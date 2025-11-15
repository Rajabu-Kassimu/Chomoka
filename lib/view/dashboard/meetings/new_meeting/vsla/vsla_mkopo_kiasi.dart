// VslaLoanAmount.dart
import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
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

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class VslaLoanAmount extends StatefulWidget {
  final Map<String, dynamic> userId;
  final int meetingId;
  var mzungukoId;
  VslaLoanAmount(
      {required this.userId, required this.meetingId, this.mzungukoId});

  @override
  _VslaLoanAmountState createState() => _VslaLoanAmountState();
}

class _VslaLoanAmountState extends State<VslaLoanAmount> {
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
  double _totalGroupShares = 0;
  int _shareValue = 0;
  int kiwangoChaJuuChaMkopo = 0;
  double fedhaZilizopo = 0;
  String? errorMessage;
  double _fainiTotal = 0;
  double _totalRepayAmount = 0;
  double _totalLoanAmount = 0;
  double _totalAkibaHiari = 0;
  double _matumiziTotal = 0;
  double _totalPaidAmount = 0;
  double totalContributions = 0;
  double _mifukoMingineTotal = 0;

  Future<void> _fetchData() async {
    try {
      final katibaModel = KatibaModel();

      // Get loan multiplier
      final katiba = await katibaModel
          .where('katiba_key', '=', 'loanMultiplierValue')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      _fixedAmount =
          int.tryParse(katiba?.toMap()['value']?.toString() ?? '0') ?? 0;

      // Get interest rate
      final interest = await katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      _interestRate =
          int.tryParse(interest?.toMap()['value']?.toString() ?? '0') ?? 0;

      // Get share value - Updated to use 'share_amount' instead of 'share_value'
      final shareValueData = await katibaModel
          .where('katiba_key', '=',
              'share_amount') // Changed from 'share_value' to 'share_amount'
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareValueData != null) {
        // Fix: Convert to double first, then to int properly
        _shareValue =
            double.tryParse(shareValueData.toMap()['value']?.toString() ?? '0')
                    ?.toInt() ??
                0; // Changed default from 5000 to 0

        // If share value is still 0, try to fetch it again with resetQuery
        if (_shareValue == 0) {
          print('Share value is 0, trying alternative fetch method');
          final altShareValueData = await katibaModel
              .where('katiba_key', '=', 'share_amount')
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (altShareValueData != null) {
            _shareValue = double.tryParse(
                        altShareValueData.toMap()['value']?.toString() ?? '0')
                    ?.toInt() ??
                0;
          }

          print('Final share value: $_shareValue');
        }
      } else {
        print('No share value data found for mzungukoId: ${widget.mzungukoId}');
        _shareValue = 0; // Changed default from 5000 to 0
      }

      // Fetch member's shares
      final memberShareModel = MemberShareModel();
      final memberShares = await memberShareModel
          .where('user_id', '=', widget.userId['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      // Calculate total shares for this member
      int totalMemberShares = memberShares.fold<int>(
        0,
        (sum, share) =>
            sum +
            (int.tryParse(share['number_of_shares']?.toString() ?? '0') ?? 0),
      );

      // Calculate total value of member's shares
      double totalShareValue = totalMemberShares * _shareValue.toDouble();

      // Calculate loan limit based on shares
      userLoanLimit = (totalShareValue * _fixedAmount).toInt();

      // Fetch total group shares
      final allGroupShares = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int totalGroupShareCount = allGroupShares.fold<int>(
        0,
        (sum, share) =>
            sum +
            (int.tryParse(share['number_of_shares']?.toString() ?? '0') ?? 0),
      );

      _totalGroupShares = totalGroupShareCount * _shareValue.toDouble();

      // Check for existing loan
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
        jumlaYaAkiba = totalShareValue.toInt(); // Member's total share value
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

  Future<void> _fetchMifukoMingineTotal() async {
    try {
      // First, get all mifuko that are marked as 'Zinakopesheka'
      final mifukoModel = MifukoMingineModel();
      final kopeshekaMifuko = await mifukoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('unakopesheka', '=', 'Zinakopesheka')
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

  Future<void> _getTotal() async {
    await _fetchFainiTotal();
    await _fetchTotalRepayAmount();
    await _fetchingMatumiziTotal();
    await _fetchTotalLoanAmount();
    await _fetchTotalPaidAmount();
    await _fetchContributions();
    await _fetchMifukoMingineTotal();
  }

  Future<void> _getTotalLoanAmount() async {
    double total = 0;
    total = (_totalPaidAmount +
        _totalGroupShares +
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
        subtitle: l10n.kiasi_cha_mkopo_wa_mwanachama,
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
                                        l10n.memberNumberLabel(
                                            widget.userId['memberNumber'] ??
                                                '-'),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        l10n.memberPhone(
                                            widget.userId['phone'] ?? '-'),
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
                                  l10n.jumla_ya_akiba,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatCurrency(jumlaYaAkiba, Provider.of<CurrencyProvider>(context).currencyCode),
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
                                  l10n.kiwango_cha_juu_mkopo,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatCurrency(kiwangoChaJuuChaMkopo, Provider.of<CurrencyProvider>(context).currencyCode),
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
                                  l10n.fedha_zilizopo_mkopo,
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
                          Text(l10n.chukua_mkopo_wote(formatCurrency(kiwangoChaJuuChaMkopo, Provider.of<CurrencyProvider>(context).currencyCode))),
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
                      title: Text(l10n.kiasi_kingine),
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
                              aboveText: l10n.kiasi,
                              labelText: l10n.kiasi,
                              hintText: l10n.weka_kiasi,
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

                    // Confirm Buttonsss
                    SizedBox(height: 20),
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: l10n.thibitisha_kiasi,
                      onPressed: () async {
                        if (selectedOption == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(l10n.tafadhali_chagua_chaguo)),
                          );
                          return;
                        }

                        if (selectedOption == "Kiasi Kingine" &&
                            (_amountController.text.isEmpty ||
                                double.tryParse(_amountController.text) ==
                                    null)) {
                          setState(() {
                            errorMessage = l10n.tafadhali_ingiza_kiasi_sahihi;
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
                            errorMessage = l10n.hakuna_kiasi_cha_kutosha;
                          });
                          return;
                        }

                        if (selectedAmount > kiwangoChaJuuChaMkopo) {
                          setState(() {
                            errorMessage = l10n.kiasi_hakiruhusiwi;
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
                                content:
                                    Text(l10n.kiasi_na_riba_vimehifadhiwa)),
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
                            SnackBar(content: Text(l10n.hitilafu_imetokea)),
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
