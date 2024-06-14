// ignore_for_file: must_be_immutable

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
import 'models/volumeSlider.dart';

class AudioTraySmall extends StatefulWidget {
  final Function() onAudioTrayMinimizingFuntion, onAudioTrayCloseFuntion;
  List<SongDataClass> songsData = [];
  SongDataClass? selectedAudio;

  AudioTraySmall(
      {super.key,
      required this.onAudioTrayMinimizingFuntion,
      required this.onAudioTrayCloseFuntion,
      n});

  @override
  State<AudioTraySmall> createState() => _AudioTraySmallState();
}

class _AudioTraySmallState extends State<AudioTraySmall> {
  @override
  void initState() {
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

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 200, right: 20),
        child: Container(
          height: 110,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.1),
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 5, bottom: 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: widget.selectedAudio != null &&
                                      widget.selectedAudio!.imageByteArray
                                          .isNotEmpty &&
                                      widget.selectedAudio!.songPath
                                          .endsWith(".mp4")
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: widget.selectedAudio != null &&
                                    widget.selectedAudio!.imageByteArray
                                        .isNotEmpty &&
                                    widget.selectedAudio!.songPath
                                        .endsWith(".mp3")
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      widget.selectedAudio!.imageByteArray,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : widget.selectedAudio != null &&
                                        widget.selectedAudio!.imageByteArray
                                            .isNotEmpty &&
                                        widget.selectedAudio!.songPath
                                            .endsWith(".mp4")
                                    ? VideoPlayer(
                                        audioStreamInstance.getVideoPlayer)
                                    : Icon(
                                        Bootstrap.music_note_beamed,
                                        size: 100,
                                      ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 5),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AudioButtons(
                                      onButtonPressed: () =>
                                          _addOrRemoveSongFromFavourite(
                                              widget.selectedAudio!.songTitle),
                                      buttonIcon: widget
                                              .selectedAudio!.songIsMyFavourite
                                          ? Bootstrap.heart_fill
                                          : Bootstrap.heart,
                                      buttonWidth: 30,
                                      buttonHeight: 30,
                                      buttonIconSize: 18,
                                      buttonBorderRadiusSize: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Container(
                                        width: 500,
                                        child: Text(
                                          widget.selectedAudio!.songTitle,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alatsi(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Container(
                                    height: 20,
                                    width: 580,
                                    child: ProgressBar(
                                      progress: audioStreamInstance
                                          .getCurrentDuration(),
                                      total: audioStreamInstance
                                          .getsongTotalDuration,
                                      barCapShape: BarCapShape.round,
                                      progressBarColor: Colors.white,
                                      baseBarColor:
                                          Colors.white.withOpacity(0.24),
                                      bufferedBarColor:
                                          Colors.white.withOpacity(0.24),
                                      thumbColor: Colors.white,
                                      barHeight: 4,
                                      thumbGlowRadius: 0,
                                      thumbRadius: 5.0,
                                      timeLabelLocation:
                                          TimeLabelLocation.sides,
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
                                ),
                                Container(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AudioButtons(
                                        onButtonPressed: () =>
                                            _shuffleSongsList(),
                                        buttonIcon: Bootstrap.shuffle,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () =>
                                            _playPreviousSong(),
                                        buttonIcon:
                                            Bootstrap.skip_backward_fill,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () =>
                                            _songPalyAndPause(
                                                widget.selectedAudio!),
                                        buttonIcon: audioStreamInstance
                                                        .getPlayerState ==
                                                    PlayerState.playing ||
                                                audioStreamInstance.videoPlayer!
                                                    .value.isPlaying
                                            ? Bootstrap.pause_circle_fill
                                            : Bootstrap.play_circle_fill,
                                        buttonWidth: 40,
                                        buttonHeight: 40,
                                        buttonIconSize: 30,
                                        buttonBorderRadiusSize: 10,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () => _playNextSong(),
                                        buttonIcon: Bootstrap.skip_forward_fill,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () =>
                                            _changeVolume(context),
                                        buttonIcon: Bootstrap.volume_up,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: AudioButtons(
                            onButtonPressed: () =>
                                widget.onAudioTrayMinimizingFuntion(),
                            buttonIcon: Bootstrap.arrow_up_right_square,
                            buttonWidth: 25,
                            buttonHeight: 25,
                            buttonIconSize: 13,
                            buttonBorderRadiusSize: 6,
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
                ),
              ],
            ),
          ),
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

  void _songPalyAndPause(SongDataClass selectedSong) {
    context
        .read<AudiostreamFunctions>()
        .setAudioData(selectedSong, widget.songsData);
    context.read<AudiostreamFunctions>().songPlayPause();
  }

  void _playNextSong() {
    context.read<AudiostreamFunctions>().playNextSong();
  }

  void _shuffleSongsList() {
    context.read<DataBaseHelper>().shuffleSongs();
  }

  void _playPreviousSong() {
    context.read<AudiostreamFunctions>().playPreviousSong();
  }

  void _changeVolume(BuildContext newContext) {
    showDialog(context: newContext, builder: (context) => VolumePopUpSlider());
  }
}
