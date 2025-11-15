import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart'; // Add this import
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MichangoListPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final Function(UwekajiKwaMkupuoModel)? onSelectContribution;

  MichangoListPage(
      {required this.meetingId, this.onSelectContribution, this.mzungukoId});

  @override
  _MichangoListPageState createState() => _MichangoListPageState();
}

class _MichangoListPageState extends State<MichangoListPage> {
  List<Map<String, dynamic>> contributions = [];
  double totalContributions = 0;
  bool isLoading = true;
  String _groupType = ''; // Add this property

  @override
  void initState() {
    super.initState();
    _checkGroupType().then((_) {
      _fetchContributions();
    });
  }

  Future<void> _checkGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
        print('Group type: $_groupType');
      }
    } catch (e) {
      print('Error checking group type: $e');
    }
  }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meetingId', '=', widget.meetingId)
          .select();

      // Calculate total amount with null safety
      double totalAmount = 0;
      for (var contribution in results) {
        if (contribution['amount'] != null) {
          totalAmount += (contribution['amount'] as num).toDouble();
        }
      }

      setState(() {
        contributions = results;
        totalContributions = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.contributions,
        subtitle: l10n.contributionsList,
        icon: Icons.add,
        onIconPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UwekajiKwaMkupuoPage(
                meetingId: widget.meetingId,
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
        },
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : contributions.isEmpty
              ? Center(
                  child: Text(
                    l10n.noContributionsCompleted,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: contributions.length,
                        itemBuilder: (context, index) {
                          final contribution = contributions[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contribution['mfukoType'] ?? l10n.noFund,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    l10n.amountLabel(contribution['amount']?.toStringAsFixed(0) ?? '0'),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    l10n.contributionType(contribution['ainaUchangiaji'] ?? l10n.none),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.done,
                        onPressed: () async {
                          // Navigate based on group type
                          if (_groupType.toLowerCase() == 'vsla') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VslaMeetingDashboard(
                                  meetingId: widget.meetingId,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    meetingpage(meetingId: widget.meetingId),
                              ),
                            );
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
    );
  }
}
