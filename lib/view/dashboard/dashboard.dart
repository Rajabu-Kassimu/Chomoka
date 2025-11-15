import 'dart:io';

import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/controllers/dashboard_controller.dart';
import 'package:chomoka/view/dashboard/group_activities/group_activities_dashboard.dart';
import 'package:chomoka/view/dashboard/help.dart';
import 'package:chomoka/view/dashboard/history/historia.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/taarifa_katikati_mzunguko.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgawanyo_mwanachama.dart';
import 'package:chomoka/view/dashboard/mrejesho/mrejesho_one.dart';
import 'package:chomoka/view/dashboard/uhifadhi_taarifa/uhifadhi_kumbukumbu.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/view/group_setup/group_Information/vsla/vsla_group_overview.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/group_setup/member_Information/member_list_dashboard.dart';
import 'package:chomoka/view/dashboard/matangazo.dart';
import 'package:chomoka/view/pre_page/setting.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class dashboard extends StatefulWidget {
  var groupId;
  var mzungukoId;
  final bool fromDashboard;
  final bool isFromLogin;

  dashboard({
    Key? key,
    this.groupId,
    this.mzungukoId,
    this.fromDashboard = false,
    this.isFromLogin = false,
  }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  static const Color ocColor = Color.fromARGB(255, 4, 34, 207);

  static const Color secondaryColor = Color.fromARGB(255, 255, 136, 0);
  static const Color accentColor = Color(0xFFF6F6F6);
  static const double cardElevation = 4.0;
  bool _hasActiveMeeting = false;
  bool _isLastMeetingCompleted = false;
  bool _isMzungukoCompleted = false;
  bool _isMzungukoPending = false;
  String _groupType = '';
  String groupName = '';
  int? mzungukoId = 0;

  // Future<void> _checkLastMeetingStatus() async {
  //   bool isCompleted = await isLastMeetingCompleted();

  //   if (isCompleted) {
  //     _showLastMeetingCompleteDialog(context, widget.groupId, mzungukoId);
  //   } else {
  //     _showMeetingOptions(context);
  //   }
  // }

  Future<void> _navigateToActiveMeeting() async {
    final model = MeetingModel();
    try {
      final activeMeeting =
          await model.where('status', '=', 'active').findOne();

      if (activeMeeting != null && activeMeeting is MeetingModel) {
        final int? existingMeetingId = activeMeeting.id;
        final int? meetingNumber = activeMeeting
            .number; // Fetch the meeting number from the active meeting

        if (existingMeetingId != null && meetingNumber != null) {
          if (_groupType == 'VSLA') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VslaMeetingDashboard(
                  meetingId: existingMeetingId,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => meetingpage(
                  meetingId: existingMeetingId,
                ),
              ),
            );
          }
        } else {
          print("Meeting ID or Meeting Number is null.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Error: Meeting ID or Meeting Number is missing.')),
          );
        }
      } else {
        print("No active meeting found.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No active meeting found.')),
        );
      }
    } catch (e) {
      print("Error fetching active meeting: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _checkGroupPrinciple() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        if (mounted) {
          // Check if widget is still mounted before setState
          setState(() {
            _groupType = groupTypeData.value ?? '';
          });
        }
        print('Group type: $_groupType');
      }
    } catch (e) {
      print('Error fetching group type: $e');
    }
  }

  Future<void> _fetchGroupInformation() async {
    try {
      await _checkGroupPrinciple();

      final groupInformationModel = GroupInformationModel();

      final data = await groupInformationModel
          // .where('id', '=', widget.groupId)
          .first() as GroupInformationModel?;

      if (data != null) {
        setState(() {
          groupName = data.name ?? "Group Name Unavailable";
        });
      }
    } catch (e) {
      debugPrint("Error fetching group information: $e");
    }
  }

  void _dialNumber(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  Future<void> _navigateBasedOnStatus() async {
    try {
      final mzungukoModel = MzungukoModel();
      final statusRecord =
          await mzungukoModel.where('id', '=', mzungukoId).first();

      if (_isMzungukoPending == false) {
        if (statusRecord != null) {
          final statusMap = statusRecord.toMap();
          final status = statusMap['status'];

          if (status == 'active') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MgaoPage(mzungukoId: mzungukoId!),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MgawanyoMwanachama(mzungukoId: mzungukoId!),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('No record found for mzungukoId: $mzungukoId')),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(
              data_id: widget.groupId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error fetching mzungukoStatus: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching mzunguko status')),
      );
    }
  }

  resetMeeting(nx) async {
    var model = MeetingModel();
    final meetingCount = await model
        // .where('mzungukoId', '=', nx)
        .where('id', '=', nx)
        .delete();
    print(meetingCount);
    return;
  }

  Future<void> _initDatabaseAndLoadData() async {
    try {
      // Initialize the database first
      await BaseModel.initAppDatabase();

      // Then proceed with the rest of the data loading
      dashboardControler.fetchMzungukoId().then((value) {
        setState(() {
          mzungukoId = value;
        });

        // Use the controller to check group principle
        dashboardControler.checkGroupPrinciple(mzungukoId).then((value) {
          setState(() {
            _groupType = value;
          });

          _fetchGroupInformation().then((_) {
            dashboardControler.checkActiveMeeting().then((value) {
              setState(() {
                _hasActiveMeeting = value;
              });
              dashboardControler.isLastMeetingCompleted().then((value) {
                setState(() {
                  _isLastMeetingCompleted = value;
                });
                dashboardControler.isLastMzungukoCompleted().then((value) {
                  setState(() {
                    _isMzungukoCompleted =
                        (value == 'completed') ? true : false;
                    _isMzungukoPending = (value == 'pending') ? true : false;
                  });
                });
              });
            });
          }).catchError((error) {
            debugPrint("Error in fetching group information: $error");
          });
        });
      });
    } catch (e) {
      print('Error initializing database: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to initialize database. Please try again.')),
      );
    }
  }

  DashboardController dashboardControler = DashboardController();

  @override
  void initState() {
    super.initState();
    _initDatabaseAndLoadData();
  }

  @override
  Widget build(BuildContext context) {
    print(_hasActiveMeeting);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            // Logo or app name

            // Help button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: ocColor,
                backgroundColor: Colors.white,
                elevation: 0,
                side: BorderSide(color: ocColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () => _showContactPopup(context, '+255626991088'),
              icon: Icon(Icons.help_outline, color: ocColor, size: 20),
              label: Text(
                l10n.help,
                style: TextStyle(
                  color: ocColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),
            // const SizedBox(width: 8),
            // Settings button
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: IconButton(
                icon: Icon(Icons.settings_outlined, color: Colors.grey[800]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _initDatabaseAndLoadData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section with gradient background
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ocColor.withOpacity(0.9),
                      ocColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ocColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24,
                          child: Icon(
                            Icons.groups_rounded,
                            color: ocColor,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.welcome,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                groupName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      l10n.helpDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Announcements slider with card styling
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         blurRadius: 8,
              //         offset: Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(16),
              //     child: MatangazoSlider(),
              //   ),
              // ),

              const SizedBox(height: 24),

              // Section title
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  l10n.moreServices,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              // Start Meeting Card - Prominent and eye-catching
              GestureDetector(
                onTap: () async {
                  if (_isMzungukoPending == false) {
                    if (_isMzungukoCompleted) {
                      _showMalizaMgaoDialog();
                    } else if (widget.isFromLogin) {
                      _showMeetingOptions(context);
                    } else if (_hasActiveMeeting) {
                      _navigateToActiveMeeting();
                    } else {
                      bool lastMeetingCompleted =
                          await dashboardControler.isLastMeetingCompleted();

                      if (lastMeetingCompleted) {
                        _showLastMeetingCompleteDialog(
                            context, widget.groupId, mzungukoId);
                      } else {
                        _showMeetingOptions(context);
                      }
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => homePage(
                          data_id: widget.groupId,
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF4CAF50),
                          Color(0xFF2E7D32),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.meeting_room_rounded,
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.startMeeting,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                _hasActiveMeeting
                                    ? l10n.continueMeeting
                                    : l10n.startMeeting,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Grid of services - more visually organized
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildDashboardGridItem(
                    title: l10n.group,
                    icon: Icons.groups_sharp,
                    iconColor: Colors.orange,
                    onTap: () {
                      if (_isMzungukoPending == false) {
                        if (_groupType == 'VSLA') { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VlsaGroupOverview(
                                  data_id: widget.groupId,
                                  fromDashboard: true,
                                  mzungukoId: mzungukoId),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupOverview(
                                  data_id: widget.groupId,
                                  fromDashboard: true,
                                  mzungukoId: mzungukoId),
                            ),
                          );
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => homePage(
                              data_id: widget.groupId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildDashboardGridItem(
                    title: l10n.constitution,
                    icon: Icons.menu_book_sharp,
                    iconColor: Colors.green,
                    onTap: () {
                      if (_isMzungukoPending == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConstitutionOverview(
                              groupId: widget.groupId,
                              fromDashboard: true,
                              mzungukoId: mzungukoId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => homePage(
                              data_id: widget.groupId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildDashboardGridItem(
                    title: l10n.wanachama,
                    icon: Icons.group,
                    iconColor: Colors.purple,
                    onTap: () {
                      if (_isMzungukoPending == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberListFromDashboard(
                              groupId: widget.groupId,
                              fromDashboard: true,
                              mzungukoId: mzungukoId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => homePage(
                              data_id: widget.groupId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildDashboardGridItem(
                    title: l10n.fund,
                    icon: Icons.attach_money_rounded,
                    iconColor: Colors.blue,
                    onTap: () async {
                      if (_isMzungukoPending == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MgaoPage(
                                    mzungukoId: mzungukoId,
                                  )),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => homePage(
                              data_id: widget.groupId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildDashboardGridItem(
                    title: l10n.feedback,
                    icon: Icons.message_outlined,
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackOnePage(
                                  groupId: widget.groupId,
                                )),
                      );
                    },
                  ),
                  _buildDashboardGridItem(
                    title: l10n.groupsActivities,
                    icon: Icons.work,
                    iconColor: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupBusinessDashboard(
                                  mzungukoId: mzungukoId,
                                )),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Additional services with different styling
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  l10n.serviceMore,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              // Historia card
              _buildFullWidthCard(
                title: l10n.history,
                icon: Icons.history,
                iconColor: Colors.brown,
                description: l10n.historyHints,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Backup card
              _buildFullWidthCard(
                title: l10n.sendData,
                icon: Icons.cloud_sync,
                iconColor: Colors.teal,
                description: l10n.sendDataHint,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UhifadhiKumbukumbuPage()),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Footer with version info
              Center(
                child: Text(
                  'Chomoka Plus v2.0',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullWidthCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: iconColor,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New helper method for grid items
  Widget _buildDashboardGridItem({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents overflow
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: iconColor,
                ),
              ),
              SizedBox(height: 12),
              Flexible(
                // Ensures text fits within limits
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMalizaMgaoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero), // No border radius
          insetPadding: EdgeInsets.symmetric(
              horizontal: 24, vertical: 16), // Reduce dialog height
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange), // Warning icon
              const SizedBox(width: 8),
              const Text(
                'Maliza Mgao',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Mzunguko wa mwisho umekamilika. Tafadhali maliza mgao.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MgawanyoMwanachama(
                      mzungukoId: mzungukoId,
                    ),
                  ),
                );
              },
              child: const Text(
                'Sawa',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMeetingOptions(BuildContext context) async {
    print(_isLastMeetingCompleted);
    await BaseModel.initAppDatabase();
    MeetingModel model = MeetingModel();

    try {
      final activeMeeting =
          await model.where('status', '=', 'active').findOne();
      if (activeMeeting != null && activeMeeting is MeetingModel) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => meetingpage(
        //       meetingId: activeMeeting.id!,
        //       groupId: widget.groupId,
        //     ),
        //   ),
        // );

        if (_groupType == 'VSLA') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VslaMeetingDashboard(
                meetingId: activeMeeting.id!,
                groupId: widget.groupId,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => meetingpage(
                meetingId: activeMeeting.id!,
                groupId: widget.groupId,
              ),
            ),
          );
        }
        return; // Exit to prevent creating a new meeting
      }

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            title: _isLastMeetingCompleted
                ? Text(
                    l10n.welcomeNextMeeting,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : Text(
                    l10n.midCycleReport,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
            content: _isLastMeetingCompleted
                ? Text(
                    l10n.tapToOpenMeeting,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  )
                : Text(
                    l10n.startNewCycleQuestion,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    final model = MeetingModel();

                    // Add debug print to see what we're querying
                    print("Querying for mzungukoId: $mzungukoId");

                    var prevMeeting = await model
                        .where('mzungukoId', '=', mzungukoId)
                        .latest();

                    // Add debug print to see what we got back
                    print("Previous meeting: $prevMeeting");

                    int current_meeting_no =
                        1; // Default value if no previous meeting exists

                    if (prevMeeting != null) {
                      var meetingModel = prevMeeting as MeetingModel;
                      print("Previous meeting number: ${meetingModel.number}");
                      current_meeting_no = (meetingModel.number ?? 0) + 1;
                    } else {
                      print(
                          "No previous meeting found, starting with number 1");
                    }

                    print(
                        "New meeting number for mzungukoId $mzungukoId: $current_meeting_no");

                    print("Creating new meeting for mzungukoId: $mzungukoId");

                    var myInstanceModel = MeetingModel();
                    myInstanceModel.mzungukoId = mzungukoId;
                    myInstanceModel.status = 'active';
                    myInstanceModel.date = DateTime.now().toString();
                    myInstanceModel.number = current_meeting_no;

                    final rowsInserted = await myInstanceModel.create();

                    if (rowsInserted == null) {
                      print(
                          'Failed to create a new meeting: No rows inserted.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to create a new meeting.')),
                      );
                      return;
                    }

                    print('Successfully saved Meeting Data:');
                    print('Mzunguko ID: ${myInstanceModel.mzungukoId}');
                    print('Meeting Number: ${myInstanceModel.number}');
                    print('Status: ${myInstanceModel.status}');
                    print('Date: ${myInstanceModel.date}');
                    print('NEW MEETING ID: ${rowsInserted}');

                    Navigator.pop(dialogContext);

                    if (_groupType == 'VSLA') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VslaMeetingDashboard(
                            meetingId: rowsInserted,
                            groupId: widget.groupId,
                            meetingNumber: current_meeting_no,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => meetingpage(
                            meetingId: rowsInserted,
                            groupId: widget.groupId,
                            meetingNumber: current_meeting_no,
                          ),
                        ),
                      );
                    }
                  } catch (e, stackTrace) {
                    print('Error creating a new meeting: $e');
                    print('Stack Trace: $stackTrace');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to create a new meeting: $e')),
                    );
                  }
                },
                child: !_isLastMeetingCompleted
                    ? Center(
                      child: Text(
                          l10n.tapYesToStartFirstMeeting,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    )
                    : TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          disabledForegroundColor:
                              Colors.white.withOpacity(0.38),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(double.infinity, 48),
                        ),
                        child: Text(
                          l10n.openMeeting,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
              if (!_isLastMeetingCompleted)
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaarifaKatikatiMzunguko(
                          groupId: widget.groupId,
                          mzungukoId: mzungukoId,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      l10n.tapNoToEnterPastMeetings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error checking for active meeting: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check for active meetings: $e'),
        ),
      );
    }
  }

  /// Show the contact/help popup
  void _showContactPopup(BuildContext currentContext, String phoneNumber) {
    final l10n = AppLocalizations.of(context)!;
    showGeneralDialog(
      context: currentContext,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      pageBuilder: (BuildContext dialogContext, _, __) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(dialogContext).size.width * 0.85,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(dialogContext).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with gradient
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ocColor, ocColor.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Text(
                            l10n.getHelp,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.needHelpContact,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 24),

                            // Phone option
                            _buildContactOption(
                              icon: Icons.phone,
                              title: l10n.call,
                              subtitle: phoneNumber,
                              color: Colors.green,
                              onTap: () async {
                                final Uri url = Uri.parse('tel:$phoneNumber');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                            ),

                            SizedBox(height: 16),

                            // WhatsApp option
                            _buildContactOption(
                              icon: Icons.message,
                              title: l10n.whatsapp,
                              subtitle: phoneNumber,
                              color: Colors.green.shade700,
                              onTap: () async {
                                var whatsappUrl =
                                    "whatsapp://send?phone=$phoneNumber";
                                try {
                                  if (await canLaunchUrl(
                                      Uri.parse(whatsappUrl))) {
                                    await launchUrl(Uri.parse(whatsappUrl));
                                  } else {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(l10n.whatsappNotInstalled)),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(dialogContext)
                                      .showSnackBar(
                                    SnackBar(
                                        content: Text(l10n.whatsappFailed)),
                                  );
                                }
                              },
                            ),

                            SizedBox(height: 16),

                            // Email option
                            _buildContactOption(
                              icon: Icons.email,
                              title: l10n.email,
                              subtitle: 'support@chomoka.com',
                              color: Colors.blue,
                              onTap: () async {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: 'support@chomoka.org',
                                  queryParameters: {
                                    'subject': l10n.helpEmailSubject,
                                  },
                                );

                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri);
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              color: Color.fromARGB(255, 4, 34, 207),
                              buttonText: l10n.faq,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HelpPage()),
                                );
                              },
                              type: ButtonType.elevated,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Close button
                  Padding(
                    padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        l10n.close,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneCard(
      String phoneNumber, BuildContext context, String label) {
    void _dialNumber(String phoneNumber) async {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imeshindikana kufungua simu.')),
        );
      }
    }

    return InkWell(
      onTap: () => _dialNumber(phoneNumber),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon Section
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.phone, size: 24, color: Colors.blueAccent),
              ),
              const SizedBox(width: 16),
              // Phone Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phoneNumber,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable Card widget for the dashboard menu items
class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool fullWidth;
  final VoidCallback? onTap;

  final Color iconColor;
  final Color titleColor;

  const _DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.titleColor,
    this.fullWidth = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: fullWidth ? 0 : 1,
      child: Card(
        margin: fullWidth
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 4),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 90,
            width: fullWidth ? double.infinity : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: iconColor),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildContactOption({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: color),
        ],
      ),
    ),
  );
}

void _showLastMeetingCompleteDialog(
    BuildContext context, var groupId, var mzungukoId) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      titlePadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning_amber_rounded, // Warning icon
            color: Colors.orange,
            size: 32,
          ),
          SizedBox(width: 8),
          Text(
            'Kikao kimekamilika', // Title
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: const Text(
        'Kikao kimekamilika, Anza upya mfumo wa chomoka kuanza kikao kipya.', // Message
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              exit(0);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => WelcomePage(
              //       groupId: groupId,
              //     ), // Navigate to LoginPage
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: const Text(
              'Ingia Tena', // Updated button text
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
