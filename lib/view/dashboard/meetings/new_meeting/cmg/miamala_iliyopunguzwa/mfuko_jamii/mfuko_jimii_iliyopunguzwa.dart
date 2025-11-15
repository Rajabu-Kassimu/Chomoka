import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/wadaiwa_mikopo/mkopo_information.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';

class MiamalaIliyopunguzwaMfukoJamiiPage extends StatefulWidget {
  MiamalaIliyopunguzwaMfukoJamiiPage({super.key});

  @override
  _MiamalaIliyopunguzwaMfukoJamiiPageState createState() =>
      _MiamalaIliyopunguzwaMfukoJamiiPageState();
}

class _MiamalaIliyopunguzwaMfukoJamiiPageState
    extends State<MiamalaIliyopunguzwaMfukoJamiiPage> {
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _filterUsers();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Miamala Iliyopunguzwa',
        subtitle: 'Chagua mwanachama',
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Tafuta kwa jina au simu",
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
                  "Hakuna wanachama waliopo.",
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
                            ),
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
                                      "Namba ya mwanachama: ${user["phone"]}",
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
              buttonText: 'Nimemaliza',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => uwekajitaarifadashboard(),
                  ),
                );
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
