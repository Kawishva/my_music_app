import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class SongsListView extends StatefulWidget {
  final List<String> allSongList;
  final Function() onPlayAndPauseButtonPressed;

  const SongsListView(
      {super.key,
      required this.allSongList,
      required this.onPlayAndPauseButtonPressed});

  @override
  State<SongsListView> createState() => _SongsLisViewState();
}

class _SongsLisViewState extends State<SongsListView> {
  int playButtonIsPressed = -1;
  bool songIsPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 265, top: 5, bottom: 5),
          itemCount: widget.allSongList.length,
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
                              onPressed: () {
                                setState(() {
                                  playButtonIsPressed = index;
                                  songIsPlaying = !songIsPlaying;
                                });
                                widget.onPlayAndPauseButtonPressed();
                              },
                              icon: Icon(
                                playButtonIsPressed == index && songIsPlaying
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        widget.allSongList[index],
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
}
