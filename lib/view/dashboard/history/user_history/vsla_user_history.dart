import 'package:chomoka/Service/sms_server.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart'; // Add this import for share value
import 'package:chomoka/widget/widget.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class VslaUserHistory extends StatefulWidget {  
  final Map<String, dynamic> user;
  final int mzungukoId;

  const VslaUserHistory({
    required this.user,
    required this.mzungukoId,
    Key? key,
  }) : super(key: key);

  @override
  State<VslaUserHistory> createState() => _VslaUserHistoryState();
}

class _VslaUserHistoryState extends State<VslaUserHistory> {
  late Future<List<Map<String, dynamic>>> _meetingsFuture;

  double _mfukoJamiiTotal = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;

  // Add these variables for shares
  int _totalSharesCount = 0;
  double _shareValue = 0;
  double _totalSharesValue = 0;

  @override
  void initState() {
    super.initState();
    _meetingsFuture = _fetchMeetings(widget.mzungukoId);
  }

  // Update the method to fetch the share value from katiba
  Future<void> _fetchShareValue() async {
    try {
      await BaseModel.initAppDatabase();

      final katibaModel = KatibaModel();

      // First try to get the share_value directly
      var shareValueData = await katibaModel
          .where('katiba_key', '=', 'share_value')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      // If share_value not found, check if we can get it from hisa_value
      if (shareValueData == null) {
        shareValueData = await katibaModel
            .where('katiba_key', '=', 'share_amount')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();
      }

      if (shareValueData != null && shareValueData is KatibaModel) {
        final value = shareValueData.value;
        if (value != null && value.isNotEmpty) {
          setState(() {
            _shareValue = double.tryParse(value) ?? 0;
          });
          print('Share value fetched successfully: $_shareValue');
        }
      } else {
        // If still not found, check the group type and use default values
        final groupTypeData = await katibaModel
            .where('katiba_key', '=', 'kanuni')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (groupTypeData != null && groupTypeData is KatibaModel) {
          final groupType = groupTypeData.value;
          if (groupType == 'VSLA') {
            // Default VSLA share value if not explicitly set
            setState(() {
              _shareValue = 2000.0;
            });
            print('Using default VSLA share value: $_shareValue');
          }
        }
      }
    } catch (e) {
      print('Error fetching share value: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchMeetings(int mzungukoId) async {
    try {
      await _fetchShareValue();

      final meetingModel = MeetingModel();
      final meetings = await meetingModel
          .where('mzungukoId', '=', mzungukoId)
          .where('status', '=', 'complete')
          .find();

      return meetings.map((meeting) => meeting.toMap()).toList();
    } catch (e) {
      print('Error fetching meetings: $e');
      return [];
    }
  }

  Future<void> _fetchMfukoJamiiForMeeting(int meetingId, int userId) async {
    try {
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final result = await uchangiajiMfukoJamiiModel
          .where('meeting_id', '=', meetingId) // Correct column name
          .where('user_id', '=', userId) // Correct column name
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['total'] ?? 0) as double)
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _mfukoJamiiTotal = sum;
      });
    } catch (e) {
      print('Error fetching Mfuko Jamii total: $e');
      setState(() {
        _mfukoJamiiTotal = 0;
      });
    }
  }

  Future<void> _fetchMkopoWasasaForMeeting(int meetingId, int userId) async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final result = await rejeshaMkopoModel
          .where('meeting_id', '=', meetingId)
          .where('user_id', '=', userId)
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['unpaidAmount'] ?? 0).toDouble())
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _mkopoWasasaTotal = sum;
      });
    } catch (e) {
      print('Error fetching Mkopo Wasasa total: $e');
      setState(() {
        _mkopoWasasaTotal = 0;
      });
    }
  }

  Future<void> _fetchFainiForMeeting(int meetingId, int userId) async {
    try {
      final userFainiModel = UserFainiModel();
      final result = await userFainiModel
          .where('meeting_id', '=', meetingId)
          .where('user_id', '=', userId)
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['unpaidfaini'] ?? 0).toDouble())
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _fainiTotal = sum;
      });
    } catch (e) {
      print('Error fetching Faini total: $e');
      setState(() {
        _fainiTotal = 0;
      });
    }
  }

  // Update the _fetchSharesForMeeting method to use the fetched share value
  Future<void> _fetchSharesForMeeting(int meetingId, int userId) async {
    try {
      await BaseModel.initAppDatabase();

      final memberShareModel = MemberShareModel();
      final shares = await memberShareModel
          .where('meeting_id', '=', meetingId)
          .where('user_id', '=', userId)
          .select();

      int totalShares = 0;
      if (shares.isNotEmpty) {
        totalShares = shares
            .map((share) => (share['number_of_shares'] ?? 0) as int)
            .fold(0, (prev, count) => prev + count);
      }

      setState(() {
        _totalSharesCount = totalShares;
        _totalSharesValue = totalShares * _shareValue;
      });

      print(
          'Total shares for user $userId in meeting $meetingId: $_totalSharesCount worth $_totalSharesValue');
    } catch (e) {
      print('Error fetching shares for user $userId in meeting $meetingId: $e');
      setState(() {
        _totalSharesCount = 0;
        _totalSharesValue = 0;
      });
    }
  }

  void _sendSms(int meetingId) async {
    String? phoneNumber = widget.user['phone'];

    if (phoneNumber == null || phoneNumber.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.mwanachamaSiSimu),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    String message = """
Ndugu ${widget.user['name']},

Muhtasari wa kikao cha ${meetingId} ni:-

Jumla ya Hisa: ${_totalSharesCount} (TZS ${formatCurrency(_totalSharesValue.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)})
Mfuko Jamii: TZS ${formatCurrency(_mfukoJamiiTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Mkopo wa Sasa: TZS ${formatCurrency(_mkopoWasasaTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Faini: TZS ${formatCurrency(_fainiTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
""";

    print(message);

    try {
      var sendSms = SmsService([phoneNumber], message);
      await sendSms.sendSms();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!
              .muhtasariUmetumwa(widget.user['name'])),
          backgroundColor: Colors.black,
        ),
      );
    } catch (e) {
      print("Error sending SMS: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.imeshindwaTumaSMS),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  // Update the _buildAmountDescription method to support subtitle
  Widget _buildAmountDescription(
      String description, double amount, IconData icon,
      {String? subtitle}) {
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  formatCurrency(amount, currencyCode),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle.replaceAll('TZS', currencyCode),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting) {
    final l10n = AppLocalizations.of(context)!;
    final createdAt = meeting['date'];
    String formattedDate;
    String formattedTime;

    try {
      if (createdAt != null && createdAt.isNotEmpty) {
        final dateTime = DateTime.parse(createdAt);
        formattedDate = DateFormat('EEEE, d MMMM yyyy').format(dateTime);
        formattedTime = DateFormat('HH:mm').format(dateTime);
      } else {
        formattedDate = 'Tarehe Haijulikani';
        formattedTime = '';
      }
    } catch (e) {
      print('Error formatting date: $e');
      formattedDate = 'Tarehe Haijulikani';
      formattedTime = '';
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: () {
          final userId = widget.user['id'];
          final meetingId = meeting['id'];
          _showTotalsModal(context, meetingId, userId);
        },
        child: ListTile(
          leading: Icon(Icons.meeting_room, color: Colors.blue),
          title: Text(
            '${l10n.kikao} ${meeting['number'] ?? 'N/A'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Text(
                formattedTime.isEmpty
                    ? AppLocalizations.of(context)!.haijulikani
                    : 'Saa $formattedTime',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTotalsModal(BuildContext context, int meetingId, int userId) async {
    await _fetchShareValue();

    await Future.wait([
      _fetchMfukoJamiiForMeeting(meetingId, userId),
      _fetchMkopoWasasaForMeeting(meetingId, userId),
      _fetchFainiForMeeting(meetingId, userId),
      _fetchSharesForMeeting(meetingId, userId),
    ]);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.muhtasariKikao,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${AppLocalizations.of(context)!.kikao} ${meetingId} - ${widget.user['name']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildAmountDescription(
                          AppLocalizations.of(context)!.jumlaYaAkiba,
                          _totalSharesValue, Icons.account_balance_wallet,
                          subtitle:
                              '$_totalSharesCount @ ${formatCurrency(_shareValue.toInt(), Provider.of<CurrencyProvider>(context).currencyCode)}'),
                      _buildAmountDescription(
                          AppLocalizations.of(context)!.jumla_mfuko_jamii,
                          _mfukoJamiiTotal, Icons.group_add),
                      _buildAmountDescription(
                          AppLocalizations.of(context)!.toa_mkopo,
                          _mkopoWasasaTotal, Icons.money),
                      _buildAmountDescription(
                          AppLocalizations.of(context)!.fainiPageTitle,
                          _fainiTotal, Icons.warning),
                    ],
                  ),
                ),
                Divider(height: 1),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          AppLocalizations.of(context)!.funga,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _sendSms(meetingId),
                        child: Text(
                          AppLocalizations.of(context)!.tumaMuhtasari,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.historiaYa(user['name']),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _meetingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to fetch meetings.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(AppLocalizations.of(context)!.hakuna_vikao));
            } else {
              final meetings = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...meetings
                      .map((meeting) => _buildMeetingCard(meeting))
                      .toList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
