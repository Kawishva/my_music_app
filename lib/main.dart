import 'package:flutter/material.dart';
import 'package:my_music_app/isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import 'package:my_music_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:window_manager/window_manager.dart';
import 'generalFunctions/audioAndVideoStream.dart';
import 'generalFunctions/navigationBarChange.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await DataBaseHelper.databaseInitialize();

  // Ensure the video player media kit is initialized, particularly for Windows
  VideoPlayerMediaKit.ensureInitialized(
    windows: true, // Dependency: media_kit_libs_windows_video
  );

  // Ensure window manager is initialized
  await windowManager.ensureInitialized();

  // Define window options
  WindowOptions windowOptions = const WindowOptions(
    size: Size(960, 640),
    titleBarStyle: TitleBarStyle.hidden,
    skipTaskbar: false,
    title: "MyMusic",
    center: true,
  );

  // Configure the window settings once it's ready to show
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMaximizable(false);
    await windowManager.setResizable(false);
    await windowManager.center();
  });

  // Run the app with multiple providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataBaseHelper()),
        ChangeNotifierProvider(create: (context) => NavigationBarChange()),
        ChangeNotifierProvider(create: (context) => AudiostreamFunctions()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
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
      home: SplashScreen(),
    );
  }
}
