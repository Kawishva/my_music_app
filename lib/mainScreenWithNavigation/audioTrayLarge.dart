// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../generalFunctions/audioAndVideoStream.dart';
import '../generalFunctions/navigationBarChange.dart';
import '../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../isarDatabase/databaseHelper/song.dart';
import 'models/audioButtons.dart';
import 'models/playListsSelectionPopUpWindow.dart';
import 'models/volumeSlider.dart';

class AudioTrayLarge extends StatefulWidget {
  final Function() onAudioTrayMinimizingFuntion, onAudioTrayCloseFuntion;
  List<SongDataClass> songsData = [];
  SongDataClass? selectedAudio;
  String playListName = "";

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
  FocusNode keyboardFocusNode = FocusNode();

  @override
  void initState() {
    readPlaylist();
    readFavourite();
    keyboardFocusNode;
    widget.playListName = "";
    widget.songsData.clear();
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
    List<SongDataClass> songDataList = dataBaseHelperContext.songDataList;
    List<SongDataClass> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongDataClass> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    switch (navigationBarChangeInstance.navigationBarIndex) {
      case 0:
        widget.songsData = songDataList;
        break;
      case 1:
        widget.songsData = favouriteSongDataList;
        break;
      case 2:
        widget.songsData = selectedPlayListSongsDataList;
        break;
    }

    // Determine the list of songs to display based on the current navigation bar index
    widget.playListName = navigationBarChangeInstance.getPlayListName;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 190),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Minimize button
                    Padding(
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
                          Text(
                            widget.playListName,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alatsi(
                              color: Colors.white,
                              //  letterSpacing: 1,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          AudioButtons(
                            onButtonPressed: () =>
                                widget.onAudioTrayCloseFuntion(),
                            buttonIcon: Bootstrap.x_lg,
                            buttonWidth: 25,
                            buttonHeight: 25,
                            buttonIconSize: 13,
                            buttonBorderRadiusSize: 6,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: widget.selectedAudio != null &&
                                            widget.selectedAudio!.imageByteArray
                                                .isNotEmpty &&
                                            widget.selectedAudio!.songPath
                                                .endsWith(".mp4")
                                        ? Colors.black.withOpacity(0.5)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: widget.selectedAudio != null &&
                                        widget.selectedAudio!.imageByteArray
                                            .isNotEmpty &&
                                        widget.selectedAudio!.songPath
                                            .endsWith(".mp3")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.memory(
                                          widget.selectedAudio!.imageByteArray,
                                          fit: BoxFit.fill,
                                          isAntiAlias: true,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      )
                                    : widget.selectedAudio != null &&
                                            widget.selectedAudio!.songPath
                                                .endsWith(".mp4")
                                        ? AspectRatio(
                                            aspectRatio: audioStreamInstance
                                                .getVideoPlayer
                                                .value
                                                .aspectRatio,
                                            child: VideoPlayer(
                                                audioStreamInstance
                                                    .getVideoPlayer))
                                        : Container(
                                            child: Icon(
                                              Bootstrap.music_note_beamed,
                                              size: 100,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Song name
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AudioButtons(
                            onButtonPressed: () =>
                                _addOrRemoveSongFromFavourite(
                                    widget.selectedAudio!.songTitle),
                            buttonIcon: widget.selectedAudio!.songIsMyFavourite
                                ? Bootstrap.heart_fill
                                : Bootstrap.heart,
                            buttonWidth: 27,
                            buttonHeight: 27,
                            buttonIconSize: 20,
                            buttonBorderRadiusSize: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
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
                          ),
                          Builder(builder: (newContext) {
                            return AudioButtons(
                              onButtonPressed: () => _onCreatePopUpWindow(
                                  context, widget.selectedAudio!),
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
                        progress: audioStreamInstance.getCurrentDuration(),
                        total: audioStreamInstance.getsongTotalDuration,
                        barCapShape: BarCapShape.round,
                        progressBarColor: Colors.white,
                        baseBarColor: Colors.white.withOpacity(0.24),
                        bufferedBarColor: Colors.white.withOpacity(0.24),
                        thumbColor: Colors.white,
                        barHeight: 4,
                        thumbGlowRadius: 0,
                        thumbRadius: 4,
                        timeLabelLocation: TimeLabelLocation.sides,
                        timeLabelTextStyle: GoogleFonts.alatsi(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                        onSeek: (duration) {
                          audioStreamInstance.seek(duration);
                        },
                      ),
                    ),
                    // Control buttons (shuffle, skip back, play/pause, skip forward, volume)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AudioButtons(
                                onButtonPressed: () => _shuffleSongsList(),
                                buttonIcon: Bootstrap.shuffle,
                                buttonWidth: 30,
                                buttonHeight: 30,
                                buttonIconSize: 18,
                                buttonBorderRadiusSize: 8),
                            Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AudioButtons(
                                      onButtonPressed: () =>
                                          _playPreviousSong(),
                                      buttonIcon: Bootstrap.skip_backward_fill,
                                      buttonWidth: 30,
                                      buttonHeight: 30,
                                      buttonIconSize: 18,
                                      buttonBorderRadiusSize: 8),
                                  AudioButtons(
                                      onButtonPressed: () =>
                                          _songPlayAndPause(),
                                      buttonIcon:
                                          audioStreamInstance.getPlayerState ==
                                                      PlayerState.playing ||
                                                  (audioStreamInstance
                                                              .videoPlayer !=
                                                          null &&
                                                      audioStreamInstance
                                                          .videoPlayer!
                                                          .value
                                                          .isPlaying)
                                              ? Bootstrap.pause_circle_fill
                                              : Bootstrap.play_circle_fill,
                                      buttonWidth: 40,
                                      buttonHeight: 40,
                                      buttonIconSize: 30,
                                      buttonBorderRadiusSize: 10),
                                  AudioButtons(
                                      onButtonPressed: () => _playNextSong(),
                                      buttonIcon: Bootstrap.skip_forward_fill,
                                      buttonWidth: 30,
                                      buttonHeight: 30,
                                      buttonIconSize: 18,
                                      buttonBorderRadiusSize: 8),
                                ],
                              ),
                            ),
                            // Expand/Collapse button

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Builder(builder: (context) {
                                      return AudioButtons(
                                          onButtonPressed: () =>
                                              _changeVolume(context),
                                          buttonIcon: Bootstrap.volume_up,
                                          buttonWidth: 30,
                                          buttonHeight: 30,
                                          buttonIconSize: 18,
                                          buttonBorderRadiusSize: 8);
                                    }),
                                    Text(
                                      "${((audioStreamInstance.getVolume * 100).toInt()).toString()}",
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: AudioButtons(
                                    onButtonPressed: () {
                                      setState(() {
                                        audioTrayPlayListIsExpanded =
                                            !audioTrayPlayListIsExpanded;
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
                                ),
                                // Playlist (visible when expanded)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            audioTrayPlayListIsExpanded
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 5, top: 10, bottom: 10),
                      child: FadeInRight(
                        animate: true,
                        duration: Duration(milliseconds: 100),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(15)),
                          child: ReorderableListView.builder(
                            onReorder: (int oldIndex, int newIndex) =>
                                _reorderingListViewFuntion(oldIndex, newIndex),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            itemCount: widget.songsData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                key: ValueKey(index),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 6),
                                child: ElevatedButton(
                                  key: ValueKey(index),
                                  onPressed: () =>
                                      _playSlectedSong(widget.songsData[index]),
                                  style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                          EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 5,
                                              right: 20)),
                                      elevation: WidgetStateProperty.all(0),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Rounded corners.
                                        ),
                                      ),
                                      backgroundColor: audioStreamInstance
                                                  .selectedSong ==
                                              widget.songsData[index]
                                          ? WidgetStateProperty.all(
                                              Colors.white.withOpacity(0.4))
                                          : WidgetStateProperty.all(
                                              Colors.white.withOpacity(0.06)),
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.white.withOpacity(0.05))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                      BorderRadius.circular(3),
                                                  child: Image.memory(
                                                    width: 50,
                                                    height: 50,
                                                    widget.songsData[index]
                                                        .imageByteArray,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Icon(
                                                    Bootstrap.music_note_beamed,
                                                    size: 35,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
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
                                              child: Text(
                                                widget
                                                    .songsData[index].songTitle,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.alatsi(
                                                  color: Colors.white,
                                                  //  letterSpacing: 1,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Text(
                                                widget.songsData[index]
                                                    .artistName,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.alatsi(
                                                  color: Colors.white,
                                                  //  letterSpacing: 1,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
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

  // Displays a popup window for playlist selection.
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

  void _playSlectedSong(SongDataClass selectedSong) {
    context
        .read<AudiostreamFunctions>()
        .setAudioData(selectedSong, widget.songsData);

    context.read<AudiostreamFunctions>().playMusic();
  }

  void _songPlayAndPause() {
    context.read<AudiostreamFunctions>().songPlayPause();
  }

  void _playNextSong() {
    context.read<AudiostreamFunctions>().playNextSong();
  }

  void _playPreviousSong() {
    context.read<AudiostreamFunctions>().playPreviousSong();
  }

  void _shuffleSongsList() {
    context.read<DataBaseHelper>().shuffleSongs();
  }

  void _changeVolume(BuildContext newContext) {
    showDialog(context: newContext, builder: (context) => VolumePopUpSlider());
  }

  void _reorderingListViewFuntion(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }

    final oldSong = widget.songsData.removeAt(oldIndex);
    widget.songsData.insert(newIndex, oldSong);
  }
}
