import 'package:flutter/material.dart';
import 'package:my_music_app/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
//window manger to custemize the app name and window resolution
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(960, 640),
    minimumSize: Size(960, 640),
    title: "My Music",
  );

  windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMaximizable(false);
    await windowManager.setResizable(false);
    await windowManager.center();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
