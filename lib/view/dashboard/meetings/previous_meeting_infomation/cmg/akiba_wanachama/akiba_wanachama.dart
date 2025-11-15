import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AkibaWanachamaPage extends StatefulWidget {
  var mzungukoId;
  final bool isFromVikaoVilivyopitaSummary;
  AkibaWanachamaPage(
      {Key? key, this.mzungukoId, this.isFromVikaoVilivyopitaSummary = false})
      : super(key: key);

  @override
  _AkibaWanachamaPageState createState() => _AkibaWanachamaPageState();
}

class _AkibaWanachamaPageState extends State<AkibaWanachamaPage> {
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;

  final Map<int, TextEditingController> _controllers = {};
  int jumlaYaAkiba = 0;
  int totalAkiba = 0;
  String? errorMessage;
  String? successMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final vikaoModel = VikaovilivyopitaModel();
      BaseModel? jumlaData = await vikaoModel
          .where('kikao_key', '=', 'jumla_ya_akiba')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      jumlaYaAkiba = int.tryParse(
            (jumlaData as VikaovilivyopitaModel?)?.value ?? '0',
          ) ??
          0;

      final groupMemberModel = GroupMembersModel();
      List<Map<String, dynamic>> allUsers = await groupMemberModel
          .find()
          .then((users) => users.map((user) => user.toMap()).toList());

      // print("Fetched Users: $allUsers");

      final akibaLazimaModel = AkibaLazimaModel();
      List<Map<String, dynamic>> existingContributions = await akibaLazimaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .find()
          .then((contributions) =>
              contributions.map((contrib) => contrib.toMap()).toList());

      print("Fetched Contributions: $existingContributions");

      Map<int, Map<String, dynamic>> contributionsMap = {};
      for (var contrib in existingContributions) {
        final userId = contrib['user_id'] as int?;
        if (userId != null) {
          contributionsMap[userId] = contrib;
        }
      }

      setState(() {
        _users = allUsers.map((user) {
          int userId = user['id'] as int;
          final existing = contributionsMap[userId];

          int amount = (existing?['amount'] is double)
              ? (existing?['amount'] as double).toInt()
              : (existing?['amount'] ?? 0);

          _controllers[userId] =
              TextEditingController(text: amount > 0 ? amount.toString() : "");

          return {
            "name": user['name'] ?? "Jina lisiloelezwa",
            "phone": user['phone'] ?? "Simu isiyoelezwa",
            "amount": amount,
            "userId": userId,
            // "isKiakaokilchopita": (existing?['isKiakaokilchopita'] ?? 0) == 1,
          };
        }).toList();
        totalAkiba = _calculateTotalContributions();
        isLoading = false;
      });
    } catch (e, stackTrace) {
      print('Error fetching data: $e');
      print('Stack Trace: $stackTrace');
      setState(() {
        errorMessage = 'Kuna tatizo la kupakia data. Tafadhali jaribu tena.';
        _users = [];
        isLoading = false;
      });
    }
  }

  int _calculateTotalContributions() {
    return _users.fold(0, (sum, user) {
      final amount = user["amount"];
      if (amount is double) {
        return sum + amount.toInt(); // Convert to int when adding
      } else if (amount is int) {
        return sum + amount;
      } else {
        return sum;
      }
    });
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });
    try {
      if (_users.isEmpty) {
        setState(() {
          errorMessage = 'Hakuna data ya kuhifadhi.';
          isLoading = false;
        });
        return;
      }

      int enteredTotal = _calculateTotalContributions();

      if (enteredTotal != jumlaYaAkiba) {
        setState(() {
          errorMessage =
              'Jumla ya akiba inapaswa kuwa TZS $jumlaYaAkiba. Hivi sasa TZS $enteredTotal. Tafadhali rekebisha.';
          isLoading = false;
        });
        return;
      }

      final akibaLazimaModel = AkibaLazimaModel();
      List<String> failedSaves = [];

      for (var user in _users) {
        final userId = user["userId"] as int?;
        final amountText = _controllers[userId]?.text.trim() ?? '0';
        final amount = int.tryParse(amountText) ?? 0;

        if (userId == null || amount == 0) continue;

        try {
          final existing = await akibaLazimaModel
              .where('user_id', '=', userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          if (existing != null) {
            await akibaLazimaModel
                .where('user_id', '=', userId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .update({
              'amount': amount,
              // 'isKiakaokilchopita': 1,
            });
          } else {
            final newContribution = AkibaLazimaModel(
              userId: userId,
              amount: amount.toDouble(),
              mzungukoId: widget.mzungukoId, // Add mzungukoId
            );
            await newContribution.create();
          }
        } catch (e) {
          failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
        }
      }

      if (failedSaves.isEmpty) {
        setState(() {
          successMessage = 'Akiba ya Hiari imehifadhiwa vizuri!';
        });
      } else {
        setState(() {
          errorMessage =
              'Imekuwepo matatizo kuhifadhi akiba kwa: ${failedSaves.join(", ")}.';
        });
      }
      await _fetchData();
    } catch (e) {
      print('Error saving data: $e');
      setState(() {
        errorMessage = 'Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Color _determineTotalColor() {
    if (totalAkiba == jumlaYaAkiba && jumlaYaAkiba != 0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = KikaoKilichopitaModel(
        meeting_step: 'akiba_hiari_last',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taarifa katikati ya mzunguko',
        subtitle: 'Akiba ya Mwanachama',
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _users.isEmpty
                ? Center(child: Text('Hakuna wanachama waliopo.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jumla ya Akiba:",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "TZS $jumlaYaAkiba",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jumla ya Akiba ya\n Wanachama:",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "TZS $totalAkiba",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: _determineTotalColor(),
                                    ),
                                  ),
                                ],
                              ),
                              if (errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              if (successMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    successMessage!,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            final userId = user["userId"] as int;
                            final name = user["name"] as String;
                            final phone = user["phone"] as String;
                            final double amount =
                                (user["amount"] as num).toDouble();

                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Namba ya mwanachama: $phone",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                "Akiba:",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: amount == 0
                                                        ? "Weka kiasi"
                                                        : null,
                                                    border:
                                                        OutlineInputBorder(),
                                                    isDense: true,
                                                  ),
                                                  controller:
                                                      _controllers[userId],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      int parsedValue =
                                                          int.tryParse(value) ??
                                                              0;
                                                      user["amount"] =
                                                          parsedValue;
                                                      totalAkiba =
                                                          _calculateTotalContributions();
                                                      errorMessage = null;
                                                      successMessage = null;
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
                        buttonText: 'Thibitisha',
                        onPressed: () async {
                          if (totalAkiba != jumlaYaAkiba) {
                            setState(() {
                              errorMessage =
                                  'Jumla ya akiba inapaswa kuwa TZS $jumlaYaAkiba. Tafadhali rekebisha.';
                            });
                            return;
                          }
                          await _updateStatusToCompleted();
                          await _saveData();
                          if (widget.isFromVikaoVilivyopitaSummary) {
                            Navigator.pop(context);
                          } else
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => uwekajitaarifadashboard(
                                        mzungukoId: widget.mzungukoId,
                                      )),
                            );
                        },
                        type: ButtonType.elevated,
                      ),
                    ],
                  ),
      ),
    );
  }
}
