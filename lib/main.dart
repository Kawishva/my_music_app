// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_music_app/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  // Ensures that Flutter framework is properly initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the window manager
  await windowManager.ensureInitialized();

  // Sets up window options with a fixed size and hidden title bar
  WindowOptions windowOptions = const WindowOptions(
      size: Size(960, 640),
      minimumSize: Size(960, 640),
      skipTaskbar: false,
      title: "MyMusic"
      //titleBarStyle: TitleBarStyle.hidden,
      );

  // Ensures that window manager is ready before showing the window
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Shows the window
    await windowManager.show();
    // Brings the window to focus
    await windowManager.focus();
    // Disables the ability to maximize the window
    await windowManager.setMaximizable(false);
    // Disables the ability to resize the window
    await windowManager.setResizable(false);
    // Centers the window on the screen
    await windowManager.center();
  });

  // Runs the main application widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          primaryContainer: Colors.transparent,
          secondary: Colors.transparent,
          secondaryContainer: Colors.transparent,
          surface: Colors.transparent,
          background: Colors.transparent,
          error: Colors.transparent,
          onPrimary: Colors.transparent,
          onSecondary: Colors.transparent,
          onSurface: Colors.transparent,
          onBackground: Colors.transparent,
          onError: Colors.transparent,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: Colors.transparent,
        dialogBackgroundColor: Colors.transparent,
        dividerColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
      ),

      // Sets the home screen of the app to the SplashScreen widget
      home: SplashScreen(),
    );
  }
}
