// taarifa_katikati_mzunguko.dart

import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


// Add import for VSLA dashboard
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/vsla_previous_meeting_dashboard.dart';

class TaarifaKatikatiMzunguko extends StatefulWidget {
  var groupId;
  var mzungukoId;

  TaarifaKatikatiMzunguko({super.key, this.groupId, this.mzungukoId});

  @override
  State<TaarifaKatikatiMzunguko> createState() =>
      _TaarifaKatikatiMzungukoState();
}

class _TaarifaKatikatiMzungukoState extends State<TaarifaKatikatiMzunguko> {
  final _formKey = GlobalKey<FormState>(); // Key for Form validation
  final TextEditingController _kikaoController = TextEditingController();
  GroupInformationModel? groupData;
  bool isLoading = true;
  String _groupType = '';

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  void dispose() {
    _kikaoController.dispose();
    super.dispose();
  }

  Future<void> _fetchSavedData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch group type first
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
      }

      final groupInformationModel = GroupInformationModel(
        id: widget.groupId,
        round: 0,
      );

      final groupDataResult = await groupInformationModel
          // .where('id', '=', widget.groupId)
          .findOne();

      if (groupDataResult is GroupInformationModel) {
        setState(() {
          groupData = groupDataResult;
          isLoading = false;
        });
      } else {
        setState(() {
          groupData = null;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid group data received')),
        );
      }

      final vikaoModel = VikaovilivyopitaModel();
      final vikaoData = await vikaoModel
          .where('kikao_key', '=', 'kikao kinachofata')
          .findOne();

      if (vikaoData is VikaovilivyopitaModel && vikaoData.value != null) {
        setState(() {
          _kikaoController.text = vikaoData.value!;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  void _onContinuePressed() async {
    if (_formKey.currentState!.validate()) {
      final kikaoValue = int.parse(_kikaoController.text);
      print('Kikao kinachofata: $kikaoValue');

      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel(
        kikao_key: 'kikao kinachofata',
        value: kikaoValue.toString(),
        status: 'active',
      );

      try {
        VikaovilivyopitaModel queryModel = VikaovilivyopitaModel();
        BaseModel? existingEntry = await queryModel
            .where('kikao_key', '=', 'kikao kinachofata')
            .findOne();

        if (existingEntry is VikaovilivyopitaModel) {
          // Update existing entry
          VikaovilivyopitaModel updateModel = VikaovilivyopitaModel();
          await updateModel.where('id', '=', existingEntry.id).update({
            'value': vikaoModel.value,
            'status': vikaoModel.status,
          });
          print('Existing entry updated.');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
          );
        } else {
          // Create new entry
          await vikaoModel.create();
          print('New entry inserted.');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
          );
        }

        MeetingModel meetingModel = MeetingModel();
        BaseModel? existingMeeting = await meetingModel
            .where('number', '=', kikaoValue)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (existingMeeting == null) {
          meetingModel.number =
              kikaoValue; // Store the entered amount in the number column
          meetingModel.mzungukoId = widget.mzungukoId;
          meetingModel.date =
              DateTime.now().toIso8601String(); // Set current date and time
          meetingModel.status = 'pending';
          await meetingModel.create();
          print('New meeting created with Number: $kikaoValue');
        } else {
          await meetingModel
              .where('number', '=', kikaoValue)
              .where('mzungukoId', '=', widget.mzungukoId)
              .update({
            'status': 'pending',
            'date': DateTime.now().toIso8601String(),
          });
          print('Existing meeting updated with Number: $kikaoValue');
        }

        // Modified navigation based on group type
        if (_groupType == 'VSLA') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VslaPreviosusMeetingDashboard(
                meetingId: kikaoValue,
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => uwekajitaarifadashboard(
                meetingId: kikaoValue,
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
        }
      } catch (e) {
        print('Error saving kikao kinachofata or updating MeetingModel: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to save kikao kinachofata or update MeetingModel: $e'),
          ),
        );
      }
    } else {
      print('Validation failed. Please check your input.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.errorSavingDataGeneric)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.uwekaji_taarifa_katikati_mzunguko,
        showBackArrow: false,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(AppLocalizations.of(context)!.loadingGroupData),
                ],
              ),
            )
          : groupData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.kikundiKipoMzunguko,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .mzunguko(widget.mzungukoId),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            controller: _kikaoController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.namba_kikao,
                              hintText: AppLocalizations.of(context)!
                                  .ingiza_namba_kikao,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .namba_kikao_inahitajika;
                              }
                              if (int.tryParse(value) == null) {
                                return AppLocalizations.of(context)!
                                    .namba_kikao_halali;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _onContinuePressed,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.continue_,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(AppLocalizations.of(context)!
                      .invalidGroupDataReceived),
                ),
    );
  }
}
