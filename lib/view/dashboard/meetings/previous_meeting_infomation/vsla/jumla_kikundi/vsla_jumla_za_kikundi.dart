import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/jumla_kikundi/vsla_jumla_za_kikundi_sumary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/model/other_funds/DifferentAmountContributionModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaJumlaZaKikundi extends StatefulWidget {
  var mzungukoId;
  VslaJumlaZaKikundi({super.key, this.mzungukoId});

  @override
  State<VslaJumlaZaKikundi> createState() => _VslaJumlaZaKikundiState();
}

class _VslaJumlaZaKikundiState extends State<VslaJumlaZaKikundi> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jumlaYaHisaController = TextEditingController();
  final TextEditingController _mfukoWaJamiiSalioController =
      TextEditingController();
  final TextEditingController _salioLililolalaSandukuniController =
      TextEditingController();

  bool isLoading = true;
  String? errorMessage;

  // Add new variables
  String _hisaAmount = '0';
  double _totalHisaValue = 0;

  // Mifuko mingine variables
  List<MifukoMingineModel> _mifukoMingine = [];
  Map<int, TextEditingController> _mifukoMingineControllers = {};

  @override
  void initState() {
    super.initState();
    _fetchSavedData().then((_) {
      _fetchHisaAmount().then((_) {
        _fetchMifukoMingine();
      });
      _calculateTotalHisaValue();
    });
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

  // Add method to calculate total hisa value
  void _calculateTotalHisaValue() {
    final hisaCount = double.tryParse(_jumlaYaHisaController.text) ?? 0;
    final hisaValue = double.tryParse(_hisaAmount) ?? 0;
    setState(() {
      _totalHisaValue = hisaCount * hisaValue;
    });
  }

  @override
  void dispose() {
    _jumlaYaHisaController.dispose();
    _mfukoWaJamiiSalioController.dispose();
    _salioLililolalaSandukuniController.dispose();
    _mifukoMingineControllers.values
        .forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchSavedData() async {
    setState(() {
      isLoading = true;
    });

    try {
      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();

      final Map<String, String> fieldKeys = {
        'jumla_ya_hisa': 'Jumla ya Hisa',
        'mfuko_wa_jamii_salio': 'Mfuko wa Jamii salio',
        'salio_lililolala_sandukuni': 'Salio Lililolala sandukuni',
      };

      for (String key in fieldKeys.keys) {
        BaseModel? data = await vikaoModel
            .where('kikao_key', '=', key)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (data is VikaovilivyopitaModel && data.value != null) {
          switch (key) {
            case 'jumla_ya_hisa':
              _jumlaYaHisaController.text = data.value!;
              break;
            case 'mfuko_wa_jamii_salio':
              _mfukoWaJamiiSalioController.text = data.value!;
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

  Future<void> _fetchMifukoMingine() async {
    try {
      final mifukoModel = MifukoMingineModel();
      final mifuko = await mifukoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'hai')
          .find();

      setState(() {
        _mifukoMingine = mifuko.map((m) => m as MifukoMingineModel).toList();

        // Create controllers for each mfuko
        for (var mfuko in _mifukoMingine) {
          if (!_mifukoMingineControllers.containsKey(mfuko.id)) {
            _mifukoMingineControllers[mfuko.id!] = TextEditingController();
          }
        }
      });

      // Load saved values for mifuko mingine
      for (var mfuko in _mifukoMingine) {
        VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();
        BaseModel? data = await vikaoModel
            .where('kikao_key', '=', 'mfuko_mingine_${mfuko.id}')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (data is VikaovilivyopitaModel && data.value != null) {
          _mifukoMingineControllers[mfuko.id!]?.text = data.value!;
        }
      }
    } catch (e) {
      print('Error fetching mifuko mingine: $e');
    }
  }

  Future<void> _saveOrUpdateData() async {
    if (_formKey.currentState!.validate()) {
      double jumlaYaHisa =
          double.tryParse(_jumlaYaHisaController.text.trim()) ?? 0.0;
      double mfukoWaJamiiSalio =
          double.tryParse(_mfukoWaJamiiSalioController.text.trim()) ?? 0.0;
      double salioLililolalaSandukuni =
          double.tryParse(_salioLililolalaSandukuniController.text.trim()) ??
              0.0;

      double totalOtherInputs = jumlaYaHisa + mfukoWaJamiiSalio;

      if (salioLililolalaSandukuni < totalOtherInputs) {
        setState(() {
          errorMessage =
              'Salio Lililolala Sandukuni lazima liwe kubwa kuliko Jumla ya Hisa na Mfuko wa Jamii Salio.';
        });
        return;
      }

      setState(() {
        errorMessage = null;
      });

      final Map<String, TextEditingController> fieldData = {
        'jumla_ya_hisa': _jumlaYaHisaController,
        'mfuko_wa_jamii_salio': _mfukoWaJamiiSalioController,
        'salio_lililolala_sandukuni': _salioLililolalaSandukuniController,
      };

      // Add mifuko mingine to fieldData and save to DifferentAmountContributionModel
      for (var mfuko in _mifukoMingine) {
        if (mfuko.id != null) {
          fieldData['mfuko_mingine_${mfuko.id}'] =
              _mifukoMingineControllers[mfuko.id]!;

          // Save to DifferentAmountContributionModel
          final amount = double.tryParse(
                  _mifukoMingineControllers[mfuko.id]!.text.trim()) ??
              0.0;
          final contribution = DifferentAmountContributionModel(
            userId: null,
            meetingId: null,
            paidAmount: amount,
            unpaidAmount: 0.0,
            mzungukoId: widget.mzungukoId,
            mfukoId: mfuko.id,
          );
          await contribution.create();
        }
      }

      try {
        for (String key in fieldData.keys) {
          String value = fieldData[key]!.text.trim();

          if (value.isEmpty) continue;

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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VslaJumlaKikundiSummary(mzungukoId: widget.mzungukoId),
          ),
        );
      } catch (e) {
        print('Error saving data: $e');
      }
    }
  }

  // Modify build method to add the card
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.taarifaKatikatiYaMzunguko,
        subtitle: AppLocalizations.of(context)!.jumlaZaKikundi,
        showBackArrow: false,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(AppLocalizations.of(context)!.loadingData),
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
                      // Add card to show hisa calculations
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet,
                                      color: Color.fromARGB(255, 4, 34, 207),
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.taarifaZaHisa,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.thamaniYaHisaMoja,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'TZS $_hisaAmount',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 4, 34, 207),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.jumlaYaThamaniYaHisa,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'TZS ${_totalHisaValue.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 4, 34, 207),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Modify the existing TextField to update total on change
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.jumlaYaHisaZote,
                        labelText: AppLocalizations.of(context)!.jumlaYaHisaZote,
                        hintText: AppLocalizations.of(context)!.jumlaYaHisaZote,
                        controller: _jumlaYaHisaController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _calculateTotalHisaValue();
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.tafadhaliJazaJumlaYaHisa;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!.tafadhaliIngizaNambariHalali;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!.jumlaLazimaIweIsiyoHasi;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.mfukoWaJamiiSalio,
                        labelText: AppLocalizations.of(context)!.mfukoWaJamiiSalio,
                        hintText: AppLocalizations.of(context)!.wekaMfukoWaJamiiSalio,
                        controller: _mfukoWaJamiiSalioController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.tafadhaliJazaMfukoWaJamiiSalio;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!.tafadhaliIngizaNambariHalali;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!.salioLazimaIweIsiyoHasi;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.salioLililolalaSandukuni,
                        labelText: AppLocalizations.of(context)!.salioLililolalaSandukuni,
                        hintText: AppLocalizations.of(context)!.wekaSalioLililolalaSandukuni,
                        controller: _salioLililolalaSandukuniController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.tafadhaliJazaSalioLililolalaSandukuni;
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return AppLocalizations.of(context)!.tafadhaliIngizaNambariHalali;
                          }
                          if (number < 0) {
                            return AppLocalizations.of(context)!.salioLazimaIweIsiyoHasi;
                          }
                          return null;
                        },
                      ),
                      if (errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20),
                      if (_mifukoMingine.isNotEmpty) ...[
                        ..._mifukoMingine.map((mfuko) {
                          final controller =
                              _mifukoMingineControllers[mfuko.id];
                          if (controller == null)
                            return const SizedBox(); // Or handle it gracefully

                          return Column(
                            children: [
                              CustomTextField(
                                aboveText: mfuko.mfukoName ?? '',
                                labelText: '${AppLocalizations.of(context)!.jumlaYa} ${mfuko.mfukoName}',
                                hintText: '${AppLocalizations.of(context)!.wekaJumlaYa} ${mfuko.mfukoName}',
                                controller: controller,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '${AppLocalizations.of(context)!.tafadhaliJazaJumlaYa} ${mfuko.mfukoName}';
                                  }
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return AppLocalizations.of(context)!.tafadhaliIngizaNambariHalali;
                                  }
                                  if (number < 0) {
                                    return AppLocalizations.of(context)!.jumlaLazimaIweIsiyoHasi;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ],

                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.continueText,
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
