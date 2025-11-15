import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/DifferentAmountFundModel.dart';
import 'package:chomoka/view/group_setup/fund_information/add_mifuko.dart';
import 'package:chomoka/view/group_setup/fund_information/list_mifuko.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class mifukominginesummary extends StatefulWidget {
  final int? recordId;
  final bool isUpdateMode;
  var mzungukoId;

  mifukominginesummary({
    super.key,
    this.recordId,
    this.isUpdateMode = false,
    this.mzungukoId,
  });

  @override
  State<mifukominginesummary> createState() => _mifukominginesummaryState();
}

class _mifukominginesummaryState extends State<mifukominginesummary> {
  double _totalContributions = 0;
  MifukoMingineModel? _record;
  bool _isLoading = true;
  List<Map<String, dynamic>> _userContributions = [];

  @override
  void initState() {
    super.initState();
    _loadRecord();
  }

  Future<void> _loadRecord() async {
    if (widget.recordId != null) {
      try {
        MifukoMingineModel model = MifukoMingineModel();
        MifukoMingineModel? result = await model
            .where('id', '=', widget.recordId)
            .first() as MifukoMingineModel?;

        // Fetch contributions if type is 'Kiwango chochote'
        if (result?.utoajiType == 'Kiwango chochote') {
          final differentAmountModel = DifferentAmountFundModel();
          final contributions = await differentAmountModel
              .where('mfukoId', '=', widget.recordId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .find();

          double total = 0;
          for (var contribution in contributions) {
            total += (contribution.toMap()['amount'] as num?)?.toDouble() ?? 0;
          }
          _totalContributions = total;
        }

        // Fetch user contributions
        _userContributions = await _fetchUserContributions();

        setState(() {
          _record = result;
          _isLoading = false;
        });
      } catch (e) {
        print('Error loading record: $e');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildContributionsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12), // Reduced bottom margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Reduced padding from 20 to 16
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8), // Reduced padding from 10 to 8
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 4, 34, 207).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Color.fromARGB(255, 4, 34, 207),
                    size: 20, // Reduced size from 24 to 20
                  ),
                ),
                SizedBox(width: 10), // Reduced width from 12 to 10
                Text(
                  "Jumla ya Michango",
                  style: TextStyle(
                    fontSize: 16, // Reduced font size from 18 to 16
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 34, 207),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12), // Reduced height from 16 to 12
            Text(
              "${Provider.of<CurrencyProvider>(context).currencyCode} ${_totalContributions.toInt()}",
              style: TextStyle(
                fontSize: 24, // Reduced font size from 28 to 24
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add this method to fetch user contributions
  Future<List<Map<String, dynamic>>> _fetchUserContributions() async {
    try {
      final differentAmountModel = DifferentAmountFundModel();
      final contributions = await differentAmountModel
          .where('mfukoId', '=', widget.recordId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      // Get all members
      final membersModel = GroupMembersModel();
      final members = await membersModel.find();

      // Create a map of member IDs to names
      Map<int, String> memberNames = {};
      for (var member in members) {
        var map = member.toMap();
        memberNames[map['id'] as int] = map['name'] as String? ?? 'Unknown';
      }

      // Map contributions with member names
      return contributions.map((contribution) {
        var map = contribution.toMap();
        return {
          'name': memberNames[map['userId']] ?? 'Unknown',
          'amount': (map['amount'] as num?)?.toDouble() ?? 0.0,
          'userId': map['userId'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching user contributions: $e');
      return [];
    }
  }

  String _safeGetField(String? value) {
    return value ?? 'N/A';
  }

  String _localizeFundGoal(String? goal, AppLocalizations l10n) {
    if (goal == null || goal.isEmpty) return l10n.haijulikani;
    switch (goal) {
      case 'Elimu':
        return l10n.education;
      case 'Kilimo':
        return l10n.agriculture;
      case 'Mradi jamii':
        return l10n.communityProject;
      case 'Cocoa':
        return l10n.cocoa;
      default:
        return goal; // Return custom goal as-is
    }
  }

  String _localizeLoanable(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return 'No';
    if (value == 'Zinakopesheka') return 'Yes';
    return value;
  }

  void _showDeleteConfirmation() {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  localizations.deleteFundTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _record?.mfukoName ?? localizations.thisFund,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  localizations.deleteFundWarning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                        ),
                        child: Text(
                          localizations.cancel,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _deleteMfuko();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          localizations.delete,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteMfuko() async {
    if (_record?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo, mfuko hauwezi kufutwa')),
      );
      return;
    }

    try {
      final model = MifukoMingineModel();
      final rowsDeleted = await model.where('id', '=', _record!.id).delete();

      if (rowsDeleted > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mfuko umefutwa kikamilifu')),
        );

        // Navigate back to the list page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => mifukoList(
                    mzungukoId: widget.mzungukoId,
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mfuko haukufutwa')),
        );
      }
    } catch (e) {
      print('Error deleting mfuko: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hitilafu imetokea wakati wa kufuta: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: localizations.fundInfoTitle,
        subtitle: localizations.fundSummarySubtitle,
        icon: Icons.delete,
        onIconPressed: _showDeleteConfirmation,
        showBackArrow: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Main Fund Information Card
                    CustomCard(
                      titleText: localizations.fundInfoTitle,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => addMifuko(
                                recordId: _record!.id,
                                mzungukoId: widget.mzungukoId),
                          ),
                        ).then((_) {
                          _loadRecord();
                        });
                      },
                      items: [
                        {
                          'description': localizations.fundName,
                          'value': _safeGetField(_record!.mfukoName)
                        },
                        {
                          'description': localizations.amount,
                          'value': (_record!.mfukoAmount == null || _record!.mfukoAmount!.trim().isEmpty)
                              ? localizations.anyAmount
                              : '${Provider.of<CurrencyProvider>(context).currencyCode} ${(double.tryParse(_record!.mfukoAmount!.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt()}'
                        },
                        {
                          'description': localizations.fundGoals,
                          'value': _localizeFundGoal(_record!.goal, localizations)
                        },
                        {
                          'description': localizations.withdrawalType,
                          'value': _safeGetField(_record!.utoajiType)
                        },
                        {
                          'description': localizations.withdrawalProcedure,
                          'value': _safeGetField(_record!.utaratibuKutoa)
                        },
                        {
                          'description': localizations.loanable,
                          'value': _localizeLoanable(_record!.unakopesheka, localizations)
                        },
                      ],
                    ),

                    SizedBox(height: 16),

                    // Contributions Summary Card
                    // if (_record?.utoajiType == 'Kiwango chochote')
                    //   CustomCard(
                    //     titleText: localizations.totalContributions,
                    //     items: [
                    //       {
                    //         'description': localizations.amountContributed,
                    //         'value': 'TZS ${_totalContributions.toStringAsFixed(0)}'
                    //       },
                    //     ],
                    //   ),

                    // SizedBox(height: 16),

                    // Member Contributions Card
                    // if (_userContributions.isNotEmpty)
                    //   CustomCard(
                    //     titleText: localizations.memberContributions,
                    //     items: _userContributions.map((contribution) {
                    //       return {
                    //         'description': contribution['name'] as String,
                    //         'value': 'TZS ${(contribution['amount'] as double).toInt()}'
                    //       };
                    //     }).toList(),
                    //   ),

                    SizedBox(height: 24),

                    // Complete Button
                    Container(
                      height: 56,
                      child: CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: localizations.completed,
                        onPressed: () async {
                          if (_record?.id != null) {
                            try {
                              final mfukoModel = MifukoMingineModel();
                              await mfukoModel
                                  .where('id', '=', _record!.id)
                                  .update({'status': 'hai'});

                              print("Status updated to 'hai'");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mifukoList(
                                          mzungukoId: widget.mzungukoId,
                                        )),
                              );
                            } catch (e) {
                              print("Error updating status: $e");
                            }
                          } else {
                            print("No record ID found, cannot update status.");
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
