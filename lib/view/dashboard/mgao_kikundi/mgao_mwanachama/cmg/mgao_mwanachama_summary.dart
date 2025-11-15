import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/view/pre_page/login_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class MgaoMwanachamaSummary extends StatefulWidget {
  final Map<String, dynamic> user;
  var mzungukoId;
  final bool isFromMgaoWanachama;

  MgaoMwanachamaSummary({
    Key? key,
    required this.user,
    this.mzungukoId,
    this.isFromMgaoWanachama = false,
  }) : super(key: key);
  @override
  State<MgaoMwanachamaSummary> createState() => _MgaoMwanachamaSummaryState();
}

class _MgaoMwanachamaSummaryState extends State<MgaoMwanachamaSummary> {
  double _akibaLazimaTotal = 0;
  double _akibaHiariTotal = 0;
  bool _hasUnpaidLoan = false;
  bool _hasUnpaidFaini = false;
  double _unpaidLoanAmount = 0.0;
  double _unpaidFainiAmount = 0.0;
  double jumlaFedha = 0.0;

  Future<void> _fetchAkibaLazimaForMeeting() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();

      final result = await akibaLazimaModel
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Fetched Akiba Lazima Data: $result');

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['amount'] ?? 0) as double)
              .fold(0, (prev, element) => prev + element)
          : 0;

      print('Akiba Lazima Total Sum: $sum');

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

  Future<void> _fetchAkibaHiariForMeeting() async {
    try {
      final akibaHiariModel = AkibaHiari();
      final result = await akibaHiariModel
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
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

  Future<bool> checkUnpaidLoanAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('unpaidAmount', '>', 0)
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalUnpaidAmount = 0.0;
      for (var record in results) {
        totalUnpaidAmount += record['unpaidAmount'] ?? 0.0;
      }

      print('Total Unpaid Amount: $totalUnpaidAmount');
      setState(() {
        _unpaidLoanAmount = totalUnpaidAmount;
      });
      return totalUnpaidAmount > 0;
    } catch (e) {
      print('Error checking unpaid mkopo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking unpaid amount')),
      );
      return false;
    }
  }

  Future<bool> checkUnpaidFaini() async {
    try {
      final userFainiModel = UserFainiModel();
      print('Querying unpaid faini for mzungukoId: ${widget.mzungukoId}');

      final results = await userFainiModel
          .where('unpaidfaini', '>', 0)
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Results count: ${results.length}');

      double totalUnpaidFaini = 0.0;

      for (var record in results) {
        print('Raw Record: $record');

        totalUnpaidFaini += record['unpaidfaini'] ?? 0.0;
        print('User Faini Data:');
        print('User ID: ${record['userId']}');
        print('Unpaid Faini: ${record['unpaidfaini']}');
        print('Mzunguko ID: ${record['mzungukoId']}');
        print('Fine ID: ${record['fainiId']}');
        print('-----------------------------------');
      }

      setState(() {
        _unpaidFainiAmount = totalUnpaidFaini;
      });

      await getTotalMgao();

      print('Total Unpaid Faini: $totalUnpaidFaini');
      return totalUnpaidFaini > 0;
    } catch (e) {
      print('Error checking unpaid faini: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking unpaid faini')),
      );
      return false;
    }
  }

  getTotalMgao() {
    double total = _akibaLazimaTotal +
        _akibaHiariTotal -
        _unpaidFainiAmount -
        _unpaidLoanAmount;
    setState(() {
      jumlaFedha = total;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAkibaLazimaForMeeting().then((_) {
      _fetchAkibaHiariForMeeting().then((_) {
        checkUnpaidLoanAmount().then((hasUnpaidLoan) {
          setState(() {
            _hasUnpaidLoan = hasUnpaidLoan;
          });
          checkUnpaidFaini().then((hasUnpaidFaini) {
            setState(() {
              _hasUnpaidFaini = hasUnpaidFaini;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(jumlaFedha);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberShareout,
        subtitle: l10n.summary,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person, size: 28),
                      radius: 24,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.memberNameLabel(widget.user['name']),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l10n.phoneNumberLabel(widget.user['phone']),
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l10n.memberNumberLabel(widget.user['memberNumber']),
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.savings, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text(
                          l10n.savings,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    buildSummaryRow(l10n.totalMandatorySavings, _akibaLazimaTotal.toStringAsFixed(0)),
                    Divider(),
                    buildSummaryRow(l10n.totalVoluntarySavings, _akibaHiariTotal.toStringAsFixed(0)),
                    Divider(),
                    if (_hasUnpaidLoan)
                      buildSummaryRow(
                        l10n.unpaidLoanAmount,
                        (_unpaidLoanAmount).toStringAsFixed(0),
                        isBold: true,
                        isRed: true,
                      ),
                    if (_hasUnpaidFaini)
                      buildSummaryRow(
                        l10n.unpaidFineAmount,
                        (_unpaidFainiAmount).toStringAsFixed(0),
                        isBold: true,
                        isRed: true,
                      ),
                    if (_hasUnpaidFaini) Divider(),
                    jumlaFedha < 0
                        ? buildSummaryRow(
                            l10n.memberOwesAmount,
                            (-jumlaFedha).toStringAsFixed(0),
                            isBold: true,
                            isRed: true,
                          )
                        : buildSummaryRow(
                            l10n.totalShareoutAmount,
                            jumlaFedha.toStringAsFixed(0),
                            isBold: true,
                          ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.continueText,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                          user: widget.user,
                          mzungukoId: widget.mzungukoId,
                          withdrawAmount: (_akibaLazimaTotal + _akibaHiariTotal)
                              .toStringAsFixed(0),
                          isFromMgaoWanachama: true)),
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

  Widget buildSummaryRow(String label, String value,
      {bool isBold = false, bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            formatCurrency(double.tryParse(value) ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isRed ? Colors.red : null, // Red color for unpaid amounts
            ),
          ),
        ],
      ),
    );
  }
}
