import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart'; // Make sure this is imported and exists
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/fund_information/MfukoJamiiSummary.dart';
import 'package:chomoka/view/group_setup/fund_information/add_mifuko.dart';
import 'package:chomoka/view/group_setup/fund_information/mfukoInfo.dart';
import 'package:chomoka/view/group_setup/fund_information/mifukoMingineSummary.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
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
                          mark: mfukoStatus == 'hai' ? 'completed' : '',
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
