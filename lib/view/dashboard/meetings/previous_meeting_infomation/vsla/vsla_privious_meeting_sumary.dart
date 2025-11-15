import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/akiba_wanachama/akiba_wanachama.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/MkopoVikaoVilivyopitaModel.dart';
import 'package:chomoka/model/MadeniKikaoVilivyopitaModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaPreviousMeetingSummary extends StatefulWidget {
  var meetingId;
  var mzungukoId;
  final bool isFromVikaoVilivyopitaSummary;
  VslaPreviousMeetingSummary(
      {super.key,
      this.meetingId,
      this.mzungukoId,
      this.isFromVikaoVilivyopitaSummary = false});
  @override
  _VslaPreviousMeetingSummaryState createState() =>
      _VslaPreviousMeetingSummaryState();
}

class _VslaPreviousMeetingSummaryState extends State<VslaPreviousMeetingSummary>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _hisaAmount = '0'; // Add this variable to store hisa amount

  // Store only keys, not localized strings
  final Map<String, String> fieldKeys = {
    'jumla_ya_akiba': 'jumla_ya_akiba',
    'mfuko_wa_jamii_salio': 'mfuko_wa_jamii_salio',
    'akiba_binafsi_salio': 'akiba_binafsi_salio',
    'salio_lililolala_sandukuni': 'salio_lililolala_sandukuni',
    'jumla_ya_hisa': 'jumla_ya_hisa',
  };

  final List<Map<String, dynamic>> summaries = [
    {"key": 'totalShares', "value": "TZS 0"},
    {"key": 'shareValue', "value": "TZS 0"},
    {"key": 'communityFundBalance', "value": "TZS 0"},
    {"key": 'idleBalanceInBox', "value": "TZS 0"},
    {"key": 'currentLoanBalance', "value": "TZS 0", "extra": 'Members: 0'},
    {"key": 'remainingCommunityContribution', "value": "TZS 0", "extra": 'Members: 1'},
    {"key": 'totalOutstandingFines', "value": "TZS 0", "extra": 'Members: 1'},
  ];

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _fetchFinancialData() async {
    try {
      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();
      Map<String, String> tempData = {};

      for (String key in fieldKeys.keys) {
        BaseModel? data = await vikaoModel.where('kikao_key', '=', key).findOne();
        tempData[key] = (data is VikaovilivyopitaModel && data.value != null) ? data.value! : '0';
      }

      // Add fetching jumla_ya_hisa
      BaseModel? hisaData = await vikaoModel
          .where('kikao_key', '=', 'jumla_ya_hisa')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (hisaData is VikaovilivyopitaModel) {
        for (final summary in summaries) {
          if (summary["key"] == 'totalShares') {
            summary["value"] = "TZS " + (hisaData.value ?? '');
          }
        }
      }

      setState(() {
        for (final summary in summaries) {
          if (fieldKeys.containsKey(summary["key"])) {
            summary["value"] = 'TZS ' + (tempData[fieldKeys[summary["key"]]!] ?? '0');
          }
        }
        _updateHisaValue();
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  Future<void> _fetchLoanData() async {
    try {
      MkopoVikaoVilivyopitaModel mkopoModel = MkopoVikaoVilivyopitaModel();
      final allRecords = await mkopoModel.find();
      final distinctUserIds = <String>{};
      double totalLoan = 0.0;
      for (final record in allRecords) {
        final mkopo = record as MkopoVikaoVilivyopitaModel;
        if (mkopo.userId != null && mkopo.userId!.isNotEmpty) {
          distinctUserIds.add(mkopo.userId!);
        }
        if (mkopo.loanAmount != null) {
          totalLoan += double.tryParse(mkopo.loanAmount!) ?? 0.0;
        }
      }
      setState(() {
        for (final summary in summaries) {
          if (summary["key"] == 'currentLoanBalance') {
            summary["value"] = 'TZS ' + totalLoan.toStringAsFixed(0);
            summary["extra"] = 'Members: ' + distinctUserIds.length.toString();
          }
        }
      });
    } catch (e) {
      print('Error fetching loan data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch loan stats: $e')),
      );
    }
  }

  Future<void> _fetchFainiAndMfukoJamiiData() async {
    try {
      final madeniModel = MadeniKikaoVilivyopitaModel();
      final allRecords = await madeniModel.find();
      double totalFaini = 0.0;
      double totalMfukoJamii = 0.0;
      for (final record in allRecords) {
        final madeni = record as MadeniKikaoVilivyopitaModel;
        if (madeni.fainaliopigwa != null) {
          totalFaini += double.tryParse(madeni.fainaliopigwa!) ?? 0.0;
        }
        if (madeni.denimfukojamii != null) {
          totalMfukoJamii += double.tryParse(madeni.denimfukojamii!) ?? 0.0;
        }
      }
      setState(() {
        for (final summary in summaries) {
          if (summary["key"] == 'totalOutstandingFines') {
            summary["value"] = 'TZS ' + totalFaini.toStringAsFixed(0);
          } else if (summary["key"] == 'remainingCommunityContribution') {
            summary["value"] = 'TZS ' + totalMfukoJamii.toStringAsFixed(0);
          }
        }
      });
    } catch (e) {
      print('Error fetching faini & mfuko jamii data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch faini & mfuko jamii data: $e')),
      );
    }
  }

  void _updateHisaValue() {
    try {
      final jumlaHisaSummary = summaries.firstWhere(
        (summary) => summary["key"] == 'totalShares',
        orElse: () => {"key": 'totalShares', "value": "TZS 0"},
      );
      final jumlaHisaValueStr =
          jumlaHisaSummary["value"].toString().replaceAll("TZS ", "");
      final jumlaHisa = double.tryParse(jumlaHisaValueStr) ?? 0;
      final hisaValue = double.tryParse(_hisaAmount) ?? 0;
      final totalValue = jumlaHisa * hisaValue;
      for (final summary in summaries) {
        if (summary["key"] == 'shareValue') {
          summary["value"] = "TZS " + totalValue.toStringAsFixed(0);
        }
      }
    } catch (e) {
      print('Error calculating hisa value: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _fetchHisaAmount().then((_) {
      _fetchFinancialData().then((_) {
        _fetchLoanData().then((_) {
          _fetchFainiAndMfukoJamiiData().then((_) {
            // _fetchAndNavigateToNextPage();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Map keys to localized strings for display
    final Map<String, String> keyToLabel = {
      'totalShares': l10n.totalShares,
      'shareValue': l10n.shareValue,
      'communityFundBalance': l10n.communityFundBalance,
      'idleBalanceInBox': l10n.idleBalanceInBox,
      'currentLoanBalance': l10n.currentLoanBalance,
      'remainingCommunityContribution': l10n.remainingCommunityContribution,
      'totalOutstandingFines': l10n.totalOutstandingFines,
    };
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.vslaPreviousMeetingSummary,
        showBackArrow: true,
      ),
      body: ListView.builder(
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          final summary = summaries[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
              shadowColor: Colors.black.withOpacity(0.1),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(
                  keyToLabel[summary["key"]] ?? summary["key"],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    fontSize: 16, // Slightly larger text
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (summary["extra"] != null) ...[
                      Text(
                        summary["extra"]!,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                    SizedBox(height: 6),
                    Text(
                      summary["value"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Larger value text to emphasize it
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: (summary["key"] == 'totalSavings')
                    ? IconButton(
                        icon:
                            Icon(Icons.remove_red_eye, color: Colors.blueGrey),
                        onPressed: () {
                          if (summary["key"] == 'totalSavings') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AkibaWanachamaPage(
                                  isFromVikaoVilivyopitaSummary: true,
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else if (summary["key"] == 'currentLoanBalance') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RejeshaMkopoPage(
                                  isFromVikaoVilivyopitaSummary: true,
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          }
                        },
                      )
                    : null,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(12),
        child: CustomButton(
          color: Color.fromARGB(255, 4, 34, 207),
          buttonText: l10n.doneButton,
          onPressed: _fetchAndNavigateToNextPage,
          type: ButtonType.elevated,
        ),
      ),
    );
  }

  Future<void> _fetchHisaAmount() async {
    try {
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        setState(() {
          _hisaAmount = shareData.value ?? '0';
        });
      }
    } catch (e) {
      print('Error fetching hisa amount: $e');
    }
  }

  void _fetchAndNavigateToNextPage() async {
    try {
      // Query to fetch the next meeting number (kikao_key)
      VikaovilivyopitaModel queryModel = VikaovilivyopitaModel();
      BaseModel? savedData = await queryModel
          .where('kikao_key', '=', 'kikao kinachofata')
          .findOne();

      if (savedData is VikaovilivyopitaModel) {
        final kikaoValue = int.tryParse(savedData.value ?? '');

        if (kikaoValue != null) {
          print('Fetched kikao value: $kikaoValue');

          MeetingModel meetingModel = MeetingModel();
          BaseModel? existingMeeting = await meetingModel
              .where('number', '=', kikaoValue)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (existingMeeting is MeetingModel) {
            print('Found existing meeting with ID: ${existingMeeting.id}');

            print('Mzunguko ID: ${widget.mzungukoId}');
            print('Kikao Value: $kikaoValue');
            print('Existing Meeting Status: ${existingMeeting.status}');

            final updateResult = await meetingModel
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('id', '=', existingMeeting.id)
                .where('number', '=', kikaoValue)
                .update({
              'status': 'active',
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VslaMeetingDashboard(
                  meetingId: existingMeeting.id,
                  meetingNumber: kikaoValue,
                ),
              ),
            );
          } else {
            print(
                'No meeting found with number: $kikaoValue and mzungukoId: ${widget.mzungukoId}');
          }
        } else {
          print('Invalid kikao value fetched: $savedData');
        }
      } else {
        print('No data found in VikaovilivyopitaModel for kikao_key.');
      }
    } catch (e) {
      print('Error fetching or updating data: $e');
    }
  }
}
