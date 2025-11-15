import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class UnpaidAkibaLazimaPage extends StatefulWidget {
  final int? mzungukoId;
  final bool isFromMgaowakikundi;
  final bool isFromAkibaLazima;

  UnpaidAkibaLazimaPage({
    Key? key,
    this.mzungukoId,
    this.isFromMgaowakikundi = false,
    this.isFromAkibaLazima = false,
  }) : super(key: key);

  @override
  _UnpaidAkibaLazimaPageState createState() => _UnpaidAkibaLazimaPageState();
}

class _UnpaidAkibaLazimaPageState extends State<UnpaidAkibaLazimaPage> {
  List<AkibaLazimaModel> unpaidUsers = [];
  Map<int, GroupMembersModel> userDetails = {};
  int _fixedAmount = 0;
  bool _isUpdating = false;
  bool _isLoading = true;
  double totalUnpaid = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchKatibaAmount().then((_) {
      _fetchUnpaidUsers();
    });
  }

  Future<void> _fetchKatibaAmount() async {
    try {
      final katibaModel = KatibaModel();
      final katiba = await katibaModel
          .where('katiba_key', '=', 'akiba_lazima')
          .where('mzungukoid', '=', widget.mzungukoId)
          .first();
      if (katiba != null) {
        setState(() {
          _fixedAmount = int.parse(katiba.toMap()['value'] ?? '0');
        });
      } else {
        print("No Katiba value found for 'akiba_lazima'.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Hakuna kiasi kilichobainishwa kwa akiba lazima.')),
        );
      }
    } catch (e) {
      print('Error fetching Katiba amount: $e');
    }
  }

  Future<void> _fetchUnpaidUsers() async {
    try {
      final result = await AkibaLazimaModel()
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('paid_status', '=', 'unpaid')
          .select();
      List<AkibaLazimaModel> fetchedUsers =
          result.map((map) => AkibaLazimaModel().fromMap(map)).toList();

      double totalUnpaidAmount = 0.0;
      setState(() {
        unpaidUsers = fetchedUsers;
      });

      for (var user in fetchedUsers) {
        await _fetchUserDetails(user.userId!);
        totalUnpaidAmount += _fixedAmount.toDouble();
      }

      setState(() {
        totalUnpaid = totalUnpaidAmount;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching unpaid users: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load users with unpaid status.'),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserDetails(int userId) async {
    try {
      final user = await GroupMembersModel().where('id', '=', userId).first();
      if (user != null) {
        setState(() {
          userDetails[userId] = GroupMembersModel().fromMap(user.toMap());
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _updateUserStatusToPaid(int userId) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      final userRecord =
          unpaidUsers.firstWhere((user) => user.userId == userId);
      userRecord.paidStatus = 'paid';
      userRecord.amount = _fixedAmount.toDouble();

      await AkibaLazimaModel()
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .update({'paid_status': 'paid', 'amount': _fixedAmount});

      setState(() {
        unpaidUsers.removeWhere((user) => user.userId == userId);
        totalUnpaid -= _fixedAmount.toDouble();
        _isUpdating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Malipo Yamepokelewa Kikamilifu!'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      setState(() {
        _isUpdating = false;
      });
      print('Error updating user status: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update status.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Michango Ambayo Haijalipwa',
        subtitle: 'Akiba Lazima',
        showBackArrow: true,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color.fromARGB(255, 4, 34, 207),
                  ),
                  SizedBox(height: 16),
                  Text('Inapakia taarifa...',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(height: 16),
                _buildSummaryCard(),
                SizedBox(height: 8),
                Expanded(
                  child: unpaidUsers.isEmpty
                      ? _buildEmptyState()
                      : _buildUsersList(),
                ),
                if (unpaidUsers.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: 'Nimemaliza',
                      onPressed: () async {
                        if (widget.isFromAkibaLazima) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      type: ButtonType.elevated,
                    ),
                  )
              ],
            ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Muhtasari wa Michango',
              style: TextStyle(
                color: Color.fromARGB(255, 4, 34, 207),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Akiba Lazima',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.3), height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Jumla ya Wanachama',
                    '${unpaidUsers.length}',
                    Icons.people,
                    Color.fromARGB(255, 4, 34, 207),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Jumla ya Madeni',
                    formatCurrency(totalUnpaid, Provider.of<CurrencyProvider>(context).currencyCode),
                    Icons.warning_amber,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      String title, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 16),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Colors.green,
                ),
                SizedBox(height: 16),
                Text(
                  'Hakuna Mwanachama Anaedaiwa Akiba Lazima',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            color: Color.fromARGB(255, 4, 34, 207),
            buttonText: 'Nimemaliza',
            onPressed: () async {
              Navigator.pop(context);
            },
            type: ButtonType.elevated,
          ),
        ),
      ],
    );
  }

  Widget _buildUsersList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: unpaidUsers.length,
      itemBuilder: (context, index) {
        final user = unpaidUsers[index];
        final userInfo = userDetails[user.userId];

        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 4, 34, 207),
                  radius: 24,
                  child: Text(
                    userInfo?.name?.substring(0, 1) ?? '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  userInfo?.name ?? 'Unknown User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    _buildInfoRow(Icons.badge, 'Namba ya Mwanachama',
                        userInfo?.memberNumber ?? 'N/A'),
                    SizedBox(height: 4),
                    _buildInfoRow(
                        Icons.phone, 'Simu', userInfo?.phone ?? 'N/A'),
                    SizedBox(height: 8),
                    if (user.paidStatus == 'unpaid')
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.warning, color: Colors.red, size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Kiasi cha Akiba Lazima Anachodaiwa: ' + formatCurrency(_fixedAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Divider(height: 1),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: user.paidStatus == 'unpaid'
                          ? () => _updateUserStatusToPaid(user.userId!)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: user.paidStatus == 'unpaid'
                            ? Colors.red
                            : Colors.green,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isUpdating
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  user.paidStatus == 'unpaid'
                                      ? Icons.payment
                                      : Icons.check_circle,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  user.paidStatus == 'unpaid'
                                      ? 'Lipia'
                                      : 'Ameshailipia',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        SizedBox(width: 6),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              style: TextStyle(fontSize: 13, color: Colors.black),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
