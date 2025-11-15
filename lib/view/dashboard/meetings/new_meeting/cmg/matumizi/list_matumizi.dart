import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/matumzi_chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart'; // Add this import
import 'package:chomoka/model/KatibaModel.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MatumiziSummaryPage extends StatefulWidget {
  final int meetingId;
  var mzungukoId;

  MatumiziSummaryPage({Key? key, required this.meetingId, this.mzungukoId})
      : super(key: key);

  @override
  _MatumiziSummaryPageState createState() => _MatumiziSummaryPageState();
}

class _MatumiziSummaryPageState extends State<MatumiziSummaryPage> {
  double _totalAmount = 0.0;
  List<Map<String, dynamic>> _matumiziDetails = [];
  bool isLoading = true;
  String _groupType = ''; // Add this property

  @override
  void initState() {
    super.initState();
    _checkGroupType().then((_) {
      _fetchTotalMatumizi();
    });
  }

  // Add this method to check the group type
  Future<void> _checkGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', widget.mzungukoId)
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

  Future<void> _fetchTotalMatumizi() async {
    try {
      final matumiziModel = MatumiziModel();

      final results = await matumiziModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results.fold(0.0, (sum, record) {
          final recordMap = record;
          return sum + (recordMap['amount'] as double? ?? 0.0);
        });

        setState(() {
          _totalAmount = total;
          _matumiziDetails = results;
          isLoading = false;
        });
      } else {
        setState(() {
          _totalAmount = 0.0;
          _matumiziDetails = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching total Matumizi: $e');
      setState(() {
        _totalAmount = 0.0;
        _matumiziDetails = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.expenseSummary,
        subtitle: l10n.totalAmountSpent,
        icon: Icons.add,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatumiziChaguaMfuko(
                  meetingId: widget.meetingId, mzungukoId: widget.mzungukoId),
            ),
          );
        },
        showBackArrow: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            l10n.totalExpenses,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TZS ${_totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _matumiziDetails.isEmpty
                        ? Center(
                            child: Text(
                              l10n.noExpensesRecorded,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _matumiziDetails.length,
                            itemBuilder: (context, index) {
                              final matumizi = _matumiziDetails[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    l10n.expenseLabel(matumizi['matumizi'] ?? l10n.unknown),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.expenseType(matumizi['matumiziCategory'] ?? l10n.unknown),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        l10n.amountLabel(matumizi['amount']?.toStringAsFixed(0) ?? '0'),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        l10n.fundLabel(matumizi['mfukoType'] ?? l10n.unknown),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.done,
                    onPressed: () {
                      // Navigate based on group type
                      if (_groupType.toLowerCase() == 'vsla') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VslaMeetingDashboard(
                              meetingId: widget.meetingId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
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
