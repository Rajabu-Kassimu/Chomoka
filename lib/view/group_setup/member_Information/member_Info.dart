import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/member_Information/member_identity.dart';
import 'package:chomoka/view/group_setup/member_Information/member_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MemberInfo extends StatefulWidget {
  final int? groupId;
  final int? userId;
  final int? mzungukoId;
  final bool isUpdateMode;
  final bool fromDashboard;

  MemberInfo({
    Key? key,
    this.groupId,
    this.userId,
    this.mzungukoId,
    this.isUpdateMode = false,
    this.fromDashboard = false,
  }) : super(key: key);

  @override
  State<MemberInfo> createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
  final TextEditingController memberNumber = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  String? selectedYear;
  String? selectedMonth;
  String? selectedDay;
  String _selectedOption = '';
  List<String> get _options => [
    AppLocalizations.of(context)!.male,
    AppLocalizations.of(context)!.female,
  ];
  final _formKey = GlobalKey<FormState>();
  String? _validationError;

  final List<String> years = List.generate(
    100, // Show last 100 years
    (index) => (DateTime.now().year - index).toString(),
  );
  final List<String> months =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> days = [];

  void _updateDays() {
    if (selectedYear != null && selectedMonth != null) {
      final year = int.parse(selectedYear!);
      final month = int.parse(selectedMonth!);
      final int daysInMonth = DateTime(year, month + 1, 0).day;

      setState(() {
        days = List.generate(
            daysInMonth, (index) => (index + 1).toString().padLeft(2, '0'));
      });
    } else {
      setState(() {
        days = [];
      });
    }
  }

  Future<void> _loadMemberData() async {
    try {
      final groupMembersModel = GroupMembersModel();
      final result =
          await groupMembersModel.where('id', '=', widget.userId).findOne();

      if (result != null && result is GroupMembersModel) {
        setState(() {
          memberNumber.text = result.memberNumber ?? '';
          fullName.text = result.name ?? '';
          if (result.dob != null) {
            final DateTime dob = DateTime.parse(result.dob!);
            selectedYear = dob.year.toString();
            selectedMonth = dob.month.toString().padLeft(2, '0');
            selectedDay = dob.day.toString().padLeft(2, '0');
          }
          _selectedOption = result.gender ?? '';
        });
      }
    } catch (e) {
      print('Error loading member data: $e');
    }
  }

  Future<bool> _isMemberNumberUnique(String number) async {
    final groupMembersModel = GroupMembersModel();

    var existingMemberQuery =
        groupMembersModel.where('memberNumber', '=', number);

    if (widget.isUpdateMode && widget.userId != null) {
      existingMemberQuery =
          existingMemberQuery.where('id', '!=', widget.userId);
    }
    final existingMember = await existingMemberQuery.findOne();
    return existingMember == null;
  }

  Future<void> _saveMemberData() async {
    if (_formKey.currentState!.validate()) {
      final memberNumberValue = memberNumber.text.trim();

      if (selectedYear == null ||
          selectedMonth == null ||
          selectedDay == null) {
        setState(() {
          _validationError = AppLocalizations.of(context)!.dobRequired;
        });
        return;
      }

      final isUnique = await _isMemberNumberUnique(memberNumberValue);
      if (!isUnique) {
        setState(() {
          _validationError = AppLocalizations.of(context)!.uniqueMemberNumber;
        });
        return;
      }

      try {
        final mzungukoModel = MzungukoModel();
        final mzungukoResult =
            await mzungukoModel.where('status', '!=', 'completed').findOne();
        final int? mzungukoId =
            (mzungukoResult != null && mzungukoResult is MzungukoModel)
                ? mzungukoResult.id
                : null;

        if (mzungukoId == null) {
          setState(() {
            _validationError = AppLocalizations.of(context)!.noActiveCycle;
          });
          return;
        }

        final String dob =
            "$selectedYear-${selectedMonth?.padLeft(2, '0')}-${selectedDay?.padLeft(2, '0')}";

        if (widget.isUpdateMode) {
          final groupMember = GroupMembersModel();
          await groupMember.where('id', '=', widget.userId).update({
            'groupId': widget.groupId,
            'memberNumber': memberNumberValue,
            'name': fullName.text,
            'gender': _selectedOption,
            'dob': dob,
            'mzungukoId': mzungukoId,
          });
          _navigateToSummaryPage(mzungukoId: mzungukoId);
        } else {
          final member = GroupMembersModel(
            groupId: widget.groupId,
            memberNumber: memberNumberValue,
            name: fullName.text,
            gender: _selectedOption,
            dob: dob,
            mzungukoId: mzungukoId,
          );
          final int userId = await member.create();
          _navigateToIdentityPage(userId,
              mzungukoId: mzungukoId); // Pass mzungukoId
        }
      } catch (e) {
        print('Error saving member data: $e');
        setState(() {
          // _validationError = AppLocalizations.of(context)!.errorSavingData.replaceAll('{error}', e.toString());
        });
      }
    }
  }

  void _navigateToSummaryPage({required int mzungukoId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberSummaryPage(
          userId: widget.userId,
          groupId: widget.groupId,
          mzungukoId: mzungukoId,
        ),
      ),
    );
  }

  void _navigateToIdentityPage(int userId, {required int mzungukoId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => memberIdentity(
          userId: userId,
          groupId: widget.groupId,
          mzungukoId: mzungukoId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdateMode) {
      _loadMemberData().then((_) {
        // _loadActiveMzungukoId();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.memberInfo,
        subtitle: widget.isUpdateMode
            ? AppLocalizations.of(context)!.editGroupInformation
            : AppLocalizations.of(context)!.memberInfo,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.memberNumber,
                  labelText: AppLocalizations.of(context)!.memberNumber,
                  hintText: AppLocalizations.of(context)!.enterMemberNumber,
                  keyboardType: TextInputType.number,
                  controller: memberNumber,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.memberNumberRequired;
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return AppLocalizations.of(context)!
                          .memberNumberDigitsOnly;
                    }
                    return null;
                  },
                ),
                if (_validationError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, top: 5),
                    child: Text(
                      _validationError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 10),
                CustomTextField(
                  aboveText: AppLocalizations.of(context)!.fullName,
                  labelText: AppLocalizations.of(context)!.fullName,
                  hintText: AppLocalizations.of(context)!.enterFullName,
                  controller: fullName,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fullNameRequired;
                    } else if (value.length < 3) {
                      return AppLocalizations.of(context)!.fullNameMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomRadioGroup<String>(
                  labelText: AppLocalizations.of(context)!.gender,
                  options: _options,
                  value: _selectedOption,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.dob),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.selectYear),
                          value: selectedYear,
                          items: years
                              .map((year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                              _updateDays();
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.dobRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.selectMonth),
                          value: selectedMonth,
                          items: months
                              .map((month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value;
                              _updateDays();
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.dobRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.selectDay),
                          value: selectedDay,
                          items: days
                              .map((day) => DropdownMenuItem(
                                    value: day,
                                    child: Text(day),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDay = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.dobRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  color: const Color.fromARGB(255, 4, 34, 207),
                  buttonText: widget.isUpdateMode
                      ? AppLocalizations.of(context)!.update
                      : AppLocalizations.of(context)!.continueText,
                  onPressed: _saveMemberData,
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
