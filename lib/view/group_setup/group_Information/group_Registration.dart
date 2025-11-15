import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/view/group_setup/group_Information/group_institution.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';

import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class GroupRegistration extends StatefulWidget {
  final dynamic data_id;
  final bool isEditingMode;

  GroupRegistration({
    super.key,
    required this.data_id,
    this.isEditingMode = false,
  });

  @override
  State<GroupRegistration> createState() => _GroupRegistrationState();
}

class _GroupRegistrationState extends State<GroupRegistration> {
  TextEditingController _controller = TextEditingController();
  String? _selectedItem;
  List<DropdownMenuItem<String>> dropdownItems = [];
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  GroupInformationModel? groupData;

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

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
          if (data.registrationStatus != null &&
              data.registrationStatus!.isNotEmpty) {
            _selectedItem = data.registrationStatus;
          }
          if (data.registeredNumber != null) {
            _controller.text = data.registeredNumber!;
          }
          isLoading = false;
        });
        print(
            'Data loaded successfully: ${data.registrationStatus}, ${data.registeredNumber}');
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

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final groupInformationModel = GroupInformationModel();

        final Map<String, dynamic> updates = {
          'registrationStatus': _selectedItem,
          'registeredNumber':
              _selectedItem == 'kimesajiliwa' ? _controller.text : null,
        };

        await groupInformationModel
            .where('id', '=', widget.data_id)
            .update(updates);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
        );

        if (widget.isEditingMode) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupOverview(
                data_id: widget.data_id,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupInstitution(
                data_id: widget.data_id,
              ),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kosa limetokea: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dropdownItems = [
      DropdownMenuItem(
        value: 'kimesajiliwa',
        child: Text(AppLocalizations.of(context)!.registered),
      ),
      DropdownMenuItem(
        value: 'hakijasajiliwa',
        child: Text(AppLocalizations.of(context)!.notRegistered),
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.groupRegistration,
        subtitle: widget.isEditingMode
            ? AppLocalizations.of(context)!.editRegistration
            : AppLocalizations.of(context)!.groupRegistration,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomDropdown<String>(
                      labelText:
                          AppLocalizations.of(context)!.registrationStatus,
                      hintText: AppLocalizations.of(context)!
                          .selectRegistrationStatus,
                      items: dropdownItems,
                      value: _selectedItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(context)!
                              .pleaseSelectRegistrationStatus;
                        }
                        return null;
                      },
                      aboveText: AppLocalizations.of(context)!
                          .selectRegistrationStatus,
                    ),
                    SizedBox(height: 10),
                    if (_selectedItem == 'kimesajiliwa')
                      CustomTextField(
                        aboveText:
                            AppLocalizations.of(context)!.registrationNumber,
                        labelText:
                            AppLocalizations.of(context)!.registrationNumber,
                        hintText: AppLocalizations.of(context)!
                            .enterRegistrationNumber,
                        controller: _controller,
                        obscureText: false,
                        validator: (value) {
                          if (_selectedItem == 'kimesajiliwa' &&
                              (value == null || value.isEmpty)) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterRegistrationNumber;
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 20),
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: widget.isEditingMode
                          ? AppLocalizations.of(context)!.correct
                          : AppLocalizations.of(context)!.continueText,
                      onPressed: _saveData,
                      type: ButtonType.elevated,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
