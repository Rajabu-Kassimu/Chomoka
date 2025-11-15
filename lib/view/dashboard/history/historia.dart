import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/view/dashboard/history/user_history/user_history.dart';
import 'package:chomoka/view/dashboard/history/user_history/vsla_user_history.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Add this import for database initialization
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class HistoryPage extends StatefulWidget {
  final bool isFromHistory;
  HistoryPage({this.isFromHistory = false});
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = "";
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _mzungukoList = [];
  List<Map<String, dynamic>> _meetings = [];
  bool isLoading = true;
  int? _selectedMzungukoId;
  String _groupType = '';
  bool _hasMgaoData = false;

  Future<void> _fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final usersModel = GroupMembersModel();
      final users = await usersModel.find();

      setState(() {
        _users = users.map((user) => user.toMap()).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        _users = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch users: $e')),
      );
    }
  }

  Future<void> _fetchMzunguko() async {
    try {
      final mzungukoModel = MzungukoModel();
      final mzungukoData = await mzungukoModel.find();

      setState(() {
        _mzungukoList =
            mzungukoData.map((mzunguko) => mzunguko.toMap()).toList();
        if (_mzungukoList.isNotEmpty) {
          _selectedMzungukoId = _mzungukoList.first['id'];
        }
      });
    } catch (e) {
      print('Failed to fetch Mzunguko: $e');
    }
  }

  Future<void> _fetchMeetings(int selectedMzungukoId) async {
    try {
      final meetingModel = MeetingModel();
      // Reset any previous query conditions

      final meetings = await meetingModel
          .where('mzungukoId', '=', selectedMzungukoId)
          .where('status', '=', 'complete')
          .find();

      if (meetings.isEmpty) {
        print(
            'No completed meetings found for Mzunguko ID: $selectedMzungukoId');
      }

      setState(() {
        _meetings = meetings.map((meeting) {
          final meetingMap = meeting.toMap();
          final createdAt = meetingMap['created_at'];

          DateTime? createdAtDateTime;
          if (createdAt != null) {
            createdAtDateTime = DateTime.parse(createdAt);
          }

          meetingMap['formatted_created_at'] =
              createdAtDateTime?.toLocal().toString() ?? 'N/A';

          return meetingMap;
        }).toList();
      });
    } catch (e) {
      print('Failed to fetch meetings: $e');
      setState(() {
        _meetings = [];
      });
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
    _tabController = TabController(length: 2, vsync: this);
    // Initialize database first, then fetch data
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      // Initialize the database using BaseModel's method
      await BaseModel.initAppDatabase();
      print('Database initialized successfully');
      // Then fetch data
      await _fetchData();
    } catch (e) {
      print('Error initializing database: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize database: $e')),
      );
    }
  }

  // Add this variable to track if mgao data exists

  // Add this method to check if mgao data exists for the current mzunguko
  Future<void> _checkMgaoData() async {
    try {
      if (_selectedMzungukoId == null) return;

      final userMgaoModel = UserMgaoModel();
      final mgaoData = await userMgaoModel
          .where('mzungukoId', '=', _selectedMzungukoId)
          .find();

      setState(() {
        _hasMgaoData = mgaoData.isNotEmpty;
      });

      print('Mgao data exists: $_hasMgaoData');
    } catch (e) {
      print('Error checking mgao data: $e');
      setState(() {
        _hasMgaoData = false;
      });
    }
  }

  // Modify _fetchData to include checking for mgao data
  Future<void> _fetchData() async {
    await _checkMgaoData(); // Add this line to check for mgao data
    await _fetchUsers();
    await _fetchMzunguko();
    if (_selectedMzungukoId != null) {
      await _fetchMeetings(_selectedMzungukoId!);
      await _fetchGroupType();
    }
  }

  // Add this method to show mgao summary dialog
  Future<void> _showMgaoSummary() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userMgaoModel = UserMgaoModel();
      final mgaoData = await userMgaoModel
          .where('mzungukoId', '=', _selectedMzungukoId)
          .find();

      setState(() {
        isLoading = false;
      });

      if (mgaoData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna taarifa za mgao kwa mzunguko huu')),
        );
        return;
      }

      // Calculate totals
      double totalMgaoAmount = 0;
      double totalAkibaBinafsi = 0;
      double totalMzungukoUjaoAkiba = 0;

      for (var mgao in mgaoData) {
        final mgaoMap = mgao.toMap();
        totalMgaoAmount += (mgaoMap['mgaoAmount'] as double?) ?? 0;
        totalAkibaBinafsi += (mgaoMap['akibaBinafsi'] as double?) ?? 0;
        totalMzungukoUjaoAkiba +=
            (mgaoMap['mzungukoUjaoAkiba'] as double?) ?? 0;
      }

      // Show dialog with summary
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Muhtasari wa Mgao',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 20),
                _buildSummaryRow('Jumla ya Mgao', totalMgaoAmount),
                _buildSummaryRow('Jumla ya Akiba Binafsi', totalAkibaBinafsi),
                _buildSummaryRow(
                    'Jumla ya Akiba Mzunguko Ujao', totalMzungukoUjaoAkiba),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Funga'),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error showing mgao summary: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  // Helper method to build summary row
  Widget _buildSummaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            'TZS ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchGroupType() async {
    try {
      if (_selectedMzungukoId == null) {
        print('Cannot fetch group type: _selectedMzungukoId is null');
        return;
      }

      print('Fetching group type for mzungukoId: $_selectedMzungukoId');

      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', _selectedMzungukoId)
          .findOne();

      print('Group type data result: $groupTypeData');

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        final value = groupTypeData.value;
        print('Found group type value: $value');
        setState(() {
          _groupType = value ?? '';
        });
      } else {
        print('Could not find group type in KatibaModel');
      }
    } catch (e) {
      print('Error fetching group type: $e');
    }
  }

  void _navigateToMeetingSummary(Map<String, dynamic> meeting) async {
    print('Navigating to meeting summary with group type: $_groupType');

    // Ensure database is initialized before navigation
    try {
      // Make sure database is initialized before navigation
      await BaseModel.initAppDatabase();
      print('Database initialized before navigation');

      if (_groupType == 'VSLA') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaMeetingSummaryPage(
              meetingId: meeting['id'],
              mzungukoId: _selectedMzungukoId!,
              meetingNumber: meeting['number'],
              isFromHistory: true,
            ),
          ),
        );
      } else {
        // Navigate to regular meeting summary
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MuhtasariWaKikaoPage(
              meetingId: meeting['id'],
              mzungukoId: _selectedMzungukoId!,
              meetingNumber: meeting['number'],
              isFromHistory: true,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error initializing database before navigation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize database: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_groupType == 'VSLA') {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    }
    print(_checkMgaoData);

    final filteredUsers = _filterUsers();

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.historia,
        showBackArrow: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.kikundi),
            Tab(text: AppLocalizations.of(context)!.member),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownButton<int>(
                value: _selectedMzungukoId,
                onChanged: (int? newValue) async {
                  if (newValue != null) {
                    setState(() {
                      _selectedMzungukoId = newValue;
                      isLoading = true;
                    });

                    setState(() {
                      _meetings = [];
                    });

                    await _fetchMeetings(newValue);
                    await _fetchGroupType();
                    await _checkMgaoData();

                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                isExpanded: true,
                iconSize: 30.0,
                items: _mzungukoList.map<DropdownMenuItem<int>>((mzunguko) {
                  return DropdownMenuItem<int>(
                    value: mzunguko['id'],
                    child: Text("Mzunguko ${mzunguko['id']}"),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _meetings.isEmpty
                    ? Center(
                        child: Text(AppLocalizations.of(context)!.hakuna_vikao))
                    : ListView.builder(
                        itemCount: _meetings.length,
                        itemBuilder: (context, index) {
                          final meeting = _meetings[index];
                          final createdAt = meeting['date'];

                          print('Raw date value: $createdAt');

                          String formattedDate;
                          String formattedTime;

                          try {
                            if (createdAt != null && createdAt.isNotEmpty) {
                              final dateTime = DateTime.parse(createdAt);
                              formattedDate = DateFormat('EEEE, d MMMM yyyy')
                                  .format(dateTime);
                              formattedTime =
                                  DateFormat('HH:mm').format(dateTime);
                            } else {
                              formattedDate = 'Tarehe Haijulikani';
                              formattedTime = '';
                            }
                          } catch (e) {
                            print('Error formatting date: $e');
                            formattedDate = 'Tarehe Haijulikani';
                            formattedTime = '';
                          }

                          return HistoryListTile(
                            icon:
                                Icon(Icons.door_back_door, color: Colors.blue),
                            title:
                                '${AppLocalizations.of(context)!.kikao} ${meeting['number']}',
                            date: formattedDate,
                            time: formattedTime.isEmpty
                                ? 'Muda haujulikani'
                                : 'Saa $formattedTime',
                            onTap: () {
                              _navigateToMeetingSummary(meeting);
                            },
                            tileColor: Colors.white,
                          );
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.tafutaJinaSimu,
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
                              AppLocalizations.of(context)!.hakunaWanachama,
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
                                  if (_groupType == 'VSLA') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VslaUserHistory(
                                          user: user,
                                          mzungukoId: _selectedMzungukoId!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserHistory(
                                          user: user,
                                          mzungukoId: _selectedMzungukoId!,
                                        ),
                                      ),
                                    );
                                  }
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user["name"] ?? "Unknown Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Namba ya mwanachama: ${user["memberNumber"] ?? 'Unknown'}",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Add this custom ListTile widget
Widget HistoryListTile({
  required Icon icon,
  required String title,
  required String date,
  required String time,
  required VoidCallback onTap,
  required Color tileColor,
}) {
  return Card(
    color: tileColor,
    elevation: 2,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
      onTap: onTap,
    ),
  );
}
