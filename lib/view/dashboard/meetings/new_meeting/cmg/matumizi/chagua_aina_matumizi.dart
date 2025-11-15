import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/thibitisha_matumizi.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class AinaMatumiziPage extends StatefulWidget {
  var meetingId;
  var mfukoType;
  var mzungukoId;

  AinaMatumiziPage(
      {super.key, this.meetingId, this.mfukoType, this.mzungukoId});

  @override
  _AinaMatumiziPageState createState() => _AinaMatumiziPageState();
}

class _AinaMatumiziPageState extends State<AinaMatumiziPage> {
  final TextEditingController specificUsageController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedOption;
  String? specificUsageError;
  String? amountError;

  final List<String> matumiziItems = [
    "Shajara (Stationery)",
    "Viburudisho",
    "Malipo ya mkopo",
    "Muda wa maongezi (Vocha)",
    "Teknolojia",
    "Bidhaa za Biashara",
    "Usafiri",
    "Gharama za Benki",
    "Mengineyo"
  ];

  void _navigateToNextPage() {
    setState(() {
      specificUsageError = specificUsageController.text.isEmpty
          ? 'Tafadhali ingiza matumizi husika.'
          : null;
      amountError =
          amountController.text.isEmpty ? 'Tafadhali ingiza kiasi.' : null;
    });

    if (specificUsageError != null ||
        amountError != null ||
        selectedOption == null) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ThibitishaMatumiziPage(
          meetingId: widget.meetingId,
          matumiziCategory: selectedOption!,
          specificUsage: specificUsageController.text,
          amount: double.tryParse(amountController.text) ?? 0.0,
          mfukoType: widget.mfukoType,
          mzungukoId: widget.mzungukoId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.expense,
        subtitle: l10n.chooseUsageType,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              l10n.chooseUsageType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: matumiziItems.length,
                itemBuilder: (context, index) {
                  final item = matumiziItems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: Text(l10n.usageType(item)),
                        value: item,
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value;
                            specificUsageController.clear();
                            amountController.clear();
                            specificUsageError = null;
                            amountError = null;
                          });
                        },
                      ),
                      if (selectedOption == item) ...[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 10.0),
                          child: Text(
                            l10n.specificUsage,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: specificUsageController,
                                decoration: InputDecoration(
                                  labelText: l10n.enterSpecificUsage,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              if (specificUsageError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    l10n.pleaseEnterSpecificUsage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 10.0),
                          child: Text(
                            l10n.amount,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: l10n.enterAmount,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              if (amountError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    l10n.pleaseEnterAmount,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.next,
              onPressed: _navigateToNextPage,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
