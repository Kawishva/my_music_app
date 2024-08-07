import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audiotags/audiotags.dart';
import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
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

  /// Initializes the database and sets up the Isar database instance.
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

  /// Handles the folder path selection and imports songs if available.
  Future<void> onFolderPathPick(String? directoryPath) async {
    if (directoryPath != null) {
      final Directory dir = Directory(directoryPath);

      // Filter files for mp3 and mp4 extensions
      final List<File> importedSongsPathList = dir
          .listSync()
          .where((item) =>
              item.path.endsWith('.mp3') || item.path.endsWith('.mp4'))
          .map((item) => File(item.path))
          .toList();

      if (importedSongsPathList.isNotEmpty) {
        for (var songPath in importedSongsPathList) {
          String? title = "";
          String? trackArtist = "";
          List<Picture>? pictures;
          Uint8List imageBytes = Uint8List(0); // Default value

          if (songPath.path.endsWith('.mp3')) {
            Tag? tag = await AudioTags.read(songPath.path);
            title = tag?.title ??
                "${songPath.path.replaceFirst("${dir.path}\\", "").replaceAll(".mp3", "")}";
            trackArtist = tag?.trackArtist ?? "";
            pictures = tag?.pictures;

            if (pictures!.isNotEmpty) {
              for (var picture in pictures) {
                if (picture.bytes.isNotEmpty) {
                  imageBytes = picture.bytes;
                  break;
                }
              }
            }
          } else {
            String? videoThumbNailPath = songPath.path.replaceAll(".mp4", "");
            title = videoThumbNailPath.replaceFirst("${dir.path}\\", "");

            debugPrint(title);
            final hasThumbnail = await FcNativeVideoThumbnail()
                .getVideoThumbnail(
                    srcFile: songPath.path,
                    destFile: videoThumbNailPath,
                    width: 800,
                    height: 800,
                    quality: 100,
                    format: 'png',
                    keepAspectRatio: true);

            if (hasThumbnail) {
              var vedioThumbNailImage = File(videoThumbNailPath);
              imageBytes = vedioThumbNailImage.readAsBytesSync();
              debugPrint("has thumbnail");
              vedioThumbNailImage.deleteSync();
            } else {
              debugPrint("no thumbnail");
            }
          }

          // Add song to the list if it's not already present
          if (!songDataList.any((song) => song.songTitle == title)) {
            songDataList.add(SongDataClass(
                title, trackArtist, imageBytes, songPath.path, false, false));
          } else {
            debugPrint("song is already in!");
          }

          await saveFolderPathToDataBase(directoryPath);
        }
        notifyListeners();
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

  /// Fetches all folder paths from the database and updates the list.
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

  /// Fetches songs from folders at startup.
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
            .where((item) =>
                item.path.endsWith('.mp3') || item.path.endsWith('.mp4'))
            .map((item) => File(item.path))
            .toList();

        debugPrint(favouriteSongsTitles.length.toString());
        if (importedSongsPathList.isNotEmpty) {
          for (var songPath in importedSongsPathList) {
            String? title = "";
            String? trackArtist = "";
            List<Picture>? pictures;
            Uint8List imageBytes = Uint8List(0); // Default value

            if (songPath.path.endsWith('.mp3')) {
              Tag? tag = await AudioTags.read(songPath.path);
              title = tag?.title ??
                  "${songPath.path.replaceFirst("${dir.path}\\", "").replaceAll(".mp3", "")}";
              trackArtist = tag?.trackArtist ?? "";
              pictures = tag?.pictures;

              if (pictures!.isNotEmpty) {
                for (var picture in pictures) {
                  if (picture.bytes.isNotEmpty) {
                    imageBytes = picture.bytes;
                    break;
                  }
                }
              }
            } else {
              String? videoThumbNailPath = songPath.path.replaceAll(".mp4", "");
              title = videoThumbNailPath.replaceFirst("${dir.path}\\", "");

              debugPrint(title);
              final hasThumbnail = await FcNativeVideoThumbnail()
                  .getVideoThumbnail(
                      srcFile: songPath.path,
                      destFile: videoThumbNailPath,
                      width: 800,
                      height: 800,
                      quality: 100,
                      format: 'png',
                      keepAspectRatio: true);

              if (hasThumbnail) {
                var vedioThumbNailImage = File(videoThumbNailPath);
                imageBytes = vedioThumbNailImage.readAsBytesSync();
                debugPrint("has thumbnail");
                vedioThumbNailImage.deleteSync();
              } else {
                debugPrint("no thumbnail");
              }
            }

            if (favouriteSongsTitles.isNotEmpty) {
              bool isFavourite = false;

              for (var favsongTitle in favouriteSongsTitles) {
                if (favsongTitle.songTitle == title) {
                  isFavourite = true;
                  break;
                }
              }

              songDataList.add(SongDataClass(
                title,
                trackArtist,
                imageBytes,
                songPath.path,
                false,
                isFavourite,
              ));
            } else {
              songDataList.add(SongDataClass(
                  title, trackArtist, imageBytes, songPath.path, false, false));
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

  /// Fetches all playlists from the database and updates the list.
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

  /// Fetches temporary playlist for a selected song.
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

  /// Adds or removes selected songs to/from the selected playlist.
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

  /// Fetches songs for the selected playlist.
  Future<void> fetchSongsListToSelectedPlayList(int playListId) async {
    selectedPlayListSongsDataList.clear(); // Clear existing data

    final favouriteSongsTitles =
        await isarDBInstance.favouriteSongsDatas.where().findAll();
    final favouriteSongsSet =
        favouriteSongsTitles.map((song) => song.songTitle).toSet();

    final selectedPlayListInDataBase =
        await isarDBInstance.playListsDatas.get(playListId);

    if (selectedPlayListInDataBase != null) {
      for (var songTitle in selectedPlayListInDataBase.songsTitle) {
        for (var songData in songDataList) {
          if (songData.songTitle == songTitle) {
            bool isFavourite = favouriteSongsSet.contains(songData.songTitle);
            selectedPlayListSongsDataList.add(
              SongDataClass(
                songData.songTitle,
                songData.artistName,
                songData.imageByteArray,
                songData.songPath,
                false,
                isFavourite,
              ),
            );
            break; // Break the inner loop once the song is found
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
        for (var favSong in favouriteSongsList) {
          if (favSong.songTitle != songTitle) {
            final newFavouriteSongTitle = FavouriteSongsData()
              ..songTitle = songTitle;
            await isarDBInstance.favouriteSongsDatas.put(newFavouriteSongTitle);
            break;
          } else {
            await isarDBInstance.favouriteSongsDatas
                .filter()
                .songTitleEqualTo(songTitle)
                .deleteAll();
            break;
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

  /// Shuffles the list of songs.
  void shuffleSongs() {
    songDataList.shuffle();
    notifyListeners();
  }

  /// Fetches favourite songs from the list of all songs.
  Future<void> fetchFavouriteSongsFromSongData() async {
    final favouriteSongTitles =
        await isarDBInstance.favouriteSongsDatas.where().findAll();
    final favouriteSongTitlesSet =
        favouriteSongTitles.map((favSong) => favSong.songTitle).toSet();

    if (favouriteSongDataList.isEmpty) {
      // Initial population of the favouriteSongDataList
      for (var song in songDataList) {
        if (favouriteSongTitlesSet.contains(song.songTitle)) {
          favouriteSongDataList.add(song);
        }
      }
    } else {
      // Update existing list
      // Remove non-favourites
      favouriteSongDataList.removeWhere(
          (song) => !favouriteSongTitlesSet.contains(song.songTitle));

      // Add new favourites
      for (var song in songDataList) {
        if (favouriteSongTitlesSet.contains(song.songTitle) &&
            !favouriteSongDataList.contains(song)) {
          favouriteSongDataList.add(song);
        }
      }
    }

    notifyListeners();
  }
}
