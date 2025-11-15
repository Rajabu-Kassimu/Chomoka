import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupLeadersModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/faini.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';

class GroupLeaders extends StatefulWidget {
  final int groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  GroupLeaders({
    super.key,
    required this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<GroupLeaders> createState() => _GroupLeadersState();
}

class _GroupLeadersState extends State<GroupLeaders> {
  final GroupMembersModel _groupMembersModel = GroupMembersModel();
  List<String> allUsers = [];
  Map<String, String?> selectedPositions = {
    'Mwenyekiti': null,
    'Katibu': null,
    'Mweka Hazina': null,
    'Mdhibiti': null,
  };

  final Map<String, String?> errors = {
    'Mwenyekiti': null,
    'Katibu': null,
    'Mweka Hazina': null,
    'Mdhibiti': null,
  };

  @override
  void initState() {
    super.initState();
    initializeData();
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
    try {
      List<BaseModel> leaders = await GroupLeaderModel()
          .where('group_id', '=', widget.groupId)
          .find();

      for (var leader in leaders) {
        final leaderModel = GroupLeaderModel().fromMap(leader.toMap());
        final user = await GroupMembersModel()
            .where('id', '=', leaderModel.user_id)
            .first() as GroupMembersModel?;

        if (user != null) {
          setState(() {
            selectedPositions[leaderModel.position ?? ''] = user.name;
          });
        }
      }
    } catch (e) {
      print('Error fetching existing leaders: $e');
    }
  }

  Future<void> saveGroupLeaders() async {
    try {
      await BaseModel.initAppDatabase();

      for (var entry in selectedPositions.entries) {
        final position = entry.key;
        final userName = entry.value;

        if (userName == null) continue;

        final user = await GroupMembersModel()
            .where('name', '=', userName)
            .first() as GroupMembersModel?;

        if (user != null) {
          final existingLeader = await GroupLeaderModel()
              .where('group_id', '=', widget.groupId)
              .where('position', '=', position)
              .first() as GroupLeaderModel?;

          if (existingLeader != null) {
            await GroupLeaderModel()
                .where('id', '=', existingLeader.id)
                .update({
              'user_id': user.id,
              'position': position,
              'mzungukoId': widget.mzungukoId, // Include mzungukoId in update
            });
          } else {
            GroupLeaderModel leader = GroupLeaderModel(
              group_id: widget.groupId,
              user_id: user.id,
              position: position,
              mzungukoId: widget.mzungukoId, // Include mzungukoId in create
            );

            await leader.create();
          }
        }
      }

      List<BaseModel> leaders = await GroupLeaderModel().find();
      print('Saved Group Leaders:');
      for (var leader in leaders) {
        print(leader.toMap());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Viongozi wamehifadhiwa kwa mafanikio')),
      );
      await fetchExistingLeaders();

      if (widget.isUpdateMode) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConstitutionOverview(
                    groupId: widget.groupId,
                    mzungukoId: widget.mzungukoId,
                  )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FainiPage(
                    groupId: widget.groupId,
                    mzungukoId: widget.mzungukoId,
                  )),
        );
      }
    } catch (e) {
      print('Error saving group leaders: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hitilafu ilitokea wakati wa kuhifadhi data')),
      );
    }
  }

  List<DropdownMenuItem<String>> getDropdownItems(String position) {
    Set<String> availableUsers = allUsers.where((user) {
      return !selectedPositions.containsValue(user) ||
          selectedPositions[position] == user;
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
      selectedPositions.forEach((position, value) {
        errors[position] = value == null ? 'Tafadhali chagua $position' : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taarifa za Katiba',
        subtitle: 'Viongozi wa Kikindi',
        showBackArrow: true,
      ),
      body: allUsers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ...selectedPositions.keys.map((position) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown<String>(
                              labelText: position,
                              hintText: 'Chagua $position',
                              items: getDropdownItems(position),
                              value: selectedPositions[position],
                              onChanged: (value) {
                                setState(() {
                                  selectedPositions[position] = value;
                                  errors[position] =
                                      null; // Clear error on selection
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Tafadhali chagua $position';
                                }
                                return null;
                              },
                              aboveText: position,
                            ),
                            if (errors[position] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  errors[position]!,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 20),
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: widget.isUpdateMode ? 'Rekebisha' : 'Hifadhi',
                      onPressed: () {
                        validateInputs();
                        if (errors.values.every((error) => error == null)) {
                          saveGroupLeaders();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Tafadhali chagua viongozi wote')),
                          );
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
