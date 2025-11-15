import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/principle.dart';
import 'package:chomoka/view/group_setup/fund_information/list_mifuko.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Info.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/view/group_setup/member_Information/member_Info.dart';
import 'package:chomoka/view/group_setup/member_Information/member_list.dart';
import 'package:chomoka/view/group_setup/password/SetPasswordPage.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/view/pre_page/setting.dart';
import 'package:flutter/material.dart';
import '../../widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class homePage extends StatefulWidget {
  final data_id;
  final bool fromHomePage;
  final bool isMzungukoPending;

  homePage(
      {super.key,
      this.data_id,
      this.fromHomePage = false,
      this.isMzungukoPending = false});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isGroupInfoComplete = false;
  bool isMemberInfoComplete = false;
  bool isKatibaComplete = false;
  bool isMifukoInfoComplete = false;
  bool isPasswordSetupComplete = false;
  bool fromHomePage = false;
  bool _isMzungukoPending = false;
  String? groupInfoId;
  int? memberInfoId;
  int? kaibaInfoId;
  int? mzungukoId;

  Future<void> _loadGroupStatus() async {
    try {
      final initSetupModel = InitSetupModel();
      final data = await initSetupModel
          .where('init_key', '=', 'group_info')
          .where('mzungukoId', '=', mzungukoId)
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is InitSetupModel) {
        setState(() {
          isGroupInfoComplete = true;
          groupInfoId = data.id.toString();
        });
      } else {
        setState(() {
          isGroupInfoComplete = false;
        });
      }
    } catch (e) {
      print('Error fetching group status: $e');
    }
  }

  Future<void> _checkMemberInfoStatus() async {
    try {
      final initSetupModel = InitSetupModel();

      final data = await initSetupModel
          .where('init_key', '=', 'group_member')
          .where('mzungukoId', '=', mzungukoId)
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is InitSetupModel) {
        setState(() {
          isMemberInfoComplete = true;
          memberInfoId = data.id;
        });
      } else {
        setState(() {
          isMemberInfoComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkKatibaStatus() async {
    try {
      final initSetupModel = InitSetupModel();

      final data = await initSetupModel
          .where('init_key', '=', 'katiba')
          .where('mzungukoId', '=', mzungukoId)
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is InitSetupModel) {
        setState(() {
          isKatibaComplete = true;
          kaibaInfoId = data.id;
        });
      } else {
        setState(() {
          isKatibaComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _loadMifukoJamiiStatus() async {
    try {
      final initSetupModel = InitSetupModel();

      final data = await initSetupModel
          .where('init_key', '=', 'mifuko')
          .where('mzungukoId', '=', mzungukoId)
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is InitSetupModel) {
        setState(() {
          isMifukoInfoComplete = true;
          kaibaInfoId = data.id;
        });
      } else {
        setState(() {
          isMifukoInfoComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkPasswordCompletionStatus() async {
    try {
      final passwordModel = PasswordModel();

      final data = await passwordModel.where('status', '=', 'complete').find();

      if (data != null && data.isNotEmpty) {
        setState(() {
          isPasswordSetupComplete = true;
        });
        print("Password setup is complete.");
      } else {
        setState(() {
          isPasswordSetupComplete = false;
        });
        print("Password setup is not complete.");
      }
    } catch (e) {
      print("Error checking password completion: $e");
    }
  }

  Future<void> fetchGroupIdAndNavigateToHome(BuildContext context) async {
    try {
      final groupInformation = await _fetchSavedData();

      if (groupInformation != null && groupInformation.id != null) {
        debugPrint("Group ID fetched: ${groupInformation.id}");

        await _updateMzungukoStatusToActive();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => dashboard(groupId: groupInformation.id),
          ),
          (Route<dynamic> route) => false, // Hii inafuta historia yote
        );
      } else {
        debugPrint("Group information is null or missing an ID.");
      }
    } catch (e) {
      debugPrint("Error fetching group ID and navigating to HomePage: $e");
    }
  }

  Future<void> _updateMzungukoStatusToActive() async {
    try {
      final mzungukoModel = MzungukoModel();
      if (mzungukoId != null) {
        await mzungukoModel
            .where('id', '=', mzungukoId)
            .update({'status': 'active'});

        print("Mzunguko status updated to active! ID: ${mzungukoId}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mzunguko umewekwa kuwa active!')),
        );
      } else {
        print("Invalid mzungukoId: ${mzungukoId}");
      }
    } catch (e) {
      print("Error updating Mzunguko status: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating Mzunguko status: $e')),
      );
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '=', 'pending').findOne();
    final int? fetchedMzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        mzungukoId = fetchedMzungukoId;
      });
    }
  }

  Future<GroupInformationModel?> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final savedGroup = await groupInformationModel.first();
      return savedGroup as GroupInformationModel?;
    } catch (e) {
      print('Error fetching saved data: $e');
      return null;
    }
  }

  _fetchSavedMembers() async {
    var member = GroupMembersModel();
    var saved_member = await member.findOne();

    if (saved_member != null && saved_member is GroupMembersModel) {
      return saved_member;
    } else {
      return null;
    }
  }

  Future<bool> _isLastMzungukoCompleted() async {
    try {
      final mzungukoModel = MzungukoModel();
      final mzungukoResult = await mzungukoModel.select();

      if (mzungukoResult.isNotEmpty) {
        final lastMzungukoMap = mzungukoResult.reduce((current, next) {
          return current['id'] > next['id'] ? current : next;
        });

        // final bool isCompleted = lastMzungukoMap['status'] == 'completed';
        final bool isPending = lastMzungukoMap['status'] == 'pending';

        setState(() {
          // _isMzungukoCompleted = isCompleted;
          _isMzungukoPending = isPending;
        });

        return isPending;
      }

      return false;
    } catch (e) {
      print('Error fetching the last mzunguko: $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeStatuses();
  }

  Future<void> _initializeStatuses() async {
    try {
      await _fetchMzungukoId();
      await _isLastMzungukoCompleted();
      if (mzungukoId != null) {
        await _loadGroupStatus();
        await _checkMemberInfoStatus();
        await _checkKatibaStatus();
        await _loadMifukoJamiiStatus();
        await _checkPasswordCompletionStatus();
      } else {
        print("Failed to fetch mzungukoId. Skipping status checks.");
      }
    } catch (e) {
      print('Error during initialization: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.setupChomoka,
        showBackArrow: false,
        icon: Icons.settings,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Group Information Tile
                ListTiles(
                  tileColor: isGroupInfoComplete
                      ? Colors.white
                      : const Color.fromARGB(255, 243, 188, 7),
                  icon: Icon(Icons.group, color: Colors.black),
                  title: AppLocalizations.of(context)!.groupInfo,
                  mark: isGroupInfoComplete ? 'completed' : 'pending',
                  onTap: () {
                    if (isGroupInfoComplete && groupInfoId != null) {
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
                          builder: (context) =>
                              groupInfo(data_id: widget.data_id),
                        ),
                      );
                    }
                  },
                ),

                // Member Information Tile
                ListTiles(
                  tileColor: isMemberInfoComplete || !isGroupInfoComplete
                      ? Colors.white
                      : const Color.fromARGB(255, 243, 188, 7),
                  icon: Icon(Icons.person,
                      color: Color.fromARGB(255, 0, 140, 255)),
                  title: AppLocalizations.of(context)!.memberInfo,
                  mark: isMemberInfoComplete ? 'completed' : 'pending',
                  onTap: () async {
                    if (isGroupInfoComplete) {
                      var is_member_list = false;

                      await _fetchSavedMembers().then((value) {
                        is_member_list = value == null ? false : true;
                      });

                      if (is_member_list) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberList(
                              groupId: widget.data_id,
                              fromHomePage: true,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberInfo(
                              groupId: widget.data_id,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),

                // Constitution Information Tile
                ListTiles(
                  tileColor: isKatibaComplete || !isMemberInfoComplete
                      ? Colors.white
                      : const Color.fromARGB(255, 243, 188, 7),
                  icon: Icon(Icons.book_sharp,
                      color: Color.fromARGB(255, 241, 4, 4)),
                  title: AppLocalizations.of(context)!.constitutionInfo,
                  mark: isKatibaComplete ? 'completed' : 'pending',
                  onTap: () {
                    if (isGroupInfoComplete && isMemberInfoComplete)
                      isKatibaComplete
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConstitutionOverview(
                                        groupId: widget.data_id,
                                        mzungukoId: mzungukoId,
                                      )),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => principle(
                                        groupId: widget.data_id,
                                      )),
                            );
                  },
                ),

                ListTiles(
                  tileColor: isMifukoInfoComplete || !isKatibaComplete
                      ? Colors.white
                      : const Color.fromARGB(255, 243, 188, 7),
                  icon:
                      Icon(Icons.money, color: Color.fromARGB(255, 0, 148, 25)),
                  title: AppLocalizations.of(context)!.fundInfo,
                  mark: isMifukoInfoComplete ? 'completed' : 'pending',
                  onTap: () {
                    if (isGroupInfoComplete &&
                        isMemberInfoComplete &&
                        isKatibaComplete)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                mifukoList(mzungukoId: mzungukoId)),
                      ).then((_) {
                        _loadMifukoJamiiStatus();
                      });
                  },
                ),

                ListTiles(
                  tileColor: isPasswordSetupComplete || !isMifukoInfoComplete
                      ? Colors.white
                      : const Color.fromARGB(255, 243, 188, 7),
                  icon: Icon(Icons.card_membership,
                      color: Color.fromARGB(255, 31, 34, 255)),
                  title: AppLocalizations.of(context)!.passwordSetup,
                  mark: isPasswordSetupComplete ? 'completed' : 'pending',
                  onTap: () {
                    if (!isPasswordSetupComplete) {
                      if (isGroupInfoComplete &&
                          isMemberInfoComplete &&
                          isKatibaComplete &&
                          isMifukoInfoComplete)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetPasswordPage(
                                  groupId: widget.data_id,
                                  mzungukoId: mzungukoId)),
                        ).then((_) {
                          _checkPasswordCompletionStatus();
                        });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .passwordSetupComplete),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          if (isGroupInfoComplete &&
              isMemberInfoComplete &&
              isKatibaComplete &&
              isMifukoInfoComplete &&
              isPasswordSetupComplete)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!.finished,
                onPressed: () {
                  fetchGroupIdAndNavigateToHome(context);
                },
                type: ButtonType.elevated,
              ),
            ),
        ],
      ),
    );
  }
}