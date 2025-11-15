import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class UserUnpaidAkibaLazima extends StatefulWidget {
  final int? mzungukoId;
  final int? userId;
  final String? name;

  const UserUnpaidAkibaLazima(
      {super.key, this.mzungukoId, this.userId, this.name});

  @override
  State<UserUnpaidAkibaLazima> createState() => _UserUnpaidAkibaLazimaState();
}

class _UserUnpaidAkibaLazimaState extends State<UserUnpaidAkibaLazima> {
  List<AkibaLazimaModel> unpaidUsers = [];
  Map<int, GroupMembersModel> userDetails = {};
  Map<int, String> meetingDetails = {};
  int _fixedAmount = 0;
  bool _isUpdating = false;
  double totalUnpaid = 0.0;
  double totalPaid = 0.0;
  bool _isLoading = true;

  Future<void> _fetchAkibaLazimaAmount() async {
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

        final akibaLazimaModel = AkibaLazimaModel();
        final result = await akibaLazimaModel
            .where('mzungukoId', '=', widget.mzungukoId)
            .where('user_id', '=', widget.userId)
            .where('paid_status', '=', 'unpaid')
            .select();

        List<AkibaLazimaModel> fetchedUsers =
            result.map((map) => AkibaLazimaModel().fromMap(map)).toList();

        setState(() {
          unpaidUsers = fetchedUsers;
        });

        double totalUnpaidAmount = 0.0;
        for (var user in fetchedUsers) {
          await _fetchUserDetails(user.userId!);
          await _fetchMeetingDetails(user.meetingId ?? 0);
          totalUnpaidAmount += _fixedAmount.toDouble();
        }

        setState(() {
          totalUnpaid = totalUnpaidAmount;
          _isLoading = false;
        });
      } else {
        print("No Katiba value found for 'akiba_lazima'.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Hakuna kiasi kilichobainishwa kwa akiba lazima.')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching Akiba Lazima amount or users: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load Akiba Lazima amount or users.'),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMeetingDetails(int meetingId) async {
    try {
      if (meetingId <= 0) {
        meetingDetails[meetingId] = 'N/A';
        return;
      }

      final meeting = await MeetingModel().where('id', '=', meetingId).first();
      if (meeting != null) {
        final meetingData = MeetingModel().fromMap(meeting.toMap());
        setState(() {
          meetingDetails[meetingId] = 'Kikao #${meetingData.number ?? "N/A"}';
        });
      } else {
        meetingDetails[meetingId] = 'N/A';
      }
    } catch (e) {
      print('Error fetching meeting details: $e');
      meetingDetails[meetingId] = 'N/A';
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

  Future<void> _updateUserStatusToPaid() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      final userRecord =
          unpaidUsers.firstWhere((user) => user.userId == widget.userId);
      userRecord.paidStatus = 'paid';

      await AkibaLazimaModel()
          .where('user_id', '=', widget.userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .update({'paid_status': 'paid', 'amount': _fixedAmount});

      setState(() {
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

  Future<void> _fetchAkibaLazimaTotalForUser() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();
      final result = await akibaLazimaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', widget.userId)
          .where('paid_status', '=', 'paid')
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['amount'] ?? 0) as double)
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        totalPaid = sum;
      });

      print('Akiba Lazima for user $widget.userId: $totalPaid');
    } catch (e) {
      print('Error fetching Akiba Lazima total for user $widget.userId: $e');
      setState(() {
        totalPaid = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAkibaLazimaTotalForUser().then((_) {
      _fetchAkibaLazimaAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.compulsorySavingsTitle,
        subtitle: l10n.compulsorySavingsSubtitle,
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
                  Text(l10n.loadingMessage,
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
                        Navigator.pop(context);
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
              'Mwanachama: ${widget.name}',
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
                    'Aliyolipa',
                    formatCurrency(totalPaid, Provider.of<CurrencyProvider>(context).currencyCode),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Asiyolipa',
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 18),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
                  'Hakuna Kiasi cha Akiba Lazima anachodaiwa mwanachama',
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
        final meetingInfo = meetingDetails[user.meetingId ?? 0] ?? 'N/A';
        final displayMeetingInfo = meetingInfo == 'N/A'
            ? 'Ni taarifa katikati ya mzunguko'
            : meetingInfo;

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
                    SizedBox(height: 4),
                    _buildInfoRow(
                        Icons.event, 'Akulipa kikao cha', displayMeetingInfo),
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
                          ? () => _updateUserStatusToPaid()
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
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
