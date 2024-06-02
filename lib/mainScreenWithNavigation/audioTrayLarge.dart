import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/audioButtons.dart';

class AudioTrayLarge extends StatefulWidget {
  final List<String> allSongList;
  final Function() onAudioTrayMinimizingFuntion,
      onShuffleButtonPressed,
      onPlayAndPauseButtonPressed,
      onSkipBackButtonPressed,
      onSkipForwardButtonPressed,
      onVolumeButtonPressed,
      onPlayListSongPressedFunction;
  final IconData? buttonIcon;

  const AudioTrayLarge(
      {super.key,
      required this.allSongList,
      required this.onAudioTrayMinimizingFuntion,
      required this.buttonIcon,
      required this.onShuffleButtonPressed,
      required this.onPlayAndPauseButtonPressed,
      required this.onSkipBackButtonPressed,
      required this.onSkipForwardButtonPressed,
      required this.onVolumeButtonPressed,
      required this.onPlayListSongPressedFunction});

  @override
  State<AudioTrayLarge> createState() => _AudioTrayLargeState();
}

class _AudioTrayLargeState extends State<AudioTrayLarge> {
  bool audioTrayPlayListIsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Center(
        child: Container(
          width: 250,
          height: audioTrayPlayListIsExpanded ? 600 : 400,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent.withOpacity(0.12),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 0), // changes position of shadow
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Minimize button
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: AudioButtons(
                    onButtonPressed: () =>
                        widget.onAudioTrayMinimizingFuntion(),
                    buttonIcon: Bootstrap.arrow_down_left_square,
                    buttonWidth: 25,
                    buttonHeight: 25,
                    buttonIconSize: 13,
                    buttonBorderRadiusSize: 6,
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
                        child: Icon(
                          Bootstrap.music_note_beamed,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Song name
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Song Name",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.alatsi(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              // Artist name
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 20),
                child: Text(
                  "Artist Name",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.alatsi(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
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
                          onButtonPressed: () =>
                              widget.onShuffleButtonPressed(),
                          buttonIcon: Bootstrap.shuffle,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () =>
                              widget.onSkipBackButtonPressed(),
                          buttonIcon: Bootstrap.skip_backward_fill,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () =>
                              widget.onPlayAndPauseButtonPressed(),
                          buttonIcon: widget.buttonIcon,
                          buttonWidth: 40,
                          buttonHeight: 40,
                          buttonIconSize: 30,
                          buttonBorderRadiusSize: 10),
                      AudioButtons(
                          onButtonPressed: () =>
                              widget.onSkipForwardButtonPressed(),
                          buttonIcon: Bootstrap.skip_backward_fill,
                          buttonWidth: 30,
                          buttonHeight: 30,
                          buttonIconSize: 18,
                          buttonBorderRadiusSize: 8),
                      AudioButtons(
                          onButtonPressed: () => widget.onVolumeButtonPressed(),
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
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              itemCount: widget.allSongList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onPlayListSongPressedFunction();
                                    },
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
                                            Colors.white.withOpacity(0.02))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Icon(
                                            Bootstrap.music_note_beamed,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            widget.allSongList[index],
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.alatsi(
                                              color: Colors.white,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "artist name",
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.alatsi(
                                              color: Colors.white,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9,
                                            ),
                                          ),
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
}
