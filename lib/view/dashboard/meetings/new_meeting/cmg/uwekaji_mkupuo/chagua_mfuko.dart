import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/aina_uchangiaji.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class UwekajiKwaMkupuoPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  UwekajiKwaMkupuoPage({super.key, required this.meetingId, this.mzungukoId});

  @override
  _UwekajiKwaMkupuoPageState createState() => _UwekajiKwaMkupuoPageState();
}

class _UwekajiKwaMkupuoPageState extends State<UwekajiKwaMkupuoPage> {
  String? selectedMfuko;
  String? errorText;
  double totalContributions = 0;
  bool isLoading = true;

  // Future<void> _saveMfukoType() async {
  //   if (selectedMfuko == null) {
  //     setState(() {
  //       errorText = 'Tafadhali chagua mfuko kabla ya kuendelea.';
  //     });
  //     return;
  //   }

  //   try {
  //     final uwekajiModel = UwekajiKwaMkupuoModel(
  //       meetingId: widget.meetingId,
  //       mfukoType: selectedMfuko,
  //     );

  //     await uwekajiModel.create(); // Save data to the database

  //     setState(() {
  //       errorText = null; // Clear the error message after saving
  //     });

  //     // Navigate to the next page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => UwekajiAinaUchangiajiPage(
  //           meetingId: widget.meetingId,
  //           mzungukoId: widget.mzungukoId,
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     setState(() {
  //       errorText = 'Kuna tatizo lililotokea wakati wa kuhifadhi mfuko.';
  //     });
  //   }
  // }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      // Calculate total amount
      double totalAmount = 0;
      for (var contribution in results) {
        // Safely handle null amounts by using null-aware operator
        final amount = contribution['amount'];
        if (amount != null) {
          totalAmount += (amount as num).toDouble();
        }
      }

      setState(() {
        totalContributions = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchContributions();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.bulkSaving,
        subtitle: l10n.chooseFund,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalContributionsForCycle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Handle text overflow
                            maxLines: 2,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    SizedBox(width: 16), // Add spacing between the columns
                    Text(
                      formatCurrency(totalContributions, Provider.of<CurrencyProvider>(context).currencyCode),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow for value
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              l10n.chooseFundToContribute,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            RadioListTile<String>(
              value: l10n.mainGroupFund,
              groupValue: selectedMfuko,
              onChanged: (value) {
                setState(() {
                  selectedMfuko = value;
                  errorText = null; // Clear the error when a selection is made
                });
              },
              title: Text(l10n.mainGroupFund),
              activeColor: Colors.blue,
            ),
            RadioListTile<String>(
              value: l10n.socialFund,
              groupValue: selectedMfuko,
              onChanged: (value) {
                setState(() {
                  selectedMfuko = value;
                  errorText = null; // Clear the error when a selection is made
                });
              },
              title: Text(l10n.socialFund),
              activeColor: Colors.blue,
            ),
            if (errorText != null) // Display error text conditionally
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  l10n.pleaseChooseFund,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            Spacer(),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.next,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UwekajiAinaUchangiajiPage(
                      meetingId: widget.meetingId,
                      mzungukoId: widget.mzungukoId,
                      mfukoType: selectedMfuko,
                    ),
                  ),
                );
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
