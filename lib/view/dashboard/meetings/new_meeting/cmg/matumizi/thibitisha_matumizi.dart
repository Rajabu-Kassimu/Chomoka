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
  String _localizeMatumiziItem(String item, AppLocalizations l10n) {
    switch (item) {
      case "Shajara (Stationery)":
        return l10n.matumziStationery;
      case "Viburudisho":
        return l10n.matumziRefreshment;
      case "Malipo ya mkopo":
        return l10n.matumziLoanPayment;
      case "Muda wa maongezi (Vocha)":
        return l10n.matumziCallTime;
      case "Teknolojia":
        return l10n.matumziTechnology;
      case "Bidhaa za Biashara":
        return l10n.matumiziMerchandise;
      case "Usafiri":
        return l10n.matumziTransport;
      case "Gharama za Benki":
        return l10n.matumiziBackCharges;
      case "Mengineyo":
        return l10n.matumziOther;
      default:
        return item;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizedCategory = _localizeMatumiziItem(widget.matumiziCategory, l10n);
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
                subtitle: Text(localizedCategory),
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
    final l10n = AppLocalizations.of(context)!;
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
        SnackBar(content: Text(l10n.dataSavedSuccessfully)),
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
        SnackBar(content: Text(l10n.errorSavingDataGeneric)),
      );
    }
  }
}
