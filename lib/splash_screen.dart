import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import 'navigation_screen/navigation_holder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FlutterSplashScreen.fadeIn(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0f2027), // Dark blue
            Color(0xFF203a43), // Medium blue
            Color(0xFF2c5364), // Light blue
            Color(0xFF302b63), // Dark purple
            Color(0xFF0f2027), // Dark blue (again for smoother transition)
          ],
        ),
        duration: Duration(seconds: 5),
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: Transform.scale(
          scale: 3,
          child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "lib/icons/appicon.png",
            ),
          ),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen: const NavigationHolderComponent(),
      )),
    );
  }
}
