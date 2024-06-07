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

  static Future<void> databaseInitialize() async {
    final dir = await getApplicationSupportDirectory();
    isarDBInstance = await Isar.open([
      AllSongsSchema,
      PlayListsSchema,
      RecentSongsSchema,
      ImportedFoldersSchema
    ], directory: dir.path, inspector: true);
  }

  final List<SongData> songDataList = [];
  final List<SongData> favouriteSongDataList = [];
  final List<PlayListData> playListDataList = [];
  final List<String> folderDirectoryPathList = [];

  final List<int> recentSongsIdList = [];

  Future<void> onFolderPathPick(String? directoryPath) async {
    if (directoryPath != null) {
      debugPrint("selected folder Path : $directoryPath");
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
        debugPrint("no song found");
      }
    } else {
      // User canceled the picker
      return;
    }
  }

  Future<void> saveFolderPathToDataBase(String directoryPath) async {
    // Create a new folder object
    final newFolderPath = ImportedFolders()
      ..importedFollderPath = directoryPath;

    // Retrieve all existing folder paths
    final folderPathsFromDataBase =
        await isarDBInstance.importedFolders.where().findAll();

    // Check if the new folder path is already in the database
    if (!folderPathsFromDataBase.contains(newFolderPath)) {
      // If not, save the new folder path
      await isarDBInstance.writeTxn(() async {
        await isarDBInstance.importedFolders.put(newFolderPath);
      });
      fetchFolderPathsFromDataBase();
    } else {
      debugPrint('Folder path already exists in the database: $directoryPath');
    }
  }

  Future<void> fetchFolderPathsFromDataBase() async {
    // Retrieve all existing folder paths
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
    debugPrint('Song IDs retrieved: $folderDirectoryPathList');
  }

  Future<void> saveAllImportedSongPathsToDataBase(
      List<File> importedSongsPathList) async {
    final importedSongsPaths = importedSongsPathList
        .map((file) => AllSongs()..songPath = file.path)
        .toList();

    final songsPathsFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    for (var newSongPath in importedSongsPaths) {
      if (!songsPathsFromDataBase.contains(newSongPath.songPath)) {
        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.allSongs.put(newSongPath);
        });
      }
    }
    await fetchSongDataFromDataBase();
  }

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
    debugPrint('Song IDs retrieved: ${songDataList.first}');
  }

  Future<void> saveNewPlayListToDataBase(String newPLayListName) async {
    final newPlaylist = PlayLists()
      ..playListName = newPLayListName
      ..songsIdList = [];

    await isarDBInstance.writeTxn(() async {
      await isarDBInstance.playLists.put(newPlaylist);
    });
    await fetchAllPlayListsDataFromDataBase();

    debugPrint('Playlist name saved to database: $newPlaylist');
  }

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

  Future<void> addOrRemoveSongFromFavourite(int songId) async {
    await isarDBInstance.writeTxn(() async {
      // Retrieve the song by ID
      final songToUpdate = await isarDBInstance.allSongs.get(songId);

      if (songToUpdate != null) {
        final bool isMyFavourite = songToUpdate.songIsMyFavourite;
        // Update the songIsMyFavourite field
        songToUpdate.songIsMyFavourite = !isMyFavourite;
        await isarDBInstance.allSongs.put(songToUpdate); // Save the changes
      }
    });
    notifyListeners();
  }

  Future<void> songPalyAndPause(int songId) async {
    await isarDBInstance.writeTxn(() async {
      // Retrieve the song by ID
      final songToUpdate = await isarDBInstance.allSongs.get(songId);

      if (songToUpdate != null) {
        final bool isPlaying = songToUpdate.songIsPlaying;
        // Update the songIsMyFavourite field
        songToUpdate.songIsPlaying = !isPlaying;
        await isarDBInstance.allSongs.put(songToUpdate); // Save the changes
      }
    });
    notifyListeners();
  }

  Stream<AllSongs?> watchSong(int songId) {
    return isarDBInstance.allSongs.watchObject(songId, fireImmediately: true);
  }

  Stream<void> watchOnAllSongs() {
    return isarDBInstance.allSongs.watchLazy();
  }
}
