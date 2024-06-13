import 'package:animate_do/animate_do.dart';
import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import 'package:my_music_app/mainScreenWithNavigation/audioTraySmall.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar/navigationBar.dart';
import 'package:my_music_app/mainScreenWithNavigation/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import '../generalFunctions/audioAndVideoStream.dart';
import '../generalFunctions/navigationBarChange.dart';
import '../isarDatabase/databaseHelper/song.dart';
import 'audioTrayLarge.dart';
import 'models/audioButtons.dart';
import 'playListsScreen.dart';

class MainScreenWithNavigation extends StatefulWidget {
  MainScreenWithNavigation({
    super.key,
  });

  @override
  State<MainScreenWithNavigation> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MainScreenWithNavigation> {
  // The currently selected index of the navigation bar
  bool audioTrayIsMinimized = false;
  String selectedDirectory = "";

  @override
  void initState() {
    super.initState();
    _initializeWindow();
    enableThumbnailToolBar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initializeWindow() async {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.center();
    });
  }

  void enableThumbnailToolBar() {
    WindowsTaskbar.setThumbnailToolbar([
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('lib/icons/backward.ico'),
        'Play Previous Song',
        () {
          context.read<AudiostreamFunctions>().playPreviousSong();
        },
      ),
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('lib/icons/play.ico'),
        'Play/Pause',
        () {
          context.read<AudiostreamFunctions>().songPlayPause();
        },
      ),
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('lib/icons/forward.ico'),
        'Play Next Song',
        () {
          context.read<AudiostreamFunctions>().playNextSong();
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(

              /* gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF022B35),
                Color(0xFF030B21),
                Color(0xFF000000),
                Color(0xFF260000),
              ],
            ),*/
              ),
          child: Stack(
            children: [
              // Main content with navigation and audio tray
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Navigation bar
                    NavigationBarHolder(),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AudioButtons(
                                    onButtonPressed: () {
                                      if (navigationBarChangeInstance
                                          .isAllSongsScreen) {
                                        _onFolderPathPickFunction();
                                      }
                                    },
                                    buttonIcon: navigationBarChangeInstance
                                            .isAllSongsScreen
                                        ? Bootstrap.plus_circle
                                        : null,
                                    buttonWidth: 30,
                                    buttonHeight: 30,
                                    buttonIconSize: 20,
                                    buttonBorderRadiusSize: 7,
                                  ),
                                  SongsSearchBar(),
                                  AudioButtons(
                                    onButtonPressed: () =>
                                        _onAudioTrayCloseFuntion(),
                                    buttonIcon: !navigationBarChangeInstance
                                            .getAudioTrayVisibility
                                        ? Bootstrap.music_player
                                        : null,
                                    buttonWidth: 25,
                                    buttonHeight: 25,
                                    buttonIconSize: 16,
                                    buttonBorderRadiusSize: 7,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: FadeIndexedStack(
                                index:
                                    navigationBarChangeInstance.navigationIndex,
                                alignment: AlignmentDirectional.center,
                                duration: Duration.zero,
                                children: [
                                  Center(child: PlayListsScreens()),
                                  Center(
                                    child: PlayListsScreens(),
                                  ),
                                  Center(
                                    child: PlayListsScreens(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Small audio tray
              audioTrayIsMinimized &&
                      navigationBarChangeInstance.getAudioTrayVisibility
                  ? FadeInUp(
                      animate: true,
                      duration: Duration(milliseconds: 200),
                      child: AudioTraySmall(
                        onAudioTrayMinimizingFuntion: () =>
                            _onAudioTrayMinimizingAndMaximizingFuntion(),
                        onAudioTrayCloseFuntion: () =>
                            _onAudioTrayCloseFuntion(),
                      ),
                    )
                  : Container(),
              // Large audio tray
              !audioTrayIsMinimized &&
                      navigationBarChangeInstance.getAudioTrayVisibility
                  ? FadeInRight(
                      animate: true,
                      duration: Duration(milliseconds: 200),
                      child: AudioTrayLarge(
                        onAudioTrayMinimizingFuntion: () =>
                            _onAudioTrayMinimizingAndMaximizingFuntion(),
                        onAudioTrayCloseFuntion: () =>
                            _onAudioTrayCloseFuntion(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to toggle audio tray minimize/maximize state
  void _onAudioTrayMinimizingAndMaximizingFuntion() {
    setState(() {
      audioTrayIsMinimized = !audioTrayIsMinimized;
    });
    debugPrint(audioTrayIsMinimized.toString());
  }

  void _onAudioTrayCloseFuntion() {
    SongDataClass? selectedAudio =
        context.read<AudiostreamFunctions>().selectedSong;

    if (selectedAudio == null) {
      SongDataClass fisrtSong =
          context.read<DataBaseHelper>().songDataList.first;

      List<SongDataClass> songDataList =
          context.read<DataBaseHelper>().songDataList;

      context
          .read<AudiostreamFunctions>()
          .setAudioData(fisrtSong, songDataList);
    }

    context.read<NavigationBarChange>().onAudioTrayCloseFuntion();
  }

  Future<void> _onFolderPathPickFunction() async {
    String? directoryPath = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Pick Song Directory!");

    context.read<DataBaseHelper>().onFolderPathPick(directoryPath);
  }
}
