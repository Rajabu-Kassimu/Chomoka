import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Refferee extends StatefulWidget {
  final dynamic groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  Refferee({
    super.key,
    this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<Refferee> createState() => _ReffereeState();
}

class _ReffereeState extends State<Refferee> {
  final TextEditingController _refereeController = TextEditingController();
  String _selectedOption = '';
  List<String> _options = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  void dispose() {
    _refereeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _options = [l10n.yes, l10n.no];
    if (_selectedOption.isEmpty) {
      _selectedOption = l10n.no;
    }
  }

  Future<void> _fetchSavedData() async {
    try {
      final katibaModel = KatibaModel();

      final needData = await katibaModel
          .where('katiba_key', '=', 'need_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      final idadiData = await katibaModel
          .where('katiba_key', '=', 'idadi_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      String needValue = '0';
      String idadiValue = '0';

      if (needData != null &&
          needData is KatibaModel &&
          needData.value != null) {
        needValue = needData.value!;
      }

      if (idadiData != null &&
          idadiData is KatibaModel &&
          idadiData.value != null) {
        idadiValue = idadiData.value!;
      }

      setState(() {
        if (needValue == '1') {
          _selectedOption = AppLocalizations.of(context)!.yes;
          _refereeController.text = idadiValue;
        } else {
          _selectedOption = AppLocalizations.of(context)!.no;
          _refereeController.clear();
        }
      });
    } catch (e) {
      print('Error fetching saved data: $e');
      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.errorSavingDataGeneric)),
      );
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }

    try {
      final katibaModel = KatibaModel();

      String needValue = _selectedOption == AppLocalizations.of(context)!.yes ? '1' : '0';
      String idadiValue = '0';

      if (_selectedOption == AppLocalizations.of(context)!.yes) {
        idadiValue =
            _refereeController.text.isNotEmpty ? _refereeController.text : '0';
      }

      // Update or create the 'need_wadhamini' record
      final needData = await katibaModel
          .where('katiba_key', '=', 'need_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (needData != null && needData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', 'need_wadhamini')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': needValue});
      } else {
        await KatibaModel(
          katiba_key: 'need_wadhamini',
          value: needValue,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      // Update or create the 'idadi_wadhamini' record
      final idadiData = await katibaModel
          .where('katiba_key', '=', 'idadi_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (idadiData != null && idadiData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', 'idadi_wadhamini')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': idadiValue});
      } else {
        await KatibaModel(
          katiba_key: 'idadi_wadhamini',
          value: idadiValue,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConstitutionOverview(
                  groupId: widget.groupId,
                  mzungukoId: widget.mzungukoId,
                )),
      );

      print(
          'Data Imehifadhiwa. need_wadhamini=$needValue, idadi_wadhamini=$idadiValue');
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSavingDataGeneric)),
      );
    }
  }

  String _generateExampleText() {
    final int? wadhamini = int.tryParse(_refereeController.text);
    if (wadhamini == null || wadhamini <= 0) {
      return '';
    }

    final double amountPerSponsor = 150000 / wadhamini;
    return AppLocalizations.of(context)!.guarantorExample(
      wadhamini,
      amountPerSponsor.toStringAsFixed(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    final String exampleText = _generateExampleText();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionTitle,
        subtitle: AppLocalizations.of(context)!.loanGuarantors,
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
                  AppLocalizations.of(context)!.doesLoanNeedGuarantor,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomRadioGroup<String>(
                  labelText: '',
                  options: _options,
                  value: _selectedOption,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption = newValue;
                      if (_selectedOption == AppLocalizations.of(context)!.yes) {
                        // If user switches to 'Ndio', show the field
                      } else {
                        _refereeController.clear();
                      }
                    });
                  },
                ),
                if (_selectedOption == AppLocalizations.of(context)!.yes)
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.numberOfGuarantors,
                    labelText: AppLocalizations.of(context)!.numberOfGuarantors,
                    hintText: AppLocalizations.of(context)!.enterNumberOfGuarantors,
                    keyboardType: TextInputType.number,
                    controller: _refereeController,
                    obscureText: false,
                    onChanged: (_) {
                      setState(() {}); // Trigger rebuild on input change
                    },
                    // Add validation
                    // Assuming CustomTextField supports a 'validator' parameter
                    validator: (value) {
                      if (_selectedOption != AppLocalizations.of(context)!.yes)
                        return null; // Skip validation if not selected
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.numberOfGuarantorsRequired;
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null || parsed <= 0) {
                        return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                      }
                      return null; // Valid input
                    },
                  ),
                SizedBox(height: 16),
                if (exampleText.isEmpty)
                  Text(
                    AppLocalizations.of(context)!.describeNumberOfGuarantors,
                    style: TextStyle(fontSize: 16),
                  ),
                if (exampleText.isNotEmpty)
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
                  buttonText: widget.isUpdateMode ? AppLocalizations.of(context)!.edit : AppLocalizations.of(context)!.continue_,
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
