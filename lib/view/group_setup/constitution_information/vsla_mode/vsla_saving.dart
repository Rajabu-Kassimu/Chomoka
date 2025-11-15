import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/vsla_mode/vsla_group_leaders.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaSaving extends StatefulWidget {
  final int groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  const VslaSaving({
    super.key,
    required this.mzungukoId,
    this.isUpdateMode = false,
    required this.groupId,
  });

  @override
  State<VslaSaving> createState() => _VslaSavingState();
}

class _VslaSavingState extends State<VslaSaving> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _fetchSavedData() async {
    try {
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        setState(() {
          _controller.text = shareData.value?.toString() ?? '';
        });
      }
    } catch (e) {
      print('Error fetching saved data: $e');
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final katiba = KatibaModel();
      final shareQuery = katiba.where('katiba_key', '=', 'share_amount');
      final shareData = await shareQuery
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', 'share_amount')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': _controller.text.toString()});
      } else {
        await KatibaModel(
          katiba_key: 'share_amount',
          mzungukoId: widget.mzungukoId,
          value: _controller.text.toString(),
        ).create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Taarifa zimehifadhiwa kikamilifu!')),
      );

      if (widget.isUpdateMode) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConstitutionOverview(
              groupId: widget.groupId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaGroupLeaders(
              groupId: widget.groupId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
      // Add navigation logic here based on your requirements
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.shareSubtitle,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Text(
                  AppLocalizations.of(context)!.sharePrompt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.shareValueLabel,
                  hintText: AppLocalizations.of(context)!.shareValueHint,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  obscureText: false,
                  onChanged: (_) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.shareValueRequired;
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return AppLocalizations.of(context)!.invalidShareValue;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (_controller.text.isNotEmpty)
                  Container(
                    color: const Color.fromARGB(255, 197, 197, 197),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      AppLocalizations.of(context)!.shareNote(_controller.text),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                CustomButton(
                  color: const Color.fromARGB(255, 4, 34, 207),
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
