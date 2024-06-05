// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_music_app/isarDB/allPlayLists.dart';
import 'package:my_music_app/isarDB/favouriteSongsList.dart';
import 'package:my_music_app/isarDB/importedFolders.dart';
import 'package:my_music_app/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'isarDB/allSongs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  final isarDB = await Isar.open([
    AllPlayListsSchema,
    AllSongsSchema,
    FavouriteSongsListSchema,
    ImportedFoldersSchema
  ], directory: dir.path, inspector: true);

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

  runApp(MyApp(databaseInstance: isarDB));
}

class MyApp extends StatelessWidget {
  final Isar databaseInstance;

  const MyApp({super.key, required this.databaseInstance});

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
      home: SplashScreen(databaseInstance: this.databaseInstance),
    );
  }
}
