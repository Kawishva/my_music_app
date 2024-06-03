import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class PlayListsScreens extends StatefulWidget {
  final List<int> allSongList;
  final Function() onPlayAndPauseButtonPressed, onAddToFavouriteListFunction;
  final Function(BuildContext newContext) onAddToPlayListOpenFunction;

  const PlayListsScreens(
      {super.key,
      required this.allSongList,
      required this.onPlayAndPauseButtonPressed,
      required this.onAddToPlayListOpenFunction,
      required this.onAddToFavouriteListFunction});

  @override
  State<PlayListsScreens> createState() => _PlayListsScreensState();
}

class _PlayListsScreensState extends State<PlayListsScreens> {
  int playButtonIsPressed = -1;
  bool songIsPlaying = false;
  bool isMyFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          primary: false,
          padding: EdgeInsets.all(5), // Padding around the grid
          itemCount: widget.allSongList.length, // Number of items in the grid
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 152, // Max width of each item
            crossAxisSpacing: 0, // Spacing between columns
            mainAxisSpacing: 0, // Spacing between rows
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
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
                                          widget.onAddToFavouriteListFunction(),

                                      icon: Icon(
                                        isMyFavourite
                                            ? Bootstrap.heart_fill
                                            : Bootstrap.heart,
                                        size: 17,
                                        color: isMyFavourite
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
                                        onPressed: () =>
                                            widget.onAddToPlayListOpenFunction(
                                                newContext),
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
                        widget.allSongList[index].toString(),
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
