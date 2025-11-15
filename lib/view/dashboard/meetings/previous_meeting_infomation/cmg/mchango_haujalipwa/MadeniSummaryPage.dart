import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/mchango_haujalipwa/mchango_haujalipwa.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MadeniSummaryPage extends StatefulWidget {
  final int userId;
  final String name;
  final String memberNumber;
  final String fineOwed;
  final String communityFundOwed;
  var mzungukoId;

  MadeniSummaryPage({
    Key? key,
    required this.userId,
    required this.name,
    required this.memberNumber,
    required this.fineOwed,
    this.mzungukoId,
    required this.communityFundOwed,
  }) : super(key: key);

  @override
  State<MadeniSummaryPage> createState() => _MadeniSummaryPageState();
}

class _MadeniSummaryPageState extends State<MadeniSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.midCycleInfo,
        subtitle: l10n.unpaidContribution,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Text(
                            widget.memberNumber,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                l10n.memberNumberLabel(widget.memberNumber),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    _buildSummaryRow(
                        l10n.unpaidFinesTitle, "TZS ${widget.fineOwed}"),
                    Divider(),
                    _buildSummaryRow(l10n.unpaidContribution,
                        "TZS ${widget.communityFundOwed}"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.continue_,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MchangoHaujalipwaPage(
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
