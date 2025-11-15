// kiasiMkopo.dart
import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/other_funds/DifferentAmountContributionModel.dart';
import 'package:chomoka/model/other_funds/SameContrinutionModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/muda_marejesho.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class KiasiMkopo extends StatefulWidget {
  final Map<String, dynamic> userId;
  final int meetingId;
  var mzungukoId;
  KiasiMkopo({required this.userId, required this.meetingId, this.mzungukoId});

  @override
  _KiasiMkopoState createState() => _KiasiMkopoState();
}

class _KiasiMkopoState extends State<KiasiMkopo> {
  String? selectedOption;
  final TextEditingController _amountController = TextEditingController();

  int _fixedAmount = 0;
  int _interestRate = 0;
  int _repayAmount = 0;
  bool isLoading = true;
  int userLoanLimit = 0;
  int amountAfterInterest = 0;
  String loanMultiplier = '';
  int jumlaYaAkiba = 0;
  int kiwangoChaJuuChaMkopo = 0;
  double fedhaZilizopo = 0;
  String? errorMessage;
  double _akibaLazimaTotal = 0;
  double _fainiTotal = 0;
  double _totalRepayAmount = 0;
  double _totalLoanAmount = 0;
  double _totalAkibaHiari = 0;
  double _matumiziTotal = 0;
  double _totalPaidAmount = 0;
  double totalContributions = 0;
  double _mifukoMingineTotal = 0.0;

  Future<void> _fetchData() async {
    try {
      final katibaModel = KatibaModel();

      final katiba = await katibaModel
          .where('katiba_key', '=', 'loanMultiplierValue')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      _fixedAmount =
          int.tryParse(katiba?.toMap()['value']?.toString() ?? '0') ?? 0;

      final interest = await katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      _interestRate =
          int.tryParse(interest?.toMap()['value']?.toString() ?? '0') ?? 0;

      final akibaLazimaModel = AkibaLazimaModel();
      final akibaLazimaContributions = await akibaLazimaModel
          .where('user_id', '=', widget.userId['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Fetched Akiba Lazima Contributions: $akibaLazimaContributions');

      double akibaLazimaSum = akibaLazimaContributions.fold<double>(
        0.0,
        (sum, contribution) =>
            sum + (double.tryParse(contribution['amount'].toString()) ?? 0.0),
      );

      final akibaHiariModel = AkibaHiari();
      final akibaHiariContributions = await akibaHiariModel
          .where('user_id', '=', widget.userId['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double akibaHiariSum = akibaHiariContributions.fold<double>(
        0.0,
        (sum, contribution) =>
            sum + (double.tryParse(contribution['amount'].toString()) ?? 0.0),
      );

      double totalContributions = akibaLazimaSum + akibaHiariSum;

      userLoanLimit = (totalContributions * _fixedAmount).toInt();

      jumlaYaAkiba = totalContributions.toInt();

      final toaMkopoModel = ToaMkopoModel();
      final existingLoan = await toaMkopoModel
          .where('userId', '=', widget.userId['id'])
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingLoan != null) {
        setState(() {
          _amountController.text =
              (existingLoan.toMap()['loanAmount']?.toString() ?? '');
          selectedOption = "Kiasi Kingine";
        });
      }

      setState(() {
        jumlaYaAkiba = totalContributions.toInt(); // Ensure it's cast to int
        kiwangoChaJuuChaMkopo = userLoanLimit;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
        errorMessage = "Imeshindikana kuchukua taarifa. Tafadhali jaribu tena.";
      });
    }
  }

  // Future<void> _fetchSalioLilolalaDuplicate() async {
  //   try {
  //     final vikaoModel = VikaovilivyopitaModel();

  //     final salioData = await vikaoModel
  //         .where('kikao_key', '=', 'salio_lililolala_sandukuni')
  //         .findOne();

  //     if (salioData != null && salioData is VikaovilivyopitaModel) {
  //       setState(() {
  //         _salioLililolala = double.tryParse(salioData.value ?? '0') ?? 0;
  //       });
  //     } else {
  //       setState(() {
  //         _salioLililolala = 0;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching salio lililolala: $e');
  //     setState(() {
  //       _salioLililolala = 0;
  //     });
  //   }
  // }

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

  // Future<void> _fetchMkopoWasasaTotal() async {
  //   try {
  //     final rejeshaMkopoModel = RejeshaMkopoModel();
  //     final results = await rejeshaMkopoModel
  //         .where('mzungukoId', '=', widget.mzungukoId)
  //         .select();

  //     double total = 0;

  //     if (results.isNotEmpty) {
  //       total = results.fold(0, (sum, entry) {
  //         return sum + (entry['unpaidAmount'] as double? ?? 0);
  //       });
  //     }

  //     setState(() {
  //       _mkopoWasasaTotal = total;
  //     });

  //     print('Total Mkopo Wasasa: $_mkopoWasasaTotal');
  //   } catch (e) {
  //     print('Error fetching Mkopo wa Sasa total: $e');
  //     setState(() {
  //       _mkopoWasasaTotal = 0;
  //     });
  //   }
  // }

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

  Future<void> _fetchTotalAkibaHiari() async {
    try {
      final akibaHiariModel = AkibaHiari();

      // Fetch all records
      final records = await akibaHiariModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAmount = 0;

      if (records.isNotEmpty) {
        totalAmount = records.fold(0, (sum, record) {
          final amount = (record['amount'] as num?)?.toDouble() ?? 0;
          return sum + amount; // Ensure `amount` is always a `double`
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

  // Add this variable with other state variables

  // Add this method to fetch mifuko mingine totals
  Future<void> _fetchMifukoMingineTotal() async {
    try {
      // First, get all mifuko that are marked as 'Zinakopesheka'
      final mifukoModel = MifukoMingineModel();
      final kopeshekaMifuko = await mifukoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          // .where('unakopesheka', '=', 'Zinakopesheka')
          .find();

      double total = 0.0;

      for (var mfuko in kopeshekaMifuko) {
        if (mfuko is MifukoMingineModel && mfuko.id != null) {
          // Check contribution type
          if (mfuko.utoajiType == 'Kiwango sawa') {
            // Fetch same contribution totals
            final sameContribModel = SameContributionModel();
            final contributions = await sameContribModel
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', mfuko.id)
                .where('status', '=', 'paid')
                .find();

            for (var contrib in contributions) {
              if (contrib is SameContributionModel) {
                total += contrib.amount ?? 0;
              }
            }
          } else {
            // Fetch different amount totals
            final diffContribModel = DifferentAmountContributionModel();
            final contributions = await diffContribModel
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', mfuko.id)
                .find();

            for (var contrib in contributions) {
              if (contrib is DifferentAmountContributionModel) {
                total += contrib.paidAmount ?? 0;
              }
            }
          }
        }
      }

      setState(() {
        _mifukoMingineTotal = total;
      });
    } catch (e) {
      print('Error fetching mifuko mingine total: $e');
    }
  }

  // Update _fetchData to include the new method
  Future<void> _getTotal() async {
    try {
      await _fetchAkibaLazimaDetails();
      await _fetchFainiTotal();
      await _fetchTotalRepayAmount();
      await _fetchTotalPaidAmount();
      await _fetchingMatumiziTotal();
      await _fetchMifukoMingineTotal(); // Add this line
      await _fetchTotalLoanAmount();
      await _fetchTotalAkibaHiari();
      await _fetchContributions();
    } catch (e) {
      print('Error in _fetchData: $e');
    }
  }

  // Update the loan limit calculation to include mifuko mingine
  void _calculateLoanLimit() {
    jumlaYaAkiba =
        (_akibaLazimaTotal + _totalAkibaHiari + _mifukoMingineTotal).toInt();
    userLoanLimit = (jumlaYaAkiba * _fixedAmount).toInt();
    // setState(() {
    //   _matumiziTotal = 0);
    // });
  }

  // Future<void> _getTotal() async {
  //   await _fetchAkibaLazimaDetails();
  //   await _fetchFainiTotal();
  //   await _fetchTotalRepayAmount();
  //   await _fetchingMatumiziTotal();
  //   await _fetchTotalLoanAmount();
  //   await _fetchTotalPaidAmount();
  //   await _fetchTotalAkibaHiari();
  //   await _fetchContributions();
  // }

  Future<void> _getTotalLoanAmount() async {
    double total = 0;
    total = (_totalPaidAmount +
        totalContributions +
        _totalAkibaHiari +
        _akibaLazimaTotal +
        _mifukoMingineTotal +
        _fainiTotal -
        _matumiziTotal -
        _totalLoanAmount);
    print(total);
    setState(() {
      fedhaZilizopo = total;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData().then((_) {
      _getTotal().then((_) {
        _getTotalLoanAmount();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mkopo,
        subtitle: 'Kiasi cha mkopo wa mwanachama',
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Details Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.person, size: 30),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.userId['name']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Namba ya Mwanachama:  ${widget.userId['memberNumber']}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        l10n.memberPhone(
                                            widget.userId['phone']),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jumla ya Akiba yake:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatCurrency(jumlaYaAkiba.toDouble(), Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Kiwango cha Juu cha Mkopo:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatCurrency(kiwangoChaJuuChaMkopo.toDouble(), Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fedha Zilizopo \nkwa Ajili ya Mkopo:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatCurrency(fedhaZilizopo, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Loan Options
                    CheckboxListTile(
                      title:
                          Text("Chukua Mkopo Wote " + formatCurrency(kiwangoChaJuuChaMkopo.toDouble(), Provider.of<CurrencyProvider>(context).currencyCode)),
                      value: selectedOption == "Chukua Mkopo Wote",
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOption = "Chukua Mkopo Wote";
                            _amountController.clear();
                            errorMessage = null;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Kiasi Kingine"),
                      value: selectedOption == "Kiasi Kingine",
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOption = "Kiasi Kingine";
                            errorMessage = null;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    if (selectedOption == "Kiasi Kingine")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              aboveText: 'Kiasi',
                              labelText: 'Kiasi',
                              hintText: 'Weka Kiasi',
                              keyboardType: TextInputType.number,
                              controller: _amountController,
                              obscureText: false,
                            ),
                          ),
                          if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                errorMessage!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),

                    // Confirm Button
                    SizedBox(height: 20),
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: 'Thibitisha Kiasi',
                      onPressed: () async {
                        if (selectedOption == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Tafadhali chagua chaguo la mkopo.")),
                          );
                          return;
                        }

                        if (selectedOption == "Kiasi Kingine" &&
                            (_amountController.text.isEmpty ||
                                double.tryParse(_amountController.text) ==
                                    null)) {
                          setState(() {
                            errorMessage = "Tafadhali ingiza kiasi sahihi.";
                          });
                          return;
                        }

                        final selectedAmount = selectedOption ==
                                "Chukua Mkopo Wote"
                            ? kiwangoChaJuuChaMkopo.toDouble()
                            : (double.tryParse(_amountController.text) ?? 0.0);

                        // Check if the amount is greater than fedhaZilizopo
                        if (selectedAmount > fedhaZilizopo) {
                          setState(() {
                            errorMessage =
                                "Hakuna kiasi cha kutosha kutoa mkopo huu.";
                          });
                          return;
                        }

                        if (selectedAmount > kiwangoChaJuuChaMkopo) {
                          setState(() {
                            errorMessage =
                                "Kiasi kilichochaguliwa hakiruhusiwi.";
                          });
                          return;
                        }

                        final loanRate = _interestRate / 100;
                        final userRate = selectedAmount * loanRate;
                        final amountAfterInterest = selectedAmount + userRate;

                        try {
                          await BaseModel.initAppDatabase();

                          // Fetch or create loan
                          final existingLoan = await ToaMkopoModel()
                              .where('userId', '=', widget.userId['id'])
                              .where('meetingId', '=', widget.meetingId)
                              .where('mzungukoId', '=', widget.mzungukoId)
                              .findOne();

                          int loanId;

                          if (existingLoan != null) {
                            // Update existing loan
                            loanId = int.tryParse(
                                    existingLoan.toMap()['id'].toString()) ??
                                0;
                            await ToaMkopoModel()
                                .where('id', '=', loanId)
                                .update({
                              'loanAmount': selectedAmount.toDouble(),
                              'repayAmount': amountAfterInterest.toDouble(),
                            });
                          } else {
                            final newLoan = ToaMkopoModel(
                              userId: widget.userId['id'],
                              meetingId: widget.meetingId,
                              mzungukoId: widget.mzungukoId,
                              loanAmount: selectedAmount.toDouble(),
                              repayAmount: amountAfterInterest.toDouble(),
                            );
                            loanId = await newLoan.create();
                          }

                          final existingRepayment = await RejeshaMkopoModel()
                              .where('user_id', '=', widget.userId['id'])
                              .where('meeting_id', '=', widget.meetingId)
                              .where('mzungukoId', '=', widget.mzungukoId)
                              .findOne();

                          if (existingRepayment != null) {
                            await RejeshaMkopoModel()
                                .where(
                                    'id', '=', existingRepayment.toMap()['id'])
                                .update({
                              'unpaidAmount': amountAfterInterest.toDouble(),
                              'loanId': loanId,
                            });
                          } else {
                            await RejeshaMkopoModel(
                              userId: widget.userId['id'],
                              meetingId: widget.meetingId,
                              mzungukoId: widget.mzungukoId,
                              unpaidAmount: amountAfterInterest.toDouble(),
                              loanId: loanId,
                            ).create();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Kiasi cha Mkopo na Riba vimehifadhiwa.")),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mudaMarejesho(
                                meetingId: widget.meetingId,
                                loanAmount: selectedAmount,
                                userId: widget.userId,
                                mzungukoId: widget.mzungukoId,
                              ),
                            ),
                          );
                        } catch (e) {
                          print('Error updating loan data: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Hitilafu imetokea. Tafadhali jaribu tena.")),
                          );
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
