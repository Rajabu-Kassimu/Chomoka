import 'package:chomoka/model/group_activities/TrainingModel.dart';
import 'package:chomoka/view/dashboard/group_activities/training/training_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class AddTraining extends StatefulWidget {
  var mzungukoId;
  final TrainingModel? trainingToEdit;

  AddTraining({super.key, this.mzungukoId, this.trainingToEdit});

  @override
  State<AddTraining> createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  // Controllers for text fields
  final TextEditingController _trainingTypeController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _membersCountController = TextEditingController();
  final TextEditingController _trainerController = TextEditingController();

  // Date selected
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Check if we're editing an existing training
    if (widget.trainingToEdit != null) {
      _isEditing = true;
      _populateFormWithExistingData();
    }
  }

  // Populate form with existing data for editing
  void _populateFormWithExistingData() {
    final training = widget.trainingToEdit!;

    _trainingTypeController.text = training.trainingType ?? '';
    _organizationController.text = training.organization ?? '';
    _membersCountController.text = training.membersCount?.toString() ?? '0';
    _trainerController.text = training.trainer ?? '';

    if (training.trainingDate != null) {
      _selectedDate = DateTime.parse(training.trainingDate!);
    }
  }

  @override
  void dispose() {
    _trainingTypeController.dispose();
    _organizationController.dispose();
    _membersCountController.dispose();
    _trainerController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final l10n = AppLocalizations.of(context)!;
    // Validate and submit form data
    if (_trainingTypeController.text.isEmpty ||
        _organizationController.text.isEmpty ||
        _membersCountController.text.isEmpty ||
        _trainerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseFillAllFields)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isEditing) {
        // Update existing training
        final training = widget.trainingToEdit!;

        // Create a map of values to update based on BaseModel's update method
        final Map<String, dynamic> updateValues = {
          'trainingType': _trainingTypeController.text,
          'organization': _organizationController.text,
          'trainingDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
          'membersCount': int.tryParse(_membersCountController.text) ?? 0,
          'trainer': _trainerController.text,
        };

        // First set the where condition for the specific training
        training.where('id', '=', training.id);

        // Then call update with the values map
        await training.update(updateValues);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isEditing ? l10n.trainingUpdated : l10n.trainingSaved)),
          );
        }
      } else {
        // Create a new training model
        final training = TrainingModel(
          mzungukoId: widget.mzungukoId,
          trainingType: _trainingTypeController.text,
          organization: _organizationController.text,
          trainingDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
          membersCount: int.tryParse(_membersCountController.text) ?? 0,
          trainer: _trainerController.text,
          status: 'active',
        );

        // Save to database
        await training.create();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isEditing ? l10n.trainingUpdated : l10n.trainingSaved)),
          );
        }
      }

      // Navigate back with result
      if (mounted) {
        Navigator.pop(context, true);
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
        title: _isEditing ? l10n.editTrainingTitle : l10n.addTrainingTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Training Type
                  CustomTextField(
                    labelText: l10n.trainingType,
                    hintText: l10n.enterTrainingType,
                    controller: _trainingTypeController,
                    aboveText: l10n.trainingType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterTrainingType;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Organization
                  CustomTextField(
                    labelText: l10n.organization,
                    hintText: l10n.enterOrganization,
                    controller: _organizationController,
                    aboveText: l10n.organization,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterOrganization;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Date
                  CustomCalendar(
                    labelText: l10n.salesDate,
                    hintText: l10n.salesDate,
                    aboveText: l10n.chooseDate,
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

                  // Number of Members
                  CustomTextField(
                    labelText: l10n.membersCount,
                    hintText: l10n.enterMembersCount,
                    controller: _membersCountController,
                    keyboardType: TextInputType.number,
                    aboveText: l10n.membersCount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterMembersCount;
                      }
                      if (int.tryParse(value) == null) {
                        return l10n.pleaseEnterValidNumber;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Trainer
                  CustomTextField(
                    labelText: l10n.trainer,
                    hintText: l10n.enterTrainer,
                    controller: _trainerController,
                    aboveText: l10n.trainer,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterTrainer;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  CustomButton(
                    color: const Color.fromARGB(255, 42, 39, 241),
                    buttonText: _isEditing ? l10n.saveChanges : l10n.saveTraining,
                    onPressed: _submitForm,
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }
}
