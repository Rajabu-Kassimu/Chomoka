import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgao_kikundi_summary.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgao_kikundi_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class KiasiMzungukoUjao extends StatefulWidget {
  final bool fromKiasi;
  final double mfukoJamiiKiasi;
  var mzungukoId;

  KiasiMzungukoUjao({
    Key? key,
    this.fromKiasi = false,
    required this.mfukoJamiiKiasi,
    this.mzungukoId,
  }) : super(key: key);

  @override
  State<KiasiMzungukoUjao> createState() => _KiasiMzungukoUjaoState();
}

class _KiasiMzungukoUjaoState extends State<KiasiMzungukoUjao> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVSLA = false;

  Future<void> _checkGroupType() async {
    try {
      await BaseModel.initAppDatabase();
      final katibaModel = KatibaModel();

      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _isVSLA = groupTypeData.value == 'VSLA';
        });
        print('Group type: ${_isVSLA ? "VSLA" : "CMG"}');
      }
    } catch (e) {
      print('Error checking group type: $e');
    }
  }

  Future<void> _updateAkibaMzungukoUjao(double amount) async {
    await _checkGroupType();
    final mzungukoModel = MzungukoModel();

    try {
      await mzungukoModel.where('id', '=', widget.mzungukoId).update({
        'akibaMzungukoUjao': amount,
      });

      final BaseModel? updatedData =
          await mzungukoModel.where('id', '=', widget.mzungukoId).findOne();
      if (_isVSLA) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaMgaoWaKikundiPage(
              fromKiasi: true,
              kiasiKilichopelekwa: _amountController.text,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MgaoWaKikundiPage(
              fromKiasi: true,
              kiasiKilichopelekwa: _amountController.text,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }

      if (updatedData != null && updatedData is MzungukoModel) {
        print('Akiba Mzunguko Ujao updated successfully:');
        print('ID: ${updatedData.id}');
        print('Akiba Mzunguko Ujao: ${updatedData.akibaMzungukoUjao}');
      } else {
        print('Error: Mzunguko data not found after update.');
      }
    } catch (e) {
      print('Error updating Akiba Mzunguko Ujao: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.groupShareTitle,
        subtitle: l10n.amountNextCycleSubtitle,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.sendToNextCycle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                l10n.enterAmountNextCycle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              Text(
                l10n.socialFund,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                l10n.availableAmount(widget.mfukoJamiiKiasi.toStringAsFixed(0)),
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: l10n.addAmount,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterAmount;
                  }
                  final enteredAmount = double.tryParse(value);
                  if (enteredAmount == null) {
                    return l10n.pleaseEnterValidNumber;
                  }
                  if (enteredAmount > widget.mfukoJamiiKiasi) {
                    return l10n.amountMustBeLessThanOrEqual(widget.mfukoJamiiKiasi.toStringAsFixed(0));
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomButton(
                color: const Color.fromARGB(255, 24, 9, 240),
                buttonText: l10n.continueText,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final amount = double.parse(_amountController.text);
                    await _updateAkibaMzungukoUjao(amount);
                  }
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
