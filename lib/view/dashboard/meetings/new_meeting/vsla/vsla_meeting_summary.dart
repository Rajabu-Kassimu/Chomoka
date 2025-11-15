import 'package:chomoka/l10n/app_localizations.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/model/other_funds/DifferentAmountContributionModel.dart';
import 'package:chomoka/model/other_funds/SameContrinutionModel.dart';
import 'package:chomoka/view/dashboard/help.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/group_total_amount.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/send_sms.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class VslaMeetingSummaryPage extends StatefulWidget {
  var meetingId;
  var groupId;
  var mzungukoId;
  var meetingNumber;
  final bool isFromHistory;
  final bool isFromMeetingSummary;

  VslaMeetingSummaryPage(
      {required this.meetingId,
      this.groupId,
      this.mzungukoId,
      this.meetingNumber,
      this.isFromHistory = false,
      this.isFromMeetingSummary = false});

  @override
  _VslaMeetingSummaryPageState createState() => _VslaMeetingSummaryPageState();
}

class _VslaMeetingSummaryPageState extends State<VslaMeetingSummaryPage> {
  double _totalAkibaLazima = 0;
  int _totalAkibaHiari = 0;
  double _totalMfukoJamii = 0;
  double _kilichotolewaMfukoJamii = 0;
  double _fainiTotal = 0;
  double _kiasiKinachodaiwa = 0;
  double _totalRepayAmount = 0;
  double _totalPaidAmount = 0;
  double _matumiziTotal = 0;
  double totalContributions = 0;
  double totalMkupuoAmount = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> attendanceList = [];
  Map<String, int>? summary;
  int? meetingId;
  bool isActiveMeeting = false;

  Widget _buildTotalAmountCard() {
    return GroupTotalAmount(
      mzungukoId: widget.mzungukoId,
      data_id: widget.groupId,
    );
  }

  // VSLA specific variables
  double _totalShares = 0;
  double _totalSharesAmount = 0;
  double _totalSocialFund = 0;
  double _totalLoansIssued = 0;
  double _totalLoanRepayments = 0;
  double _totalUnpaidAmount = 0;
  double shareValue = 3000.0; // Default value, will be updated from KatibaModel

  Future<void> _fetchMfukoJamiiData() async {
    try {
      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();

      final records = await mfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalSum = 0;
      Set<int> seenUserIds = Set<int>();

      if (records.isNotEmpty) {
        totalSum = records.fold(0, (sum, record) {
          final amount = (record['total'] as num?)?.toDouble() ?? 0;
          final status = record['paid_status'] as String?;
          final userId = record['user_id'] as int?;

          if (status == 'paid' &&
              userId != null &&
              !seenUserIds.contains(userId)) {
            seenUserIds.add(userId);
            return sum + amount;
          }

          return sum;
        });
      }

      setState(() {
        _totalMfukoJamii = totalSum;
        _totalSocialFund = totalSum; // For VSLA, this is the social fund
      });

      print('Total Mfuko Jamii: $_totalMfukoJamii');
    } catch (e) {
      print('Error fetching Mfuko Jamii data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya Mfuko Jamii.')),
      );
    }
  }

  Future<void> _fetchFainiTotal() async {
    try {
      final userFainiModel = UserFainiModel();
      final results = await userFainiModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results
            .map((entry) => (entry['paidfaini'] ?? 0).toDouble())
            .fold(0.0, (sum, element) => sum + element);

        setState(() {
          _fainiTotal = total;
        });
      } else {
        setState(() {
          _fainiTotal = 0.0;
        });
      }
    } catch (e) {
      print(
          'Error fetching total unpaid fines for meeting ID ${widget.meetingId}: $e');
      setState(() {
        _fainiTotal = 0.0;
      });
    }
  }

  Future<void> _fetchTotalRepayAmount() async {
    try {
      final toaMkopoModel = ToaMkopoModel();

      final List<Map<String, dynamic>> results = await toaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meetingId', '=', widget.meetingId)
          .select();

      double totalRepayAmount = 0.0;

      if (results.isNotEmpty) {
        totalRepayAmount = results.fold(0.0, (sum, record) {
          return sum + (record['repayAmount'] as double? ?? 0.0);
        });
      }

      setState(() {
        _totalRepayAmount = totalRepayAmount;
        _totalLoansIssued = totalRepayAmount; // For VSLA, this is loans issued
      });

      print(
          'Total Repay Amount for Meeting ID ${widget.meetingId}: $_totalRepayAmount');
    } catch (e) {
      print('Error fetching total repay amount: $e');
      setState(() {
        _totalRepayAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya marejesho.')),
      );
    }
  }

  Future<void> _fetchTotalPaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();

      final List<Map<String, dynamic>> results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalPaidAmount = 0.0;

      if (results.isNotEmpty) {
        totalPaidAmount = results.fold(0.0, (sum, record) {
          return sum + (record['paidAmount'] as double? ?? 0.0);
        });
      }

      setState(() {
        _totalPaidAmount = totalPaidAmount;
        _totalLoanRepayments = totalPaidAmount;
      });

      print(
          'Total Paid Amount for Meeting ID ${widget.meetingId}: $_totalPaidAmount');
    } catch (e) {
      print('Error fetching total paid amount: $e');
      setState(() {
        _totalPaidAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
      );
    }
  }

  Future<void> _fetchTotalUnpaidAmount() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();

      final List<Map<String, dynamic>> results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      double totalUnpaidAmount = 0.0;

      if (results.isNotEmpty) {
        totalUnpaidAmount = results.fold(0.0, (sum, record) {
          return sum + (record['unpaidAmount'] as double? ?? 0.0);
        });
      }

      setState(() {
        _totalUnpaidAmount = totalUnpaidAmount;
      });

      print(
          'Total Paid Amount for Meeting ID ${widget.meetingId}: $_totalPaidAmount');
    } catch (e) {
      print('Error fetching total paid amount: $e');
      setState(() {
        _totalPaidAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia jumla ya malipo.')),
      );
    }
  }

  Future<void> _fetchingMatumiziTotal() async {
    try {
      final matumiziModel = MatumiziModel();

      final results = await matumiziModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results.fold(0.0, (sum, record) {
          return sum + (record['amount'] as double? ?? 0.0);
        });

        setState(() {
          _matumiziTotal = total;
        });
      } else {
        setState(() {
          _matumiziTotal = 0.0;
        });
      }
    } catch (e) {
      print('Error fetching total amount for meeting: $e');
      setState(() {
        _matumiziTotal = 0.0;
      });
    }
  }

  Future<void> _fetchSavedAttendance() async {
    try {
      final attendanceModel = AttendanceModel();
      final savedAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      print('Fetched ${savedAttendances.length} attendance records.');

      int totalMembers = savedAttendances.length;
      int presentMembers = 0;
      int absentMembers = 0;
      int kawahi = 0;
      int kachelewa = 0;
      int withPermission = 0;
      int withoutPermission = 0;
      int representative = 0;

      for (var attendance in savedAttendances) {
        final status = attendance.toMap()['attendance_status'] ?? 'unknown';
        final subStatus =
            attendance.toMap()['sub_attendance_status'] ?? 'unknown';

        if (status == 'Yupo') {
          presentMembers++;
          if (subStatus == 'Kawahi') {
            kawahi++;
          } else if (subStatus == 'Kachelewa') {
            kachelewa++;
          }
        } else if (status == 'Hayupo') {
          absentMembers++;
          if (subStatus == 'Kwa Ruhusa') {
            withPermission++;
          } else if (subStatus == 'Bila Ruhusa') {
            withoutPermission++;
          } else if (subStatus == 'Katuma Mwakilishi') {
            representative++;
          }
        }
      }

      setState(() {
        summary = {
          'total': totalMembers,
          'present': presentMembers,
          'absent': absentMembers,
          'kawahi': kawahi,
          'kachelewa': kachelewa,
          'withPermission': withPermission,
          'withoutPermission': withoutPermission,
          'representative': representative,
        };
      });

      print('Attendance Summary Fetched and Displayed.');
    } catch (e, stackTrace) {
      print('Error fetching attendance data: $e');
      print('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch attendance data.')),
      );
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

  Future<void> fetchGroupIdAndNavigateToHome(BuildContext context) async {
    try {
      final groupInformation = await _fetchSavedData();

      if (groupInformation != null && groupInformation.id != null) {
        debugPrint("Group ID fetched: ${groupInformation.id}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendSms(
              groupId: groupInformation.id,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
              meetingNumber: widget.meetingNumber,
            ),
          ),
        );
      } else {
        debugPrint("Group information is null or missing an ID.");
      }
    } catch (e) {
      debugPrint("Error fetching group ID and navigating to HomePage: $e");
    }
  }

  Future<void> _fetchKilichotolewaMfukoJamii() async {
    try {
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();

      toaMfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId);

      final records = await toaMfukoJamiiModel.select();
      double totalAmountWithdrawn = records.fold(0.0, (sum, record) {
        final amount = (record['amount'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      setState(() {
        _kilichotolewaMfukoJamii = totalAmountWithdrawn;
      });
    } catch (e) {
      print('Error fetching withdrawal data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data za mfuko jamii.'),
        ),
      );
    }
  }

  Future<void> _navigateToActiveMeeting() async {
    final model = MeetingModel();
    try {
      final activeMeeting =
          await model.where('status', '=', 'active').findOne();

      if (activeMeeting != null && activeMeeting is MeetingModel) {
        final int? existingMeetingId = activeMeeting.id;
        final int? meetingNumber = activeMeeting.number;

        if (existingMeetingId != null && meetingNumber != null) {
          setState(() {
            meetingId = existingMeetingId;
          });
        } else {
          print("Meeting ID or Meeting Number is null.");
        }
      } else {
        print("No active meeting found.");
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
    }
  }

  Future<void> _fetchContributions() async {
    try {
      // First fetch the share value from KatibaModel
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        shareValue =
            double.tryParse(shareData.value?.toString() ?? '3000') ?? 3000.0;
      }

      // Replace the existing implementation with MemberShareModel
      final memberShareModel = MemberShareModel();
      final results = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meeting_id', '=', widget.meetingId)
          .select();

      // Calculate total number of shares
      int totalShares = 0;
      for (var share in results) {
        final numberOfShares = share['number_of_shares'];
        if (numberOfShares != null) {
          totalShares += (numberOfShares as num).toInt();
        }
      }

      double totalShareAmount = totalShares * shareValue;

      setState(() {
        totalContributions = totalShareAmount;
        _totalShares = totalShares.toDouble();
        _totalSharesAmount = totalShareAmount;
        isLoading = false;
      });

      print(
          'Total Shares: $totalShares, Total Share Amount: $_totalSharesAmount, Share Value: $shareValue');
    } catch (e) {
      print('Error fetching share data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _checkActiveMeeting() async {
    final model = MeetingModel();
    try {
      final activeMeeting = await model
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'active')
          .findOne();

      if (activeMeeting != null) {
        setState(() {
          isActiveMeeting = true;
        });
        return true;
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() {
      isActiveMeeting = false;
    });
    return false;
  }

  Future<void> _fetchUwekajiMkupuo() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('meetingId', '=', widget.meetingId)
          .select();

      // Calculate total amount
      double totalAmount = 0;
      for (var contribution in results) {
        // Safely handle null amounts by using null-aware operator
        final amount = contribution['amount'];
        if (amount != null) {
          totalAmount += (amount as num).toDouble();
        }
      }

      setState(() {
        totalMkupuoAmount = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Add near other variable declarations
  Map<String, double> _mifukoTotals = {};

  // Add this method to fetch mifuko data
  Future<void> _fetchMifukoData() async {
    try {
      final mifukoModel = MifukoMingineModel();
      final mifukoList =
          await mifukoModel.where('mzungukoId', '=', widget.mzungukoId).find();

      Map<String, double> totals = {};

      for (var mfuko in mifukoList) {
        if (mfuko is MifukoMingineModel && mfuko.id != null) {
          String mfukoName = mfuko.mfukoName ?? 'Unknown Fund';
          double total = 0;

          // Check contribution type
          if (mfuko.utoajiType == 'Kiwango sawa') {
            final sameContribModel = SameContributionModel();
            final contributions = await sameContribModel
                .where('meetingId', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', mfuko.id)
                .find();

            for (var contrib in contributions) {
              if (contrib is SameContributionModel) {
                total += contrib.amount ?? 0;
              }
            }
          } else {
            final diffContribModel = DifferentAmountContributionModel();
            final contributions = await diffContribModel
                .where('meetingId', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .where('mfukoId', '=', mfuko.id)
                .find();

            for (var contrib in contributions) {
              if (contrib is DifferentAmountContributionModel) {
                total += contrib.paidAmount ?? 0;
              }
            }
          }

          totals[mfukoName] = total;
        }
      }

      setState(() {
        _mifukoTotals = totals;
      });
    } catch (e) {
      print('Error fetching mifuko data: $e');
    }
  }

  // Add _fetchMifukoData to _fetchData method
  Future<GroupInformationModel?> _fetchData() async {
    await _navigateToActiveMeeting();
    await _fetchMfukoJamiiData();
    await _fetchSavedData();
    await _fetchFainiTotal();
    await _fetchTotalRepayAmount();
    await _fetchTotalPaidAmount();
    await _fetchingMatumiziTotal();
    await _fetchSavedAttendance();
    await _fetchKilichotolewaMfukoJamii();
    await _fetchContributions();
    await _fetchUwekajiMkupuo();
    await _fetchTotalUnpaidAmount();
    await _fetchMifukoData(); // Add this line
  }

  // Add this section in the build method, before the Attendance section
  Widget _buildMifukoSection() {
    final l10n = AppLocalizations.of(context);

    // If localizations are not yet available, avoid building the section to
    // prevent runtime null-cast errors. The parent build will later rebuild
    // when localizations become available.
    if (l10n == null || _mifukoTotals.isEmpty) {
      return Container();
    }

    return _buildSection(
      title: l10n.otherFunds,
      items: _mifukoTotals.entries
          .map(
            (entry) => _buildRowItem(
              icon: Icons.account_balance_wallet,
              label: entry.key,
              amount: formatCurrency(entry.value, Provider.of<CurrencyProvider>(context).currencyCode),
              color: Colors.purple,
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // If localization isn't yet available, render a minimal scaffold with a
    // loading indicator to avoid calling methods on a null `l10n`.
    if (l10n == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.meetingSummaryTitle(widget.meetingNumber ?? ''),
        subtitle: l10n.meetingSummary,
        showBackArrow: true,
        icon: Icons.help,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpPage()),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VSLA specific section - Share Purchase
            _buildSection(
              title: l10n!.sharePurchaseSection,
              items: [
                _buildRowItem(
                  icon: Icons.monetization_on,
                  label: l10n!.totalSharesDeposited,
                  amount: formatCurrency(_totalShares, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: Colors.blue,
                ),
                _buildRowItem(
                  icon: Icons.monetization_on,
                  label: l10n!.totalShareValue,
                  amount: formatCurrency(_totalSharesAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Social Fund section
            Row(
              children: [
                Expanded(
                  child: _buildSection(
                    title: l10n!.socialFund,
                    items: [
                      _buildRowItem(
                        icon: Icons.handshake,
                        label: l10n!.amountDeposited,
                        amount: formatCurrency(_totalSocialFund, Provider.of<CurrencyProvider>(context).currencyCode),
                        color: Colors.green,
                      ),
                      _buildRowItem(
                        icon: Icons.money_off,
                        label: l10n!.amountWithdrawn,
                        amount: formatCurrency(_kilichotolewaMfukoJamii, Provider.of<CurrencyProvider>(context).currencyCode),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Loan section
            _buildSection(
              title: l10n!.loansSection,
              items: [
                _buildRowItem(
                  icon: Icons.local_activity,
                  label: l10n!.loansIssued,
                  amount: formatCurrency(_totalLoansIssued, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                _buildRowItem(
                  icon: Icons.download,
                  label: l10n!.loanAmountRepaid,
                  amount: formatCurrency(_totalLoanRepayments, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: Colors.green,
                ),
                _buildRowItem(
                  icon: Icons.upload,
                  label: l10n!.loanAmountOutstanding,
                  amount: formatCurrency(_totalUnpaidAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Fines section
            _buildSection(
              title: l10n!.finesSection,
              items: [
                _buildRowItem(
                  icon: Icons.handyman,
                  label: l10n!.totalFinesPaid,
                  amount: formatCurrency(_fainiTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: const Color.fromARGB(255, 255, 3, 3),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              title: l10n!.bulkSaving,
              items: [
                _buildRowItem(
                  icon: Icons.handyman,
                  label: l10n!.totalBulkSaving,
                  amount: formatCurrency(totalMkupuoAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: const Color.fromARGB(255, 23, 136, 1),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Expenses section
            _buildSection(
              title: l10n!.expensesSection,
              items: [
                _buildRowItem(
                  icon: Icons.cabin,
                  label: l10n!.totalExpenses,
                  amount: formatCurrency(_matumiziTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                  color: const Color.fromARGB(255, 26, 2, 248),
                ),
              ],
            ),
            SizedBox(height: 20),

            _buildMifukoSection(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                if (summary == null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      l10n!.loadingAttendanceSummary,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              l10n!.attendance,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        buildSummaryRow(Icons.groups, l10n!.totalMembers,
                            summary!['total']),
                        Divider(),
                        buildSummaryRow(Icons.check_circle, l10n!.presentMembers,
                            summary!['present']),
                        buildSummaryRow(
                            Icons.alarm_on, l10n!.earlyMembers, summary!['kawahi']),
                        buildSummaryRow(Icons.alarm_off, l10n!.lateMembers,
                            summary!['kachelewa']),
                        buildSummaryRow(Icons.person_add, l10n!.representative,
                            summary!['representative']),
                        Divider(),
                        buildSummaryRow(
                            Icons.cancel, l10n!.absentMembers, summary!['absent']),
                        buildSummaryRow(Icons.event_available, l10n!.withPermission,
                            summary!['withPermission']),
                        buildSummaryRow(Icons.event_busy, l10n!.withoutPermission,
                            summary!['withoutPermission']),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 20),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: widget.isFromHistory ? l10n!.done : l10n!.closeMeeting,
              onPressed: () async {
                if (widget.isFromHistory) {
                  Navigator.pop(context);
                  return;
                } else {
                  fetchGroupIdAndNavigateToHome(context);
                }
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: items,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowItem({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
    bool canNavigate = false,
    VoidCallback? onNavigate,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          if (canNavigate && onNavigate != null)
            IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: onNavigate,
            ),
        ],
      ),
    );
  }

  Widget buildSummaryRow(IconData icon, String label, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text(
            value?.toString() ?? '0',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}