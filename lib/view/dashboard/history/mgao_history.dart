import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MgaoHistory extends StatefulWidget {
  final int mzungukoId;

  const MgaoHistory({
    super.key,
    required this.mzungukoId,
  });

  @override
  State<MgaoHistory> createState() => _MgaoHistoryState();
}

class _MgaoHistoryState extends State<MgaoHistory> {
  bool isLoading = true;
  List<Map<String, dynamic>> _mgaoRecords = [];
  Map<int, Map<String, dynamic>> _usersMap = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _fetchUsers();
      await _fetchMgaoRecords();
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUsers() async {
    try {
      final usersModel = GroupMembersModel();
      // Reset query to avoid issues with previous queries
    //   usersModel.resetQuery();

      final users = await usersModel.find();

      // Create a map of users for quick lookup by ID
      for (var user in users) {
        final userMap = user.toMap();
        _usersMap[userMap['id']] = userMap;
      }

      print('Fetched ${_usersMap.length} users');
    } catch (e) {
      print('Error fetching users: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imeshindwa kupata orodha ya wanachama: $e')),
      );
    }
  }

  Future<void> _fetchMgaoRecords() async {
    try {
      final userMgaoModel = UserMgaoModel();
      // Reset query to avoid issues with previous queries
    //   userMgaoModel.resetQuery();

      final mgaoRecords = await userMgaoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      setState(() {
        _mgaoRecords = mgaoRecords.map((record) => record.toMap()).toList();
      });

      print('Fetched ${_mgaoRecords.length} mgao records for mzunguko ${widget.mzungukoId}');
    } catch (e) {
      print('Error fetching mgao records: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imeshindwa kupata taarifa za mgao: $e')),
      );
    }
  }

  String _getUserName(int? userId) {
    if (userId == null) return 'Mwanachama Hapatikani';
    final user = _usersMap[userId];
    return user != null ? user['name'] ?? 'Jina Halijulikani' : 'Mwanachama Hapatikani';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Historia ya Mgao',
        subtitle: 'Mzunguko ${widget.mzungukoId}',
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _mgaoRecords.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_toggle_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hakuna taarifa za mgao kwa mzunguko huu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _mgaoRecords.length,
                  itemBuilder: (context, index) {
                    final mgao = _mgaoRecords[index];
                    final userName = _getUserName(mgao['userId']);
                    final isPaid = mgao['status'] == 'paid';

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: isPaid ? Colors.green[100] : Colors.orange[100],
                          child: Icon(
                            isPaid ? Icons.check_circle : Icons.pending,
                            color: isPaid ? Colors.green : Colors.orange,
                          ),
                        ),
                        title: Text(
                          userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            _buildInfoRow('Jumla ya Mgao:', mgao['mgaoAmount'] ?? 0),
                            _buildInfoRow('Akiba Binafsi:', mgao['akibaBinafsi'] ?? 0),
                            _buildInfoRow('Akiba Mzunguko Ujao:', mgao['mzungukoUjaoAkiba'] ?? 0),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isPaid ? Colors.green[50] : Colors.orange[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isPaid ? 'Imelipwa' : 'Haijalipwa',
                                style: TextStyle(
                                  color: isPaid ? Colors.green[700] : Colors.orange[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showMgaoDetails(mgao, userName);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        child: Icon(Icons.refresh),
        tooltip: 'Onyesha upya',
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    final formattedValue = value is num
        ? NumberFormat.currency(locale: 'sw', symbol: 'TZS ', decimalDigits: 0).format(value)
        : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          Text(
            formattedValue,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showMgaoDetails(Map<String, dynamic> mgao, String userName) {
    final isPaid = mgao['status'] == 'paid';
    final mgaoAmount = mgao['mgaoAmount'] ?? 0.0;
    final akibaBinafsi = mgao['akibaBinafsi'] ?? 0.0;
    final mzungukoUjaoAkiba = mgao['mzungukoUjaoAkiba'] ?? 0.0;
    final actualPayment = mgaoAmount - mzungukoUjaoAkiba;

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
                'Taarifa za Mgao',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              _buildDetailRow('Jumla ya Mgao', mgaoAmount),
              _buildDetailRow('Akiba Binafsi', akibaBinafsi),
              _buildDetailRow('Akiba Mzunguko Ujao', mzungukoUjaoAkiba),
              Divider(),
              _buildDetailRow('Kiasi Kilicholipwa', actualPayment, isHighlighted: true),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isPaid ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isPaid ? 'Imelipwa' : 'Haijalipwa',
                  style: TextStyle(
                    color: isPaid ? Colors.green[700] : Colors.orange[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
  }

  Widget _buildDetailRow(String label, double amount, {bool isHighlighted = false}) {
    final formattedAmount = NumberFormat.currency(
      locale: 'sw',
      symbol: 'TZS ',
      decimalDigits: 0
    ).format(amount);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isHighlighted ? Colors.black : Colors.grey[700],
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            formattedAmount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? Colors.green[700] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}