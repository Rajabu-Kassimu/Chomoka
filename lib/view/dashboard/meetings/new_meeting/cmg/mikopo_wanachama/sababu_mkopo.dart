import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/mkopo_kiasi.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_mkopo_kiasi.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class sababuMkopo extends StatefulWidget {
  var meetingId;
  var userId;
  var mzungukoId;
  sababuMkopo({this.userId, this.meetingId, this.mzungukoId});

  @override
  _sababuMkopoState createState() => _sababuMkopoState();
}

class _sababuMkopoState extends State<sababuMkopo> {
  final List<String> reasonKeys = [
    'kilimo',
    'maboresho_nyumba',
    'elimu',
    'biashara',
    'sababu_nyingine',
  ];

  String? selectedReason;
  final TextEditingController _customReasonController = TextEditingController();
  String _groupType = '';

  Future<void> _loadSavedReason() async {
    try {
      await BaseModel.ensureDatabaseInitialized();
      final toaMkopoModel = ToaMkopoModel()
        ..where('userId', '=', widget.userId['id'])
        ..where('meetingId', '=', widget.meetingId)
        ..where('mzungukoId', '=', widget.mzungukoId); // Include mzungukoId

      final savedReason = await toaMkopoModel.first();

      if (savedReason != null) {
        print('Fetched Data: ${savedReason.toMap()}');
        setState(() {
          selectedReason = (savedReason as ToaMkopoModel)
              .sababuKukopa; // Assign the saved reason
          if (!reasonKeys.contains(selectedReason)) {
            _customReasonController.text =
                savedReason.sababuKukopa ?? ''; // Set custom reason
            selectedReason = "Sababu Nyingine"; // Mark as custom reason
          }
        });
      } else {
        print("No saved reason found for this user.");
      }
    } catch (e) {
      print('Error loading saved reason: $e');
    }
  }

  Future<void> _fetchGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
        print('Group type: $_groupType');
      }
    } catch (e) {
      print('Error fetching group type: $e');
    }
  }

  Future<void> _saveData() async {
    try {
      if (selectedReason == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tafadhali chagua sababu.")),
        );
        return;
      }

      final reasonToSubmit = selectedReason == "Sababu Nyingine"
          ? _customReasonController.text
          : selectedReason;

      if (reasonToSubmit == null || reasonToSubmit.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tafadhali weka sababu nyingine.")),
        );
        return;
      }

      final toaMkopoModel = ToaMkopoModel()
        ..userId = widget.userId['id']
        ..meetingId = widget.meetingId
        ..mzungukoId = widget.mzungukoId // Include mzungukoId
        ..sababuKukopa = reasonToSubmit;

      final existingRecord = await ToaMkopoModel()
          .where('userId', '=', widget.userId['id'])
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId) // Include mzungukoId
          .first();

      if (existingRecord != null) {
        // Update record
        await ToaMkopoModel()
            .where('id', '=', (existingRecord as ToaMkopoModel).id)
            .update({'sababuKukopa': reasonToSubmit});
        print(
            'Updated: userId: ${widget.userId['id']}, meetingId: ${widget.meetingId}, mzungukoId: ${widget.mzungukoId}, reason: $reasonToSubmit');
      } else {
        await toaMkopoModel.create();
        print(
            'Created: userId: ${widget.userId['id']}, meetingId: ${widget.meetingId}, mzungukoId: ${widget.mzungukoId}, reason: $reasonToSubmit');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sababu imehifadhiwa!")),
      );

      // Navigate based on group type
      if (_groupType == 'VSLA') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaLoanAmount(
              userId: widget.userId,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KiasiMkopo(
              userId: widget.userId,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving reason: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kuna tatizo. Tafadhali jaribu tena.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGroupType().then((_) {
      _loadSavedReason();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final Map<String, String> reasonLabels = {
      'kilimo': l10n.kilimo,
      'maboresho_nyumba': l10n.maboresho_nyumba,
      'elimu': l10n.elimu,
      'biashara': l10n.biashara,
      'sababu_nyingine': l10n.sababu_nyingine,
    };
    print(widget.userId['id']);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mkopo,
        subtitle: l10n.sababu_ya_kutoa_mkopo,
        showBackArrow: true,
        // icon: Icons.settings,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.weka_sababu(widget.userId['name']),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ...reasonKeys.map((reason) {
                    return CheckboxListTile(
                      title: Text(reasonLabels[reason]!),
                      value: selectedReason == reason,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedReason = reason;
                          if (reason != 'sababu_nyingine') {
                            _customReasonController.clear();
                          }
                        });
                      },
                    );
                  }).toList(),
                  if (selectedReason == "Sababu Nyingine")
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomTextField(
                        aboveText: l10n.sababu_nyingine,
                        labelText: l10n.sababu_nyingine,
                        hintText: l10n.weka_sababu_nyingine,
                        keyboardType: TextInputType.text,
                        controller: _customReasonController,
                        obscureText: false,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.thibitisha_sababu,
              onPressed: () {
                final reasonToSubmit = selectedReason == "Sababu Nyingine"
                    ? _customReasonController.text
                    : selectedReason;

                if (selectedReason == "Sababu Nyingine" &&
                    (reasonToSubmit == null || reasonToSubmit.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Tafadhali weka sababu nyingine.")),
                  );
                  return;
                }

                _saveData();

                print('Button Pressed');
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
