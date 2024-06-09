// ignore_for_file: must_be_immutable

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../generalFunctions/audioStream.dart';
import '../generalFunctions/navigationBarChange.dart';
import '../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../isarDatabase/databaseHelper/song.dart';
import 'models/audioButtons.dart';

class AudioTraySmall extends StatefulWidget {
  final Function() onAudioTrayMinimizingFuntion, onAudioTrayCloseFuntion;
  List<SongData> songsData = [];
  SongData? selectedAudio;

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

    // Determine the list of songs to display based on the current navigation bar index

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 150),
        child: Container(
          width: 350,
          height: 110,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.1),
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
                color: Colors.lightBlueAccent.withOpacity(0.2),
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
                  padding: const EdgeInsets.only(top: 0, right: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: widget.selectedAudio != null &&
                                    widget.selectedAudio!.imageByteArray
                                        .isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 25, right: 5),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.selectedAudio!.songTitle,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alatsi(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    height: 20,
                                    width: 210,
                                    child: ProgressBar(
                                      progress: audioStreamInstance
                                          .getCurrentDureation,
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
                                        buttonIcon:
                                            widget.selectedAudio!.songIsPlaying
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
                                        onButtonPressed: () {},
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
                  alignment: AlignmentDirectional(-0.2786, -0.5),
                  child: Builder(builder: (context) {
                    return AudioButtons(
                      onButtonPressed: () => _addOrRemoveSongFromFavourite(
                          widget.selectedAudio!.songId),
                      buttonIcon: widget.selectedAudio!.songIsMyFavourite
                          ? Bootstrap.heart_fill
                          : Bootstrap.heart,
                      buttonWidth: 25,
                      buttonHeight: 25,
                      buttonIconSize: 17,
                      buttonBorderRadiusSize: 8,
                    );
                  }),
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

  /// Adds or removes a song from the favourites list.
  void _addOrRemoveSongFromFavourite(int songId) {
    context.read<DataBaseHelper>().addOrRemoveSongFromFavourite(songId);
  }

  void _songPalyAndPause(SongData selectedSong) {
    context.read<DataBaseHelper>().songPalyAndPause(selectedSong.songId);
    context.read<AudiostreamFunctions>().setAudioData(selectedSong);
    context.read<AudiostreamFunctions>().songPlayPause();
  }

  void _playNextSong() {
    final audioStreamInstance = context.read<AudiostreamFunctions>();

    SongData? currentSong = audioStreamInstance.getSelectedSongData;

    for (int i = 0; i < widget.songsData.length; i++) {
      if (widget.songsData[i] == currentSong) {
        if (widget.songsData.length == i + 1) {
          currentSong = widget.songsData.first;
        } else {
          currentSong = widget.songsData[i + 1];
        }
        break;
      }
    }

    context.read<DataBaseHelper>().songPalyAndPause(currentSong!.songId);
    audioStreamInstance.setAudioData(currentSong);
    context.read<AudiostreamFunctions>().playMusic();
  }

  void _shuffleSongsList() {
    context.read<DataBaseHelper>().shuffleSongs();
  }

  void _playPreviousSong() {
    final audioStreamInstance = context.read<AudiostreamFunctions>();

    SongData? currentSong = audioStreamInstance.getSelectedSongData;

    for (int i = 0; i < widget.songsData.length; i++) {
      if (widget.songsData[i] == currentSong) {
        if (i == 0) {
          currentSong = widget.songsData.last;
        } else {
          currentSong = widget.songsData[i - 1];
        }
        break;
      }
    }
    context.read<DataBaseHelper>().songPalyAndPause(currentSong!.songId);
    audioStreamInstance.setAudioData(currentSong);
    context.read<AudiostreamFunctions>().playMusic();
  }
}
