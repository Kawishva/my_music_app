import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'models/audioButtons.dart';

class AudioTraySmall extends StatefulWidget {
  final Function() onAudioTrayMinimizingFuntion, onAudioTrayCloseFuntion;

  const AudioTraySmall(
      {super.key,
      required this.onAudioTrayMinimizingFuntion,
      required this.onAudioTrayCloseFuntion,
      n});

  @override
  State<AudioTraySmall> createState() => _AudioTraySmallState();
}

class _AudioTraySmallState extends State<AudioTraySmall> {
  bool isMyFavourite = false;
  bool songIsPLaying = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 150),
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                              horizontal: 10, vertical: 0),
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Bootstrap.music_note_beamed,
                              size: 60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Song Name",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.alatsi(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 2, top: 7),
                                  child: Container(
                                    height: 20,
                                    width: 210,
                                    child: ProgressBar(
                                      progress: Duration(seconds: 3),
                                      total: Duration(minutes: 1),
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
                                        // Handle seek action here, if needed
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
                                        onButtonPressed: () {},
                                        buttonIcon: Bootstrap.shuffle,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () {},
                                        buttonIcon:
                                            Bootstrap.skip_backward_fill,
                                        buttonWidth: 30,
                                        buttonHeight: 30,
                                        buttonIconSize: 18,
                                        buttonBorderRadiusSize: 8,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () {},
                                        buttonIcon: songIsPLaying
                                            ? Bootstrap.pause_circle_fill
                                            : Bootstrap.play_circle_fill,
                                        buttonWidth: 40,
                                        buttonHeight: 40,
                                        buttonIconSize: 30,
                                        buttonBorderRadiusSize: 10,
                                      ),
                                      AudioButtons(
                                        onButtonPressed: () {},
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
                  alignment: AlignmentDirectional(-0.25, -0.7),
                  child: Builder(builder: (context) {
                    return AudioButtons(
                      onButtonPressed: () {},
                      buttonIcon: isMyFavourite
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
                    padding: const EdgeInsets.only(right: 2),
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
}
