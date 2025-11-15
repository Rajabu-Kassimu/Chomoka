import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/jumla_kikundi/jumla_za_kikundi_sumary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class JumlaZaKikundi extends StatefulWidget {
  var mzungukoId;
  JumlaZaKikundi({super.key, this.mzungukoId});

  @override
  State<JumlaZaKikundi> createState() => _JumlaZaKikundiState();
}

class _JumlaZaKikundiState extends State<JumlaZaKikundi> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jumlaYaAkibaController = TextEditingController();
  final TextEditingController _mfukoWaJamiiSalioController =
      TextEditingController();
  final TextEditingController _akibaBinafsiSalioController =
      TextEditingController();
  final TextEditingController _salioLililolalaSandukuniController =
      TextEditingController();

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  void dispose() {
    _jumlaYaAkibaController.dispose();
    _mfukoWaJamiiSalioController.dispose();
    _akibaBinafsiSalioController.dispose();
    _salioLililolalaSandukuniController.dispose();
    super.dispose();
  }

  Future<void> _fetchSavedData() async {
    setState(() {
      isLoading = true;
    });

    try {
      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();

      final Map<String, String> fieldKeys = {
        'jumla_ya_akiba': 'Jumla ya Akiba',
        'mfuko_wa_jamii_salio': 'Mfuko wa Jamii salio',
        'akiba_binafsi_salio': 'Akiba Binafsi salio',
        'salio_lililolala_sandukuni': 'Salio Lililolala sandukuni',
      };

      for (String key in fieldKeys.keys) {
        BaseModel? data =
            await vikaoModel.where('kikao_key', '=', key).findOne();

        if (data is VikaovilivyopitaModel && data.value != null) {
          switch (key) {
            case 'jumla_ya_akiba':
              _jumlaYaAkibaController.text = data.value!;
              break;
            case 'mfuko_wa_jamii_salio':
              _mfukoWaJamiiSalioController.text = data.value!;
              break;
            case 'akiba_binafsi_salio':
              _akibaBinafsiSalioController.text = data.value!;
              break;
            case 'salio_lililolala_sandukuni':
              _salioLililolalaSandukuniController.text = data.value!;
              break;
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching saved data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveOrUpdateData() async {
    if (_formKey.currentState!.validate()) {
      double jumlaYaAkiba =
          double.tryParse(_jumlaYaAkibaController.text.trim()) ?? 0.0;
      double mfukoWaJamiiSalio =
          double.tryParse(_mfukoWaJamiiSalioController.text.trim()) ?? 0.0;
      double akibaBinafsiSalio =
          double.tryParse(_akibaBinafsiSalioController.text.trim()) ?? 0.0;
      double salioLililolalaSandukuni =
          double.tryParse(_salioLililolalaSandukuniController.text.trim()) ??
              0.0;

      double totalOtherInputs = jumlaYaAkiba + mfukoWaJamiiSalio;

      if (salioLililolalaSandukuni < totalOtherInputs) {
        setState(() {
          errorMessage =
              'Salio Lililolala Sandukuni lazima liwe kubwa kuliko Jumla ya Akiba na Mfuko wa Jamii Salio.';
        });
        return;
      }

      setState(() {
        errorMessage = null;
      });

      final Map<String, TextEditingController> fieldData = {
        'jumla_ya_akiba': _jumlaYaAkibaController,
        'mfuko_wa_jamii_salio': _mfukoWaJamiiSalioController,
        'akiba_binafsi_salio': _akibaBinafsiSalioController,
        'salio_lililolala_sandukuni': _salioLililolalaSandukuniController,
      };

      try {
        VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();

        for (String key in fieldData.keys) {
          String value = fieldData[key]!.text.trim();

          if (value.isEmpty) {
            continue;
          }

          VikaovilivyopitaModel queryModel = VikaovilivyopitaModel();
          BaseModel? existingEntry = await queryModel
              .where('kikao_key', '=', key)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (existingEntry is VikaovilivyopitaModel) {
            VikaovilivyopitaModel updateModel = VikaovilivyopitaModel();
            await updateModel.where('id', '=', existingEntry.id).update({
              'value': value,
              'status': 'active',
              'mzungukoId': widget.mzungukoId,
            });
          } else {
            VikaovilivyopitaModel newEntry = VikaovilivyopitaModel(
              kikao_key: key,
              value: value,
              status: 'active',
              mzungukoId: widget.mzungukoId,
            );
            await newEntry.create();
          }
        }

        // Navigate to the summary page after saving
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  JumlaKikundiSummary(mzungukoId: widget.mzungukoId)),
        );
      } catch (e) {
        print('Error saving data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.groupTotals,
        subtitle: AppLocalizations.of(context)!.groupTotalsSummary,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading data...'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.totalShares,
                        labelText: AppLocalizations.of(context)!.totalShares,
                        hintText:
                            AppLocalizations.of(context)!.enterTotalShares,
                        controller: _jumlaYaAkibaController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterTotalShares;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidNumber;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidPositiveNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.shareValue,
                        labelText: AppLocalizations.of(context)!.shareValue,
                        hintText: AppLocalizations.of(context)!.enterShareValue,
                        controller: _mfukoWaJamiiSalioController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterShareValue;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidNumber;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidPositiveNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.totalSavings,
                        labelText: AppLocalizations.of(context)!.totalSavings,
                        hintText:
                            AppLocalizations.of(context)!.enterTotalSavings,
                        controller: _akibaBinafsiSalioController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterTotalSavings;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidNumber;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidPositiveNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText:
                            AppLocalizations.of(context)!.communityFundBalance,
                        labelText:
                            AppLocalizations.of(context)!.communityFundBalance,
                        hintText: AppLocalizations.of(context)!
                            .enterCommunityFundBalance,
                        controller: _salioLililolalaSandukuniController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterCommunityFundBalance;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidNumber;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterValidPositiveNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      if (errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.continue_,
                        onPressed: _saveOrUpdateData,
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
