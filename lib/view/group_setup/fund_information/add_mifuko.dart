import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/view/group_setup/fund_information/different_amount.dart';
import 'package:chomoka/view/group_setup/fund_information/mifukoMingineSummary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class addMifuko extends StatefulWidget {
  final int? recordId;
  var mzungukoId;

  addMifuko({super.key, this.recordId, this.mzungukoId});

  @override
  State<addMifuko> createState() => _addMifukoState();
}

class _addMifukoState extends State<addMifuko> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _amountController = TextEditingController();
  TextEditingController _mfukoName = TextEditingController();
  TextEditingController _goalController = TextEditingController();

  String _selectedOption = '';
  String _selectedData = '';
  String? _selectedType;
  bool _isKopesheka = false;
  bool _isExistingRecord = false;
  MifukoMingineModel? _existingModel;
  String? _utaratibuUchangiajiError;
  String? _utaratibuUtoajiError;

  @override
  void initState() {
    super.initState();
    _loadDataIfExists();
  }

  Future<void> _loadDataIfExists() async {
    if (widget.recordId != null) {
      MifukoMingineModel model = MifukoMingineModel();
      MifukoMingineModel? record = await model
          .where('id', '=', widget.recordId)
          .first() as MifukoMingineModel?;
      if (record != null) {
        setState(() {
          _existingModel = record;
          _isExistingRecord = true;

          _mfukoName.text = record.mfukoName ?? '';
          _goalController.text = record.goal ?? '';
          _selectedOption = record.utoajiType ?? '';
          _amountController.text = record.mfukoAmount ?? '';
          _selectedData = record.utaratibuKutoa ?? '';
          _isKopesheka = (record.unakopesheka == 'Zinakopesheka');

          _selectedType = _mapGoalToItem(record.goal);
        });
      }
    }
  }

  String? _mapGoalToItem(String? goal) {
    switch (goal) {
      case 'Elimu':
        return 'item2';
      case 'Kilimo':
        return 'item3';
      case 'Mradi jamii':
        return 'item4';
      case 'Cocoa':
        return 'item5';
      default:
        if (goal != null &&
            goal.isNotEmpty &&
            goal != 'Elimu' &&
            goal != 'Kilimo' &&
            goal != 'Mradi jamii' &&
            goal != 'Cocoa') {
          return 'item6';
        }
        return 'item1';
    }
  }

  String? _mapItemToGoal(String? selectedType) {
    switch (selectedType) {
      case 'item2':
        return 'Elimu';
      case 'item3':
        return 'Kilimo';
      case 'item4':
        return 'Mradi jamii';
      case 'item5':
        return 'Cocoa';
      case 'item6':
        return _goalController.text;
      default:
        return null;
    }
  }

  bool _validateRadios() {
    bool isValid = true;

    if (_selectedOption.isEmpty) {
      setState(() {
        _utaratibuUchangiajiError =
            AppLocalizations.of(context)!.pleaseSelectContributionProcedure;
      });
      isValid = false;
    } else {
      setState(() {
        _utaratibuUchangiajiError = null;
      });
    }

    // If Kiwango sawa is chosen but no amount given - handled by the text field validator.

    if (_selectedData.isEmpty) {
      setState(() {
        _utaratibuUtoajiError =
            AppLocalizations.of(context)!.pleaseSelectWithdrawalProcedure;
      });
      isValid = false;
    } else {
      setState(() {
        _utaratibuUtoajiError = null;
      });
    }

    return isValid;
  }

  Future<void> _saveData() async {
    if (!_validateRadios()) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final model = MifukoMingineModel(
        id: _existingModel?.id,
        mzungukoId: widget.mzungukoId,
        mfukoName: _mfukoName.text,
        goal: _mapItemToGoal(_selectedType),
        utoajiType: _selectedOption,
        mfukoAmount: _amountController.text,
        utaratibuKutoa: _selectedData,
        unakopesheka: _isKopesheka ? 'Zinakopesheka' : '',
        status: 'hai',
      );

      int? mfukoId;

      // Check if record exists
      final existingRecord = await MifukoMingineModel()
          .where('mfuko_name', '=', _mfukoName.text)
          .where('mzungukoId', '=', widget.mzungukoId)
          .first();

      if (existingRecord != null) {
        // Update existing record
        await MifukoMingineModel()
            .where('id', '=', existingRecord.toMap()['id'])
            .update(model.toMap()..remove('id'));
        mfukoId =
            existingRecord.toMap()['id']; // Fix: access id through toMap()

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dataUpdatedSuccessfully)),
        );
      } else {
        // Create new record
        mfukoId = await model.create();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => mifukominginesummary(
            recordId: mfukoId,
            mzungukoId: widget.mzungukoId,
          ),
        ),
      );
      // // Navigate based on selected option
      // if (_selectedOption == 'Kiwango chochote') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DifferentAmount(
      //         recordId: mfukoId,
      //         mzungukoId: widget.mzungukoId,
      //       ),
      //     ),
      //   );
      // } else {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => mifukominginesummary(
      //         recordId: mfukoId,
      //         mzungukoId: widget.mzungukoId,
      //       ),
      //     ),
      //   );
      // }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorSavingDataGeneric),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _options = [
      AppLocalizations.of(context)!.equalAmount,
      AppLocalizations.of(context)!.anyAmount,
    ];
    final List<String> _utaratibu = [
      AppLocalizations.of(context)!.notWithdrawableDuringCycle,
      AppLocalizations.of(context)!.withdrawByMemberName,
      AppLocalizations.of(context)!.withdrawAsGroup,
    ];
    final List<DropdownMenuItem<String>> mifukoType = [
      DropdownMenuItem(
        value: 'item1',
        child: Text(AppLocalizations.of(context)!.selectOption),
      ),
      DropdownMenuItem(
        value: 'item2',
        child: Text(AppLocalizations.of(context)!.education),
      ),
      DropdownMenuItem(
        value: 'item3',
        child: Text(AppLocalizations.of(context)!.agriculture),
      ),
      DropdownMenuItem(
        value: 'item4',
        child: Text(AppLocalizations.of(context)!.communityProject),
      ),
      DropdownMenuItem(
        value: 'item5',
        child: Text(AppLocalizations.of(context)!.cocoa),
      ),
      DropdownMenuItem(
        value: 'item6',
        child: Text(AppLocalizations.of(context)!.otherGoals),
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.fundInformation,
        subtitle: AppLocalizations.of(context)!.fundProcedures,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.fundName,
                  labelText: AppLocalizations.of(context)!.fundName,
                  hintText: AppLocalizations.of(context)!.enterFundName,
                  keyboardType: TextInputType.text,
                  controller: _mfukoName,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterFundName;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomDropdown<String>(
                  labelText: AppLocalizations.of(context)!.fundGoals,
                  hintText: AppLocalizations.of(context)!.fundGoals,
                  items: mifukoType,
                  value: _selectedType ?? 'item1',
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'item1') {
                      return AppLocalizations.of(context)!.pleaseSelectFundGoal;
                    }
                    return null;
                  },
                  aboveText: AppLocalizations.of(context)!.fundGoals,
                ),
                if (_selectedType == 'item6') SizedBox(height: 10),
                if (_selectedType == 'item6')
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.otherGoals,
                    labelText: AppLocalizations.of(context)!.otherGoals,
                    hintText: AppLocalizations.of(context)!.enterOtherGoals,
                    keyboardType: TextInputType.text,
                    controller: _goalController,
                    obscureText: false,
                    validator: (value) {
                      if (_selectedType == 'item6' &&
                          (value == null || value.trim().isEmpty)) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterOtherGoals;
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 10),

                // Utaratibu wa Uchangiaji (Radio)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.contributionProcedure,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CustomRadioGroup<String>(
                      options: _options,
                      value: _selectedOption,
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      },
                      labelText: '',
                    ),
                    if (_utaratibuUchangiajiError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(_utaratibuUchangiajiError!,
                            style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),

                if (_selectedOption == _options[0]) SizedBox(height: 10),
                if (_selectedOption == _options[0])
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.contributionAmount,
                    labelText: AppLocalizations.of(context)!.contributionAmount,
                    hintText:
                        AppLocalizations.of(context)!.enterContributionAmount,
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    obscureText: false,
                    validator: (value) {
                      if (_selectedOption ==
                              AppLocalizations.of(context)!.equalAmount &&
                          (value == null || value.trim().isEmpty)) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterContributionAmount;
                      }
                      return null;
                    },
                  ),
                CustomCheckbox(
                  labelText: AppLocalizations.of(context)!.fundProcedure,
                  hintText: AppLocalizations.of(context)!.loanable,
                  value: _isKopesheka,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isKopesheka = newValue;
                    });
                  },
                ),
                SizedBox(height: 10),

                // Taratibu za Utoaji (Radio)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.withdrawalProcedure,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CustomRadioGroup<String>(
                      options: _utaratibu,
                      value: _selectedData,
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedData = newValue;
                        });
                      },
                      labelText: '',
                    ),
                    if (_utaratibuUtoajiError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(_utaratibuUtoajiError!,
                            style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),

                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: AppLocalizations.of(context)!.continueText,
                  onPressed: _saveData,
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
