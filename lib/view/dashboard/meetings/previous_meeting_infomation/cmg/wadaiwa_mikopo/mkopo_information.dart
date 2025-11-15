import 'package:chomoka/model/MkopoVikaoVilivyopitaModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/wadaiwa_mikopo/LoanSummaryPage.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class WadaiwaMkopoInfoPage extends StatefulWidget {
  final int userId;
  var mzungukoId;
  WadaiwaMkopoInfoPage({super.key, required this.userId, this.mzungukoId});

  @override
  State<WadaiwaMkopoInfoPage> createState() => _WadaiwaMkopoInfoPageState();
}

class _WadaiwaMkopoInfoPageState extends State<WadaiwaMkopoInfoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _outstandingAmountController =
      TextEditingController();
  final TextEditingController _sessionController = TextEditingController();
  final TextEditingController _loanTimeController = TextEditingController();
  final TextEditingController _otherReasonController = TextEditingController();

  final List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(value: 'Kilimo', child: Text('Kilimo')),
    DropdownMenuItem(
        value: 'Maboresho ya Nyumba', child: Text('Maboresho ya Nyumba')),
    DropdownMenuItem(value: 'Elimu', child: Text('Elimu')),
    DropdownMenuItem(value: 'Biashara', child: Text('Biashara')),
    DropdownMenuItem(value: 'Nyingine', child: Text('Nyingine')),
  ];

  String _selectedReason = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSavedData();

    // Add listeners to automatically calculate outstanding amount
    _loanAmountController.addListener(_calculateOutstandingAmount);
    _paidAmountController.addListener(_calculateOutstandingAmount);
  }

  @override
  void dispose() {
    // Remove listeners when disposing
    _loanAmountController.removeListener(_calculateOutstandingAmount);
    _paidAmountController.removeListener(_calculateOutstandingAmount);
    super.dispose();
  }

  double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // Format number to remove decimal places
  String _formatNumberWithoutDecimals(double value) {
    return value.toInt().toString();
  }

  // Method to calculate outstanding amount automatically
  void _calculateOutstandingAmount() {
    if (_loanAmountController.text.isNotEmpty &&
        _paidAmountController.text.isNotEmpty) {
      try {
        double loanAmount = double.parse(_loanAmountController.text);
        double paidAmount = double.parse(_paidAmountController.text);

        // Ensure paid amount doesn't exceed loan amount
        if (paidAmount > loanAmount) {
          paidAmount = loanAmount;
          _paidAmountController.text = _formatNumberWithoutDecimals(loanAmount);
        }

        double outstandingAmount = loanAmount - paidAmount;

        // Only update if the calculation resulted in a valid number
        if (!outstandingAmount.isNaN && !outstandingAmount.isInfinite) {
          setState(() {
            _outstandingAmountController.text =
                _formatNumberWithoutDecimals(outstandingAmount);
          });
        }
      } catch (e) {
        print('Error calculating outstanding amount: $e');
      }
    }
  }

  Future<void> _fetchSavedData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch MkopoVikaoVilivyopitaModel data
      final mkopoModel = MkopoVikaoVilivyopitaModel();
      final savedMkopoData =
          await mkopoModel.where('user_id', '=', widget.userId).findOne();

      if (savedMkopoData != null) {
        final data = savedMkopoData.toMap();

        setState(() {
          _selectedReason = data['sababu_ya_mkopo'] ?? '';
          _loanAmountController.text =
              _formatNumberWithoutDecimals(_parseDouble(data['loan_amount']));
          _paidAmountController.text =
              _formatNumberWithoutDecimals(_parseDouble(data['paid_amount']));
          _outstandingAmountController.text = _formatNumberWithoutDecimals(
              _parseDouble(data['outstandingAmount']));
          _sessionController.text = data['kikao_alichokopa'] ?? '';
          _loanTimeController.text = data['loan_time'] ?? '';
        });
      } else {
        print(
            'No data found for MkopoVikaoVilivyopitaModel user_id: ${widget.userId}');
      }

      final rejeshaMkopoModel = RejeshaMkopoModel();
      final savedRejeshaData = await rejeshaMkopoModel
          .where('user_id', '=', widget.userId)
          .findOne();

      if (savedRejeshaData != null) {
        final rejeshaData = savedRejeshaData.toMap();

        print("Fetched RejeshaMkopoModel data:");
        print("userId: ${rejeshaData['user_id']}");
        print("mzungukoId: ${rejeshaData['mzunguko_id']}");
        print("meetingId: ${rejeshaData['meeting_id']}");
        print("paidAmount: ${rejeshaData['paid_amount']}");
        print("unpaidAmount: ${rejeshaData['unpaid_amount']}");
        print("paymentTime: ${rejeshaData['payment_time']}");

        String payments = rejeshaData['payments'] ??
            'Default Payment Reason'; // You can set a default if it's null
        print("payments: $payments");
      } else {
        print('No data found for RejeshaMkopoModel user_id: ${widget.userId}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final mkopoModel = MkopoVikaoVilivyopitaModel()
        ..userId = widget.userId.toString()
        ..sababuYaMkopo = _selectedReason == 'Nyingine'
            ? _otherReasonController.text
            : _selectedReason
        ..loanAmount = _loanAmountController.text
        ..paidAmount = _paidAmountController.text
        ..outstandingAmount = _outstandingAmountController.text
        ..kikaoAlichokopa = _sessionController.text
        ..loanTime = _loanTimeController.text;

      try {
        final dataToSave = mkopoModel.toMap();
        dataToSave.remove('id');

        final existingRecord = await mkopoModel
            .where('user_id', '=', widget.userId.toString())
            .findOne();

        if (existingRecord != null) {
          await mkopoModel
              .where('user_id', '=', widget.userId.toString())
              .update(dataToSave);
        } else {
          await mkopoModel.create();
        }

        final sanitizedPayments =
            _selectedReason == 'Nyingine' ? _otherReasonController.text : null;

        final paymentTime = DateTime.now().millisecondsSinceEpoch.toDouble();

        final rejeshaMkopoModel = RejeshaMkopoModel(
          userId: widget.userId,
          mzungukoId: widget.mzungukoId,
          meetingId: 1,
          paidAmount: double.tryParse(_paidAmountController.text) ?? 0.0,
          unpaidAmount:
              double.tryParse(_outstandingAmountController.text) ?? 0.0,
          paymentTime: paymentTime,
          payments: sanitizedPayments,
        );

        print("RejeshaMkopoModel data to save:");
        print(rejeshaMkopoModel.toMap());

        final existingRejeshaMkopoRecord = await rejeshaMkopoModel
            .where('user_id', '=', widget.userId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (existingRejeshaMkopoRecord != null) {
          final dataToUpdate = rejeshaMkopoModel.toMap();
          dataToUpdate.remove('id');

          await rejeshaMkopoModel
              .where('user_id', '=', widget.userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .update(dataToUpdate);
          print('RejeshaMkopoModel record updated.');
        } else {
          print('RejeshaMkopoModel does not exist, creating new record.');
          await rejeshaMkopoModel.create();
        }

        final toaMkopoModel = ToaMkopoModel(
          userId: widget.userId,
          mzungukoId: widget.mzungukoId,
          meetingId: 1,
          sababuKukopa: _selectedReason == 'Nyingine'
              ? _otherReasonController.text
              : _selectedReason,
          loanAmount: double.tryParse(_loanAmountController.text),
          repayAmount: double.tryParse(_loanAmountController.text) ?? 0.0,
          mkopoTime: _loanTimeController.text,
        );

        print("ToaMkopoModel data to save:");
        print(toaMkopoModel.toMap());

        final existingToaMkopoRecord = await toaMkopoModel
            .where('userId', '=', widget.userId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (existingToaMkopoRecord != null) {
          final dataToUpdate = toaMkopoModel.toMap();
          dataToUpdate.remove('id'); // Exclude 'id' from update

          await toaMkopoModel
              .where('userId', '=', widget.userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .update(dataToUpdate);
          print('ToaMkopoModel record updated.');
        } else {
          await toaMkopoModel.create();
          print('ToaMkopoModel record created.');
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WadaiwaMikopoSummaryPage(
              userId: widget.userId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } catch (e) {
        print('Error saving data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanInformation,
        subtitle: l10n.memberLoanInfo,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      CustomDropdown<String>(
                        labelText: l10n.selectReason,
                        hintText: l10n.selectReason,
                        items: dropdownItems,
                        value: dropdownItems
                                .any((item) => item.value == _selectedReason)
                            ? _selectedReason
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _selectedReason = value ?? '';
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseSelectReason;
                          }
                          return null;
                        },
                        aboveText: l10n.reasonForLoan,
                      ),
                      SizedBox(height: 5),
                      if (_selectedReason == 'Nyingine')
                        CustomTextField(
                          aboveText: l10n.enterOtherReason,
                          labelText: l10n.otherReason,
                          hintText: l10n.enterOtherReason,
                          controller: _otherReasonController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return l10n.pleaseEnterOtherReason;
                            }
                            return null;
                          },
                          obscureText: false,
                        ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: l10n.loanAmount,
                        labelText: l10n.loanAmount,
                        hintText: l10n.enterLoanAmount,
                        keyboardType: TextInputType.number,
                        controller: _loanAmountController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterLoanAmount;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: l10n.amountPaid,
                        labelText: l10n.amountPaid,
                        hintText: l10n.enterAmountPaid,
                        keyboardType: TextInputType.number,
                        controller: _paidAmountController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterAmountPaid;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          double? paidAmount = double.tryParse(value);
                          double? loanAmount = double.tryParse(_loanAmountController.text);
                          if (paidAmount != null && loanAmount != null && paidAmount > loanAmount) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: l10n.outstandingBalance,
                        labelText: l10n.outstandingBalance,
                        hintText: l10n.calculatedAutomatically,
                        keyboardType: TextInputType.number,
                        controller: _outstandingAmountController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterOutstandingAmount;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          double? outstandingAmount = double.tryParse(value);
                          if (outstandingAmount != null && outstandingAmount < 0) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: l10n.loanMeeting,
                        labelText: l10n.loanMeeting,
                        hintText: l10n.enterLoanMeeting,
                        keyboardType: TextInputType.number,
                        controller: _sessionController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterLoanMeeting;
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: l10n.loanDuration,
                        labelText: l10n.loanDuration,
                        hintText: l10n.enterLoanDuration,
                        keyboardType: TextInputType.number,
                        controller: _loanTimeController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterLoanDuration;
                          }
                          if (double.tryParse(value) == null) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.continue_,
                        onPressed: _saveData,
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
