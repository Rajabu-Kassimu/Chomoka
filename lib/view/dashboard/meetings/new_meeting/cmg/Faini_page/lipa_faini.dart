import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/faini_payment.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart'; // Add this import
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgao_kikundi_summary.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgao_kikundi_summary.dart';
import 'package:chomoka/view/group_setup/group_Information/vsla/vsla_group_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class LipaFainiPage extends StatefulWidget {
  var meetingId;
  var groupId;
  var group_data;
  var mzungukoId;
  final bool fromGroupOverview;
  final bool fromVlsaGroupOverview;
  final bool isFromMeetingSummary;
  final bool fromDashboard;
  final bool isFromMgaowakikundi;

  LipaFainiPage(
      {this.meetingId,
      this.isFromMeetingSummary = false,
      this.fromGroupOverview = false,
      this.isFromMgaowakikundi = false,
      this.fromVlsaGroupOverview = false,
      this.groupId,
      this.group_data,
      this.mzungukoId,
      this.fromDashboard = false});

  @override
  _LipaFainiPageState createState() => _LipaFainiPageState();
}

class _LipaFainiPageState extends State<LipaFainiPage> {
  List<Map<String, dynamic>> _userFainiSummary = [];
  bool isLoading = true;
  bool isActiveMeeting = false;
  double totalFines = 0.0;
  double totalPaidFines = 0.0;
  String _groupType = ''; // Add this property

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkGroupType().then((_) {
      _checkActiveMeeting().then((_) {
        _fetchUserFainiSummary().then((_) {
          _fetchFainiTotal();
        });
      });
    });
  }

  // Add this method to check the group type
  Future<void> _checkGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
        print('Group type: $_groupType');
      }
    } catch (e) {
      print('Error checking group type: $e');
    }
  }

  Future<void> _fetchUserFainiSummary() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userFainiModel = UserFainiModel();
      Map<int, Map<String, dynamic>> userSummary = {};
      double totalUnpaid = 0.0;

      if (!isActiveMeeting || widget.fromGroupOverview) {
        final userFainiRecords = await userFainiModel
            .where('mzungukoId', '=', widget.mzungukoId)
            .where('unpaidfaini', '>', 0)
            .find();

        for (var record in userFainiRecords) {
          final userFaini = record as UserFainiModel;
          final userId = userFaini.userId!;
          final unpaidFineAmount = userFaini.unpaidfaini?.toDouble() ?? 0.0;

          if (!userSummary.containsKey(userId)) {
            final member =
                await GroupMembersModel().where('id', '=', userId).first();
            final memberDetails = member?.toMap() ?? {};

            userSummary[userId] = {
              'id': userId,
              'name': memberDetails['name'] ?? 'Jina lisiloelezwa',
              'phone': memberDetails['phone'] ?? 'Simu haijulikani',
              'memberNumber': memberDetails['memberNumber'] ?? 'N/A',
              'totalFine': unpaidFineAmount,
            };
          } else {
            userSummary[userId]!['totalFine'] += unpaidFineAmount;
          }
          totalUnpaid += unpaidFineAmount;
        }
      } else {
        final attendanceModel = AttendanceModel();
        final yupoAttendances = await attendanceModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoid', '=', widget.mzungukoId)
            .where('attendance_status', '=', 'Yupo')
            .find();

        for (var attendance in yupoAttendances) {
          final userId = attendance.toMap()['user_id'] as int?;
          if (userId == null) continue;

          final userFainiRecords = await userFainiModel
              .where('mzungukoId', '=', widget.mzungukoId)
              .where('user_id', '=', userId)
              .where('unpaidfaini', '>', 0)
              .find();

          final member =
              await GroupMembersModel().where('id', '=', userId).first();
          final memberDetails = member?.toMap() ?? {};

          double unpaidTotal = 0.0;
          for (var record in userFainiRecords) {
            final userFaini = record as UserFainiModel;
            unpaidTotal += userFaini.unpaidfaini?.toDouble() ?? 0.0;
          }

          if (unpaidTotal > 0) {
            userSummary[userId] = {
              'id': userId,
              'name': memberDetails['name'] ?? 'Jina lisiloelezwa',
              'phone': memberDetails['phone'] ?? 'Simu haijulikani',
              'memberNumber': memberDetails['memberNumber'] ?? 'N/A',
              'totalFine': unpaidTotal,
            };
            totalUnpaid += unpaidTotal;
          }
        }
      }

      setState(() {
        _userFainiSummary = userSummary.values.toList();
        totalFines = totalUnpaid;
        isLoading = false;
      });

      await _fetchFainiTotal();
    } catch (e) {
      print('Error fetching summary: $e');
      setState(() {
        _userFainiSummary = [];
        isLoading = false;
      });
    }
  }

  Future<void> _fetchFainiTotal() async {
    try {
      final userFainiModel = UserFainiModel();

      final results =
          // widget.fromGroupOverview
          //     ? await userFainiModel
          //         .where('mzungukoId', '=', widget.mzungukoId)
          //         .select()
          //     :
          await userFainiModel
              .where('mzungukoId', '=', widget.mzungukoId)
              // .where('meeting_id', '=', widget.meetingId)
              .select();

      if (results.isNotEmpty) {
        double total = results
            .map((entry) => (entry['paidfaini'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);

        print(total);

        setState(() {
          totalPaidFines = total;
        });
      } else {
        setState(() {
          totalPaidFines = 0;
        });
      }
    } catch (e) {
      print('Error fetching total unpaid fines: $e');
      setState(() {
        totalPaidFines = 0;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        meeting_step: 'lipa_faini',
        mzungukoId: widget.mzungukoId,
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

  Future<bool> _checkActiveMeeting() async {
    final model = MeetingModel();
    try {
      final activeMeeting = await model
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'active')
          .findOne();

      if (activeMeeting != null) {
        setState(() {
          isActiveMeeting = true;
        });
        return true;
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() {
      isActiveMeeting = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(isActiveMeeting);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.lipaFainiTitle,
        subtitle: l10n.pigaFainiSubtitle,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _userFainiSummary.isEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          width: 600,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.totalFinesDue,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  formatCurrency(totalFines, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  l10n.totalFinesDue,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  formatCurrency(totalPaidFines, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.noFineMembers,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.doneButton,
                        onPressed: () async {
                          if (widget.fromDashboard == true &&
                              widget.fromGroupOverview == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupOverview(
                                  mzungukoId: widget.mzungukoId,
                                  data_id: widget.groupId,
                                  fromDashboard: true,
                                ),
                              ),
                            );
                          } else if (widget.isFromMgaowakikundi) {
                            if (_groupType == 'VSLA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            }
                          } else if (widget.fromVlsaGroupOverview) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VlsaGroupOverview(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else {
                            await _updateStatusToCompleted();

                            if (_groupType == 'VSLA') {
                              // Navigate to VSLA dashboard if it's a VSLA group
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMeetingDashboard(
                                    meetingId: widget.meetingId,
                                    groupId: widget.groupId,
                                    meetingNumber: null,
                                  ),
                                ),
                              );
                            } else {
                              // Navigate to regular CMG dashboard
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => meetingpage(
                                    meetingId: widget.meetingId,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.totalFinesDue,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  formatCurrency(totalFines, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  l10n.totalFinesPaid,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  formatCurrency(totalPaidFines, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      l10n.unpaidFinesTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _userFainiSummary.length,
                        itemBuilder: (context, index) {
                          final user = _userFainiSummary[index];
                          return GestureDetector(
                            onTap: () {
                              if (!widget.fromDashboard)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FainiPaymentPage(
                                      meetingId: widget.meetingId,
                                      userId: user['id'],
                                      userName: user['name'],
                                      userNumber: user['memberNumber'],
                                      mzungukoId: widget.mzungukoId,
                                    ),
                                  ),
                                ).then((_) =>
                                    _fetchUserFainiSummary()); // Refresh data when returning
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: const Color.fromARGB(
                                          255, 133, 135, 136),
                                      child: Text(
                                        user['name'] != null
                                            ? user['name'][0]
                                                .toUpperCase() // Display initial
                                            : "?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jina: ${user['name']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            l10n.memberNumberLabel(user['memberNumber']),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "Jumla ya Faini: " + formatCurrency((user['totalFine'] ?? 0), Provider.of<CurrencyProvider>(context).currencyCode),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.doneButton,
                        onPressed: () async {
                          try {
                            if (widget.fromGroupOverview == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupOverview(
                                    mzungukoId: widget.mzungukoId,
                                    fromDashboard: true,
                                  ),
                                ),
                              );
                            } else if (widget.isFromMgaowakikundi == true) {
                              if (_groupType == 'VSLA') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VslaMgaoWaKikundiPage(
                                      mzungukoId: widget.mzungukoId,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MgaoWaKikundiPage(
                                      mzungukoId: widget.mzungukoId,
                                    ),
                                  ),
                                );
                              }
                            } else if (widget.isFromMeetingSummary == true) {
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
                              await _updateStatusToCompleted();

                              if (_groupType == 'VSLA') {
                                // Navigate to VSLA dashboard if it's a VSLA group
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VslaMeetingDashboard(
                                      meetingId: widget.meetingId,
                                      groupId: widget.groupId,
                                      meetingNumber: null,
                                    ),
                                  ),
                                );
                              } else {
                                // Navigate to regular CMG dashboard
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => meetingpage(
                                      meetingId: widget.meetingId,
                                    ),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            print('Error during navigation: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.navigationError),
                              ),
                            );
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
    );
  }
}
