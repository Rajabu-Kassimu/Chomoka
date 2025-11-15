import 'package:chomoka/view/group_setup/constitution_information/refferee.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Punishment extends StatefulWidget {
  final dynamic groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  Punishment({
    super.key,
    this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<Punishment> createState() => _PunishmentState();
}

class _PunishmentState extends State<Punishment> {
  final TextEditingController _asilimiaController = TextEditingController();
  final TextEditingController _kiasiController = TextEditingController();
  String _selectedOption = 'percentage';
  List<String> _options = [
    'Asilimia',
    'Kiasi Maalumu'
  ]; // Initialize with default values

  void _initializeOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _options = [
      l10n.percentage,
      l10n.fixedAmount,
    ];
    // Set initial selected option
    if (_selectedOption == 'percentage' && _options.isNotEmpty) {
      _selectedOption = _options[0];
    } else if (_selectedOption == 'fixed_amount' && _options.length > 1) {
      _selectedOption = _options[1];
    }
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeOptions(context);
      _fetchSavedData();
    });
  }

  Future<void> _fetchSavedData() async {
    try {
      if (_options.isEmpty) {
        // Initialize options if not already initialized
        _initializeOptions(context);
      }
      final katibaModel = KatibaModel();

      final asilimiaData = await katibaModel
          .where('katiba_key', '=', 'asilimia')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      final kiasiData = await katibaModel
          .where('katiba_key', '=', 'kiasi_maalumu')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (asilimiaData != null && asilimiaData is KatibaModel) {
        setState(() {
          _selectedOption = _options[0];
          _asilimiaController.text = asilimiaData.value ?? '';
          _kiasiController.clear();
        });
      } else if (kiasiData != null && kiasiData is KatibaModel) {
        setState(() {
          _selectedOption = _options[1];
          _kiasiController.text = kiasiData.value ?? '';
          _asilimiaController.clear();
        });
      } else {
        setState(() {
          _selectedOption = _options[0];
          _asilimiaController.clear();
          _kiasiController.clear();
        });
      }
    } catch (e) {
      print('Error fetching saved data: $e');
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }

    try {
      final katibaModel = KatibaModel();
      String katibaKey =
          _selectedOption == _options[0] ? 'asilimia' : 'kiasi_maalumu';

      final valueToSave = _selectedOption == _options[0]
          ? _asilimiaController.text
          : _kiasiController.text;

      final existingData = await katibaModel
          .where('katiba_key', '=', katibaKey)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      // Update or create the record for the chosen key
      if (existingData != null && existingData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', katibaKey)
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': valueToSave});
      } else {
        await KatibaModel(
          katiba_key: katibaKey,
          value: valueToSave,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      // Delete the other key to ensure only one type of punishment is saved
      if (_selectedOption == _options[0]) {
        await KatibaModel()
            .where('katiba_key', '=', 'kiasi_maalumu')
            .where('mzungukoId', '=', widget.mzungukoId)
            .delete();
      } else {
        await KatibaModel()
            .where('katiba_key', '=', 'asilimia')
            .where('mzungukoId', '=', widget.mzungukoId)
            .delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Refferee(
            groupId: widget.groupId,
            mzungukoId: widget.mzungukoId, // Pass mzungukoId to next screen
            // isUpdateMode: true, // Uncomment if needed
          ),
        ),
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  String? _generateExampleText() {
    String textValue = _selectedOption == 'Asilimia'
        ? _asilimiaController.text
        : _kiasiController.text;

    final double? value = double.tryParse(textValue);
    if (value == null || value < 0) {
      // Changed from value <= 0 to value < 0
      return null; // Return null for invalid or empty input
    }

    if (_selectedOption == _options[0]) {
      // Asilimia
      if (value == 0) {
        return AppLocalizations.of(context)!.noPercentagePenalty;
      }
      return AppLocalizations.of(context)!.percentagePenaltyExample(
          value.toStringAsFixed(0), (value * 100).toStringAsFixed(0));
    } else if (_selectedOption == _options[1]) {
      // Kiasi Maalumu
      if (value == 0) {
        return AppLocalizations.of(context)!.noFixedAmountPenalty;
      }
      return AppLocalizations.of(context)!
          .fixedAmountPenaltyExample(value.toStringAsFixed(0));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    final String? exampleText = _generateExampleText();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.loanDelayPenalty,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.loanDelayPenalty,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomRadioGroup<String>(
                  labelText: '',
                  options: _options,
                  value: _selectedOption,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption = newValue;
                      if (_selectedOption == _options[0]) {
                        _kiasiController.clear();
                      } else {
                        _asilimiaController.clear();
                      }
                    });
                  },
                ),
                // In the validator methods for both text fields, I'll change the validation to allow 0

                if (_selectedOption == _options[0]) // Asilimia
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.percentage,
                    labelText: AppLocalizations.of(context)!.percentage,
                    hintText:
                        AppLocalizations.of(context)!.enterPenaltyPercentage,
                    keyboardType: TextInputType.number,
                    controller: _asilimiaController,
                    obscureText: false,
                    onChanged: (_) {
                      setState(() {}); // Trigger rebuild on input change
                    },
                    validator: (value) {
                      if (_selectedOption != _options[0])
                        return null; // Skip validation if not selected
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.percentageRequired;
                      }
                      final parsed = double.tryParse(value);
                      if (parsed == null || parsed < 0) {
                        // Changed from parsed <= 0 to parsed < 0
                        return AppLocalizations.of(context)!
                            .enterValidPercentage;
                      }
                      return null; // Valid input
                    },
                  ),
                if (_selectedOption == _options[1]) // Kiasi Maalumu
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.fixedAmount,
                    labelText: AppLocalizations.of(context)!.fixedAmount,
                    hintText: AppLocalizations.of(context)!.enterFixedAmount,
                    keyboardType: TextInputType.number,
                    controller: _kiasiController,
                    obscureText: false,
                    onChanged: (_) {
                      setState(() {}); // Trigger rebuild on input change
                    },
                    validator: (value) {
                      if (_selectedOption != _options[1])
                        return null; // Skip validation if not selected
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .fixedAmountRequired;
                      }
                      final parsed = double.tryParse(value);
                      if (parsed == null || parsed < 0) {
                        // Changed from parsed <= 0 to parsed < 0
                        return AppLocalizations.of(context)!.enterValidAmount;
                      }
                      return null; // Valid input
                    },
                  ),
                SizedBox(height: 16),
                if (exampleText == null)
                  Text(
                    AppLocalizations.of(context)!.explainPenaltyUsage,
                    style: TextStyle(fontSize: 16),
                  ),
                if (exampleText != null)
                  Container(
                    color: const Color.fromARGB(255, 197, 197, 197),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        exampleText,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: AppLocalizations.of(context)!.continue_,
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
