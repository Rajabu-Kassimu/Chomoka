import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/group_setup/member_Information/member_Info.dart';
import 'package:chomoka/view/group_setup/member_Information/member_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MemberList extends StatefulWidget {
  var groupId;
  var mzungukoId;
  final bool fromHomePage;

  MemberList(
      {super.key,
      required this.groupId,
      this.fromHomePage = false,
      this.mzungukoId});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  var _members = [];
  bool isLoading = true;
  bool _isMzungukoPending = true;
  int mzungukoId = 0;

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
    try {
      print(widget.mzungukoId);
      final initSetupModel = InitSetupModel(
        init_key: 'group_member',
        mzungukoId: mzungukoId,
        value: 'complete',
      );

      await initSetupModel.create();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePage(data_id: widget.groupId),
        ),
      );
    } catch (e) {
      // print(AppLocalizations.of(context)!.failedToUpdateStatus.replaceAll('{error}', e.toString()));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(AppLocalizations.of(context)!.failedToUpdateStatus.replaceAll('{error}', e.toString()))),
      // );
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
        _isMzungukoPending = true;
      });
    } else {
      setState(() {
        _isMzungukoPending = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMembers().then((_) {
      _fetchMzungukoId();
    });
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
                    groupId: widget.groupId, mzungukoId: widget.mzungukoId)),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MemberSummaryPage(
                                      groupId: widget.groupId,
                                      userId: member['id'],
                                      fromHomePage: true,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
                if (showCompletionButton)
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
