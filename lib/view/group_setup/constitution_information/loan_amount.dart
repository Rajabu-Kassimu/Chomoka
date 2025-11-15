import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/interest.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class LoanAmount extends StatefulWidget {
  final dynamic groupId;
  var mzungukoId;
  final bool isUpdateMode;

  LoanAmount({
    Key? key,
    this.groupId,
    this.mzungukoId,
    this.isUpdateMode = false,
  }) : super(key: key);

  @override
  State<LoanAmount> createState() => _LoanAmountState();
}

class _LoanAmountState extends State<LoanAmount> {
  final TextEditingController _controller = TextEditingController();
  double? multiplier;
  String? errorText;
  String? _groupMode;

  Future<void> _fetchSavedData() async {
    try {
      final katibaModel = KatibaModel();

      // Fetch group mode (VSLA or CMG)
      final groupModeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupModeData != null && groupModeData is KatibaModel) {
        setState(() {
          _groupMode = groupModeData.value;
        });
      }

      // Fetch saved multiplier value
      final savedMultiplierQuery = await katibaModel
          .where('katiba_key', '=', 'loanMultiplierValue')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (savedMultiplierQuery != null && savedMultiplierQuery is KatibaModel) {
        setState(() {
          _controller.text = savedMultiplierQuery.value ?? '';
          multiplier = double.tryParse(_controller.text);
        });
      }
    } catch (e) {
      print('Hitilafu ilitokea wakati wa kupata taarifa: $e');
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        // errorText = l10n.errorFetchingData.replaceAll('{error}', e.toString());
      });
    }
  }

  bool _validateInput() {
    final input = _controller.text.trim();

    final l10n = AppLocalizations.of(context)!;
    if (input.isEmpty) {
      setState(() {
        errorText = l10n.loanAmountRequired;
      });
      return false;
    }

    final parsed = double.tryParse(input);
    if (parsed == null) {
      setState(() {
        errorText = l10n.loanAmountInvalidNumber;
      });
      return false;
    }

    if (parsed <= 0) {
      setState(() {
        errorText = l10n.loanAmountMustBePositive;
      });
      return false;
    }

    // If all checks pass, clear errors
    setState(() {
      errorText = null;
      multiplier = parsed;
    });
    return true;
  }

  Future<void> _saveData() async {
    if (!_validateInput()) {
      return; // Stop if validation fails
    }

    try {
      final katibaModel = KatibaModel();
      final int mzungukoId = widget.mzungukoId;

      // Check if record exists
      final savedMultiplierQuery = await katibaModel
          .where('katiba_key', '=', 'loanMultiplierValue')
          .where('mzungukoId', '=', mzungukoId)
          .findOne();

      // If record exists -> update, else create
      if (savedMultiplierQuery != null && savedMultiplierQuery is KatibaModel) {
        await katibaModel
            .where('katiba_key', '=', 'loanMultiplierValue')
            .where('mzungukoId', '=', mzungukoId)
            .update({'value': _controller.text});
      } else {
        final newKatiba = KatibaModel(
          katiba_key: 'loanMultiplierValue',
          value: _controller.text,
          mzungukoId: mzungukoId,
        );
        await newKatiba.create();
      }

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.dataSavedSuccessfully)),
      );

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Interest(
            groupId: widget.groupId,
            isUpdateMode: true,
            mzungukoId: widget.mzungukoId,
          ),
        ),
      );
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      print('Imeshindwa kuhifadhi data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    final bool isVSLA = _groupMode == 'VSLA';
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanAmountTitle,
        subtitle: l10n.loanAmountSubtitle,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomTextField(
              aboveText:
                  isVSLA ? l10n.loanAmountVSLAPrompt : l10n.loanAmountCMGPrompt,
              labelText:
                  isVSLA ? l10n.loanAmountVSLAHint : l10n.loanAmountCMGHint,
              hintText:
                  isVSLA ? l10n.loanAmountVSLAHint : l10n.loanAmountCMGHint,
              keyboardType: TextInputType.number,
              controller: _controller,
              obscureText: false,
              onChanged: (value) {
                setState(() {
                  errorText = null;
                  multiplier = double.tryParse(value);
                });
              },
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            const SizedBox(height: 10),
            if (multiplier == null)
              Text(
                isVSLA
                    ? l10n.loan_based_on_shares
                    : l10n.loan_based_on_savings,
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            if (multiplier != null)
              Container(  
                color: const Color.fromARGB(255, 197, 197, 197),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isVSLA
                        ? l10n.loanAmountExample(
                            (multiplier! * 10000).toStringAsFixed(0),
                            'hisa',
                            multiplier!.toStringAsFixed(0),
                          )
                        : l10n.loanAmountExample(
                            (multiplier! * 10000).toStringAsFixed(0),
                            'akiba',
                            multiplier!.toStringAsFixed(0),
                          ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: widget.isUpdateMode ? l10n.update : l10n.continueText,
              onPressed: _saveData,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
