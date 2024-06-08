import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../../generalFunctions/navigationBarChange.dart';
import '../../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../../isarDatabase/databaseHelper/song.dart';
import '../../models/playListsSelectionPopUpWindow.dart';

class SongsListView extends StatefulWidget {
  final int playListID;

  const SongsListView({
    super.key,
    required this.playListID,
  });

  @override
  State<SongsListView> createState() => _SongsLisViewState();
}

class _SongsLisViewState extends State<SongsListView> {
  @override
  void initState() {
    super.initState();
    _fetchSongsToPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);

    List<SongData> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    return Container(
      height: 145,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 265, top: 5, bottom: 5),
          itemCount: selectedPlayListSongsDataList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  0, 0), // changes position of shadow
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
                                  selectedPlayListSongsDataList[index].songId),
                              icon: Icon(
                                selectedPlayListSongsDataList[index]
                                        .songIsPlaying
                                    ? Bootstrap.pause_circle_fill
                                    : Bootstrap.play_circle_fill,
                                size: 60,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              // Adjusted to use ButtonStyle with MaterialStateProperty
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                overlayColor: WidgetStateProperty.all(
                                    Colors.black.withOpacity(0.3)),
                                padding:
                                    WidgetStateProperty.all(EdgeInsets.zero),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        50), // Rounded corners.
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
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
                                              selectedPlayListSongsDataList[
                                                      index]
                                                  .songId),
                                      icon: Icon(
                                        selectedPlayListSongsDataList[index]
                                                .songIsMyFavourite
                                            ? Bootstrap.heart_fill
                                            : Bootstrap.heart,
                                        size: 17,
                                        color:
                                            selectedPlayListSongsDataList[index]
                                                    .songIsMyFavourite
                                                ? Color(0xFF880900)
                                                : Colors.black,
                                      ),
                                      // Adjusted to use ButtonStyle with MaterialStateProperty
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.transparent),
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.black.withOpacity(0.1)),
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.zero),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Rounded corners.
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Builder(builder: (newContext) {
                                    return SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                        onPressed: () => _onCreatePopUpWindow(
                                            context,
                                            selectedPlayListSongsDataList[index]
                                                .songId),
                                        icon: Icon(
                                          Bootstrap.three_dots_vertical,
                                          size: 17,
                                          color: Colors.black,
                                        ),
                                        // Adjusted to use ButtonStyle with MaterialStateProperty
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.transparent),
                                          overlayColor: WidgetStateProperty.all(
                                              Colors.black.withOpacity(0.1)),
                                          padding: WidgetStateProperty.all(
                                              EdgeInsets.zero),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5), // Rounded corners.
                                            ),
                                          ),
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
                        selectedPlayListSongsDataList[index].songId.toString(),
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

  void _fetchSongsToPlaylist() {
    context
        .read<DataBaseHelper>()
        .fetchSongsListToSelectedPlayList(widget.playListID);
  }

  /// Toggles play/pause state of a song.
  void _songPalyAndPause(int songId) {
    context.read<NavigationBarChange>().setAudioTrayersAreVisible();
    context.read<DataBaseHelper>().songPalyAndPause(songId);
  }

  void _onCreatePopUpWindow(BuildContext newContext, int songId) {
    debugPrint("vfdvf");
    showDialog(
        context: newContext,
        builder: (context) => PlayListPopUpWindow(
              songId: songId,
            ));
  }
}
