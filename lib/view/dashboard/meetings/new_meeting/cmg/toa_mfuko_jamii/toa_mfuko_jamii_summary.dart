import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/toa_mfuko_jamii.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ToaMfukoJamiiSummary extends StatefulWidget {
  final Map<String, dynamic>? userId;
  var meetingId;
  final String? selectedSababu;
  final String? sababuLimitAmount;
  final String? sababu;
  var mzungukoId;
  final double amount;
  final double mfukoJamiiTotal;

  ToaMfukoJamiiSummary({
    this.selectedSababu,
    this.userId,
    this.meetingId,
    this.sababuLimitAmount,
    this.mzungukoId,
    required this.amount,
    required this.mfukoJamiiTotal,
    required this.sababu,
  });

  @override
  _ToaMfukoJamiiSummaryState createState() => _ToaMfukoJamiiSummaryState();
}

class _ToaMfukoJamiiSummaryState extends State<ToaMfukoJamiiSummary> {
  String? _selectedOption;
  int _totalAkiba = 0;
  bool isLoading = false;
  TextEditingController _amountController = TextEditingController();

  void _proceed() async {
    // Create and populate the ToaMfukoJamiiModel
    ToaMfukoJamiiModel toaMfukoJamiiModel = ToaMfukoJamiiModel(
      userId: widget.userId?['id'],
      mzungukoId: widget.mzungukoId,
      meetingId: widget.meetingId,
      amount: widget.amount,
      sababu: widget.sababu,
    );

    try {
      int insertedId = await toaMfukoJamiiModel.create();
      print('Data saved with ID: $insertedId');

      final savedRecord =
          await ToaMfukoJamiiModel().where('id', '=', insertedId).findOne();
      if (savedRecord != null) {
        print('Saved Record: ${savedRecord.toMap()}');
      } else {
        print('Failed to retrieve the saved record.');
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ToaMfukoJamii(
            mzungukoId: widget.mzungukoId,
            meetingId: widget.meetingId,
          ),
        ),
      );
    } catch (e) {
      // Handle errors if any
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mfuko_jamii,
        subtitle: l10n.thibitisha_utoaji_pesa,
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
                                        SizedBox(height: 4),
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
                            color: Colors.white, // Ensuring white background
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
                                        l10n.salio_la_sasa,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(widget.mfukoJamiiTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.sababu_ya_kutoa,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey, // Description grey
                                        ),
                                      ),
                                      Text(
                                        "${widget.sababu}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black, // Value bold black
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.kiasi_cha_kutoa,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey, // Description grey
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(widget.amount, Provider.of<CurrencyProvider>(context).currencyCode),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.salio_jipya,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey, // Description grey
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(widget.mfukoJamiiTotal - widget.amount, Provider.of<CurrencyProvider>(context).currencyCode),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
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
                    buttonText: l10n.confirm,
                    onPressed: _proceed,
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
    );
  }
}
