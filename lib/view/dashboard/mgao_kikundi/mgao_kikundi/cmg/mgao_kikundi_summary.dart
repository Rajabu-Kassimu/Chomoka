import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaAkibaHiari.dart';
import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgawanyo_mwanachama.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/unpaid_akiba_lazima.dart';
import 'package:chomoka/view/dashboard/unpaidAkiba/unpaid_mfuko_jamii.dart';
import 'package:chomoka/view/pre_page/login_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class MgaoWaKikundiPage extends StatefulWidget {
  final bool fromKiasi;
  final String? kiasiKilichopelekwa;
  var mzungukoId;
  final bool isFromMgaowakikundi;

  MgaoWaKikundiPage({
    Key? key,
    this.mzungukoId,
    this.fromKiasi = false,
    this.isFromMgaowakikundi = false,
    this.kiasiKilichopelekwa,
  }) : super(key: key);
  @override
  State<MgaoWaKikundiPage> createState() => _MgaoWaKikundiPageState();
}

class _MgaoWaKikundiPageState extends State<MgaoWaKikundiPage> {
  double _akibaLazimaTotal = 0;
  double _totalAkibaHiari = 0;
  double _mfukoJamiiTotal = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;
  double _matumiziTotal = 0;
  double _totalRepayAmount = 0;
  double _totalPaidAmount = 0;
  double _pesaMgao = 0;
  double _salioLililolala = 0;
  double _akibaLazimaUnpaid = 0;
  double _kilichotolewaAkibaHiari = 0;
  double _totalLoanAmount = 0;
  double _salioTotal = 0;
  double kiasiKilichopelekwa = 0;
  double _akibaJamiiMzungukoUjao = 0;
  double _kilichotolewaMfukoJamii = 0;
  double? unpaidAmount;
  double _jumlaYaAkiba = 0;
  double _mfukoWaJamiiSalio = 0;
  double _akibaBinafsiSalio = 0;
  double totalContributions = 0;
  bool isLoading = true;
  Map<String, void Function(double)>? fieldSetters;
  double _totalUnpaidAmount = 0.0;

  String _safeGetField(String? field, {String defaultValue = '-'}) {
    return field?.isNotEmpty == true ? field! : defaultValue;
  }

  Future<void> _fetchAkibaLazimaDetails() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();
      final records = await akibaLazimaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalSum = 0;

      if (records.isNotEmpty) {
        totalSum = records.fold(0, (sum, record) {
          final total = (record['amount'] as num?)?.toDouble() ?? 0;
          return sum + total;
        });
      }

      setState(() {
        _akibaLazimaTotal = totalSum;
      });

      print('Total Akiba Lazima: $_akibaLazimaTotal');
    } catch (e) {
      print('Error fetching total Akiba Lazima: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Akiba Lazima.'),
        ),
      );
    }
  }

  Future<void> _fetchTotalAkibaHiari() async {
    try {
      final akibaHiariModel = AkibaHiari();

      final records = await akibaHiariModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAmount = 0;

      if (records.isNotEmpty) {
        totalAmount = records.fold(0, (sum, record) {
          final amount = (record['amount'] as num?)?.toDouble() ?? 0;
          return sum + amount;
        });
      }

      setState(() {
        _totalAkibaHiari = totalAmount;
      });

      print('Total Akiba Hiari: $_totalAkibaHiari');
    } catch (e) {
      print('Error fetching total Akiba Hiari: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Akiba Hiari.'),
        ),
      );
    }
  }

  Future<void> _fetchMfukoJamiiTotal() async {
    try {
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final result = await uchangiajiMfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double total = 0;

      if (result.isNotEmpty) {
        total = result.fold(0, (prev, entry) {
          return prev + (entry['total'] as double? ?? 0);
        });
      }

      setState(() {
        _mfukoJamiiTotal = total;
      });

      print('Total Mfuko Jamii: $_mfukoJamiiTotal');
    } catch (e) {
      print('Error fetching Mfuko Jamii total: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch Mfuko Jamii total.')),
      );
    }
  }

  Future<void> _fetchMkopoWasasaTotal() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double total = 0;

      if (results.isNotEmpty) {
        total = results.fold(0, (sum, entry) {
          return sum + (entry['unpaidAmount'] as double? ?? 0);
        });
      }

      setState(() {
        _mkopoWasasaTotal = total;
      });

      print('Total Mkopo Wasasa: $_mkopoWasasaTotal');
    } catch (e) {
      print('Error fetching Mkopo wa Sasa total: $e');
      setState(() {
        _mkopoWasasaTotal = 0;
      });
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

  Future<void> _fetchTotalRepayAmount() async {
    try {
      final toaMkopoModel = ToaMkopoModel();
      final results = await toaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalRepayAmount = 0;

      if (results.isNotEmpty) {
        totalRepayAmount = results.fold(0, (sum, record) {
          return sum + (record['repayAmount'] as double? ?? 0);
        });
      }

      setState(() {
        _totalRepayAmount = totalRepayAmount;
      });

      print('Total Repay Amount: $_totalRepayAmount');
    } catch (e) {
      print('Error fetching total repay amount: $e');
      setState(() {
        _totalRepayAmount = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya marejesho.')),
      );
    }
  }

  Future<void> _fetchTotalPaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalPaidAmount = 0;

      if (results.isNotEmpty) {
        totalPaidAmount = results.fold(0, (sum, record) {
          return sum + (record['paidAmount'] as double? ?? 0);
        });
      }

      setState(() {
        _totalPaidAmount = totalPaidAmount;
      });

      print('Total Paid Amount: $_totalPaidAmount');
    } catch (e) {
      print('Error fetching total paid amount: $e');
      // setState(() {
      //   _totalPaidAmount = 0);
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
      );
    }
  }

  Future<void> _fetchingMatumiziTotal() async {
    try {
      final matumiziModel = MatumiziModel();
      final results = await matumiziModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double total = 0;

      if (results.isNotEmpty) {
        total = results.fold(0, (sum, record) {
          return sum + (record['amount'] as double? ?? 0);
        });
      }

      setState(() {
        _matumiziTotal = total;
      });

      print('Total Matumizi: $_matumiziTotal');
    } catch (e) {
      print('Error fetching total amount for meeting: $e');
      // setState(() {
      //   _matumiziTotal = 0);
      // });
    }
  }

  Future<void> _fetchTotalLoanAmount() async {
    try {
      final toaMkopoModel = ToaMkopoModel();
      final records = await toaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalLoanAmount = 0;

      if (records.isNotEmpty) {
        totalLoanAmount = records.fold(0, (sum, record) {
          final loan = (record['loanAmount'] as num?)?.toDouble() ?? 0;
          return sum + loan;
        });
      }

      setState(() {
        _totalLoanAmount = totalLoanAmount;
      });

      print('Total Loan Amount: $_totalLoanAmount');
    } catch (e) {
      print('Error fetching total loan amount: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya mikopo.')),
      );
    }
  }

  Future<void> updateMzungukoData({
    required int mzungukoId,
    required double faida,
    required double jumlaPesaZote,
    required double pesaYaMgao,
  }) async {
    try {
      final mzungukoModel = MzungukoModel();

      // Update the data in the database
      await mzungukoModel.where('id', '=', mzungukoId).update({
        'status': 'completed',
        'faida': faida,
        'jumlaPesaZote': jumlaPesaZote,
        'pesaYaMgao': pesaYaMgao,
      });

      // Fetch the updated data from the database
      final BaseModel? updatedData =
          await mzungukoModel.where('id', '=', mzungukoId).findOne();

      // Cast BaseModel to MzungukoModel
      if (updatedData != null && updatedData is MzungukoModel) {
        print('Mzunguko data updated successfully:');
        print('ID: ${updatedData.id}');
        print('Status: ${updatedData.status}');
        print('Faida: ${updatedData.faida}');
        print('Jumla Pesa Zote: ${updatedData.jumlaPesaZote}');
        print('Pesa Ya Mgao: ${updatedData.pesaYaMgao}');
      } else {
        print('Error: Mzunguko data not found after update.');
      }
    } catch (e) {
      print('Error updating Mzunguko data: $e');
      // Handle the error, e.g., show a Snackbar or dialog
    }
  }

  //============================================================================

  Future<bool> checkUnpaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('unpaidAmount', '>', 0)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalUnpaidAmount = 0.0;
      for (var record in results) {
        totalUnpaidAmount += record['unpaidAmount'] ?? 0.0;
      }

      setState(() {
        _totalUnpaidAmount = totalUnpaidAmount;
      });

      print('Total Unpaid Amount: $_totalUnpaidAmount');
      return _totalUnpaidAmount > 0;
    } catch (e) {
      print('Error checking unpaid mkopo: $e');
      setState(() {
        _totalUnpaidAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking unpaid amount')),
      );
      return false;
    }
  }

  Future<bool> checkUnpaidFaini() async {
    try {
      final userFainiModel = UserFainiModel();
      print('Querying unpaid faini for mzungukoId: ${widget.mzungukoId}');

      // Fetch unpaid fines without filtering by userId
      final results = await userFainiModel
          .where('unpaidfaini', '>', 0)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Results count: ${results.length}');

      double totalUnpaidFaini = 0.0;
      for (var record in results) {
        print('Raw Record: $record');

        totalUnpaidFaini += record['unpaidfaini'] ?? 0.0;

        print('User Faini Data:');
        print('User ID: ${record['userId']}');
        print('Unpaid Faini: ${record['unpaidfaini']}');
        print('Mzunguko ID: ${record['mzungukoId']}');
        print('Fine ID: ${record['fainiId']}');
        print('-----------------------------------');
      }

      print('Total Unpaid Faini: $totalUnpaidFaini');
      return totalUnpaidFaini > 0; // Return true if there is any unpaid fine
    } catch (e) {
      print('Error checking unpaid faini: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking unpaid faini')),
      );
      return false;
    }
  }

  //============================================================================

  Future<void> _getMgaoAmount() async {
    if (widget.fromKiasi) {
      kiasiKilichopelekwa =
          double.tryParse(widget.kiasiKilichopelekwa ?? '0.0') ?? 0.0;
    }
    double total = ((_totalPaidAmount - _totalLoanAmount) +
        _akibaLazimaTotal +
        _fainiTotal +
        _mfukoWaJamiiSalio +
        _mfukoJamiiTotal +
        totalContributions +
        (-_matumiziTotal - kiasiKilichopelekwa));
    setState(() {
      _pesaMgao = total;
    });
  }

  // _calculateTotal() {
  //   double sumTotal = (_totalPaidAmount -
  //       _totalLoanAmount +
  //       _akibaLazimaTotal +
  //       _fainiTotal +
  //       (_mfukoJamiiTotal -
  //           _matumiziTotal -
  //           kiasiKilichopelekwa -
  //           _totalMgaoAmount -
  //           _totalMgaoAkibaHiari));
  //   setState(() {
  //     _salioTotal = sumTotal;
  //     _akibaJamiiMzungukoUjao = kiasiKilichopelekwa;
  //   });
  // }

  Future<void> _fetchKilichotolewaMfukoJamii() async {
    try {
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();

      toaMfukoJamiiModel.where('mzungukoId', '=', widget.mzungukoId);

      final records = await toaMfukoJamiiModel.select();
      double totalAmountWithdrawn = records.fold(0.0, (sum, record) {
        final amount = (record['amount'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      setState(() {
        _kilichotolewaMfukoJamii = totalAmountWithdrawn;
      });
    } catch (e) {
      print('Error fetching withdrawal data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data za mfuko jamii.'),
        ),
      );
    }
  }

  Future<bool> checkUnpaidMfukoJamii() async {
    final unpaidMfukoJamii = await UchangaajiMfukoJamiiModel()
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('paid_status', '=', 'unpaid')
        // .where('type', '=', 'mfuko_jamii')
        .count();
    return unpaidMfukoJamii > 0;
  }

  Future<bool> checkUnpaidAkibaHiari() async {
    final unpaidAkibaHiari = await AkibaLazimaModel()
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('paid_status', '=', 'unpaid')
        // .where('type', '=', 'akiba_hiari')
        .count();
    return unpaidAkibaHiari > 0;
  }

  Future<void> _fetchSalioLilolala() async {
    try {
      final vikaoModel = VikaovilivyopitaModel();

      for (final key in fieldSetters!.keys) {
        final data = await vikaoModel
            .where('kikao_key', '=', key)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        final value = data != null && data is VikaovilivyopitaModel
            ? double.tryParse(data.value ?? '0') ?? 0
            : 0;

        setState(() {
          fieldSetters![key]?.call(value.toDouble());
        });
      }

      print('Fetched values: salioLililolala=$_salioLililolala, '
          ' yYaAkiba=$_jumlaYaAkiba, '
          'mfukoWaJamiiSalio=$_mfukoWaJamiiSalio, '
          'akibaBinafsiSalio=$_akibaBinafsiSalio');
    } catch (e) {
      print('Error fetching field values: $e');
      setState(() {
        _salioLililolala = 0;
        _jumlaYaAkiba = 0;
        _mfukoWaJamiiSalio = 0;
        _akibaBinafsiSalio = 0;
      });
    }
  }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      // Calculate total amount
      double totalAmount = 0;
      for (var contribution in results) {
        // Safely handle null amounts by using null-aware operator
        final amount = contribution['amount'];
        if (amount != null) {
          totalAmount += (amount as num).toDouble();
        }
      }

      setState(() {
        totalContributions = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetctData() async {
    await _fetchSalioLilolala();
    await _fetchAkibaLazimaDetails();
    await _fetchTotalAkibaHiari();
    await _fetchMfukoJamiiTotal();
    await _fetchMkopoWasasaTotal();
    await _fetchFainiTotal();
    await _fetchSalioLilolala();
    await _fetchingMatumiziTotal();
    await _fetchTotalPaidAmount();
    await _fetchTotalRepayAmount();
    await _fetchTotalLoanAmount();
    await _fetchKilichotolewaMfukoJamii();
    await _getMgaoAmount();
    await _fetchContributions();
    // await _calculateTotal();
  }

  @override
  void initState() {
    super.initState();
    fieldSetters = {
      'salio_lililolala_sandukuni': (value) => _salioLililolala = value,
      'jumla_ya_akiba': (value) => _jumlaYaAkiba = value,
      'mfuko_wa_jamii_salio': (value) => _mfukoWaJamiiSalio = value,
      'akiba_binafsi_salio': (value) => _akibaBinafsiSalio = value,
    };
    _fetctData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.groupShareTitle,
        subtitle: l10n.summary,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary Card
            _buildSummaryCard(context, l10n),
            SizedBox(height: 20),
            // Continue Button
            CustomButton(
              color: const Color.fromARGB(255, 24, 9, 240),
              buttonText: widget.fromKiasi ? (l10n.confirm ?? 'Thibitisha') : (l10n.continueText ?? 'Endelea'),
              onPressed: () async {
                bool hasUnpaidAmount = await checkUnpaidAmount();
                bool hasUnpaidFaini = await checkUnpaidFaini();
                bool hasUnpaidMfukoJamii = await checkUnpaidMfukoJamii();
                bool hasUnpaidAkibaHiari = await checkUnpaidAkibaHiari();

                if (hasUnpaidAmount ||
                    hasUnpaidFaini ||
                    hasUnpaidMfukoJamii ||
                    hasUnpaidAkibaHiari) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String message = '';

                      if (hasUnpaidAmount) {
                        message = 'Kuna malipo ya mkopo yasiyolipwa. Tafadhali lipa mikopo yote kabla ya kuendelea.';
                      } else if (hasUnpaidFaini) {
                        message = 'Kuna malipo ya faini yasiyolipwa. Tafadhali lipa faini zote kabla ya kuendelea.';
                      } else if (hasUnpaidMfukoJamii) {
                        message = 'Kuna malipo ya mfuko jamii yasiyolipwa. Tafadhali lipa malipo yote kabla ya kuendelea.';
                      } else if (hasUnpaidAkibaHiari) {
                        message = 'Kuna malipo ya akiba Lazima yasiyolipwa. Tafadhali lipa malipo yote kabla ya kuendelea.';
                      }

                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange[700]),
                            const SizedBox(width: 8),
                            Text(
                              'Tahadhali',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        content: Text(message),
                        actions: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange[700]),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();

                              if (hasUnpaidAmount) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RejeshaMkopoPage(
                                      mzungukoId: widget.mzungukoId,
                                      isFromMgaowakikundi: true,
                                    ),
                                  ),
                                );
                              } else if (hasUnpaidFaini) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LipaFainiPage(
                                      mzungukoId: widget.mzungukoId,
                                      isFromMgaowakikundi: true,
                                    ),
                                  ),
                                );
                              } else if (hasUnpaidMfukoJamii) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UnpaidUchangaajiMfukoJamiiPage(
                                      mzungukoId: widget.mzungukoId,
                                      isFromMgaowakikundi: true,
                                    ),
                                  ),
                                );
                              } else if (hasUnpaidAkibaHiari) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UnpaidAkibaLazimaPage(
                                      mzungukoId: widget.mzungukoId,
                                      isFromMgaowakikundi: true,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              l10n.continueText ?? 'Endelea',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return; // Exit the function early
                }

                if (widget.fromKiasi) {
                  await updateMzungukoData(
                    mzungukoId: widget.mzungukoId,
                    faida: _totalPaidAmount - _totalLoanAmount,
                    jumlaPesaZote: _totalPaidAmount -
                        _totalLoanAmount +
                        _akibaLazimaTotal +
                        _fainiTotal +
                        _mfukoJamiiTotal,
                    pesaYaMgao: _pesaMgao,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MgawanyoMwanachama(
                        pesaYaMgao: _pesaMgao,
                        mzungukoId: widget.mzungukoId,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        mfukoJamiiKiasi:
                            (_mfukoJamiiTotal + _mfukoWaJamiiSalio),
                        mzungukoId: widget.mzungukoId,
                        isFromMgao: true,
                      ),
                    ),
                  );
                }
              },
              type: ButtonType.elevated,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, AppLocalizations l10n) {
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Akiba', Icons.savings),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya akiba',
                  formatCurrency(_akibaLazimaTotal, currencyCode)),
              SizedBox(height: 16),
              _buildSectionHeader('Faida'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow(
                  'Jumla ya ziada zilizokusanywa',
                  (_totalPaidAmount - _totalLoanAmount) >= 0
                      ? formatCurrency((_totalPaidAmount - _totalLoanAmount), currencyCode)
                      : l10n.totalUnpaidAmount(formatCurrency(_mkopoWasasaTotal, currencyCode)),
                  textColor: (_totalPaidAmount - _totalLoanAmount) < 0
                      ? Colors.red
                      : Colors.black),
              _buildRow('Jumla ya faini zilizokusanywa',
                  formatCurrency(_fainiTotal, currencyCode)),
              SizedBox(height: 16),
              _buildSectionHeader('Jamii'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya Mfuko Jamii',
                  formatCurrency((_mfukoJamiiTotal - kiasiKilichopelekwa + _mfukoWaJamiiSalio), currencyCode),
                  isRed: false),
              _buildRow('Jumla ya kiasi kilichotolewa\n katika Mfuko Jamii',
                  formatCurrency(_kilichotolewaMfukoJamii, currencyCode),
                  isRed: true),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya Mfuko Jamii',
                  formatCurrency((_mfukoJamiiTotal - kiasiKilichopelekwa - _kilichotolewaMfukoJamii + _mfukoWaJamiiSalio), currencyCode),
                  isRed: false),
              SizedBox(height: 16),
              _buildSectionHeader('Jumla ya fedha zote'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya Fedha Zote',
                  formatCurrency(_pesaMgao, currencyCode),
                  isBold: true),
              SizedBox(height: 16),
              _buildSectionHeader('Matumizi'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Matumizi mengine ya kikundi',
                  formatCurrency(_matumiziTotal, currencyCode),
                  isRed: true, isBold: true),
              SizedBox(height: 16),
              _buildSectionHeader('Kiasi kilichobaki'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow(
                'Mfuko Jamii kilichopelekwa\n Mzunguko ujao',
                formatCurrency(widget.fromKiasi ? (double.tryParse(widget.kiasiKilichopelekwa ?? '0') ?? 0) : 0, currencyCode),
              ),
              SizedBox(height: 16),
              _buildSectionHeader('Jumla ya fedha za mgao'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya Fedha za Mgao',
                  formatCurrency(_pesaMgao, currencyCode),
                  isBold: true),
              SizedBox(height: 16),
              _buildSectionHeader('Jumla ya Akiba Binafsi'),
              Divider(color: const Color.fromARGB(115, 49, 49, 49)),
              _buildRow('Jumla ya Akiba Binafsi',
                  formatCurrency((_totalAkibaHiari - _kilichotolewaAkibaHiari), currencyCode),
                  isBold: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, [IconData? icon]) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: const Color(0xFF0D47A1),
            size: 20,
          ),
        if (icon != null) SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D47A1),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, String value,
      {bool isRed = false, bool isBold = false, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          if ((_totalPaidAmount - _totalLoanAmount) < 0 &&
              title == 'Jumla ya ziada zilizokusanywa')
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: Colors.red,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: textColor ?? (isRed ? Colors.red : Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}
