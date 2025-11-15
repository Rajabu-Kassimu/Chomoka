// RepaymentDetailsPage.dart
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart'; // Add this import
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class RepaymentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> loan;
  final List<Map<String, dynamic>> allMembers;
  final int? meetingId;
  var mzungukoId;
  final bool fromDashboard;
  final bool isFromMgaowakikundi;

  RepaymentDetailsPage({
    required this.loan,
    required this.allMembers,
    this.meetingId,
    required this.mzungukoId,
    this.fromDashboard = false,
    this.isFromMgaowakikundi = false,
  });

  @override
  _RepaymentDetailsPageState createState() => _RepaymentDetailsPageState();
}

class _RepaymentDetailsPageState extends State<RepaymentDetailsPage> {
  final TextEditingController _paymentController = TextEditingController();
  double remainingLoan = 0;
  double paymentAmount = 0;
  String selectedOption = 'Punguza Deni';
  String? _errorMessage;
  String interestRate = ''; // Add this variable
  String interestType = ''; // Add this variable
  double originalLoanAmount = 0.0; // Add this variable
  String loanDate = ''; // Add this variable

  List<Map<String, dynamic>> paymentHistory = [];

  void _loadPaymentHistory() {
    if (widget.loan['payments'] is String &&
        (widget.loan['payments'] as String).isNotEmpty) {
      try {
        List<dynamic> payments = json.decode(widget.loan['payments'] as String);
        setState(() {
          paymentHistory = payments.map((payment) {
            return {
              'amount': payment['amount'],
              'date': payment['date'],
            };
          }).toList();
        });
        print(paymentHistory);
      } catch (e) {
        print("Error parsing payments JSON: $e");
        setState(() {
          paymentHistory = [];
          _errorMessage = "Imeshindikana kuchakata historia ya malipo.";
        });
      }
    } else {
      setState(() {
        paymentHistory = [];
      });
    }
  }

  void _makePayment() async {
    double enteredAmount;

    if (selectedOption == 'Lipa Yote') {
      enteredAmount = remainingLoan;
    } else {
      enteredAmount = double.tryParse(_paymentController.text) ?? 0.0;
    }

    setState(() {
      _errorMessage = null;
    });

    if (enteredAmount <= 0 || enteredAmount > remainingLoan) {
      setState(() {
        _errorMessage = "Tafadhali ingiza kiasi sahihi cha malipo.";
      });
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      RejeshaMkopoModel existingLoan = RejeshaMkopoModel();
      existingLoan
          .where('id', '=', widget.loan['id'])
          .where('mzungukoId', '=', widget.mzungukoId);
      List<BaseModel> results = await existingLoan.find();
      if (results.isEmpty) {
        throw Exception("Loan not found.");
      }
      RejeshaMkopoModel loanToUpdate = results.first as RejeshaMkopoModel;

      loanToUpdate.paidAmount =
          (loanToUpdate.paidAmount ?? 0.0) + enteredAmount;
      loanToUpdate.unpaidAmount =
          (loanToUpdate.unpaidAmount ?? 0.0) - enteredAmount;

      // Update meeting_id for the payment
      loanToUpdate.meetingId = widget.meetingId;

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
        'amount': enteredAmount,
        'date': DateTime.now().toIso8601String(),
        'meeting_id': widget.meetingId, // Add meeting_id to payment history
      });
      print(updatedPayments);
      loanToUpdate.payments = json.encode(updatedPayments);

      Map<String, dynamic> updatedValues = {
        'paidAmount': loanToUpdate.paidAmount,
        'unpaidAmount': loanToUpdate.unpaidAmount,
        'payments': loanToUpdate.payments,
        'meeting_id': widget.meetingId, // Update meeting_id in the main record
      };

      await existingLoan
          .where('id', '=', widget.loan['id'])
          .where('mzungukoId', '=', widget.mzungukoId)
          .update(updatedValues);

      setState(() {
        paymentAmount += enteredAmount;
        remainingLoan -= enteredAmount;
        paymentHistory.add({
          'amount': enteredAmount,
          'date': DateTime.now().toIso8601String(),
        });
      });

      Navigator.of(context).pop();

      if (selectedOption != 'Lipa Yote') {
        _paymentController.clear();
      }

      setState(() {
        selectedOption = 'Punguza Deni';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Malipo yamefanikiwa!")),
      );
    } catch (e) {
      Navigator.of(context).pop();

      setState(() {
        _errorMessage = "Imeshindikana kuhifadhi malipo: $e";
      });
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    } catch (e) {
      return dateStr;
    }
  }

  Future<void> _fetchInterestInfo() async {
    try {
      final katibaModel = KatibaModel();

      // Fetch interest rate
      final rateQuery = katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId);
      final rateData = await rateQuery.findOne();
      if (rateData != null && rateData is KatibaModel) {
        setState(() {
          interestRate = rateData.value ?? '';
        });
      }

      // Fetch interest type
      final typeQuery = katibaModel
          .where('katiba_key', '=', 'interest_type')
          .where('mzungukoId', '=', widget.mzungukoId);
      final typeData = await typeQuery.findOne();
      if (typeData != null && typeData is KatibaModel) {
        setState(() {
          interestType = typeData.value ?? '';
        });
      }
    } catch (e) {
      print('Error fetching interest data: $e');
    }
  }

  Future<void> _fetchLoanDetails() async {
    try {
      final toaMkopoModel = ToaMkopoModel();

      // Check if userId exists in the loan data
      final userId = widget.loan['userId'];
      if (userId == null) {
        print('User ID is null, trying to fetch loan using loan ID instead');

        // Try to use the loan ID to fetch the original loan details
        final loanId = widget.loan['id'];
        if (loanId != null) {
          final loanQuery = toaMkopoModel
              .where('id', '=', loanId)
              .where('mzungukoId', '=', widget.mzungukoId);

          final loanData = await loanQuery.findOne();
          if (loanData != null && loanData is ToaMkopoModel) {
            setState(() {
              originalLoanAmount = loanData.loanAmount ?? 0.0;
              loanDate = loanData.mkopoTime ?? '';
            });
            print(
                'Fetched loan amount by ID: $originalLoanAmount, date: $loanDate');
            return;
          }
        }

        // If loan ID approach fails, try using the member number
        final memberNumber = widget.loan['memberNumber'];
        if (memberNumber != null) {
          print('Trying to fetch loan using member number: $memberNumber');
          final loanQuery = toaMkopoModel
              .where('memberNumber', '=', memberNumber)
              .where('mzungukoId', '=', widget.mzungukoId);

          final loanData = await loanQuery.findOne();
          if (loanData != null && loanData is ToaMkopoModel) {
            setState(() {
              originalLoanAmount = loanData.loanAmount ?? 0.0;
              loanDate = loanData.mkopoTime ?? '';
            });
            print(
                'Fetched loan amount by member number: $originalLoanAmount, date: $loanDate');
            return;
          }
        }

        // If all else fails, use the loan amount from the current loan object
        setState(() {
          originalLoanAmount =
              (widget.loan['loanAmount'] as num?)?.toDouble() ?? 0.0;
          loanDate = widget.loan['mkopoTime'] as String? ?? '';
        });
        print(
            'Using loan amount from current loan object: $originalLoanAmount');
      } else {
        // Original approach using userId
        final loanQuery = toaMkopoModel
            .where('userId', '=', userId)
            .where('mzungukoId', '=', widget.mzungukoId);

        final loanData = await loanQuery.findOne();

        if (loanData != null && loanData is ToaMkopoModel) {
          setState(() {
            originalLoanAmount = loanData.loanAmount ?? 0.0;
            loanDate = loanData.mkopoTime ?? '';
          });
          print('Fetched loan amount: $originalLoanAmount, date: $loanDate');
        } else {
          print(
              'No loan data found for userId: $userId, mzungukoId: ${widget.mzungukoId}');

          // Fallback to using the loan amount from the current loan object
          setState(() {
            originalLoanAmount =
                (widget.loan['loanAmount'] as num?)?.toDouble() ?? 0.0;
            loanDate = widget.loan['mkopoTime'] as String? ?? '';
          });
          print(
              'Using loan amount from current loan object: $originalLoanAmount');
        }
      }
    } catch (e) {
      print('Error fetching loan details: $e');

      // Fallback in case of any error
      setState(() {
        originalLoanAmount =
            (widget.loan['loanAmount'] as num?)?.toDouble() ?? 0.0;
        loanDate = widget.loan['mkopoTime'] as String? ?? '';
      });
      print(
          'Using loan amount from current loan object after error: $originalLoanAmount');
    }
  }

  @override
  void initState() {
    super.initState();
    remainingLoan = (widget.loan['unpaidAmount'] as num?)?.toDouble() ?? 0.0;
    paymentAmount = (widget.loan['paidAmount'] as num?)?.toDouble() ?? 0.0;
    _loadPaymentHistory();
    _fetchInterestInfo().then((_) {
      _fetchLoanDetails();
    });

    // _fetchInterestInfo();
    // _fetchLoanDetails();
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
                      l10n.makePayment,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Kiasi Kilichobakia: " + formatCurrency(remainingLoan, Provider.of<CurrencyProvider>(context).currencyCode),
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
                        l10n.payAll,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio<String>(
                        value: 'Lipa Yote',
                        groupValue: selectedOption,
                        activeColor: Colors.blueAccent,
                        onChanged: (value) {
                          setModalState(() {
                            selectedOption = value!;
                            _paymentController.clear();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        l10n.reduceLoan,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio<String>(
                        value: 'Punguza Deni',
                        groupValue: selectedOption,
                        activeColor: const Color.fromARGB(255, 39, 4, 240),
                        onChanged: (value) {
                          setModalState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    if (selectedOption == 'Punguza Deni') ...[
                      SizedBox(height: 12),
                      TextField(
                        controller: _paymentController,
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
                    if (_errorMessage != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _errorMessage!,
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
                              _makePayment();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.payLoan,
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
    final member = widget.allMembers.firstWhere(
      (memberMap) => memberMap['id'] == widget.loan['userId'],
      orElse: () => {'name': 'Unknown User', 'memberNumber': 'N/A'},
    );

    final memberName = member['name'] ?? 'Unknown User';
    final memberNumber = member['memberNumber'] ?? 'N/A';

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanDetailsTitle,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Loan Details Card
              Container(
                width: double.infinity, // Responsive width
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  elevation: 6, // Increased elevation for depth
                  color: Colors.white, // Set to white
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Increased padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mwanachama: <Name>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.member,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.loan['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.memberNumber,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.loan['memberNumber'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.phone,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            widget.loan['phone'] != null
                                ? Text(
                                    "${widget.loan['phone']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.loanTaken,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "TZS " + formatCurrency(originalLoanAmount > 0 ? originalLoanAmount : 0, Provider.of<CurrencyProvider>(context).currencyCode),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Add loan date if available
                        if (loanDate.isNotEmpty) ...[
                          //   SizedBox(height: 10),
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Tarehe ya Mkopo:",
                          //         style: TextStyle(
                          //           color: Colors.grey,
                          //           fontSize: 16,
                          //         ),
                          //       ),
                          //       Text(
                          //         _formatDate(loanDate),
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                        ],
                        if (interestRate.isNotEmpty) ...[
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.loanInterest,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${interestRate}%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.loanToPay,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "TZS " + formatCurrency(paymentAmount + remainingLoan, Provider.of<CurrencyProvider>(context).currencyCode),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.amountPaid,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "TZS " + formatCurrency(paymentAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.loanRemaining,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "TZS " + formatCurrency(remainingLoan, Provider.of<CurrencyProvider>(context).currencyCode),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          color: Colors.green,
                          buttonText: l10n.payLoan,
                          onPressed: () {
                            _showPaymentModal();
                            print('Button Pressed');
                          },
                          type: ButtonType.elevated,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0), // Increased padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.paymentHistory,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12),
                      paymentHistory.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: paymentHistory.length,
                              itemBuilder: (context, index) {
                                final payment = paymentHistory[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 3,
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  color: Colors.white, // Set to white
                                  child: ListTile(
                                    leading: Icon(Icons.payment,
                                        color: Colors.orange),
                                    title: Text(
                                      "Umelipa: " + formatCurrency(payment['amount'] ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Tarehe: ${_formatDate(payment['date'])}",
                                    ),
                                  ),
                                );
                              },
                            )
                          : Text(
                              l10n.noPaymentsMade,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: l10n.doneButton,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RejeshaMkopoPage(
                        meetingId: widget.meetingId,
                        mzungukoId: widget.mzungukoId,
                        // fromDashboard: true,
                        isFromMgaowakikundi: true,
                      ),
                    ),
                  );
                  print('Button Pressed');
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
