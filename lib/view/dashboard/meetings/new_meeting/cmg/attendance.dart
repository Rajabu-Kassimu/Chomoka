import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/FainiModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/model/BaseModel.dart'; // Add this import
import 'package:chomoka/l10n/app_localizations.dart';


class AttendancePage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final bool isFromMeetingSummary;

  AttendancePage(
      {Key? key,
      required this.meetingId,
      required this.mzungukoId,
      this.isFromMeetingSummary = false})
      : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool isLoading = true;
  List<Map<String, dynamic>> members = [];

  double summaryHeight = 200.0;
  final double minSummaryHeight = 100.0;
  final double maxSummaryHeight = 300.0;

  int? katumaMwakilishiFainiId;
  int katumaMwakilishiAmount = 0;

  int? kachelewaFainiId;
  int kachelewaAmount = 0;
  String _groupType = '';

  int? hayupoFainiId;
  int hayupoKwaRuhusaAmount = 0;

  @override
  void initState() {
    super.initState();
    _initDatabaseAndFetchData(); // Replace _fetchData() with this new method
  }

  // Add this new method to initialize the database first
  Future<void> _initDatabaseAndFetchData() async {
    try {
      // Initialize the database first
      await BaseModel.initAppDatabase();
      // Then fetch data
      await _fetchData();
    } catch (e) {
      print('Error initializing database: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to initialize database. Please try again.')),
      );
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    await _getFineAmount();

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
      }

      final usersModel = GroupMembersModel();
      final users = await usersModel.find();
      print('Fetched ${users.length} users.');

      setState(() {
        members = users.map((user) {
          return {
            "userId": user.toMap()['id'],
            "memberNumber": user.toMap()['memberNumber'] ?? 'N/A',
            "name": user.toMap()['name'] ?? 'No Name',
            "status": null,
            "sub_attendance_status": null,
          };
        }).toList();
        isLoading = false;
      });
      print('Members list populated.');

      await _fetchSavedAttendance();
    } catch (e, stackTrace) {
      print('Error fetching data: $e');
      print('Stack Trace: $stackTrace');

      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch members. Please try again.')),
      );
    }
  }

  // Toggle attendance status
  void toggleStatus(int index, String value) {
    setState(() {
      members[index]['status'] = value;
      members[index]['sub_attendance_status'] = null;
      print(
          'Toggled status for ${members[index]['name']} to $value and reset sub_attendance_status.');
    });
  }

  // Set attendance detail
  void setAttendanceDetail(int index, String value) {
    setState(() {
      members[index]['sub_attendance_status'] = value;
      print(
          'Set sub_attendance_status for ${members[index]['name']} to $value');
    });
  }

  Map<String, int> calculateSummary() {
    int totalMembers = members.length;

    int presentMembers = members
        .where((member) =>
            member['status'] == 'Yupo' ||
            member['sub_attendance_status'] == 'Katuma Mwakilishi')
        .length;

    int absentMembers = totalMembers - presentMembers;

    int kawahi = members
        .where((member) =>
            (member['status'] == 'Yupo' ||
                member['sub_attendance_status'] == 'Katuma Mwakilishi') &&
            member['sub_attendance_status'] == 'Kawahi')
        .length;

    int kachelewa = members
        .where((member) =>
            (member['status'] == 'Yupo' ||
                member['sub_attendance_status'] == 'Katuma Mwakilishi') &&
            member['sub_attendance_status'] == 'Kachelewa')
        .length;

    int withPermission = members
        .where((member) =>
            member['status'] == 'Hayupo' &&
            member['sub_attendance_status'] == 'Kwa Ruhusa')
        .length;

    int withoutPermission = members
        .where((member) =>
            member['status'] == 'Hayupo' &&
            member['sub_attendance_status'] == 'Bila Ruhusa')
        .length;

    return {
      'total': totalMembers,
      'present': presentMembers,
      'absent': absentMembers,
      'kawahi': kawahi,
      'kachelewa': kachelewa,
      'withPermission': withPermission,
      'withoutPermission': withoutPermission,
      'representative': members
          .where((member) =>
              member['sub_attendance_status'] == 'Katuma Mwakilishi')
          .length,
    };
  }

  //===========================================================================

  Future<void> _saveAttendance() async {
    await _getFineAmount();

    for (var member in members) {
      if (member['status'] == null) {
        _showSnackBar('Chagua hali za mahudhurio kwa kila mwanachama.');
        return;
      }

      if (member['status'] == 'Yupo' &&
          member['sub_attendance_status'] == null) {
        _showSnackBar('${member['name']} Chagua aina ya mahudhurio.');
        return;
      }

      if (member['status'] == 'Hayupo' &&
          member['sub_attendance_status'] == null) {
        _showSnackBar('${member['name']} Chagua sababu ya kutokuwepo.');
        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    try {
      for (var member in members) {
        int fineAmount = 0;
        int fineId = 0;

        print(
            'Processing member: ${member['name']} with status: ${member['status']} and detail: ${member['sub_attendance_status']}');

        // Assign fines based on status and sub-status
        if (member['status'] == 'Yupo') {
          if (member['sub_attendance_status'] == 'Kachelewa') {
            fineAmount = kachelewaAmount;
            fineId = kachelewaFainiId ?? 0;
          } else if (member['sub_attendance_status'] == 'Katuma Mwakilishi') {
            fineAmount = katumaMwakilishiAmount;
            fineId = katumaMwakilishiFainiId ?? 0;
          }
        } else if (member['status'] == 'Hayupo') {
          if (member['sub_attendance_status'] == 'Bila Ruhusa') {
            // Corrected condition
            fineAmount = hayupoKwaRuhusaAmount;
            fineId = hayupoFainiId ?? 0;
          }
        }

        print(
            'Assigned Fine for ${member['name']}: Fine Amount = $fineAmount, Fine ID = $fineId');

        await _saveOrUpdateAttendance(member, fineAmount);

        final userFaini = UserFainiModel()
          ..meetingId = widget.meetingId
          ..mzungukoId = widget.mzungukoId
          ..userId = member['userId']
          ..fainiId = fineId
          ..paidfaini = 0
          ..unpaidfaini = fineAmount;

        final existingUserFaini = await UserFainiModel()
            .where('meeting_id', '=', widget.meetingId)
            .where('user_id', '=', member['userId'])
            .where('mzungukoId', '=', widget.mzungukoId)
            .first();

        if (existingUserFaini != null) {
          Map<String, dynamic> updateMap = userFaini.toMap();
          updateMap.remove('id');
          updateMap.remove('created_at');
          await UserFainiModel()
              .where('meeting_id', '=', widget.meetingId)
              .where('user_id', '=', member['userId'])
              .where('mzungukoId', '=', widget.mzungukoId)
              .update(updateMap);
        } else {
          await userFaini.create();
        }
      }

      _showSnackBar('Taarifa za mahudhurio zimehifadhiwa kikamilifu!');

      await _updateStatusToCompleted();
      await _fetchSavedAttendance();

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => meetingpage(meetingId: widget.meetingId),
      //   ),
      // );

      if (_groupType == 'VSLA') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VslaMeetingDashboard(meetingId: widget.meetingId),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => meetingpage(meetingId: widget.meetingId),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('Error saving attendance data: $e');
      _showSnackBar('Failed to save attendance data. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveOrUpdateAttendance(
      Map<String, dynamic> member, int fineAmount) async {
    AttendanceModel attendance = AttendanceModel(
      meetingId: widget.meetingId,
      userId: member['userId'],
      attendanceStatus: member['status'],
      subAttendanceStatus: member['sub_attendance_status'],
      status: 'complete',
      mzungukoId: widget.mzungukoId,
    );

    final existingAttendance = await AttendanceModel()
        .where('meeting_id', '=', widget.meetingId)
        .where('user_id', '=', member['userId'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .first();

    if (existingAttendance != null) {
      Map<String, dynamic> updateMap = attendance.toMap();
      updateMap.remove('id');
      updateMap.remove('created_at');
      await AttendanceModel()
          .where('meeting_id', '=', widget.meetingId)
          .where('user_id', '=', member['userId'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .update(updateMap);
      print('Updated existing attendance record for ${member['name']}');
    } else {
      await attendance.create();
      print('Created new attendance record for ${member['name']}');
    }
  }

  Future<void> _getFineAmount() async {
    final KachelewaFaini =
        await FainiModel().where('penalties_name', '=', 'Kachelewa').first();
    if (KachelewaFaini != null) {
      kachelewaFainiId = KachelewaFaini.toMap()['id'];
      kachelewaAmount = int.tryParse(
              KachelewaFaini.toMap()['penalties_price']?.trim() ?? '0') ??
          0;
      print(
          'Kachelewa Fine Amount: $kachelewaAmount, Fine ID: $kachelewaFainiId');
    }

    final hayupoFaini = await FainiModel()
        .where('penalties_name', '=', 'Hayupo bila ruhusa')
        .first();
    if (hayupoFaini != null) {
      hayupoFainiId = hayupoFaini.toMap()['id'];
      hayupoKwaRuhusaAmount =
          int.tryParse(hayupoFaini.toMap()['penalties_price']?.trim() ?? '0') ??
              0;
      print(
          'Hayupo bila Ruhusa Fine Amount: $hayupoKwaRuhusaAmount, Fine ID: $hayupoFainiId');
    }

    final katumaMwakilishi = await FainiModel()
        .where('penalties_name', '=', 'Katuma mwakilishi')
        .first();
    if (katumaMwakilishi != null) {
      katumaMwakilishiFainiId = katumaMwakilishi.toMap()['id'];
      katumaMwakilishiAmount = int.tryParse(
              katumaMwakilishi.toMap()['penalties_price']?.trim() ?? '0') ??
          0;
      print(
          'Katuma Mwakilishi Fine Amount: $katumaMwakilishiAmount, Fine ID: $katumaMwakilishiFainiId');
    }
  }

//=============================================================================

  Future<void> _fetchSavedAttendance() async {
    try {
      final attendanceModel = AttendanceModel();
      final savedAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid ', '=', widget.mzungukoId)
          .find();

      print('Fetched ${savedAttendances.length} attendance records.');

      setState(() {
        for (var attendance in savedAttendances) {
          int userId = attendance.toMap()['user_id'];
          String status = attendance.toMap()['attendance_status'];
          String? detail = attendance.toMap()['sub_attendance_status'];

          // Find the corresponding member and update their status and details
          int memberIndex =
              members.indexWhere((member) => member['userId'] == userId);
          if (memberIndex != -1) {
            members[memberIndex]['status'] = status;
            members[memberIndex]['sub_attendance_status'] = detail;
            print(
                'Updated ${members[memberIndex]['name']} with status: $status and detail: $detail');
          }
        }
      });

      print('Saved Attendance Data Fetched and Displayed.');
    } catch (e, stackTrace) {
      print('Error fetching saved attendance data: $e');
      print('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch saved attendance data.')),
      );
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'attendance',
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
    final l10n = AppLocalizations.of(context)!;

    final summary = calculateSummary();
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.attendance,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                summaryHeight += details.delta.dy;
                summaryHeight =
                    summaryHeight.clamp(minSummaryHeight, maxSummaryHeight);
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: summaryHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Summary Content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSummarySection(summary),
                  ),
                  // Drag Handle
                  Positioned(
                    bottom: 10,
                    left: (MediaQuery.of(context).size.width / 2) - 20,
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.0),

          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : members.isEmpty
                    ? Center(child: Text('No members found.'))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return MemberCard(
                            member: member,
                            onToggleStatus: (status) =>
                                toggleStatus(index, status),
                            onSetDetail: (detail) =>
                                setAttendanceDetail(index, detail),
                          );
                        },
                      ),
          ),

          // Confirm Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: l10n.confirm,
                onPressed: () {
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
                    _saveAttendance();
                  }
                },
                type: ButtonType.elevated,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Summary Section Widget
  Widget _buildSummarySection(Map<String, int> summary) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.attendanceSummary,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          Divider(thickness: 2, color: Colors.blueGrey.shade200),
          SizedBox(height: 8.0),
          SummaryRow(title: l10n.totalMembers, value: summary['total']),
          Divider(),
          SummaryRow(title: l10n.present, value: summary['present']),
          SummaryRow(title: l10n.onTime, value: summary['kawahi']),
          SummaryRow(title: l10n.lates, value: summary['kachelewa']),
          SummaryRow(
              title: l10n.sentRepresentative, value: summary['representative']),
          Divider(),
          SummaryRow(title: l10n.absent, value: summary['absent']),
          SummaryRow(
              title: l10n.withPermission, value: summary['withPermission']),
          SummaryRow(
              title: l10n.withoutPermission,
              value: summary['withoutPermission']),
        ],
      ),
    );
  }
}

// SummaryRow Widget
class SummaryRow extends StatelessWidget {
  final String title;
  final int? value;

  const SummaryRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          Text(
            '${value ?? 0}',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// MemberCard Widget
class MemberCard extends StatelessWidget {
  final Map<String, dynamic> member;
  final Function(String) onToggleStatus;
  final Function(String) onSetDetail;

  const MemberCard({
    Key? key,
    required this.member,
    required this.onToggleStatus,
    required this.onSetDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blueGrey.shade100,
          child: Icon(Icons.person, size: 30, color: Colors.blueGrey.shade700),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member['name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 4),
            Text(
              'Member #: ${member['memberNumber']}',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AttendanceOptions(
              status: member['status'],
              subStatus: member['sub_attendance_status'],
              onToggleStatus: onToggleStatus,
              onSetDetail: onSetDetail,
              memberName: member['name'],
            ),
          ),
        ],
      ),
    );
  }
}

// AttendanceOptions Widget
class AttendanceOptions extends StatelessWidget {
  final String? status;
  final String? subStatus;
  final Function(String) onToggleStatus;
  final Function(String) onSetDetail;
  final String memberName;

  const AttendanceOptions({
    Key? key,
    required this.status,
    required this.subStatus,
    required this.onToggleStatus,
    required this.onSetDetail,
    required this.memberName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Attendance Status Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => onToggleStatus('Yupo'),
              icon: Icon(
                Icons.check_circle,
                color: status == 'Yupo' ? Colors.green : Colors.grey,
              ),
              label: Text(
                l10n.present,
                style: TextStyle(
                  color: status == 'Yupo' ? Colors.green : Colors.grey,
                ),
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: status == 'Yupo' ? Colors.green : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () => onToggleStatus('Hayupo'),
              icon: Icon(
                Icons.cancel,
                color: status == 'Hayupo' ? Colors.red : Colors.grey,
              ),
              label: Text(
                l10n.absent,
                style: TextStyle(
                  color: status == 'Hayupo' ? Colors.red : Colors.grey,
                ),
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: status == 'Hayupo' ? Colors.red : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        if (status == 'Hayupo') ...[
          // Absence Reasons
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.reasonForAbsence,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: [
                  Center(
                    child: CustomChoiceChip(
                      label: l10n.withPermission,
                      isSelected: subStatus == 'Kwa Ruhusa',
                      selectedColor: Colors.green.shade100,
                      onSelected: () => onSetDetail('Kwa Ruhusa'),
                    ),
                  ),
                  Center(
                    child: CustomChoiceChip(
                      label: l10n.withoutPermission,
                      isSelected: subStatus == 'Bila Ruhusa',
                      selectedColor: Colors.red.shade100,
                      onSelected: () => onSetDetail('Bila Ruhusa'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ] else if (status == 'Yupo') ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.attendance,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: [
                  Center(
                    child: CustomChoiceChip(
                      label: l10n.onTime,
                      isSelected: subStatus == 'Kawahi',
                      selectedColor: Colors.green.shade100,
                      onSelected: () => onSetDetail('Kawahi'),
                    ),
                  ),
                  Center(
                    child: CustomChoiceChip(
                      label: l10n.lates,
                      isSelected: subStatus == 'Kachelewa',
                      selectedColor: Colors.red.shade100,
                      onSelected: () => onSetDetail('Kachelewa'),
                    ),
                  ),
                  Center(
                    child: CustomChoiceChip(
                      label: l10n.sendingRepresentative,
                      isSelected: subStatus == 'Katuma Mwakilishi',
                      selectedColor: Colors.orange.shade100,
                      onSelected: () => onSetDetail('Katuma Mwakilishi'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onSelected;

  const CustomChoiceChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: selectedColor,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
