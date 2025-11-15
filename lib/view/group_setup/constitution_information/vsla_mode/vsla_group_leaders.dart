import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupLeadersModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/faini.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaGroupLeaders extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;
  final bool isUpdateMode;

  const VslaGroupLeaders({
    super.key,
    this.groupId,
    this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<VslaGroupLeaders> createState() => _VslaGroupLeadersState();
}

class _VslaGroupLeadersState extends State<VslaGroupLeaders> {
  final GroupMembersModel _groupMembersModel = GroupMembersModel();
  List<String> allUsers = [];

  // Use fixed keys for positions
  static const List<String> positionKeys = [
    'chairperson',
    'secretary',
    'treasurer',
    'counter1',
    'counter2',
  ];

  late Map<String, String?> selectedPositions;
  late Map<String, String?> errors;

  // Map fixed keys to localized labels
  String getPositionLabel(String key, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'chairperson':
        return l10n.chairperson;
      case 'secretary':
        return l10n.secretary;
      case 'treasurer':
        return l10n.treasurer;
      case 'counter1':
        return l10n.counter1;
      case 'counter2':
        return l10n.counter2;
      default:
        return key;
    }
  }

  Map<String, String?> getInitialPositions() {
    return {
      for (var key in positionKeys) key: null,
    };
  }
  Map<String, String?> getInitialErrors() {
    return {
      for (var key in positionKeys) key: null,
    };
  }

  @override
  void initState() {
    super.initState();
    selectedPositions = getInitialPositions();
    errors = getInitialErrors();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeData();
    });
  }

  Future<void> initializeData() async {
    await fetchGroupMembers();
    await fetchExistingLeaders();
  }

  Future<void> fetchGroupMembers() async {
    try {
      await BaseModel.initAppDatabase();

      List<BaseModel> baseModels = await GroupMembersModel().find();
      List<GroupMembersModel> users = baseModels.map((model) {
        return GroupMembersModel().fromMap(model.toMap());
      }).toList();

      setState(() {
        allUsers = users.map((user) => user.name ?? 'Unknown').toList();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> fetchExistingLeaders() async {
    if (widget.groupId == null) return;
    
    try {
      List<BaseModel> leaders = await GroupLeaderModel()
          .where('group_id', '=', widget.groupId)
          .find();

      // Map of database position values to UI position keys
      final positionMap = {
        'mwenyekiti': 'chairperson',
        'katibu': 'secretary',
        'mweka hazina': 'treasurer',
        'mhesabu pesa namba 1': 'counter1',
        'mhesabu pesa namba 2': 'counter2',
      };

      for (var leader in leaders) {
        final leaderModel = GroupLeaderModel().fromMap(leader.toMap());
        final user = await GroupMembersModel()
            .where('id', '=', leaderModel.user_id)
            .first() as GroupMembersModel?;

        if (user != null && leaderModel.position != null) {
          final position = leaderModel.position!.toLowerCase().trim();
          final uiPosition = positionMap[position] ?? position;
          print('Loading position: $position -> $uiPosition for user: ${user.name}');

          setState(() {
            selectedPositions[uiPosition] = user.name;
          });
        }
      }
    } catch (e) {
      print('Error fetching existing leaders: $e');
    }
  }

  Future<void> saveVslaGroupLeaders() async {
    if (widget.groupId == null || widget.mzungukoId == null) {
      return;
    }

    try {
      await BaseModel.initAppDatabase();

      // Map of UI position keys to database position values
      final positionMap = {
        'chairperson': 'mwenyekiti',
        'secretary': 'katibu',
        'treasurer': 'mweka hazina',
        'counter1': 'mhesabu pesa namba 1',
        'counter2': 'mhesabu pesa namba 2',
      };

      for (var entry in selectedPositions.entries) {
        final positionKey = entry.key;
        final userName = entry.value;

        if (userName == null) continue;

        final user = await GroupMembersModel()
            .where('name', '=', userName)
            .first() as GroupMembersModel?;

        if (user != null) {
          final databasePosition = positionMap[positionKey] ?? positionKey;
          print('Saving position: $positionKey -> $databasePosition for user: $userName');

          final existingLeader = await GroupLeaderModel()
              .where('group_id', '=', widget.groupId)
              .where('position', '=', databasePosition)
              .first() as GroupLeaderModel?;

          if (existingLeader != null) {
            await GroupLeaderModel()
                .where('id', '=', existingLeader.id)
                .update({
              'user_id': user.id,
              'position': databasePosition,
              'mzungukoId': widget.mzungukoId,
            });
          } else {
            GroupLeaderModel leader = GroupLeaderModel(
              group_id: widget.groupId,
              user_id: user.id,
              position: databasePosition,
              mzungukoId: widget.mzungukoId,
            );

            await leader.create();
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
      );
      await fetchExistingLeaders();

      if (widget.isUpdateMode) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConstitutionOverview(
                    groupId: widget.groupId!,
                    mzungukoId: widget.mzungukoId!,
                  )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FainiPage(
                    groupId: widget.groupId!,
                    mzungukoId: widget.mzungukoId!,
                  )),
        );
      }
    } catch (e) {
      print('Error saving group leaders: $e');
    }
  }

  List<DropdownMenuItem<String>> getDropdownItems(String positionKey) {
    Set<String> availableUsers = allUsers.where((user) {
      return !selectedPositions.containsValue(user) ||
          selectedPositions[positionKey] == user;
    }).toSet();

    return availableUsers
        .map((user) => DropdownMenuItem(
              value: user,
              child: Text(user),
            ))
        .toList();
  }

  void validateInputs() {
    setState(() {
      bool hasErrors = false;
      selectedPositions.forEach((positionKey, value) {
        final error = value == null
            ? AppLocalizations.of(context)!.positionRequired(getPositionLabel(positionKey, context))
            : null;
        errors[positionKey] = error;
        if (error != null) hasErrors = true;
      });
      
      if (hasErrors) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.selectAllLeadersError),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.groupId);
    if (!((selectedPositions != null) && (errors != null))) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.groupLeadersSubtitle,
        showBackArrow: true,
      ),
      body: allUsers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ...positionKeys.map((positionKey) {
                      final label = getPositionLabel(positionKey, context);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown<String>(
                              labelText: label,
                              hintText: AppLocalizations.of(context)!
                                  .selectPositionHint(label),
                              items: getDropdownItems(positionKey),
                              value: selectedPositions[positionKey],
                              onChanged: (value) {
                                setState(() {
                                  selectedPositions[positionKey] = value;
                                  errors[positionKey] = null;
                                });
                              },
                              validator: (String? value) => value == null
                                  ? AppLocalizations.of(context)!.positionRequired(label)
                                  : null,
                              aboveText: label,
                            ),
                            if (errors[positionKey] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  errors[positionKey]!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: const Color.fromARGB(255, 4, 34, 207),
                      buttonText: widget.isUpdateMode
                          ? AppLocalizations.of(context)!.editButton
                          : AppLocalizations.of(context)!.saveButton,
                      onPressed: () {
                        validateInputs();
                        if (errors.values.every((error) => error == null)) {
                          saveVslaGroupLeaders();
                        }
                      },
                      type: ButtonType.elevated,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
