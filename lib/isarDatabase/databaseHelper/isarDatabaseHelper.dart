import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../mainDatabaseCtreation/all_songs.dart';
import '../mainDatabaseCtreation/imported_folders.dart';
import '../mainDatabaseCtreation/play_lists.dart';
import '../mainDatabaseCtreation/recent_songs.dart';
import 'playlist.dart';
import 'song.dart';

class DataBaseHelper extends ChangeNotifier {
  static late Isar isarDBInstance;

  /// Initializes the database and sets all songs to not playing.
  static Future<void> databaseInitialize() async {
    final dir = await getApplicationSupportDirectory();
    isarDBInstance = await Isar.open([
      AllSongsSchema,
      PlayListsSchema,
      RecentSongsSchema,
      ImportedFoldersSchema
    ], directory: dir.path, inspector: true);

    await setAllSongsToNotPlaying();
  }

  final List<SongData> songDataList = [];
  final List<SongData> favouriteSongDataList = [];
  final List<PlayListData> playListDataList = [];
  final List<String> folderDirectoryPathList = [];
  final List<int> recentSongsIdList = [];

  /// Handles the folder path selection and imports songs if available.
  Future<void> onFolderPathPick(String? directoryPath) async {
    if (directoryPath != null) {
      debugPrint("Selected folder Path: $directoryPath");
      final Directory dir = Directory(directoryPath);

      final List<File> importedSongsPathList = dir
          .listSync()
          .where((item) => item.path.endsWith('.mp3'))
          .map((item) => File(item.path))
          .toList();

      if (importedSongsPathList.isNotEmpty) {
        await saveFolderPathToDataBase(directoryPath);
        await saveAllImportedSongPathsToDataBase(importedSongsPathList);
      } else {
        debugPrint("No song found");
      }
    } else {
      // User canceled the picker
      return;
    }
  }

  /// Saves a folder path to the database if it doesn't already exist.
  Future<void> saveFolderPathToDataBase(String directoryPath) async {
    final newFolderPath = ImportedFolders()
      ..importedFollderPath = directoryPath;

    final folderPathsFromDataBase =
        await isarDBInstance.importedFolders.where().findAll();

    final exists = folderPathsFromDataBase.any((folder) =>
        folder.importedFollderPath == newFolderPath.importedFollderPath);

    if (!exists) {
      await isarDBInstance.writeTxn(() async {
        await isarDBInstance.importedFolders.put(newFolderPath);
      });
    } else {
      debugPrint('Folder path already exists in the database: $directoryPath');
    }
  }

  /// Fetches all folder paths from the database.
  Future<void> fetchFolderPathsFromDataBase() async {
    final folderPathsDataFromDataBase =
        await isarDBInstance.importedFolders.where().findAll();

    for (var folderPathsFromDB in folderPathsDataFromDataBase) {
      if (!folderDirectoryPathList
          .contains(folderPathsFromDB.importedFollderPath)) {
        folderDirectoryPathList
            .add(folderPathsFromDB.importedFollderPath.toString());
      }
    }
    notifyListeners();
    debugPrint('Folder paths retrieved: $folderDirectoryPathList');
  }

  /// Saves all imported song paths to the database if they don't already exist.
  Future<void> saveAllImportedSongPathsToDataBase(
      List<File> importedSongsPathList) async {
    final importedSongsPaths = importedSongsPathList
        .map((file) => AllSongs()..songPath = file.path)
        .toList();

    final songsPathsFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    for (var importedSong in importedSongsPaths) {
      final exists = songsPathsFromDataBase.any(
        (songDataFromDB) => songDataFromDB.songPath == importedSong.songPath,
      );

      if (!exists) {
        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.allSongs.put(importedSong);
        });
      }
    }

    await fetchSongDataFromDataBase();
  }

  /// Fetches all song data from the database and updates the local list.
  Future<void> fetchSongDataFromDataBase() async {
    final songDataListFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    for (var songData in songDataList) {
      if (!songDataListFromDataBase
          .any((songDatafromDB) => songDatafromDB.songId == songData.songId)) {
        await isarDBInstance.writeTxn(() async {
          final deleteNotAvailableSongPath = await isarDBInstance.allSongs
              .filter()
              .songIdEqualTo(songData.songId)
              .deleteAll();
          debugPrint('Song deleted: $deleteNotAvailableSongPath');
        });

        songDataList.remove(songData);
      }
    }

    for (var songDatafromDB in songDataListFromDataBase) {
      if (!songDataList.any((song) => song.songId == songDatafromDB.songId)) {
        songDataList.add(SongData(
            songDatafromDB.songId,
            songDatafromDB.songPath.toString(),
            songDatafromDB.songIsPlaying,
            songDatafromDB.songIsMyFavourite));
      }
    }

    notifyListeners();
    debugPrint('Songs retrieved: ${songDataList.first}');
  }

  /// Saves a new playlist to the database.
  Future<void> saveNewPlayListToDataBase(String newPLayListName) async {
    final newPlaylist = PlayLists()
      ..playListName = newPLayListName
      ..songsIdList = [];

    await isarDBInstance.writeTxn(() async {
      await isarDBInstance.playLists.put(newPlaylist);
    });
    await fetchAllPlayListsDataFromDataBase();

    debugPrint('Playlist saved to database: $newPlaylist');
  }

  /// Fetches all playlists from the database.
  Future<void> fetchAllPlayListsDataFromDataBase() async {
    final playListDataListFromDataBase =
        await isarDBInstance.playLists.where().findAll();

    for (var playlistDataFromDB in playListDataListFromDataBase) {
      if (!playListDataList.any((playList) =>
          playList.playListName == playlistDataFromDB.playListName)) {
        playListDataList.add(PlayListData(
            playlistDataFromDB.playListName.toString(),
            playlistDataFromDB.songsIdList));
      }
    }
    notifyListeners();
    debugPrint('Playlists retrieved: $playListDataList');
  }

  /// Adds or removes a song from the favourites list in the database.
  Future<void> addOrRemoveSongFromFavourite(int songId) async {
    await isarDBInstance.writeTxn(() async {
      final songToUpdate = await isarDBInstance.allSongs.get(songId);

      if (songToUpdate != null) {
        final bool isMyFavourite = songToUpdate.songIsMyFavourite;
        songToUpdate.songIsMyFavourite = !isMyFavourite;
        songDataList[songId - 1].songIsMyFavourite = !isMyFavourite;
        await isarDBInstance.allSongs.put(songToUpdate);
      }
    });

    await fetchFavouriteSongsFromSongData();
    notifyListeners();
  }

  /// Fetches all favourite songs from the database.
  Future<void> fetchFavouriteSongsFromSongData() async {
    final favouriteSongsListFromDataBase = await isarDBInstance.allSongs
        .filter()
        .songIsMyFavouriteEqualTo(true)
        .findAll();

    final songsToRemove = [];
    for (var favouriteSongData in favouriteSongDataList) {
      if (!favouriteSongsListFromDataBase.any((favouriteSongDatafromDB) =>
          favouriteSongDatafromDB.songId == favouriteSongData.songId)) {
        songsToRemove.add(favouriteSongData);
      }
    }

    for (var songData in songsToRemove) {
      favouriteSongDataList.remove(songData);
    }

    for (var favouriteSongDatafromDB in favouriteSongsListFromDataBase) {
      if (!favouriteSongDataList
          .any((song) => song.songId == favouriteSongDatafromDB.songId)) {
        favouriteSongDataList.add(SongData(
            favouriteSongDatafromDB.songId,
            favouriteSongDatafromDB.songPath.toString(),
            favouriteSongDatafromDB.songIsPlaying,
            favouriteSongDatafromDB.songIsMyFavourite));
      }
    }
    await fetchSongDataFromDataBase();
    notifyListeners();
    debugPrint('Favourite list: ${favouriteSongDataList.length}');
  }

  /// Toggles the play/pause state of a song and updates the database accordingly.
  Future<void> songPalyAndPause(int songId) async {
    final songDataListFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    await isarDBInstance.writeTxn(() async {
      for (var songDatafromDB in songDataListFromDataBase) {
        if (songDatafromDB.songId != songId) {
          songDatafromDB.songIsPlaying = false;
          await isarDBInstance.allSongs.put(songDatafromDB);
        }
      }
    });

    await isarDBInstance.writeTxn(() async {
      final songToUpdate = await isarDBInstance.allSongs.get(songId);

      if (songToUpdate != null) {
        final bool isPlaying = songToUpdate.songIsPlaying;
        songToUpdate.songIsPlaying = !isPlaying;

        if (favouriteSongDataList.contains(songId - 1)) {
          favouriteSongDataList.forEach((song) {
            song.songIsPlaying = false;
          });
          favouriteSongDataList[songId - 1].songIsPlaying = true;
        }
        songDataList.forEach((song) {
          song.songIsPlaying = false;
        });

        songDataList[songId - 1].songIsPlaying = !isPlaying;
        await isarDBInstance.allSongs.put(songToUpdate);
      }
    });

    notifyListeners();
  }

  /// Dummy method placeholder for future use.
  Future<void> getSongIsPlayingValueFromDataBase() async {}

  /// Sets all songs to not playing in the database.
  static Future<void> setAllSongsToNotPlaying() async {
    await isarDBInstance.writeTxn(() async {
      final songDataListFromDataBase =
          await isarDBInstance.allSongs.where().findAll();
      for (var songDatafromDB in songDataListFromDataBase) {
        songDatafromDB.songIsPlaying = false;
      }
      await isarDBInstance.allSongs.putAll(songDataListFromDataBase);
    });
  }
}
