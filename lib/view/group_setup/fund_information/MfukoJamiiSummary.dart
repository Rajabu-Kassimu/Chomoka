import 'package:chomoka/view/group_setup/fund_information/mfukoInfo.dart';
import 'package:chomoka/view/group_setup/fund_information/sababu_kutoa.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/SababuKutoaMfuko.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class MfukoSummaryPage extends StatefulWidget {
  final bool isUpdateMode;
  final bool fromDashboard;
  var mzungukoId;

  MfukoSummaryPage({
    Key? key,
    this.isUpdateMode = false,
    this.fromDashboard = false,
    this.mzungukoId,
  }) : super(key: key);

  @override
  State<MfukoSummaryPage> createState() => _MfukoSummaryPageState();
}

class _MfukoSummaryPageState extends State<MfukoSummaryPage> {
  String mfukoName = "Mfuko Jamii";
  String mfukoAmount = "0";
  List<Map<String, String>> sababu = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMfukoData();
  }

  Future<void> _fetchMfukoData() async {
    try {
      final mfukoModel = MfukoJamiiModel();

      final mfukoNameData = await mfukoModel
          .where('mfuko_key', '=', 'Jina la Mfuko')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (mfukoNameData != null && mfukoNameData is MfukoJamiiModel) {
        mfukoName = mfukoNameData.value ?? "Mfuko Jamii";
      }

      final mfukoAmountData = await mfukoModel
          .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (mfukoAmountData != null && mfukoAmountData is MfukoJamiiModel) {
        mfukoAmount = mfukoAmountData.value ?? "0";
      }

      await _fetchSababuData();
    } catch (e) {
      print("Error fetching Mfuko data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSababuData() async {
    try {
      final sababuModel = SababuKutoaMfuko();

      final sababuData = await sababuModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      final List<Map<String, String>> fetchedSababu = [];
      for (var reason in sababuData) {
        final mappedReason = SababuKutoaMfuko().fromMap(reason);
        if (mappedReason.reasonName != null && mappedReason.amount != null) {
          fetchedSababu.add({
            'description': mappedReason.reasonName!,
            'value': 'TZS ${mappedReason.amount!}',
          });
        }
      }

      setState(() {
        sababu = fetchedSababu;
      });
    } catch (e) {
      print("Error fetching Sababu za Kutoa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    if (isLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.fundOverview,
          subtitle: AppLocalizations.of(context)!.fundInfo,
          showBackArrow: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.fundOverview,
        subtitle: AppLocalizations.of(context)!.fundInfo,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                titleText: AppLocalizations.of(context)!.fundInfo,
                onEdit: widget.fromDashboard
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MfukoJamiiPage(
                                    isUpdateMode: true,
                                    mzungukoId: widget.mzungukoId,
                                  )),
                        );
                      },
                items: [
                  {
                    'description': AppLocalizations.of(context)!.groupName,
                    'value': mfukoName
                  },
                  {
                    'description': AppLocalizations.of(context)!.amount,
                    'value': '${Provider.of<CurrencyProvider>(context).currencyCode} ${(double.tryParse(mfukoAmount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt()}'
                  },
                ],
              ),
              const SizedBox(height: 20),
              CustomCard(
                titleText: AppLocalizations.of(context)!.withdrawalReasons,
                onEdit: widget.fromDashboard
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SababuKutoa(
                                    isUpdateMode: true,
                                    mzungukoId: widget.mzungukoId,
                                  )),
                        );
                        print("Edit Sababu za Kutoa");
                      },
                items: sababu.isNotEmpty
                    ? sababu.map((item) => {
                        'description': item['description'] ?? '',
                        'value': '${Provider.of<CurrencyProvider>(context).currencyCode} ${(double.tryParse((item['value'] ?? '').replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt()}'
                      }).toList()
                    : [
                        {
                          'description':
                              AppLocalizations.of(context)!.noReasonsRecorded,
                          'value': '',
                        }
                      ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                color: const Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!.finished,
                onPressed: () async {
                  try {
                    final mfukoModel = MfukoJamiiModel();

                    await mfukoModel
                        .where('mfuko_key', '=', 'Jina la Mfuko')
                        .update({'status': 'hai'});

                    print("Status updated to 'hai'");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => mifukoList(
                                mzungukoId: widget.mzungukoId,
                              )),
                    );
                  } catch (e) {
                    print("Error updating status: $e");
                  }
                },
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
