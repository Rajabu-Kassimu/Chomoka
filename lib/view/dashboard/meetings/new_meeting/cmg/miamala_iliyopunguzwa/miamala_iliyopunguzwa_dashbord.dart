import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';

class miamalailiyopunguzwadashboard extends StatefulWidget {
  var mzungukoId;
  miamalailiyopunguzwadashboard({super.key, this.mzungukoId});

  @override
  State<miamalailiyopunguzwadashboard> createState() =>
      _miamalailiyopunguzwadashboardState();
}

class _miamalailiyopunguzwadashboardState
    extends State<miamalailiyopunguzwadashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Miamala iliyopunguzwa',
        // subtitle: 'Kuanzisha Chomoka',
        showBackArrow: true,
        // icon: Icons.settings,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Chagua sehemu ya kurekebisha endapo umekosea kuingiza katika vikao vilivyopita'),
            ),
            ListTiles(
              icon:
                  Icon(Icons.group, color: const Color.fromARGB(255, 0, 0, 0)),
              title: 'Mfuko wa Jamii mchango',
              mark: 'pending',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => JumlaZaKikundi()),
                // );
              },
            ),
            ListTiles(
              icon: Icon(Icons.check_box,
                  color: Color.fromARGB(144, 12, 36, 252)),
              title: 'Weka Akiba Hiari',
              mark: 'pending',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AkibaWanachamaPage()),
                // );
              },
            ),
            ListTiles(
              icon: Icon(Icons.bolt, color: Color.fromARGB(255, 228, 13, 13)),
              title: 'Akiba ya lazima iliyonunuliwa',
              mark: 'pending',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => MchangoHaujalipwaPage()),
                // );
              },
            ),
            ListTiles(
              icon: Icon(Icons.label_important_outline_sharp,
                  color: Color.fromARGB(255, 255, 231, 11)),
              title: 'Faini zilizopigwa',
              mark: 'pending',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => WadaiwaMikopoPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
