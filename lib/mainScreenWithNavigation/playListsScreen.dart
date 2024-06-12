// ignore_for_file: must_be_immutable
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../generalFunctions/audioStream.dart';
import '../generalFunctions/navigationBarChange.dart';
import '../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../isarDatabase/databaseHelper/song.dart';
import 'models/playListsSelectionPopUpWindow.dart';

class PlayListsScreens extends StatefulWidget {
  List<SongDataClass> songsData = [];

  PlayListsScreens({
    super.key,
  });

  @override
  State<PlayListsScreens> createState() => _PlayListsScreensState();
}

class _PlayListsScreensState extends State<PlayListsScreens> {
  @override
  void initState() {
    // Initialize state by fetching data from the database
    widget.songsData.clear();
    readPlaylist();
    readFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);
    final audioStreamInstance = Provider.of<AudiostreamFunctions>(context);

    // Determine the list of songs to display based on the current navigation bar index
    List<SongDataClass> songDataList = dataBaseHelperContext.songDataList;
    List<SongDataClass> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongDataClass> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    if (navigationBarChangeInstance.navigationBarIndex == 0) {
      widget.songsData = songDataList;
    }
    if (navigationBarChangeInstance.navigationBarIndex == 1) {
      widget.songsData = favouriteSongDataList;
    }
    if (navigationBarChangeInstance.navigationBarIndex == 2) {
      widget.songsData = selectedPlayListSongsDataList;
    }
    return Container(
        child: GridView.builder(
            primary: true,
            padding: EdgeInsets.all(3), // Padding around the grid
            itemCount: widget.songsData.length, // Number of items in the grid
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 152, // Max width of each item
              crossAxisSpacing: 0, // Spacing between columns
              mainAxisSpacing: 0, // Spacing between rows
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF18D7FD).withOpacity(0.3),
                                spreadRadius: 2.5,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 0), // Changes position of shadow
                              )
                            ]),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            widget.songsData[index].imageByteArray.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      widget.songsData[index].imageByteArray,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Bootstrap.music_note_beamed,
                                    size: 60,
                                  ),
                            SizedBox(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                    onPressed: () => _songPalyAndPause(
                                        widget.songsData[index]),
                                    icon: Icon(
                                      audioStreamInstance.selectedSong ==
                                                  widget.songsData[index] &&
                                              audioStreamInstance
                                                      .getPlayerState ==
                                                  PlayerState.playing
                                          ? Bootstrap.pause_circle_fill
                                          : Bootstrap.play_circle_fill,
                                      size: 60,
                                      color:
                                          widget.songsData[index].songIsPlaying
                                              ? Colors.black.withOpacity(0.8)
                                              : Colors.black.withOpacity(0.3),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.transparent),
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.black.withOpacity(0.3)),
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.zero),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              50), // Rounded corners.
                                        ))))),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2, left: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: IconButton(
                                          onPressed: () =>
                                              _addOrRemoveSongFromFavourite(
                                                  widget.songsData[index]
                                                      .songTitle),
                                          style: ButtonStyle(
                                              padding: WidgetStateProperty.all(
                                                  EdgeInsets.zero),
                                              elevation:
                                                  WidgetStateProperty.all(0),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Rounded corners.
                                                ),
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.transparent),
                                              overlayColor:
                                                  WidgetStateProperty.all(
                                                      Colors.transparent)),
                                          icon: Icon(
                                            widget.songsData[index]
                                                    .songIsMyFavourite
                                                ? Bootstrap.heart_fill
                                                : Bootstrap.heart,
                                            size: 23,
                                            color: widget.songsData[index]
                                                    .songIsMyFavourite
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        )),
                                    Builder(builder: (newContext) {
                                      return SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: IconButton(
                                          onPressed: () => _onCreatePopUpWindow(
                                              context, widget.songsData[index]),
                                          style: ButtonStyle(
                                              padding: WidgetStateProperty.all(
                                                  EdgeInsets.zero),
                                              elevation:
                                                  WidgetStateProperty.all(0),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Rounded corners.
                                                ),
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(Colors
                                                      .white
                                                      .withOpacity(0.1)),
                                              overlayColor:
                                                  WidgetStateProperty.all(Colors
                                                      .black
                                                      .withOpacity(0.05))),
                                          icon: Icon(
                                            Bootstrap.three_dots_vertical,
                                            size: 17,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Tooltip(
                          message: widget.songsData[index].songTitle,
                          child: Text(
                            widget.songsData[index].songTitle,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alatsi(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.songsData[index].artistName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.alatsi(
                          //letterSpacing: 0.5,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  // Fetch all playlists data from the database
  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  // Fetch all favourite songs data from the database
  void readFavourite() {
    context.read<DataBaseHelper>().fetchFavouriteSongsFromSongData();
  }

  /// Adds or removes a song from the favourites list.
  void _addOrRemoveSongFromFavourite(String songTitle) {
    context.read<DataBaseHelper>().addOrRemoveSongFromFavourite(songTitle);
  }

  /// Toggles play/pause state of a song.
  void _songPalyAndPause(SongDataClass selectedSong) {
    context
        .read<AudiostreamFunctions>()
        .setAudioData(selectedSong, widget.songsData);

    context.read<NavigationBarChange>().setAudioTrayersAreVisible();
    context.read<NavigationBarChange>().setplayListNamgechange(true);
    context.read<AudiostreamFunctions>().playMusic();
  }

  /// Displays a popup window for playlist selection.
  void _onCreatePopUpWindow(BuildContext newContext, SongDataClass pickedSong) {
    context
        .read<DataBaseHelper>()
        .fetchTemporyPlayListLibraryForSelectedSong(pickedSong.songTitle);
    showDialog(
        context: newContext,
        builder: (context) => PlayListPopUpWindow(
              selectedSong: pickedSong,
            ));
  }
}
