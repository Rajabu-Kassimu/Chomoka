import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MatumiziModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/piga_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/attendance.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/list_matumizi.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/matumizi/matumzi_chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/mikopo_wanachama/toa_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/toa_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uchangiaji_mfuko_jamii.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/chagua_mfuko.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/uwekaji_mkupuo/list_uchangaji.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/pre_buy_share.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/share_summary.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaMeetingDashboard extends StatefulWidget {
  var meetingId;
  var groupId;
  var meetingNumber;
  VslaMeetingDashboard(
      {super.key, this.meetingId, this.groupId, this.meetingNumber});

  @override
  State<VslaMeetingDashboard> createState() => _VslaMeetingDashboardState();
}

class _VslaMeetingDashboardState extends State<VslaMeetingDashboard> {
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
  Map<int, String> _mifukoStatusMap = {};

  Future<void> _fetchMfukoStatus(int? mfukoId) async {
    if (mfukoId == null) return;

    try {
      final setupModel = MeetingSetupModel();
      final data = await setupModel
          .where('meetingId', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .where('meeting_step', '=', 'mfuko_${mfukoId}')
          .where('value', '=', 'complete')
          .findOne();

      setState(() {
        _mifukoStatusMap[mfukoId] = (data != null) ? 'completed' : 'pending';
      });
    } catch (e) {
      print('Error fetching mfuko status: $e');
      _mifukoStatusMap[mfukoId] = 'pending';
    }
  }

  String _getMfukoStatus(int? mfukoId) {
    if (mfukoId == null) return 'pending';
    return _mifukoStatusMap[mfukoId] ?? 'pending';
  }

  // Add this method to navigate to the appropriate mfuko page
  void _navigateToMfukoPage(BuildContext context, MifukoMingineModel mfuko) {
    if (mfuko.utoajiType == 'Kiwango sawa') {
    } else {
      // For other types, you can add navigation to different pages
      // For now, show a message that this feature is not implemented
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Aina ya mfuko "${mfuko.utoajiType}" haijatekelezwa bado.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
            isToaAkibaHiariComplete = true;
          });
        }

        return isNdiyoRuhusu;
      } else {
        print('No data found for the specified conditions.');
        setState(() {
          _akibaHiariStatus = false;
          isToaAkibaHiariComplete = true;
        });
        return false;
      }
    } catch (e) {
      print('Error fetching saved data: $e');
      setState(() {
        _akibaHiariStatus = false;
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

  Future<void> _navigateToSharePage(BuildContext context) async {
    try {
      final memberShareModel = MemberShareModel();
      final existingShares = await memberShareModel
          .where('meeting_id', '=', widget.meetingId)
          .where('mzungukoId', '=', mzungukoId)
          .find();

      if (existingShares.isNotEmpty) {
        // If shares exist, navigate to ShareSummary
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShareSummary(
              meetingId: widget.meetingId,
              mzungukoId: mzungukoId,
            ),
          ),
        );
      } else {
        // If no shares exist, navigate to PreBuyShare
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreBuyShare(
              meetingId: widget.meetingId,
              mzungukoId: mzungukoId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error checking share status: $e');
      // Default to PreBuyShare if there's an error
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreBuyShare(
            meetingId: widget.meetingId,
            mzungukoId: mzungukoId,
          ),
        ),
      );
    }
  }

  List<MifukoMingineModel> _mifukoMingineList = [];

  Future<void> _fetchAndPrintMifukoMingine() async {
    try {
      if (mzungukoId == null) {
        await _fetchMzungukoId();
      }

      final model = MifukoMingineModel();
      List<dynamic> results =
          await model.where('mzungukoId', '=', mzungukoId).find();

      print('===== MIFUKO MINGINE DATA =====');
      if (results.isEmpty) {
        print('No mifuko mingine found for mzungukoId: $mzungukoId');
      } else {
        print('Found ${results.length} mifuko mingine records:');
        List<MifukoMingineModel> mifukoList = [];
        for (var mfuko in results) {
          if (mfuko is MifukoMingineModel) {
            mifukoList.add(mfuko);
            print('ID: ${mfuko.id}');
            print('Name: ${mfuko.mfukoName}');
            print('Goal: ${mfuko.goal}');
            print('Status: ${mfuko.status}');
            print('Amount: ${mfuko.mfukoAmount}');
            print('Utoaji Type: ${mfuko.utoajiType}');
            print('Utaratibu Kutoa: ${mfuko.utaratibuKutoa}');
            print('Unakopesheka: ${mfuko.unakopesheka}');
            print('------------------------');
          }
        }
        setState(() {
          _mifukoMingineList = mifukoList;
        });

        // Fetch status for each mfuko
        for (var mfuko in _mifukoMingineList) {
          if (mfuko.id != null) {
            await _fetchMfukoStatus(mfuko.id);
          }
        }
      }
    } catch (e) {
      print('Error fetching and printing mifuko mingine: $e');
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
      await _checkChangiaMfukoJamiiStatus();
      await fetchAKibaHiariStatus();
      await _fetchAndPrintMifukoMingine();
    } catch (e) {
      print('Error during initialization: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeStatuses();
  }

  // Add this method to check if all mifuko mingine are complete
  bool _areAllMifukoComplete() {
    // If there are no mifuko mingine, return true (all are complete by default)
    if (_mifukoMingineList.isEmpty) return true;

    // Check if all mifuko have completed status
    for (var mfuko in _mifukoMingineList) {
      if (_getMfukoStatus(mfuko.id) != 'completed') {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool allMifukoComplete = _areAllMifukoComplete();
    final l10n = AppLocalizations.of(context)!;

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
              title: l10n.groupAttendance,
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
              title: l10n.contributeMfukoJamii,
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
              title: l10n.contributeMfukoJamii,
              mark: isAkibaLazimaComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete && isChangiaMfukoJamiiComplete)
                  _navigateToSharePage(context);
              },
            ),

            // Dynamic ListTiles for Mifuko Mingine
            ..._mifukoMingineList
                .map((mfuko) => ListTiles(
                      tileColor: _getMfukoStatus(mfuko.id) == 'completed' ||
                              !isChangiaMfukoJamiiComplete
                          ? Colors.white
                          : const Color.fromARGB(255, 243, 188, 7),
                      icon: Icon(Icons.account_balance_wallet,
                          color: Color.fromARGB(144, 12, 36, 252)),
                      title: 'Changia ${mfuko.mfukoName}',
                      mark: _getMfukoStatus(mfuko.id),
                      onTap: () {
                        if (isAttendanceComplete && isChangiaMfukoJamiiComplete)
                          _navigateToMfukoPage(context, mfuko);
                      },
                    ))
                .toList(),

            ListTiles(
              tileColor: isRejeshaMkopoComplete ||
                      !isAkibaLazimaComplete ||
                      !allMifukoComplete ||
                      !allMifukoComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon:
                  Icon(Icons.upload, color: const Color.fromARGB(255, 0, 0, 0)),
              title: l10n.repayLoan,
              mark: isRejeshaMkopoComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isChangiaMfukoJamiiComplete &&
                    allMifukoComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RejeshaMkopoPage(
                        meetingId: widget.meetingId,
                        mzungukoId: mzungukoId,
                        // fromDashboard: true,
                        // isFromMgaowakikundi: true,
                      ),
                    ),
                  );
              },
            ),
            ListTiles(
              tileColor: isLipaFainiComplete ||
                      !isRejeshaMkopoComplete ||
                      !allMifukoComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.personal_video_sharp,
                  color: Color.fromARGB(255, 221, 2, 250)),
              title: l10n.payFine,
              mark: isLipaFainiComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isChangiaMfukoJamiiComplete &&
                    allMifukoComplete &&
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
              title: l10n.groupAttendance,
              mark: isToaMfukoJamiiComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isChangiaMfukoJamiiComplete &&
                    allMifukoComplete &&
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
              title: l10n.addFineType,
              mark: isToaMkopoComplete ? 'completed' : 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isChangiaMfukoJamiiComplete &&
                    allMifukoComplete &&
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
            ListTiles(
              tileColor: isToaAkibaHiariComplete && isToaMkopoComplete
                  ? const Color.fromARGB(255, 243, 188, 7)
                  : Colors.white,
              icon: Icon(Icons.lock, color: Color.fromARGB(255, 2, 194, 50)),
              title: l10n.meetingSummary,
              mark: 'pending',
              onTap: () {
                if (isAttendanceComplete &&
                    isAkibaLazimaComplete &&
                    isChangiaMfukoJamiiComplete &&
                    allMifukoComplete &&
                    isRejeshaMkopoComplete &&
                    isLipaFainiComplete &&
                    isToaMfukoJamiiComplete &&
                    isToaMkopoComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VslaMeetingSummaryPage(
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
