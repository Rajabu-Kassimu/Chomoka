import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/list_uchangaji.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class UwekajiAinaUchangiajiPage extends StatefulWidget {
  final int meetingId; // Required meeting ID
  var mzungukoId;
  var mfukoType;
  UwekajiAinaUchangiajiPage(
      {super.key,
      required this.meetingId,
      required this.mzungukoId,
      this.mfukoType});

  @override
  _UwekajiAinaUchangiajiPageState createState() =>
      _UwekajiAinaUchangiajiPageState();
}

class _UwekajiAinaUchangiajiPageState extends State<UwekajiAinaUchangiajiPage> {
  String? selectedOption;
  TextEditingController amountController = TextEditingController();
  String? errorText;

  Future<void> _updateAinaUchangiajiAndAmount() async {
    if (selectedOption == null) {
      setState(() {
        errorText = 'Tafadhali chagua aina ya uchangiaji.';
      });
      return;
    }

    if (amountController.text.isEmpty) {
      setState(() {
        errorText = 'Tafadhali ingiza kiasi.';
      });
      return;
    }

    double? amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        errorText = 'Tafadhali ingiza kiasi halali.';
      });
      return;
    }

    try {
      // Create new record
      final uwekajiModel = UwekajiKwaMkupuoModel();
      final id = await uwekajiModel.create();

      Map<String, dynamic> updateData = {
        'meetingId': widget.meetingId,
        'ainaUchangiaji': selectedOption,
        'amount': amount,
        'mzungukoId': widget.mzungukoId,
        'mfukoType': widget.mfukoType,
        'status': 'complete',
      };

      await uwekajiModel.where('id', '=', id).update(updateData);

      // Print saved data
      print('Saved Data: ID=$id, ${updateData.toString()}');

      setState(() {
        errorText = null;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MichangoListPage(
            meetingId: widget.meetingId,
            mzungukoId: widget.mzungukoId,
          ),
        ),
      );
    } catch (e) {
      print('Error saving data: $e');
      setState(() {
        errorText = 'Kuna tatizo lililotokea wakati wa kuhifadhi data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.bulkSaving,
        subtitle: l10n.chooseContributionType,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.chooseContributionType,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListTile(
              title: Text(l10n.donationContribution),
              leading: Radio<String>(
                value: l10n.donationContribution,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    errorText = null; // Reset error on selection
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text(l10n.businessProfit),
              leading: Radio<String>(
                value: l10n.businessProfit,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    errorText = null; // Reset error on selection
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text(l10n.loanDisbursement),
              leading: Radio<String>(
                value: l10n.loanDisbursement,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    errorText = null; // Reset error on selection
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text(l10n.other),
              leading: Radio<String>(
                value: l10n.other,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    errorText = null; // Reset error on selection
                  });
                },
              ),
            ),
            if (selectedOption != null) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  l10n.enterAmountFor(selectedOption!),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.amount,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              if (errorText != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    errorText!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ],
            ],
            SizedBox(height: 20),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.next,
              onPressed: _updateAinaUchangiajiAndAmount,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
