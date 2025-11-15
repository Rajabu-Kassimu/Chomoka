import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/model/group_activities/business/SalesModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class Sales extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const Sales({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
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
    _customerController.dispose();
    _revenueController.dispose();
    _sellerController.dispose();
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

  // Then update the _submitForm method
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Create a new SalesModel instance
      final sale = SalesModel(
        businessId: widget.businessId.id,
        mzungukoId: widget.mzungukoId,
        saleDate: _selectedDate?.toIso8601String(),
        customer: _customerController.text,
        revenue: double.tryParse(_revenueController.text),
        seller: _sellerController.text,
        description: _descriptionController.text,
        status: 'active',
      );

      // Save to database
      sale.create().then((id) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Taarifa za mauzo zimehifadhiwa')),
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
        title: AppLocalizations.of(context)!.salesTitle,
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
                                widget.businessId.businessName ?? AppLocalizations.of(context)!.salesBusinessName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.businessId.businessLocation ?? AppLocalizations.of(context)!.salesBusinessLocationUnknown,
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
                      AppLocalizations.of(context)!.salesInfo,
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
                          labelText: AppLocalizations.of(context)!.salesDate,
                          hintText: AppLocalizations.of(context)!.salesDateHint,
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.salesDateError;
                            }
                            return null;
                          },
                          aboveText: AppLocalizations.of(context)!.salesDateAbove,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Customer field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.salesCustomer,
                      hintText: AppLocalizations.of(context)!.salesCustomerHint,
                      controller: _customerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.salesCustomerError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.salesCustomerAbove,
                    ),
                    const SizedBox(height: 16),

                    // Revenue field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.salesRevenue,
                      hintText: AppLocalizations.of(context)!.salesRevenueHint,
                      controller: _revenueController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.salesRevenueError;
                        }
                        if (double.tryParse(value) == null) {
                          return AppLocalizations.of(context)!.salesRevenueInvalidError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.salesRevenueAbove,
                    ),
                    const SizedBox(height: 16),

                    // Seller field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.salesSeller,
                      hintText: AppLocalizations.of(context)!.salesSellerHint,
                      controller: _sellerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.salesSellerError;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!.salesSellerAbove,
                    ),
                    const SizedBox(height: 16),

                    // Description field with CustomTextField
                    CustomTextField(
                      labelText: AppLocalizations.of(context)!.salesDescription,
                      hintText: AppLocalizations.of(context)!.salesDescriptionHint,
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      aboveText: AppLocalizations.of(context)!.salesDescriptionAbove,
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.salesSave,
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
