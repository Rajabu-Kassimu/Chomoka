import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/mchango_haujalipwa/MadeniSummaryPage.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/MadeniKikaoVilivyopitaModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MadeniKikaoPage extends StatefulWidget {
  final int userId;
  final String name;
  final String memberNumber;
  var mzungukoId;

  MadeniKikaoPage({
    super.key,
    required this.userId,
    required this.memberNumber,
    this.mzungukoId,
    required this.name,
  });

  @override
  State<MadeniKikaoPage> createState() => _MadeniKikaoPageState();
}

class _MadeniKikaoPageState extends State<MadeniKikaoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fainiController = TextEditingController();
  final TextEditingController _denimfukoJamiiController = TextEditingController();
  bool isLoading = true;

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final madeniModel = MadeniKikaoVilivyopitaModel();
      final savedData = await madeniModel
          .where('id', '=', widget.userId)
          // .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (savedData != null) {
        final data = savedData.toMap();
        setState(() {
          _fainiController.text = data['fainaliopigwa'] ?? '';
          _denimfukoJamiiController.text = data['denimfukojamii'] ?? '';
        });
      }
    } catch (e) {
      print('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Hifadhi taarifa za MadeniKikaoVilivyopitaModel
        final madeniModel = MadeniKikaoVilivyopitaModel()
          ..id = widget.userId
          ..fainaliopigwa = _fainiController.text
          ..denimfukojamii = _denimfukoJamiiController.text;

        final existingRecord = await MadeniKikaoVilivyopitaModel()
            .where('id', '=', widget.userId)
            .findOne();

        if (existingRecord != null) {
          await MadeniKikaoVilivyopitaModel()
              .where('id', '=', widget.userId)
              .update({
            'fainaliopigwa': _fainiController.text,
            'denimfukojamii': _denimfukoJamiiController.text,
            'updated_at': DateTime.now().toIso8601String(),
          });
        } else {
          await madeniModel.create();
        }

        // Hifadhi taarifa za UserFainiModel
        final userFainiModel = UserFainiModel()
          ..userId = widget.userId
          ..mzungukoId = widget.mzungukoId
          ..fainiId = 30
          ..unpaidfaini = int.tryParse(_fainiController.text) ?? 0
          ..paidfaini = 0;

        final existingFainiRecord = await UserFainiModel()
            .where('user_id', '=', widget.userId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (existingFainiRecord != null) {
          await UserFainiModel()
              .where('user_id', '=', widget.userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .update({
            'fainiId': 30,
            'paidfaini': 0,
            'unpaidfaini': (int.tryParse(_fainiController.text) ?? 0),
            'updated_at': DateTime.now().toIso8601String(),
          });
        } else {
          await userFainiModel.create();
        }

        // Hifadhi taarifa za UchangaajiMfukoJamiiModel
        final uchangaajiMfukoJamiiModel = UchangaajiMfukoJamiiModel()
          ..userId = widget.userId
          ..mzungukoId = widget.mzungukoId
          ..paidStatus = 'unpaid'
          ..total = double.tryParse(_denimfukoJamiiController.text) ?? 0.0;

        final existingMfukoJamiiRecord = await UchangaajiMfukoJamiiModel()
            .where('user_id', '=', widget.userId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (existingMfukoJamiiRecord != null) {
          await UchangaajiMfukoJamiiModel()
              .where('user_id', '=', widget.userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .update({
            'total': double.tryParse(_denimfukoJamiiController.text) ?? 0.0,
            'paidStatus': 'unpaid',
            'updated_at': DateTime.now().toIso8601String(),
          });
        } else {
          await uchangaajiMfukoJamiiModel.create();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Taarifa zimehifadhiwa kwa mafanikio')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hitilafu katika kuhifadhi data: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.unpaidContributions,
        subtitle: AppLocalizations.of(context)!.memberContributions,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                                  radius: 30,
                                  child: Icon(Icons.person, size: 30),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            l10n.jina,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        l10n.memberNumber,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        widget.memberNumber,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      aboveText: AppLocalizations.of(context)!.fineOwed,
                      labelText: AppLocalizations.of(context)!.fineOwed,
                      hintText: AppLocalizations.of(context)!.enterFineOwed,
                      controller: _fainiController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterFineOwed;
                        }
                        if (double.tryParse(value) == null) {
                          return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      aboveText: AppLocalizations.of(context)!.communityFundOwed,
                      labelText: AppLocalizations.of(context)!.communityFundOwed,
                      hintText: AppLocalizations.of(context)!.enterCommunityFundOwed,
                      controller: _denimfukoJamiiController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterCommunityFundOwed;
                        }
                        if (double.tryParse(value) == null) {
                          return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            color: const Color.fromARGB(255, 4, 34, 207),
                            buttonText: AppLocalizations.of(context)!.continue_,
                            onPressed: () async {
                              await _saveData();
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MadeniSummaryPage(
                                      userId: widget.userId,
                                      name: widget.name,
                                      memberNumber: widget.memberNumber,
                                      fineOwed: _fainiController.text,
                                      mzungukoId: widget.mzungukoId,
                                      communityFundOwed: _denimfukoJamiiController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            type: ButtonType.elevated,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
