import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/SuccessSplashPage.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class SendSms extends StatefulWidget {
  final int? groupId;
  final int? meetingId;
  var mzungukoId;
  var meetingNumber;

  SendSms({
    Key? key,
    this.groupId,
    this.meetingId,
    this.mzungukoId,
    this.meetingNumber,
  }) : super(key: key);

  @override
  State<SendSms> createState() => _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  List<GroupMembersModel> members = [];
  Set<int> selectedMemberIds = {};
  bool isLoading = true;
  bool isSelectMode = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      setState(() {
        isLoading = true;
      });

      // First fetch attendance records with 'Yupo' status
      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('attendance_status', '=', 'Yupo')
          .find();

      if (yupoAttendances.isEmpty) {
        setState(() {
          members = [];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna wanachama waliopo.')),
        );
        return;
      }

      // Extract user IDs with 'Yupo' status
      List<int> yupoUserIds = yupoAttendances
          .map((attendance) => attendance.toMap()['user_id'] as int?)
          .where((id) => id != null)
          .cast<int>()
          .toSet()
          .toList();

      // Fetch only the members who are present
      final groupMembersModel = GroupMembersModel();
      List<GroupMembersModel> presentMembers = [];

      for (int userId in yupoUserIds) {
        final member = await groupMembersModel.where('id', '=', userId).first();
        if (member != null) {
          presentMembers.add(member as GroupMembersModel);
        }
      }

      setState(() {
        members = presentMembers;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching members: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch members')),
      );
    }
  }

  void _toggleMemberSelection(int? memberId) {
    if (memberId == null) return;
    setState(() {
      if (selectedMemberIds.contains(memberId)) {
        selectedMemberIds.remove(memberId);
      } else {
        selectedMemberIds.add(memberId);
      }
    });
  }

  // Add these variables to track user data
  double _shareValue = 0.0;
  Map<int, Map<String, dynamic>> userSummaries = {};

  Future<void> _fetchUserData(int userId) async {
    try {
      // Fetch share value
      final katiba = KatibaModel();
      final shareValueData = await katiba
          .where('katiba_key', '=',
              'share_amount') // Changed from 'share_value' to 'share_amount'
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareValueData != null && shareValueData is KatibaModel) {
        _shareValue =
            double.tryParse(shareValueData.value?.toString() ?? '0') ?? 3000.0;
      }

      // Initialize user summary
      userSummaries[userId] = {
        'shares_count': 0,
        'shares_value': 0.0,
        'mfuko_jamii': 0.0,
        'mkopo_wasasa': 0.0,
        'faini': 0.0,
      };

      // Fetch shares
      final memberShareModel = MemberShareModel();
      final shares = await memberShareModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', userId)
          .select();

      int totalShares = shares.fold(
          0, (sum, share) => sum + (share['number_of_shares'] as int? ?? 0));

      // Fetch Mfuko Jamii
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final mfukoJamiiResult = await uchangiajiMfukoJamiiModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', userId)
          .select();

      double mfukoJamiiTotal = mfukoJamiiResult.fold(0.0,
          (sum, entry) => sum + (entry['total'] as num?)!.toDouble() ?? 0.0);

      // Fetch current loans
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final mkopoResult = await rejeshaMkopoModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', userId)
          .select();

      double mkopoTotal = mkopoResult.fold(
          0.0,
          (sum, entry) =>
              sum + (entry['unpaidAmount'] as num?)!.toDouble() ?? 0.0);

      // Fetch fines
      final userFainiModel = UserFainiModel();
      final fainiResult = await userFainiModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', userId)
          .select();

      double fainiTotal = fainiResult.fold(
          0.0,
          (sum, entry) =>
              sum + (entry['unpaidfaini'] as num?)!.toDouble() ?? 0.0);

      // Update user summary
      userSummaries[userId] = {
        'shares_count': totalShares,
        'shares_value': totalShares * _shareValue,
        'mfuko_jamii': mfukoJamiiTotal,
        'mkopo_wasasa': mkopoTotal,
        'faini': fainiTotal,
      };
    } catch (e) {
      print('Error fetching data for user $userId: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(widget.meetingId);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.sendSmsTitle,
        subtitle: l10n.sendSmsSubtitle,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: isSelectMode
                  ? _buildMembersList(l10n)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.chooseSmsSendType,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 32),
                        _buildOptionButtons(l10n),
                      ],
                    ),
            ),
    );
  }

  Widget _buildOptionButtons(AppLocalizations l10n) {
    return Column(
      children: [
        CustomButton(
          buttonText: l10n.sendToAll,
          onPressed: () {
            setState(() {
              isSelectMode = false;
              selectedMemberIds.clear();
            });
            _sendSMS(l10n);
          },
          type: ButtonType.elevated,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(height: 8),
        CustomButton(
          buttonText: l10n.chooseMembers,
          onPressed: () {
            setState(() {
              isSelectMode = true;
              selectedMemberIds.clear();
            });
          },
          type: ButtonType.elevated,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildMembersList(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.totalMembers,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${members.length}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              if (isSelectMode)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 4, 34, 207)
                            .withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        '${selectedMemberIds.length} ${l10n.selected}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              final isSelected = selectedMemberIds.contains(member.id);

              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isSelectMode
                          ? () => _toggleMemberSelection(member.id)
                          : null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade200,
                              ),
                              child: Center(
                                child: Text(
                                  member.name?.substring(0, 1).toUpperCase() ??
                                      l10n.unknownName.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.name ?? l10n.unknownName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    member.phone ?? l10n.noPhone,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelectMode)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(Icons.check,
                                        size: 14,
                                        color: Colors.white)
                                    : null,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (isSelectMode)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: CustomButton(
                buttonText: selectedMemberIds.isEmpty
                    ? l10n.sendSms
                    : l10n.sendSmsWithCount(selectedMemberIds.length),
                onPressed: () => _sendSMS(l10n),
                type: ButtonType.elevated,
                color: const Color.fromARGB(255, 4, 34, 207),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _sendSMS(AppLocalizations l10n) async {
    List<GroupMembersModel> targetMembers = isSelectMode
        ? members
            .where((member) => selectedMemberIds.contains(member.id))
            .toList()
        : members;

    if (targetMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isSelectMode
                ? l10n.selectMembersToSendSms
                : l10n.noMembersToSendSms)),
      );
      return;
    }

    // Fetch data for each member
    for (var member in targetMembers) {
      if (member.id != null) {
        await _fetchUserData(member.id!);
      }
    }

    // Send SMS to each member
    for (var member in targetMembers) {
      if (member.phone == null || member.phone!.isEmpty) continue;

      final userSummary = userSummaries[member.id];
      if (userSummary == null) continue;

      String message =
          l10n.smsGreeting(member.name ?? l10n.unknownName) + '\n\n' +
          l10n.smsSummaryHeader + '\n' +
          l10n.smsTotalShares(userSummary['shares_count'].toString(), userSummary['shares_value'].toInt().toString()) + '\n' +
          l10n.smsSocialFund(userSummary['mfuko_jamii'].toInt().toString()) + '\n' +
          l10n.smsCurrentLoan(userSummary['mkopo_wasasa'].toInt().toString()) + '\n' +
          l10n.smsFine(userSummary['faini'].toInt().toString());

      try {
        await sendSMS(
          message: message,
          recipients: [member.phone!],
          sendDirect: true,
        );
      } catch (e) {
        print('Error sending SMS to ${member.name}: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(l10n.failedToSendSms(member.name ?? l10n.unknownName))),
        );
      }
    }

    // After sending all SMS messages, close the meeting
    try {
      // Show loading indicator while closing meeting
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Verify the meeting exists and is not already closed
      final existingMeeting = await MeetingModel()
          .where('id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .first();

      // if (existingMeeting == null) {
      //   Navigator.pop(context); // Remove loading indicator
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(l10n.meetingNotFound)),
      //   );
      //   return;
      // }

      if (existingMeeting?.toMap()['status'] == 'complete') {
        Navigator.pop(context); // Remove loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.failedToCloseMeeting)),
        );
        return;
      }

      // Update the meeting status to complete using BaseModel's update method
      print('Closing meeting with params: meetingId=${widget.meetingId} (${widget.meetingId.runtimeType}), mzungukoId=${widget.mzungukoId} (${widget.mzungukoId.runtimeType})');

      // First verify if the meeting exists and print its data
      // Also print all rows from the table so we can see what's stored
      final meetingModelForSelect = MeetingModel();
      final allMeetings = await MeetingModel().select();
      print('All meetings in DB: ${allMeetings.length}');
      for (var r in allMeetings) {
        print('meeting row: $r');
      }

      final checkMeeting = await meetingModelForSelect
          .where('id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Found meetings with where clauses: ${checkMeeting.length}');
      if (checkMeeting.isNotEmpty) {
        print('Meeting data: ${checkMeeting.first}');
      }
      
      // Create update values with required fields
      final updateValues = {
        'status': 'complete',
        'updated_at': DateTime.now().toIso8601String(),
        'synced_at': null,
      };
      
      // Create a new instance for update since where clauses are cleared after select
      final meetingModelForUpdate = MeetingModel();
      final rowsUpdated = await meetingModelForUpdate
          .where('id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .update(updateValues);

      print('Rows updated (by id + mzungukoId): $rowsUpdated');

      int effectiveRowsUpdated = rowsUpdated;

      // If no rows were updated, fallback to updating by id only (handles null mzungukoId in DB)
      if (effectiveRowsUpdated == 0) {
        print('No rows matched id+ mzungukoId; attempting fallback update by id only...');
        final fallbackUpdated = await MeetingModel()
            .where('id', '=', widget.meetingId)
            .update(updateValues);
        print('Fallback rows updated (by id only): $fallbackUpdated');
        effectiveRowsUpdated = fallbackUpdated;
      }

      Navigator.pop(context); // Remove loading indicator

      if (effectiveRowsUpdated > 0) {
        // Successfully closed the meeting, navigate to success page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessSplashPage(
              meetingId: widget.meetingId!,
              groupId: widget.groupId,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.failedToCloseMeeting),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Make sure to remove loading indicator if there's an error
      Navigator.of(context).pop();
      print('Error closing meeting: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.failedToCloseMeetingWithError(e.toString())),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
