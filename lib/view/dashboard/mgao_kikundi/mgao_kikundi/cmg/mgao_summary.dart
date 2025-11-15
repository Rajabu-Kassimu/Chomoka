import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgawanyo_mwanachama.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class MgaoSummary extends StatefulWidget {
  final int? mzungukoId;
  final Map<String, dynamic> member;
  var mgaoKiasi;
  var pesaYaMgao;
  var userLength;
  final bool isFromSummary;

  MgaoSummary({
    super.key,
    this.mzungukoId,
    this.pesaYaMgao,
    this.userLength,
    required this.member,
    required this.mgaoKiasi,
    this.isFromSummary = false,
  });

  @override
  State<MgaoSummary> createState() => _MgaoSummaryState();
}

class _MgaoSummaryState extends State<MgaoSummary> {
  final TextEditingController _inputController = TextEditingController();
  double _mfukoJamiiTotal = 0;
  double _akibaLazimaTotal = 0;
  double _kiasiMzungukoUjao = 0;
  double _totalPaidAmount = 0;
  double _totalLoanAmount = 0;
  double _fainiTotal = 0;
  double _akibaHiariTotal = 0;
  String? _status;

  Future<void> _fetchMfukoJamiiTotalForUser() async {
    try {
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final result = await uchangiajiMfukoJamiiModel
          .where('user_id', '=', widget.member['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['total'] ?? 0) as double)
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _mfukoJamiiTotal = sum;
      });
    } catch (e) {
      setState(() {
        _mfukoJamiiTotal = 0;
      });
    }
  }

  Future<void> _fetchAkibaLazimaTotalForUser() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();
      final result = await akibaLazimaModel
          .where('user_id', '=', widget.member['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['amount'] ?? 0) as double)
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _akibaLazimaTotal = sum;
      });
    } catch (e) {
      setState(() {
        _akibaLazimaTotal = 0;
      });
    }
  }

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
      // setState(() {
      //   _totalPaidAmount = 0);
      // });
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

  @override
  void initState() {
    super.initState();
    _fetchDataForUser();
  }

  Future<void> _fetchDataForUser() async {
    await _fetchMfukoJamiiTotalForUser();
    await _fetchAkibaLazimaTotalForUser();
    await _fetchUserMgaoData();
    await _fetchTotalPaidAmount();
    await _fetchTotalLoanAmount();
    await _fetchFainiTotal();
    await _fetchAkibaHiariTotalForUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mgao wa Wanachama',
        subtitle: 'Muhtasari wa Mgao',
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryCard(),
              SizedBox(height: 15),
              if (_status != 'paid')
                CustomButton(
                  color: Colors.green,
                  buttonText: 'Toa kwenda mzunguko ujao',
                  onPressed: () {
                    _showInputDialog(context);
                  },
                  type: ButtonType.elevated,
                ),
              SizedBox(height: 20),
              if (_inputController
                  .text.isNotEmpty) // Check if text is not empty
                CustomButton(
                  color: Color.fromARGB(255, 24, 9, 240),
                  buttonText: 'Thibitisha',
                  onPressed: () async {
                    await _updateStatusToPaid();

                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MgawanyoMwanachama(
                          mzungukoId: widget.mzungukoId,
                          pesaYaMgao: widget.pesaYaMgao,
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

  Widget _buildSummaryCard() {
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
                  'Name: ${widget.member['name']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Namba ya mwanachama: ${widget.member['memberNumber']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Namba ya simu: ${widget.member['phone']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                const Divider(),
                _buildSummaryRow('Jumla ya Akiba:', _akibaLazimaTotal),
                const Divider(),
                _buildSummaryRow(
                    'Jumla ya Ziada Zilizopokelewa:',
                    ((_totalPaidAmount - _totalLoanAmount) /
                        widget.userLength)),
                const Divider(),
                _buildSummaryRow(
                    'Taarifa Mpya ya Mgao:', (_fainiTotal / widget.userLength)),
                const Divider(),
                _buildSummaryRow('Jumla ya Mfuko Jamii:', _mfukoJamiiTotal),
                const Divider(),
                _buildSummaryRow('Kiasi cha akiba binafsi:', _akibaHiariTotal),
                const Divider(),
                // _buildSummaryRow('Kiasi cha akiba \nkwenda mzunguko ujao:',
                //     _kiasiMzungukoUjao),
                // const Divider(),
                _buildSummaryRow('Kiasi cha akiba \nkwenda mzunguko ujao:',
                    _kiasiMzungukoUjao),
                const Divider(),
                _buildSummaryRow(
                    'Jumla ya Malipo:', (widget.mgaoKiasi + _akibaHiariTotal)),
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

  Widget _buildSummaryRow(String description, dynamic amount) {
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;
    final formattedAmount = formatCurrency((amount is num ? amount : 0), currencyCode);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(description),
          Text(
            formattedAmount,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showInputDialog(BuildContext context) {
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
                    const Text(
                      'Weka kiasi kwa ajili ya mzunguko ujao',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Kiasi',
                        hintText: 'Weka kiasi',
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
                          child: const Text(
                            'Ghairi',
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

                            if (enteredAmount <= widget.mgaoKiasi) {
                              double newMgaoKiasi =
                                  widget.mgaoKiasi - enteredAmount;

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
                                  content: Text(
                                      'Kiasi kinachowekwa lazima kiwe kidogo au sawa na mgao kiasi.'),
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
                          child: const Text(
                            'Thibitisha',
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
  final String? status;

  CustomMemberCard({
    required this.memberNumber,
    required this.name,
    this.mgaoAmount = 0.0,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
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
                    'Namba ya mwanachama: $memberNumber',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mgao: ' + formatCurrency(mgaoAmount, currencyCode),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor, // Set color dynamically
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
