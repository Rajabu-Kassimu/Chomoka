import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/SuccessSplashPage.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/akiba_hiari.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/akiba_lazima.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/attendance.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uchangiaji_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/help.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/model/MeetingModel.dart';

class MuhtasariWaKikaoPage extends StatefulWidget {
  var meetingId;
  var groupId;
  var mzungukoId;
  var meetingNumber;
  final bool isFromHistory;
  final bool isFromMeetingSummary;
  MuhtasariWaKikaoPage(
      {required this.meetingId,
      this.groupId,
      this.mzungukoId,
      this.meetingNumber,
      this.isFromHistory = false,
      this.isFromMeetingSummary = false});

  @override
  _MuhtasariWaKikaoPageState createState() => _MuhtasariWaKikaoPageState();
}

class _MuhtasariWaKikaoPageState extends State<MuhtasariWaKikaoPage> {
  double _totalAkibaLazima = 0;
  int _totalAkibaHiari = 0;
  double _totalMfukoJamii = 0;
  double _kilichotolewaMfukoJamii = 0;
  double _fainiTotal = 0;
  double _kiasiKinachodaiwa = 0;
  double _totalRepayAmount = 0;
  double _totalPaidAmount = 0;
  double _matumiziTotal = 0;
  double totalContributions = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> attendanceList = [];
  Map<String, int>? summary;
  int? meetingId;
  bool isActiveMeeting = false;

  Future<void> _fetchAkibaLazimaDetails() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();

      final records = await akibaLazimaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalSum = 0;
      Set<int> seenUserIds = Set<int>();

      print('Fetched Akiba Lazima records: $records');

      if (records.isNotEmpty) {
        totalSum = records.fold(0, (sum, record) {
          final amount = (record['amount'] as num?)?.toDouble() ?? 0;
          final status = record['paid_status'] as String?;
          final userId = record['user_id'] as int?;

          // print('Record: amount=$amount, status=$status, userId=$userId');

          if (status == 'paid' &&
              userId != null &&
              !seenUserIds.contains(userId)) {
            seenUserIds.add(userId);
            return sum + amount;
          }

          return sum;
        });
      }

      setState(() {
        _totalAkibaLazima = totalSum;
      });

      // Print the updated total
      print('Total Akiba Lazima: $_totalAkibaLazima');
    } catch (e) {
      print('Error fetching total Akiba Lazima: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Akiba Lazima.'),
        ),
      );
    }
  }

  Future<void> _fetchTotalAkibaHiari() async {
    try {
      final akibaHiariModel = AkibaHiari();

      final records = await akibaHiariModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int totalAmount = records.fold(0, (sum, record) {
        return sum + (record['amount'] as int? ?? 0);
      });

      setState(() {
        _totalAkibaHiari = totalAmount;
      });

      print('Total Akiba Hiari: $_totalAkibaHiari');
    } catch (e) {
      print('Error fetching total Akiba Hiari: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya Akiba Hiari.')),
      );
    }
  }

  Future<void> _fetchMfukoJamiiData() async {
    try {
      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();

      final records = await mfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalSum = 0;
      Set<int> seenUserIds = Set<int>();

      if (records.isNotEmpty) {
        totalSum = records.fold(0, (sum, record) {
          final amount = (record['total'] as num?)?.toDouble() ?? 0;
          final status = record['paid_status'] as String?;
          final userId = record['user_id'] as int?;

          if (status == 'paid' &&
              userId != null &&
              !seenUserIds.contains(userId)) {
            seenUserIds.add(userId);
            return sum + amount;
          }

          return sum;
        });
      }

      setState(() {
        _totalMfukoJamii = totalSum;
      });

      print('Total Mfuko Jamii: $_totalMfukoJamii');
    } catch (e) {
      print('Error fetching Mfuko Jamii data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya Mfuko Jamii.')),
      );
    }
  }

  Future<void> _fetchFainiTotal() async {
    try {
      final userFainiModel = UserFainiModel();
      final results = await userFainiModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results
            .map((entry) => (entry['paidfaini'] ?? 0).toDouble())
            .fold(0.0, (sum, element) => sum + element);

        setState(() {
          _fainiTotal = total;
        });
      } else {
        setState(() {
          _fainiTotal = 0.0;
        });
      }
    } catch (e) {
      print(
          'Error fetching total unpaid fines for meeting ID ${widget.meetingId}: $e');
      setState(() {
        _fainiTotal = 0.0;
      });
    }
  }

  Future<void> _fetchTotalRepayAmount() async {
    try {
      final toaMkopoModel = ToaMkopoModel();

      final List<Map<String, dynamic>> results = await toaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meetingId', '=', widget.meetingId)
          .select();

      double totalRepayAmount = 0.0;

      if (results.isNotEmpty) {
        totalRepayAmount = results.fold(0.0, (sum, record) {
          return sum + (record['repayAmount'] as double? ?? 0.0);
        });
      }

      setState(() {
        _totalRepayAmount = totalRepayAmount;
      });

      print(
          'Total Repay Amount for Meeting ID ${widget.meetingId}: $_totalRepayAmount');
    } catch (e) {
      print('Error fetching total repay amount: $e');
      setState(() {
        _totalRepayAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya marejesho.')),
      );
    }
  }

  Future<void> _fetchTotalPaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();

      final List<Map<String, dynamic>> results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalPaidAmount = 0.0;

      if (results.isNotEmpty) {
        totalPaidAmount = results.fold(0.0, (sum, record) {
          return sum + (record['paidAmount'] as double? ?? 0.0);
        });
      }

      setState(() {
        _totalPaidAmount = totalPaidAmount;
      });

      print(
          'Total Paid Amount for Meeting ID ${widget.meetingId}: $_totalPaidAmount');
    } catch (e) {
      print('Error fetching total paid amount: $e');
      setState(() {
        _totalPaidAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
      );
    }
  }

  Future<void> _fetchingMatumiziTotal() async {
    try {
      final matumiziModel = MatumiziModel();

      final results = await matumiziModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results.fold(0.0, (sum, record) {
          return sum + (record['amount'] as double? ?? 0.0);
        });

        setState(() {
          _matumiziTotal = total;
        });
      } else {
        setState(() {
          _matumiziTotal = 0.0;
        });
      }
    } catch (e) {
      print('Error fetching total amount for meeting: $e');
      setState(() {
        _matumiziTotal = 0.0;
      });
    }
  }

  Future<void> _fetchSavedAttendance() async {
    try {
      final attendanceModel = AttendanceModel();
      final savedAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      print('Fetched ${savedAttendances.length} attendance records.');

      int totalMembers = savedAttendances.length;
      int presentMembers = 0;
      int absentMembers = 0;
      int kawahi = 0;
      int kachelewa = 0;
      int withPermission = 0;
      int withoutPermission = 0;
      int representative = 0;

      for (var attendance in savedAttendances) {
        final status = attendance.toMap()['attendance_status'] ?? 'unknown';
        final subStatus =
            attendance.toMap()['sub_attendance_status'] ?? 'unknown';

        if (status == 'Yupo') {
          presentMembers++;
          if (subStatus == 'Kawahi') {
            kawahi++;
          } else if (subStatus == 'Kachelewa') {
            kachelewa++;
          }
        } else if (status == 'Hayupo') {
          absentMembers++;
          if (subStatus == 'Kwa Ruhusa') {
            withPermission++;
          } else if (subStatus == 'Bila Ruhusa') {
            withoutPermission++;
          } else if (subStatus == 'Katuma Mwakilishi') {
            representative++;
          }
        }
      }

      setState(() {
        summary = {
          'total': totalMembers,
          'present': presentMembers,
          'absent': absentMembers,
          'kawahi': kawahi,
          'kachelewa': kachelewa,
          'withPermission': withPermission,
          'withoutPermission': withoutPermission,
          'representative': representative,
        };
      });

      print('Attendance Summary Fetched and Displayed.');
    } catch (e, stackTrace) {
      print('Error fetching attendance data: $e');
      print('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch attendance data.')),
      );
    }
  }

  Future<GroupInformationModel?> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final savedGroup = await groupInformationModel.first();
      return savedGroup as GroupInformationModel?;
    } catch (e) {
      print('Error fetching saved data: $e');
      return null;
    }
  }

  Future<void> fetchGroupIdAndNavigateToHome(BuildContext context) async {
    try {
      final groupInformation = await _fetchSavedData();

      if (groupInformation != null && groupInformation.id != null) {
        debugPrint("Group ID fetched: ${groupInformation.id}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessSplashPage(
              groupId: groupInformation.id,
              meetingId: widget.meetingId,
            ),
          ),
        );
      } else {
        debugPrint("Group information is null or missing an ID.");
      }
    } catch (e) {
      debugPrint("Error fetching group ID and navigating to HomePage: $e");
    }
  }

  Future<void> _fetchKilichotolewaMfukoJamii() async {
    try {
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();

      toaMfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId);

      final records = await toaMfukoJamiiModel.select();
      double totalAmountWithdrawn = records.fold(0.0, (sum, record) {
        final amount = (record['amount'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      setState(() {
        _kilichotolewaMfukoJamii = totalAmountWithdrawn;
      });
    } catch (e) {
      print('Error fetching withdrawal data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data za mfuko jamii.'),
        ),
      );
    }
  }

  Future<void> _navigateToActiveMeeting() async {
    final model = MeetingModel();
    try {
      final activeMeeting =
          await model.where('status', '=', 'active').findOne();

      if (activeMeeting != null && activeMeeting is MeetingModel) {
        final int? existingMeetingId = activeMeeting.id;
        final int? meetingNumber =
            activeMeeting.number; // Fetch the meeting number

        if (existingMeetingId != null && meetingNumber != null) {
          setState(() {
            meetingId = existingMeetingId; // Set the meetingId using setState
          });
        } else {
          print("Meeting ID or Meeting Number is null.");
        }
      } else {
        print("No active meeting found.");
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
    }
  }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meetingId', '=', widget.meetingId)
          .select();

      // Calculate total amount
      double totalAmount = 0;
      for (var contribution in results) {
        // Safely handle null amounts by using null-aware operator
        final amount = contribution['amount'];
        if (amount != null) {
          totalAmount += (amount as num).toDouble();
        }
      }

      setState(() {
        totalContributions = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
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

  Future<GroupInformationModel?> _fetchData() async {
    await _navigateToActiveMeeting();
    await _fetchAkibaLazimaDetails();
    await _fetchTotalAkibaHiari();
    await _fetchMfukoJamiiData();
    await _fetchSavedData();
    await _fetchFainiTotal();
    await _fetchTotalRepayAmount();
    await _fetchTotalPaidAmount();
    await _fetchingMatumiziTotal();
    await _fetchSavedAttendance();
    await _fetchKilichotolewaMfukoJamii();
    await _fetchContributions();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Muhtasari wa Kikao ${widget.meetingNumber}',
        subtitle: 'Muhtasari',
        showBackArrow: true,
        icon: Icons.help,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpPage()),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: "Fedha zilizokusanywa",
              items: [
                _buildRowItem(
                  icon: Icons.car_crash,
                  label: "Akiba ya lazima",
                  amount: _totalAkibaLazima != null
                      ? "TZS ${_totalAkibaLazima.toStringAsFixed(0)}"
                      : "Loading...",
                  color: Colors.blueAccent,
                  canNavigate: widget.isFromHistory ? false : true,
                  onNavigate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AkibaLazimaPage(
                          isFromMeetingSummary: true,
                          mzungukoId: widget.mzungukoId,
                          meetingId: widget.meetingId,
                        ),
                      ),
                    );
                  },
                ),
                _buildRowItem(
                  icon: Icons.handshake,
                  label: "Mfuko wa jamii Kiasi kilichowekwa",
                  amount: "TZS ${(_totalMfukoJamii).toStringAsFixed(0)}",
                  color: Colors.green,
                  canNavigate: widget.isFromHistory ? false : true,
                  onNavigate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UchangiajifukoJamiiPage(
                          isFromMeetingSummary: true,
                          mzungukoId: widget.mzungukoId,
                          meetingId: widget.meetingId,
                        ),
                      ),
                    );
                  },
                ),
                _buildRowItem(
                  icon: Icons.monetization_on,
                  label: "Akiba binafsi kiasi kilichowekwa",
                  amount: "TZS ${_totalAkibaHiari}",
                  color: const Color.fromARGB(225, 255, 208, 0),
                  canNavigate: widget.isFromHistory ? false : true,
                  onNavigate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AkibaHiariPage(
                          isFromMeetingSummary: true,
                          mzungukoId: widget.mzungukoId,
                          meetingId: widget.meetingId,
                        ),
                      ),
                    );
                  },
                ),
                _buildRowItem(
                  icon: Icons.handyman,
                  label: "Jumla ya Faini Zilizolipwa",
                  amount: "TZS ${_fainiTotal.toStringAsFixed(0)}",
                  color: const Color.fromARGB(255, 255, 3, 3),
                  canNavigate: widget.isFromHistory ? false : true,
                  onNavigate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LipaFainiPage(
                          isFromMeetingSummary: true,
                          mzungukoId: widget.mzungukoId,
                          meetingId: widget.meetingId,
                        ),
                      ),
                    );
                  },
                ),
                _buildRowItem(
                  icon: Icons.download,
                  label: "Jumla ya Uwekaji wa Mkupuo",
                  amount: "TZS ${totalContributions.toStringAsFixed(0)}",
                  color: const Color.fromARGB(255, 57, 202, 0),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              title: "Fedha zilizotolewa",
              items: [
                _buildRowItem(
                  icon: Icons.money,
                  label: "Mfuko wa jamii Kiasi kilichotoka",
                  amount: "TZS ${_kilichotolewaMfukoJamii.toStringAsFixed(0)}",
                  color: Colors.redAccent,
                ),
                _buildRowItem(
                  icon: Icons.cabin,
                  label: "Matumizi",
                  amount: "TZS ${_matumiziTotal.toStringAsFixed(0)}",
                  color: const Color.fromARGB(255, 26, 2, 248),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              title: "Mikopo",
              items: [
                _buildRowItem(
                  icon: Icons.local_activity,
                  label: "Mikopo Iliyotolewa",
                  amount: "TZS ${_totalRepayAmount.toStringAsFixed(0)}",
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                _buildRowItem(
                  icon: Icons.download,
                  label: "Kiasi cha mkopo Kilicholipwa",
                  amount: "TZS ${_totalPaidAmount.toStringAsFixed(0)}",
                  color: Colors.green,
                ),
                _buildRowItem(
                  icon: Icons.upload,
                  label: "Kiasi cha mkopo Kilichobakia",
                  amount:
                      "TZS ${(_totalRepayAmount - _totalPaidAmount).toStringAsFixed(0)}",
                  color: Colors.orange,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                if (summary == null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Loading attendance summary...",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Mahudhurio',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            !widget.isFromHistory
                                ? IconButton(
                                    icon: Icon(Icons.remove_red_eye,
                                        color: Colors.grey),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AttendancePage(
                                            isFromMeetingSummary: true,
                                            mzungukoId: widget.mzungukoId,
                                            meetingId: widget.meetingId,
                                          ), // Replace with the actual page
                                        ),
                                      );
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(height: 8),
                        buildSummaryRow(Icons.groups, 'Idadi ya wanachama',
                            summary!['total']),
                        Divider(),
                        buildSummaryRow(Icons.check_circle, 'Waliohudhuria',
                            summary!['present']),
                        buildSummaryRow(
                            Icons.alarm_on, 'Kawahi', summary!['kawahi']),
                        buildSummaryRow(Icons.alarm_off, 'Kachelewa',
                            summary!['kachelewa']),
                        buildSummaryRow(Icons.person_add, 'Katuma Mwakilishi',
                            summary!['representative']),
                        Divider(),
                        buildSummaryRow(
                            Icons.cancel, 'Hawakuhudhuria', summary!['absent']),
                        buildSummaryRow(Icons.event_available, 'Kwa Ruhusa',
                            summary!['withPermission']),
                        buildSummaryRow(Icons.event_busy, 'Bila Ruhusa',
                            summary!['withoutPermission']),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: widget.isFromHistory ? 'Nimemaliza' : 'Funga Kikao',
              onPressed: () async {
                if (widget.isFromHistory) {
                  Navigator.pop(context);
                  return;
                } else {
                  try {
                    final existingMeeting = await MeetingModel()
                        .where('id', '=', meetingId)
                        .where('mzungukoId', '=', widget.mzungukoId)
                        .first();

                    if (existingMeeting != null) {
                      print('Meeting found: ${existingMeeting.toMap()}');

                      final rowsUpdated = await MeetingModel()
                          .where('id', '=', meetingId)
                          .where('mzungukoId', '=', widget.mzungukoId)
                          .update({'status': 'complete'});

                      if (rowsUpdated > 0) {
                        print(
                            'Meeting updated successfully. Rows affected: $rowsUpdated');
                        fetchGroupIdAndNavigateToHome(context);
                      } else {
                        print('Failed to update the meeting status.');
                      }
                    } else {
                      print('No matching meeting found.');
                    }
                  } catch (e) {
                    print('Error updating meeting status: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Imeshindikana kufunga kikao: $e')),
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

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildRowItem({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
    bool isAmountRed = false,
    bool canNavigate =
        false, // New parameter to control visibility of the eye icon
    VoidCallback? onNavigate, // Callback for navigation (nullable)
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Icon container with label and amount
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isAmountRed ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Conditional rendering of the eye icon and action
          if (canNavigate)
            IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: onNavigate, // Execute navigation callback
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 104, 104, 104))),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Widget _buildSection({
  required String title,
  required List<Widget> items,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: items,
          ),
        ),
      ),
    ],
  );
}

Widget _buildRowItem({
  required IconData icon,
  required String label,
  required String amount,
  required Color color,
  bool isAmountRed = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 4),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isAmountRed ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSummaryRow(IconData icon, String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blueGrey),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
