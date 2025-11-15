import 'package:chomoka/model/group_activities/business/PurchaseModel.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Purchases extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const Purchases({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<Purchases> createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _buyerController = TextEditingController();
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
    _amountController.dispose();
    _buyerController.dispose();
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Create a new PurchaseModel instance
      final purchase = PurchaseModel(
        businessId: widget.businessId.id,
        mzungukoId: widget.mzungukoId,
        purchaseDate: _selectedDate?.toIso8601String(),
        amount: double.tryParse(_amountController.text),
        buyer: _buyerController.text,
        description: _descriptionController.text,
        status: 'active',
      );

      // Save to database
      purchase.create().then((id) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Taarifa za manunuzi zimehifadhiwa')),
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
        title: AppLocalizations.of(context)!.purchasesTitle,
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
                                widget.businessId.businessName ?? AppLocalizations.of(context)!.purchasesBusinessName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.businessId.businessLocation ?? AppLocalizations.of(context)!.purchasesBusinessLocationUnknown,
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
                      AppLocalizations.of(context)!.purchasesInfo,
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
                          labelText: AppLocalizations.of(context)!.purchasesDate,
                          hintText: AppLocalizations.of(context)!.purchasesDateHint,
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.purchasesDateError;
                            }
                            return null;
                          },
                          aboveText: AppLocalizations.of(context)!.purchasesDateAbove,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Amount field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.purchasesAmount,
                      hintText: AppLocalizations.of(context)!.purchasesAmountHint,
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.purchasesAmountError;
                        }
                        if (double.tryParse(value) == null) {
                          return AppLocalizations.of(context)!.purchasesAmountInvalidError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.purchasesAmountAbove,
                    ),
                    const SizedBox(height: 16),

                    // Buyer field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.purchasesBuyer,
                      hintText: AppLocalizations.of(context)!.purchasesBuyerHint,
                      controller: _buyerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.purchasesBuyerError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.purchasesBuyerAbove,
                    ),
                    const SizedBox(height: 16),

                    // Description field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.purchasesDescription,
                      hintText: AppLocalizations.of(context)!.purchasesDescriptionHint,
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      aboveText: AppLocalizations.of(context)!.purchasesDescriptionAbove,
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.purchasesSave,
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
