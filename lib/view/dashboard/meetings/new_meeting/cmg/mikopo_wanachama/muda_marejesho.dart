import 'package:chomoka/model/ToaMkopoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/mkopo_referee.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class mudaMarejesho extends StatefulWidget {
  var userId;
  var meetingId;
  var loanAmount;
  var mzungukoId;

  mudaMarejesho(
      {this.meetingId, this.userId, this.loanAmount, this.mzungukoId});

  @override
  _mudaMarejeshoState createState() => _mudaMarejeshoState();
}

class _mudaMarejeshoState extends State<mudaMarejesho> {
  String? selectedOption;
  final TextEditingController _customMonthsController = TextEditingController();
  bool isLoading = true;

  Future<void> _fetchSavedRepaymentTime() async {
    try {
      final repaymentModel = ToaMkopoModel();

      final existingRecord = await repaymentModel
          .where('userId', '=', widget.userId['id'])
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingRecord != null) {
        final savedMonths = (existingRecord as ToaMkopoModel).mkopoTime ?? '';
        setState(() {
          selectedOption = ["1", "2", "3", "6"].contains(savedMonths)
              ? savedMonths
              : "Nyingine";

          if (selectedOption == "Nyingine") {
            _customMonthsController.text = savedMonths;
          }
        });
      }
    } catch (e) {
      print("Error fetching repayment time: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveRepaymentTime(int months) async {
    try {
      final repaymentModel = ToaMkopoModel();

      final existingRecord = await repaymentModel
          .where('userId', '=', widget.userId['id'])
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (existingRecord != null) {
        // Update existing record
        await repaymentModel
            .where('id', '=', (existingRecord as ToaMkopoModel).id)
            .update({'mkopoTime': months.toString()});
        print("Updated repayment time: $months months");
      } else {
        // Create a new record
        await ToaMkopoModel(
          userId: widget.userId['id'],
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          mkopoTime: months.toString(),
        ).create();
        print("Created new repayment record: $months months");
      }

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WadhaminiPage(
                userId: widget.userId,
                meetingId: widget.meetingId,
                mzungukoId: widget.mzungukoId)),
      );
    } catch (e) {
      print("Error saving repayment time: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedRepaymentTime();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mkopo,
        subtitle: l10n.muda_wa_marejesho,
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
                                  "${widget.userId['name']}",
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
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  l10n.memberPhone(widget.userId['phone'] ?? 0),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  l10n.kiasi_cha_mkopo_wake_ni(
                                      formatCurrency(widget.loanAmount, Provider.of<CurrencyProvider>(context).currencyCode)),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
                  // Question Text
                  Text(
                    l10n.mkopo_wa_miezi_mingapi,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        RadioListTile(
                          title: Text(l10n.mwezi_1),
                          value: "1",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              _customMonthsController.clear();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(l10n.miezi_2),
                          value: "2",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              _customMonthsController.clear();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(l10n.miezi_3),
                          value: "3",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              _customMonthsController.clear();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(l10n.miezi_6),
                          value: "6",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              _customMonthsController.clear();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(l10n.nyingine),
                          value: "Nyingine",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                            });
                          },
                        ),
                        if (selectedOption == "Nyingine")
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: _customMonthsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: l10n.ingiza_miezi,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    color: Color.fromARGB(255, 4, 34, 207),
                    buttonText: l10n.thibitisha_muda,
                    onPressed: () async {
                      if (selectedOption == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.tafadhali_chagua_muda)),
                        );
                        return;
                      }

                      if (selectedOption == "Nyingine" &&
                          (_customMonthsController.text.isEmpty ||
                              int.tryParse(_customMonthsController.text) ==
                                  null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(l10n.tafadhali_ingiza_muda_sahihi)),
                        );
                        return;
                      }

                      final selectedMonths = selectedOption == "Nyingine"
                          ? int.parse(_customMonthsController.text)
                          : int.parse(selectedOption!);

                      await _saveRepaymentTime(selectedMonths);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        l10n.muda_wa_marejesho_umehifadhiwa(selectedMonths),
                      )));
                      print('Repayment Time Saved: $selectedMonths months');
                    },
                    type: ButtonType.elevated,
                  ),
                ],
              ),
            ),
    );
  }
}
