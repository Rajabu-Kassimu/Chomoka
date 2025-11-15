import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/DifferentAmountFundModel.dart';
import 'package:chomoka/model/other_funds/DifferentAmountContributionModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class DifferentAmount extends StatefulWidget {
  final int meetingId;
  var mzungukoId;
  final bool isFromMeetingSummary;
  final String mfukoName;
  final int? mfukoId;

  DifferentAmount({
    Key? key,
    required this.meetingId,
    this.mzungukoId,
    this.isFromMeetingSummary = false,
    required this.mfukoName,
    this.mfukoId,
  }) : super(key: key);

  @override
  State<DifferentAmount> createState() => _DifferentAmountState();
}

// Update imports

class _DifferentAmountState extends State<DifferentAmount> {
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;
  String _groupType = '';
  Map<int, TextEditingController> _amountControllers = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _amountControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  // Add new state variables
  Map<int, double> _requiredAmounts = {};
  Map<int, TextEditingController> _paidAmountControllers = {};

  // Update _fetchData method to get required amounts
  Future<void> _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Fetch group type
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
      }

      // Fetch attendance records
      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoid', '=', widget.mzungukoId)
          .where('attendance_status', '=', 'Yupo')
          .find();

      if (yupoAttendances.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna wanachama waliopo.')),
        );
        setState(() {
          _users = [];
          isLoading = false;
        });
        return;
      }

      List<int> yupoUserIds = yupoAttendances
          .map((attendance) => attendance.toMap()['user_id'] as int?)
          .where((id) => id != null)
          .cast<int>()
          .toSet()
          .toList();

      // Fetch users
      final usersModel = GroupMembersModel();
      List<Map<String, dynamic>> yupoUsers = [];
      for (int id in yupoUserIds) {
        final user = await usersModel.where('id', '=', id).first();
        if (user != null) {
          yupoUsers.add(user.toMap());
        }
      }

      // Get required amounts from DifferentAmountFundModel
      final fundModel = DifferentAmountFundModel();
      final requiredAmounts = await fundModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('mfukoId', '=', widget.mfukoId)
          .find();

      // Get existing contributions
      final contributionModel = DifferentAmountContributionModel();
      final existingContributions = await contributionModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('mfukoId', '=', widget.mfukoId)
          .find();

      Map<int, Map<String, double>> contributionsMap = {};
      for (var contribution in existingContributions) {
        if (contribution is DifferentAmountContributionModel &&
            contribution.userId != null) {
          contributionsMap[contribution.userId!] = {
            'paid': contribution.paidAmount ?? 0.0,
            'unpaid': contribution.unpaidAmount ?? 0.0,
          };
        }
      }

      // Create controllers for each user
      List<Map<String, dynamic>> updatedUsers = [];
      for (var user in yupoUsers) {
        int userId = user['id'] as int;

        // Get required amount for this user
        var userFund = requiredAmounts.firstWhere(
          (fund) => (fund as DifferentAmountFundModel).userId == userId,
          orElse: () => DifferentAmountFundModel(amount: 0.0),
        );
        double requiredAmount =
            (userFund as DifferentAmountFundModel).amount ?? 0.0;
        _requiredAmounts[userId] = requiredAmount;

        // Get existing contribution or set defaults
        var existingContribution =
            contributionsMap[userId] ?? {'paid': 0.0, 'unpaid': requiredAmount};

        // In the _fetchData method, update the controller text initialization
        _paidAmountControllers[userId] = TextEditingController(
          text: existingContribution['paid']! > 0
              ? existingContribution['paid']!.toInt().toString()
              : '',
        );

        updatedUsers.add({
          "name": user['name'] ?? "Jina lisiloelezwa",
          "phone": user['phone'] ?? "Simu isiyoelezwa",
          "userId": userId,
          "memberNumber": user['memberNumber'] ?? "-",
          "requiredAmount": requiredAmount,
          "unpaidAmount": existingContribution['unpaid'],
        });
      }

      setState(() {
        _users = updatedUsers;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  // Update _calculateTotalCollected to return integer
  int _calculateTotalCollected() {
    int total = 0;
    _paidAmountControllers.values.forEach((controller) {
      total += int.tryParse(controller.text) ?? 0;
    });
    return total;
  }

  // Add validation method
  // Remove or modify the validation method to always return true
  bool _validatePayment(int userId, String amount) {
  // Always return true to allow any amount
  return true;
  }
  
  // Update the TextField in ListView.builder

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_users.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna data ya kuhifadhi.')),
        );
        return;
      }

      List<String> failedSaves = [];

      for (var user in _users) {
        int userId = user["userId"] as int;
        double requiredAmount = _requiredAmounts[userId] ?? 0.0;
        double paidAmount =
            double.tryParse(_paidAmountControllers[userId]?.text ?? '0') ?? 0.0;
        double unpaidAmount = requiredAmount - paidAmount;

        try {
          final contributionModel = DifferentAmountContributionModel();
          final existingRecord = await contributionModel
              .where('meetingId', '=', widget.meetingId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .where('mfukoId', '=', widget.mfukoId)
              .where('userId', '=', userId)
              .first();

          if (existingRecord != null) {
            // Fix: Use the same where conditions for update
            await contributionModel
                .where('meetingId', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', widget.mfukoId)
                .where('userId', '=', userId)
                .update({
              'paidAmount': paidAmount,
              'unpaidAmount': unpaidAmount,
            });
          } else {
            final newContribution = DifferentAmountContributionModel(
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
              mfukoId: widget.mfukoId,
              userId: userId,
              paidAmount: paidAmount,
              unpaidAmount: unpaidAmount,
            );
            await newContribution.create();
          }
        } catch (e) {
          print('Error saving contribution for user $userId: $e');
          failedSaves.add(user["name"]);
        }
      }

      if (failedSaves.isEmpty) {
        await _updateStatusToCompleted();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Michango imehifadhiwa vizuri!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Imekuwepo matatizo kuhifadhi michango kwa: ${failedSaves.join(", ")}.')),
        );
      }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Kuna tatizo la kuhifadhi michango. Tafadhali jaribu tena.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'mfuko_${widget.mfukoId}',
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imeshindikana kuhifadhi michango: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.contributeOtherFund(widget.mfukoName),
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
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.totalCollected,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_calculateTotalCollected(), Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            final userId = user["userId"] as int;
                            final controller = _amountControllers[userId];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.person, size: 30),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user["name"] ?? l10n.unknownName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            user["memberNumber"] != null
                                                ? l10n.memberNumberLabel(user["memberNumber"])
                                                : l10n.memberNumberLabel('-'),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: 8),
                                          TextField(
                                            controller: _paidAmountControllers[userId],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              labelText: l10n.amountToContribute,
                                              border: OutlineInputBorder(),
                                              prefixText: Provider.of<CurrencyProvider>(context).currencyCode + ' ',
                                            ),
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
                        buttonText: l10n.confirm,
                        onPressed: () async {
                          await _saveData();
                          if (_groupType == 'VSLA') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VslaMeetingDashboard(
                                  meetingId: widget.meetingId,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => meetingpage(
                                  meetingId: widget.meetingId,
                                ),
                              ),
                            );
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
      ),
    );
  }
}
