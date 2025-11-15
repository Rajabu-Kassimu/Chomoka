import 'package:chomoka/view/dashboard/group_activities/group_business/business_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class BusinessInformation extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;

  const BusinessInformation({
    super.key,
    this.groupId,
    this.mzungukoId,
  });

  @override
  State<BusinessInformation> createState() => _BusinessInformationState();
}

class _BusinessInformationState extends State<BusinessInformation> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers for text fields
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessLocationController = TextEditingController();
  final TextEditingController _otherProductTypeController = TextEditingController();
  DateTime _startDate = DateTime.now();
  String _productType = 'Sabuni za matumizi ya nyumbani/nguo';

  // List of product types for dropdown
  final List<String> _productTypes = [
    'Sabuni za matumizi ya nyumbani/nguo',
    'Vyakula',
    'Vifaa vya ujenzi',
    'Bidhaa za kilimo',
    'Nguo na mavazi',
    'Vifaa vya elektroniki',
    'Nyingine'
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessLocationController.dispose();
    _otherProductTypeController.dispose();
    super.dispose();
  }

  // In the _saveBusinessInformation method, update the navigation after successful save:

  Future<void> _saveBusinessInformation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Get the actual product type (either from dropdown or custom input)
        final String actualProductType = _productType == 'Nyingine'
            ? _otherProductTypeController.text
            : _productType;

        // Create a new business information model
        final businessInfo = BusinessInformationModel(
          groupId: widget.groupId,
          mzungukoId: widget.mzungukoId,
          businessName: _businessNameController.text,
          businessLocation: _businessLocationController.text,
          startDate: DateFormat('yyyy-MM-dd').format(_startDate),
          productType: actualProductType,
          otherProductType: _productType == 'Nyingine' ? _otherProductTypeController.text : null,
          status: 'active',
        );

        // Save to database
        await businessInfo.create();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.businessInformationSaved)),
          );

          // Navigate to summary screen instead of just popping
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessSummary(
                groupId: widget.groupId,
                mzungukoId: widget.mzungukoId,
                businessInfo: businessInfo,
              ),
            ),
          );
        }
      } catch (e) {
        // Error handling remains the same
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.businessInformationTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Business Name
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.businessInformationName,
                        hintText: AppLocalizations.of(context)!.businessInformationNameHint,
                        controller: _businessNameController,
                        aboveText: AppLocalizations.of(context)!.businessInformationNameAbove,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.businessInformationNameError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Business Location
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.businessInformationLocation,
                        hintText: AppLocalizations.of(context)!.businessInformationLocationHint,
                        controller: _businessLocationController,
                        aboveText: AppLocalizations.of(context)!.businessInformationLocationAbove,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.businessInformationLocationError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Business Start Date
                      CustomCalendar(
                        labelText: AppLocalizations.of(context)!.businessInformationStartDate,
                        hintText: AppLocalizations.of(context)!.businessInformationStartDateHint,
                        aboveText: AppLocalizations.of(context)!.businessInformationStartDateAbove,
                        onDateSelected: (date) {
                          setState(() {
                            _startDate = date;
                          });
                        },
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Product Type Dropdown
                      Text(
                        AppLocalizations.of(context)!.businessInformationProductTypeAbove,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.businessInformationProductType,
                            border: OutlineInputBorder(),
                          ),
                          value: _productType,
                          items: _productTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _productType = newValue;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.businessInformationProductTypeError;
                            }
                            return null;
                          },
                        ),
                      ),

                      // Show additional field if "Nyingine" is selected
                      if (_productType == 'Nyingine') ...[
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: AppLocalizations.of(context)!.businessInformationOtherProductType,
                          hintText: AppLocalizations.of(context)!.businessInformationOtherProductTypeHint,
                          controller: _otherProductTypeController,
                          aboveText: AppLocalizations.of(context)!.businessInformationOtherProductTypeAbove,
                          validator: (value) {
                            if (_productType == 'Nyingine' && (value == null || value.isEmpty)) {
                              return AppLocalizations.of(context)!.businessInformationOtherProductTypeError;
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 30),

                      // Save Button
                      CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.businessInformationSave,
                        onPressed: _saveBusinessInformation,
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