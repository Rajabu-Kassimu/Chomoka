import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/model/group_activities/business/ExpensesModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Expenses extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const Expenses({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _payerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _reasonController.dispose();
    _amountController.dispose();
    _payerController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  // Add this import at the top of the file

  // Replace the _submitForm method with this implementation
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Create a new ExpensesModel instance
      final expense = ExpensesModel(
        businessId: widget.businessId.id,
        mzungukoId: widget.mzungukoId,
        expenseDate: _selectedDate?.toIso8601String(),
        reason: _reasonController.text,
        amount: double.tryParse(_amountController.text),
        payer: _payerController.text,
        description: _descriptionController.text,
        status: 'active',
      );

      // Save to database
      expense.create().then((id) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Taarifa za matumizi zimehifadhiwa')),
        );

        // Clear form or navigate back
        Navigator.pop(context);
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hitilafu: ${error.toString()}')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.expensesTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Business info header
                    Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.businessId.businessName ?? AppLocalizations.of(context)!.expensesBusinessName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.businessId.businessLocation ?? AppLocalizations.of(context)!.expensesBusinessLocationUnknown,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Text(
                      AppLocalizations.of(context)!.expensesInfo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Date field with CustomTextField
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          labelText: AppLocalizations.of(context)!.expensesDate,
                          hintText: AppLocalizations.of(context)!.expensesDateHint,
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.expensesDateError;
                            }
                            return null;
                          },
                          aboveText: AppLocalizations.of(context)!.expensesDateAbove,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Reason field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.expensesReason,
                      hintText: AppLocalizations.of(context)!.expensesReasonHint,
                      controller: _reasonController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.expensesReasonError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.expensesReasonAbove,
                    ),
                    const SizedBox(height: 16),

                    // Amount field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.expensesAmount,
                      hintText: AppLocalizations.of(context)!.expensesAmountHint,
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.expensesAmountError;
                        }
                        if (double.tryParse(value) == null) {
                          return AppLocalizations.of(context)!.expensesAmountInvalidError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.expensesAmountAbove,
                    ),
                    const SizedBox(height: 16),

                    // Payer field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.expensesPayer,
                      hintText: AppLocalizations.of(context)!.expensesPayerHint,
                      controller: _payerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.expensesPayerError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.expensesPayerAbove,
                    ),
                    const SizedBox(height: 16),

                    // Description field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.expensesDescription,
                      hintText: AppLocalizations.of(context)!.expensesDescriptionHint,
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      aboveText: AppLocalizations.of(context)!.expensesDescriptionAbove,
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.expensesSave,
                        onPressed: _submitForm,
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
