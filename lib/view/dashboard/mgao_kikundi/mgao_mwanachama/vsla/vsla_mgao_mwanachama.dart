import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/vsla/vsla_mgao_mwanachama_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaMgaoWanachamaPage extends StatefulWidget {
  var mzungukoId;
  VslaMgaoWanachamaPage({super.key, this.mzungukoId});

  @override
  _VslaMgaoWanachamaPageState createState() => _VslaMgaoWanachamaPageState();
}

class _VslaMgaoWanachamaPageState extends State<VslaMgaoWanachamaPage> {
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final usersModel = GroupMembersModel();
      final allUsers = await usersModel.find();

      List<Map<String, dynamic>> userList =
          allUsers.map((user) => user.toMap()).toList();

      final userMgaoModel = UserMgaoModel();
      final paidUserMgaos = await userMgaoModel
          .where('status', '=', 'paid')
          .where('type', '=', 'personal')
          .find();

      Set<int> paidUserIds = paidUserMgaos
          .map((mgao) => (mgao as UserMgaoModel).toMap()['userId'] as int)
          .toSet();

      setState(() {
        _users = userList.where((user) {
          return !paidUserIds.contains(user['id']);
        }).toList();

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
    final l10n = AppLocalizations.of(context)!;
    final filteredUsers = _filterUsers();

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberShareout,
        subtitle: l10n.chooseMember,
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
                    l10n.noMembersFound,
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
                              builder: (context) => VslaMgaoMwanachamaSummary(
                                  user: user, mzungukoId: widget.mzungukoId)),
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
                                      user["name"] ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      l10n.phoneNumberLabel(user["phone"] ?? ""),
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
              buttonText: l10n.finished,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MgaoPage(mzungukoId: widget.mzungukoId)),
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
