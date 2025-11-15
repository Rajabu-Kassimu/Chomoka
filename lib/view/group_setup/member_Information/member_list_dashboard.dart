import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/group_setup/member_Information/member_Info.dart';
import 'package:chomoka/view/group_setup/member_Information/member_summary.dart';
import 'package:chomoka/view/group_setup/member_Information/vsla/vsla_member_summarry.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MemberListFromDashboard extends StatefulWidget {
  var groupId;
  final bool fromDashboard;
  var mzungukoId;

  MemberListFromDashboard({
    super.key,
    required this.groupId,
    this.mzungukoId,
    this.fromDashboard = false,
  });

  @override
  State<MemberListFromDashboard> createState() =>
      _MemberListFromDashboardState();
}

class _MemberListFromDashboardState extends State<MemberListFromDashboard> {
  var _members = [];
  bool isLoading = true;
  String? groupType;

  @override
  void initState() {
    super.initState();
    _fetchGroupType().then((_) {
      _fetchMembers();
    });
  }

  Future<void> _fetchGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData =
          await katibaModel.where('katiba_key', '=', 'kanuni').findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          groupType = groupTypeData.value ?? '';
        });
        print('Group type: $groupType');
      }
    } catch (e) {
      // print(AppLocalizations.of(context)!.errorFetchingGroupType.replaceAll('{error}', e.toString()));
    }
  }

  Future<void> _fetchMembers() async {
    try {
      final groupMembersModel = GroupMembersModel();

      final savedMembers = await groupMembersModel.select();

      setState(() {
        _members = savedMembers;
        isLoading = false;
      });
    } catch (e) {
      // print(AppLocalizations.of(context)!.errorFetchingMembers.replaceAll('{error}', e.toString()));
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => dashboard(
          groupId: widget.groupId,
          mzungukoId: widget.mzungukoId,
        ),
      ),
    );
  }

  void _navigateToMemberSummary(dynamic member) {
    if (groupType == 'VSLA') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VslaMemberSummaryPage(
            groupId: widget.groupId,
            mzungukoId: widget.mzungukoId,
            userId: member['id'],
            fromDashboard: true,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemberSummaryPage(
            groupId: widget.groupId,
            mzungukoId: widget.mzungukoId,
            userId: member['id'],
            fromDashboard: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showCompletionButton = _members.length >= 5;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.wanachama,
        showBackArrow: true,
        icon: Icons.person_add,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MemberInfo(
                      groupId: widget.groupId,
                    )),
          );
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _members.isEmpty
                      ? Center(
                          child: Text(AppLocalizations.of(context)!.noMembers))
                      : ListView.builder(
                          itemCount: _members.length,
                          itemBuilder: (context, index) {
                            final member = _members[index];
                            print(member);
                            return MemberCard(
                              image: member['memberImage'] ?? '',
                              memberNumber: member['memberNumber'] ?? '',
                              name: member['name'] ?? '',
                              phone: member['phone'] ?? '',
                              onViewDetails: () {
                                _navigateToMemberSummary(member);
                              },
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: AppLocalizations.of(context)!.completed,
                    onPressed: () async {
                      await _updateStatusToCompleted();
                    },
                    type: ButtonType.elevated,
                  ),
                ),
              ],
            ),
    );
  }
}
