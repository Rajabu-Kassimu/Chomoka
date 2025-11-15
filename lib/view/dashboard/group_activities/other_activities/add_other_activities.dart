import 'package:chomoka/model/group_activities/ShughuliMbalimbaliModel.dart';
import 'package:chomoka/view/dashboard/group_activities/other_activities/other_activities_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class AddOtherActivities extends StatefulWidget {
  var mzungukoId;
  final ShughuliMbalimbaliModel? activityToEdit;

  AddOtherActivities({super.key, this.mzungukoId, this.activityToEdit});

  @override
  State<AddOtherActivities> createState() => _AddOtherActivitiesState();
}

class _AddOtherActivitiesState extends State<AddOtherActivities> {
  // Controllers for text fields
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _beneficiariesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Date selected
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Check if we're editing an existing activity
    if (widget.activityToEdit != null) {
      _isEditing = true;
      _populateFormWithExistingData();
    }
  }

  // Populate form with existing data for editing
  void _populateFormWithExistingData() {
    final activity = widget.activityToEdit!;

    _activityController.text = activity.activityName ?? '';
    _beneficiariesController.text = activity.beneficiariesCount?.toString() ?? '0';
    _locationController.text = activity.location ?? '';

    if (activity.activityDate != null) {
      _selectedDate = DateTime.parse(activity.activityDate!);
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    _beneficiariesController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final l10n = AppLocalizations.of(context)!;
    // Validate and submit form data
    if (_activityController.text.isEmpty ||
        _beneficiariesController.text.isEmpty ||
        _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseFillAllActivityFields)),
      );
      return;
    }

    // Validate mzungukoId
    if (widget.mzungukoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hitilafu: Mzunguko ID haijulikani')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isEditing) {
        // Update existing activity
        final activity = widget.activityToEdit!;

        // Create a map of values to update
        final Map<String, dynamic> updateValues = {
          'activityName': _activityController.text,
          'activityDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
          'beneficiariesCount': int.tryParse(_beneficiariesController.text) ?? 0,
          'location': _locationController.text,
          'mzungukoId': widget.mzungukoId,
          'status': 'active',
        };

        // Set where condition for the specific activity
        activity.where('id', '=', activity.id);

        // Update in database
        await activity.update(updateValues);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isEditing ? l10n.activityUpdated : l10n.activitySaved)),
          );
        }
      } else {
        // Create a new activity model
        final activity = ShughuliMbalimbaliModel(
          mzungukoId: widget.mzungukoId is int ? widget.mzungukoId : int.parse(widget.mzungukoId.toString()),
          activityName: _activityController.text,
          activityDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
          beneficiariesCount: int.tryParse(_beneficiariesController.text) ?? 0,
          location: _locationController.text,
          status: 'active',
        );

        // Save to database
        await activity.create();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Shughuli imehifadhiwa kikamilifu')),
          );
        }
      }

      // Navigate to summary screen instead of just popping back
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtherActivitiesSummary(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorOccurred(e.toString()))),
        );
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: _isEditing ? l10n.editOtherActivityTitle : l10n.addOtherActivityTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Date
                  CustomCalendar(
                    labelText: l10n.activityDate,
                    hintText: l10n.chooseActivityDate,
                    aboveText: l10n.activityDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Activity
                  CustomTextField(
                    labelText: l10n.activityName,
                    hintText: l10n.enterActivityName,
                    controller: _activityController,
                    aboveText: l10n.activityName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterActivityName;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Number of Beneficiaries
                  CustomTextField(
                    labelText: l10n.beneficiariesCount,
                    hintText: l10n.enterBeneficiariesCount,
                    controller: _beneficiariesController,
                    keyboardType: TextInputType.number,
                    aboveText: l10n.beneficiariesCount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterBeneficiariesCount;
                      }
                      if (int.tryParse(value) == null) {
                        return l10n.pleaseEnterValidNumber;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Location
                  CustomTextField(
                    labelText: l10n.location,
                    hintText: l10n.enterLocation,
                    controller: _locationController,
                    aboveText: l10n.location,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterLocation;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  CustomButton(
                    color: const Color.fromARGB(255, 42, 39, 241),
                    buttonText: _isEditing ? l10n.saveActivityChanges : l10n.saveActivity,
                    onPressed: _submitForm,
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }
}