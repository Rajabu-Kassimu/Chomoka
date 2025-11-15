import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/list_matumizi.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class ThibitishaMatumiziPage extends StatefulWidget {
  final int meetingId;
  final String matumiziCategory;
  final String specificUsage;
  final double amount;
  final String mfukoType;
  var mzungukoId;

  ThibitishaMatumiziPage({
    Key? key,
    required this.meetingId,
    required this.matumiziCategory,
    required this.specificUsage,
    required this.amount,
    required this.mfukoType,
    this.mzungukoId,
  }) : super(key: key);

  @override
  _ThibitishaMatumiziPageState createState() => _ThibitishaMatumiziPageState();
}

class _ThibitishaMatumiziPageState extends State<ThibitishaMatumiziPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.expense,
        subtitle: l10n.confirmExpense,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(l10n.expenseFund),
                subtitle: Text(widget.mfukoType),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(l10n.expenseTypeLabel.toString()),
                subtitle: Text(widget.matumiziCategory),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(l10n.specificUsage),
                subtitle: Text(widget.specificUsage),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(l10n.amount),
                subtitle: Text("TZS ${widget.amount.toStringAsFixed(0)}"),
              ),
            ),
            const Spacer(),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.save,
              onPressed: _saveData,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData() async {
    try {
      // Save data to the database
      final newMatumizi = MatumiziModel(
        meetingId: widget.meetingId,
        matumiziCategory: widget.matumiziCategory,
        matumizi: widget.specificUsage,
        amount: widget.amount,
        mfukoType: widget.mfukoType,
        mzungukoId: widget.mzungukoId,
        status: 'complete',
      );

      await newMatumizi.create();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Matumizi yamefanikiwa!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MatumiziSummaryPage(
            meetingId: widget.meetingId,
            mzungukoId: widget.mzungukoId,
          ),
        ),
      );
    } catch (e) {
      print('Error saving Matumizi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Imeshindikana kuhifadhi matumizi.")),
      );
    }
  }
}
