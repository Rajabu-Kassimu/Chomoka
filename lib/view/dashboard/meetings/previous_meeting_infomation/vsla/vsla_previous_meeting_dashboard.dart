import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/akiba_binafsi/akiba_binafsl.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/akiba_wanachama/akiba_wanachama.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/jumla_kikundi/jumla_za_kikundi.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/mchango_haujalipwa/mchango_haujalipwa.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/muhtasari_vikao_vilivyopita.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/wadaiwa_mikopo/wadaiwa_mikopo.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/jumla_kikundi/vsla_jumla_za_kikundi.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/member_share.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/vsla/vsla_privious_meeting_sumary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class VslaPreviosusMeetingDashboard extends StatefulWidget {
  var meetingId;
  var mzungukoId;
  VslaPreviosusMeetingDashboard({super.key, this.meetingId, this.mzungukoId});

  @override
  State<VslaPreviosusMeetingDashboard> createState() =>
      _VslaPreviosusMeetingDashboardState();
}

class _VslaPreviosusMeetingDashboardState
    extends State<VslaPreviosusMeetingDashboard> {
  bool isJumlaKikundiComplete = false;
  bool isAkibaHiariceComplete = false;
  bool isMchangoHaujalipwaComplete = false;
  bool isWadaiwamkopoComplete = false;
  bool isAkibaBinafsiComplete = false;

  Future<void> _checkJumlaKikundiStatus() async {
    try {
      final initSetupModel = KikaoKilichopitaModel();

      final data = await initSetupModel
          .where('meeting_step', '=', 'jumla_kikundi')
          .where('value', '=', 'complete')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (data != null && data is KikaoKilichopitaModel) {
        setState(() {
          isJumlaKikundiComplete = true;
        });
      } else {
        setState(() {
          isJumlaKikundiComplete = false;
        });
        print('No matching data found for mzungukoId: ${widget.mzungukoId}.');
      }
    } catch (e) {
      print('Error fetching Jumla Kikundi status: $e');
    }
  }

  Future<void> _checkAkibaHiariStatus() async {
    try {
      final initSetupModel = KikaoKilichopitaModel();

      final data = await initSetupModel
          .where('meeting_step', '=', 'akiba_hiari_last')
          .where('value', '=', 'complete')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (data != null && data is KikaoKilichopitaModel) {
        setState(() {
          isAkibaHiariceComplete = true;
        });
      } else {
        setState(() {
          isAkibaHiariceComplete = false;
        });
        print('No matching data found for mzungukoId: ${widget.mzungukoId}.');
      }
    } catch (e) {
      print('Error fetching Akiba Hiari status: $e');
    }
  }

  Future<void> _checkMchangoHaujalipwaStatus() async {
    try {
      final initSetupModel = KikaoKilichopitaModel();

      final data = await initSetupModel
          .where('meeting_step', '=', 'mchango_haujalipwa')
          .where('value', '=', 'complete')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (data != null && data is KikaoKilichopitaModel) {
        setState(() {
          isMchangoHaujalipwaComplete = true;
        });
      } else {
        setState(() {
          isMchangoHaujalipwaComplete = false;
        });
        print('No matching data found for mzungukoId: ${widget.mzungukoId}.');
      }
    } catch (e) {
      print('Error fetching Mchango Haujalipwa status: $e');
    }
  }

  Future<void> _checkWadaiwaMikopoStatus() async {
    try {
      final initSetupModel = KikaoKilichopitaModel();

      final data = await initSetupModel
          .where('meeting_step', '=', 'wadaiwa_mikopo')
          .where('value', '=', 'complete')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (data != null && data is KikaoKilichopitaModel) {
        setState(() {
          isWadaiwamkopoComplete = true;
        });
      } else {
        setState(() {
          isWadaiwamkopoComplete = false;
        });
        print('No matching data found for mzungukoId: ${widget.mzungukoId}.');
      }
    } catch (e) {
      print('Error fetching Wadaiwa Mikopo status: $e');
    }
  }

  Future<void> _checkAkibaBinafsiStatus() async {
    try {
      final initSetupModel = KikaoKilichopitaModel();

      final data = await initSetupModel
          .where('meeting_step', '=', 'akiba_binafsi')
          .where('value', '=', 'complete')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (data != null && data is KikaoKilichopitaModel) {
        setState(() {
          isAkibaBinafsiComplete = true;
        });
      } else {
        setState(() {
          isAkibaBinafsiComplete = false;
        });
        print('No matching data found for mzungukoId: ${widget.mzungukoId}.');
      }
    } catch (e) {
      print('Error fetching Akiba Binafsi status: $e');
    }
  }

  Future<void> _fetchData() async {
    await _checkJumlaKikundiStatus();
    await _checkAkibaHiariStatus();
    await _checkMchangoHaujalipwaStatus();
    await _checkWadaiwaMikopoStatus();
    await _checkAkibaBinafsiStatus();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.uwekajiTaarifaKatikaMzunguko,
        showBackArrow: false,
      ),
      body: Container(
        child: ListView(
          children: [
            ListTiles(
              tileColor: isJumlaKikundiComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.group, color: const Color.fromARGB(255, 0, 0, 0)),
              title: AppLocalizations.of(context)!.jumlaYaKikundi,
              mark: isJumlaKikundiComplete
                  ? AppLocalizations.of(context)!.completed
                  : AppLocalizations.of(context)!.pending,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VslaJumlaZaKikundi(mzungukoId: widget.mzungukoId)),
                );
              },
            ),
            ListTiles(
              tileColor: isAkibaHiariceComplete || !isJumlaKikundiComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.check_box,
                  color: Color.fromARGB(144, 12, 36, 252)),
              title: AppLocalizations.of(context)!.hisaZaWanachama,
              mark: isAkibaHiariceComplete
                  ? AppLocalizations.of(context)!.completed
                  : AppLocalizations.of(context)!.pending,
              onTap: () {
                if (isJumlaKikundiComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MemberShare(mzungukoId: widget.mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isMchangoHaujalipwaComplete || !isAkibaHiariceComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.bolt, color: Color.fromARGB(255, 228, 13, 13)),
              title: AppLocalizations.of(context)!.mchangoHaujalipwa,
              mark: isMchangoHaujalipwaComplete
                  ? AppLocalizations.of(context)!.completed
                  : AppLocalizations.of(context)!.pending,
              onTap: () {
                if (isJumlaKikundiComplete && isAkibaHiariceComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MchangoHaujalipwaPage(
                            mzungukoId: widget.mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: isWadaiwamkopoComplete || !isMchangoHaujalipwaComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.label_important_outline_sharp,
                  color: Color.fromARGB(255, 255, 231, 11)),
              title: AppLocalizations.of(context)!.wadaiwaMikopo,
              mark: isWadaiwamkopoComplete
                  ? AppLocalizations.of(context)!.completed
                  : AppLocalizations.of(context)!.pending,
              onTap: () {
                if (isJumlaKikundiComplete &&
                    isAkibaHiariceComplete &&
                    isMchangoHaujalipwaComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WadaiwaMikopoPage(mzungukoId: widget.mzungukoId)),
                  );
              },
            ),
            ListTiles(
              tileColor: !isMchangoHaujalipwaComplete || !isWadaiwamkopoComplete
                  ? Colors.white
                  : const Color.fromARGB(255, 243, 188, 7),
              icon: Icon(Icons.personal_video_sharp,
                  color: Color.fromARGB(255, 221, 2, 250)),
              title: AppLocalizations.of(context)!.muhtasari,
              mark: AppLocalizations.of(context)!.pending,
              onTap: () {
                if (isJumlaKikundiComplete &&
                    isAkibaHiariceComplete &&
                    isMchangoHaujalipwaComplete &&
                    isWadaiwamkopoComplete)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VslaPreviousMeetingSummary(
                              meetingId: widget.meetingId,
                              mzungukoId: widget.mzungukoId,
                            )),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
