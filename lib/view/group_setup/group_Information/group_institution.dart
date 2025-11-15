import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class GroupInstitution extends StatefulWidget {
  final dynamic data_id;
  final bool isEditingMode;

  GroupInstitution({
    super.key,
    required this.data_id,
    this.isEditingMode = false,
  });

  @override
  State<GroupInstitution> createState() => _GroupInstitutionState();
}

class _GroupInstitutionState extends State<GroupInstitution> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _teacherIdentificationController =
      TextEditingController();
  TextEditingController _newOrganizationController = TextEditingController();

  String? _selectedOrganization;
  String? _selectedProject;

  List<DropdownMenuItem<String>> get organizationItems => [
    DropdownMenuItem(value: 'Deloitte', child: Text('Deloitte')),
    DropdownMenuItem(value: 'CARE', child: Text('CARE')),
    DropdownMenuItem(value: 'Helvetas', child: Text('Helvetas')),
    DropdownMenuItem(value: 'ELCT', child: Text('ELCT')),
    DropdownMenuItem(value: 'WWF', child: Text('WWF')),
    DropdownMenuItem(value: 'CODERT', child: Text('CODERT')),
    DropdownMenuItem(value: 'RLabs', child: Text('RLabs')),
    DropdownMenuItem(
        value: 'Restless Development', child: Text('Restless Development')),
    DropdownMenuItem(value: 'Nyingine', child: Text(AppLocalizations.of(context)!.other,)),
    DropdownMenuItem(value: 'Hakuna', child: Text(AppLocalizations.of(context)!.none,)),
  ];

  Map<String, List<DropdownMenuItem<String>>> get organizationProjects => {
    'Helvetas': [
      DropdownMenuItem(value: 'UKIJANI', child: Text('UKIJANI')),
      DropdownMenuItem(value: 'USEMINI', child: Text('USEMINI')),
      DropdownMenuItem(value: 'Nyingine', child: Text(AppLocalizations.of(context)!.other,)),
    ],
    'CARE': [
      DropdownMenuItem(value: 'DMDP', child: Text('DMDP')),
      DropdownMenuItem(value: 'HMHL', child: Text('HMHL')),
      DropdownMenuItem(value: 'Scale Up', child: Text('Scale Up')),
      DropdownMenuItem(value: 'FFBS', child: Text('FFBS')),
      DropdownMenuItem(value: 'Swiofish', child: Text('Swiofish')),
      DropdownMenuItem(value: 'Uchumi', child: Text('Uchumi')),
      DropdownMenuItem(value: 'Wwf-Alliance', child: Text('Wwf-Alliance')),
      DropdownMenuItem(value: 'Umoja ni nguvu', child: Text('Umoja ni nguvu')),
      DropdownMenuItem(value: 'Start small', child: Text('Start small')),
      DropdownMenuItem(
          value: 'Scale up for Livelihood',
          child: Text('Scale up for Livelihood')),
      DropdownMenuItem(
          value: 'Resilience Livelihood', child: Text('Resilience Livelihood')),
      DropdownMenuItem(value: 'HWC', child: Text('HWC')),
      DropdownMenuItem(value: 'HROP', child: Text('HROP')),
      DropdownMenuItem(value: 'Sadifu', child: Text('Sadifu')),
      DropdownMenuItem(value: 'Resolve', child: Text('Resolve')),
      DropdownMenuItem(value: 'Nyingine', child: Text(AppLocalizations.of(context)!.other,)),
    ],
    'Restless Development': [
      DropdownMenuItem(
          value: 'Vijana Tunaweza', child: Text('Vijana Tunaweza')),
      DropdownMenuItem(
          value: 'SET', child: Text('Skills for Employment Tanzania (SET)')),
      DropdownMenuItem(value: 'Nyingine', child: Text('Nyingine')),
    ],
    'WWF': [
      DropdownMenuItem(value: 'Land for Life', child: Text('Land for Life')),
      DropdownMenuItem(value: 'RUMAKI', child: Text('RUMAKI')),
      DropdownMenuItem(value: 'Nyingine', child: Text('Nyingine')),
    ],
  };

  // Get project items based on selected organization
  List<DropdownMenuItem<String>> get projectItems {
    if (_selectedOrganization != null &&
        organizationProjects.containsKey(_selectedOrganization)) {
      return organizationProjects[_selectedOrganization]!;
    }
    return [DropdownMenuItem(value: 'Nyingine', child: Text('Nyingine'))];
  }

  bool isLoading = true;
  GroupInformationModel? groupData;

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  /// Fetch existing data for the given `data_id`
  Future<void> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      print('Fetching data for group ID: ${widget.data_id}');

      final data = await groupInformationModel
          .where('id', '=', widget.data_id)
          .first() as GroupInformationModel?;

      if (data != null) {
        setState(() {
          groupData = data;

          // Set organization if it exists
          if (data.groupInstitution != null &&
              data.groupInstitution!.isNotEmpty) {
            // Check if the organization is in our predefined list
            bool isInList = organizationItems
                .any((item) => item.value == data.groupInstitution);

            if (isInList) {
              _selectedOrganization = data.groupInstitution;
            } else {
              // If not in list, set as "Other" and populate the custom field
              _selectedOrganization = 'Nyingine';
              _newOrganizationController.text = data.groupInstitution!;
            }
          }

          // Set project name if it exists
          if (data.projectName != null) {
            if (organizationProjects.containsKey(_selectedOrganization)) {
              // Check if the project exists in the predefined list
              bool projectInList = organizationProjects[_selectedOrganization]!
                  .any((item) => item.value == data.projectName);

              if (projectInList) {
                _selectedProject = data.projectName;
              } else {
                _selectedProject = 'Nyingine';
                _projectNameController.text = data.projectName!;
              }
            } else {
              _projectNameController.text = data.projectName!;
            }
          }

          // Set teacher identification if it exists
          if (data.teacherIdentification != null) {
            _teacherIdentificationController.text = data.teacherIdentification!;
          }

          isLoading = false;
        });
        print(
            'Data loaded successfully: ${data.groupInstitution}, ${data.projectName}, ${data.teacherIdentification}');
      } else {
        print('No data found for ID: ${widget.data_id}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching saved data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Save or update institution data in SQLite
  // In _saveInstitutionData method, modify the project saving logic
  Future<void> _saveInstitutionData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final groupInformationModel = GroupInformationModel();

        final String organizationToSave = _selectedOrganization == 'Nyingine'
            ? _newOrganizationController.text
            : _selectedOrganization ?? '';

        // Modified project name saving logic
        final String projectToSave;
        if (_selectedOrganization == 'Hakuna') {
          projectToSave = 'Hakuna';
        } else if (_selectedOrganization == 'Helvetas' ||
            _selectedOrganization == 'CARE' ||
            _selectedOrganization == 'Restless Development' ||
            _selectedOrganization == 'WWF') {
          projectToSave = _selectedProject == 'Nyingine'
              ? _projectNameController.text
              : _selectedProject ?? '';
        } else {
          projectToSave = _projectNameController.text;
        }

        final Map<String, dynamic> updates = {
          'groupInstitution': organizationToSave,
          'projectName': projectToSave,
          'teacherIdentification': _teacherIdentificationController.text,
        };

        // Update the record in SQLite
        final existingRecord = await groupInformationModel
            .where('id', '=', widget.data_id)
            .findOne();

        if (existingRecord != null) {
          await groupInformationModel
              .where('id', '=', widget.data_id)
              .update(updates);
        } else {
          await groupInformationModel.create();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GroupOverview(
              data_id: widget.data_id,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kosa limetokea: $e')),
        );
      }
    }
  }

  // In the build method, modify the project input visibility conditions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.groupInstitution,
        subtitle: widget.isEditingMode
            ? AppLocalizations.of(context)!.editInstitution
            : AppLocalizations.of(context)!.groupInstitution,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomDropdown<String>(
                        labelText:
                            AppLocalizations.of(context)!.selectOrganization,
                        hintText:
                            AppLocalizations.of(context)!.selectOrganization,
                        items: organizationItems,
                        value: _selectedOrganization,
                        onChanged: (value) {
                          setState(() {
                            _selectedOrganization = value;
                            _selectedProject = null;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseSelectOrganization;
                          }
                          return null;
                        },
                        aboveText:
                            AppLocalizations.of(context)!.selectOrganization,
                      ),
                      if (_selectedOrganization == 'Nyingine')
                        SizedBox(height: 10),
                      if (_selectedOrganization == 'Nyingine')
                        CustomTextField(
                          aboveText: AppLocalizations.of(context)!
                              .enterOrganizationName,
                          labelText: AppLocalizations.of(context)!
                              .enterOrganizationName,
                          hintText: AppLocalizations.of(context)!
                              .enterOrganizationName,
                          keyboardType: TextInputType.text,
                          controller: _newOrganizationController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .organizationNameRequired;
                            }
                            return null;
                          },
                        ),
                      SizedBox(height: 10),
                      if (_selectedOrganization == 'Helvetas' ||
                          _selectedOrganization == 'CARE' ||
                          _selectedOrganization == 'Restless Development' ||
                          _selectedOrganization == 'WWF')
                        CustomDropdown<String>(
                          labelText:
                              AppLocalizations.of(context)!.selectProject,
                          hintText: AppLocalizations.of(context)!.selectProject,
                          items: projectItems,
                          value: _selectedProject,
                          onChanged: (value) {
                            setState(() {
                              _selectedProject = value;
                            });
                          },
                          validator: (value) {
                            if (_selectedOrganization == 'Helvetas' ||
                                _selectedOrganization == 'CARE' ||
                                _selectedOrganization ==
                                    'Restless Development' ||
                                _selectedOrganization == 'WWF') {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseSelectProject;
                              }
                            }
                            return null;
                          },
                          aboveText:
                              AppLocalizations.of(context)!.selectProject,
                        ),

                      // Update conditions for showing text field
                      if ((_selectedProject == 'Nyingine' &&
                              (_selectedOrganization == 'Helvetas' ||
                                  _selectedOrganization == 'CARE' ||
                                  _selectedOrganization ==
                                      'Restless Development' ||
                                  _selectedOrganization == 'WWF')) ||
                          (_selectedOrganization != 'Helvetas' &&
                              _selectedOrganization != 'CARE' &&
                              _selectedOrganization != 'Restless Development' &&
                              _selectedOrganization != 'WWF' &&
                              _selectedOrganization != 'Nyingine' &&
                              _selectedOrganization != 'Hakuna' &&
                              _selectedOrganization != null))
                        CustomTextField(
                          aboveText:
                              AppLocalizations.of(context)!.enterProjectName,
                          labelText:
                              AppLocalizations.of(context)!.enterProjectName,
                          hintText:
                              AppLocalizations.of(context)!.enterProjectName,
                          keyboardType: TextInputType.text,
                          controller: _projectNameController,
                          obscureText: false,
                          validator: (value) {
                            if ((_selectedProject == 'Nyingine' &&
                                    (_selectedOrganization == 'Helvetas' ||
                                        _selectedOrganization == 'CARE')) ||
                                (_selectedOrganization != 'Helvetas' &&
                                    _selectedOrganization != 'CARE' &&
                                    _selectedOrganization != 'Nyingine' &&
                                    _selectedOrganization != null)) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .projectNameRequired;
                              }
                            }
                            return null;
                          },
                        ),
                      SizedBox(height: 10),
                      CustomTextField(
                        aboveText: AppLocalizations.of(context)!.enterTeacherId,
                        labelText: AppLocalizations.of(context)!.enterTeacherId,
                        hintText: AppLocalizations.of(context)!.enterTeacherId,
                        controller: _teacherIdentificationController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .teacherIdRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: widget.isEditingMode
                            ? AppLocalizations.of(context)!.save
                            : AppLocalizations.of(context)!.continueText,
                        onPressed: _saveInstitutionData,
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
