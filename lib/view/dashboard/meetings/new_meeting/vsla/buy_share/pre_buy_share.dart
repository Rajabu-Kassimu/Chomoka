import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/buy_share.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/share_summary.dart';
import 'package:chomoka/model/GroupMemberModel.dart'; // Add this import
import 'package:chomoka/l10n/app_localizations.dart';


class PreBuyShare extends StatefulWidget {
  final int? meetingId;
  final int? mzungukoId;

  const PreBuyShare({
    super.key,
    this.meetingId,
    this.mzungukoId,
  });

  @override
  State<PreBuyShare> createState() => _PreBuyShareState();
}

class _PreBuyShareState extends State<PreBuyShare> {
  // Add this method to start the member loop process
  Future<void> _startSharePurchaseProcess() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF689F38),
            ),
          );
        },
      );

      // Fetch attendance records for users marked as "Yupo"
      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .where('attendance_status', '=', 'Yupo')
          .find();

      // Close loading indicator
      Navigator.pop(context);

      if (yupoAttendances.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hakuna wanachama waliopo'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Extract user IDs from attendance records
      List<int> yupoUserIds = yupoAttendances
          .map((attendance) => attendance.toMap()['user_id'] as int?)
          .where((id) => id != null)
          .cast<int>()
          .toSet()
          .toList();

      if (yupoUserIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hakuna wanachama waliopo'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Fetch member details for users with "Yupo" status
      final membersModel = GroupMembersModel();
      List<dynamic> presentMembers = [];

      for (int id in yupoUserIds) {
        final member = await membersModel.where('id', '=', id).first();
        if (member != null) {
          presentMembers.add(member);
        }
      }

      if (presentMembers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hakuna maelezo ya wanachama waliopo'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Store purchase data for summary
      List<Map<String, dynamic>> purchaseData = [];

      // Loop through each present member
      for (int i = 0; i < presentMembers.length; i++) {
        final member = presentMembers[i];
        final memberMap = member.toMap();

        // Navigate to BuyShare for this member
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyShare(
              userId: memberMap['id'] is int
                  ? memberMap['id']
                  : int.tryParse(memberMap['id'].toString()),
              userName: memberMap['name'],
              memberNumber: memberMap['memberNumber'] != null
                  ? (memberMap['memberNumber'] is int
                      ? memberMap['memberNumber']
                      : int.tryParse(memberMap['memberNumber'].toString()))
                  : null,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );

        // If result is not null, add to purchase data
        if (result != null && result is Map<String, dynamic>) {
          purchaseData.add({
            'id': memberMap['id'],
            'name': memberMap['name'],
            'shares': result['shares'],
          });
        }
      }

      // After all members, show summary
      if (purchaseData.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShareSummary(
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hakuna hisa zilizochukuliwa'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      print('Error in share purchase process: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna hitilafu imetokea: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.nunuaHisa,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFF5F5F5)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card container for icon and text
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Icon in a circular container
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 119, 119, 119)
                                  .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 80,
                              color: Color.fromARGB(255, 4, 34, 207),
                            ),
                          ),
                          SizedBox(height: 25),
                          // Title
                          Text(
                            l10n.nunuaHisa,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 15),
                          // Description
                          Text(
                            l10n.sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Start button
                          ElevatedButton(
                            onPressed: _startSharePurchaseProcess,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 4, 34, 207),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.anzaSasa,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom buttons
          Container(
            height: 60,
            child: Row(
              children: [
                // "RUDI NYUMA" button (Go back)
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // Update meeting step status to complete before going back
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
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VslaMeetingDashboard(
                            meetingId: widget.meetingId,
                            // mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Color.fromARGB(255, 221, 95, 45), // Orange color
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              l10n.rudiNymba,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom navigation indicator
          Container(
            height: 20,
            color: Colors.black,
            child: Center(
              child: Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
