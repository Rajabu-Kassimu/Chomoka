import 'package:chomoka/view/group_setup/term_condition.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class PermissionsPage extends StatefulWidget {
  var data_id;
  PermissionsPage({super.key, this.data_id});
  
  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  @override
  void initState() {
    super.initState();
    _requestPermissions(); // Request permissions when the page starts
  }

  // Function to request permissions
  Future<void> _requestPermissions() async {
    // Request SMS, Call, and Location permissions
    var smsStatus = await Permission.sms.request();
    var callStatus = await Permission.phone.request();
    var locationStatus = await Permission.location.request();
    var cameraStatus = await Permission.camera.request();

    // You can check the status of each permission here if needed
    if (smsStatus.isGranted &&
        callStatus.isGranted &&
        cameraStatus.isGranted &&
        locationStatus.isGranted) {
      print('All permissions granted');
    } else {
      print('Some permissions are not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.permissions,
        showBackArrow: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.permissions,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.permissionsDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.permissionsRequest,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),

                      _buildPermissionRow(
                        icon: Icons.sms,
                        title: AppLocalizations.of(context)!.smsPermission,
                        description: AppLocalizations.of(context)!.smsDescription,
                      ),
                      SizedBox(height: 16),
                      _buildPermissionRow(
                        icon: Icons.location_on,
                        title: AppLocalizations.of(context)!.locationPermission,
                        description: AppLocalizations.of(context)!.locationDescription,
                      ),
                      SizedBox(height: 16),
                      _buildPermissionRow(
                        icon: Icons.camera_alt,
                        title: AppLocalizations.of(context)!.mediaPermission,
                        description: AppLocalizations.of(context)!.mediaDescription,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!.continueText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage(
                        data_id: widget.data_id,
                      ),
                    ),
                  );
                },
                type: ButtonType.elevated,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildPermissionRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: Colors.blueAccent),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
