import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/chagua_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart'; // Add this import
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class PigaFainiPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  PigaFainiPage({super.key, required this.meetingId, this.mzungukoId});

  @override
  _PigaFainiPageState createState() => _PigaFainiPageState();
}

class _PigaFainiPageState extends State<PigaFainiPage> {
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
  String _groupType = ''; // Add this property

  @override
  void initState() {
    super.initState();
    _checkGroupType();
    _fetchData();
  }

  // Add this method to check the group type
  Future<void> _checkGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('katiba_key', '=', 'kanuni')
          .first();

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
      print('error: $e');
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

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _filterUsers();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.pigaFainiTitle,
        subtitle: l10n.pigaFainiSubtitle,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: l10n.searchHint,
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
                              builder: (context) => SelectFinesScreen(
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
                                      "Namba ya mwanachama: ${user["memberNumber"]}",
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
              onPressed: () {
                // Navigate based on group type
                if (_groupType.toLowerCase() == 'vsla') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VslaMeetingDashboard(
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
