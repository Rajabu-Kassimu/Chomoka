// uchangiajifuko_jamii.dart
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/other_funds/SameContrinutionModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ContributeSameAmount extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final bool isFromMeetingSummary;
  final String mfukoName;
  final int? mfukoId;
  final double? contributionAmount;

  ContributeSameAmount({
    super.key,
    required this.meetingId,
    this.mzungukoId,
    this.isFromMeetingSummary = false,
    required this.mfukoName,
    this.mfukoId,
    this.contributionAmount,
  });

  @override
  _ContributeSameAmountState createState() => _ContributeSameAmountState();
}

class _ContributeSameAmountState extends State<ContributeSameAmount> {
  List<Map<String, dynamic>> _users = [];
  Map<int, bool> _unpaidStatusMap = {};
  int _fixedAmount = 0;
  List<int> unpaidUsers = [];
  bool isLoading = true;
  String _groupType = '';

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

      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
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

      List<Map<String, dynamic>> yupoUsers = [];
      for (int id in yupoUserIds) {
        final user = await usersModel.where('id', '=', id).first();
        if (user != null) {
          yupoUsers.add(user.toMap());
        }
      }

      // Check existing contributions using SameContributionModel
      final contributionModel = SameContributionModel();
      final existingContributions = await contributionModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('mfukoId', '=', widget.mfukoId)
          .find();

      Map<int, bool> contributionsMap = {};
      for (var contribution in existingContributions) {
        if (contribution is SameContributionModel && contribution.userId != null) {
          contributionsMap[contribution.userId!] = contribution.status == 'paid';
        }
      }

      List<Map<String, dynamic>> updatedUsers = [];
      for (var user in yupoUsers) {
        int userId = user['id'] as int;
        bool isPaid = contributionsMap[userId] ?? false;

        updatedUsers.add({
          "name": user['name'] ?? "Jina lisiloelezwa",
          "phone": user['phone'] ?? "Simu isiyoelezwa",
          "isPaid": isPaid,
          "userId": userId,
          "hasUnpaidHistory":
              false, // This can be removed or modified based on your needs
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

  int _calculateTotalCollected() {
    return _users.where((user) => user["isPaid"] == true).length *
        (widget.contributionAmount?.toInt() ?? 0);
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
        return;
      }

      final contributionModel = SameContributionModel();
      List<String> failedSaves = [];

      for (var user in _users) {
        int? userId = user["userId"] as int?;
        bool isPaid = user["isPaid"] as bool;

        if (userId == null) continue;

        double amount = isPaid ? widget.contributionAmount?.toDouble() ?? 0.0 : 0.0;

        try {
          // Check for existing record
          final existingRecord = await contributionModel
              .where('meetingId', '=', widget.meetingId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .where('mfukoId', '=', widget.mfukoId)
              .where('userId', '=', userId)
              .first();

          if (existingRecord != null && existingRecord is SameContributionModel) {
            // Update existing record
            await contributionModel
                .where('meetingId', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', widget.mfukoId)
                .where('userId', '=', userId)
                .update({
              'status': isPaid ? 'paid' : 'unpaid',
              'amount': amount,
            });
          } else {
            // Create new record
            final newContribution = SameContributionModel(
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
              mfukoId: widget.mfukoId,
              userId: userId,
              status: isPaid ? 'paid' : 'unpaid',
              amount: amount,
            );
            await newContribution.create();
          }
        } catch (e) {
          print('Error saving contribution for user $userId: $e');
          failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
        }
      }

      if (failedSaves.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Michango imehifadhiwa vizuri!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imekuwepo matatizo kuhifadhi michango kwa: ${failedSaves.join(", ")}.')),
        );
      }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kuhifadhi michango. Tafadhali jaribu tena.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      // Update the status for the specific mfuko
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'mfuko_${widget.mfukoId}', // Changed to match VslaMeetingDashboard's format
        value: 'complete',
      );

      await meetingSetupModel.create();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Michango imehifadhiwa vizuri!')),
      );

    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imeshindikana kuhifadhi michango: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;   
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.contributeOtherFund(widget.mfukoName),
        showBackArrow: true,
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
                                  l10n.amountToContribute,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency((widget.contributionAmount ?? 0).toInt(), Provider.of<CurrencyProvider>(context).currencyCode),
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
                                            user["name"] ?? l10n.unknownName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "${l10n.phone}: ${user["phone"] ?? l10n.noPhone}",
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MuhtasariWaKikaoPage(
                            //             meetingId: widget.meetingId,
                            //             mzungukoId: widget.mzungukoId,
                            //           )),
                            // );
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
