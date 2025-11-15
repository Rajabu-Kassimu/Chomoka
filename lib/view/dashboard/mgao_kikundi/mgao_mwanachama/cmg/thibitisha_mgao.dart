import 'dart:convert';

import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/Service/sms_server.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/cmg/mgao_mwanachama.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class ThibishaMgao extends StatefulWidget {
  final Map<String, dynamic> user;
  var mzungukoId;
  var withdrawAmount;

  ThibishaMgao({
    Key? key,
    required this.user,
    this.mzungukoId,
    this.withdrawAmount,
  }) : super(key: key);

  @override
  State<ThibishaMgao> createState() => _ThibishaMgaoState();
}

class _ThibishaMgaoState extends State<ThibishaMgao> {
  double _akibaLazimaTotal = 0;
  double _akibaHiariTotal = 0;
  bool _hasUnpaidLoan = false;
  bool _hasUnpaidFaini = false;
  double _unpaidLoanAmount = 0.0;
  double _unpaidFainiAmount = 0.0;
  double _totalMgao = 0.0;
  String _smsOption = "Hapana";
  bool _lipaYote = false;
  bool _lipaKiasi = false;
  bool _haweziKulipa = false;
  String? _errorMessage;
  TextEditingController _lipaYoteController = TextEditingController();
  TextEditingController _lipaKiasiController = TextEditingController();

  Future<void> _fetchAkibaLazimaForMeeting() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();

      final result = await akibaLazimaModel
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Fetched Akiba Lazima Data: $result');

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['amount'] ?? 0) as double)
              .fold(0, (prev, element) => prev + element)
          : 0;

      print('Akiba Lazima Total Sum: $sum');

      setState(() {
        _akibaLazimaTotal = sum;
      });
    } catch (e) {
      print('Error fetching Akiba Lazima total: $e');
      setState(() {
        _akibaLazimaTotal = 0;
      });
    }
  }

  Future<void> _fetchAkibaHiariForMeeting() async {
    try {
      final akibaHiariModel = AkibaHiari();
      final result = await akibaHiariModel
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = result.isNotEmpty
          ? result
              .map((entry) => (entry['amount'] ?? 0).toDouble())
              .fold(0, (prev, element) => prev + element)
          : 0;

      setState(() {
        _akibaHiariTotal = sum;
      });
    } catch (e) {
      print('Error fetching Akiba Hiari total: $e');
      setState(() {
        _akibaHiariTotal = 0;
      });
    }
  }

  Future<void> _saveMgaoData() async {
    final userMgaoModel = UserMgaoModel();

    final existingEntry = await userMgaoModel
        .where('userId', '=', widget.user['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .first();

    if (existingEntry != null) {
      final userMgao = existingEntry as UserMgaoModel;
      await userMgaoModel.where('id', '=', userMgao.id).update({
        'mgaoAmount': _akibaLazimaTotal,
        'akibaBinafsi': _akibaHiariTotal,
        'status': 'paid',
        'type': 'personal',
      });
    } else {
      final newEntry = UserMgaoModel(
        userId: widget.user['id'],
        mzungukoId: widget.mzungukoId,
        mgaoAmount: _akibaLazimaTotal,
        akibaBinafsi: _akibaHiariTotal,
        status: 'paid',
        type: 'personal',
      );
      await newEntry.create();
    }

    await deleteUserInformation();
  }

  Future<bool> checkUnpaidLoanAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('unpaidAmount', '>', 0)
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalUnpaidAmount = 0.0;
      for (var record in results) {
        totalUnpaidAmount += record['unpaidAmount'] ?? 0.0;
      }

      print('Total Unpaid Amount: $totalUnpaidAmount');
      setState(() {
        _unpaidLoanAmount = totalUnpaidAmount;
      });
      return totalUnpaidAmount > 0;
    } catch (e) {
      print('Error checking unpaid mkopo: $e');
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

      final results = await userFainiModel
          .where('unpaidfaini', '>', 0)
          .where('user_id', '=', widget.user['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Results count: ${results.length}');

      double totalUnpaidFaini = 0.0;
      for (var record in results) {
        print('Raw Record: $record');

        totalUnpaidFaini += record['unpaidfaini'] ?? 0.0;
      }

      setState(() {
        _unpaidFainiAmount = totalUnpaidFaini;
      });

      totalMgao();

      print('Total Unpaid Faini: $totalUnpaidFaini');
      return totalUnpaidFaini > 0;
    } catch (e) {
      print('Error checking unpaid faini: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking unpaid faini')),
      );
      return false;
    }
  }

  Future<void> _deleteUserFromGroup() async {
    try {
      final groupMembersModel = GroupMembersModel();

      final rowsDeleted =
          await groupMembersModel.where('id', '=', widget.user['id']).delete();

      if (rowsDeleted > 0) {
        print('Successfully deleted user ${widget.user['id']}');
      } else {
        print('No user found with ID ${widget.user['id']}');
      }

      setState(() {});
    } catch (e) {
      print('Error deleting user ${widget.user['id']}: $e');
    }
  }

  void _showUnpayableDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Mwanachama anatakiwa kulipa madeni aliyokuwa nayo ili kuendela na mgao",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Sawa"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _makePayment() async {
    double enteredAmount = _lipaYote
        ? _unpaidFainiAmount + _unpaidLoanAmount
        : double.tryParse(_lipaKiasiController.text) ?? 0.0;

    setState(() {
      _errorMessage = null;
    });

    if (!_lipaYote &&
        (enteredAmount <= 0 ||
            enteredAmount > _unpaidFainiAmount + _unpaidLoanAmount)) {
      setState(() {
        _errorMessage = "Tafadhali ingiza kiasi sahihi cha malipo.";
      });
      return;
    }

    try {
      // Fetch loan data
      RejeshaMkopoModel existingLoan = RejeshaMkopoModel();
      existingLoan.where('mzungukoId', '=', widget.mzungukoId);
      List<BaseModel> loanResults = await existingLoan.find();
      if (loanResults.isEmpty) {
        throw Exception("Loan not found.");
      }
      RejeshaMkopoModel loanToUpdate = loanResults.first as RejeshaMkopoModel;

      // Fetch fine data
      UserFainiModel existingFine = UserFainiModel();
      existingFine.where('mzungukoId', '=', widget.mzungukoId);
      List<BaseModel> fineResults = await existingFine.find();
      if (fineResults.isEmpty) {
        throw Exception("Fine not found.");
      }
      UserFainiModel fineToUpdate = fineResults.first as UserFainiModel;

      if (_lipaYote) {
        // "Lipa Yote" logic: Set unpaid amounts to zero
        loanToUpdate.unpaidAmount = 0.0;
        fineToUpdate.unpaidfaini = 0;
      } else {
        // "Lipa Kiasi" logic: Pay loan first, then remaining amount for fine
        double remainingLoanAmount =
            (loanToUpdate.unpaidAmount ?? 0.0) - enteredAmount;
        if (remainingLoanAmount >= 0) {
          loanToUpdate.unpaidAmount = remainingLoanAmount;
        } else {
          loanToUpdate.unpaidAmount = 0.0;
          fineToUpdate.unpaidfaini =
              (fineToUpdate.unpaidfaini ?? 0) - remainingLoanAmount.toInt();
        }
      }

      // Save updated loan and fine data
      await existingLoan.where('id', '=', loanToUpdate.id).update({
        'unpaidAmount': loanToUpdate.unpaidAmount,
        'paidAmount': (loanToUpdate.paidAmount ?? 0.0) + enteredAmount,
        'payments': _updatePaymentHistory(loanToUpdate.payments, enteredAmount),
      });

      await existingFine.where('id', '=', fineToUpdate.id).update({
        'unpaidfaini': fineToUpdate.unpaidfaini,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Malipo yamefanikiwa!")),
      );

      _lipaKiasiController.clear();

      setState(() {
        // selectedOption = 'Punguza Deni';
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Imeshindikana kuhifadhi malipo: $e";
      });
    }
  }

  String _updatePaymentHistory(String? existingPayments, double amount) {
    List<Map<String, dynamic>> payments = [];
    if (existingPayments != null && existingPayments.isNotEmpty) {
      try {
        payments =
            List<Map<String, dynamic>>.from(json.decode(existingPayments));
      } catch (e) {
        print("Error parsing existing payments: $e");
      }
    }
    payments.add({
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
    });
    return json.encode(payments);
  }

  _sendSms() async {
    String? phoneNumber = (widget.user['phone']).toString();

    if (phoneNumber == null || phoneNumber.isEmpty) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Mwanachama hana namba ya simu"),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    String message = """
Ndugu ${widget.user['name']},

Muhtasari wako wa mgao ni:-

Akiba hiyari : ${formatCurrency(_akibaLazimaTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Akiba lazima: ${formatCurrency(_akibaHiariTotal.toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Malipo taslimu ${formatCurrency((_totalMgao).toInt(), Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
""";

    print(message);

    try {
      var sendSms = SmsService([phoneNumber], message);
      await sendSms.sendSms();
      // Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Mustasari umetumwa kwa ${widget.user['name']} Kikamilifu"),
          backgroundColor: Colors.black,
        ),
      );
    } catch (e) {
      print("Error sending SMS: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Imeshindwa kutuma SMS, tafadhali jaribu tena"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void totalMgao() {
    double lipaYoteAmount = double.tryParse(_lipaYoteController.text) ?? 0.0;
    double lipaKiasiAmount = double.tryParse(_lipaKiasiController.text) ?? 0.0;

    setState(() {
      if (_lipaYote) {
        _totalMgao =
            0.0; // Ikiwa Lipa Yote imechaguliwa, mgao lazima uwe sifuri
      } else {
        _totalMgao = (_akibaHiariTotal + _akibaLazimaTotal) -
            (_unpaidFainiAmount + _unpaidLoanAmount) -
            lipaYoteAmount -
            lipaKiasiAmount;
      }
    });
  }

  Future<void> deleteUserInformation() async {
    try {
      await faini();
      await mkopo();
      await hiari();
      await lazima();
      await jamii();

      setState(() {});
    } catch (e) {
      print(
          'Error deleting user information for mzungukoId: ${widget.mzungukoId} and userId: ${widget.user['id']}: $e');
    }
    await _deleteUserFromGroup();
  }

  jamii() async {
    final uchangaajiModel = UchangaajiMfukoJamiiModel();
    final records = await uchangaajiModel
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('user_id', '=', widget.user['id'])
        .where('paid_status', '=', 'unpaid')
        .select();

    print('Number of unpaid Uchangaaji records: ${records.length}');

    if (records.isNotEmpty) {
      final uchangaajiDeleted = await uchangaajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', widget.user['id'])
          .where('paid_status', '=', 'unpaid')
          .delete();

      if (uchangaajiDeleted > 0) {
        print('Deleted unpaid UchangaajiMfukoJamii records.');
      } else {
        print('Records found but deletion failed.');
      }
    } else {
      print('No unpaid Uchangaaji records found.');
    }
  }

  faini() async {
    final userFainiModel = UserFainiModel();
    final userFainiRecords = await userFainiModel
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('user_id', '=', widget.user['id'])
        .find();

    for (var record in userFainiRecords) {
      final userFaini = record as UserFainiModel;

      final existingUnpaidFaini = userFaini.unpaidfaini ?? 0;
      userFaini.paidfaini = existingUnpaidFaini;
      userFaini.unpaidfaini = 0;

      await userFainiModel.where('id', '=', userFaini.id).update({
        'paidfaini': userFaini.paidfaini,
        'unpaidfaini': userFaini.unpaidfaini,
      });

      print(
          'Updated userFaini: ID = ${userFaini.id}, Paid Fine = ${userFaini.paidfaini}, Unpaid Fine = ${userFaini.unpaidfaini}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Malipo yamefanywa kikamilifu.')),
      );
    }
  }

  mkopo() async {
    RejeshaMkopoModel existingLoan = RejeshaMkopoModel();

    existingLoan
        .where('user_id', '=', widget.user['id'])
        .where('mzungukoId', '=', widget.mzungukoId);

    List<BaseModel> results = await existingLoan.find();
    if (results.isEmpty) {
      throw Exception("Loan not found.");
    }

    RejeshaMkopoModel loanToUpdate = results.first as RejeshaMkopoModel;

    double unpaidLoanAmount = loanToUpdate.unpaidAmount ?? 0.0;

    loanToUpdate.paidAmount =
        (loanToUpdate.paidAmount ?? 0.0) + unpaidLoanAmount;
    loanToUpdate.unpaidAmount = 0.0;

    List<Map<String, dynamic>> updatedPayments = [];
    if (loanToUpdate.payments != null && loanToUpdate.payments!.isNotEmpty) {
      try {
        updatedPayments = List<Map<String, dynamic>>.from(
            json.decode(loanToUpdate.payments!));
      } catch (e) {
        print("Error parsing existing payments: $e");
        updatedPayments = [];
      }
    }

    updatedPayments.add({
      'amount': unpaidLoanAmount,
      'date': DateTime.now().toIso8601String(),
    });

    loanToUpdate.payments = json.encode(updatedPayments);

    Map<String, dynamic> updatedValues = {
      'paidAmount': loanToUpdate.paidAmount,
      'unpaidAmount': 0.0,
    };

    await existingLoan
        .where('user_id', '=', widget.user['id'])
        .where('mzungukoId', '=', widget.mzungukoId)
        .update(updatedValues);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deni lote limefanikiwa kulipwa!")),
    );
  }

  hiari() async {
    final akibaHiariModel = AkibaHiari();
    final akibaHiariDeleted = await akibaHiariModel
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('user_id', '=', widget.user['id'])
        .delete();

    if (akibaHiariDeleted > 0) {
      print(
          'Successfully deleted AkibaHiari data for mzungukoId: ${widget.mzungukoId} and userId: ${widget.user['id']}');
    } else {
      print(
          'No AkibaHiari data found for mzungukoId: ${widget.mzungukoId} and userId: ${widget.user['id']}');
    }
  }

  lazima() async {
    final akibaLazimaModel = AkibaLazimaModel();
    final akibaLazimaDeleted = await akibaLazimaModel
        .where('mzungukoId', '=', widget.mzungukoId)
        .where('user_id', '=', widget.user['id'])
        .delete();

    if (akibaLazimaDeleted > 0) {
      print(
          'Successfully deleted AkibaLazima data for mzungukoId: ${widget.mzungukoId} and userId: ${widget.user['id']}');
    } else {
      print(
          'No AkibaLazima data found for mzungukoId: ${widget.mzungukoId} and userId: ${widget.user['id']}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAkibaLazimaForMeeting().then((_) {
      _fetchAkibaHiariForMeeting().then((_) {
        checkUnpaidLoanAmount().then((hasUnpaidLoan) {
          setState(() {
            _hasUnpaidLoan = hasUnpaidLoan;
          });
          checkUnpaidFaini().then((hasUnpaidFaini) {
            setState(() {
              _hasUnpaidFaini = hasUnpaidFaini;
            });

            _lipaYoteController.text = (-_totalMgao).toStringAsFixed(0);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: l10n.memberShareout,
        subtitle: l10n.confirmShareout,
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person, size: 28),
                          radius: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.memberNameLabel(widget.user['name'] ?? l10n.unknownName),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                l10n.phoneNumberLabel(widget.user['phone'] ?? l10n.noPhone),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                l10n.phoneNumberLabel(widget.user['memberNumber'] ?? '-'),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.savings, color: Colors.blueAccent),
                            SizedBox(width: 8),
                            Text(
                              l10n.savings,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        if (_hasUnpaidLoan)
                          buildSummaryRow(
                            l10n.unpaidLoanAmount,
                            (_unpaidLoanAmount).toStringAsFixed(0),
                            isBold: true,
                            isRed: true,
                          ),
                        if (_hasUnpaidFaini)
                          buildSummaryRow(
                            l10n.unpaidFineAmount,
                            (_unpaidFainiAmount).toStringAsFixed(0),
                            isBold: true,
                            isRed: true,
                          ),
                        buildSummaryRow(
                          l10n.mandatorySavingsToBeWithdrawn,
                          _akibaLazimaTotal.toStringAsFixed(0),
                          color: Colors.green,
                        ),
                        buildSummaryRow(
                          l10n.voluntarySavingsToBeWithdrawn,
                          _akibaHiariTotal.toStringAsFixed(0),
                          color: Colors.green,
                        ),
                        Divider(),
                        if (_totalMgao < 0)
                          buildSummaryRow(
                            l10n.memberMustPayAmount,
                            (-_totalMgao).toStringAsFixed(0),
                            color: Colors.red,
                            isBold: true,
                          ),
                        if (_totalMgao > 0)
                          buildSummaryRow(
                            l10n.cashPayment,
                            (_totalMgao).toStringAsFixed(0),
                            color: Colors.green,
                            isBold: true,
                          ),
                        if (_totalMgao == 0)
                          buildSummaryRow(
                            l10n.noPaymentToMember,
                            (_totalMgao).toStringAsFixed(0),
                            color: Colors.green,
                            isBold: true,
                          ),
                      ],
                    ),
                  ),
                ),
                if (!_hasUnpaidFaini || !_hasUnpaidLoan) SizedBox(height: 16),
                if (_hasUnpaidFaini || _hasUnpaidLoan)
                  if (_totalMgao < 0)
                    Expanded(
                      child: SingleChildScrollView(
                        physics:
                            BouncingScrollPhysics(), // Hii inasaidia scrolling kuwa laini
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Hii inazuia kuchukua nafasi isiyo na kikomo
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: Text(
                                'Malipo',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _lipaYote,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _lipaYote = true;
                                        _lipaKiasi = false;
                                        _haweziKulipa = false;
                                      } else {
                                        _lipaYote = false;
                                      }
                                    });
                                  },
                                ),
                                Text("Lipa yote"),
                                Spacer(),
                                Text("TZS ${(-_totalMgao).toStringAsFixed(0)}"),
                              ],
                            ),
                            if (_lipaYote)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _lipaYoteController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Weka Kiasi",
                                        border: OutlineInputBorder(),
                                      ),
                                      enabled:
                                          false, // Camount imewekwa moja kwa moja
                                    ),
                                    SizedBox(height: 15),
                                    CustomButton(
                                      color: Colors.green,
                                      buttonText: 'Lipia Kiasi Chote',
                                      onPressed: () async {
                                        setState(() {
                                          // Mtumiaji akichagua lipa yote, hakikisha kiasi kimejazwa
                                          double totalAmount =
                                              _unpaidFainiAmount +
                                                  _unpaidLoanAmount;
                                          _lipaYoteController.text =
                                              totalAmount.toStringAsFixed(0);

                                          // Weka mgao kuwa 0
                                          _totalMgao = 0.0;
                                        });
                                      },
                                      type: ButtonType.elevated,
                                    ),
                                  ],
                                ),
                              ),
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       value: _lipaKiasi,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           if (value!) {
                            //             _lipaKiasi = true;
                            //             _lipaYote = false;
                            //             _haweziKulipa = false;
                            //           } else {
                            //             _lipaKiasi = false;
                            //           }
                            //         });
                            //       },
                            //     ),
                            //     Text("Lipa kiwango kingine"),
                            //   ],
                            // ),
                            if (_lipaKiasi)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _lipaKiasiController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Weka Kiasi",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    CustomButton(
                                      color: Colors.green,
                                      buttonText: 'Lipia Kiasi',
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MgaoWanachamaPage(
                                                      mzungukoId:
                                                          widget.mzungukoId)),
                                        );
                                      },
                                      type: ButtonType.elevated,
                                    ),
                                  ],
                                ),
                              ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _haweziKulipa,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _haweziKulipa = true;
                                        _lipaYote = false;
                                        _lipaKiasi = false;
                                        _showUnpayableDialog();
                                      } else {
                                        _haweziKulipa = false;
                                      }
                                    });
                                  },
                                ),
                                Text("Mwanachama hawezi kulipa"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                SizedBox(
                  height: 20,
                ),
                // if (!_hasUnpaidFaini || !_hasUnpaidLoan)
                Center(
                    child: Text(
                  "Tuma muhtasari kwa SMS",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
                // SizedBox(height: 10),
                // if (!_hasUnpaidFaini || !_hasUnpaidLoan)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: "Ndiyo",
                          groupValue: _smsOption,
                          onChanged: (value) {
                            setState(() {
                              _smsOption = value!;
                            });
                          },
                        ),
                        Text("Ndiyo"),
                        SizedBox(width: 16),
                        Radio<String>(
                          value: "Hapana",
                          groupValue: _smsOption,
                          onChanged: (value) {
                            setState(() {
                              _smsOption = value!;
                            });
                          },
                        ),
                        Text("Hapana"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: 'Maliza',
                  onPressed: () async {
                    if (_totalMgao < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Mwanachama anadaiwa lipa madeni yote kuendelea"),
                          backgroundColor: Colors.black,
                        ),
                      );
                      return;
                    }

                    if (_smsOption == "Ndiyo") {
                      await _sendSms();
                    }
                    // await deleteUserInformation();

                    await _saveMgaoData();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MgaoWanachamaPage(mzungukoId: widget.mzungukoId)),
                    );

                    print('Button Pressed');
                    print('SMS Option Selected: $_smsOption');
                  },
                  type: ButtonType.elevated,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryRow(String label, String value,
      {bool isBold = false, bool isRed = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            formatCurrency(double.tryParse(value) ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isRed ? Colors.red : color,
            ),
          ),
        ],
      ),
    );
  }
}
