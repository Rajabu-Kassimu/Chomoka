import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/faini_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/FainiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class SelectFinesScreen extends StatefulWidget {
  final Map<String, dynamic> userId;
  final int meetingId;
  var mzungukoId;

  SelectFinesScreen(
      {required this.userId, required this.meetingId, this.mzungukoId});

  @override
  _SelectFinesScreenState createState() => _SelectFinesScreenState();
}

class _SelectFinesScreenState extends State<SelectFinesScreen> {
  List<FainiModel> _faini = [];
  int? selectedFineId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFainiData();
  }

  Future<void> _fetchFainiData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fainiModel = FainiModel();
      final fainiRecords =
          await fainiModel.where('mzungukoid', '=', widget.mzungukoId).find();

      // Filter valid fines and exclude specific fines
      final validFines =
          fainiRecords.map((record) => record as FainiModel).where((fine) {
        final amount = double.tryParse(fine.penaltiesPrice ?? '0') ?? 0;

        // Exclude specific fines
        final excludeFines = [
          'kachelewa',
          'hayupo bila ruhusa',
          'katuma mwakilishi'
        ];

        return amount > 0 &&
            !excludeFines.contains(fine.penaltiesName?.toLowerCase());
      }).toList();

      if (validFines.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Hakuna rekodi za faini zilizo na kiasi zaidi ya 0.')),
        );
        setState(() {
          _faini = [];
          isLoading = false;
        });
        return;
      }

      setState(() {
        _faini = validFines;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching fines: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.')),
      );
      setState(() {
        _faini = [];
        isLoading = false;
      });
    }
  }

  Future<void> _saveFine() async {
    if (selectedFineId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tafadhali chagua faini.')),
      );
      return;
    }

    try {
      final selectedFine =
          _faini.firstWhere((fine) => fine.id == selectedFineId);
      final unpaidAmount =
          double.tryParse(selectedFine.penaltiesPrice ?? '0')?.toInt() ?? 0;

      final userFaini = UserFainiModel(
        meetingId: widget.meetingId,
        userId: widget.userId['id'],
        fainiId: selectedFineId,
        unpaidfaini: unpaidAmount,
        mzungukoId: widget.mzungukoId,
        paidfaini: 0,
      );

      await userFaini.create();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Faini imehifadhiwa kikamilifu.')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FainiSummaryPage(
            meetingId: widget.meetingId,
            userId: widget.userId['id'],
            mzungukoId: widget.mzungukoId,
          ),
        ),
      );
    } catch (e) {
      print('Error saving fine: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Kuna tatizo la kuhifadhi faini. Tafadhali jaribu tena.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.fainiPageTitle,
        subtitle: l10n.pageSubtitle,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _faini.length,
                      itemBuilder: (context, index) {
                        final fine = _faini[index];
                        return CheckboxListTile(
                          title: Text(fine.penaltiesName ?? l10n.undefinedFine),
                          subtitle:
                              Text( l10n.amount + " " + formatCurrency(double.tryParse(fine.penaltiesPrice ?? '0') ?? 0, Provider.of<CurrencyProvider>(context).currencyCode)),
                          value: selectedFineId == fine.id,
                          onChanged: (value) {
                            if (value == true) {
                              setState(() {
                                selectedFineId = fine.id;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                  if (selectedFineId != null)
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: l10n.saveFine,
                      onPressed: _saveFine,
                      type: ButtonType.elevated,
                    ),
                ],
              ),
            ),
    );
  }
}
