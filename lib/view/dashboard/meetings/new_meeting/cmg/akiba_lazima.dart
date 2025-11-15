// akiba_lazima.dart
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/unpaid_akiba_lazima.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/user_unpaid_akiba_lazima.dart';
import 'package:flutter/material.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class AkibaLazimaPage extends StatefulWidget {
  final int? meetingId;
  var mzungukoId;
  final bool isFromMgaowakikundi;
  final bool isFromMeetingSummary;
  final bool isFromAkibaLazima;
  AkibaLazimaPage({
    super.key,
    this.meetingId,
    this.mzungukoId,
    this.isFromMgaowakikundi = false,
    this.isFromMeetingSummary = false,
    this.isFromAkibaLazima = false,
  });

  @override
  _AkibaLazimaPageState createState() => _AkibaLazimaPageState();
}

class _AkibaLazimaPageState extends State<AkibaLazimaPage> {
  List<Map<String, dynamic>> _users = [];
  int _fixedAmount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Fetch the fixed amount for 'akiba_lazima'
      final katibaModel = KatibaModel();
      final katiba = await katibaModel
          .where('katiba_key', '=', 'akiba_lazima')
          .where('mzungukoid', '=', widget.mzungukoId)
          .first();

      if (katiba != null) {
        setState(() {
          _fixedAmount = int.parse(katiba.toMap()['value'] ?? '0');
        });
      } else {
        print("No Katiba value found for 'akiba_lazima'.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Hakuna kiasi kilichobainishwa kwa akiba lazima.')),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Fetch attendance records with 'Yupo' status
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

      // Extract user IDs with 'Yupo' status
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

      // Fetch all users and identify those without 'Yupo' status
      final usersModel = GroupMembersModel();
      final allUsers = await usersModel.find();

      // Identify users who are not in "Yupo" status
      List<int> usersWithNoYupo = [];
      for (var user in allUsers) {
        int userId = user.toMap()['id'] as int;
        if (!yupoUserIds.contains(userId)) {
          usersWithNoYupo.add(userId); // Add user IDs without "Yupo" status
        }
      }

      print("User IDs with no 'Yupo' status: $usersWithNoYupo");

      // Mark users with no "Yupo" status as unpaid
      for (int userId in usersWithNoYupo) {
        await _markUserAsUnpaid(userId);
      }

      // Fetch user details for "Yupo" users
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

      // Fetch existing contributions for "Yupo" users
      final akibaLazimaModel = AkibaLazimaModel();
      final existingContributions = await akibaLazimaModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .find();

      // Map contributions by user ID
      Map<int, AkibaLazimaModel> contributionsMap = {};
      for (var contribution in existingContributions) {
        int? userId = contribution.toMap()['user_id'] as int?;
        if (userId != null) {
          contributionsMap[userId] = contribution as AkibaLazimaModel;
        }
      }

      // Fetch unpaid status
      final unpaidStatusMap = await _fetchUserPaymentStatus();

      List<Map<String, dynamic>> updatedUsers = [];
      for (var user in yupoUsers) {
        int userId = user['id'] as int;
        bool hasUnpaidStatus = unpaidStatusMap[userId] ?? false;

        print(
            "User ${user['name']} (ID: $userId) - Has unpaid status: $hasUnpaidStatus");

        updatedUsers.add({
          "name": user['name'] ?? "Jina lisiloelezwa",
          "phone": user['phone'] ?? "Simu isiyoelezwa",
          "isPaid":
              contributionsMap[userId]?.paidStatus == 'paid' ? true : false,
          "userId": userId,
          "hasUnpaidStatus": hasUnpaidStatus,
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
      final contributionModel = AkibaLazimaModel();

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
          'amount': 0,
        };

        await contributionModel
            .where(
                'id',
                '=',
                (existingContribution as AkibaLazimaModel)
                    .id) // Hakikisha tunasasisha rekodi maalum
            .update(updateValues);

        print("Updated user $userId as unpaid.");
      } else {
        print(
            "No existing contribution found for user $userId. Creating new unpaid record...");

        AkibaLazimaModel newContribution = AkibaLazimaModel(
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          userId: userId,
          paidStatus: 'unpaid',
          amount: 0,
        );
        await newContribution.create();

        print("Marked user $userId as unpaid.");
      }
    } catch (e, stackTrace) {
      print("Error marking user $userId as unpaid: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  Future<Map<int, bool>> _fetchUserPaymentStatus() async {
    try {
      final akibaModel = AkibaLazimaModel();
      final existingContributions = await akibaModel
          .where('mzungukoid', '=', widget.mzungukoId)
          .where('paid_status', '=', 'unpaid')
          .find();

      Map<int, bool> userUnpaidStatus = {};
      for (var contribution in existingContributions) {
        if (contribution is AkibaLazimaModel) {
          int? userId = contribution.toMap()['user_id'] as int?;
          if (userId != null) {
            userUnpaidStatus[userId] = true;
          }
        }
      }

      print("Found ${userUnpaidStatus.length} users with unpaid Akiba Lazima");
      print(
          "Users with unpaid Akiba Lazima: ${userUnpaidStatus.keys.toList()}");
      return userUnpaidStatus;
    } catch (e) {
      print('Error fetching Akiba Lazima payment status: $e');
      return {};
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

      final akibaLazimaModel = AkibaLazimaModel();
      List<String> failedSaves = [];
      int totalContributions = 0;

      for (var user in _users) {
        int? userId = user["userId"] as int?;
        bool isPaid = user["isPaid"] as bool;

        if (userId == null) {
          continue;
        }

        double amount = isPaid ? _fixedAmount.toDouble() : 0.0;
        totalContributions += amount.toInt();

        final existingRecord = await akibaLazimaModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .where('user_id', '=', userId)
            .findOne();

        if (existingRecord != null) {
          try {
            (existingRecord as AkibaLazimaModel).amount = amount;
            existingRecord.paidStatus = isPaid ? 'paid' : 'unpaid';

            await existingRecord.create();
            print(
                'Updated AkibaLazima: meetingId=${widget.meetingId}, mzungukoId=${widget.mzungukoId}, userId=$userId, amount=$amount, status=${isPaid ? 'paid' : 'unpaid'}');
          } catch (e) {
            failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
            print('Error during update: $e');
          }
        } else {
          AkibaLazimaModel akibaLazima = AkibaLazimaModel(
            meetingId: widget.meetingId,
            mzungukoId: widget.mzungukoId,
            userId: userId,
            paidStatus: isPaid ? 'paid' : 'unpaid',
            amount: amount,
          );

          try {
            // Save the new record
            await akibaLazima.create();
            print(
                'Saved AkibaLazima: meetingId=${widget.meetingId}, mzungukoId=${widget.mzungukoId}, userId=$userId, amount=$amount, status=${akibaLazima.paidStatus}');
          } catch (e) {
            failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
            print('Error during save: $e');
          }
        }
      }

      if (failedSaves.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Akiba ya Lazima imehifadhiwa vizuri!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Imekuwepo matatizo kuhifadhi akiba kwa: ${failedSaves.join(", ")}.',
            ),
          ),
        );
      }

      await _fetchData();
    } catch (e) {
      print('Error saving data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'akiba_lazima',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Akiba ya Lazima',
        showBackArrow: true,
        icon: Icons.edit,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnpaidAkibaLazimaPage(
                  mzungukoId: widget.mzungukoId, isFromAkibaLazima: true),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _users.isEmpty
                ? Center(child: Text('Hakuna wanachama waliopo.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Fixed Amount Section
                                Text(
                                  "Kiasi ambacho mwanachama alipie:",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_fixedAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 16),
                                // Total Collected Section
                                Text(
                                  "Kilichopatikana:",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_calculateTotalCollected(), Provider.of<CurrencyProvider>(context).currencyCode),
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
                                    // User Details Section
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
                                            "Simu: ${user["phone"]}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: 8),
                                          // Checkbox Section
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
                                                    ? "Amelipa"
                                                    : "Ajalipia",
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
                                        color: user["hasUnpaidStatus"] == true
                                            ? Colors.red
                                            : const Color.fromARGB(
                                                255, 139, 27, 245),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserUnpaidAkibaLazima(
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
                        buttonText: 'Thibitisha',
                        onPressed: () async {
                          await _updateStatusToCompleted();
                          await _saveData();
                          if (widget.isFromMeetingSummary) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MuhtasariWaKikaoPage(
                                  mzungukoId: widget.mzungukoId,
                                  meetingId: widget.meetingId,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => meetingpage(
                                  meetingId: widget.meetingId,
                                ),
                              ),
                            );
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
