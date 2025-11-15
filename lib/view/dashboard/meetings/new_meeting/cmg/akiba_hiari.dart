import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/ToaAkibaHiari.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:flutter/services.dart';
import '../../../../../../widget/widget.dart';
import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class AkibaHiariPage extends StatefulWidget {
  final int? meetingId;
  final int? mzungukoId;
  final bool isFromMeetingSummary;

  AkibaHiariPage(
      {Key? key,
      this.meetingId,
      this.mzungukoId,
      this.isFromMeetingSummary = false})
      : super(key: key);

  @override
  _AkibaHiariPageState createState() => _AkibaHiariPageState();
}

class _AkibaHiariPageState extends State<AkibaHiariPage> {
  List<Map<String, dynamic>> _users = [];
  bool isLoading = true;

  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final attendanceModel = AttendanceModel();
      final yupoAttendances = await attendanceModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('attendance_status', '=', 'Yupo')
          .find();

      if (yupoAttendances.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna wanachama waliopo.')),
        );
        setState(() {
          _users = [];
          isLoading = false;
        });
        return;
      }

      List<int> yupoUserIds = yupoAttendances
          .map((attendance) => attendance.toMap()['user_id'])
          .where((id) => id != null)
          .cast<int>()
          .toList();

      final usersModel = GroupMembersModel();
      List<Map<String, dynamic>> yupoUsers = [];

      for (int id in yupoUserIds) {
        final user = await usersModel.where('id', '=', id).first();
        if (user != null) {
          yupoUsers.add(user.toMap());
        }
      }

      final akibaHiariModel = AkibaHiari();
      final existingContributions = await akibaHiariModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      // Map contributions, handling null values safely
      Map<int, int> contributionsMap = {
        for (var contribution in existingContributions)
          (contribution.toMap()['user_id'] as int?) ?? 0:
              (contribution.toMap()['amount'] as int?) ??
                  0, // Default to 0 if null
      };

      setState(() {
        _users = yupoUsers.map((user) {
          int userId = (user['id'] as int?) ?? 0;

          _controllers[userId] = TextEditingController(
            text: (contributionsMap[userId] == 0)
                ? ''
                : contributionsMap[userId]?.toString() ?? '',
          );

          return {
            "name": user['name'] ?? "Jina lisiloelezwa",
            "phone": user['phone'] ?? "Simu isiyoelezwa",
            "amount": contributionsMap[userId] ?? 0,
            "userId": userId,
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _users = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Kuna tatizo la kupakia data. Tafadhali jaribu tena.')),
      );
    }
  }

  int _calculateTotalContributions() {
    return _users.fold(0, (sum, user) => sum + (user["amount"] as int? ?? 0));
  }

  Future<void> _updateOrCreateTotal() async {
    try {
      int totalContributions = _calculateTotalContributions();

      final akibaHiariModel = AkibaHiari();

      final existingRecord = await akibaHiariModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .first();

      if (existingRecord != null) {
        await akibaHiariModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'total': totalContributions});
      } else {
        AkibaHiari newRecord = AkibaHiari(
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          amount: totalContributions,
        );
        await newRecord.create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jumla ya Akiba Hiari imehifadhiwa vizuri!')),
      );
    } catch (e) {
      print('Error updating or creating total: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna tatizo la kuhifadhi Jumla.')),
      );
    }
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_users.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hakuna data ya kuhifadhi.')),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      final akibaHiariModel = AkibaHiari();
      final toaAkibaHiariModel = ToaAkibaHiariModel();
      List<String> failedSaves = [];

      for (var user in _users) {
        int? userId = user["userId"] as int?;
        int amount = user["amount"] as int? ?? 0;

        if (_controllers[userId]?.text.isEmpty ?? true) {
          amount = 0;
        }

        if (userId == null) {
          continue;
        }

        AkibaHiari akibaHiari = AkibaHiari(
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          userId: userId,
          amount: amount,
        );

        try {
          final existingRecord = await akibaHiariModel
              .where('user_id', '=', userId)
              .where('meeting_id', '=', widget.meetingId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .first();

          if (existingRecord != null) {
            await akibaHiariModel
                .where('user_id', '=', userId)
                .where('meeting_id', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .update({'amount': amount});
          } else {
            await akibaHiari.create();
          }

          final existingToaRecord = await toaAkibaHiariModel
              .where('user_id', '=', userId)
              .where('meeting_id', '=', widget.meetingId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .first();

          if (existingToaRecord != null) {
            await toaAkibaHiariModel
                .where('user_id', '=', userId)
                .where('meeting_id', '=', widget.meetingId)
                .where('mzungukoId', '=', widget.mzungukoId)
                .update({'available_amount': amount.toDouble()});
          } else {
            final newToaAkibaHiari = ToaAkibaHiariModel(
              userId: userId,
              meetingId: widget.meetingId,
              mzungukoId: widget.mzungukoId,
              availableAmount: amount.toDouble(),
            );
            await newToaAkibaHiari.create();
          }
        } catch (e) {
          failedSaves.add(user["name"] ?? "Jina lisiloelezwa");
        }
      }

      if (failedSaves.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Akiba ya Hiari imehifadhiwa vizuri!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Imekuwepo matatizo kuhifadhi akiba kwa: ${failedSaves.join(", ")}.',
            ),
          ),
        );
      }

      await _fetchData();
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.'),
        ),
      );
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
        mzungukoId: widget.mzungukoId,
        meeting_step: 'akiba_hiari',
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

  // Future<void> printAllData() async {
  //   try {
  //     final akibaHiariModel = ToaAkibaHiariModel();
  //     final records = await akibaHiariModel.select(); // Pata rekodi zote

  //     if (records.isNotEmpty) {
  //       for (var record in records) {
  //         print(record); // Chapisha kila rekodi
  //       }
  //     } else {
  //       print("Hakuna rekodi zilizopo kwenye ToaAkibaHiariModel.");
  //     }
  //   } catch (e) {
  //     print('Error fetching all data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Akiba ya Hiari',
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
                                  "Jumla ya Akiba Hiari:",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formatCurrency(_calculateTotalContributions(), Provider.of<CurrencyProvider>(context).currencyCode),
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
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            int userId = user["userId"] as int;

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user["name"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Namba ya mwanachama: ${user["phone"]}",
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
                                                    LengthLimitingTextInputFormatter(
                                                        10),
                                                  ],
                                                  controller:
                                                      _controllers[userId],
                                                  decoration: InputDecoration(
                                                    hintText: user["amount"] ==
                                                            0
                                                        ? "Weka kiasi"
                                                        : "Ingiza kiasi", // Show "Weka kiasi" if amount is 0
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.0,
                                                            horizontal: 16.0),
                                                  ),
                                                  onChanged: (value) async {
                                                    int newValue = value.isEmpty
                                                        ? 0
                                                        : int.tryParse(value) ??
                                                            0;

                                                    setState(() {
                                                      user["amount"] = newValue;
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
                          if (widget.isFromMeetingSummary) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MuhtasariWaKikaoPage(
                                        meetingId: widget.meetingId,
                                        mzungukoId: widget.mzungukoId,
                                      )),
                            );
                          } else {
                            await _updateStatusToCompleted();
                            await _saveData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      meetingpage(meetingId: widget.meetingId)),
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
