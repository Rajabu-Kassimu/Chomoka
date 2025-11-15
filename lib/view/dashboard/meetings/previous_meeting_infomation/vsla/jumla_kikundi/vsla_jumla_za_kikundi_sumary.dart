import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/model/other_funds/DifferentAmountContributionModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/vsla_previous_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaJumlaKikundiSummary extends StatefulWidget {
  final int? mzungukoId;

  const VslaJumlaKikundiSummary({Key? key, this.mzungukoId}) : super(key: key);

  @override
  State<VslaJumlaKikundiSummary> createState() =>
      _VslaJumlaKikundiSummaryState();
}

class _VslaJumlaKikundiSummaryState extends State<VslaJumlaKikundiSummary> {
  bool isLoading = true;
  Map<String, String> financialData = {};
  List<Map<String, dynamic>> mifukoMingineData = [];

  late Map<String, String> fieldKeys;

  @override
  void initState() {
    super.initState();
    // Removed _fetchFinancialData() from here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fieldKeys = {
      'jumla_ya_hisa': AppLocalizations.of(context)!.jumlaYaHisa,
      'mfuko_wa_jamii_salio': AppLocalizations.of(context)!.mfukoWaJamiiSalio,
      'salio_lililolala_sandukuni':
          AppLocalizations.of(context)!.salioLililolalaSandukuni,
    };
    _fetchFinancialData(); // Moved here to ensure fieldKeys is initialized first
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = KikaoKilichopitaModel(
        meeting_step: 'jumla_kikundi',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      debugPrint('Error updating status: $e');
    }
  }

  Future<void> _fetchFinancialData() async {
    try {
      // Fetch regular financial data
      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();
      Map<String, String> tempData = {};

      for (String key in fieldKeys.keys) {
        BaseModel? data = await vikaoModel
            .where('kikao_key', '=', key)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        tempData[key] = (data is VikaovilivyopitaModel && data.value != null)
            ? data.value!
            : '0';
      }

      // Fetch mifuko mingine data
      final mifukoModel = MifukoMingineModel();
      final mifuko = await mifukoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'hai')
          .find();

      for (var mfuko in mifuko) {
        if (mfuko is MifukoMingineModel && mfuko.id != null) {
          final contribution = DifferentAmountContributionModel();
          final data = await contribution
              .where('mfukoId', '=', mfuko.id)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (data is DifferentAmountContributionModel) {
            mifukoMingineData.add({
              'name': mfuko.mfukoName ?? 'Mfuko',
              'amount': data.paidAmount ?? 0.0,
            });
          }
        }
      }

      setState(() {
        financialData = tempData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching financial data: $e');
      setState(() => isLoading = false);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(AppLocalizations.of(context)!.failedToLoadSummaryData),
      //   ),
      // );
    }
  }

  String _formatCurrency(String value) {
    try {
      double amount = double.parse(value);
      return 'TZS ${amount.toStringAsFixed(0)}';
    } catch (e) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.taarifaZaKikundi,
        subtitle: AppLocalizations.of(context)!.jumlaYaTaarifaZaKikundi,
        showBackArrow: true,
      ),
      body: isLoading
          ? _buildLoading()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: financialData.isNotEmpty
                  ? _buildFinancialList()
                  : _buildEmptyView(),
            ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: 4.0,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.inapakiaTaarifa,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Colors.grey[400], size: 48),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.hakunaTaarifaZilizopo,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.jumlaZaKikundi,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: fieldKeys.keys.length + mifukoMingineData.length,
            separatorBuilder: (_, __) => const Divider(thickness: 1.2),
            itemBuilder: (context, index) {
              if (index < fieldKeys.keys.length) {
                final entry = fieldKeys.entries.elementAt(index);
                final key = entry.key;
                final label = entry.value;

                final rawValue = financialData[key] ?? '0';
                final formattedValue = _formatCurrency(rawValue);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black26,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    title: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formattedValue,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                final mfukoData =
                    mifukoMingineData[index - fieldKeys.keys.length];
                final formattedValue =
                    _formatCurrency(mfukoData['amount'].toString());

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black26,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    title: Text(
                      mfukoData['name'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formattedValue,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: CustomButton(
            color: const Color(0xFF0422CF),
            buttonText: AppLocalizations.of(context)!.finished,
            onPressed: () async {
              await _updateStatusToCompleted();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VslaPreviosusMeetingDashboard(
                    mzungukoId: widget.mzungukoId,
                  ),
                ),
              );
            },
            type: ButtonType.elevated,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
