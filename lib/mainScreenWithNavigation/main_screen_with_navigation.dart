import 'dart:io';
import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:isar/isar.dart';
import 'package:my_music_app/mainScreenWithNavigation/audioTraySmall.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar.dart';
import 'package:my_music_app/mainScreenWithNavigation/search_bar.dart';
import '../isarDB/allSongs.dart';
import 'audioTrayLarge.dart';
import 'models/audioButtons.dart';
import 'screens/exploreScreen/mainScreenHolder.dart';
import 'screens/playlistsScreens/playListsScreen.dart';
import 'package:popover/popover.dart';
import 'package:file_picker/file_picker.dart';

class MainScreenWithNavigation extends StatefulWidget {
  final Isar databaseInstance;

  const MainScreenWithNavigation({super.key, required this.databaseInstance});

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
  String selectedDirectory = "";
  late List<bool> checkBoxValues;

  // List of all songs
  List<int> allSongsIdList = [];

  // List of playlists
  List<int> playListsIdList = [];

  @override
  void initState() {
    super.initState();
    checkBoxValues = List<bool>.filled(playListsIdList.length, false);
    _retrieveSongIds(widget.databaseInstance);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isarDBInstance = widget.databaseInstance;

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
                      playLists: playListsIdList,
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
                                        _onSongsFolderPathSelectionFunction(
                                            isarDBInstance),
                                    buttonIcon: screenIsAllSongsScreen
                                        ? Bootstrap.plus_circle
                                        : null,
                                    buttonWidth: 30,
                                    buttonHeight: 30,
                                    buttonIconSize: 20,
                                    buttonBorderRadiusSize: 7,
                                  ),
                                  SongsSearchBar(
                                    allSongList: allSongsIdList,
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
                                      allSongList: this.allSongsIdList,
                                      playLists: this.playListsIdList,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                      onAddToFavouriteListFunction: () =>
                                          _onAddToFavouriteListFunction(),
                                      onAddToPlayListOpenFunction:
                                          (newContext) =>
                                              _onAddToPlayListOpenFunction(
                                                  newContext),
                                    ),
                                  ),
                                  Center(
                                      child: PlayListsScreens(
                                    allSongList: allSongsIdList,
                                    onPlayAndPauseButtonPressed: () =>
                                        _onPlayAndPauseButtonPressed(),
                                    onAddToFavouriteListFunction: () =>
                                        _onAddToFavouriteListFunction(),
                                    onAddToPlayListOpenFunction: (newContext) =>
                                        _onAddToPlayListOpenFunction(
                                            newContext),
                                  )),
                                  Center(
                                    child: PlayListsScreens(
                                      allSongList: allSongsIdList,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                      onAddToFavouriteListFunction: () =>
                                          _onAddToFavouriteListFunction(),
                                      onAddToPlayListOpenFunction:
                                          (newContext) =>
                                              _onAddToPlayListOpenFunction(
                                                  newContext),
                                    ),
                                  ),
                                  Center(
                                    child: PlayListsScreens(
                                      allSongList: allSongsIdList,
                                      onPlayAndPauseButtonPressed: () =>
                                          _onPlayAndPauseButtonPressed(),
                                      onAddToFavouriteListFunction: () =>
                                          _onAddToFavouriteListFunction(),
                                      onAddToPlayListOpenFunction:
                                          (newContext) =>
                                              _onAddToPlayListOpenFunction(
                                                  newContext),
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
                      onAudioTrayMinimizingFuntion: () =>
                          _onAudioTrayMinimizingAndMaximizingFuntion(),
                      onShuffleButtonPressed: () => _onShuffleButtonPressed(),
                      onPlayAndPauseButtonPressed: () =>
                          _onPlayAndPauseButtonPressed(),
                      onSkipBackButtonPressed: () => _onSkipBackButtonPressed(),
                      onSkipForwardButtonPressed: () =>
                          _onSkipForwardButtonPressed(),
                      onVolumeButtonPressed: () => _onVolumeButtonPressed(),
                      onAudioTrayCloseFuntion: () => _onAudioTrayCloseFuntion(),
                      onAddToFavouriteListFunction: () =>
                          _onAddToFavouriteListFunction(),
                    )
                  : Container(),
              // Large audio tray
              !audioTrayIsMinimized && audioTrayersAreVisible
                  ? AudioTrayLarge(
                      allSongList: allSongsIdList,
                      buttonIcon: songIsPLaying
                          ? Bootstrap.pause_circle_fill
                          : Bootstrap.play_circle_fill,
                      onAudioTrayMinimizingFuntion: () =>
                          _onAudioTrayMinimizingAndMaximizingFuntion(),
                      onShuffleButtonPressed: () => _onShuffleButtonPressed(),
                      onPlayAndPauseButtonPressed: () =>
                          _onPlayAndPauseButtonPressed(),
                      onSkipBackButtonPressed: () => _onSkipBackButtonPressed(),
                      onSkipForwardButtonPressed: () =>
                          _onSkipForwardButtonPressed(),
                      onVolumeButtonPressed: () => _onVolumeButtonPressed(),
                      onAudioTrayCloseFuntion: () => _onAudioTrayCloseFuntion(),
                      onPlayListSongPressedFunction: () =>
                          _onPlayListSongPressedFunction(),
                      onAddToFavouriteListFunction: () =>
                          _onAddToFavouriteListFunction(),
                      onAddToPlayListOpenFunction: (newContext) =>
                          _onAddToPlayListOpenFunction(newContext),
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
      allSongsIdList.shuffle();
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

  Future<void> _onSongsFolderPathSelectionFunction(Isar isarDBInstance) async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        selectedDirectory = directoryPath;
      });
      debugPrint(selectedDirectory);

      _loadAndSaveAllSongsInDB(directoryPath, isarDBInstance);
    } else {
      // User canceled the picker
      return;
    }
  }

  Future<void> _loadAndSaveAllSongsInDB(
      String directoryPath, Isar isarDBInstance) async {
    final Directory dir = Directory(directoryPath);
    final List<File> importedSongs = dir
        .listSync()
        .where((item) => item.path.endsWith('.mp3'))
        .map((item) => File(item.path))
        .toList();

    final importedSongsList =
        importedSongs.map((file) => AllSongs()..songPath = file.path).toList();

    final retrievedSongs = await isarDBInstance.allSongs.where().findAll();
    final allRetrievedSongsPathList =
        retrievedSongs.map((song) => song.songPath).toList();

    for (var importedSong in importedSongsList) {
      if (!allRetrievedSongsPathList.contains(importedSong.songPath)) {
        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.allSongs.put(importedSong);
        });
      }
    }

    await _retrieveSongIds(isarDBInstance);

    debugPrint(importedSongs.first.path);
  }

  Future<void> _retrieveSongIds(Isar isarDBInstance) async {
    final allSongs = await isarDBInstance.allSongs.where().findAll();
    final allSongsIds = allSongs.map((song) => song.songId).toList();

    setState(() {
      for (final id in allSongsIds) {
        if (!allSongsIdList.contains(id)) {
          allSongsIdList.add(id);
        }
      }
    });

    debugPrint('Song IDs retrieved: $allSongsIdList');
  }

  void _onAddToPlayListOpenFunction(BuildContext newContext) {
    showPopover(
      context: newContext,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration.zero,
      bodyBuilder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  itemCount: playListsIdList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //  decoration: BoxDecoration(color: Colors.amber),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            playListsIdList[index].toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.alatsi(
                              letterSpacing: 0.5,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8, // Scale down the checkbox
                            child: Checkbox(
                              value: checkBoxValues[index],
                              tristate: true,
                              activeColor:
                                  Colors.white, // Active color of the checkbox
                              overlayColor: WidgetStateProperty.all(Colors
                                  .transparent), // Transparent overlay color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), // Rounded corners for the checkbox
                              ),
                              onChanged: (ticked) {
                                setState(() {
                                  checkBoxValues[index] = ticked ?? false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
      radius: 15,
      width: 100,
      height: 130,
      arrowHeight: 0,
      arrowWidth: 0,
    );
  }

  void _onAddToFavouriteListFunction() {}
}
