import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audiotags/audiotags.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../mainDatabaseCtreation/all_songs.dart';
import '../mainDatabaseCtreation/imported_folders.dart';
import '../mainDatabaseCtreation/play_lists.dart';
import '../mainDatabaseCtreation/recent_songs.dart';
import 'playlist.dart';
import 'song.dart';
import 'temporyPlayList.dart';

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

  final List<TemporyPlayList> temporyPlayListdataList = [];
  final List<SongData> songDataList = [];
  final List<SongData> favouriteSongDataList = [];
  final List<SongData> selectedPlayListSongsDataList = [];
  final List<PlayListData> playListDataList = [];
  final List<String> folderDirectoryPathList = [];
  final List<int> recentSongsIdList = [];

  /// Handles the folder path selection and imports songs if available.
  Future<void> onFolderPathPick(String? directoryPath) async {
    if (directoryPath != null) {
      final Directory dir = Directory(directoryPath);

      final List<File> importedSongsPathList = dir
          .listSync()
          .where((item) => item.path.endsWith('.mp3'))
          .map((item) => File(item.path))
          .toList();

      if (importedSongsPathList.isNotEmpty) {
        await saveFolderPathToDataBase(directoryPath);
        await saveAllImportedSongPathsToDataBase(importedSongsPathList);
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
          await isarDBInstance.allSongs
              .filter()
              .songIdEqualTo(songData.songId)
              .deleteAll();
        });

        songDataList.remove(songData);
      }
    }

    for (var songDatafromDB in songDataListFromDataBase) {
      if (!songDataList.any((song) => song.songId == songDatafromDB.songId)) {
        String? title;
        String? trackArtist;
        List<Picture>? pictures;

        try {
          if (songDatafromDB.songPath != null &&
              songDatafromDB.songPath!.isNotEmpty) {
            Tag? tag = await AudioTags.read(songDatafromDB.songPath!);
            title = tag?.title;
            trackArtist =
                tag?.trackArtist; // Corrected from trackArtist to artist
            pictures = tag?.pictures;
          }
        } catch (e) {
          // Handle the exception by logging or providing a default value
          print("Error reading audio tags: $e");
        }

        songDataList.add(SongData(
            songDatafromDB.songId,
            title ?? "no name",
            trackArtist ?? "no name",
            pictures?.first.bytes ?? Uint8List(0),
            songDatafromDB.songPath.toString(),
            songDatafromDB.songIsPlaying,
            songDatafromDB.songIsMyFavourite));
      }
    }

    notifyListeners();
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
  }

  /// Fetches all playlists from the database.
  Future<void> fetchAllPlayListsDataFromDataBase() async {
    final playListDataListFromDataBase =
        await isarDBInstance.playLists.where().findAll();

    for (var playlistDataFromDB in playListDataListFromDataBase) {
      if (!playListDataList.any((playList) =>
          playList.playListName == playlistDataFromDB.playListName)) {
        playListDataList.add(PlayListData(
            playlistDataFromDB.playListId,
            playlistDataFromDB.playListName.toString(),
            playlistDataFromDB.songsIdList));
      }
    }
    notifyListeners();
  }

  Future<void> temporyPlayListLibraryForSelectedSong(int songId) async {
    temporyPlayListdataList.clear();
    final playListDataFromDataBase =
        await isarDBInstance.playLists.where().findAll();

    for (var playlistData in playListDataFromDataBase) {
      if (playlistData.songsIdList.contains(songId)) {
        temporyPlayListdataList.add(TemporyPlayList(
            songId, playlistData.playListId, playlistData.playListName!, true));
      } else {
        temporyPlayListdataList.add(TemporyPlayList(songId,
            playlistData.playListId, playlistData.playListName!, false));
      }
    }
    notifyListeners();
  }

  Future<void> addOrRemoveSelectedSongsToSelectedPlayList(
      int playListId, int songId) async {
    final selectedPlayListInDataBase =
        await isarDBInstance.playLists.get(playListId);

    if (selectedPlayListInDataBase != null) {
      if (!selectedPlayListInDataBase.songsIdList.contains(songId)) {
        selectedPlayListInDataBase.songsIdList = List<int>.from(
            selectedPlayListInDataBase.songsIdList); // Ensure it's growable
        selectedPlayListInDataBase.songsIdList.add(songId);

        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.playLists.put(selectedPlayListInDataBase);
        });
      } else {
        selectedPlayListInDataBase.songsIdList = List<int>.from(
            selectedPlayListInDataBase.songsIdList); // Ensure it's growable
        selectedPlayListInDataBase.songsIdList.remove(songId);

        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.playLists.put(selectedPlayListInDataBase);
        });
      }
    }
    await fetchSongsListToSelectedPlayList(playListId);
    notifyListeners();
  }

  Future<void> fetchSongsListToSelectedPlayList(int playListId) async {
    selectedPlayListSongsDataList.clear(); // Clear existing data
    //debugPrint(playListId.toString());

    final selectedPlayListInDataBase =
        await isarDBInstance.playLists.get(playListId);
    final songDataListFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    if (selectedPlayListInDataBase != null) {
      for (var songId in selectedPlayListInDataBase.songsIdList) {
        for (var songData in songDataListFromDataBase) {
          if (songData.songId == songId) {
            String? title;
            String? trackArtist;
            List<Picture>? pictures;

            try {
              if (songData.songPath != null && songData.songPath!.isNotEmpty) {
                Tag? tag = await AudioTags.read(songData.songPath!);
                title = tag?.title;
                trackArtist = tag?.trackArtist;
                pictures = tag?.pictures;
              }
            } catch (e) {
              // Handle the exception by logging or providing a default value
              print("Error reading audio tags: $e");
            }

            selectedPlayListSongsDataList.add(SongData(
                songData.songId,
                title ?? "no name",
                trackArtist ?? "no name",
                pictures?.first.bytes ?? Uint8List(0),
                songData.songPath.toString(),
                songData.songIsPlaying,
                songData.songIsMyFavourite));
          }
        }
      }
    }

    notifyListeners();
  }

  /// Adds or removes a song from the favourites list in the database.
  Future<void> addOrRemoveSongFromFavourite(int songId) async {
    await isarDBInstance.writeTxn(() async {
      final songToUpdate = await isarDBInstance.allSongs.get(songId);

      if (songToUpdate != null) {
        final bool isMyFavourite = songToUpdate.songIsMyFavourite;
        songToUpdate.songIsMyFavourite = !isMyFavourite;
        for (var song in songDataList) {
          if (song.songId == songId) {
            song.songIsMyFavourite = !isMyFavourite;
          }
        }
        await isarDBInstance.allSongs.put(songToUpdate);
      }
    });

    for (var song in selectedPlayListSongsDataList) {
      if (song.songId == songId) {
        song.songIsMyFavourite = !song.songIsMyFavourite;
      }
    }

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
        String? title;
        String? trackArtist;
        List<Picture>? pictures;

        try {
          if (favouriteSongDatafromDB.songPath != null &&
              favouriteSongDatafromDB.songPath!.isNotEmpty) {
            Tag? tag = await AudioTags.read(favouriteSongDatafromDB.songPath!);
            title = tag?.title;
            trackArtist =
                tag?.trackArtist; // Corrected from trackArtist to artist
            pictures = tag?.pictures;
          }
        } catch (e) {
          // Handle the exception by logging or providing a default value
          print("Error reading audio tags: $e");
        }

        favouriteSongDataList.add(SongData(
            favouriteSongDatafromDB.songId,
            title!,
            trackArtist!,
            pictures!.first.bytes,
            favouriteSongDatafromDB.songPath.toString(),
            favouriteSongDatafromDB.songIsPlaying,
            favouriteSongDatafromDB.songIsMyFavourite));
      }
    }
    await fetchSongDataFromDataBase();
    notifyListeners();
  }

  /// Toggles the play/pause state of a song and updates the database accordingly.
  Future<void> songPalyAndPause(int songId) async {
    final songDataListFromDataBase =
        await isarDBInstance.allSongs.where().findAll();

    await isarDBInstance.writeTxn(() async {
      // Set all other songs to not playing
      for (var songDatafromDB in songDataListFromDataBase) {
        if (songDatafromDB.songId != songId) {
          songDatafromDB.songIsPlaying = false;
          await isarDBInstance.allSongs.put(songDatafromDB);
        }
      }

      // Update the selected song's playing state
      final songToUpdate = await isarDBInstance.allSongs.get(songId);
      if (songToUpdate != null) {
        final bool isPlaying = songToUpdate.songIsPlaying;
        songToUpdate.songIsPlaying = !isPlaying;
        await isarDBInstance.allSongs.put(songToUpdate);

        // Update the local songDataList
        for (var song in songDataList) {
          if (song.songId == songId) {
            song.songIsPlaying = !isPlaying;
          } else {
            song.songIsPlaying = false;
          }
        }

        for (var song in selectedPlayListSongsDataList) {
          if (song.songId == songId) {
            song.songIsPlaying = !isPlaying;
          } else {
            song.songIsPlaying = false;
          }
        }

        // Update the local favouriteSongDataList
        for (var song in favouriteSongDataList) {
          if (song.songId == songId) {
            song.songIsPlaying = !isPlaying;
          } else {
            song.songIsPlaying = false;
          }
        }
      }
    });
    notifyListeners();
  }

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

  void shuffleSongs() {
    songDataList.shuffle();
    favouriteSongDataList.shuffle();
    selectedPlayListSongsDataList.shuffle();
    notifyListeners();
  }
}
