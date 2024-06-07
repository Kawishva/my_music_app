import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../../generalFunctions/navigationBarChange.dart';
import '../../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../../isarDatabase/databaseHelper/song.dart';
import '../../models/playListsSelectionPopUpWindow.dart';

class PlayListsScreens extends StatefulWidget {
  const PlayListsScreens({
    super.key,
  });

  @override
  State<PlayListsScreens> createState() => _PlayListsScreensState();
}

class _PlayListsScreensState extends State<PlayListsScreens> {
  int playButtonIsPressed = -1;
  bool songIsPlaying = false;
  bool isMyFavourite = false;

  @override
  void initState() {
    // Initialize state by fetching data from the database
    reedSongs();
    readPlaylist();
    readFavourite();
    super.initState();
  }

  // Fetch all songs data from the database
  void reedSongs() {
    context.read<DataBaseHelper>().fetchSongDataFromDataBase();
  }

  // Fetch all playlists data from the database
  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  // Fetch all favourite songs data from the database
  void readFavourite() {
    context.read<DataBaseHelper>().fetchFavouriteSongsFromSongData();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);

    // Determine the list of songs to display based on the current navigation bar index
    List<SongData> songDataList = dataBaseHelperContext.songDataList;
    List<SongData> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongData> songsData = [];

    if (navigationBarChangeInstance.navigationBarIndex == 1) {
      songsData = songDataList;
    }
    if (navigationBarChangeInstance.navigationBarIndex == 2) {
      songsData = favouriteSongDataList;
    }

    return Container(
      child: GridView.builder(
          primary: true,
          padding: EdgeInsets.all(3), // Padding around the grid
          itemCount: songsData.length, // Number of items in the grid
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
                          Icon(
                            Bootstrap.music_note_beamed,
                            size: 60,
                          ),
                          SizedBox(
                              width: 60,
                              height: 60,
                              child: IconButton(
                                  onPressed: () => _songPalyAndPause(
                                      songsData[index].songId),
                                  icon: Icon(
                                    songsData[index].songIsPlaying
                                        ? Bootstrap.pause_circle_fill
                                        : Bootstrap.play_circle_fill,
                                    size: 60,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
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
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                        onPressed: () =>
                                            _addOrRemoveSongFromFavourite(
                                                songsData[index].songId),
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
                                          songsData[index].songIsMyFavourite
                                              ? Bootstrap.heart_fill
                                              : Bootstrap.heart,
                                          size: 17,
                                          color:
                                              songsData[index].songIsMyFavourite
                                                  ? Color(0xFF880900)
                                                  : Colors.black,
                                        ),
                                      )),
                                  Builder(builder: (newContext) {
                                    return SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                        onPressed: () =>
                                            _onCreatePopUpWindow(context),
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
                      child: Text(
                        songsData[index].songId.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.alatsi(
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "artist name",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.alatsi(
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  /// Adds or removes a song from the favourites list.
  void _addOrRemoveSongFromFavourite(int songId) {
    context.read<DataBaseHelper>().addOrRemoveSongFromFavourite(songId);
  }

  /// Toggles play/pause state of a song.
  void _songPalyAndPause(int songId) {
    context.read<DataBaseHelper>().songPalyAndPause(songId);
  }

  /// Displays a popup window for playlist selection.
  void _onCreatePopUpWindow(BuildContext newContext) {
    showDialog(
        context: newContext, builder: (context) => PlayListPopUpWindow());
  }
}
