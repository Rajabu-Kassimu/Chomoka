// uchangiajifuko_jamii.dart
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/unpaid_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/user_unpaid_jamii.dart';
import 'package:flutter/material.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_format.dart';

class UchangiajifukoJamiiPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final bool isFromMeetingSummary;
  final bool isFromUchangiaji;
  UchangiajifukoJamiiPage({
    super.key,
    required this.meetingId,
    this.mzungukoId,
    this.isFromMeetingSummary = false,
    this.isFromUchangiaji = false,
  });

  @override
  _UchangiajifukoJamiiPageState createState() =>
      _UchangiajifukoJamiiPageState();
}

class _UchangiajifukoJamiiPageState extends State<UchangiajifukoJamiiPage> {
  List<Map<String, dynamic>> _users = [];
  Map<int, bool> _unpaidStatusMap = {};
  int _fixedAmount = 0;
  List<int> unpaidUsers = [];
  bool isLoading = true;
  String _groupType = '';
  bool _didFetch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetch) {
      _fetchData();
      _didFetch = true;
    }
  }

  Future<void> _fetchData() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      setState(() {
        isLoading = true;
      });

      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
      }

      final mfukoJamiiModel = MfukoJamiiModel();
      final mfukoData = await mfukoJamiiModel
          .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
          .where('mzungukoid', '=', widget.mzungukoId)
          .first();

      if (mfukoData != null) {
        setState(() {
          _fixedAmount = int.parse(mfukoData.toMap()['value'] ?? '0');
        });
      } else {
        print("No MfukoJamii value found for 'Kiasi cha Kuchangia'.");

        setState(() {
          isLoading = false;
        });
        return;
      }

      // Fetch attendance records for users marked as "Yupo"
      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .where('attendance_status', '=', 'Yupo')
          .find();

      print("Attendance Records with 'Yupo' status: ${yupoAttendances.length}");

      if (yupoAttendances.isEmpty) {
        print("No members with 'Yupo' status found.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna wanachama waliopo.')),
        );
        setState(() {
          _users = [];
          isLoading = false;
        });
        return;
      }

      List<int> yupoUserIds = yupoAttendances
          .map((attendance) => attendance.toMap()['user_id'] as int?)
          .where((id) => id != null)
          .cast<int>()
          .toSet()
          .toList();

      print("User IDs from Attendance with 'Yupo' status: $yupoUserIds");

      if (yupoUserIds.isEmpty) {
        print("No valid user IDs found for 'Yupo' attendances.");
        setState(() {
          _users = [];
          isLoading = false;
        });
        return;
      }

      final usersModel = GroupMembersModel();
      final allUsers = await usersModel.find();

      List<int> usersWithNoYupo = [];
      for (var user in allUsers) {
        int userId = user.toMap()['id'] as int;
        if (!yupoUserIds.contains(userId)) {
          usersWithNoYupo.add(userId); // Add user IDs without "Yupo" status
        }
      }

      print("User IDs with no 'Yupo' status: $usersWithNoYupo");

      for (int userId in usersWithNoYupo) {
        await _markUserAsUnpaid(userId);
      }

      List<Map<String, dynamic>> yupoUsers = [];
      for (int id in yupoUserIds) {
        print("Fetching user details for ID: $id");
        final user = await usersModel.where('id', '=', id).first();

        if (user != null) {
          print("User Found: ${user.toMap()}");
          yupoUsers.add(user.toMap());
        } else {
          print("No user found for ID: $id");
        }
      }

      if (yupoUsers.isEmpty) {
        print("No user details found for the Yupo members.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna maelezo ya wanachama waliopo.')),
        );
        setState(() {
          _users = [];
          isLoading = false;
        });
        return;
      }

      final contributionModel = UchangaajiMfukoJamiiModel();
      final existingContributions = await contributionModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .find();

      Map<int, UchangaajiMfukoJamiiModel> contributionsMap = {};
      for (var contribution in existingContributions) {
        if (contribution is UchangaajiMfukoJamiiModel) {
          int? userId = contribution.toMap()['user_id'] as int?;
          if (userId != null) {
            contributionsMap[userId] = contribution;
          }
        }
      }

      // Fetch unpaid status
      _unpaidStatusMap = await _fetchUserPaymentStatus();

      List<Map<String, dynamic>> updatedUsers = [];
      for (var user in yupoUsers) {
        int userId = user['id'] as int;
        bool isPaid =
            contributionsMap[userId]?.paidStatus == 'paid' ? true : false;
        bool hasUnpaidHistory = _unpaidStatusMap[userId] ?? false;

        print("User ${user['name']} - Has unpaid history: $hasUnpaidHistory");

        updatedUsers.add({
          "name": user['name'] ?? l10n.unknownName,
          "phone": user['phone'] ?? l10n.noPhone,
          "isPaid": isPaid,
          "userId": userId,
          "hasUnpaidHistory": hasUnpaidHistory,
        });
      }

      setState(() {
        _users = updatedUsers;
        isLoading = false;
      });
    } catch (e, stackTrace) {
      print('Error fetching data: $e');
      print('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _markUserAsUnpaid(int userId) async {
    try {
      final contributionModel = UchangaajiMfukoJamiiModel();

      print("Checking existing contribution for user $userId...");

      final existingContribution = await contributionModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', userId)
          .first();

      if (existingContribution != null) {
        print(
            "Existing contribution found for user $userId. Updating to unpaid...");

        Map<String, dynamic> updateValues = {
          'paid_status': 'unpaid',
          'total': 0,
        };
        await existingContribution.update(updateValues);
        print("Updated user $userId as unpaid.");
      } else {
        print(
            "No existing contribution found for user $userId. Creating new unpaid record...");

        UchangaajiMfukoJamiiModel newContribution = UchangaajiMfukoJamiiModel(
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          userId: userId,
          paidStatus: 'unpaid',
          total: 0,
        );
        await newContribution.create();
        print("Marked user $userId as unpaid.");
      }
    } catch (e, stackTrace) {
      print("Error marking user $userId as unpaid: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  int _calculateTotalCollected() {
    return _users.where((user) => user["isPaid"] == true).length * _fixedAmount;
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_users.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna data ya kuhifadhi.')),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();
      List<String> failedSaves = [];

      for (var user in _users) {
        int? userId = user["userId"] as int?;
        bool isPaid = user["isPaid"] as bool;

        if (userId == null) {
          continue;
        }

        double amount = isPaid ? _fixedAmount.toDouble() : 0.0;

        final existingRecord = await mfukoJamiiModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .where('user_id', '=', userId)
            .findOne();

        if (existingRecord != null) {
          try {
            (existingRecord as UchangaajiMfukoJamiiModel).total = amount;
            (existingRecord as UchangaajiMfukoJamiiModel).paidStatus =
                isPaid ? 'paid' : 'unpaid';

            await existingRecord.create();
            print(
                'Updated MfukoJamii: meetingId=${widget.meetingId}, mzungukoId=${widget.mzungukoId}, userId=$userId, amount=$amount, status=${existingRecord.paidStatus}');
          } catch (e) {
            failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
            print('Error during update: $e');
          }
        } else {
          UchangaajiMfukoJamiiModel mfukoJamii = UchangaajiMfukoJamiiModel(
            meetingId: widget.meetingId,
            mzungukoId: widget.mzungukoId,
            userId: userId,
            paidStatus: isPaid ? 'paid' : 'unpaid',
            total: amount,
          );

          try {
            // Save the new record
            await mfukoJamii.create();
            print(
                'Saved MfukoJamii: meetingId=${widget.meetingId}, mzungukoId=${widget.mzungukoId}, userId=$userId, amount=$amount, status=${mfukoJamii.paidStatus}');
          } catch (e) {
            failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
            print('Error during save: $e');
          }
        }
      }

      if (failedSaves.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mfuko Jamii umehifadhiwa vizuri!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Imekuwepo matatizo kuhifadhi mfuko jamii kwa: ${failedSaves.join(", ")}.',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Kuna tatizo la kuhifadhi mfuko jamii. Tafadhali jaribu tena.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateOrCreateTotal(int totalContributions) async {
    try {
      final contributionModel = UchangaajiMfukoJamiiModel();

      final count = await contributionModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .count();

      if (count > 0) {
        await contributionModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoid', '=', widget.mzungukoId)
            .update({'total': totalContributions, 'status': 'paid'});
      } else {
        UchangaajiMfukoJamiiModel newRecord = UchangaajiMfukoJamiiModel(
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          status: 'paid',
          total: totalContributions.toDouble(),
        );
        await newRecord.create();
      }

      print(
          "Total contributions successfully updated/created: $totalContributions");
    } catch (e) {
      print('Error updating or creating total contributions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Kuna tatizo la kuhifadhi jumla ya mfuko jamii.')),
      );
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'changia_mfuko_jamii',
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Future<Map<int, bool>> _fetchUserPaymentStatus() async {
    try {
      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final existingContributions = await mfukoJamiiModel
          .where('mzungukoid', '=', widget.mzungukoId)
          .find();

      Map<int, bool> userUnpaidStatus = {};
      for (var contribution in existingContributions) {
        if (contribution is UchangaajiMfukoJamiiModel) {
          int? userId = contribution.toMap()['user_id'] as int?;
          String? paidStatus = contribution.toMap()['paid_status'] as String?;

          if (userId != null) {
            if (paidStatus == 'unpaid') {
              userUnpaidStatus[userId] = true;
              print("User $userId has unpaid status: ${paidStatus}");
            }
          }
        }
      }

      print("Found ${userUnpaidStatus.length} users with unpaid Mfuko Jamii");
      print("Users with unpaid Mfuko Jamii: ${userUnpaidStatus.keys.toList()}");
      return userUnpaidStatus;
    } catch (e) {
      print('Error fetching Mfuko Jamii payment status: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.communityFund,
        showBackArrow: true,
        icon: Icons.edit,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnpaidUchangaajiMfukoJamiiPage(
                  mzungukoId: widget.mzungukoId, isFromUchangiaji: true),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _users.isEmpty
                ? Center(child: Text(l10n.noMembers))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Fixed Amount Section
                                Text(
                                  l10n.amountToPaid,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_fixedAmount.toInt(), Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 16),
                                // Total Collected Section
                                Text(
                                  l10n.whatWasCollected,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_calculateTotalCollected().toInt(), Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            print(
                                "Building item for ${user["name"]} - Has unpaid history: ${user["hasUnpaidHistory"]}");

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.person, size: 30),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user["name"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "${user["phone"]}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: user["isPaid"],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    user["isPaid"] = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                user["isPaid"]
                                                    ? l10n.hasPaid
                                                    : l10n.hasNotPaid,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: user["isPaid"]
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.info,
                                        color: user["hasUnpaidHistory"] == true
                                            ? Colors.red
                                            : const Color.fromARGB(
                                                255, 139, 27, 245),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserUnpaidJamii(
                                              userId: user["userId"],
                                              mzungukoId: widget.mzungukoId,
                                              name: user["name"],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.confirm,
                        onPressed: () async {
                          if (widget.isFromMeetingSummary) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MuhtasariWaKikaoPage(
                                        meetingId: widget.meetingId,
                                        mzungukoId: widget.mzungukoId,
                                      )),
                            );
                          } else {
                            await _updateStatusToCompleted();
                            await _saveData();
                            if (_groupType == 'VSLA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMeetingDashboard(
                                      meetingId: widget.meetingId),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      meetingpage(meetingId: widget.meetingId),
                                ),
                              );
                            }
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
      ),
    );
  }
}
