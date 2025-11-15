import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/maliza_mgao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgao_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class VslaMgawanyoMwanachama extends StatefulWidget {
  final int? mzungukoId;
  final double? faida;
  final double? totalMfukoJamii;
  final bool isFromSummary;

  VslaMgawanyoMwanachama({
    super.key,
    this.mzungukoId,
    this.faida,
    this.totalMfukoJamii,
    this.isFromSummary = false,
  });

  @override
  State<VslaMgawanyoMwanachama> createState() => _VslaMgawanyoMwanachamaState();
}

class _VslaMgawanyoMwanachamaState extends State<VslaMgawanyoMwanachama> {
  List<Map<String, dynamic>> _members = [];
  bool isLoading = true;
  bool allPaid = true;
  int? _userLength;
  double _shareValue = 0.0; // Store the hisa value

  // Fetch the hisa value from katiba settings
  Future<double> _fetchShareValue() async {
    try {
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        final value = double.tryParse(shareData.value ?? '0') ?? 0.0;
        print('Share value from katiba: TZS $value');
        return value;
      }
    } catch (e) {
      print('Error fetching share value: $e');
    }
    return 0.0;
  }

  Future<void> _fetchMembers() async {
    if (_members.isNotEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Fetch share value first
      _shareValue = await _fetchShareValue();

      final groupMembersModel = GroupMembersModel();
      final savedMembers = await groupMembersModel.select();

      final userMgaoModel = UserMgaoModel();
      final allUserMgaos = await userMgaoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      Set<int> personalPaidUserIds = allUserMgaos
          .where((mgao) =>
              (mgao as UserMgaoModel).type == 'personal' &&
              (mgao as UserMgaoModel).status == 'paid')
          .map((mgao) => mgao.toMap()['userId'] as int)
          .toSet();

      Set<int> groupPaidUserIds = allUserMgaos
          .where((mgao) =>
              (mgao as UserMgaoModel).type == 'group' &&
              (mgao as UserMgaoModel).status == 'paid')
          .map((mgao) => mgao.toMap()['userId'] as int)
          .toSet();

      // Get unpaid members
      List<Map<String, dynamic>> unpaidMembers = savedMembers.where((member) {
        return !personalPaidUserIds.contains(member['id']);
      }).toList();

      // Get total members count for mfuko jamii calculation
      int totalMembersCount = unpaidMembers.length;

      // Fetch member shares
      final memberShareModel = MemberShareModel();
      final shares = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      // Create a map of userId to number of shares
      Map<int, int> userShares = {};
      int totalShares = 0;

      // Calculate total shares and map user shares
      for (var share in shares) {
        int userId = share['user_id'];
        int numberOfShares = share['number_of_shares'] ?? 0;

        // Only count shares for unpaid members
        if (unpaidMembers.any((member) => member['id'] == userId)) {
          userShares[userId] = (userShares[userId] ?? 0) + numberOfShares;
          totalShares += numberOfShares;
        }
      }

      print('Total shares: $totalShares');

      // Get mzunguko data for total mgao amount
      final mzungukoModel = MzungukoModel();
      final BaseModel? mzungukoData =
          await mzungukoModel.where('id', '=', widget.mzungukoId).findOne();

      double totalMgaoAmount = 0.0;
      double faida = 0.0;
      if (mzungukoData != null && mzungukoData is MzungukoModel) {
        totalMgaoAmount = mzungukoData.pesaYaMgao ?? 0.0;
        faida = mzungukoData.faida ?? 0.0;
      }

      // Calculate mfuko jamii per member (equal distribution)
      double mfukoJamiiPerMember =
          widget.totalMfukoJamii != null && totalMembersCount > 0
              ? widget.totalMfukoJamii! / totalMembersCount
              : 0.0;

      setState(() {
        _userLength = unpaidMembers.length;
        _members = unpaidMembers.map((member) {
          final bool isGroupPaid = groupPaidUserIds.contains(member['id']);
          final int userId = member['id'];
          final int memberShares = userShares[userId] ?? 0;

          // Calculate share percentage
          double sharePercentage =
              totalShares > 0 ? memberShares / totalShares : 0.0;

          // Calculate faida portion based on shares
          double faidaPortion = faida * sharePercentage;

          // Calculate share value (hisa value * number of shares)
          double shareValueTotal = _shareValue * memberShares;

          // Calculate total mgao amount for this member (including share value)
          double memberMgaoAmount =
              faidaPortion + mfukoJamiiPerMember + shareValueTotal;

          print(
              'Member $userId has $memberShares shares (${(sharePercentage * 100).toStringAsFixed(2)}%)');
          print('Share value: TZS ${shareValueTotal.toStringAsFixed(0)}');
          print(
              'Faida portion: ${faidaPortion.toStringAsFixed(0)}, Mfuko Jamii: ${mfukoJamiiPerMember.toStringAsFixed(0)}');
          print('Total mgao amount: ${memberMgaoAmount.toStringAsFixed(0)}');

          return {
            ...member,
            'shares': memberShares,
            'sharePercentage': sharePercentage,
            'shareValue': shareValueTotal,
            'faidaPortion': faidaPortion,
            'mfukoJamiiPortion': mfukoJamiiPerMember,
            'mgaoAmount': memberMgaoAmount,
            'status': isGroupPaid ? 'paid' : 'unpaid',
            'type': isGroupPaid ? 'group' : 'personal',
          };
        }).toList();

        // Check if all members are paid
        allPaid = _members.every((member) => member['status'] == 'paid');
        isLoading = false;
      });

      print('Unpaid members count: ${_members.length}');
      print('Total shares: $totalShares');
      print('Faida to distribute: ${faida.toStringAsFixed(0)}');
      print(
          'Mfuko Jamii to distribute: ${(widget.totalMfukoJamii ?? 0).toStringAsFixed(0)}');
    } catch (e) {
      print('Error fetching members and shares: $e');
      setState(() {
        _members = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    print('Mgao amount per member: TZS ${widget.faida}');
    print('Total mgao jamii: TZS ${widget.totalMfukoJamii}');
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberShareDistributionTitle,
        subtitle: l10n.selectMember,
        showBackArrow: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: _members.isEmpty
                        ? Center(
                            child: Text(l10n.noMembersInGroup))
                        : ListView.builder(
                            itemCount: _members.length,
                            itemBuilder: (context, index) {
                              final member = _members[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VslaMgaoSummary(
                                          mzungukoId: widget.mzungukoId,
                                          member: member,
                                          userLength: _userLength,
                                          mgaoKiasi:
                                              member['mgaoAmount'] ?? 0.0,
                                          mfukoJamii:
                                              member['mfukoJamiiPortion'] ??
                                                  0.0),
                                    ),
                                  );
                                },
                                child: CustomMemberCard(
                                  memberNumber: member['memberNumber'] ?? '',
                                  name: member['name'] ?? '',
                                  mgaoAmount: member['mgaoAmount'] ?? 0.0,
                                  shares: member['shares'] ?? 0,
                                  sharePercentage:
                                      member['sharePercentage'] ?? 0.0,
                                  shareValue: member['shareValue'] ?? 0.0,
                                  faidaPortion: member['faidaPortion'] ?? 0.0,
                                  mfukoJamiiPortion:
                                      member['mfukoJamiiPortion'] ?? 0.0,
                                  status: member['status'],
                                ),
                              );
                            },
                          )),
                if (allPaid)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      color: const Color.fromARGB(255, 4, 34, 207),
                      buttonText: l10n.continueText,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MalizaMgao(mzungukoId: widget.mzungukoId),
                          ),
                        );
                      },
                      type: ButtonType.elevated,
                    ),
                  ),
              ],
            ),
    );
  }
}

class CustomMemberCard extends StatelessWidget {
  final String memberNumber;
  final String name;
  final double mgaoAmount;
  final int shares;
  final double sharePercentage;
  final double faidaPortion;
  final double mfukoJamiiPortion;
  final double shareValue;
  final String? status;

  CustomMemberCard({
    required this.memberNumber,
    required this.name,
    this.mgaoAmount = 0.0,
    this.shares = 0,
    this.sharePercentage = 0.0,
    this.faidaPortion = 0.0,
    this.mfukoJamiiPortion = 0.0,
    this.shareValue = 0.0,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color amountColor = (status == 'paid') ? Colors.red : Colors.green;
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Icon(Icons.person, size: 30.0, color: Colors.black),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    l10n.memberNumberLabel(memberNumber),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    l10n.totalShareAmount(shares.toString(), (sharePercentage * 100).toStringAsFixed(1)),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    l10n.shareValueAmount(formatCurrency(shareValue, currencyCode)),
                    style: TextStyle(fontSize: 14.0, color: Colors.indigo[800]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.totalDistributionAmount(formatCurrency(mgaoAmount, currencyCode)),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor,
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
}
