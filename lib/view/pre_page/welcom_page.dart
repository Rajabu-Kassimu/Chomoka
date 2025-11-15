import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/view/pre_page/login_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class WelcomePage extends StatefulWidget {
  var groupId;

  WelcomePage({this.groupId});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String groupName = "Loading...";
  String groupUniqueId = "Loading...";
  int? mzungukoId = 0;

  Future<void> _fetchGroupInformation() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final data = await groupInformationModel
          // .where('id', '=', widget.groupId)
          .first() as GroupInformationModel?;

      if (data != null) {
        setState(() {
          groupName = data.name ?? "Group Name Unavailable";
          groupUniqueId = data.registeredNumber ?? "Unique ID Unavailable";
        });
      }
    } catch (e) {
      print("Error fetching group information: $e");
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult = await mzungukoModel.select(limit: 1);

    final int? fetchedMzungukoId = mzungukoResult.isNotEmpty
        ? mzungukoModel.fromMap(mzungukoResult.first).id
        : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        mzungukoId = fetchedMzungukoId;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGroupInformation().then((_) {
      _fetchMzungukoId();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(mzungukoId);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.build,
                    color: const Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  // Add functionality if needed
                },
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(0, 35),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: () {},
              icon: Icon(
                Icons.directions_run,
                color: Colors.white,
              ),
              label: Text(
                AppLocalizations.of(context)!.demo,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                groupName.toUpperCase(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              // Text(
              //   groupUniqueId,
              //   style: TextStyle(fontSize: 14, color: Colors.grey),
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: 40),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/group.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "CHOMOKA",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.appVersionName,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              Text(
                AppLocalizations.of(context)!.appVersionNumber,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              children: [
                Column(
                  children: [
                    CustomButton(
                      color: Colors.green,
                      buttonText: AppLocalizations.of(context)!.open,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(
                                  groupId: widget.groupId,
                                  groupName: groupName,
                                  mzungukoId: mzungukoId)),
                        );
                      },
                      type: ButtonType.elevated,
                    ),
                    SizedBox(height: 20),
                    // CustomButton(
                    //   color: const Color.fromARGB(255, 4, 34, 207),
                    //   buttonText: 'Hifadhi Kumbukumbu',
                    //   onPressed: () {},
                    //   type: ButtonType.elevated,
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
