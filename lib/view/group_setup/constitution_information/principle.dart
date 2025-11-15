import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/cmg_mode/cmg_savings.dart';
import 'package:chomoka/view/group_setup/constitution_information/vsla_mode/vsla_saving.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class principle extends StatefulWidget {
  var groupId;

  principle({super.key, this.groupId});

  @override
  State<principle> createState() => _principleState();
}

class _principleState extends State<principle> {
  String _selectedOption = '';
  String? _validationMessage;
  var kanuni_id;
  String? _validationError;

  void _onChanged(String value) {
    setState(() {
      _selectedOption = value;
      _validationMessage = null;
    });
  }

  _fetchSavedData() async {
    final principle = KatibaModel();
    final saved_principle =
        await principle.where('katiba_key', '=', 'kanuni').findOne();
    if (saved_principle != null && saved_principle is KatibaModel) {
      setState(() {
        _selectedOption = saved_principle.value!;
      });
    }
  }

  Future<void> _saveData() async {
    if (_selectedOption.isEmpty) {
      setState(() {
        _validationMessage = 'Tafadhali chagua aina ya kikundi!';
      });
      return;
    }

    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '!=', 'completed').findOne();
    final int? mzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (mzungukoId == null) {
      setState(() {
        _validationError = 'Hitilafu: Hakuna Mzunguko ulio hai uliopatikana!';
      });
      return;
    }

    try {
      final principle = KatibaModel();
      final savedPrinciple =
          await principle.where('katiba_key', '=', 'kanuni').findOne();

      if (savedPrinciple != null && savedPrinciple is KatibaModel) {
        await savedPrinciple
            .where('katiba_key', '=', 'kanuni')
            .where('mzungukoId', '=', mzungukoId)
            .update({
          'katiba_key': 'kanuni',
          'value': _selectedOption,
          'mzungukoId': mzungukoId,
        });
      } else {
        final katiba = KatibaModel(
          katiba_key: 'kanuni',
          value: _selectedOption,
          mzungukoId: mzungukoId,
        );
        await katiba.create();
      }

      // Navigate based on selected option
      if (_selectedOption == 'VSLA') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaSaving(
              mzungukoId: mzungukoId,
              groupId: widget.groupId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Savings(
              groupId: widget.groupId,
              mzungukoId: mzungukoId,
            ),
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Taarifa zimehifaziwa kikamilifu!')),
      );
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data')),
      );
    }
  }

  @override
  void initState() {
    _fetchSavedData().then((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.constitutionGroupType,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomCheckbox(
                labelText: AppLocalizations.of(context)!.kayaCmg,
                hintText: AppLocalizations.of(context)!.kayaCmgHint,
                value: _selectedOption == 'Kaya CMG',
                onChanged: (bool newValue) {
                  _onChanged('Kaya CMG');
                },
                aboveText: AppLocalizations.of(context)!.constitutionGroupType,
              ),
              SizedBox(height: 10),
              CustomCheckbox(
                labelText: AppLocalizations.of(context)!.vsla,
                hintText: AppLocalizations.of(context)!.vslaHint,
                value: _selectedOption == 'VSLA',
                onChanged: (bool newValue) {
                  _onChanged('VSLA');
                },
              ),
              SizedBox(height: 20),
              if (_validationMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _validationMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!.continueText,
                onPressed: () {
                  _saveData();
                },
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
