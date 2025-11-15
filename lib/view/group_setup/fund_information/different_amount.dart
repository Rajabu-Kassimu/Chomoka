

import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/view/group_setup/fund_information/mifukoMingineSummary.dart';
import 'package:flutter/services.dart';
import 'package:chomoka/model/DifferentAmountFundModel.dart';

class DifferentAmount extends StatefulWidget {
  final int? recordId;
  final dynamic mzungukoId;

  const DifferentAmount({
    super.key,
    this.recordId,
    this.mzungukoId,
  });

  @override
  State<DifferentAmount> createState() => _DifferentAmountState();
}

class _DifferentAmountState extends State<DifferentAmount> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _members = [];
  bool isLoading = true;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchMembers() async {
    try {
      setState(() {
        isLoading = true;
      });

      final membersModel = GroupMembersModel();
      final members = await membersModel.find();

      // Fetch existing contributions
      final differentAmountModel = DifferentAmountFundModel();
      final existingContributions = await differentAmountModel
          .where('mfukoId', '=', widget.recordId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      // Map contributions
      Map<int, double> contributionsMap = {
        for (var contribution in existingContributions)
          (contribution.toMap()['userId'] as int?) ?? 0:
              (contribution.toMap()['amount'] as double?) ?? 0,
      };

      setState(() {
        _members = members.map((member) {
          final memberMap = member.toMap();
          int userId = memberMap['id'] as int;

          _controllers[userId] = TextEditingController(
            text: (contributionsMap[userId] == 0)
                ? ''
                : contributionsMap[userId]?.toString() ?? '',
          );

          return {
            "name": memberMap['name'] ?? "Jina lisiloelezwa",
            "memberNumber": memberMap['memberNumber'] ?? "Namba haijulikani",
            "amount": contributionsMap[userId] ?? 0,
            "userId": userId,
          };
        }).toList();

        isLoading = false;
      });
    } catch (e) {
      print('Error fetching members: $e');
      setState(() {
        _members = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.')),
      );
    }
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_members.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna data ya kuhifadhi.')),
        );
        return;
      }

      final differentAmountModel = DifferentAmountFundModel();
      List<String> failedSaves = [];

      for (var member in _members) {
        int? userId = member["userId"] as int?;
        double amount = (member["amount"] as num?)?.toDouble() ?? 0;

        if (_controllers[userId]?.text.isEmpty ?? true) {
          amount = 0;
        }

        if (userId == null) continue;

        try {
          // Check for existing record
          final existingRecord = await differentAmountModel
              .where('userId', '=', userId)
              .where('mfukoId', '=', widget.recordId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .first();

          if (existingRecord != null) {
            // Update existing record
            await differentAmountModel
                .where('userId', '=', userId)
                .where('mfukoId', '=', widget.recordId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .update({'amount': amount});
          } else {
            // Create new record
            final newRecord = DifferentAmountFundModel(
              userId: userId,
              mfukoId: widget.recordId,
              mzungukoId: widget.mzungukoId,
              amount: amount,
            );
            await newRecord.create();
          }
        } catch (e) {
          failedSaves.add(member["name"] ?? "Jina lisiloelezwa");
          print('Error saving for member: $e');
        }
      }

      if (failedSaves.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Taarifa zimehifadhiwa vizuri!')),
        );

        // Calculate total contributions
        double totalContributions = _calculateTotalContributions();

        // Navigate to summary with additional data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => mifukominginesummary(
              recordId: widget.recordId,
              mzungukoId: widget.mzungukoId,
              isUpdateMode: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Imekuwepo matatizo kuhifadhi kwa: ${failedSaves.join(", ")}.',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  double _calculateTotalContributions() {
    double total = 0;
    for (var member in _members) {
      if (member["amount"] != null) {
        total += double.tryParse(member["amount"].toString()) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taarifa za Mifuko',
        subtitle: 'Viwango Tofauti vya Michango',
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _members.isEmpty
                ? Center(child: Text('Hakuna wanachama.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jumla ya Michango:",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "TZS ${_calculateTotalContributions()}",
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
                          itemCount: _members.length,
                          itemBuilder: (context, index) {
                            final member = _members[index];
                            int userId = member["userId"] as int;

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
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
                                            member["name"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Namba ya mwanachama: ${member["memberNumber"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                "Kiasi:",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: TextField(
                                                  controller: _controllers[userId],
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                    LengthLimitingTextInputFormatter(10),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: "Ingiza kiasi",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      member["amount"] = value.isEmpty ? 0 : int.tryParse(value) ?? 0;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
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
                        buttonText: 'Endelea',
                        onPressed: _saveData,  // Direct call to _saveData instead of form validation
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
      ),
    );
  }
}
