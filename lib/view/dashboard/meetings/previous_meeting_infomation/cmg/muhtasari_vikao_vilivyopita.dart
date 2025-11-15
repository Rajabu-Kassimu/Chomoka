import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/akiba_wanachama/akiba_wanachama.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';
import 'package:chomoka/model/MkopoVikaoVilivyopitaModel.dart';
import 'package:chomoka/model/MadeniKikaoVilivyopitaModel.dart';

class MeetingSummaryPage extends StatefulWidget {
  var meetingId;
  var mzungukoId;
  final bool isFromVikaoVilivyopitaSummary;
  MeetingSummaryPage(
      {super.key,
      this.meetingId,
      this.mzungukoId,
      this.isFromVikaoVilivyopitaSummary = false});
  @override
  _MeetingSummaryPageState createState() => _MeetingSummaryPageState();
}

class _MeetingSummaryPageState extends State<MeetingSummaryPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final Map<String, String> fieldKeys = {
    'jumla_ya_akiba': 'Jumla ya Akiba',
    'mfuko_wa_jamii_salio': 'Mfuko wa jamii salio',
    'akiba_binafsi_salio': 'Akiba binafsi salio',
    'salio_lililolala_sandukuni': 'Salio lililolala sandukuni',
  };

  final List<Map<String, dynamic>> summaries = [
    {
      "title": "Jumla ya Akiba",
      "value": "TZS 0",
    },
    {
      "title": "Mfuko wa jamii salio",
      "value": "TZS 0",
    },
    {
      "title": "Akiba binafsi salio",
      "value": "TZS 0",
    },
    {
      "title": "Salio lililolala sandukuni",
      "value": "TZS 0",
    },
    {
      "title": "Salio la mkopo wa sasa",
      "value": "TZS 0",
      "extra": "Wanachama : 0",
    },
    {
      "title": "Mchango Uliosalia wa Mfuko wa jamii",
      "value": "TZS 0",
      "extra": "Wanachama : 1",
    },
    {
      "title": "Jumla ya Faini zinazodaiwa",
      "value": "TZS 0",
      "extra": "Wanachama : 1",
    },
  ];

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
                builder: (context) => meetingpage(
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
        BaseModel? data =
            await vikaoModel.where('kikao_key', '=', key).findOne();

        if (data is VikaovilivyopitaModel && data.value != null) {
          tempData[key] = data.value!;
        } else {
          tempData[key] = '0';
        }
      }

      setState(() {
        for (final summary in summaries) {
          final matchedKey = fieldKeys.entries.firstWhere(
            (entry) => entry.value == summary["title"],
            orElse: () => const MapEntry('', ''),
          );
          if (matchedKey.key.isNotEmpty) {
            summary["value"] = 'TZS ${tempData[matchedKey.key]}';
          }
        }
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
          if (summary["title"] == "Salio la mkopo wa sasa") {
            summary["value"] = 'TZS ${totalLoan.toStringAsFixed(0)}';
            summary["extra"] = 'Wanachama : ${distinctUserIds.length}';
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
          if (summary["title"] == "Jumla ya Faini zinazodaiwa") {
            summary["value"] = 'TZS ${totalFaini.toStringAsFixed(0)}';
          } else if (summary["title"] ==
              "Mchango Uliosalia wa Mfuko wa jamii") {
            summary["value"] = 'TZS ${totalMfukoJamii.toStringAsFixed(0)}';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);

    _fetchFinancialData().then((_) {
      _fetchLoanData().then((_) {
        _fetchFainiAndMfukoJamiiData().then((_) {
          // _fetchAndNavigateToNextPage();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Muhtasari',
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
                  summary["title"],
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
                trailing: (summary["title"] == "Jumla ya Akiba")
                    ? IconButton(
                        icon:
                            Icon(Icons.remove_red_eye, color: Colors.blueGrey),
                        onPressed: () {
                          if (summary["title"] == "Jumla ya Akiba") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AkibaWanachamaPage(
                                  isFromVikaoVilivyopitaSummary: true,
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else if (summary["title"] ==
                              "Salio la mkopo wa sasa") {
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
          buttonText: 'Nimemaliza',
          onPressed: _fetchAndNavigateToNextPage,
          type: ButtonType.elevated,
        ),
      ),
    );
  }
}
