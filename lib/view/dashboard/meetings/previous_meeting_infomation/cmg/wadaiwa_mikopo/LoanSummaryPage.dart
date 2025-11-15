import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/wadaiwa_mikopo/wadaiwa_mikopo.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/MkopoVikaoVilivyopitaModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class WadaiwaMikopoSummaryPage extends StatefulWidget {
  final int userId;
  var mzungukoId;

  WadaiwaMikopoSummaryPage({super.key, required this.userId, this.mzungukoId});

  @override
  State<WadaiwaMikopoSummaryPage> createState() => _LoanSummaryPageState();
}

class _LoanSummaryPageState extends State<WadaiwaMikopoSummaryPage> {
  bool isLoading = true;

  String reasonForLoan = "N/A";
  String loanAmount = "0";
  String amountPaid = "0";
  String loanBalance = "0";
  String loanMeeting = "N/A";
  String loanDuration = "N/A";
  String additionalAmount = "0";
  String guarantor1 = "N/A";
  String guarantor2 = "N/A";

  /// Fetch loan summary data from the database
  Future<void> _fetchLoanSummary() async {
    setState(() {
      isLoading = true;
    });

    try {
      final mkopoModel = MkopoVikaoVilivyopitaModel();
      final savedData =
          await mkopoModel.where('user_id', '=', widget.userId).findOne();

      if (savedData != null) {
        final data = savedData.toMap();
        setState(() {
          reasonForLoan = data['sababu_ya_mkopo'] ?? "N/A";
          loanAmount = data['loan_amount'] ?? "0";
          amountPaid = data['paid_amount'] ?? "0";
          loanBalance = data['outstandingAmount'] ?? "0";
          loanMeeting = data['kikao_alichokopa'] ?? "N/A";
          loanDuration = data['loan_time'] ?? "N/A";
          additionalAmount = data['ziada_ya_mkopo'] ?? "0";

          // Extract guarantors
          final referees = data['referees'] ?? "";
          final guarantors = referees.split(',');
          guarantor1 = guarantors.isNotEmpty ? guarantors[0] : "N/A";
          guarantor2 = guarantors.length > 1 ? guarantors[1] : "N/A";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLoanSummary();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.loanInformation,
        subtitle: l10n.loanSummary,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.loanSummaryTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            _buildSummaryRowWithDivider(l10n.reasonForLoan, reasonForLoan),
                            _buildSummaryRowWithDivider(l10n.loanAmount, "TZS ${formatCurrency(loanAmount)}"),
                            _buildSummaryRowWithDivider(l10n.amountPaid, "TZS ${formatCurrency(amountPaid)}"),
                            _buildSummaryRowWithDivider(l10n.outstandingBalance, "TZS ${formatCurrency(loanBalance)}"),
                            _buildSummaryRowWithDivider(l10n.loanMeeting, loanMeeting),
                            _buildSummaryRowWithDivider(l10n.loanDuration, loanDuration),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      color: Color.fromARGB(255, 4, 34, 207),
                      buttonText: l10n.doneButton,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WadaiwaMikopoPage(
                              mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                        print('Button Pressed');
                      },
                      type: ButtonType.elevated,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  /// Helper method to format currency
  String formatCurrency(String amount) {
    try {
      final value = double.tryParse(amount) ?? 0.0;
      return value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]},');
    } catch (e) {
      return amount; // Return original if parsing fails
    }
  }

  /// Helper method to build summary rows with a divider
  Widget _buildSummaryRowWithDivider(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
