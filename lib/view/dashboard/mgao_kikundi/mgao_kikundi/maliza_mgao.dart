import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MalizaMgao extends StatefulWidget {
  var mzungukoId;
  MalizaMgao({super.key, this.mzungukoId});

  @override
  State<MalizaMgao> createState() => _MalizaMgaoState();
}

class _MalizaMgaoState extends State<MalizaMgao> {
  double faida = 0.0;
  double jumlaPesaZote = 0.0;
  double pesaYaMgao = 0.0;
  double jumlaAkibaMzungukoUjao = 0.0;
  double kiasiMzungukoUjao = 0.0;
  double _fainiTotal = 0.0;
  bool isLoading = true;
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

  Future<void> _fetchData() async {
    try {
      final mzungukoModel = MzungukoModel();

      final mzungukoData = await mzungukoModel
          .where('id', '=', widget.mzungukoId)
          .findOne() as MzungukoModel?;

      if (mzungukoData != null) {
        setState(() {
          faida = mzungukoData.faida ?? 0.0;
          jumlaPesaZote = mzungukoData.jumlaPesaZote ?? 0.0;
          pesaYaMgao = mzungukoData.pesaYaMgao ?? 0.0;
          kiasiMzungukoUjao = mzungukoData.akibaMzungukoUjao ?? 0.0;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAndSumAkibaMzungukoUjao() async {
    try {
      final userMgaoModel = UserMgaoModel();

      final results = await userMgaoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAkibaMzungukoUjao = results.fold(0.0, (double total, record) {
        final akiba = (record['mzungukoUjaoAkiba'] as num?)?.toDouble() ?? 0.0;
        return total + akiba;
      });

      setState(() {
        jumlaAkibaMzungukoUjao = totalAkibaMzungukoUjao;
      });
      print('Total Akiba Mzunguko Ujao: $jumlaAkibaMzungukoUjao');
    } catch (e) {
      print('Error fetching and summing Akiba Mzunguko Ujao: $e');
    }
  }

  Future<void> _completeAndCreateNewMzunguko(BuildContext context) async {
    try {
      final mzungukoResult = await MzungukoModel()
          .where('status', '=', 'pending')
          .select(limit: 1);

      if (mzungukoResult.isNotEmpty) {
        print('There is already a pending Mzunguko. Cannot create a new one.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kuna mzunguko unaosubiri kuisha.')),
        );
        return;
      }

      final newMzunguko = MzungukoModel();
      newMzunguko.status = 'pending';
      final newId = await newMzunguko.create();

      print('New Mzunguko created with ID: $newId');

      final createdMzunguko =
          await MzungukoModel().where('id', '=', newId).select();

      if (createdMzunguko.isNotEmpty) {
        print('Saved Mzunguko Data: ${createdMzunguko.first}');
      } else {
        print('No data found for the newly created Mzunguko.');
      }

      // Navigate to the dashboard after creating the new Mzunguko
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => dashboard()),
        (route) => false,
      );
    } catch (e) {
      print('Error creating new Mzunguko: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imeshindikana kuanzisha mzunguko mpya: $e')),
      );
    }
  }

  Future<void> _fetchFainiTotal() async {
    try {
      final userFainiModel = UserFainiModel();
      final results = await userFainiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double total = 0.0;

      if (results.isNotEmpty) {
        total = results.fold(0.0, (double sum, entry) {
          final unpaidFaini = (entry['paidfaini'] as int?)?.toDouble() ?? 0.0;
          return sum + unpaidFaini;
        });
      }

      setState(() {
        _fainiTotal = total;
      });

      print('Total Faini: $_fainiTotal');
    } catch (e) {
      print('Error fetching total unpaid fines: $e');
      setState(() {
        _fainiTotal = 0.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData().then((_) {
      _fetchAndSumAkibaMzungukoUjao().then((_) {
        _fetchFainiTotal();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.groupShareDistributionTitle,
        showBackArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (faida + _fainiTotal) == 0
                            ? l10n.noProfitEmoji
                            : l10n.profitEmoji,
                        style: const TextStyle(
                          fontSize: 70.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (faida + _fainiTotal) == 0
                            ? l10n.noProfitMessage
                            : l10n.profitMessage((faida + _fainiTotal).toStringAsFixed(0)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: (faida + _fainiTotal) == 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.totalDistributionFunds,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 68, 68, 68),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                l10n.amountTzs(pesaYaMgao.toStringAsFixed(0)),
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.nextCycleSocialFund,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 68, 68, 68),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                l10n.amountTzs(kiasiMzungukoUjao.toStringAsFixed(0)),
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.nextCycleMemberSavings,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 68, 68, 68),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                l10n.amountTzs(jumlaAkibaMzungukoUjao.toStringAsFixed(0)),
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: const Color.fromARGB(255, 4, 34, 207),
                      buttonText: l10n.finishCycle,
                      onPressed: () {
                        _completeAndCreateNewMzunguko(context);
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
