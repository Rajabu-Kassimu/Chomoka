import 'dart:math';

import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupIdentityModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Summary.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/controllers/group_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:intl/intl.dart';

class groupInfo extends StatefulWidget {
  var data_id;
  final bool isEditingMode;

  groupInfo({
    super.key,
    required this.data_id,
    this.isEditingMode = false,
  });

  @override
  State<groupInfo> createState() => _groupInfoState();
}

class _groupInfoState extends State<groupInfo> {
  // Add controller
  final GroupInformationController _groupInfoController =
      GroupInformationController();
  TextEditingController groupName = TextEditingController();
  TextEditingController madeDate = TextEditingController();
  TextEditingController round = TextEditingController();

  List<GroupInformationModel> _savedData = [];
  final _formKey = GlobalKey<FormState>();
  bool _isMzungukoPending = false;
  int? _groupId = 0;

  Future<void> _fetchExistingData() async {
    final groupInformationModel = GroupInformationModel();
    final BaseModel? baseModelData = await groupInformationModel.findOne();

    if (baseModelData != null) {
      if (baseModelData is GroupInformationModel) {
        setState(() {
          groupName.text = baseModelData.name ?? '';
          madeDate.text = baseModelData.yearMade?.toString() ?? '';
        });
      } else {
        print('Error: Fetched data is not a GroupInformationModel');
      }
    }
  }

  Future<void> _fetchSavedData() async {
    final groupInformationModel = GroupInformationModel();
    final List<Map<String, dynamic>> savedRecords =
        await groupInformationModel.select();

    setState(() {
      _savedData = savedRecords.map((record) {
        final groupInfo =
            groupInformationModel.fromMap(record); // Use instance methodr
        _groupId = groupInfo.id; // Set groupId from the fetched data
        return groupInfo;
      }).toList();
    });
  }

  Future<void> _updateGroupData() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> updates = {};

      if (groupName.text.isNotEmpty) updates['name'] = groupName.text;
      if (madeDate.text.isNotEmpty) {
        final year = int.tryParse(madeDate.text);
        if (year != null) updates['yearMade'] = year;
      }

      int? mzungukoId;

      if (round.text.isNotEmpty) {
        final roundValue = int.tryParse(round.text);
        if (roundValue != null) {
          try {
            final mzungukoModel = MzungukoModel();
            // Fetch the latest Mzunguko if it exists, otherwise use roundValue
            final latestMzungukoResult = await mzungukoModel.select().then(
                (results) => results.isNotEmpty
                    ? results.reduce((a, b) => a['id'] > b['id'] ? a : b)
                    : null);

            if (latestMzungukoResult != null &&
                latestMzungukoResult['status'] == 'pending') {
              // If the last mzunguko is pending, use its ID
              mzungukoId = latestMzungukoResult['id'];
            } else {
              // Otherwise, use the roundValue
              mzungukoId = roundValue;
              updates['round'] = roundValue;
              updates['mzungukoId'] = roundValue;
            }

            // Update the 'round' column with the fetched or provided mzungukoId
            if (mzungukoId != null) {
              updates['round'] = mzungukoId;
            }
          } catch (e) {
            print("Error fetching mzunguko data: $e");
          }
        }
      }

      try {
        final groupInformationModel = GroupInformationModel();
        if (_groupId != null) {
          // Update the group with the correct mzungukoId and round
          if (mzungukoId != null) {
            updates['mzungukoId'] = mzungukoId;
          }
          await groupInformationModel
              .where('id', '=', _groupId)
              .update(updates);

          if (updates.containsKey('round')) {
            await _saveMzungukoInfo(updates['round']);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
          );

          await _fetchSavedData();
          await saveGroupIdentity(groupName.text);

          widget.isEditingMode
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupOverview(data_id: _groupId),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupSummary(data_id: _groupId),
                  ),
                );
        } else {
          throw Exception("Invalid data_id: ${_groupId}");
        }
      } catch (e) {
        print("Error during update: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating data: $e')),
        );
      }
    }
  }

  Future<void> _saveMzungukoInfo(int roundValue) async {
    if (!widget.isEditingMode) {
      try {
        final mzungukoModel = MzungukoModel();

        final latestMzungukoResult = await mzungukoModel.select().then(
            (results) => results.isNotEmpty
                ? results.reduce((a, b) => a['id'] > b['id'] ? a : b)
                : null);

        int mzungukoId;

        if (latestMzungukoResult != null &&
            latestMzungukoResult['status'] == 'pending') {
          mzungukoId = latestMzungukoResult['id'];
          print("Mzunguko info updated successfully! ID: $mzungukoId");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Mzunguko uliopo tayari ni wa "pending". Hakuna mzunguko mpya ulioanzishwa.')),
          );
        } else {
          mzungukoId = roundValue;
          final mzungukoModelInstance = MzungukoModel();
          mzungukoModelInstance.id = mzungukoId;
          mzungukoModelInstance.status = 'pending';

          final int savedId = await mzungukoModelInstance.create();
          print("Mzunguko info created successfully! Saved ID: $savedId");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.mzungukoPendingNoNew)),
          );
        }
      } catch (e) {
        print("Error saving or updating Mzunguko info: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving or updating Mzunguko info: $e')),
        );
      }
    }
  }

  String generateRandomDigits(int length) {
    final random = Random();
    return List.generate(length, (index) => random.nextInt(10)).join();
  }

  Future<void> saveGroupIdentity(String groupName) async {
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyyMMddHHmmss').format(now);
    final randomDigits = generateRandomDigits(6);
    final groupIdentity = '$formattedTime$randomDigits';

    try {
      final groupIdentityModel =
          GroupIdentityModel(groupIdentity: groupIdentity);

      final existingIdentity = await groupIdentityModel.findOne();
      print((existingIdentity as GroupIdentityModel?)?.groupIdentity);
      // await existingIdentity.delete();
      if (existingIdentity == null) {
        await groupIdentityModel.create();
        print('Group identity saved: $groupIdentity');
      } else {
        // var d_id = (existingIdentity as GroupIdentityModel?)?.id;
        // print("Dataaaaaaaaaaaaaaa $d_id");
        // await groupIdentityModel.where('id', '=', d_id).delete();
        // await groupIdentityModel.create();
      }
    } catch (e) {
      print('Error saving group identity: $e');
    }
  }

  Future<bool> _isLastMzungukoCompleted() async {
    try {
      final mzungukoModel = MzungukoModel();
      final mzungukoResult = await mzungukoModel.select();

      if (mzungukoResult.isNotEmpty) {
        final lastMzungukoMap = mzungukoResult.reduce((current, next) {
          return current['id'] > next['id'] ? current : next;
        });

        // final bool isCompleted = lastMzungukoMap['status'] == 'completed';
        final bool isPending = lastMzungukoMap['status'] == 'pending';

        setState(() {
          // _isMzungukoCompleted = isCompleted;
          _isMzungukoPending = isPending;
        });

        return isPending;
      }

      return false;
    } catch (e) {
      print('Error fetching the last mzunguko: $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _isLastMzungukoCompleted().then((_) {
      _fetchSavedData().then((_) {
        _fetchExistingData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.groupInformation,
        subtitle: AppLocalizations.of(context)!.editGroupInformation,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.groupName,
                  labelText: AppLocalizations.of(context)!.groupName,
                  hintText: AppLocalizations.of(context)!.enterGroupName,
                  controller: groupName,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.groupNameRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.yearEstablished,
                  labelText: AppLocalizations.of(context)!.yearEstablished,
                  hintText: AppLocalizations.of(context)!.enterYearEstablished,
                  keyboardType: TextInputType.number,
                  controller: madeDate,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .yearEstablishedRequired;
                    }
                    final int? year = int.tryParse(value);
                    if (year == null) {
                      return AppLocalizations.of(context)!.enterValidYear;
                    }
                    final int currentYear = DateTime.now().year;
                    if (year < 1999 || year > currentYear) {
                      // return AppLocalizations.of(context)!.enterYearRange.replaceAll('{currentYear}', currentYear.toString());
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('${AppLocalizations.of(context)!.example}, 2010',
                    textAlign: TextAlign.left),
                SizedBox(height: 10),
                Visibility(
                  visible: (_isMzungukoPending == false &&
                      widget.isEditingMode == false),
                  child: CustomTextField(
                    aboveText: AppLocalizations.of(context)!.currentRound,
                    labelText: AppLocalizations.of(context)!.currentRound,
                    hintText: AppLocalizations.of(context)!.enterCurrentRound,
                    controller: round,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .currentRoundRequired;
                      }
                      if (int.tryParse(value) == null) {
                        return AppLocalizations.of(context)!.enterValidRound;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: widget.isEditingMode
                      ? AppLocalizations.of(context)!.update
                      : AppLocalizations.of(context)!.continueText,
                  onPressed: _updateGroupData,
                  type: ButtonType.elevated,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
