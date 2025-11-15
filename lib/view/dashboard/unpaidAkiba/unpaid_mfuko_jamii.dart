import 'dart:math';

import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class UnpaidUchangaajiMfukoJamiiPage extends StatefulWidget {
  final int? mzungukoId;
  final bool isFromMgaowakikundi;
  final bool isFromUchangiaji;

  UnpaidUchangaajiMfukoJamiiPage({
    Key? key,
    this.mzungukoId,
    this.isFromMgaowakikundi = false,
    this.isFromUchangiaji = false,
  }) : super(key: key);

  @override
  _UnpaidUchangaajiMfukoJamiiPageState createState() =>
      _UnpaidUchangaajiMfukoJamiiPageState();
}

class _UnpaidUchangaajiMfukoJamiiPageState
    extends State<UnpaidUchangaajiMfukoJamiiPage> {
  List<UchangaajiMfukoJamiiModel> unpaidUsers = [];
  Map<int, GroupMembersModel> userDetails = {};
  Map<int, String> meetingDetails = {};
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
      final katibaModel = MfukoJamiiModel();
      final katiba = await katibaModel
          .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
          .where('mzungukoid', '=', widget.mzungukoId)
          .first();
      if (katiba != null) {
        setState(() {
          _fixedAmount = int.parse(katiba.toMap()['value'] ?? '0');
        });
      } else {
        print("No Katiba value found for 'uchangaaji_mfuko_jamii'.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Hakuna kiasi kilichobainishwa kwa uchangiaji wa mfuko jamii.')),
        );
      }
    } catch (e) {
      print('Error fetching Katiba amount: $e');
    }
  }

  Future<void> _fetchUnpaidUsers() async {
    try {
      final result = await UchangaajiMfukoJamiiModel()
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('paid_status', '=', 'unpaid')
          .select();
      List<UchangaajiMfukoJamiiModel> fetchedUsers = result
          .map((map) => UchangaajiMfukoJamiiModel().fromMap(map))
          .toList();
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

  Future<void> _updateUserStatusToPaid(int userId) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      final userRecord =
          unpaidUsers.firstWhere((user) => user.userId == userId);
      userRecord.paidStatus = 'paid';
      userRecord.total = _fixedAmount.toDouble();

      await UchangaajiMfukoJamiiModel()
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .update({'paid_status': 'paid', 'total': _fixedAmount});

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.unpaidContributionsTitle,
        subtitle: l10n.unpaidContributionsSubtitle,
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
                  Text(l10n.loadingData,
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
                      buttonText: l10n.doneButton,
                      onPressed: () async {
                        if (widget.isFromMgaowakikundi) {
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
    final l10n = AppLocalizations.of(context)!;
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
              l10n.contributionSummary,
              style: TextStyle(
                color: Color.fromARGB(255, 4, 34, 207),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              l10n.communityFund,
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
                    l10n.totalMembers,
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
                    l10n.totalLoan,
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
      padding: const EdgeInsets.symmetric(
          horizontal: 4.0), // Reduced padding from 8.0 to 4.0
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Added to prevent overflow
            children: [
              Icon(icon,
                  color: iconColor, size: 16), // Reduced size from 18 to 16
              SizedBox(width: 4), // Reduced width from 6 to 4
              Flexible(
                // Added Flexible to allow text to wrap
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13, // Reduced from 14 to 13
                  ),
                  overflow: TextOverflow.ellipsis, // Added overflow handling
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15, // Reduced from 16 to 15
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis, // Added overflow handling
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.noUnpaidMemberJamii,
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
            buttonText: l10n.doneButton,
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
    final l10n = AppLocalizations.of(context)!;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: unpaidUsers.length,
      itemBuilder: (context, index) {
        final user = unpaidUsers[index];
        final userInfo = userDetails[user.userId];
        final meetingInfo = meetingDetails[user.meetingId ?? 0] ?? 'N/A';
        final displayMeetingInfo =
            meetingInfo == 'N/A' ? l10n.midCycleInfo : meetingInfo;

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
                    _buildInfoRow(Icons.badge, l10n.memberNumber,
                        userInfo?.memberNumber ?? 'N/A'),
                    SizedBox(height: 4),
                    _buildInfoRow(
                        Icons.phone, 'Simu', userInfo?.phone ?? 'N/A'),
                    SizedBox(height: 4),
                    _buildInfoRow(
                        Icons.event, l10n.dueMeeting, displayMeetingInfo),
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
                                l10n.socialFundDueAmount(
                                    formatCurrency(_fixedAmount, Provider.of<CurrencyProvider>(context).currencyCode)),
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
                                      ? l10n.pay
                                      : l10n.alreadyPaid,
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
