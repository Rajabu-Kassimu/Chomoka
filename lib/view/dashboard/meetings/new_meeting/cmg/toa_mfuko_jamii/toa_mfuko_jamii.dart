import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart'; // Add this import
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/sababu_kutoa_mfuko.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ToaMfukoJamii extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  ToaMfukoJamii({super.key, required this.meetingId, this.mzungukoId});

  @override
  _ToaMfukoJamiiState createState() => _ToaMfukoJamiiState();
}

class _ToaMfukoJamiiState extends State<ToaMfukoJamii> {
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
  String _groupType = ''; // Add this property

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

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .where('attendance_status', '=', 'Yupo')
          .find();
      if (yupoAttendances.isEmpty) {
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

      final usersModel = GroupMembersModel();
      List<Map<String, dynamic>> yupoUsers = [];

      for (int id in yupoUserIds) {
        final user = await usersModel.where('id', '=', id).first();
        if (user != null) {
          yupoUsers.add(user.toMap());
        }
      }

      setState(() {
        _users = yupoUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        _users = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  List<Map<String, dynamic>> _filterUsers() {
    if (_searchQuery.isEmpty) {
      return _users;
    }
    return _users
        .where((user) =>
            user["name"]
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user["phone"]
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user["memberNumber"]
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        meeting_step: 'toa_mfuko_jamii',
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

  @override
  void initState() {
    super.initState();
    _checkGroupType().then((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _filterUsers();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mfuko_jamii,
        subtitle: l10n.pigaFainiSubtitle,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: l10n.searchByNameOrPhone,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (filteredUsers.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    l10n.noMembers,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SababuKutoaMfukoPage(
                                  userId: user,
                                  meetingId: widget.meetingId,
                                  mzungukoId: widget.mzungukoId)),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.person, size: 30),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user["name"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      l10n.memberNumberLabel(
                                          user["memberNumber"]),
                                      style: TextStyle(
                                        color: Colors.grey,
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
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.doneButton,
              onPressed: () async {
                await _updateStatusToCompleted();

                if (_groupType == 'VSLA') {
                  // Navigate to VSLA dashboard if it's a VSLA group
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VslaMeetingDashboard(
                        meetingId: widget.meetingId,
                        groupId:
                            null, // You might need to pass the groupId if available
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
                print('Button Pressed');
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
