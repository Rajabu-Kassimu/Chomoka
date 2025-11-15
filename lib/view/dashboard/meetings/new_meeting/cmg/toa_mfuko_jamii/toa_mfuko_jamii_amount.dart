import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/toa_mfuko_jamii_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ToaMfukoJamiiAmountPage extends StatefulWidget {
  final Map<String, dynamic>? userId;
  final int? meetingId;
  final String? selectedSababu;
  final String? sababuLimitAmount;
  final String? sababu;
  var mzungukoId;

  ToaMfukoJamiiAmountPage({
    this.selectedSababu,
    this.userId,
    this.meetingId,
    this.mzungukoId,
    this.sababuLimitAmount,
    this.sababu,
  });

  @override
  _ToaMfukoJamiiAmountPageState createState() =>
      _ToaMfukoJamiiAmountPageState();
}

class _ToaMfukoJamiiAmountPageState extends State<ToaMfukoJamiiAmountPage> {
  String? _selectedOption;
  double _totalAkiba = 0;
  double _previousMfukoJamiiBalance = 0; // New variable for previous balance
  bool isLoading = true;
  String? _errorText;
  TextEditingController _amountController = TextEditingController();

  Future<void> _fetchData() async {
    try {
      // Fetch current Mfuko Jamii data
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();

      uchangiajiMfukoJamiiModel.where('mzungukoId', '=', widget.mzungukoId);
      final contributionRecords = await uchangiajiMfukoJamiiModel.select();

      double totalContribution = contributionRecords.fold(0.0, (sum, record) {
        final amount = (record['total'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      toaMfukoJamiiModel.where('mzungukoId', '=', widget.mzungukoId);
      final withdrawalRecords = await toaMfukoJamiiModel.select();

      double totalWithdrawn = withdrawalRecords.fold(0.0, (sum, record) {
        final amount = (record['amount'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      double totalBalance = totalContribution - totalWithdrawn;

      // Fetch previous meeting's Mfuko Jamii balance
      await _fetchPreviousMfukoJamiiBalance();

      setState(() {
        _totalAkiba = totalBalance;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching total data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  // New method to fetch previous meeting's Mfuko Jamii balance
  Future<void> _fetchPreviousMfukoJamiiBalance() async {
    try {
      final vikaoModel = VikaovilivyopitaModel();
      final previousData = await vikaoModel
          .where('kikao_key', '=', 'mfuko_wa_jamii_salio')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (previousData != null && previousData is VikaovilivyopitaModel) {
        setState(() {
          _previousMfukoJamiiBalance =
              double.tryParse(previousData.value ?? '0') ?? 0.0;
        });
        print('Previous Mfuko Jamii balance: $_previousMfukoJamiiBalance');
      } else {
        print('No previous Mfuko Jamii balance found');
      }
    } catch (e) {
      print('Error fetching previous Mfuko Jamii balance: $e');
    }
  }

  void _proceed() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tafadhali chagua chaguo moja.")),
      );
      return;
    }

    double enteredAmount = 0.0;
    double maxLimit =
        double.tryParse(widget.sababuLimitAmount ?? '0') ?? double.infinity;

    if (_selectedOption == "kiasi_kingine") {
      enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

      if (enteredAmount <= 0) {
        setState(() {
          _errorText = "Kiasi lazima kiwe zaidi ya sifuri.";
        });
        return;
      }

      if (enteredAmount > maxLimit) {
        setState(() {
          _errorText =
              "Kiasi hakiwezi kuzidi kiwango cha juu cha kutoa: TZS $maxLimit.";
        });
        return;
      }

      if (enteredAmount > _totalAkiba) {
        setState(() {
          _errorText = "Kiasi hakiwezi kuzidi salio la sasa: TZS $_totalAkiba.";
        });
        return;
      }
    } else if (_selectedOption == "kiasi_chote") {
      enteredAmount = maxLimit;

      if (enteredAmount > _totalAkiba) {
        setState(() {
          _errorText =
              "Kiwango cha juu cha kutoa ni kikubwa kuliko salio la sasa.";
        });
        return;
      }
    }

    setState(() {
      _errorText = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToaMfukoJamiiSummary(
          userId: widget.userId,
          meetingId: widget.meetingId,
          selectedSababu: widget.selectedSababu,
          mzungukoId: widget.mzungukoId,
          amount: enteredAmount,
          mfukoJamiiTotal: _totalAkiba,
          sababu: widget.sababu,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mfuko_jamii,
        subtitle: l10n.chagua_kiwango_kutoa,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Information Card
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                          l10n.jina,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "${widget.userId?['name'] ?? 'Jina Lisiloeleweka'}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          l10n.memberNumber,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "${widget.userId?['memberNumber'] ?? 'Jina Lisiloeleweka'}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.sababu_ya_kutoa,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "${widget.sababu ?? 'N/A'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.kiwango_cha_juu,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(double.tryParse(widget.sababuLimitAmount ?? '0') ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.salio_la_sasa,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        formatCurrency((_totalAkiba + _previousMfukoJamiiBalance), Provider.of<CurrencyProvider>(context).currencyCode),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Add previous meeting's Mfuko Jamii balance
                                  // SizedBox(height: 10),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Salio la Mfuko Jamii (Kikao kilichopita):",
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       "TZS ${_previousMfukoJamiiBalance.toStringAsFixed(0)}",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.blue[800],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            l10n.chagua_kiwango_kutoa,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          RadioListTile<String>(
                            title: Text(l10n.toa_kiasi_chote),
                            subtitle: Text(formatCurrency(double.tryParse(widget.sababuLimitAmount ?? '0') ?? 0, Provider.of<CurrencyProvider>(context).currencyCode)),
                            value: "kiasi_chote",
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                                _amountController.clear();
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(l10n.toa_kiasi_kingine),
                            value: "kiasi_kingine",
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                          if (_selectedOption == "kiasi_kingine")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: l10n.ingiza_kiasi,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  if (_errorText != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _errorText!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    color: Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.continue_,
                    onPressed: _proceed,
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
    );
  }
}
