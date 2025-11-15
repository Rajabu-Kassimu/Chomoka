import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/repaymentDetailsPage.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/muhtasari_vikao_vilivyopita.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgao_kikundi_summary.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgao_kikundi_summary.dart';
import 'package:chomoka/view/group_setup/group_Information/vsla/vsla_group_overview.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class RejeshaMkopoPage extends StatefulWidget {
  var meetingId;
  final bool fromGroupOverview;
  final bool fromDashboard;
  final bool isFromMgaowakikundi;
  final bool isFromVslaMgaowakikundi;
  final bool fromVlsaGroupOverview;
  final bool isFromVikaoVilivyopitaSummary;
  var groupId;
  var mzungukoId;

  RejeshaMkopoPage(
      {Key? key,
      this.meetingId,
      this.fromGroupOverview = false,
      this.isFromMgaowakikundi = false,
      this.fromVlsaGroupOverview = false,
      this.isFromVslaMgaowakikundi = false,
      this.isFromVikaoVilivyopitaSummary = false,
      this.groupId,
      this.mzungukoId,
      this.fromDashboard = false})
      : super(key: key);

  @override
  _RejeshaMkopoPageState createState() => _RejeshaMkopoPageState();
}

class _RejeshaMkopoPageState extends State<RejeshaMkopoPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> unpaidLoans = [];
  bool isActiveMeeting = false;
  double _totalRepayAmount = 0;
  double _totalPaidAmount = 0;
  double _totalunpaidAmount = 0;
  String _groupType = ''; // Add this property

  Future<void> _fetchUnpaidLoans() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();

      final unpaidLoansData = await rejeshaMkopoModel
          .where('unpaidAmount', '>', 0)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      final groupMemberModel = GroupMembersModel();
      final allMembers = await groupMemberModel.find();

      setState(() {
        unpaidLoans = unpaidLoansData.map((loanModel) {
          final loan = loanModel.toMap();
          final member = allMembers.firstWhere(
            (memberModel) => memberModel.toMap()['id'] == loan['user_id'],
            orElse: () => GroupMembersModel(),
          );

          final memberMap = member.toMap();

          return {
            ...loan,
            'name': memberMap['name'] ?? 'Unknown User',
            'memberNumber': memberMap['memberNumber'] ?? 'N/A',
            'unpaidAmount': loan['unpaidAmount'] != null
                ? double.tryParse(loan['unpaidAmount'].toString())
                : null,
          };
        }).toList();
      });
    } catch (e) {
      print("Error fetching unpaid loans: $e");
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
        meeting_step: 'rejesha_mkopo',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Future<bool> _checkActiveMeeting() async {
    try {
      final model = MeetingModel();
      final activeMeeting = await model
          // .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'active')
          .findOne();

      if (activeMeeting != null && activeMeeting is MeetingModel) {
        final hasValidFields = activeMeeting.id != null && activeMeeting.number != null;
        setState(() {
          isActiveMeeting = hasValidFields;
        });
        return hasValidFields;
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
    
    setState(() {
      isActiveMeeting = false;
    });
    return false;
  }

  Future<void> _fetchTotalRepayAmount() async {
    try {
      final toaMkopoModel = ToaMkopoModel();

      final List<Map<String, dynamic>> results = widget.fromGroupOverview ||
              widget.isFromMgaowakikundi ||
              widget.fromVlsaGroupOverview
          ? await toaMkopoModel
              .where('mzungukoId', '=', widget.mzungukoId)
              .select()
          : await toaMkopoModel
              .where('mzungukoId', '=', widget.mzungukoId)
              // .where('meetingId', '=', widget.meetingId)
              .select();

      double totalRepayAmount = results.fold(0.0, (sum, record) {
        return sum + (record['repayAmount'] as double? ?? 0.0);
      });

      if (mounted) {
        setState(() {
          _totalRepayAmount = totalRepayAmount;
        });
      }

      print('Total Repay Amount: $_totalRepayAmount');
    } catch (e) {
      print('Error fetching total repay amount: $e');

      if (mounted) {
        setState(() {
          _totalRepayAmount = 0.0;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya marejesho.')),
      );
    }
  }

  Future<void> _fetchTotalPaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();

      final List<Map<String, dynamic>> results = widget.fromGroupOverview ||
              widget.isFromMgaowakikundi ||
              widget.fromVlsaGroupOverview
          ? await rejeshaMkopoModel
              .where('mzungukoId', '=', widget.mzungukoId)
              .select()
          : await rejeshaMkopoModel
              .where('mzungukoId', '=', widget.mzungukoId)
              .where('meeting_id', '=', widget.meetingId)
              .select();

      double totalPaidAmount = results.fold(0.0, (sum, record) {
        return sum + (record['paidAmount'] as double? ?? 0.0);
      });

      // Calculate total unpaid amount
      double totalUnpaidAmount = results.fold(0.0, (sum, record) {
        return sum + (record['unpaidAmount'] as double? ?? 0.0);
      });

      setState(() {
        _totalPaidAmount = totalPaidAmount;
        _totalunpaidAmount = totalUnpaidAmount;
      });

      print('Total Paid Amount: $_totalPaidAmount');
      print('Total Unpaid Amount: $_totalunpaidAmount');
    } catch (e) {
      print('Error fetching total paid amount: $e');
      setState(() {
        _totalPaidAmount = 0.0;
        _totalunpaidAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
      );
    }
  }

  // Add this method to check the group type
  Future<void> _checkGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
        print('Group type: $_groupType');
      }
    } catch (e) {
      print('Error checking group type: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkGroupType().then((_) {
      _checkActiveMeeting().then((_) {
        _fetchUnpaidLoans().then((_) {
          _fetchTotalRepayAmount().then((_) {
            _fetchTotalPaidAmount();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.fromVlsaGroupOverview);
    // _checkActiveMeeting();
    print(isActiveMeeting);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanDebtorsTitle,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : unpaidLoans.isEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.loanSummaryTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Total loan amount issued
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanIssuedAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalRepayAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black, // Static for issued loans
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Total loan amount repaid
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanRepaidAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalunpaidAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _totalunpaidAmount > 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Remaining loan amount
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanRemainingAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalunpaidAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: (_totalunpaidAmount) > 0
                                          ? Colors
                                              .red // Debt or incomplete payment
                                          : Colors.green, // Fully repaid
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.noUnpaidLoans,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.doneButton,
                        onPressed: () async {
                          if (widget.fromGroupOverview) {
                            Navigator.pop(context);
                          } else if (!isActiveMeeting) {
                            if (_groupType == 'VSLA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            }
                          } else {
                            await _updateStatusToCompleted();
                            if (_groupType == 'VSLA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMeetingDashboard(
                                    meetingId: widget.meetingId,
                                    groupId: widget.groupId,
                                    meetingNumber: null,
                                  ),
                                ),
                              );
                            } else {
                              // Navigate to regular CMG dashboard
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => meetingpage(
                                    meetingId: widget.meetingId,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.loanSummaryTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Total loan amount issued
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanIssuedAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalRepayAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black, // Static for issued loans
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Total loan amount repaid
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanRepaidAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalPaidAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _totalPaidAmount > 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Remaining loan amount
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.loanRemainingAmount,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(_totalunpaidAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: (_totalunpaidAmount) > 0
                                          ? Colors
                                              .red // Debt or incomplete payment
                                          : Colors.green, // Fully repaid
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      l10n.loanDebtors,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: unpaidLoans.length,
                          itemBuilder: (context, index) {
                            final loan = unpaidLoans[index];
                            return GestureDetector(
                              onTap: () {
                                if (!widget.fromDashboard)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RepaymentDetailsPage(
                                        meetingId: widget.meetingId,
                                        loan: loan,
                                        allMembers: [],
                                        mzungukoId: widget.mzungukoId,
                                        isFromMgaowakikundi: true,
                                      ),
                                    ),
                                  );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            l10n.memberLabel,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "${loan['name']}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Text(
                                          //   l10n.memberNumber,
                                          //   style: TextStyle(
                                          //     fontSize: 14,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                          Text(
                                            "${loan['memberNumber']}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            l10n.unpaidLoanAmount,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            formatCurrency(loan['unpaidAmount'] ?? 0, Provider.of<CurrencyProvider>(context).currencyCode),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.doneButton,
                        onPressed: () async {
                          if (widget.isFromVikaoVilivyopitaSummary == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetingSummaryPage(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else if (widget.fromGroupOverview == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupOverview(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else if (widget.fromVlsaGroupOverview == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VlsaGroupOverview(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else if (isActiveMeeting) {
                            await _updateStatusToCompleted();

                            if (_groupType == 'VSLA') {
                              // Navigate to VSLA dashboard if it's a VSLA group
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMeetingDashboard(
                                    meetingId: widget.meetingId,
                                    groupId: widget.groupId,
                                    meetingNumber: null,
                                  ),
                                ),
                              );
                            } else {
                              // Navigate to regular CMG dashboard
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => meetingpage(
                                    meetingId: widget.meetingId,
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (_groupType == 'VSLA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VslaMgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MgaoWaKikundiPage(
                                    mzungukoId: widget.mzungukoId,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
    );
  }
}
