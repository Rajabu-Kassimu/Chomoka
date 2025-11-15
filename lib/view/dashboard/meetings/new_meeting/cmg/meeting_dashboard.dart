import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/piga_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/akiba_hiari.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/akiba_lazima.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/attendance.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/list_matumizi.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/matumzi_chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_summary.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/miamala_iliyopunguzwa/miamala_iliyopunguzwa_dashbord.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/toa_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_akiba_hiari/toa_akiba_hiari.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/toa_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uchangiaji_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/list_uchangaji.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';

class meetingpage extends StatefulWidget {
  var meetingId;
  var groupId;
  var meetingNumber;
  meetingpage({super.key, this.meetingId, this.groupId, this.meetingNumber});

  @override
  State<meetingpage> createState() => _meetingpageState();
}

class _meetingpageState extends State<meetingpage> {
  bool isAttendanceComplete = false;
  bool isAkibaLazimaComplete = false;
  bool isAkibaHiariComplete = false;
  bool isChangiaMfukoJamiiComplete = false;
  bool isRejeshaMkopoComplete = false;
  bool isLipaFainiComplete = false;
  bool isToaMfukoJamiiComplete = false;
  bool isToaMkopoComplete = false;
  bool isToaAkibaHiariComplete = false;
  bool _akibaHiariStatus = false;
  int? mzungukoId;
  int? meetingNumber;

  Future<void> _checkAttendanceStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'attendance')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isAttendanceComplete = true;
        });
      } else {
        setState(() {
          isAttendanceComplete = false;
        });
        print('No matching data found for meetingId: ${widget.meetingId}.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkAkibaLazimaStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'akiba_lazima')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isAkibaLazimaComplete = true;
        });
      } else {
        setState(() {
          isAkibaLazimaComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkAkibaHiariStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'akiba_hiari')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isAkibaHiariComplete = true;
        });
      } else {
        setState(() {
          isAkibaHiariComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkChangiaMfukoJamiiStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'changia_mfuko_jamii')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isChangiaMfukoJamiiComplete = true;
        });
      } else {
        setState(() {
          isChangiaMfukoJamiiComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkRejeshaMkopoStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'rejesha_mkopo')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isRejeshaMkopoComplete = true;
        });
      } else {
        setState(() {
          isRejeshaMkopoComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkLipaFainiStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'lipa_faini')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isLipaFainiComplete = true;
        });
      } else {
        setState(() {
          isLipaFainiComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkToaMfukoJamiiStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'toa_mfuko_jamii')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isToaMfukoJamiiComplete = true;
        });
      } else {
        setState(() {
          isToaMfukoJamiiComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkToaMkopoStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'toa_mkopo')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isToaMkopoComplete = true;
        });
      } else {
        setState(() {
          isToaMkopoComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _checkToaAkibaHiariStatus() async {
    try {
      final initSetupModel = MeetingSetupModel();

      final data = await initSetupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'toa_akiba_hiari')
          .where('value', '=', 'complete')
          .findOne();

      if (data != null && data is MeetingSetupModel) {
        setState(() {
          isToaAkibaHiariComplete = true;
        });
      } else {
        setState(() {
          isToaAkibaHiariComplete = false;
        });
        print('No matching data found in InitSetupModel.');
      }
    } catch (e) {
      print('Error fetching member info status: $e');
    }
  }

  Future<void> _navigateToAppropriatePage(BuildContext context) async {
    final uwekajiKwaMkupuoModel = UwekajiKwaMkupuoModel();
    final existingContributions =
        await uwekajiKwaMkupuoModel.where('mzungukoId', '=', mzungukoId).find();

    if (existingContributions.isNotEmpty) {
      // Navigate to MichangoListPage if contributions exist
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MichangoListPage(
            meetingId: widget.meetingId,
            mzungukoId: mzungukoId,
            onSelectContribution: (selectedContribution) {
              // Handle the selected contribution if necessar
              print('Selected Contribution: ${selectedContribution.toMap()}');
            },
          ),
        ),
      );
    } else {
      // Navigate to UwekajiKwaMkupuoPage if no contributions exist
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UwekajiKwaMkupuoPage(
            meetingId: widget.meetingId,
            mzungukoId: mzungukoId,
          ),
        ),
      );
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '=', 'active').findOne();
    final int? fetchedMzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        mzungukoId =
            fetchedMzungukoId; // Update the state with the fetched mzungukoId
      });
    }
  }

  Future<void> _navigateToMatumiziPage(BuildContext context) async {
    final matumiziModel = MatumiziModel();
    final existingMatumizi = await matumiziModel
        .where('meetingId', '=', widget.meetingId)
        .where('mzungukoId', '=', mzungukoId)
        .find();

    if (existingMatumizi.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatumiziSummaryPage(
            meetingId: widget.meetingId,
            mzungukoId: mzungukoId,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatumiziChaguaMfuko(
            meetingId: widget.meetingId,
            mzungukoId: mzungukoId,
          ),
        ),
      );
    }
  }

  Future<bool> fetchAKibaHiariStatus() async {
    try {
      final katiba = KatibaModel();
      final akibaHiariData = await katiba
          .where('katiba_key', '=', 'akiba_hiari')
          .where('mzungukoId', '=', mzungukoId)
          .findOne();

      if (akibaHiariData != null && akibaHiariData is KatibaModel) {
        String fetchedValue = akibaHiariData.value?.toString() ?? '';
        print('Fetched data: $fetchedValue'); // Print the fetched data

        bool isNdiyoRuhusu = fetchedValue == "Ndiyo ruhusu";

        setState(() {
          _akibaHiariStatus = isNdiyoRuhusu;
        });

        // Check if fetchedValue is not "Ndiyo ruhusu"
        if (fetchedValue != "Ndiyo ruhusu") {
          setState(() {
            isAkibaHiariComplete = true;
            isToaAkibaHiariComplete = true;
          });
        }

        return isNdiyoRuhusu;
      } else {
        print('No data found for the specified conditions.');
        setState(() {
          _akibaHiariStatus = false;
          isAkibaHiariComplete = true;
          isToaAkibaHiariComplete = true;
        });
        return false;
      }
    } catch (e) {
      print('Error fetching saved data: $e');
      setState(() {
        _akibaHiariStatus = false;
        isAkibaHiariComplete = true;
        isToaAkibaHiariComplete = true;
      });
      return false;
    }
  }

  Future<void> _fetchNextMeetingNumber() async {
    try {
      final model = MeetingModel();
      // Fetch all meetings with the matching conditions
      final allMeetings = await model
          .where('mzungukoId', '=', mzungukoId)
          .where('status', '=', 'active')
          .find();

      if (allMeetings.isNotEmpty) {
        int? nextMeetingCount = (allMeetings.first as MeetingModel).number;

        setState(() {
          meetingNumber = nextMeetingCount;
        });

        print('Fetched meeting number: $nextMeetingCount');
      } else {
        print('No active meetings found');
      }
    } catch (e) {
      print('Error fetching next meeting number: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching meeting number: $e')),
      );
    }
  }

  Future<void> _initializeStatuses() async {
    await _fetchMzungukoId();
    try {
      await _fetchNextMeetingNumber();
      await _checkAttendanceStatus();
      await _checkAkibaLazimaStatus();
      await _checkToaAkibaHiariStatus();
      await _checkLipaFainiStatus();
      await _checkRejeshaMkopoStatus();
      await _checkToaMkopoStatus();
      await _checkToaMfukoJamiiStatus();
      await _checkAkibaHiariStatus();
      await _checkChangiaMfukoJamiiStatus();
      await fetchAKibaHiariStatus();
    } catch (e) {
      print('Error during initialization: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kikao cha ${meetingNumber}',
        showBackArrow: false,
        icon: isAttendanceComplete ? Icons.local_police_outlined : null,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PigaFainiPage(
                      meetingId: widget.meetingId,
                      mzungukoId: mzungukoId,
                    )),
          );
        },
        additionalActions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              switch (value) {
                case 'mkupuo':
                  _navigateToAppropriatePage(context);
                  break;
                case 'edit':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => miamalailiyopunguzwadashboard(
                              // meetingId: widget.meetingId,
                              mzungukoId: mzungukoId,
                            )),
                  );
                  break;
                case 'matumizi':
                  _navigateToMatumiziPage(context);
                  break;
                case 'Logout':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged out')),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'mkupuo',
                  child: Row(
                    children: [
                      Icon(Icons.data_exploration_sharp,
                          color: const Color.fromARGB(255, 255, 0, 0)),
                      SizedBox(width: 10),
                      Text('Uwekaji kwa mkupuo'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit,
                          color: const Color.fromARGB(255, 33, 150, 243)),
                      SizedBox(width: 10),
                      Text('Hariri kikao'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'matumizi',
                  child: Row(
                    children: [
                      Icon(Icons.badge,
                          color: const Color.fromARGB(255, 1, 136, 13)),
                      SizedBox(width: 10),
                      Text('Weka taarifa za matumizi'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            ListTiles(
              tileColor: isAttendanceComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.group,
                  color: const Color.fromARGB(255, 100, 96, 96)),
              title: 'Kagua mahudhurio',
              mark: isAttendanceComplete ? 'completed' : 'pending',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendancePage(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId,
                          )),
                );
              },
            ),
            ListTiles(
              tileColor: isChangiaMfukoJamiiComplete || !isAttendanceComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.label_important_outline_sharp,
                  color: Color.fromARGB(255, 255, 231, 11)),
              title: 'Changia mfuko wa jamii',
              mark: isChangiaMfukoJamiiComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UchangiajifukoJamiiPage(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isAkibaLazimaComplete || !isChangiaMfukoJamiiComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.check_box,
                  color: Color.fromARGB(144, 12, 36, 252)),
              title: 'Weka akiba ya Lazima',
              mark: isAkibaLazimaComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete && isChangiaMfukoJamiiComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AkibaLazimaPage(
                              meetingId: widget.meetingId,
                              mzungukoId: mzungukoId,
                            )),
                  );
              },
            ),
            if (_akibaHiariStatus)
              ListTiles(
                tileColor: isAkibaHiariComplete || !isAkibaLazimaComplete
                    ? Colors.white
                    : const Color.fromARGB(255, 243, 188, 7),
                icon: Icon(Icons.bolt, color: Color.fromARGB(255, 228, 13, 13)),
                title: 'Weka akiba ya hiyari',
                mark: isAkibaHiariComplete ? 'completed' : 'pending',
                onTap: () {
                  if (isAttendanceComplete && isAkibaLazimaComplete)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AkibaHiariPage(
                                meetingId: widget.meetingId,
                                mzungukoId: mzungukoId,
                              )),
                    );
                },
              ),
            ListTiles(
              tileColor: isRejeshaMkopoComplete || !isAkibaHiariComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon:
                  Icon(Icons.upload, color: const Color.fromARGB(255, 0, 0, 0)),
              title: 'Rejesha Mkopo',
              mark: isRejeshaMkopoComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isAkibaHiariComplete &&
                    isChangiaMfukoJamiiComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RejeshaMkopoPage(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isLipaFainiComplete || !isRejeshaMkopoComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.personal_video_sharp,
                  color: Color.fromARGB(255, 221, 2, 250)),
              title: 'Lipa faini',
              mark: isLipaFainiComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isAkibaHiariComplete &&
                    isChangiaMfukoJamiiComplete &&
                    isRejeshaMkopoComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LipaFainiPage(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isToaMfukoJamiiComplete || !isLipaFainiComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon:
                  Icon(Icons.download, color: Color.fromARGB(255, 24, 143, 0)),
              title: 'Toa kutoka mfuko wa jamii',
              mark: isToaMfukoJamiiComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isAkibaHiariComplete &&
                    isChangiaMfukoJamiiComplete &&
                    isRejeshaMkopoComplete &&
                    isLipaFainiComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToaMfukoJamii(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isToaMkopoComplete || !isToaMfukoJamiiComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.camera_roll_sharp,
                  color: Color.fromARGB(255, 3, 5, 15)),
              title: 'Toa Mkopo',
              mark: isToaMkopoComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isAkibaHiariComplete &&
                    isChangiaMfukoJamiiComplete &&
                    isRejeshaMkopoComplete &&
                    isLipaFainiComplete &&
                    isToaMfukoJamiiComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToaMkopoPage(
                            meetingId: widget.meetingId,
                            mzungukoId: mzungukoId)),
                  );
              },
            ),
            if (_akibaHiariStatus)
              ListTiles(
                tileColor: isToaAkibaHiariComplete || !isToaMkopoComplete
                    ? Colors.white
                    : const Color.fromARGB(255, 243, 188, 7),
                icon: Icon(Icons.drive_file_move_rounded,
                    color: Color.fromARGB(255, 5, 144, 236)),
                title: 'Toa kutoka akiba ya hiyari',
                mark: isToaAkibaHiariComplete ? 'completed' : 'pending',
                onTap: () {
                  if (isAttendanceComplete &&
                      isAkibaLazimaComplete &&
                      isAkibaHiariComplete &&
                      isChangiaMfukoJamiiComplete &&
                      isRejeshaMkopoComplete &&
                      isLipaFainiComplete &&
                      isToaMfukoJamiiComplete &&
                      isToaMkopoComplete)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ToaAkibaHiariPage(
                              meetingId: widget.meetingId,
                              mzungukoId: mzungukoId)),
                    );
                },
              ),
            ListTiles(
              tileColor: isToaAkibaHiariComplete && isToaMkopoComplete
                  ? const Color.fromARGB(255, 243, 188, 7)
                  : Colors.white,
              icon: Icon(Icons.lock, color: Color.fromARGB(255, 2, 194, 50)),
              title: 'Muhtasari wa Kikao',
              mark: 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isAkibaHiariComplete &&
                    isChangiaMfukoJamiiComplete &&
                    isRejeshaMkopoComplete &&
                    isLipaFainiComplete &&
                    isToaMfukoJamiiComplete &&
                    isToaMkopoComplete &&
                    isToaAkibaHiariComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MuhtasariWaKikaoPage(
                            meetingId: widget.meetingId,
                            groupId: widget.groupId,
                            mzungukoId: mzungukoId,
                            meetingNumber: meetingNumber)),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
