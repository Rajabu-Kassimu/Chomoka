import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'package:chomoka/l10n/app_localizations.dart';


class SplashScreen extends StatefulWidget {
  final Widget Function()? onCompletion; // Callback to determine the next page

  SplashScreen({Key? key, this.onCompletion}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  final int _numStars = 50;

  @override
  void initState() {
    super.initState();

    // Animation controller for scaling logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();

    _navigateToNextPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (widget.onCompletion != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.onCompletion!()),
      );
    }
  }

  List<Widget> _buildFloatingStars() {
    return List.generate(_numStars, (index) {
      final double left =
          _random.nextDouble() * MediaQuery.of(context).size.width;
      final double top =
          _random.nextDouble() * MediaQuery.of(context).size.height;
      final double size = _random.nextDouble() * 4 + 2;
      final Color color = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );

      return AnimatedPositioned(
        duration: Duration(milliseconds: 3000 + _random.nextInt(2000)),
        left: left,
        top: top,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Stack(
        children: [
          // Floating stars
          ..._buildFloatingStars(),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated App Logo
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 4, 34, 207), // Deep Blue
                          Color.fromARGB(255, 24, 154, 180), // Light Cyan
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Color.fromARGB(
                            255, 255, 215, 0), // White icon for contrast
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // App Name
                Text(
                  "Chomoka Plus",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // Tagline
                Text(
                  l10n.appTagline ?? "Tunakusaidia Kuimarisha Maendeleo",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                // Loading Indicator
                const SpinKitThreeBounce(
                  color: Color.fromARGB(255, 4, 34, 207), // Deep Blue color
                  size: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
