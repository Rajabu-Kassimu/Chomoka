import 'package:chomoka/view/group_setup/constitution_information/punishment.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Interest extends StatefulWidget {
  final dynamic groupId;
  final int mzungukoId; // Ensure mzungukoId is an int
  final bool isUpdateMode;

  Interest({
    super.key,
    this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final TextEditingController _controller = TextEditingController();
  String _selectedOption = '';
  List<String> _options = [];

  void _initializeOptions() {
    final l10n = AppLocalizations.of(context)!;
    _options = [
      l10n.oneTimeInterest,
      l10n.monthlyCalculation,
      l10n.equalAmountAllMonths,
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeOptions();
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
    _controller.addListener(() {
      setState(() {}); // Trigger rebuild on input change
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchSavedData() async {
    try {
      final katibaModel = KatibaModel();

      // Fetch saved interest rate
      final rateQuery = katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId);
      final rateData = await rateQuery.findOne();
      if (rateData != null && rateData is KatibaModel) {
        setState(() {
          _controller.text = rateData.value ?? '';
        });
      }

      // Fetch saved interest type
      final typeQuery = katibaModel
          .where('katiba_key', '=', 'interest_type')
          .where('mzungukoId', '=', widget.mzungukoId);
      final typeData = await typeQuery.findOne();
      if (typeData != null && typeData is KatibaModel) {
        setState(() {
          _selectedOption = typeData.value ?? _options[0];
        });
      } else {
        // If nothing is saved yet, default to the first option
        setState(() {
          _selectedOption = _options[0];
        });
      }
    } catch (e) {
      print('Hitilafu ilitokea wakati wa kupata taarifa: $e');
      final l10n = AppLocalizations.of(context)!;
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }

    try {
      final katibaModel = KatibaModel();

      // Handle interest_rate
      final rateData = await katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (rateData != null && rateData is KatibaModel) {
        await KatibaModel().where('id', '=', rateData.id).update({
          'value': _controller.text,
          'mzungukoId': widget.mzungukoId, // Ensure mzungukoId is included
        });
      } else {
        await KatibaModel(
          katiba_key: 'interest_rate',
          value: _controller.text,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      // Handle interest_type
      final typeData = await katibaModel
          .where('katiba_key', '=', 'interest_type')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (typeData != null && typeData is KatibaModel) {
        await KatibaModel().where('id', '=', typeData.id).update({
          'value': _selectedOption,
          'mzungukoId': widget.mzungukoId, // Ensure mzungukoId is included
        });
      } else {
        await KatibaModel(
          katiba_key: 'interest_type',
          value: _selectedOption,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.dataSavedSuccessfully)),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Punishment(
                  groupId: widget.groupId,
                  mzungukoId:
                      widget.mzungukoId, // Pass mzungukoId to next screen
                  isUpdateMode: true,
                )),
      );
    } catch (e) {
      print('Hitilafu ilitokea wakati wa kuhifadhi data: $e');
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorSavingData(e.toString()))),
      );
    }
  }

  String? _generateExampleText() {
    final double? rate = double.tryParse(_controller.text);
    if (rate == null || rate <= 0) {
      return null;
    }

    final l10n = AppLocalizations.of(context)!;
    
    // Compare against the actual localized option values from _options
    if (_selectedOption == l10n.monthlyCalculation) {
      return l10n.loanInterestExample(rate.toStringAsFixed(0));
    } else if (_selectedOption == l10n.equalAmountAllMonths) {
      return l10n.loanInterestExampleEqual(
          rate.toStringAsFixed(0), (rate * 100).toStringAsFixed(0));
    } else if (_selectedOption == l10n.oneTimeInterest) {
      return l10n.loanInterestExampleOnce(
          rate.toStringAsFixed(0), (rate * 100).toStringAsFixed(0));
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String? exampleText = _generateExampleText();
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.constitutionInfo,
        subtitle: l10n.loanInterest,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  l10n.interestType,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomRadioGroup<String>(
                  labelText: '',
                  options: _options,
                  value: _selectedOption,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                  // If CustomRadioGroup supports validators, you can add them here
                ),
                SizedBox(height: 20),
                Text(
                  l10n.enterInterestRate,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: l10n.enterInterestRate,
                  hintText: l10n.enterInterestRate,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  obscureText: false,
                  onChanged: (_) {
                    setState(() {}); // Recalculate when input changes
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.enterInterestRate;
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return l10n.enterValidAmount;
                    }
                    return null; // Valid input
                  },
                ),
                SizedBox(height: 10),
                if (exampleText == null)
                  Text(
                    l10n.interestDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                SizedBox(height: 20),
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
                SizedBox(height: 10),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: l10n.continue_,
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
