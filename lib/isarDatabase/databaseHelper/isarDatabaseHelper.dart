import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audiotags/audiotags.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../mainDatabaseCtreation/favorite_songs_list.dart';
import '../mainDatabaseCtreation/imported_folders.dart';
import '../mainDatabaseCtreation/playlist_data.dart';
import 'playlist.dart';
import 'song.dart';
import 'temporyPlayList.dart';

class DataBaseHelper extends ChangeNotifier {
  static late Isar isarDBInstance;

  /// Initializes the database and sets all songs to not playing.
  static Future<void> databaseInitialize() async {
    final dir = await getApplicationSupportDirectory();
    isarDBInstance = await Isar.open(
        [FavouriteSongsDataSchema, PlayListsDataSchema, ImportedFoldersSchema],
        directory: dir.path, inspector: true);
  }

  final List<TemporyPlayList> temporyPlayListdataList = [];
  final List<SongDataClass> songDataList = [];
  final List<SongDataClass> favouriteSongDataList = [];
  final List<SongDataClass> selectedPlayListSongsDataList = [];
  final List<PlayListClass> playListDataList = [];
  final List<String> folderDirectoryPathList = [];
  //final List<int> recentSongsIdList = [];

  /// Handles the folder path selection and imports songs if available.
  Future<void> onFolderPathPick(String? directoryPath) async {
    if (directoryPath != null) {
      final Directory dir = Directory(directoryPath);

      final List<File> importedSongsPathList = dir
          .listSync()
          .where((item) => item.path.endsWith('.mp3'))
          .map((item) => File(item.path))
          .toList();
      debugPrint(importedSongsPathList.length.toString());
      if (importedSongsPathList.isNotEmpty) {
        for (var songPath in importedSongsPathList) {
          String? title;
          String? trackArtist;
          List<Picture>? pictures;
          Uint8List imageBytes = Uint8List(0); // Default value

          Tag? tag = await AudioTags.read(songPath.path);
          title = tag?.title;
          trackArtist =
              tag?.trackArtist; // Corrected from trackArtist to artist
          pictures = tag?.pictures;

          if (pictures!.isNotEmpty) {
            for (var picture in pictures) {
              if (picture.bytes.isNotEmpty) {
                imageBytes = picture.bytes;
                break;
              }
            }
          }
          songDataList.add(SongDataClass(
              title ?? "${songPath.path.replaceFirst("${dir.path}\\", "")}",
              trackArtist ?? "",
              imageBytes,
              songPath.path,
              false,
              false));

          notifyListeners();
          await saveFolderPathToDataBase(directoryPath);
        }
      } else {
        debugPrint("no songs found!");
      }
    } else {
      debugPrint("file picker canceled");
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
        debugPrint("folder path added to database");
      });
    }
    notifyListeners();
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

  Future<void> fetchSongAtStartUp() async {
    final folderPathsDataFromDataBase =
        await isarDBInstance.importedFolders.where().findAll();
    final favouriteSongsTitles =
        await isarDBInstance.favouriteSongsDatas.where().findAll();

    if (folderPathsDataFromDataBase.isNotEmpty) {
      for (var directoryPath in folderPathsDataFromDataBase) {
        final Directory dir =
            Directory(directoryPath.importedFollderPath.toString());

        final List<File> importedSongsPathList = dir
            .listSync()
            .where((item) => item.path.endsWith('.mp3'))
            .map((item) => File(item.path))
            .toList();

        debugPrint(importedSongsPathList.first.toString());
        if (importedSongsPathList.isNotEmpty) {
          for (var songPath in importedSongsPathList) {
            String? title;
            String? trackArtist;
            List<Picture>? pictures;
            Uint8List imageBytes = Uint8List(0); // Default value

            Tag? tag = await AudioTags.read(songPath.path);
            title = tag?.title;
            trackArtist =
                tag?.trackArtist; // Corrected from trackArtist to artist
            pictures = tag?.pictures;

            if (pictures!.isNotEmpty) {
              for (var picture in pictures) {
                if (picture.bytes.isNotEmpty) {
                  imageBytes = picture.bytes;
                  break;
                }
              }
            }

            if (favouriteSongsTitles.isNotEmpty) {
              for (int i = 0; i < favouriteSongsTitles.length; i++) {
                if (favouriteSongsTitles[i].songTitle == title) {
                  songDataList.add(SongDataClass(
                      title ??
                          "${songPath.path.replaceFirst("${dir.path}\\", "")}",
                      trackArtist ?? "",
                      imageBytes,
                      songPath.path,
                      false,
                      true));
                } else {
                  songDataList.add(SongDataClass(
                      title ??
                          "${songPath.path.replaceFirst("${dir.path}\\", "")}",
                      trackArtist ?? "",
                      imageBytes,
                      songPath.path,
                      false,
                      false));
                }
              }
            } else {
              songDataList.add(SongDataClass(
                  title ?? "${songPath.path.replaceFirst("${dir.path}\\", "")}",
                  trackArtist ?? "",
                  imageBytes,
                  songPath.path,
                  false,
                  false));
              debugPrint(songDataList.first.toString());
            }
          }
        }
        importedSongsPathList.clear();
        notifyListeners();
      }
    } else {
      debugPrint("startup !");
    }
  }

  /// Saves a new playlist to the database.
  Future<void> saveNewPlayListToDataBase(String newPLayListName) async {
    final newPlaylist = PlayListsData()
      ..playListName = newPLayListName
      ..songsTitle = List.empty(growable: true);

    await isarDBInstance.writeTxn(() async {
      await isarDBInstance.playListsDatas.put(newPlaylist);
    });
    await fetchAllPlayListsDataFromDataBase();
  }

  /// Fetches all playlists from the database.
  Future<void> fetchAllPlayListsDataFromDataBase() async {
    final playListDataListFromDataBase =
        await isarDBInstance.playListsDatas.where().findAll();

    for (var playlistDataFromDB in playListDataListFromDataBase) {
      if (!playListDataList.any((playList) =>
          playList.playListName == playlistDataFromDB.playListName)) {
        playListDataList.add(PlayListClass(
            playlistDataFromDB.playListId,
            playlistDataFromDB.playListName.toString(),
            playlistDataFromDB.songsTitle));
      }
    }
    notifyListeners();
  }

  Future<void> fetchTemporyPlayListLibraryForSelectedSong(
      String songTitle) async {
    temporyPlayListdataList.clear();
    final playListDataFromDataBase =
        await isarDBInstance.playListsDatas.where().findAll();

    for (var playlistData in playListDataFromDataBase) {
      if (playlistData.songsTitle.contains(songTitle)) {
        temporyPlayListdataList.add(TemporyPlayList(songTitle,
            playlistData.playListId, playlistData.playListName!, true));
      } else {
        temporyPlayListdataList.add(TemporyPlayList(songTitle,
            playlistData.playListId, playlistData.playListName!, false));
      }
    }
    notifyListeners();
  }

  Future<void> addOrRemoveSelectedSongsToSelectedPlayList(
      int playListId, String songTitle) async {
    final selectedPlayListInDataBase =
        await isarDBInstance.playListsDatas.get(playListId);

    if (selectedPlayListInDataBase != null) {
      if (!selectedPlayListInDataBase.songsTitle.contains(songTitle)) {
        selectedPlayListInDataBase.songsTitle = List<String>.from(
            selectedPlayListInDataBase.songsTitle); // Ensure it's growable
        selectedPlayListInDataBase.songsTitle.add(songTitle);

        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.playListsDatas.put(selectedPlayListInDataBase);
        });
      } else {
        selectedPlayListInDataBase.songsTitle = List<String>.from(
            selectedPlayListInDataBase.songsTitle); // Ensure it's growable
        selectedPlayListInDataBase.songsTitle.remove(songTitle);

        await isarDBInstance.writeTxn(() async {
          await isarDBInstance.playListsDatas.put(selectedPlayListInDataBase);
        });
      }
    }
    await fetchSongsListToSelectedPlayList(playListId);
    notifyListeners();
  }

  Future<void> fetchSongsListToSelectedPlayList(int playListId) async {
    selectedPlayListSongsDataList.clear(); // Clear existing data
    final favouriteSongsTitles =
        await isarDBInstance.favouriteSongsDatas.where().findAll();

    final selectedPlayListInDataBase =
        await isarDBInstance.playListsDatas.get(playListId);

    if (selectedPlayListInDataBase != null) {
      for (var songTitle in selectedPlayListInDataBase.songsTitle) {
        for (var songData in songDataList) {
          if (songData.songTitle == songTitle) {
            String? title;
            String? trackArtist;
            List<Picture>? pictures;

            Tag? tag = await AudioTags.read(songData.songPath);
            title = tag?.title;
            trackArtist = tag?.trackArtist;
            pictures = tag?.pictures;

            for (var favouriteSongTile in favouriteSongsTitles) {
              if (favouriteSongTile == title) {
                selectedPlayListSongsDataList.add(SongDataClass(
                    title ?? "no name",
                    trackArtist ?? "no name",
                    pictures?.first.bytes ?? Uint8List(0),
                    songData.songPath.toString(),
                    false,
                    true));
              } else {
                selectedPlayListSongsDataList.add(SongDataClass(
                    title ?? "no name",
                    trackArtist ?? "no name",
                    pictures?.first.bytes ?? Uint8List(0),
                    songData.songPath.toString(),
                    false,
                    false));
              }
            }
          }
        }
      }
    }
    notifyListeners();
  }

  /// Adds or removes a song from the favourites list in the database.
  Future<void> addOrRemoveSongFromFavourite(String songTitle) async {
    await isarDBInstance.writeTxn(() async {
      final favouriteSongsList =
          await isarDBInstance.favouriteSongsDatas.where().findAll();

      if (favouriteSongsList.isNotEmpty) {
        for (int i = 0; i < favouriteSongsList.length; i++) {
          if (favouriteSongsList[i].songTitle != songTitle) {
            final newFavouriteSongTitle = FavouriteSongsData()
              ..songTitle = songTitle;
            await isarDBInstance.favouriteSongsDatas.put(newFavouriteSongTitle);
          } else {
            await isarDBInstance.favouriteSongsDatas
                .filter()
                .songTitleEqualTo(songTitle)
                .deleteAll();
          }
        }
      } else {
        final newFavouriteSongTitle = FavouriteSongsData()
          ..songTitle = songTitle;
        await isarDBInstance.favouriteSongsDatas.put(newFavouriteSongTitle);
      }
    });

    for (var song in songDataList) {
      if (song.songTitle == songTitle) {
        song.songIsMyFavourite = !song.songIsMyFavourite;
        debugPrint(song.songTitle);
      }
    }

    for (var song in selectedPlayListSongsDataList) {
      if (song.songTitle == songTitle) {
        song.songIsMyFavourite = !song.songIsMyFavourite;
      }
    }

    await fetchFavouriteSongsFromSongData();
    notifyListeners();
  }

  void shuffleSongs() {
    songDataList.shuffle();
    // favouriteSongDataList.shuffle();
    // selectedPlayListSongsDataList.shuffle();
    notifyListeners();
  }

  Future<void> fetchFavouriteSongsFromSongData() async {
    final favouriteSongTitles =
        await isarDBInstance.favouriteSongsDatas.where().findAll();

    for (int i = 0; i < favouriteSongTitles.length; i++) {
      for (var song in songDataList) {
        if (favouriteSongTitles[i].songTitle == song.songTitle &&
            !favouriteSongTitles.contains(song.songTitle)) {
          favouriteSongDataList.add(song);
          notifyListeners();
        }
      }
    }
  }

  void setSongPlayAndPause(SongDataClass selectedSong) {
    // Update the local songDataList

    for (var song in songDataList) {
      if (song == selectedSong) {
        song.songIsPlaying = !song.songIsPlaying;
      } else {
        song.songIsPlaying = false;
      }
    }

    for (var song in selectedPlayListSongsDataList) {
      if (song == selectedSong) {
        song.songIsPlaying = !song.songIsPlaying;
      } else {
        song.songIsPlaying = false;
      }
    }

    // Update the local favouriteSongDataList
    for (var song in favouriteSongDataList) {
      if (song == selectedSong) {
        song.songIsPlaying = !song.songIsPlaying;
      } else {
        song.songIsPlaying = false;
      }
    }
  }
}
