import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/mainScreenWithNavigation/audioTraySmall.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar.dart';
import 'package:my_music_app/mainScreenWithNavigation/search_bar.dart';
import 'audioTrayLarge.dart';
import 'models/audioButtons.dart';
import 'screens/exploreScreen/mainScreenHolder.dart';
import 'screens/playlistsScreens/playListsScreen.dart';
import 'package:file_selector/file_selector.dart';

class MainScreenWithNavigation extends StatefulWidget {
  const MainScreenWithNavigation({super.key});

  @override
  State<MainScreenWithNavigation> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MainScreenWithNavigation> {
  // The currently selected index of the navigation bar
  int navigationBarIndex = 0;
  bool screenIsAllSongsScreen = false;
  bool audioTrayIsMinimized = false;
  bool playButtonIsPressed = false;
  bool songIsPLaying = false;
  bool audioTrayersAreVisible = false;

  // List of all songs
  List<String> allSongList = [
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
  List<String> playLists = [
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
  }

  @override
  void dispose() {
    super.dispose();
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
                Color(0xFF260000),
              ],
            ),
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
                    NavigationBarHolder(
                      navigationBarIndexChangeFunction: (navigationBarIndex) =>
                          _onNavigationBarIndexChangeFunction(
                              navigationBarIndex),
                      playLists: playLists,
                    ),
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
                                    onButtonPressed: () =>
                                        _onAddAudioFilesFunction(),
                                    buttonIcon: screenIsAllSongsScreen
                                        ? Bootstrap.plus_circle
                                        : null,
                                    buttonWidth: 30,
                                    buttonHeight: 30,
                                    buttonIconSize: 20,
                                    buttonBorderRadiusSize: 7,
                                  ),
                                  SongsSearchBar(
                                    allSongList: allSongList,
                                    onSuggestionTapFunction: (searchValue) =>
                                        _onSuggestionTapFunction(searchValue),
                                  ),
                                  AudioButtons(
                                    onButtonPressed: () =>
                                        _onAudioTrayCloseFuntion(),
                                    buttonIcon: !audioTrayersAreVisible
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
                                index: navigationBarIndex,
                                alignment: AlignmentDirectional.center,
                                duration: Duration.zero,
                                children: [
                                  Center(
                                    child: MainScreenHolder(
                                      allSongList: this.allSongList,
                                      playLists: this.playLists,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                    ),
                                  ),
                                  Center(
                                      child: PlayListsScreens(
                                    allSongList: allSongList,
                                    onPlayAndPauseButtonPressed: () =>
                                        _onPlayAndPauseButtonPressed(),
                                  )),
                                  Center(
                                    child: PlayListsScreens(
                                      allSongList: allSongList,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                    ),
                                  ),
                                  Center(
                                    child: PlayListsScreens(
                                      allSongList: allSongList,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                    ),
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
              audioTrayIsMinimized && audioTrayersAreVisible
                  ? AudioTraySmall(
                      buttonIcon: songIsPLaying
                          ? Bootstrap.pause_circle_fill
                          : Bootstrap.play_circle_fill,
                      onAudioTrayMinimizingFuntion:
                          _onAudioTrayMinimizingAndMaximizingFuntion,
                      onShuffleButtonPressed: _onShuffleButtonPressed,
                      onPlayAndPauseButtonPressed: _onPlayAndPauseButtonPressed,
                      onSkipBackButtonPressed: _onSkipBackButtonPressed,
                      onSkipForwardButtonPressed: _onSkipForwardButtonPressed,
                      onVolumeButtonPressed: _onVolumeButtonPressed,
                      onAudioTrayCloseFuntion: _onAudioTrayCloseFuntion,
                    )
                  : Container(),
              // Large audio tray
              !audioTrayIsMinimized && audioTrayersAreVisible
                  ? AudioTrayLarge(
                      allSongList: allSongList,
                      buttonIcon: songIsPLaying
                          ? Bootstrap.pause_circle_fill
                          : Bootstrap.play_circle_fill,
                      onAudioTrayMinimizingFuntion:
                          _onAudioTrayMinimizingAndMaximizingFuntion,
                      onShuffleButtonPressed: _onShuffleButtonPressed,
                      onPlayAndPauseButtonPressed: _onPlayAndPauseButtonPressed,
                      onSkipBackButtonPressed: _onSkipBackButtonPressed,
                      onSkipForwardButtonPressed: _onSkipForwardButtonPressed,
                      onVolumeButtonPressed: _onVolumeButtonPressed,
                      onPlayListSongPressedFunction:
                          _onPlayListSongPressedFunction,
                      onAudioTrayCloseFuntion: _onAudioTrayCloseFuntion,
                    )
                  : Container(),
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
      if (navigationBarIndex == 1) {
        screenIsAllSongsScreen = true;
      } else {
        screenIsAllSongsScreen = false;
      }
      allSongList.shuffle();
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
      audioTrayersAreVisible = true;
      songIsPLaying = !songIsPLaying;
    });
    debugPrint("play pressed");
  }

  void _onAudioTrayCloseFuntion() {
    setState(() {
      audioTrayersAreVisible = !audioTrayersAreVisible;
    });
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

  void _onSuggestionTapFunction(dynamic searchValue) {
    debugPrint(searchValue.toString());
  }

  Future<void> _onAddAudioFilesFunction() async {
    const XTypeGroup fileTypes = XTypeGroup(
      extensions: <String>['.mp3'],
    );

    final List<XFile> selectedFilesList =
        await openFiles(acceptedTypeGroups: <XTypeGroup>[fileTypes]);

    if (selectedFilesList.isNotEmpty) {
      setState(() {
        for (int i = 0; i < selectedFilesList.length; i++) {}

        selectedFilesList.clear();
      });
    } else {
      // User canceled the picker
      return;
    }
  }
}
