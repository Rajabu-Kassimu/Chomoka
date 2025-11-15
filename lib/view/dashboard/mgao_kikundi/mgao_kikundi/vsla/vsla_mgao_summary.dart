import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgawanyo_mwanachama.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class VslaMgaoSummary extends StatefulWidget {
  final int? mzungukoId;
  final Map<String, dynamic> member;
  var mgaoKiasi;
  var mfukoJamii;
  var userLength;
  final bool isFromSummary;

  VslaMgaoSummary({
    super.key,
    this.mzungukoId,
    this.userLength,
    required this.member,
    required this.mgaoKiasi,
    required this.mfukoJamii,
    this.isFromSummary = false,
  });

  @override
  State<VslaMgaoSummary> createState() => _VslaMgaoSummaryState();
}

class _VslaMgaoSummaryState extends State<VslaMgaoSummary> {
  final TextEditingController _inputController = TextEditingController();
  double _akibaLazimaTotal = 0;
  double _kiasiMzungukoUjao = 0;
  double _totalPaidAmount = 0;
  double _totalLoanAmount = 0;
  double _fainiTotal = 0;
  double _akibaHiariTotal = 0;
  double _shareValue = 0.0; // Added share value property
  String? _status;
  int _memberShares = 0;
  double _sharePercentage = 0.0;
  double _faidaPortion = 0.0;
  double _mfukoJamiiPortion = 0.0;
  double _totalMgaoAmount = 0.0;

  // Add method to fetch share value
  Future<void> _fetchShareValue() async {
    try {
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        final value = double.tryParse(shareData.value ?? '0') ?? 0.0;
        setState(() {
          _shareValue = value;
        });
        print('Share value from katiba: TZS $_shareValue');
      }
    } catch (e) {
      print('Error fetching share value: $e');
      setState(() {
        _shareValue = 0.0;
      });
    }
  }

  // Fetch member shares
  Future<void> _fetchMemberShares() async {
    try {
      final memberShareModel = MemberShareModel();
      final shares = await memberShareModel
          .where('user_id', '=', widget.member['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int totalShares = 0;
      if (shares.isNotEmpty) {
        totalShares = shares
            .map((share) => (share['number_of_shares'] ?? 0) as int)
            .fold(0, (prev, count) => prev + count);
      }

      // Get total shares for all members to calculate percentage
      final allShares = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int groupTotalShares = 0;
      if (allShares.isNotEmpty) {
        groupTotalShares = allShares
            .map((share) => (share['number_of_shares'] ?? 0) as int)
            .fold(0, (prev, count) => prev + count);
      }

      // Calculate share percentage
      double sharePercentage =
          groupTotalShares > 0 ? totalShares / groupTotalShares : 0.0;

      setState(() {
        _memberShares = totalShares;
        _sharePercentage = sharePercentage;
      });

      print(
          'Member shares: $_memberShares (${(_sharePercentage * 100).toStringAsFixed(2)}%)');
    } catch (e) {
      print('Error fetching member shares: $e');
      setState(() {
        _memberShares = 0;
        _sharePercentage = 0.0;
      });
    }
  }

  // Future<void> _fetchMfukoJamiiTotalForUser() async {
  //   try {
  //     final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
  //     final result = await uchangiajiMfukoJamiiModel
  //         .where('user_id', '=', widget.member['id'])
  //         .where('mzungukoId', '=', widget.mzungukoId)
  //         .select();

  //     double sum = 0;
  //     if (result.isNotEmpty) {
  //       sum = result
  //           .map((entry) => (entry['total'] ?? 0) as double)
  //           .fold(0, (prev, element) => prev + element);
  //     }

  //     setState(() {
  //       _mfukoJamiiTotal = sum;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _mfukoJamiiTotal = 0;
  //     });
  //   }
  // }

  Future<void> _fetchUserMgaoData() async {
    final userMgaoModel = UserMgaoModel();
    final existingEntry = await userMgaoModel
        .where('userId', '=', widget.member['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('type', '=', 'group')
        .first();

    if (existingEntry != null) {
      final userMgao = existingEntry as UserMgaoModel;
      setState(() {
        _kiasiMzungukoUjao = userMgao.mzungukoUjaoAkiba ?? 0;
        widget.mgaoKiasi = userMgao.mgaoAmount ?? 0;
        _status = userMgao.status;
      });
    }
  }

  Future<void> _updateOrCreateUserMgao(
      double newMgaoKiasi, double enteredAmount) async {
    final userMgaoModel = UserMgaoModel();
    final existingEntry = await userMgaoModel
        .where('userId', '=', widget.member['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('type', '=', 'group')
        .first();

    if (existingEntry != null) {
      final userMgao = existingEntry as UserMgaoModel;
      await userMgaoModel.where('id', '=', userMgao.id).update({
        'mgaoAmount': newMgaoKiasi,
        'mzungukoUjaoAkiba': enteredAmount,
      });
    } else {
      final newEntry = UserMgaoModel(
        userId: widget.member['id'],
        mzungukoId: widget.mzungukoId,
        type: 'group',
        mgaoAmount: newMgaoKiasi,
        mzungukoUjaoAkiba: enteredAmount,
      );
      await newEntry.create();
    }

    final savedEntry = await userMgaoModel
        .where('userId', '=', widget.member['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('type', '=', 'group')
        .first();

    if (savedEntry != null) {
      final userMgao = savedEntry as UserMgaoModel;
      print('Saved Entry:');
      print('ID: ${userMgao.id}');
      print('User ID: ${userMgao.userId}');
      print('Mzunguko ID: ${userMgao.mzungukoId}');
      print('Mgao Amount: ${userMgao.mgaoAmount}');
      print('Mgao Type: ${userMgao.type}');
      print('Mzunguko Ujao Akiba: ${userMgao.mzungukoUjaoAkiba}');
    } else {
      print('No entry found after save operation.');
    }
  }

  Future<void> _updateStatusToPaid() async {
    final userMgaoModel = UserMgaoModel();
    final existingEntry = await userMgaoModel
        .where('userId', '=', widget.member['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .first();

    if (existingEntry != null) {
      final userMgao = existingEntry as UserMgaoModel;
      await userMgaoModel.where('id', '=', userMgao.id).update({
        'status': 'paid',
      });
      setState(() {
        _status = 'paid';
      });
    } else {
      print('No entry found to update status.');
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
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

  Future<void> _fetchAkibaHiariTotalForUser() async {
    try {
      final akibaHiariModel = AkibaHiari();
      final result = await akibaHiariModel
          .where('user_id', '=', widget.member['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['amount'] ?? 0).toDouble())
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _akibaHiariTotal = sum;
      });
      print('Akiba Hiari for user ${widget.member['id']}: $_akibaHiariTotal');
    } catch (e) {
      print(
          'Error fetching Akiba Hiari total for user ${widget.member['id']}: $e');
      setState(() {
        _akibaHiariTotal = 0;
      });
    }
  }

  // Calculate member's portion of faida and mfuko jamii
  void _calculateMemberPortions() {
    // Get values from the member data passed from vsla_mgawanyo_mwanachama.dart
    _faidaPortion = widget.member['faidaPortion'] ?? 0.0;
    _mfukoJamiiPortion = widget.member['mfukoJamiiPortion'] ?? 0.0;
    double shareValue = widget.member['shareValue'] ?? 0.0;
    
    // Calculate total mgao amount using the same formula as in vsla_mgawanyo_mwanachama.dart
    _totalMgaoAmount = _faidaPortion + _mfukoJamiiPortion + shareValue;
    
    print('Using values from vsla_mgawanyo_mwanachama:');
    print('Faida portion: ${_faidaPortion.toStringAsFixed(0)}, Mfuko Jamii: ${_mfukoJamiiPortion.toStringAsFixed(0)}');
    print('Share value: ${shareValue.toStringAsFixed(0)}');
    print('Total mgao amount: ${_totalMgaoAmount.toStringAsFixed(0)}');
  }

  @override
  void initState() {
    super.initState();
    
    // Initialize values from the member data passed from vsla_mgawanyo_mwanachama.dart
    _memberShares = widget.member['shares'] ?? 0;
    _sharePercentage = widget.member['sharePercentage'] ?? 0.0;
    _faidaPortion = widget.member['faidaPortion'] ?? 0.0;
    _mfukoJamiiPortion = widget.mfukoJamii;
    _totalMgaoAmount = widget.mgaoKiasi;
    
    _fetchDataForUser();
  }

  Future<void> _fetchDataForUser() async {
    await _fetchShareValue();
    await _fetchMemberShares();
    await _fetchUserMgaoData();
    await _fetchTotalPaidAmount();
    await _fetchTotalLoanAmount();
    await _fetchFainiTotal();
    await _fetchAkibaHiariTotalForUser();

    // Set values from the member data passed from vsla_mgawanyo_mwanachama.dart
    setState(() {
      _memberShares = widget.member['shares'] ?? 0;
      _sharePercentage = widget.member['sharePercentage'] ?? 0.0;
      _faidaPortion = widget.member['faidaPortion'] ?? 0.0;
      _mfukoJamiiPortion = widget.member['mfukoJamiiPortion'] ?? 0.0;
      _totalMgaoAmount = widget.mgaoKiasi;
    });
    
    // Calculate member's portions after fetching all data
    _calculateMemberPortions();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberShareSummaryTitle,
        subtitle: l10n.memberShareSummarySubtitle,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryCard(l10n),
              SizedBox(height: 15),
              if (_status != 'paid')
                CustomButton(
                  color: Colors.green,
                  buttonText: l10n.giveToNextCycle,
                  onPressed: () {
                    _showInputDialog(context, l10n);
                  },
                  type: ButtonType.elevated,
                ),
              SizedBox(height: 20),
              if (_inputController.text.isNotEmpty)
                CustomButton(
                  color: Color.fromARGB(255, 24, 9, 240),
                  buttonText: l10n.confirm,
                  onPressed: () async {
                    await _updateStatusToPaid();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VslaMgawanyoMwanachama(
                          mzungukoId: widget.mzungukoId,
                        ),
                      ),
                    );
                  },
                  type: ButtonType.elevated,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(AppLocalizations l10n) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.memberName((widget.member['name'] ?? '').toString()),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  l10n.memberNumberLabel((widget.member['memberNumber'] ?? '').toString()),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  l10n.memberPhone((widget.member['phone'] ?? '').toString()),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                const Divider(),
                _buildSectionHeader(l10n.shareInfoSection),
                _buildSummaryRow(l10n.numberOfShares, _memberShares),
                _buildSummaryRow(l10n.sharePercentage, '${(_sharePercentage * 100).toStringAsFixed(1)}%'),
                _buildSummaryRow(l10n.shareValue, _shareValue * _memberShares),
                const Divider(),
                _buildSectionHeader(l10n.profitInfoSection),
                _buildSummaryRow(l10n.profitShare, _faidaPortion),
                _buildSummaryRow(l10n.socialFundShare, _mfukoJamiiPortion),
                const Divider(),
                _buildSectionHeader(l10n.distributionSummarySection),
                _buildSummaryRow(l10n.summaryShareValue, _shareValue * _memberShares),
                _buildSummaryRow(l10n.summaryProfit, _faidaPortion),
                _buildSummaryRow(l10n.summarySocialFund, widget.mfukoJamii),
                _buildSummaryRow(l10n.summaryTotalDistribution, _totalMgaoAmount, isHighlighted: true),
                const Divider(),
                _buildSectionHeader(l10n.paymentInfoSection),
                _buildSummaryRow(l10n.amountToNextCycle, _kiasiMzungukoUjao),
                _buildSummaryRow(l10n.paymentAmount, (_totalMgaoAmount - _kiasiMzungukoUjao), isHighlighted: true),
              ],
            ),
          ),
        ),
        if (_status == 'paid')
          Positioned(
            bottom: -70,
            left: -20,
            child: Image.asset(
              'assets/images/paid1.png',
              height: 200,
            ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String description, dynamic amount,
      {bool isHighlighted = false}) {
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;
    final formattedAmount = amount is num ? formatCurrency(amount, currencyCode) : amount.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: isHighlighted ? 15.0 : 14.0,
              ),
            ),
          ),
          Text(
            formattedAmount,
            style: TextStyle(
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              fontSize: isHighlighted ? 16.0 : 14.0,
              color: isHighlighted ? Colors.green[700] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showInputDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.inputAmountForNextCycle,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.amount,
                        hintText: l10n.inputAmountForNextCycle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red, // Red background
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                          child: Text(
                            l10n.cancel,
                            style: TextStyle(
                                color: Colors.white), // White text color
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () async {
                            String enteredAmountStr = _inputController.text;
                            double enteredAmount =
                                double.tryParse(enteredAmountStr) ?? 0.0;

                            if (enteredAmount <= _totalMgaoAmount) {
                              double newMgaoKiasi =
                                  _totalMgaoAmount - enteredAmount;

                              await _updateOrCreateUserMgao(
                                  newMgaoKiasi, enteredAmount);

                              setState(() {
                                widget.mgaoKiasi = newMgaoKiasi;
                                _kiasiMzungukoUjao = enteredAmount;
                              });

                              Navigator.of(context).pop(); // Close dialog
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.amountMustBeLessThanOrEqualTotal),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Green background
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                          child: Text(
                            l10n.confirmButton,
                            style: TextStyle(
                                color: Colors.white), // White text color
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
}

class CustomMemberCard extends StatelessWidget {
  final String memberNumber;
  final String name;
  final double mgaoAmount;
  final int shares;
  final double sharePercentage;
  final double faidaPortion;
  final double mfukoJamiiPortion;
  final double shareValue;
  final String? status;

  CustomMemberCard({
    required this.memberNumber,
    required this.name,
    this.mgaoAmount = 0.0,
    this.shares = 0,
    this.sharePercentage = 0.0,
    this.faidaPortion = 0.0,
    this.mfukoJamiiPortion = 0.0,
    this.shareValue = 0.0,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color amountColor = (status == 'paid') ? Colors.red : Colors.green;
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Icon(Icons.person, size: 30.0, color: Colors.black),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    l10n.memberNumberLabel
                    (memberNumber),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    l10n.totalShareAmount(shares.toString(), (sharePercentage * 100).toStringAsFixed(1)),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    l10n.shareValueAmount(formatCurrency(shareValue, currencyCode)),
                    style: TextStyle(fontSize: 14.0, color: Colors.indigo[800]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.totalDistributionAmount(formatCurrency(mgaoAmount, currencyCode)),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
