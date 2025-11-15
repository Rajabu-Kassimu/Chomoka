import 'package:chomoka/model/group_activities/RequestPembejeoModel.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/request_pembejeo_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class RequestPembejeo extends StatefulWidget {
  var mzungukoId;
  var userId;
  final RequestPembejeoModel? existingRequest; // Add this parameter for editing
  final bool isEditing; // Flag to indicate if we're editing

  RequestPembejeo({
    super.key,
    this.mzungukoId,
    this.userId,
    this.existingRequest,
    this.isEditing = false, // Default to false for new requests
  });

  @override
  State<RequestPembejeo> createState() => _RequestPembejeoState();
}

class _RequestPembejeoState extends State<RequestPembejeo> {
  // Controllers for text fields
  final TextEditingController _pembejeoTypeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Status dropdown for editing
  String _selectedStatus = 'pending';
  List<String> _statusOptions = ['pending', 'approved', 'rejected'];

  // Date selected
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // If editing, populate the form with existing data
    if (widget.isEditing && widget.existingRequest != null) {
      _pembejeoTypeController.text = widget.existingRequest!.pembejeoType ?? '';
      _amountController.text = widget.existingRequest!.amount ?? '';
      _companyController.text = widget.existingRequest!.company ?? '';
      _priceController.text = widget.existingRequest!.price?.toString() ?? '';

      // Set the selected status
      _selectedStatus = widget.existingRequest!.status ?? 'pending';

      // Set the selected date
      if (widget.existingRequest!.requestDate != null) {
        _selectedDate = DateTime.parse(widget.existingRequest!.requestDate!);
      }
    }
  }

  @override
  void dispose() {
    _pembejeoTypeController.dispose();
    _amountController.dispose();
    _companyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    // Validate and submit form data
    if (_pembejeoTypeController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.requestInputFillAll)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      int? extractedUserId;

      if (widget.userId is int) {
        extractedUserId = widget.userId;
      } else if (widget.userId is Map) {
        // Try to extract id from map with various possible keys
        if (widget.userId['id'] != null) {
          extractedUserId = widget.userId['id'] is int
              ? widget.userId['id']
              : int.tryParse(widget.userId['id'].toString());
        } else if (widget.userId['user_id'] != null) {
          extractedUserId = widget.userId['user_id'] is int
              ? widget.userId['user_id']
              : int.tryParse(widget.userId['user_id'].toString());
        }
      } else if (widget.userId is String) {
        extractedUserId = int.tryParse(widget.userId);
      } else if (widget.userId != null) {
        // Try to parse as string as last resort
        extractedUserId = int.tryParse(widget.userId.toString());
      }

      // If we're editing, we can use the existing request's userId as fallback
      if (extractedUserId == null && widget.isEditing && widget.existingRequest?.userId != null) {
        extractedUserId = widget.existingRequest!.userId;
        print('Using existing request userId: $extractedUserId');
      }

      if (extractedUserId == null) {
        print('Failed to extract userId from: ${widget.userId}');
        throw Exception('Invalid user ID format');
      }

      // Create or update the request model
      RequestPembejeoModel request;

      if (widget.isEditing && widget.existingRequest != null) {
        // Update existing request
        request = widget.existingRequest!;

        // Create a map of values to update
        Map<String, dynamic> updateValues = {
          'pembejeoType': _pembejeoTypeController.text,
          'amount': _amountController.text,
          'company': _companyController.text,
          'price': double.tryParse(_priceController.text),
          'requestDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
          'status': _selectedStatus, // Update status
        };

        // Set the values in the model for use after update
        request.pembejeoType = _pembejeoTypeController.text;
        request.amount = _amountController.text;
        request.company = _companyController.text;
        request.price = double.tryParse(_priceController.text);
        request.requestDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
        request.status = _selectedStatus;

        // First set the where condition to identify the record to update
        request.where('id', '=', request.id);

        // Update in database with the values map
        await request.update(updateValues);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.requestInputUpdateSuccess)),
          );
        }
      } else {
        // Create a new request model
        request = RequestPembejeoModel(
          mzungukoId: widget.mzungukoId is int
              ? widget.mzungukoId
              : int.parse(widget.mzungukoId.toString()),
          userId: extractedUserId,
          pembejeoType: _pembejeoTypeController.text,
          amount: _amountController.text,
          company: _companyController.text,
          price: double.tryParse(_priceController.text),
          requestDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
          status: 'pending', // New requests are always pending
        );

        // Save to database
        await request.create();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.requestInputSuccess)),
          );
        }
      }

      if (mounted) {
        // Navigate to summary screen with the specific request
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RequestPembejeoSummary(
              mzungukoId: widget.mzungukoId is int
                  ? widget.mzungukoId
                  : int.parse(widget.mzungukoId.toString()),
              userId: extractedUserId,
              request: request, // Pass the request object
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.requestInputError(e.toString()))),
        );
        print('Error submitting request: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEditing ? AppLocalizations.of(context)!.requestInputEditTitle : AppLocalizations.of(context)!.requestInputTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Type of Pembejeo
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.requestInputType,
                    hintText: AppLocalizations.of(context)!.requestInputTypeHint,
                    controller: _pembejeoTypeController,
                    aboveText: AppLocalizations.of(context)!.requestInputType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.requestInputTypeError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Company
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.requestInputCompany,
                    hintText: AppLocalizations.of(context)!.requestInputCompanyHint,
                    controller: _companyController,
                    aboveText: AppLocalizations.of(context)!.requestInputCompany,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.requestInputCompanyError;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Amount
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.requestInputAmount,
                    hintText: AppLocalizations.of(context)!.requestInputAmountHint,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    aboveText: AppLocalizations.of(context)!.requestInputAmount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.requestInputAmountError;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Price
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.requestInputPrice,
                    hintText: AppLocalizations.of(context)!.requestInputPriceHint,
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    aboveText: AppLocalizations.of(context)!.requestInputPrice,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.requestInputPriceError;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Date
                  CustomCalendar(
                    labelText: AppLocalizations.of(context)!.requestInputDate,
                    hintText: AppLocalizations.of(context)!.requestInputDateHint,
                    aboveText: AppLocalizations.of(context)!.requestInputDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),

                  // Status dropdown (only show when editing)
                  if (widget.isEditing) ...[
                    const SizedBox(height: 16),
                    CustomDropdown<String>(
                      labelText: AppLocalizations.of(context)!.requestInputStatus,
                      hintText: AppLocalizations.of(context)!.requestInputStatusHint,
                      aboveText: AppLocalizations.of(context)!.requestInputStatus,
                      value: _selectedStatus,
                      items: _statusOptions.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(_getStatusDisplayName(status, context)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedStatus = newValue;
                          });
                        }
                      },
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Submit Button
                  CustomButton(
                    color: const Color.fromARGB(255, 42, 39, 241),
                    buttonText: widget.isEditing ? AppLocalizations.of(context)!.requestInputSaveChanges : AppLocalizations.of(context)!.requestInputSubmit,
                    onPressed: _submitRequest,
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }

  // Helper method to get display name for status
  String _getStatusDisplayName(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppLocalizations.of(context)!.requestSummaryStatusApproved;
      case 'rejected':
        return AppLocalizations.of(context)!.requestSummaryStatusRejected;
      case 'pending':
      default:
        return AppLocalizations.of(context)!.requestSummaryStatusPending;
    }
  }
}
