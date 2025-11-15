import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/list_uchangaji.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class ThibitishaUchangiajiPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final double mchango;
  ThibitishaUchangiajiPage(
      {super.key,
      required this.meetingId,
      required this.mchango,
      this.mzungukoId});

  @override
  _ThibitishaUchangiajiPageState createState() =>
      _ThibitishaUchangiajiPageState();
}

class _ThibitishaUchangiajiPageState extends State<ThibitishaUchangiajiPage> {
  final double salioMfuko = 25000.0; // Example initial balance

  double get salioJipya => salioMfuko + widget.mchango; // Calculate new balance

  Future<void> _updateStatusToCompleted() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      await uwakajiModel
          .where('meetingId', '=', widget.meetingId)
          .update({'status': 'complete'});

      print('Status updated to complete for meetingId ${widget.meetingId}');
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.bulkSaving,
        subtitle: l10n.confirmContribution,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildRow(l10n.fundBalance, salioMfuko),
                    Divider(),
                    _buildRow(l10n.currentContribution, widget.mchango),
                    Divider(),
                    _buildRow(l10n.newFundBalance, salioJipya),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    color: Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.next,
                    onPressed: () async {
                      await _updateStatusToCompleted();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MichangoListPage(
                            meetingId: widget.meetingId,
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

  Widget _buildRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'TZS ${value.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
