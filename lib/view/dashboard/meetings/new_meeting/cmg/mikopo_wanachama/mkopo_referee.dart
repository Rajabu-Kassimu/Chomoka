import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/loan_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class WadhaminiPage extends StatefulWidget {
  final Map<String, dynamic> userId;
  final int meetingId;
  var mzungukoId;
  final bool noRefferee;

  WadhaminiPage(
      {required this.userId,
      required this.meetingId,
      this.mzungukoId,
      this.noRefferee = false});

  @override
  _WadhaminiPageState createState() => _WadhaminiPageState();
}

class _WadhaminiPageState extends State<WadhaminiPage> {
  int requiredReferees = 1;
  List<Map<String, dynamic>> groupMembers = [];
  List<Map<String, dynamic>> selectedReferees = [];
  String? errorMessage;
  bool isLoading = true;

  Future<void> _fetchData() async {
    try {
      final katiba = KatibaModel();
      final katibaData = await katiba
          .where('katiba_key', '=', 'idadi_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (katibaData != null && katibaData is KatibaModel) {
        requiredReferees = int.parse(katibaData.value ?? '1');
      }

      final groupMembersModel = GroupMembersModel();
      final allMembers = await groupMembersModel.find();

      final toaMkopoModel = ToaMkopoModel()
        ..where('userId', '=', widget.userId['id'])
        ..where('meetingId', '=', widget.meetingId)
        ..where('mzungukoId', '=', widget.mzungukoId); // Include mzungukoId

      final savedMkopo = await toaMkopoModel.first();

      List<int> savedRefereeIds = [];
      if (savedMkopo != null) {
        final mkopo = savedMkopo as ToaMkopoModel;

        savedRefereeIds = (mkopo.referees ?? '')
            .split(',')
            .where((id) => id.isNotEmpty)
            .map((id) => int.parse(id))
            .toList();
      }

      setState(() {
        groupMembers = allMembers
            .where((member) => member.toMap()['id'] != widget.userId['id'])
            .map((member) => member.toMap())
            .toList();

        selectedReferees = groupMembers
            .where((member) => savedRefereeIds.contains(member['id']))
            .toList();
      });
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveReferees() async {
    try {
      final refereesIds = selectedReferees.map((ref) => ref['id']).join(',');

      final toaMkopoModel = ToaMkopoModel()
        ..userId = widget.userId['id']
        ..meetingId = widget.meetingId
        ..mzungukoId = widget.mzungukoId
        ..referees = refereesIds;

      final existingMkopo = await ToaMkopoModel()
          .where('userId', '=', widget.userId['id'])
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .first();

      if (existingMkopo != null) {
        final mkopo = existingMkopo as ToaMkopoModel;

        await ToaMkopoModel().where('id', '=', mkopo.id).update({
          'referees': refereesIds,
        });
      } else {
        await toaMkopoModel.create();
      }
    } catch (e) {
      print("Error saving referees: $e");
    }
  }

  void _onRefereeSelected(Map<String, dynamic> referee) {
    if (selectedReferees.contains(referee)) {
      setState(() {
        selectedReferees.remove(referee);
      });
    } else if (selectedReferees.length < requiredReferees) {
      setState(() {
        selectedReferees.add(referee);
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = "Unaweza kuchagua wadhamini $requiredReferees tu.";
      });
    }
  }

  void _validateAndProceed() async {
    if (selectedReferees.length != requiredReferees) {
      setState(() {
        errorMessage = "Tafadhali chagua wadhamini $requiredReferees.";
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    await _saveReferees();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoanSummaryPage(
          userId: widget.userId,
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData().then((_) {
      if (requiredReferees == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoanSummaryPage(
              userId: widget.userId,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
              noRefferee: true,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mkopo,
        subtitle: l10n.wadhamini,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Details
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, size: 30),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.jinas(widget.userId['name']),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  l10n.memberNumberLabel(
                                      widget.userId['memberNumber'] ?? 0),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    l10n.chagua_wadhamini(requiredReferees),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          groupMembers.length + 1, // Add one for the error
                      itemBuilder: (context, index) {
                        if (index == groupMembers.length) {
                          return errorMessage != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    errorMessage!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                )
                              : SizedBox.shrink();
                        }

                        final referee = groupMembers[index];
                        final isSelected = selectedReferees.contains(referee);
                        return ListTile(
                          title: Text(
                            referee['name'] ?? 'Unknown',
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                          onTap: () => _onRefereeSelected(referee),
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    color: Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.continue_,
                    onPressed: _validateAndProceed,
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }
}
