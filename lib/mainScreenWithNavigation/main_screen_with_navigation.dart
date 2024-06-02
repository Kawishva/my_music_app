import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/mainScreenWithNavigation/audioTraySmall.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar.dart';
import 'package:my_music_app/models/minimizeAndCloseButtons.dart';
import 'package:window_manager/window_manager.dart';
import 'audioTrayLarge.dart';

class MainScreenWithNavigation extends StatefulWidget {
  const MainScreenWithNavigation({super.key});

  @override
  State<MainScreenWithNavigation> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MainScreenWithNavigation> {
  // The currently selected index of the navigation bar
  int navigationBarIndex = 0;
  bool audioTrayIsMinimized = false;
  bool playButtonIsPressed = false;

  // List of all songs
  final List<String> allSongList = [
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english"
  ];

  // List of playlists
  final List<String> playLists = [
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english",
    "old songs",
    "reggae",
    "english"
  ];

  @override
  void initState() {
    super.initState();
    _initializeWindow();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Initialize window settings
  void _initializeWindow() async {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions();

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      windowManager.isMinimizable();
      windowManager.isClosable();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF022B35),
                Color(0xFF030B21),
                Color(0xFF000000),
                Color.fromARGB(255, 38, 0, 0),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Main content with navigation and audio tray
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Navigation bar
                    NavigationBarHolder(
                      navigationBarIndexChangeFunction: (navigationBarIndex) =>
                          _onNavigationBarIndexChangeFunction(
                              navigationBarIndex),
                      playLists: playLists,
                    ),
                    Expanded(
                      child: FadeIndexedStack(
                        index: navigationBarIndex,
                        alignment: AlignmentDirectional.center,
                        duration: Duration.zero,
                        children: const [
                          Center(
                            child: Text(
                              'Settings 1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Settings 2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Settings 3',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Settings 4',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Large audio tray
                    audioTrayIsMinimized
                        ? AudioTrayLarge(
                            allSongList: allSongList,
                            buttonIcon: playButtonIsPressed
                                ? Bootstrap.play_circle_fill
                                : Bootstrap.pause_circle_fill,
                            onAudioTrayMinimizingFuntion:
                                _onAudioTrayMinimizingAndMaximizingFuntion,
                            onShuffleButtonPressed: _onShuffleButtonPressed,
                            onPlayAndPauseButtonPressed:
                                _onPlayAndPauseButtonPressed,
                            onSkipBackButtonPressed: _onSkipBackButtonPressed,
                            onSkipForwardButtonPressed:
                                _onSkipForwardButtonPressed,
                            onVolumeButtonPressed: _onVolumeButtonPressed,
                            onPlayListSongPressedFunction:
                                _onPlayListSongPressedFunction,
                          )
                        : Container(),
                  ],
                ),
              ),
              // Small audio tray
              !audioTrayIsMinimized
                  ? AudioTraySmall(
                      buttonIcon: playButtonIsPressed
                          ? Bootstrap.play_circle_fill
                          : Bootstrap.pause_circle_fill,
                      onAudioTrayMinimizingFuntion:
                          _onAudioTrayMinimizingAndMaximizingFuntion,
                      onShuffleButtonPressed: _onShuffleButtonPressed,
                      onPlayAndPauseButtonPressed: _onPlayAndPauseButtonPressed,
                      onSkipBackButtonPressed: _onSkipBackButtonPressed,
                      onSkipForwardButtonPressed: _onSkipForwardButtonPressed,
                      onVolumeButtonPressed: _onVolumeButtonPressed,
                    )
                  : Container(),
              // Minimize and close buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MinimizeAndCloseButtons(
                        buttonIcon: Bootstrap.dash_lg,
                        onPressed: () async {
                          windowManager.minimize();
                          debugPrint("minimized pressed");
                        },
                        buttonBackgroundColor: Color(0xFF03233D),
                        buttonOverlayColor: Colors.blue.withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: MinimizeAndCloseButtons(
                          buttonIcon: Bootstrap.x_lg,
                          onPressed: () {
                            windowManager.close();
                            debugPrint("close pressed");
                          },
                          buttonBackgroundColor: Color(0xFF3D0303),
                          buttonOverlayColor: Colors.red.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle navigation bar index change
  void _onNavigationBarIndexChangeFunction(int navigationBarIndex) {
    setState(() {
      this.navigationBarIndex = navigationBarIndex;
    });
  }

  // Function to toggle audio tray minimize/maximize state
  void _onAudioTrayMinimizingAndMaximizingFuntion() {
    setState(() {
      audioTrayIsMinimized = !audioTrayIsMinimized;
    });
    debugPrint(audioTrayIsMinimized.toString());
  }

  // Function to handle shuffle button press
  void _onShuffleButtonPressed() {
    debugPrint("shuffle pressed");
  }

  // Function to handle skip back button press
  void _onSkipBackButtonPressed() {
    debugPrint("skip back pressed");
  }

  // Function to handle play/pause button press
  void _onPlayAndPauseButtonPressed() {
    setState(() {
      playButtonIsPressed = !playButtonIsPressed;
    });
    debugPrint("play pressed");
  }

  // Function to handle skip forward button press
  void _onSkipForwardButtonPressed() {
    debugPrint("skip forward pressed");
  }

  // Function to handle volume button press
  void _onVolumeButtonPressed() {
    debugPrint("volume pressed");
  }

  // Function to handle playlist song press
  void _onPlayListSongPressedFunction() {
    debugPrint("playlist song pressed");
  }
}
