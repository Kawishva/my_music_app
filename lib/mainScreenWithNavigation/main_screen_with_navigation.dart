import 'dart:io';
import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:isar/isar.dart';
import 'package:my_music_app/mainScreenWithNavigation/audioTraySmall.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar/navigationBar.dart';
import 'package:my_music_app/mainScreenWithNavigation/search_bar.dart';
import '../isarDB/allPlayLists.dart';
import '../isarDB/allSongs.dart';
import '../isarDB/favouriteSongsList.dart';
import '../isarDB/importedFolders.dart';
import 'audioTrayLarge.dart';
import 'models/audioButtons.dart';
import 'screens/exploreScreen/mainScreenHolder.dart';
import 'screens/playlistsScreens/playListsScreen.dart';
import 'package:file_picker/file_picker.dart';

class MainScreenWithNavigation extends StatefulWidget {
  final Isar databaseInstance;

  MainScreenWithNavigation({super.key, required this.databaseInstance});

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

  // List of all songs
  List<int> allSongsIdList = [];

  // List of playlists

  // List of playlists
  List<String> folderPathsList = [];
  List<String> allPlayLists = [];

  @override
  void initState() {
    super.initState();

    _reloadFoldersFunction(widget.databaseInstance);
    _retrieveSongIds(widget.databaseInstance);
    _resetFunction(widget.databaseInstance);
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
                                  SongsSearchBar(),
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
                                    child: MainScreenHolder(),
                                  ),
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
              audioTrayIsMinimized && audioTrayersAreVisible
                  ? AudioTraySmall(
                      onAudioTrayMinimizingFuntion: () =>
                          _onAudioTrayMinimizingAndMaximizingFuntion(),
                      onAudioTrayCloseFuntion: () => _onAudioTrayCloseFuntion(),
                    )
                  : Container(),
              // Large audio tray
              !audioTrayIsMinimized && audioTrayersAreVisible
                  ? AudioTrayLarge(
                      onAudioTrayMinimizingFuntion: () =>
                          _onAudioTrayMinimizingAndMaximizingFuntion(),
                      onAudioTrayCloseFuntion: () => _onAudioTrayCloseFuntion(),
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
    _reloadFoldersFunction(widget.databaseInstance);
    setState(() {
      this.navigationBarIndex = navigationBarIndex;
      if (navigationBarIndex == 1) {
        screenIsAllSongsScreen = true;
      } else {
        screenIsAllSongsScreen = false;
      }
    });
  }

  // Function to toggle audio tray minimize/maximize state
  void _onAudioTrayMinimizingAndMaximizingFuntion() {
    setState(() {
      audioTrayIsMinimized = !audioTrayIsMinimized;
    });
    debugPrint(audioTrayIsMinimized.toString());
  }

  void _onAudioTrayCloseFuntion() {
    setState(() {
      audioTrayersAreVisible = !audioTrayersAreVisible;
    });
  }

  Future<void> _onSongsFolderPathSelectionFunction(Isar isarDBInstance) async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      debugPrint(directoryPath);
      final Directory dir = Directory(directoryPath);

      final List<File> importedSongs = dir
          .listSync()
          .where((item) => item.path.endsWith('.mp3'))
          .map((item) => File(item.path))
          .toList();

      if (importedSongs.isNotEmpty) {
        _saveFolderPathFunction(directoryPath, isarDBInstance);
        _saveAllSongsToDBFunction(importedSongs, isarDBInstance);
      } else {
        debugPrint("no song found");
      }
    } else {
      // User canceled the picker
      return;
    }
  }

  Future<void> _saveFolderPathFunction(
      String directoryPath, Isar isarDBInstance) async {
    // Create a new folder object
    final newFolder = ImportedFolders()..importedFollderPath = directoryPath;

    // Retrieve all existing folder paths
    final folders = await isarDBInstance.importedFolders.where().findAll();
    final retrievedfolderPaths =
        folders.map((folder) => directoryPath).toList();

    // Check if the new folder path is already in the database
    if (!retrievedfolderPaths.contains(newFolder)) {
      // If not, save the new folder path
      await isarDBInstance.writeTxn(() async {
        await isarDBInstance.importedFolders.put(newFolder);
      });
      final newfolders = await isarDBInstance.importedFolders.where().findAll();
      debugPrint('Folder path saved to database: $newfolders');
    } else {
      debugPrint('Folder path already exists in the database: $directoryPath');
    }
  }

  Future<void> _reloadFoldersFunction(Isar isarDBInstance) async {
    List<File> allImportedSongsPaths = [];

    setState(() {
      folderPathsList.clear();
      // allSongsIdList.clear();
    });

    // Retrieve folder paths from the database
    final folders = await isarDBInstance.importedFolders.where().findAll();
    folderPathsList =
        folders.map((folder) => folder.importedFollderPath.toString()).toList();

    final retrievedSongsPaths = await isarDBInstance.allSongs.where().findAll();
    final allRetrievedSongsPathList =
        retrievedSongsPaths.map((song) => song.songPath).toList();

    for (int i = 0; i < folderPathsList.length; i++) {
      final Directory dir = Directory(folderPathsList[i]);

      final List<File> importedSongsPaths = dir
          .listSync()
          .where((item) => item.path.endsWith('.mp3'))
          .map((item) => File(item.path))
          .toList();

      if (importedSongsPaths.isNotEmpty) {
        allImportedSongsPaths.addAll(importedSongsPaths);
        debugPrint("No song  directory: ${importedSongsPaths.length}");
        _saveAllSongsToDBFunction(importedSongsPaths, isarDBInstance);
      } else {
        debugPrint("No song found in directory: ${folderPathsList[i]}");
      }
    }

    for (int j = 0; j < allRetrievedSongsPathList.length; j++) {
      if (!allImportedSongsPaths
          .any((file) => file.path == allRetrievedSongsPathList[j])) {
        await isarDBInstance.writeTxn(() async {
          final success = await isarDBInstance.allSongs
              .filter()
              .songPathEqualTo(allRetrievedSongsPathList[j])
              .deleteAll();
          debugPrint('Song deleted: $success');
        });
      }
    }

    _retrievFolderPathsFunction(isarDBInstance);
    _retrieveSongIds(isarDBInstance);
    _onRetrieveAllPlayListsFunction(isarDBInstance);
  }

  Future<void> _retrievFolderPathsFunction(Isar isarDBInstance) async {
    // Retrieve all existing folder paths
    final folders = await isarDBInstance.importedFolders.where().findAll();
    final retrievedfolderPaths =
        folders.map((folder) => folder.importedFollderPath).toList();

    setState(() {
      for (var folderPaths in retrievedfolderPaths) {
        if (!allSongsIdList.contains(folderPaths)) {
          folderPathsList.add(folderPaths!);
        }
      }
    });

    debugPrint('Song IDs retrieved: $folderPathsList');
  }

  Future<void> _saveAllSongsToDBFunction(
      List<File> importedSongs, Isar isarDBInstance) async {
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

    for (int i = 0; i < allSongsIdList.length; i++) {
      if (!allSongs.any((song) => song.songId == allSongsIdList[i])) {
        await isarDBInstance.writeTxn(() async {
          final success = await isarDBInstance.allSongs
              .filter()
              .songIdEqualTo(allSongsIdList[i])
              .deleteAll();
          debugPrint('Song deleted: $success');
        });

        allSongsIdList.removeAt(i);
      }
    }

    setState(() {
      for (final songId in allSongsIds) {
        if (!allSongsIdList.contains(songId)) {
          allSongsIdList.add(songId);
        }
      }
    });

    debugPrint('Song IDs retrieved: $allSongsIdList');
  }

  Future<void> _resetFunction(Isar isarDBInstance) async {
    final newPlaylist = AllPlayLists()
      ..playListName = "newPlaylistName1111"
      ..songsIdList = [];

    final newSong = AllSongs()..songPath = "newSong1111";

    final favouriteList = FavouriteSongsList()..songPath = "favourite1111";

    await isarDBInstance.writeTxn(() async {
      await isarDBInstance.allPlayLists.put(newPlaylist);
      await isarDBInstance.allSongs.put(newSong);
      await isarDBInstance.favouriteSongsLists.put(favouriteList);

      final deleteSong = await isarDBInstance.allSongs
          .filter()
          .songPathEqualTo("newSong1111")
          .deleteAll();
      debugPrint('Song deleted: $deleteSong');

      final deletePlaylist = await isarDBInstance.allPlayLists
          .filter()
          .playListNameEqualTo("newPlaylistName1111")
          .deleteAll();
      debugPrint('Song deleted: $deletePlaylist');

      final deleteFavourite = await isarDBInstance.favouriteSongsLists
          .filter()
          .songPathEqualTo("favourite1111")
          .deleteAll();
      debugPrint('Song deleted: $deleteFavourite');
    });
  }

  Future<void> _onRetrieveAllPlayListsFunction(Isar isarDBInstance) async {
    final playlists = await isarDBInstance.allPlayLists.where().findAll();
    final playListNames =
        playlists.map((playlist) => playlist.playListName).toList();

    // Remove playlists from the database if they are not in allPlayLists
    for (int i = allPlayLists.length - 1; i >= 0; i--) {
      if (!playlists
          .any((playlist) => playlist.playListName == allPlayLists[i])) {
        await isarDBInstance.writeTxn(() async {
          final deletePlaylist = await isarDBInstance.allPlayLists
              .filter()
              .playListNameEqualTo(allPlayLists[i])
              .deleteAll();
          debugPrint('Playlist deleted: $deletePlaylist');
        });

        setState(() {
          allPlayLists.removeAt(i);
        });
      }
    }

    // Add new playlists from the database to allPlayLists
    for (final playlistName in playListNames) {
      if (!allPlayLists.contains(playlistName)) {
        setState(() {
          allPlayLists.add(playlistName ?? "");
        });
      }
    }

    debugPrint('Playlists retrieved: $allPlayLists');
  }
}
