import 'dart:convert';
import 'package:chomoka/model/ToaAkibaHiari.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ToaAkibaHiariAmountPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final int meetingId;
  var mzungukoId;

  ToaAkibaHiariAmountPage({
    Key? key,
    required this.user,
    this.mzungukoId,
    required this.meetingId,
  }) : super(key: key);

  @override
  _ToaAkibaHiariAmountPageState createState() =>
      _ToaAkibaHiariAmountPageState();
}

class _ToaAkibaHiariAmountPageState extends State<ToaAkibaHiariAmountPage> {
  String? _selectedOption;
  double _totalAkiba = 0;
  double _totalWithdrawn = 0;
  bool isLoading = true;
  String? _errorText;
  double _withdrawAmount = 0;
  double _remainingAmount = 0;
  List<Map<String, dynamic>> _withdrawalHistory = [];
  TextEditingController _amountController = TextEditingController();

  Future<void> _fetchData() async {
    try {
      await BaseModel.ensureDatabaseInitialized();

      final akibaHiariModel = ToaAkibaHiariModel();
      akibaHiariModel
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId);
      final records = await akibaHiariModel.select();

      double totalBalance = 0.0;
      double remainingBalance = 0.0;
      double totalWithdrawn = 0.0;
      List<Map<String, dynamic>> allHistory = [];

      if (records.isNotEmpty) {
        // Sum up all available amounts for this mzunguko
        totalBalance = records.fold(0.0, (sum, record) {
          return sum +
              ((record['available_amount'] as num?)?.toDouble() ?? 0.0);
        });

        // Process history and withdrawals
        for (var record in records) {
          List<Map<String, dynamic>> history = [];
          if (record['history'] != null) {
            try {
              history = List<Map<String, dynamic>>.from(
                  json.decode(record['history']));
            } catch (e) {
              print("Error decoding history: $e");
            }
          }

          double withdrawn = history.fold(0.0, (sum, entry) {
            return sum + ((entry['amount'] as num?)?.toDouble() ?? 0.0);
          });

          totalWithdrawn += withdrawn;
          allHistory.addAll(history);
        }

        // Calculate remaining balance
        remainingBalance = totalBalance - totalWithdrawn;
      }

      setState(() {
        _totalAkiba = totalBalance;
        _remainingAmount = remainingBalance;
        _totalWithdrawn = totalWithdrawn;
        _withdrawalHistory = allHistory;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> printAllData() async {
    try {
      await BaseModel.ensureDatabaseInitialized();

      final akibaHiariModel = ToaAkibaHiariModel();
      final records = await akibaHiariModel.select(); // Pata rekodi zote

      if (records.isNotEmpty) {
        for (var record in records) {
          print(record); // Chapisha kila rekodi
        }
      } else {
        print("Hakuna rekodi zilizopo kwenye ToaAkibaHiariModel.");
      }
    } catch (e) {
      print('Error fetching all data: $e');
    }
  }

  Future<void> _saveData() async {
    try {
      final akibaHiariModel = ToaAkibaHiariModel();
      akibaHiariModel.where('user_id', '=', widget.user['id']);
      final existingRecords = await akibaHiariModel.select();

      if (existingRecords.isNotEmpty) {
        final latestRecord = existingRecords.last;

        double updatedRemainAmount =
            (latestRecord['remain_amount'] as double? ?? _totalAkiba) -
                _withdrawAmount;

        List<Map<String, dynamic>> updatedHistory =
            latestRecord['history'] != null
                ? List<Map<String, dynamic>>.from(
                    jsonDecode(latestRecord['history']))
                : [];
        updatedHistory.add({
          "date": DateTime.now().toIso8601String(),
          "amount": _withdrawAmount,
        });

        await akibaHiariModel.where('id', '=', latestRecord['id']).update({
          'remain_amount': updatedRemainAmount,
          'history': jsonEncode(updatedHistory),
        });
      } else {
        // If no record exists, create a new record
        final newModel = ToaAkibaHiariModel(
          userId: widget.user['id'],
          amount: _withdrawAmount,
          mzungukoId: widget.mzungukoId,
          availableAmount: _totalAkiba, // Total akiba remains fixed
          remainAmount:
              _totalAkiba - _withdrawAmount, // Remaining amount is reduced
          history: [
            {
              "date": DateTime.now().toIso8601String(),
              "amount": _withdrawAmount,
            }
          ],
        );
        await newModel.create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Utoaji umehifadhiwa kwa mafanikio!')),
      );

      // Refresh the data
      await _fetchData();
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.'),
        ),
      );
    }
  }

  void _proceed() {
    if (_remainingAmount <= 0) {
      setState(() {
        _errorText = "Hauna salio la kutosha.";
      });
      return;
    }

    if (_selectedOption == "toa_kiasi_kingine") {
      _withdrawAmount = double.tryParse(_amountController.text) ?? 0;

      if (_withdrawAmount <= 0) {
        setState(() {
          _errorText = "Tafadhali ingiza kiasi zaidi ya sifuri.";
        });
        return;
      }

      if (_withdrawAmount > _remainingAmount) {
        setState(() {
          _errorText =
              "Kiasi hakiwezi kuzidi kiasi anachoweza kutoa: " + formatCurrency(_remainingAmount, Provider.of<CurrencyProvider>(context).currencyCode) + ".";
        });
        return;
      }
    } else if (_selectedOption == "toa_yote") {
      _withdrawAmount = _remainingAmount;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tafadhali chagua chaguo moja.")),
      );
      return;
    }

    // Update remaining amount and total withdrawn
    setState(() {
      _remainingAmount -= _withdrawAmount; // Deduct withdrawn amount
      _totalWithdrawn += _withdrawAmount; // Add to total withdrawn
      _errorText = null;
    });

    _saveData(); // Save the changes to the database
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    printAllData();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Akiba Hiari',
        subtitle: 'Toa Akiba Hiari',
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserInfo(),
                        SizedBox(height: 16),
                        _buildSummaryCard(),
                        SizedBox(height: 16),
                        _buildWithdrawalOptions(),
                        SizedBox(height: 20),
                        _buildProceedButton(),
                        SizedBox(height: 20),
                        _buildHistorySection(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: 'Nimemaliza',
                      onPressed: () {
                        Navigator.pop(context);
                        print('Button Pressed');
                      },
                      type: ButtonType.elevated,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildUserInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 30),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Namba ya mwanachama: ${widget.user['memberNumber']}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "Namba ya simu: ${widget.user['phone']}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "Salio la Sasa: " + formatCurrency(_remainingAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow("Jumla ya Akiba:", _totalAkiba),
            SizedBox(height: 10),
            _buildSummaryRow(
              "Kiasi Anachoweza Kutoa:",
              _remainingAmount,
            ),
            SizedBox(height: 10),
            _buildSummaryRow("Kiasi Alichotoa:", _totalWithdrawn, isRed: true),
            SizedBox(height: 10),
            _buildSummaryRow(
              "Salio la Sasa:",
              _remainingAmount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            formatCurrency(value, Provider.of<CurrencyProvider>(context).currencyCode),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isRed ? Colors.red : Colors.black, // Conditional color
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalOptions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chagua kiwango cha utoaji',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            RadioListTile<String>(
              title: Text("Toa yote"),
              subtitle: Text(
                "TZS " + formatCurrency(_remainingAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: "toa_yote",
              groupValue: _selectedOption,
              onChanged: _remainingAmount > 0
                  ? (value) {
                      setState(() {
                        _selectedOption = value;
                        _amountController.clear();
                      });
                    }
                  : null, // Disable if remaining amount is 0
            ),
            RadioListTile<String>(
              title: Text("Toa kiasi kingine"),
              value: "toa_kiasi_kingine",
              groupValue: _selectedOption,
              onChanged: _remainingAmount > 0
                  ? (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    }
                  : null, // Disable if remaining amount is 0
            ),
            if (_selectedOption == "toa_kiasi_kingine")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Ingiza kiasi",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
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

  Widget _buildProceedButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _remainingAmount > 0
              ? _proceed
              : null, // Disable if remaining amount is 0
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Toa Akiba Hiari',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historia ya Utoaji',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        _withdrawalHistory.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _withdrawalHistory.length,
                itemBuilder: (context, index) {
                  final history = _withdrawalHistory[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.shade100,
                        ),
                        child: Icon(
                          Icons.payment,
                          color: Colors.orange,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        "Ametoa: " + formatCurrency(history['amount'] ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "Tarehe: ${history['date']}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Text(
                "Hakuna historia ya utoaji iliyorekodiwa.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
      ],
    );
  }
}
