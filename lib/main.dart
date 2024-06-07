import 'package:flutter/material.dart';
import 'package:my_music_app/isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import 'package:my_music_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'generalFunctions/navigationBarChange.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DataBaseHelper.databaseInitialize();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(960, 640),
    minimumSize: Size(960, 640),
    skipTaskbar: false,
    title: "MyMusic",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMaximizable(false);
    await windowManager.setResizable(false);
    await windowManager.center();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataBaseHelper()),
        ChangeNotifierProvider(create: (context) => NavigationBarChange()),
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
