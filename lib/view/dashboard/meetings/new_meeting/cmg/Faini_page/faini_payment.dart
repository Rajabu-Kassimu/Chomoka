import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:flutter/services.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class FainiPaymentPage extends StatefulWidget {
  var userId;
  var meetingId;
  var userName;
  var userNumber;
  var mzungukoId;
  final bool isFromMgaowakikundi;

  FainiPaymentPage(
      {this.userId,
      this.meetingId,
      this.userName,
      this.userNumber,
      this.mzungukoId,
      this.isFromMgaowakikundi = false});

  @override
  _FainiPaymentPageState createState() => _FainiPaymentPageState();
}

class _FainiPaymentPageState extends State<FainiPaymentPage> {
  double totalFines = 0.0;
  double totalPaid = 0.0;
  double totalUnpaid = 0.0;
  TextEditingController _amountController = TextEditingController();
  String? _errorText;
  bool isLoading = true;
  String paymentOption = 'all';

  @override
  void initState() {
    super.initState();
    _fetchFainiSummary();
  }

  Future<void> _fetchFainiSummary() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userFainiModel = UserFainiModel();
      final userFainiRecords = await userFainiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('user_id', '=', widget.userId)
          .find();

      print("Fetched Records: $userFainiRecords");

      double fines = 0.0;
      double paid = 0.0;

      for (var record in userFainiRecords) {
        final userFaini = record as UserFainiModel;

        final fineAmount = userFaini.unpaidfaini?.toDouble() ?? 0.0;

        fines += fineAmount;
        paid += userFaini.paidfaini?.toDouble() ?? 0.0;
      }

      print("Total Fines (direct calculation): $fines, Total Paid: $paid");

      setState(() {
        totalFines = fines;
        totalPaid = paid;
        totalUnpaid = fines;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching fine summary: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia data.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _payFine() async {
    double amount = 0.0;

    if (paymentOption == 'all') {
      amount = totalUnpaid;
    } else {
      amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

      if (amount <= 0) {
        setState(() {
          _errorText = 'Tafadhali ingiza kiasi halali.';
        });
        return;
      }

      if (amount > totalUnpaid) {
        setState(() {
          _errorText = 'Kiasi kinazidi faini inayodaiwa.';
        });
        return;
      }

      setState(() {
        _errorText = null;
      });
    }

    try {
      final userFainiModel = UserFainiModel();
      final userFainiRecords = await userFainiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          // .where('meeting_id', '=', widget.meetingId)
          .where('user_id', '=', widget.userId)
          .find();

      double remainingAmount = amount;

      for (var record in userFainiRecords) {
        if (remainingAmount <= 0) break;

        final userFaini = record as UserFainiModel;
        final unpaid = userFaini.unpaidfaini?.toDouble() ?? 0.0;

        if (unpaid > 0) {
          final payment = remainingAmount > unpaid ? unpaid : remainingAmount;
          remainingAmount -= payment;

          userFaini.paidfaini = (userFaini.paidfaini ?? 0) + payment.toInt();
          userFaini.unpaidfaini = (unpaid - payment).toInt();

          await userFaini.where('id', '=', userFaini.id).update({
            'paidfaini': userFaini.paidfaini,
            'unpaidfaini': userFaini.unpaidfaini,
          });
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Malipo yamefanywa kikamilifu.')),
      );

      _fetchFainiSummary();
    } catch (e) {
      print('Error processing payment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kufanya malipo.')),
      );
    }
  }

  void _showPaymentModal() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.payFineTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      l10n.totalUnpaidLabel(formatCurrency(totalUnpaid, Provider.of<CurrencyProvider>(context).currencyCode)),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      l10n.choosePaymentType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 10, 177, 4),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        l10n.payAllFines,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio<String>(
                        value: 'all',
                        groupValue: paymentOption,
                        activeColor: Colors.blueAccent,
                        onChanged: (value) {
                          setModalState(() {
                            paymentOption = value!;
                            _amountController.clear();
                            _errorText = null;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        l10n.payCustomAmount,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio<String>(
                        value: 'custom',
                        groupValue: paymentOption,
                        activeColor: const Color.fromARGB(255, 39, 4, 240),
                        onChanged: (value) {
                          setModalState(() {
                            paymentOption = value!;
                            _errorText = null;
                          });
                        },
                      ),
                    ),
                    if (paymentOption == 'custom') ...[
                      SizedBox(height: 12),
                      TextField(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: l10n.enterPaymentAmount,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 26, 4, 226)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                      ),
                    ],
                    if (_errorText != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _errorText!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _payFine();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.payFine,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberFinesTitle,
        subtitle: l10n.payFine,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Information Card
                          Card(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color.fromARGB(
                                        255, 148, 148, 148),
                                    child: Text(
                                      widget.userId != null &&
                                              widget.userNumber
                                                  .toString()
                                                  .isNotEmpty
                                          ? widget.userId
                                              .toString()[0]
                                              .toUpperCase()
                                          : "?",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.memberNameLabel(widget.userName),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          l10n.memberNumberLabel(
                                              widget.userNumber),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Summary Card
                          Container(
                            width: double.infinity,
                            child: Card(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.totalFinesLabel(formatCurrency(totalFines, Provider.of<CurrencyProvider>(context).currencyCode)),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      l10n.totalPaidLabel(formatCurrency(totalPaid, Provider.of<CurrencyProvider>(context).currencyCode)),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      l10n.totalUnpaidLabel(formatCurrency(totalUnpaid, Provider.of<CurrencyProvider>(context).currencyCode)),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 20),
                                    // Payment button
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: totalUnpaid > 0
                                            ? _showPaymentModal
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14),
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          elevation: 5,
                                          shadowColor:
                                              Colors.green.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.payment, size: 24),
                                            SizedBox(width: 10),
                                            Text(
                                              l10n.payFine,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Removed the inline payment options section
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.doneButton,
                    onPressed: () {
                      if (widget.isFromMgaowakikundi) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LipaFainiPage(
                                meetingId: widget.meetingId,
                              ),
                            ));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
    );
  }
}
