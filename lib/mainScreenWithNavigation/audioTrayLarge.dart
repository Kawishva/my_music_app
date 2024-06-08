// ignore_for_file: must_be_immutable
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../generalFunctions/audioStream.dart';
import '../generalFunctions/navigationBarChange.dart';
import '../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../isarDatabase/databaseHelper/song.dart';
import 'models/audioButtons.dart';
import 'models/playListsSelectionPopUpWindow.dart';

class AudioTrayLarge extends StatefulWidget {
  final Function() onAudioTrayMinimizingFuntion, onAudioTrayCloseFuntion;
  List<SongData> songsData = [];
  SongData? selectedAudio;
  AudioTrayLarge({
    super.key,
    required this.onAudioTrayMinimizingFuntion,
    required this.onAudioTrayCloseFuntion,
  });

  @override
  State<AudioTrayLarge> createState() => _AudioTrayLargeState();
}

class _AudioTrayLargeState extends State<AudioTrayLarge> {
  bool audioTrayPlayListIsExpanded = true;
  final player = AudioPlayer();

  @override
  void initState() {
    reedSongs();
    readPlaylist();
    readFavourite();
    widget.songsData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);

    final audioStreamInstance = Provider.of<AudiostreamFunctions>(context);

    widget.selectedAudio = audioStreamInstance.getSelectedSongData;

    // Determine the list of songs to display based on the current navigation bar index
    List<SongData> songDataList = dataBaseHelperContext.songDataList;
    List<SongData> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongData> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    if (navigationBarChangeInstance.navigationBarIndex == 1 ||
        navigationBarChangeInstance.navigationBarIndex == 0) {
      widget.songsData = songDataList;
    }
    if (navigationBarChangeInstance.navigationBarIndex == 2) {
      widget.songsData = favouriteSongDataList;
    }
    if (navigationBarChangeInstance.navigationBarIndex == 3) {
      widget.songsData = selectedPlayListSongsDataList;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 250,
          height: audioTrayPlayListIsExpanded ? 600 : 400,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF022B35).withOpacity(0.6),
                  Color(0xFF030B21).withOpacity(0.7),
                  Color(0xFF000000).withOpacity(0.8),
                  Color(0xFF260000).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Minimize button
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AudioButtons(
                        onButtonPressed: () =>
                            widget.onAudioTrayMinimizingFuntion(),
                        buttonIcon: Bootstrap.arrow_down_left_square,
                        buttonWidth: 25,
                        buttonHeight: 25,
                        buttonIconSize: 13,
                        buttonBorderRadiusSize: 6,
                      ),
                      AudioButtons(
                        onButtonPressed: () => widget.onAudioTrayCloseFuntion(),
                        buttonIcon: Bootstrap.x_lg,
                        buttonWidth: 25,
                        buttonHeight: 25,
                        buttonIconSize: 13,
                        buttonBorderRadiusSize: 6,
                      ),
                    ],
                  ),
                ),
              ),
              // Song icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: widget.selectedAudio != null &&
                                widget.selectedAudio!.imageByteArray.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.memory(
                                  widget.selectedAudio!.imageByteArray,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Bootstrap.music_note_beamed,
                                size: 60,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              // Song name
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AudioButtons(
                      onButtonPressed: () {},
                      buttonIcon: widget.selectedAudio!.songIsMyFavourite
                          ? Bootstrap.heart_fill
                          : Bootstrap.heart,
                      buttonWidth: 27,
                      buttonHeight: 27,
                      buttonIconSize: 20,
                      buttonBorderRadiusSize: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          child: Text(
                            widget.selectedAudio!.songTitle,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alatsi(
                              color: Colors.white,
                              // letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        // Artist name
                        Text(
                          widget.selectedAudio!.artistName,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.alatsi(
                            color: Colors.white,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Builder(builder: (newContext) {
                      return AudioButtons(
                        onButtonPressed: () => _onCreatePopUpWindow(
                            context, widget.selectedAudio!.songId),
                        buttonIcon: Bootstrap.three_dots_vertical,
                        buttonWidth: 25,
                        buttonHeight: 25,
                        buttonIconSize: 17,
                        buttonBorderRadiusSize: 8,
                      );
                    }),
                  ],
                ),
              ),
              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProgressBar(
                  progress: Duration(seconds: 3),
                  total: Duration(minutes: 1),
                  barCapShape: BarCapShape.round,
                  progressBarColor: Colors.white,
                  baseBarColor: Colors.white.withOpacity(0.24),
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Colors.white,
                  barHeight: 4,
                  thumbGlowRadius: 0,
                  thumbRadius: 5.0,
                  timeLabelLocation: TimeLabelLocation.sides,
                  timeLabelTextStyle: GoogleFonts.alatsi(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                  onSeek: (duration) {
                    // Handle seek action here, if needed
                  },
                ),
              ),
              // Control buttons (shuffle, skip back, play/pause, skip forward, volume)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AudioButtons(
                          onButtonPressed: () {},
                          buttonIcon: Bootstrap.shuffle,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () {},
                          buttonIcon: Bootstrap.skip_backward_fill,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () =>
                              _songPalyAndPause(widget.selectedAudio!),
                          buttonIcon: widget.selectedAudio!.songIsPlaying
                              ? Bootstrap.pause_circle_fill
                              : Bootstrap.play_circle_fill,
                          buttonWidth: 40,
                          buttonHeight: 40,
                          buttonIconSize: 30,
                          buttonBorderRadiusSize: 10),
                      AudioButtons(
                          onButtonPressed: () {},
                          buttonIcon: Bootstrap.skip_forward_fill,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () {},
                          buttonIcon: Bootstrap.volume_up,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                    ],
                  ),
                ),
              ),
              // Expand/Collapse button
              AudioButtons(
                onButtonPressed: () {
                  setState(() {
                    audioTrayPlayListIsExpanded = !audioTrayPlayListIsExpanded;
                  });
                  debugPrint("tray is expanded");
                },
                buttonIcon: audioTrayPlayListIsExpanded
                    ? Bootstrap.arrows_angle_expand
                    : Bootstrap.arrows_angle_contract,
                buttonWidth: 35,
                buttonHeight: 25,
                buttonIconSize: 13,
                buttonBorderRadiusSize: 10,
              ),
              // Playlist (visible when expanded)
              audioTrayPlayListIsExpanded
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 2, bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              itemCount: widget.songsData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  child: ElevatedButton(
                                    onPressed: () => _songPalyAndPause(
                                        widget.songsData[index]),
                                    style: ButtonStyle(
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5)),
                                        elevation: WidgetStateProperty.all(0),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8), // Rounded corners.
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white.withOpacity(0.06)),
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.white.withOpacity(0.05))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 5),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: widget.songsData[index]
                                                    .imageByteArray.isNotEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    child: Image.memory(
                                                      width: 35,
                                                      height: 35,
                                                      widget.songsData[index]
                                                          .imageByteArray,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Icon(
                                                    Bootstrap.music_note_beamed,
                                                    size: 15,
                                                    color: Colors.black,
                                                  ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                              child: Container(
                                                width: 173,
                                                child: Text(
                                                  widget.songsData[index]
                                                      .songTitle,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.alatsi(
                                                    color: Colors.white,
                                                    //  letterSpacing: 1,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Container(
                                                width: 173,
                                                child: Text(
                                                  widget.songsData[index]
                                                      .artistName,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.alatsi(
                                                    color: Colors.white,
                                                    //  letterSpacing: 1,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
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

  // Displays a popup window for playlist selection.
  void _onCreatePopUpWindow(BuildContext newContext, int songId) {
    context
        .read<DataBaseHelper>()
        .temporyPlayListLibraryForSelectedSong(songId);
    showDialog(
        context: newContext,
        builder: (context) => PlayListPopUpWindow(
              songId: songId,
            ));
  }

  void _songPalyAndPause(SongData selectedSong) {
    context.read<AudiostreamFunctions>().setAudioData(selectedSong);
    // context.read<NavigationBarChange>().setAudioTrayersAreVisible();
    context.read<DataBaseHelper>().songPalyAndPause(selectedSong.songId);
  }
}
