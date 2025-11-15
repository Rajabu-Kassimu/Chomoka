import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgao_kikundi_summary.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/vsla/vsla_mgao_kikundi_summary.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/cmg/mgao_mwanachama.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/vsla/vsla_mgao_mwanachama.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MgaoPage extends StatefulWidget {
  var mzungukoId;
  MgaoPage({Key? key, this.mzungukoId}) : super(key: key);
  @override
  State<MgaoPage> createState() => _MgaoPageState();
}

class _MgaoPageState extends State<MgaoPage> {
  bool _hasActiveMeeting = false;
  bool _hasAnyMeeting = false;
  bool isLoading = true;
  bool _isVSLA = false;

  @override
  void initState() {
    super.initState();
    _checkGroupType().then((_) {
      _checkActiveMeeting();
    });
  }

  // Add method to check if the group is VSLA
  Future<void> _checkGroupType() async {
    try {
      await BaseModel.initAppDatabase();
      final katibaModel = KatibaModel();

      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _isVSLA = groupTypeData.value == 'VSLA';
        });
        print('Group type: ${_isVSLA ? "VSLA" : "CMG"}');
      }
    } catch (e) {
      print('Error checking group type: $e');
    }
  }

  Future<void> _checkActiveMeeting() async {
    setState(() {
      isLoading = true;
    });

    try {
      await BaseModel.initAppDatabase();
      MeetingModel model = MeetingModel();

      final activeMeeting = await model
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'active')
          .findOne();
      final anyMeeting =
          await model.where('mzungukoId', '=', widget.mzungukoId).findOne();

      setState(() {
        _hasActiveMeeting = activeMeeting != null;
        _hasAnyMeeting = anyMeeting == null;
        isLoading = false;
      });
    } catch (e) {
      print('Error checking meetings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMeetingDialog() {
    final l10n = AppLocalizations.of(context)!;
    if (_hasAnyMeeting) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  l10n.noMeeting,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          content: Text(
            l10n.noMeetingDesc,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                l10n.continueText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_hasActiveMeeting) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  l10n.meetingInProgress,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          content: Text(
            l10n.meetingInProgressDesc,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                l10n.continueText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _handleKikundiAction() async {
    if (isLoading) return;

    _showMeetingDialog();
    if (_hasActiveMeeting == false && _hasAnyMeeting == false) {
      if (_isVSLA) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaMgaoWaKikundiPage(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MgaoWaKikundiPage(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
    }
  }

  void _handleWanachamaAction() async {
    if (isLoading) return;

    _showMeetingDialog();
    if (_hasActiveMeeting == false && _hasAnyMeeting == false) {
      // Navigate to the appropriate page based on group type
      if (_isVSLA) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VslaMgaoWanachamaPage(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MgaoWanachamaPage(
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.shareout,
        subtitle: l10n.chooseShareoutType,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildOptionCard(
                    icon: Icons.group,
                    iconColor: Colors.green,
                    title: l10n.groupShareout,
                    description: l10n.groupShareoutDesc,
                    buttonText: l10n.group,
                    buttonColor: Colors.green,
                    onPressed: _handleKikundiAction,
                  ),
                  SizedBox(height: 20),
                  _buildOptionCard(
                    icon: Icons.person,
                    iconColor: Colors.blue,
                    title: l10n.memberShareout,
                    description: l10n.memberShareoutDesc,
                    buttonText: l10n.member,
                    buttonColor: Colors.blue,
                    onPressed: _handleWanachamaAction,
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => dashboard(
                              mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.home),
                      label: Text(
                        l10n.returnToHome,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 34, 207),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        minimumSize: Size(300, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: iconColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  minimumSize: Size(250, 45),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
