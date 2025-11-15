import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/syncData.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chomoka/l10n/app_localizations.dart';


class ChaguaNjiaPage extends StatefulWidget {
  const ChaguaNjiaPage({super.key});

  @override
  State<ChaguaNjiaPage> createState() => _ChaguaNjiaPageState();
}

class _ChaguaNjiaPageState extends State<ChaguaNjiaPage> {
  double progress = 0;
  bool showProgress = false;

  Future<void> _showSyncProgress() async {
    setState(() {
      progress = 0;
      showProgress = true;
    });

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50), () {
        setState(() {
          progress = i.toDouble();
        });
      });
    }

    await Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: const RoundedRectangleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🎉',
                  style: TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.taarifaZimehifadhiwa,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    AppLocalizations.of(context)!.sawa,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      setState(() {
        showProgress = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.uhifadhiKumbukumbu,
        showBackArrow: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.chaguaNjiaUhifadhi,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildOptionButton(
                      text: 'Internet',
                      color: const Color.fromARGB(255, 4, 207, 55),
                      icon: Icons.wifi,
                      onPressed: () async {
                        await _showSyncProgress();
                        var syncdt = Syncdata();
                        syncdt.syncAllTables();
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildOptionButton(
                      text: 'SMS',
                      color: const Color.fromARGB(255, 4, 34, 207),
                      icon: Icons.sms,
                      onPressed: () async {
                        await _showSyncProgress();
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (showProgress) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[300],
                  color: Colors.teal,
                  minHeight: 12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!
                    .uhifadhiProgress(progress.toInt()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
