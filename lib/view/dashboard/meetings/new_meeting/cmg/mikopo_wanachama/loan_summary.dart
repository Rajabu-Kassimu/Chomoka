import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/toa_mkopo.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class LoanSummaryPage extends StatefulWidget {
  final Map<String, dynamic> userId;
  final int meetingId;
  var mzungukoId;
  final bool noRefferee;

  LoanSummaryPage({
    required this.userId,
    required this.meetingId,
    this.mzungukoId,
    this.noRefferee = false,
  });

  @override
  _LoanSummaryPageState createState() => _LoanSummaryPageState();
}

class _LoanSummaryPageState extends State<LoanSummaryPage> {
  bool isLoading = true;
  double loanAmount = 0;
  int _interestRate = 0;
  int _punishment = 0;
  String reason = '';
  String repaymentPeriod = '';
  String referees = '';
  String interestType = '';
  String repayAmount = '';
  List<Map<String, dynamic>> refereeDetails = [];
  String errorMessage = '';
  int repaymentMonths = 0;

  @override
  void initState() {
    super.initState();
    _fetchLoanDetails();
  }

  Future<void> _fetchLoanDetails() async {
    try {
      final katibaModel = KatibaModel();

      final interest = await katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (interest == null) {
        print('Loan multiplier not found in Katiba. Data: $interest');
        setState(() => isLoading = false);
        return;
      }

      final interestTypeData = await katibaModel
          .where('katiba_key', '=', 'interest_type')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (interestTypeData != null && interestTypeData is KatibaModel) {
        interestType = interestTypeData.value ?? '';
      }

      final interestValue = interest.toMap()['value'];
      print('Fetched interest rate value: $interestValue');

      _interestRate = int.tryParse(interestValue?.toString() ?? '0') ?? 0;

      if (_interestRate == 0) {
        print(
            'Interest rate parsed as 0. Check the database for correct value.');
      }

      final asilimiaData = await katibaModel
          .where('katiba_key', '=', 'asilimia')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      final kiasiData = await katibaModel
          .where('katiba_key', '=', 'kiasi_maalumu')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      final punishmentData = await katibaModel
          .where('katiba_key', '=', 'interest_rate')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (punishmentData == null) {
        print('Punishment data not found in Katiba.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final punishmentValue = punishmentData.toMap()['value'];
      print('Fetched punishment rate value: $punishmentValue');

      _punishment = int.tryParse(punishmentValue?.toString() ?? '0') ?? 0;

      if (_punishment == 0) {
        print(
            'Punishment rate parsed as 0. Check the database for correct value.');
      }

      final toaMkopoModel = ToaMkopoModel()
        ..where('userId', '=', widget.userId['id'])
        ..where('meetingId', '=', widget.meetingId)
        ..where('mzungukoId', '=', widget.mzungukoId);

      final savedLoan = await toaMkopoModel.first();

      if (savedLoan != null) {
        final loan = savedLoan as ToaMkopoModel;

        setState(() {
          loanAmount = loan.loanAmount ?? 0;
          reason = loan.sababuKukopa ?? 'Sababu haijafafanuliwa';
          referees = loan.referees ?? '';
          repayAmount = loan.repayAmount != null
              ? loan.repayAmount!.toStringAsFixed(0)
              : '';
          repaymentPeriod = loan.mkopoTime ?? '';
        });

        int repaymentMonths = 0;
        try {
          print('Raw repaymentPeriod: "$repaymentPeriod"');

          repaymentMonths =
              int.tryParse(repaymentPeriod.replaceAll(RegExp(r'[^0-9]'), '')) ??
                  0;

          if (repaymentMonths == 0) {
            print(
                'Repayment period not valid. Using default value of 1 month.');
            repaymentMonths = 1;
          }
        } catch (e) {
          print('Error parsing repayment period: $e');
          repaymentMonths = 1;
        }

        final DateTime now = DateTime.now();
        final DateTime endDate = now.add(Duration(days: repaymentMonths * 30));
        final String formattedEndDate =
            DateFormat('yyyy-MM-dd').format(endDate);

        print('Repayment Period (Months): $repaymentMonths');
        print('End Date: $formattedEndDate');

        final refereeIds = referees
            .split(',')
            .where((id) => id.isNotEmpty)
            .map((id) => int.tryParse(id) ?? 0)
            .toList();

        final groupMemberModel = GroupMembersModel();
        final allMembers = await groupMemberModel.find();

        setState(() {
          refereeDetails = allMembers
              .where((member) => refereeIds.contains(member.toMap()['id']))
              .map((member) => member.toMap())
              .toList();
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Tatizo katika kupakia data za mkopo.';
      });
      print('Error fetching loan details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print(widget.noRefferee);
    final DateTime now = DateTime.now();
    int repaymentMonths = 0;
    try {
      repaymentMonths =
          int.parse(repaymentPeriod.replaceAll(RegExp(r'[^0-9]'), ''));
    } catch (e) {
      print("Error parsing repayment period: $e");
    }

    final DateTime endDate =
        now.add(Duration(days: repaymentMonths * 30)); // Approximation

    final String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);

    print('Repayment Period (Months): $repaymentMonths');
    print('End Date: $formattedEndDate');

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.muhtasari_wa_mkopo,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUserDetailsCard(),
                  SizedBox(height: 20),
                  buildLoanDetailsSection(formattedEndDate),
                  SizedBox(height: 20),
                  buildLoanReasonSection(),
                  SizedBox(height: 20),
                  widget.noRefferee == false
                      ? buildRefereeSection()
                      : SizedBox(),
                  SizedBox(height: 20),
                  CustomButton(
                    color: Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.thibitisha_mkopo,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ToaMkopoPage(
                            meetingId: widget.meetingId,
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildUserDetailsCard() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 35, color: Colors.white),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userId['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    l10n.memberNumberLabel(widget.userId['memberNumber']),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    l10n.memberPhone(widget.userId['phone'] ?? 0),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoanDetailsSection(String formattedEndDate) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.maelezo_ya_mkopo,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF041ECF),
          ),
        ),
        SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLoanDetailRow(l10n.kiasi_cha_mkopo,
                    formatCurrency(loanAmount, Provider.of<CurrencyProvider>(context).currencyCode)),
                Divider(),
                buildLoanDetailRow(
                    l10n.riba_ya_mkopo, "${_interestRate.toStringAsFixed(0)}%"),
                Divider(),
                buildLoanDetailRow(l10n.maelezo_ya_riba, "${interestType}"),
                Divider(),
                buildLoanDetailRow(l10n.salio_la_mkopo, formatCurrency(double.tryParse(repayAmount) ?? 0, Provider.of<CurrencyProvider>(context).currencyCode)),
                Divider(),
                buildLoanDetailRow(
                    l10n.muda_wa_marejesho, l10n.miezi(repaymentPeriod)),
                Divider(),
                buildLoanDetailRow(l10n.tarehe_ya_mwisho, formattedEndDate),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoanDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildLoanReasonSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sababu_ya_kutoa_mkopo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF041ECF),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 500,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                reason.isNotEmpty ? reason : "Sababu haijafafanuliwa",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRefereeSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.wadhamini,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF041ECF),
          ),
        ),
        SizedBox(height: 10),
        ...refereeDetails.map(
          (referee) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: Colors.black26,
            child: ListTile(
              title: Text(
                referee['name'] ?? 'Unknown',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
