import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/view/group_setup/fund_information/MfukoJamiiSummary.dart';
import 'package:chomoka/view/group_setup/fund_information/sababu_kutoa.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MfukoJamiiPage extends StatefulWidget {
  final bool isUpdateMode;
  final dynamic mzungukoId;

  MfukoJamiiPage({
    super.key,
    this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<MfukoJamiiPage> createState() => _MfukoJamiiPageState();
}

class _MfukoJamiiPageState extends State<MfukoJamiiPage> {
  late TextEditingController _mfukoNameController;
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _mfukoNameController = TextEditingController();
    _fetchSavedData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_mfukoNameController.text.isEmpty) {
      _mfukoNameController.text = AppLocalizations.of(context)!.communityFundTitle;
    }
  }

  Future<void> _fetchSavedData() async {
    try {
      final mfukoModel = MfukoJamiiModel();

      final mfukoNameData = await mfukoModel
          .where('mfuko_key', '=', 'Jina la Mfuko')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (mfukoNameData != null && mfukoNameData is MfukoJamiiModel) {
        _mfukoNameController.text = mfukoNameData.value ?? 'Mfuko Jamii';
      }

      final mfukoAmountData = await mfukoModel
          .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (mfukoAmountData != null && mfukoAmountData is MfukoJamiiModel) {
        _amountController.text = mfukoAmountData.value ?? '';
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final mfukoModel = MfukoJamiiModel();

        // Update or create the name of the Mfuko
        final existingName = await mfukoModel
            .where('mfuko_key', '=', 'Jina la Mfuko')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();
        if (existingName != null && existingName is MfukoJamiiModel) {
          await MfukoJamiiModel().where('id', '=', existingName.id).update({
            'value': _mfukoNameController.text,
            'mzungukoId': widget.mzungukoId,
          });
        } else {
          await MfukoJamiiModel(
            mfuko_key: 'Jina la Mfuko',
            value: _mfukoNameController.text,
            mzungukoId: widget.mzungukoId,
          ).create();
        }

        final existingAmount = await mfukoModel
            .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();
        if (existingAmount != null && existingAmount is MfukoJamiiModel) {
          await MfukoJamiiModel().where('id', '=', existingAmount.id).update({
            'value': _amountController.text,
            'mzungukoId': widget.mzungukoId,
          });
        } else {
          await MfukoJamiiModel(
            mfuko_key: 'Kiasi cha Kuchangia',
            value: _amountController.text,
            mzungukoId: widget.mzungukoId,
          ).create();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Taarifa zimehifadhiwa kikamilifu!')),
        );

        if (widget.isUpdateMode) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MfukoSummaryPage(
                      mzungukoId: widget.mzungukoId,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SababuKutoa(
                      mzungukoId: widget.mzungukoId,
                    )),
          );
        }
      } catch (e) {
        print('Error saving data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.communityFundInfo,
        subtitle: localizations.fundInfo,
        showBackArrow: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              // Community fund name should be read-only
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Text(
              //     localizations.fundName,
              //     style: TextStyle(
              //       fontSize: 16.0,
              //       color: const Color.fromARGB(255, 5, 5, 5),
              //     ),
              //   ),
              // ),
              TextFormField(
                controller: _mfukoNameController,
                readOnly: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: localizations.fundName,
                  hintText: localizations.enterFundName,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.fundNameRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                aboveText: localizations.contributionAmount,
                labelText: localizations.contributionAmount,
                hintText: localizations.enterContributionAmount,
                keyboardType: TextInputType.number,
                controller: _amountController,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.contributionAmountRequired;
                  }
                  if (double.tryParse(value) == null) {
                    return localizations.enterValidAmount;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: widget.isUpdateMode
                    ? localizations.edit
                    : localizations.continueText,
                onPressed: _saveData,
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
