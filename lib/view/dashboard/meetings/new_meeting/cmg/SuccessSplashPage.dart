import 'package:chomoka/model/syncData.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chomoka/l10n/app_localizations.dart';


class SuccessSplashPage extends StatefulWidget {
  final int meetingId;
  var groupId;

  SuccessSplashPage({Key? key, required this.meetingId, required this.groupId})
      : super(key: key);

  @override
  _SuccessSplashPageState createState() => _SuccessSplashPageState();
}

class _SuccessSplashPageState extends State<SuccessSplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _textColorAnimation;
  bool showLoader = true;
  bool isSyncing = false;
  String statusMessage = "Inahifadhi taarifa...";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _colorAnimation = ColorTween(
            begin: const Color.fromARGB(255, 155, 155, 155),
            end: const Color.fromARGB(255, 76, 175, 80)) // Green color
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _textColorAnimation = ColorTween(
      begin: Colors.grey[700]!,
      end: Colors.green[600]!, // Dark green for text
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _checkInternetAndSync();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _checkInternetAndSync() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      showLoader = true;
      isSyncing = true;
      statusMessage = l10n.dataSavedSuccessfully;
    });

    // Check for internet connection
    bool hasInternet = await _checkInternetConnection();

    if (hasInternet) {
      // If internet is available, sync data
      setState(() {
        statusMessage = l10n.dataSavedSuccessfully;
      });

      try {
        var syncdt = Syncdata();
        await syncdt.syncAllTables();

        setState(() {
          statusMessage = l10n.dataSavedSuccessfully;
        });
      } catch (e) {
        print("Error syncing data: $e");
        setState(() {
          statusMessage = l10n.dataSavedSuccessfully;
        });
      }
    } else {
      // If no internet, just show saved message
      setState(() {
        statusMessage = l10n.dataSavedSuccessfully;
      });
    }

    // Continue with animation after sync attempt
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      showLoader = false;
      isSyncing = false;
    });

    _animationController.forward();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => dashboard(groupId: widget.groupId),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green[50]!,
              Colors.green[100]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Background design elements
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.1),
                  ),
                ),
              ),
              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: _colorAnimation.value,
                          size: 120,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AnimatedBuilder(
                      animation: _textColorAnimation,
                      builder: (context, child) {
                        return Column(
                          children: [
                            Text(
                              'Meeting Closed', // fallback, no l10n key found
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: _textColorAnimation.value,
                              ),
                            ),
                            Text(
                              l10n.finished,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: _textColorAnimation.value,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    if (showLoader)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.green,
                              strokeWidth: 3.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            statusMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
