import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/chagua_aina_matumizi.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MatumiziChaguaMfuko extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  MatumiziChaguaMfuko({super.key, required this.meetingId, this.mzungukoId});

  @override
  _MatumiziChaguaMfukoState createState() => _MatumiziChaguaMfukoState();
}

class _MatumiziChaguaMfukoState extends State<MatumiziChaguaMfuko> {
  String? selectedMfuko;
  String? errorText;

  void _navigateToNextPage() {
    if (selectedMfuko == null) {
      setState(() {
        errorText = 'Tafadhali chagua mfuko wa matumizi.';
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AinaMatumiziPage(
          meetingId: widget.meetingId,
          mfukoType: selectedMfuko!,
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
        subtitle: l10n.chooseFund,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            // Title
            Text(
              l10n.chooseFundToContribute,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // Radio List Tiles for Fund Selection
            RadioListTile<String>(
              value: l10n.mainGroupFund,
              groupValue: selectedMfuko,
              onChanged: (value) {
                setState(() {
                  selectedMfuko = value;
                  errorText = null; // Clear error text on selection
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
                  errorText = null; // Clear error text on selection
                });
              },
              title: Text(l10n.socialFund),
              activeColor: Colors.blue,
            ),

            if (errorText != null) ...[
              SizedBox(height: 8),
              Text(
                l10n.pleaseChooseFund,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],

            Spacer(),

            // Bottom Buttons
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
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
