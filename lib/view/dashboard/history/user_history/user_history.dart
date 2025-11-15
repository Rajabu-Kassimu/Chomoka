import 'package:chomoka/Service/sms_server.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class UserHistory extends StatefulWidget {
  final Map<String, dynamic> user;
  final int mzungukoId;

  const UserHistory({
    required this.user,
    required this.mzungukoId,
    Key? key,
  }) : super(key: key);

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  late Future<List<Map<String, dynamic>>> _meetingsFuture;

  double _akibaLazimaTotal = 0;
  double _akibaHiariTotal = 0;
  double _mfukoJamiiTotal = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;

  @override
  void initState() {
    super.initState();
    _meetingsFuture = _fetchMeetings(widget.mzungukoId);
  }

  Future<List<Map<String, dynamic>>> _fetchMeetings(int mzungukoId) async {
    try {
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

  Future<void> _fetchAkibaLazimaForMeeting(int meetingId, int userId) async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();
      final result = await akibaLazimaModel
          .where('meeting_id', '=', meetingId)
          .where('user_id', '=', userId)
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['amount'] ?? 0) as double)
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _akibaLazimaTotal = sum;
      });
    } catch (e) {
      print('Error fetching Akiba Lazima total: $e');
      setState(() {
        _akibaLazimaTotal = 0;
      });
    }
  }

  Future<void> _fetchAkibaHiariForMeeting(int meetingId, int userId) async {
    try {
      final akibaHiariModel = AkibaHiari();
      final result = await akibaHiariModel
          .where('meeting_id', '=', meetingId)
          .where('user_id', '=', userId)
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['amount'] ?? 0).toDouble())
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _akibaHiariTotal = sum;
      });
    } catch (e) {
      print('Error fetching Akiba Hiari total: $e');
      setState(() {
        _akibaHiariTotal = 0;
      });
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

Muhtasari wa kikao cha $meetingId ni:-

Akiba Lazima: ${formatCurrency(_akibaLazimaTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Akiba Hiari: ${formatCurrency(_akibaHiariTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Mfuko Jamii: ${formatCurrency(_mfukoJamiiTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Mkopo wa Sasa: ${formatCurrency(_mkopoWasasaTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Faini: ${formatCurrency(_fainiTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
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

  void _showTotalsModal(BuildContext context, int meetingId, int userId) async {
    await Future.wait([
      _fetchAkibaLazimaForMeeting(meetingId, userId),
      _fetchAkibaHiariForMeeting(meetingId, userId),
      _fetchMfukoJamiiForMeeting(meetingId, userId),
      _fetchMkopoWasasaForMeeting(meetingId, userId),
      _fetchFainiForMeeting(meetingId, userId),
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
                        '${AppLocalizations.of(context)!.kikao} $meetingId - ${widget.user['name']}',
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
                          AppLocalizations.of(context)!.akiba_wanachama,
                          _akibaLazimaTotal,
                          Icons.account_balance_wallet),
                      _buildAmountDescription(
                          AppLocalizations.of(context)!.akiba_binafsi,
                          _akibaHiariTotal,
                          Icons.account_balance),
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

  Widget _buildAmountDescription(
      String description, double amount, IconData icon) {
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
