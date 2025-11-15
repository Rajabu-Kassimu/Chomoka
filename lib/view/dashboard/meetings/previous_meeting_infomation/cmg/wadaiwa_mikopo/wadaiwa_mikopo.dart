import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/wadaiwa_mikopo/mkopo_information.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/vsla_previous_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class WadaiwaMikopoPage extends StatefulWidget {
  var mzungukoId;
  WadaiwaMikopoPage({super.key, this.mzungukoId});

  @override
  _WadaiwaMikopoPageState createState() => _WadaiwaMikopoPageState();
}

class _WadaiwaMikopoPageState extends State<WadaiwaMikopoPage> {
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
  String _groupType = '';

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
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
      // Fetch all users from the GroupMemberModel
      final usersModel = GroupMembersModel();
      List<Map<String, dynamic>> allUsers = await usersModel
          .find()
          .then((users) => users.map((user) => user.toMap()).toList());

      setState(() {
        _users = allUsers;
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
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = KikaoKilichopitaModel(
        meeting_step: 'wadaiwa_mikopo',
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
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filteredUsers = _filterUsers();

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanDebtorsTitle,
        subtitle: l10n.select,
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
              Center(
                child: Text(
                  l10n.noMembersFound,
                  style: TextStyle(fontSize: 16),
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
                            builder: (context) => WadaiwaMkopoInfoPage(
                                userId: user['id'],
                                mzungukoId: widget.mzungukoId),
                          ),
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
                                        l10n.memberNumberLabel(user["memberNumber"])
                                      ,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VslaPreviosusMeetingDashboard(
                        mzungukoId: widget.mzungukoId,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => uwekajitaarifadashboard(
                        mzungukoId: widget.mzungukoId,
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
