import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/loan_amount.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/FainiModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class FainiPage extends StatefulWidget {
  var groupId;
  var mzungukoId;
  final bool isUpdateMode;

  FainiPage({
    super.key,
    this.groupId,
    this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<FainiPage> createState() => _FainiPageState();
}

class _FainiPageState extends State<FainiPage> {
  late List<String> fines;

  @override
  void initState() {
    super.initState();
    _fetchAllFainiData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fines = [
      AppLocalizations.of(context)!.lateness,
      AppLocalizations.of(context)!.absentWithoutPermission,
      AppLocalizations.of(context)!.sendingRepresentative,
      AppLocalizations.of(context)!.speakingWithoutPermission,
      AppLocalizations.of(context)!.phoneUsageDuringMeeting,
      AppLocalizations.of(context)!.leadershipMisconduct,
      AppLocalizations.of(context)!.forgettingRules
    ];
  }

  final Map<String, TextEditingController> _controllers = {};

  _saveOrUpdateFaini(String penaltiesName, String penaltiesPrice) async {
    try {
      final fainiModel = FainiModel();
      final existingFaini = await fainiModel
          .where('penalties_name', '=', penaltiesName)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingFaini != null && existingFaini is FainiModel) {
        await fainiModel
            .where('penalties_name', '=', penaltiesName)
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({
          'penalties_price': penaltiesPrice,
        });
        print('Faini updated: $penaltiesName');
      } else {
        await FainiModel(
          group_id: widget.groupId,
          mzungukoId: widget.mzungukoId,
          penaltiesName: penaltiesName,
          penaltiesPrice: penaltiesPrice,
        ).create();
        print('Faini added: $penaltiesName');
      }
    } catch (e) {
      print('Error saving/updating faini: $e');
    }
  }

  _fetchFainiData() async {
    final fineModel = FainiModel();

    for (var entry in _controllers.entries) {
      final penaltyName = entry.key;
      final controller = entry.value;

      final existingFaini = await fineModel
          .where('penalties_name', '=', penaltyName)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingFaini != null && existingFaini is FainiModel) {
        setState(() {
          controller.text = (existingFaini.penaltiesPrice == "0" ||
                  existingFaini.penaltiesPrice == null)
              ? ''
              : existingFaini.penaltiesPrice!;
        });
      } else {
        controller.text = '';
      }
    }
  }

  _fetchAllFainiData() async {
    final fineModel = FainiModel();

    final existingFainiCount =
        await fineModel.where('mzungukoId', '=', widget.mzungukoId).count();
    if (existingFainiCount == 0) {
      for (var fn in fines) {
        await _saveOrUpdateFaini(fn, '0');
      }
    }

    var fineInputs =
        await fineModel.where('mzungukoId', '=', widget.mzungukoId).find();

    for (var input in fineInputs) {
      final inputMap = input.toMap(); // Convert BaseModel to Map
      final penaltyName = inputMap['penalties_name'];
      final penaltyPrice = inputMap['penalties_price'] ?? '0';

      setState(() {
        _controllers[penaltyName] = TextEditingController(
          text: (penaltyPrice == "0") ? '' : penaltyPrice.toString(),
        );
      });
    }

    _fetchFainiData();
  }

  Future<void> _saveAllFaini() async {
    if (widget.isUpdateMode) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConstitutionOverview(
                  groupId: widget.groupId,
                  mzungukoId: widget.mzungukoId,
                )),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoanAmount(
                groupId: widget.groupId, mzungukoId: widget.mzungukoId)),
      );
    }
  }

  void _showInputDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: Text(AppLocalizations.of(context)!.addNewFine),
          content: Container(
            width: 600,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.finesWithoutAmountWontShow),
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.fineType,
                  labelText: AppLocalizations.of(context)!.fineType,
                  hintText: AppLocalizations.of(context)!.addFineType,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.amount,
                  labelText: AppLocalizations.of(context)!.addAmount,
                  hintText: AppLocalizations.of(context)!.addAmount,
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  obscureText: false,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel,
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final price = priceController.text.trim();

                if (name.isNotEmpty && price.isNotEmpty) {
                  await _saveOrUpdateFaini(name, price);
                  _controllers[name] = TextEditingController(text: price);
                  setState(() {}); // Refresh UI to include the new fine
                }

                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.save,
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.fines,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.finesWithoutAmountWontShow),
              SizedBox(height: 10),
              ..._controllers.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomTextField(
                    aboveText: entry.key,
                    labelText: entry.key,
                    hintText: (entry.value.text.isEmpty)
                        ? AppLocalizations.of(context)!.amount
                        : '',
                    keyboardType: TextInputType.number,
                    controller: entry.value,
                    obscureText: false,
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        await _saveOrUpdateFaini(entry.key, value);
                      }
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              CustomButton(
                color: Colors.green,
                buttonText: AppLocalizations.of(context)!.addNewFine,
                onPressed: () {
                  _showInputDialog(context);
                },
                type: ButtonType.elevated,
              ),
              SizedBox(height: 20),
              CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: widget.isUpdateMode
                    ? AppLocalizations.of(context)!.update
                    : AppLocalizations.of(context)!.continue_,
                onPressed: _saveAllFaini,
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
