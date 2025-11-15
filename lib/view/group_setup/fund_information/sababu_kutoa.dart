import 'package:chomoka/model/SababuKutoaMfuko.dart';
import 'package:chomoka/view/group_setup/fund_information/MfukoJamiiSummary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart'; // Make sure this is imported and exists
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/fund_information/add_mifuko.dart';
import 'package:chomoka/view/group_setup/fund_information/mfukoInfo.dart';
import 'package:chomoka/view/group_setup/fund_information/mifukoMingineSummary.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class mifukoList extends StatefulWidget {
  var mzungukoId;

  mifukoList({super.key, this.mzungukoId});

  @override
  State<mifukoList> createState() => _mifukoListState();
}

class _mifukoListState extends State<mifukoList> {
  String mfukoStatus = 'sio hai';
  List<MifukoMingineModel> _mifukoList = [];
  bool _isLoading = true;
  bool _isMzungukoPending = false;
  int mzungukoId = 0;

  Future<void> _fetchMfukoStatus() async {
    try {
      final mfukoModel = MfukoJamiiModel();
      final mfukoData = await mfukoModel
          .where('mfuko_key', '=', 'Jina la Mfuko')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (mfukoData != null && mfukoData is MfukoJamiiModel) {
        setState(() {
          mfukoStatus = mfukoData.status ?? 'sio hai';
        });
      }
    } catch (e) {
      print("Error fetching Mfuko status: $e");
    }

    if (mfukoStatus == 'hai') {
      await _fetchMifukoList();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMifukoList() async {
    try {
      MifukoMingineModel model = MifukoMingineModel();
      List<MifukoMingineModel> results =
          (await model.where('mzungukoId', '=', widget.mzungukoId).find())
              .cast<MifukoMingineModel>();
      setState(() {
        _mifukoList = results;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching Mifuko list: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final initSetupModel = InitSetupModel(
        init_key: 'mifuko',
        mzungukoId: mzungukoId,
        value: 'complete',
      );

      await initSetupModel.create();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '=', 'pending').findOne();
    final int? fetchedMzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        mzungukoId = fetchedMzungukoId;
        _isMzungukoPending = true;
      });
    } else {
      setState(() {
        _isMzungukoPending = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMfukoStatus().then((_) {
      _fetchMzungukoId();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.fundInfo,
        subtitle: localizations.selectFund,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTiles(
            icon: const Icon(Icons.group, color: Colors.black),
            title: localizations.communityFund,
            mark: mfukoStatus == 'hai' ? localizations.completed : '',
            onTap: () {
              if (mfukoStatus == 'hai') {
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
                      builder: (context) => MfukoJamiiPage(
                            mzungukoId: widget.mzungukoId,
                          )),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          if (mfukoStatus == 'hai')
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _mifukoList.length,
                      itemBuilder: (context, index) {
                        final item = _mifukoList[index];
                        return ListTiles(
                          icon: const Icon(Icons.account_balance_wallet,
                              color: Colors.black),
                          title:
                              item.mfukoName ?? localizations.fundWithoutName,
                          mark: localizations.completed,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mifukominginesummary(
                                  recordId: item.id,
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          if (mfukoStatus == 'hai')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomButton(
                    color: Colors.green,
                    buttonText: localizations.addAnotherFund,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addMifuko(
                                  mzungukoId: widget.mzungukoId,
                                )),
                      );
                    },
                    type: ButtonType.elevated,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: localizations.finished,
                    onPressed: _updateStatusToCompleted,
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SababuKutoa extends StatefulWidget {
  final bool isUpdateMode;
  var mzungukoId;

  SababuKutoa({
    super.key,
    this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<SababuKutoa> createState() => _SababuKutoaState();
}

class _SababuKutoaState extends State<SababuKutoa> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _controllers.clear();
    _fetchReasons();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = AppLocalizations.of(context);
    if (_controllers.isEmpty) {
      _controllers[localizations?.illness ?? 'Ugonjwa'] =
          TextEditingController();
      _controllers[localizations?.death ?? 'Kifo'] = TextEditingController();
    }
  }

  Future<void> _fetchReasons() async {
    try {
      final reasonsData = await SababuKutoaMfuko()
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      setState(() {
        for (var data in reasonsData) {
          final reasonModel = SababuKutoaMfuko().fromMap(data);
          final reasonName = reasonModel.reasonName ?? '';
          if (reasonName.isNotEmpty) {
            _controllers[reasonName] =
                TextEditingController(text: reasonModel.amount ?? '0');
          }
        }
      });
    } catch (e) {
      print('Error fetching reasons: $e');
    }
  }

  Future<void> _saveData(String reasonName, String amount) async {
    try {
      final existingReason = await SababuKutoaMfuko()
          .where('reason_name', '=', reasonName)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingReason != null) {
        // Update
        await SababuKutoaMfuko()
            .where('reason_name', '=', reasonName)
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'amount': amount});
      } else {
        await SababuKutoaMfuko(
          reasonName: reasonName,
          amount: amount,
          mzungukoId: widget.mzungukoId,
        ).create();
      }
    } catch (e) {
      print('Error saving/updating reason: $e');
    }
  }

  void _showInputDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Container(
              width: 600,
              height: 355,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addNewReason,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(AppLocalizations.of(context)!
                        .reasonsWithoutAmountWarning),
                    SizedBox(height: 10),
                    CustomTextField(
                      aboveText: AppLocalizations.of(context)!.reason,
                      labelText: AppLocalizations.of(context)!.reason,
                      hintText: AppLocalizations.of(context)!.enterReason,
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      obscureText: false,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      aboveText: AppLocalizations.of(context)!.amount,
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.enterAmount,
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between buttons
                        TextButton(
                          onPressed: () async {
                            final name = nameController.text.trim();
                            final amount = amountController.text.trim();

                            if (name.isNotEmpty && amount.isNotEmpty) {
                              await _saveData(name, amount);
                              setState(() {
                                _controllers[name] =
                                    TextEditingController(text: amount);
                              });
                            }

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.fundInfoTitle,
        subtitle: AppLocalizations.of(context)!.reasonsForGiving,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.reasonsForGivingInFund,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.reasonsWithoutAmountWarning),
              SizedBox(height: 10),
              ..._controllers.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomTextField(
                    aboveText: _getLocalizedReason(context, entry.key),
                    labelText: _getLocalizedReason(context, entry.key),
                    hintText: AppLocalizations.of(context)!.enterAmount,
                    keyboardType: TextInputType.number,
                    controller: entry.value,
                    obscureText: false,
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        await _saveData(entry.key, value);
                      }
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              CustomButton(
                color: Colors.green,
                buttonText:
                    AppLocalizations.of(context)!.addNewReasonToReceiveMoney,
                onPressed: () => _showInputDialog(context),
                type: ButtonType.elevated,
              ),
              SizedBox(height: 20),
              CustomButton(
                color: const Color.fromARGB(255, 4, 34, 207),
                buttonText: widget.isUpdateMode
                    ? AppLocalizations.of(context)!.update
                    : AppLocalizations.of(context)!.continueText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MfukoSummaryPage(
                              mzungukoId: widget.mzungukoId,
                            )),
                  );
                  print('Endelea Pressed');
                },
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLocalizedReason(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'illness':
        return l10n.illness;
      case 'death':
        return l10n.death;
      // Add more cases as needed
      default:
        return key;
    }
  }
}
