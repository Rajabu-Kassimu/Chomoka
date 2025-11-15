import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Registration.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class GroupSummary extends StatefulWidget {
  final int? data_id;
  final bool isEditingMode;

  GroupSummary({
    super.key,
    required this.data_id,
    this.isEditingMode = false,
  });

  @override
  _GroupSummaryState createState() => _GroupSummaryState();
}

class _GroupSummaryState extends State<GroupSummary> {
  String _selectedOption = '';
  List<String> _options = [];
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GroupInformationModel? groupData;

  @override
  void initState() {
    super.initState(); 
    if (widget.data_id != null) {
      _fetchSavedData();
    }
  }

  Future<void> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      print('Querying database for group with ID: ${widget.data_id}');

      final data = await groupInformationModel
          .where('id', '=', widget.data_id)
          .first() as GroupInformationModel?;

      if (data != null) {
        setState(() {
          groupData = data;
          if (data.meetingFrequently != null &&
              data.meetingFrequently!.isNotEmpty) {
            _selectedOption = data.meetingFrequently!;
          }
          if (data.meetingAmount != null) {
            _controller.text = data.meetingAmount.toString();
          }
        });
        print(
            'Data loaded successfully: ${data.meetingFrequently}, ${data.meetingAmount}');
      } else {
        print('No data found for ID: ${widget.data_id}');
      }
    } catch (e) {
      print('Error fetching saved data: $e');
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final groupInformationModel = GroupInformationModel();

        final Map<String, dynamic> updates = {
          'meetingFrequently': _selectedOption,
          'meetingAmount': _controller.text,
          'meetingDescription': _getMgaoDescription(),
        };

        await groupInformationModel
            .where('id', '=', widget.data_id)
            .update(updates);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
        );

        if (widget.isEditingMode) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GroupOverview(
                data_id: widget.data_id,
                isEditingMode: true,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GroupRegistration(
                data_id: widget.data_id,
              ),
            ),
          );
        }
      } catch (e) { 
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(AppLocalizations.of(context)!.errorOccurred.replaceAll('{error}', e.toString()))),
        // );
      }
    }
  }

  String _getMgaoDescription() {
    if (_controller.text.isEmpty) return '';

    int? vikao = int.tryParse(_controller.text);
    if (vikao == null || vikao <= 0) return '';

    int totalWeeks;
    if (_selectedOption == AppLocalizations.of(context)!.weekly) {
      totalWeeks = vikao;
    } else if (_selectedOption == AppLocalizations.of(context)!.biWeekly) {
      totalWeeks = vikao * 2;
    } else if (_selectedOption == AppLocalizations.of(context)!.monthly) {
      totalWeeks = vikao * 4;
    } else {
      return '';
    }

    int years = totalWeeks ~/ 52;
    int remainingWeeks = totalWeeks % 52;
    int months = remainingWeeks ~/ 4;
    int weeks = remainingWeeks % 4;

    String yearsText = years > 0 ? AppLocalizations.of(context)!.years(years) : '';
    String monthsText = months > 0 ? AppLocalizations.of(context)!.months(months) : '';
    String weeksText = weeks > 0 ? AppLocalizations.of(context)!.weeks(weeks) : '';

    return AppLocalizations.of(context)!.allocationDescription(
      [yearsText, monthsText, weeksText].where((e) => e.isNotEmpty).join(' na ')
    );
  }

  @override
  Widget build(BuildContext context) {
    _options = [
      AppLocalizations.of(context)!.weekly,
      AppLocalizations.of(context)!.biWeekly,
      AppLocalizations.of(context)!.monthly,
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.groupSummary,
        subtitle: AppLocalizations.of(context)!.sessionSummary,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.meetingFrequency,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: _options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                    );
                  }).toList(),
                ),
                if (_selectedOption.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.pleaseSelectFrequency,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.sessionCount,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.sessionCount,
                    hintText: AppLocalizations.of(context)!.enterSessionCount,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.sessionCountRequired;
                    }
                    if (int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return AppLocalizations.of(context)!
                          .enterValidSessionCount;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                if (_getMgaoDescription().isNotEmpty) ...[
                  Text(
                    AppLocalizations.of(context)!.pleaseNote,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    // Ensure allocationDescription is accessed correctly
                    AppLocalizations.of(context)!.allocationDescription(_getMgaoDescription()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: widget.isEditingMode
                      ? AppLocalizations.of(context)!.update
                      : AppLocalizations.of(context)!.continueText,
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
