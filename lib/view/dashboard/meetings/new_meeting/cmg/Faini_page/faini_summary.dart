import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/piga_faini.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/FainiModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class FainiSummaryPage extends StatefulWidget {
  final int meetingId;
  final int userId;
  var mzungukoId;

  FainiSummaryPage(
      {required this.meetingId, required this.userId, this.mzungukoId});

  @override
  _FainiSummaryPageState createState() => _FainiSummaryPageState();
}

class _FainiSummaryPageState extends State<FainiSummaryPage> {
  Map<String, dynamic>? _userDetails;
  List<Map<String, dynamic>> _userFines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFainiForUser();
  }

  Future<void> _fetchFainiForUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch user details
      final member =
          await GroupMembersModel().where('id', '=', widget.userId).first();
      final userDetails = member?.toMap() ??
          {
            'name': 'Jina lisiloelezwa',
            'phone': 'Simu haijulikani',
          };

      final userFainiModel = UserFainiModel();
      final userFainiRecords = await userFainiModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', widget.userId)
          .where('unpaidfaini', '>', 0)
          .find();

      List<Map<String, dynamic>> userFines = [];
      for (var record in userFainiRecords) {
        final userFaini = record as UserFainiModel;

        // Fetch fine details
        final fine =
            await FainiModel().where('id', '=', userFaini.fainiId).first();
        final fineDetails = fine?.toMap() ?? {};

        userFines.add({
          'fineName': fineDetails['penalties_name'] ?? 'Faini isiyoelezwa',
          'finePrice': fineDetails['penalties_price'] ?? '0',
          'unpaidAmount':
              userFaini.toMap()['unpaidfaini'] ?? '0', // Add unpaid amount
        });
      }

      setState(() {
        _userDetails = userDetails;
        _userFines = userFines;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching fines for user: $e');
      setState(() {
        _userDetails = null;
        _userFines = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia data.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.pigaFainiTitle,
        subtitle: l10n.fainiSummarySubtitle,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // User Details Card
                if (_userDetails != null)
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Circular Avatar with User Initials
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                (_userDetails!['name'] ?? 'M')
                                    .toString()
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            // User Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _userDetails!['name'] ?? l10n.unknownName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    l10n.memberPhone(_userDetails!['phone'] ??
                                        l10n.unknownPhone),
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
                  ),
                // Fines List or Empty State
                Expanded(
                  child: _userFines.isEmpty
                      ? Center(
                          child: Text(
                            l10n.noFines,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _userFines.length,
                          itemBuilder: (context, index) {
                            final fine = _userFines[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    // Fine Icon
                                    Icon(
                                      Icons.gavel,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                    SizedBox(width: 16),
                                    // Fine Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.fineTypes(fine['fineName']),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            l10n.fineAmount(formatCurrency(double.tryParse(fine['finePrice'] ?? '0') ?? 0, Provider.of<CurrencyProvider>(context).currencyCode)),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // Navigation Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.backToFines,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PigaFainiPage(
                            meetingId: widget.meetingId,
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
    );
  }
}
