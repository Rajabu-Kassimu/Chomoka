import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/vsla_previous_meeting_dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MemberShare extends StatefulWidget {
  final int mzungukoId;
  MemberShare({Key? key, required this.mzungukoId}) : super(key: key);

  @override
  _MemberShareState createState() => _MemberShareState();
}

class _MemberShareState extends State<MemberShare> {
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
  final Map<int, TextEditingController> _controllers = {};

  // Variables for tracking totals and validation
  String totalHisa = '0';
  int enteredTotalHisa = 0;
  String? errorMessage;
  String? successMessage;
  String _hisaAmount = '0'; // Value of one share

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      // Fetch total hisa from VikaovilivyopitaModel
      final vikaoModel = VikaovilivyopitaModel();
      final hisaData = await vikaoModel
          .where('kikao_key', '=', 'jumla_ya_hisa')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (hisaData is VikaovilivyopitaModel && hisaData.value != null) {
        totalHisa = hisaData.value!;
      }

      // Fetch hisa amount (value of one share)
      await _fetchHisaAmount();

      // Fetch all group members
      final groupMemberModel = GroupMembersModel();
      List<Map<String, dynamic>> allUsers = await groupMemberModel
          .find()
          .then((users) => users.map((user) => user.toMap()).toList());

      // Fetch existing member share contributions
      final memberShareModel = MemberShareModel();
      List<Map<String, dynamic>> existingShares = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .find()
          .then((shares) => shares.map((share) => share.toMap()).toList());

      // Create a map for quick lookup of existing shares
      Map<int, Map<String, dynamic>> sharesMap = {};
      for (var share in existingShares) {
        final userId = share['user_id'] as int?;
        if (userId != null) {
          sharesMap[userId] = share;
        }
      }

      setState(() {
        _users = allUsers.map((user) {
          int userId = user['id'] as int;
          final existing = sharesMap[userId];

          int shareCount = existing?['number_of_shares'] ?? 0;

          _controllers[userId] = TextEditingController(
              text: shareCount > 0 ? shareCount.toString() : "");

          return {
            "name": user['name'] ?? AppLocalizations.of(context)!.unnamed,
            "phone": user['phone'] ?? AppLocalizations.of(context)!.noPhone,
            "shareCount": shareCount,
            "userId": userId,
          };
        }).toList();

        enteredTotalHisa = _calculateTotalShares();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // setState(() {
      //   errorMessage = AppLocalizations.of(context)!.errorLoadingData;
      //   _users = [];
      //   isLoading = false;
      // });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = KikaoKilichopitaModel(
        meeting_step: 'akiba_hiari_last',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      print('Error updating status: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(AppLocalizations.of(context)!.failedToUpdateStatus)),
      // );
    }
  }

  Future<void> _fetchHisaAmount() async {
    try {
      final katiba = KatibaModel();
      final shareData =
          await katiba.where('katiba_key', '=', 'share_amount').findOne();

      if (shareData != null && shareData is KatibaModel) {
        setState(() {
          _hisaAmount = shareData.value ?? '0';
        });
      }
    } catch (e) {
      print('Error fetching hisa amount: $e');
    }
  }

  int _calculateTotalShares() {
    int total = 0;
    for (var user in _users) {
      final shareCount = user["shareCount"] as int? ?? 0;
      total += shareCount;
    }
    return total;
  }

  void _updateTotalShares() {
    setState(() {
      for (var user in _users) {
        final userId = user["userId"] as int;
        final shareText = _controllers[userId]?.text.trim() ?? '0';
        final shareCount = int.tryParse(shareText) ?? 0;
        user["shareCount"] = shareCount;
      }
      enteredTotalHisa = _calculateTotalShares();
    });
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      if (_users.isEmpty) {
        setState(() {
          errorMessage = 'No data to save.';
          isLoading = false;
        });
        return;
      }

      _updateTotalShares();

      // Validate that entered total matches expected total
      if (enteredTotalHisa != int.parse(totalHisa)) {
        setState(() {
          errorMessage =
              'Jumla ya hisa inapaswa kuwa ${totalHisa}. Hivi sasa ${enteredTotalHisa}. Tafadhali rekebisha.';
          isLoading = false;
        });
        return;
      }

      final memberShareModel = MemberShareModel();
      List<String> failedSaves = [];

      for (var user in _users) {
        final userId = user["userId"] as int?;
        final shareText = _controllers[userId]?.text.trim() ?? '0';
        final shareCount = int.tryParse(shareText) ?? 0;

        if (userId == null || shareCount == 0) continue;

        try {
          final existing = await memberShareModel
              .where('user_id', '=', userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (existing != null) {
            await memberShareModel
                .where('user_id', '=', userId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .update({
              'number_of_shares': shareCount,
            });
          } else {
            final newShare = MemberShareModel(
              userId: userId,
              numberOfShares: shareCount,
              mzungukoId: widget.mzungukoId,
            );
            await newShare.create();
          }
        } catch (e) {
          print('Error saving share for user $userId: $e');
          failedSaves.add(user["name"] ?? "Unnamed");
        }
      }

      if (failedSaves.isEmpty) {
        // Update meeting step status
        await _updateStatusToCompleted();

        setState(() {
          successMessage = 'Hisa za wanachama zimehifadhiwa kikamilifu!';
          isLoading = false;
        });

        // Navigate to dashboard after successful save
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VslaPreviosusMeetingDashboard(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Failed to save shares for: ${failedSaves.join(", ")}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error saving data: $e');
      setState(() {
        errorMessage = 'Error saving data: $e';
        isLoading = false;
      });
    }
  }

  Color _determineTotalColor() {
    if (enteredTotalHisa == int.tryParse(totalHisa) && totalHisa != '0') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberShareTitle,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _users.isEmpty
                ? Center(child: Text(l10n.noMembers))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.vslaEnterTotalShares + ":",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    totalHisa,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.vslaTotalShares + ":",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    enteredTotalHisa.toString(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: _determineTotalColor(),
                                    ),
                                  ),
                                ],
                              ),
                              if (errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              if (successMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    successMessage!,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            final userId = user["userId"] as int;
                            final name = user["name"] as String;
                            final phone = user["phone"] as String;
                            final int shareCount = user["shareCount"] as int? ?? 0;
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            l10n.phoneNumber + ": $phone",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            l10n.shareCount + ":",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            decoration: InputDecoration(
                                              hintText: shareCount == 0 ? l10n.enterShares : null,
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                            ),
                                            controller: _controllers[userId],
                                            onChanged: (value) {
                                              setState(() {
                                                int parsedValue = int.tryParse(value) ?? 0;
                                                user["shareCount"] = parsedValue;
                                                enteredTotalHisa = _calculateTotalShares();
                                                errorMessage = null;
                                                successMessage = null;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.saveButton,
                        onPressed: _saveData,
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
      ),
    );
  }
}
