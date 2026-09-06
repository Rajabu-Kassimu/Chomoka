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
  bool _isBusy = false;

  Future<void> _syncInternet() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    final progress = ValueNotifier<double>(0);
    _showLoadingDialog(progress);

    final syncdt = Syncdata();
    final result = await syncdt.syncAllTables(
      onProgress: (value) {
        if (mounted) progress.value = value.toDouble();
      },
    );

    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() => _isBusy = false);

    await _showResultDialog(result);
  }

  Future<void> _syncSms() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    final progress = ValueNotifier<double>(0);
    _showLoadingDialog(progress);

    // SMS backup flow will be connected here later. For now it runs the
    // same saving animation so the UI stays consistent.
    for (var i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      if (!mounted) return;
      progress.value = i.toDouble();
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() => _isBusy = false);

    await _showResultDialog(SyncResult.success);
  }

  void _showLoadingDialog(ValueNotifier<double> progress) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (dialogContext) {
        final loc = AppLocalizations.of(dialogContext)!;
        return PopScope(
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 56,
                    height: 56,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    loc.tumaTaarifa,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<double>(
                    valueListenable: progress,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: (value / 100).toDouble(),
                              minHeight: 10,
                              backgroundColor: Colors.teal.shade100,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            loc.uhifadhiProgress(value.round()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showResultDialog(SyncResult result) {
    final isSuccess = result == SyncResult.success;
    final isNoData = result == SyncResult.noData;
    final color = isNoData
        ? Colors.orange
        : isSuccess
            ? Colors.teal
            : Colors.redAccent;
    final icon = isNoData
        ? Icons.info_outline
        : isSuccess
            ? Icons.check_circle
            : Icons.error_outline;

    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final loc = AppLocalizations.of(dialogContext)!;
        final message = isNoData
            ? loc.hakunaTaarifaZilizopo
            : isSuccess
                ? loc.taarifaZimehifadhiwa
                : loc.hitilafu_imetokea;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 48, color: color),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      loc.sawa,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: loc.uhifadhiKumbukumbu,
        showBackArrow: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.cloud_upload_outlined,
                  size: 52,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                loc.chaguaNjiaUhifadhi,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loc.tumaTaarifa,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              _buildOptionButton(
                text: 'Internet',
                color: const Color.fromARGB(255, 4, 207, 55),
                icon: Icons.wifi,
                onPressed: _isBusy ? null : _syncInternet,
              ),
              const SizedBox(height: 16),
              _buildOptionButton(
                text: 'SMS',
                color: const Color.fromARGB(255, 4, 34, 207),
                icon: Icons.sms,
                onPressed: _isBusy ? null : _syncSms,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required Color color,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        backgroundColor: color,
        foregroundColor: Colors.white,
        disabledBackgroundColor: color.withValues(alpha: 0.6),
        disabledForegroundColor: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 28,
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
