// ignore_for_file: avoid_unnecessary_containers

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import 'navigation_text_button.dart';

class NavigationHolderComponent extends StatefulWidget {
  const NavigationHolderComponent({super.key});

  @override
  State<NavigationHolderComponent> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<NavigationHolderComponent> {
  // The currently selected index of the navigation bar
  int selectedIndex = 0;
  int listviewSelectedIndex = -1;
  bool trayIsMinimized = false;
  bool playeButtonIsPressed = false;
  bool audioTrayIsExpanded = true;

  final List<String> allSongList = [
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english"
  ];

  final List<String> playLists = [
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english",
    "old songs",
    "regge",
    "english"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF022B35), // Dark blue
                      Color(0xFF030B21), // Medium blue
                      Color(0xFF000000), // Light blue

                      Color.fromARGB(255, 38, 0,
                          0), // Dark blue (again for smoother transition)
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //navigation
                          Container(
                            width: 180,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF9E9E9E).withOpacity(0.09),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NavigationTextButton(
                                  buttonBoxShadow: [
                                    selectedIndex == 0
                                        ? const BoxShadow(
                                            color: Color(0xFF44C7FF),
                                            spreadRadius: 3,
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          )
                                        : const BoxShadow(
                                            color: Colors.transparent,
                                            spreadRadius: 0,
                                            blurRadius: 0,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          )
                                  ],
                                  buttonOnPressed: () {
                                    setState(() {
                                      selectedIndex = 0;
                                      listviewSelectedIndex = -1;
                                      trayIsMinimized = !trayIsMinimized;
                                    });
                                  },
                                  buttonColor: selectedIndex == 0
                                      ? const Color(0xFF44C7FF)
                                      : Colors.transparent,
                                  buttonName: "EXPLORE",
                                  buttonFontSize: 14,
                                  buttonLetterSpacing: 3,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 37, top: 20),
                                  child: Text(
                                    "LIBRARY",
                                    style: GoogleFonts.alatsi(
                                        color: Colors.white,
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, bottom: 0),
                                  child: NavigationTextButton(
                                    buttonBoxShadow: [
                                      selectedIndex == 1
                                          ? const BoxShadow(
                                              color: Color(0xFF44C7FF),
                                              spreadRadius: 3,
                                              blurRadius: 8,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            )
                                          : const BoxShadow(
                                              color: Colors.transparent,
                                              spreadRadius: 0,
                                              blurRadius: 0,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            )
                                    ],
                                    buttonOnPressed: () {
                                      setState(() {
                                        selectedIndex = 1;
                                        listviewSelectedIndex = -1;
                                      });
                                    },
                                    buttonColor: selectedIndex == 1
                                        ? const Color(0xFF44C7FF)
                                        : Colors.transparent,
                                    buttonName: "All songs",
                                    buttonFontSize: 12,
                                    buttonLetterSpacing: 1,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: NavigationTextButton(
                                    buttonBoxShadow: [
                                      selectedIndex == 2
                                          ? const BoxShadow(
                                              color: Color(0xFF44C7FF),
                                              spreadRadius: 3,
                                              blurRadius: 8,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            )
                                          : const BoxShadow(
                                              color: Colors.transparent,
                                              spreadRadius: 0,
                                              blurRadius: 0,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            )
                                    ],
                                    buttonOnPressed: () {
                                      setState(() {
                                        selectedIndex = 2;
                                        listviewSelectedIndex = -1;
                                      });
                                    },
                                    buttonColor: selectedIndex == 2
                                        ? const Color(0xFF44C7FF)
                                        : Colors.transparent,
                                    buttonName: "Favourites",
                                    buttonFontSize: 12,
                                    buttonLetterSpacing: 1,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 30, top: 20, bottom: 0),
                                  child: Text(
                                    "PLAYLISTS",
                                    style: GoogleFonts.alatsi(
                                        color: Colors.white,
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      itemCount: playLists.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: NavigationTextButton(
                                            buttonBoxShadow: [
                                              listviewSelectedIndex == index
                                                  ? const BoxShadow(
                                                      color: Color(0xFF44C7FF),
                                                      spreadRadius: 3,
                                                      blurRadius: 8,
                                                      offset: Offset(0,
                                                          0), // changes position of shadow
                                                    )
                                                  : const BoxShadow(
                                                      color: Colors.transparent,
                                                      spreadRadius: 0,
                                                      blurRadius: 0,
                                                      offset: Offset(0,
                                                          0), // changes position of shadow
                                                    )
                                            ],
                                            buttonOnPressed: () {
                                              setState(() {
                                                selectedIndex = 3;
                                                listviewSelectedIndex = index;
                                              });
                                            },
                                            buttonColor:
                                                listviewSelectedIndex == index
                                                    ? const Color(0xFF44C7FF)
                                                    : Colors.transparent,
                                            buttonName: playLists[index],
                                            buttonFontSize: 12,
                                            buttonLetterSpacing: 1,
                                            fontColor: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),

                          //screens

                          Expanded(
                            child: FadeIndexedStack(
                              index: selectedIndex,
                              alignment: AlignmentDirectional.center,
                              duration: Duration.zero,
                              children: const [
                                Center(
                                  child: Text(
                                    'Settings 1',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Settings 2',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Settings 3',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Settings 4',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          trayIsMinimized
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 35, horizontal: 10),
                                  child: Center(
                                    child: Container(
                                      width: 250,
                                      height: audioTrayIsExpanded ? 600 : 400,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.lightBlueAccent
                                                  .withOpacity(0.12),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: IconButton.filled(
                                                      onPressed: () {
                                                        setState(() {
                                                          trayIsMinimized =
                                                              !trayIsMinimized;
                                                        });
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(Colors
                                                                    .transparent),
                                                        overlayColor:
                                                            WidgetStateProperty
                                                                .all(Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                        padding:
                                                            WidgetStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        shape: WidgetStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6), // Rounded corners.
                                                          ),
                                                        ),
                                                      ),
                                                      icon: Icon(
                                                        Bootstrap
                                                            .arrow_down_left_square,
                                                        size: 13,
                                                        color: Colors.white,
                                                      ))),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Icon(
                                                      Bootstrap
                                                          .music_note_beamed,
                                                      size: 100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "Song Name",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.alatsi(
                                                  color: Colors.white,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, bottom: 20),
                                            child: Text(
                                              "Artist Name",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.alatsi(
                                                  color: Colors.white,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ProgressBar(
                                              progress: Duration(seconds: 3),
                                              total: Duration(minutes: 1),
                                              barCapShape: BarCapShape.round,
                                              progressBarColor: Colors.white,
                                              baseBarColor: Colors.white
                                                  .withOpacity(0.24),
                                              bufferedBarColor: Colors.white
                                                  .withOpacity(0.24),
                                              thumbColor: Colors.white,
                                              barHeight: 4,
                                              thumbGlowRadius: 0,
                                              thumbRadius: 5.0,
                                              timeLabelLocation:
                                                  TimeLabelLocation.sides,
                                              timeLabelTextStyle:
                                                  GoogleFonts.alatsi(
                                                      color: Colors.white,
                                                      letterSpacing: 2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 9),
                                              onSeek: (duration) {
                                                // _player.seek(duration);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: IconButton.filled(
                                                          onPressed: () {
                                                            setState(() {
                                                              debugPrint(
                                                                  "shuffle pressed");
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            overlayColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                            padding:
                                                                WidgetStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
                                                            shape: WidgetStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners.
                                                              ),
                                                            ),
                                                          ),
                                                          icon: Icon(
                                                            Bootstrap.shuffle,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ))),
                                                  SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: IconButton.filled(
                                                          onPressed: () {
                                                            setState(() {
                                                              debugPrint(
                                                                  "skip back");
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            overlayColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                            padding:
                                                                WidgetStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
                                                            shape: WidgetStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners.
                                                              ),
                                                            ),
                                                          ),
                                                          icon: Icon(
                                                            Bootstrap
                                                                .skip_backward_fill,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ))),
                                                  SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: IconButton.filled(
                                                          onPressed: () {
                                                            setState(() {
                                                              debugPrint(
                                                                  "play");
                                                              playeButtonIsPressed =
                                                                  !playeButtonIsPressed;
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            overlayColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                            padding:
                                                                WidgetStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
                                                            shape: WidgetStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners.
                                                              ),
                                                            ),
                                                          ),
                                                          icon:
                                                              playeButtonIsPressed
                                                                  ? Icon(
                                                                      Bootstrap
                                                                          .play_circle_fill,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : Icon(
                                                                      Bootstrap
                                                                          .pause_circle_fill,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white,
                                                                    ))),
                                                  SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: IconButton.filled(
                                                          onPressed: () {
                                                            setState(() {
                                                              debugPrint(
                                                                  "skip next");
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            overlayColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                            padding:
                                                                WidgetStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
                                                            shape: WidgetStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners.
                                                              ),
                                                            ),
                                                          ),
                                                          icon: Icon(
                                                            Bootstrap
                                                                .skip_forward_fill,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ))),
                                                  SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: IconButton.filled(
                                                          onPressed: () async {
                                                            debugPrint(
                                                                "volume button");
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            overlayColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                            padding:
                                                                WidgetStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
                                                            shape: WidgetStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners.
                                                              ),
                                                            ),
                                                          ),
                                                          icon: Icon(
                                                            Bootstrap.volume_up,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 35,
                                            height: 25,
                                            child: IconButton.filled(
                                                onPressed: () async {
                                                  debugPrint("tray is expaned");
                                                  setState(() {
                                                    audioTrayIsExpanded =
                                                        !audioTrayIsExpanded;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.transparent),
                                                  overlayColor:
                                                      WidgetStateProperty.all(
                                                          Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                  padding:
                                                      WidgetStateProperty.all(
                                                          EdgeInsets.zero),
                                                  shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // Rounded corners.
                                                    ),
                                                  ),
                                                ),
                                                icon: audioTrayIsExpanded
                                                    ? Icon(
                                                        Bootstrap
                                                            .arrows_angle_expand,
                                                        size: 13,
                                                        color: Colors.white,
                                                      )
                                                    : Icon(
                                                        Bootstrap
                                                            .arrows_angle_contract,
                                                        size: 13,
                                                        color: Colors.white,
                                                      )),
                                          ),
                                          audioTrayIsExpanded
                                              ? Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            top: 0,
                                                            bottom: 2),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.05),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          itemCount: allSongList
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2,
                                                                      horizontal:
                                                                          6),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  debugPrint(
                                                                      "song pressed in tray");
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                                                                            vertical:
                                                                                5,
                                                                            horizontal:
                                                                                5)),
                                                                        elevation:
                                                                            WidgetStateProperty.all(
                                                                                0),
                                                                        shape: WidgetStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8), // Rounded corners.
                                                                          ),
                                                                        ),
                                                                        backgroundColor: WidgetStateProperty.all(Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.06)),
                                                                        overlayColor: WidgetStateProperty.all(Colors
                                                                            .white
                                                                            .withOpacity(0.02))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              3),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      child:
                                                                          Icon(
                                                                        Bootstrap
                                                                            .music_note_beamed,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        allSongList[
                                                                            index],
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        style: GoogleFonts.alatsi(
                                                                            color: Colors
                                                                                .white,
                                                                            letterSpacing:
                                                                                1,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 9),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "artist name",
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        style: GoogleFonts.alatsi(
                                                                            color: Colors
                                                                                .white,
                                                                            letterSpacing:
                                                                                1,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 9),
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
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    !trayIsMinimized
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, left: 150),
                                child: Container(
                                  width: 350,
                                  height: 110,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.lightBlueAccent
                                              .withOpacity(0.12),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              0), // changes position of shadow
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, right: 10),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                                  child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                      Bootstrap
                                                          .music_note_beamed,
                                                      size: 60,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Text(
                                                          "Song Name",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: GoogleFonts
                                                              .alatsi(
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 11),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                right: 5,
                                                                bottom: 2,
                                                                top: 7),
                                                        child: Container(
                                                          height: 20,
                                                          width: 210,
                                                          child: ProgressBar(
                                                            progress: Duration(
                                                                seconds: 3),
                                                            total: Duration(
                                                                minutes: 1),
                                                            barCapShape:
                                                                BarCapShape
                                                                    .round,
                                                            progressBarColor:
                                                                Colors.white,
                                                            baseBarColor: Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.24),
                                                            bufferedBarColor:
                                                                Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.24),
                                                            thumbColor:
                                                                Colors.white,
                                                            barHeight: 4,
                                                            thumbGlowRadius: 0,
                                                            thumbRadius: 5.0,
                                                            timeLabelLocation:
                                                                TimeLabelLocation
                                                                    .sides,
                                                            timeLabelTextStyle:
                                                                GoogleFonts.alatsi(
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        9),
                                                            onSeek: (duration) {
                                                              // _player.seek(duration);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: IconButton
                                                                    .filled(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            debugPrint("shuffle pressed");
                                                                          });
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStateProperty.all(Colors.transparent),
                                                                          overlayColor: WidgetStateProperty.all(Colors
                                                                              .black
                                                                              .withOpacity(0.5)),
                                                                          padding:
                                                                              WidgetStateProperty.all(EdgeInsets.zero),
                                                                          shape:
                                                                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10), // Rounded corners.
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Bootstrap
                                                                              .shuffle,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                            SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: IconButton
                                                                    .filled(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            debugPrint("skip back");
                                                                          });
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStateProperty.all(Colors.transparent),
                                                                          overlayColor: WidgetStateProperty.all(Colors
                                                                              .black
                                                                              .withOpacity(0.5)),
                                                                          padding:
                                                                              WidgetStateProperty.all(EdgeInsets.zero),
                                                                          shape:
                                                                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10), // Rounded corners.
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Bootstrap
                                                                              .skip_backward_fill,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                            SizedBox(
                                                                width: 40,
                                                                height: 40,
                                                                child: IconButton.filled(
                                                                    onPressed: () {
                                                                      setState(
                                                                          () {
                                                                        debugPrint(
                                                                            "play");
                                                                        playeButtonIsPressed =
                                                                            !playeButtonIsPressed;
                                                                      });
                                                                    },
                                                                    style: ButtonStyle(
                                                                      backgroundColor:
                                                                          WidgetStateProperty.all(
                                                                              Colors.transparent),
                                                                      overlayColor: WidgetStateProperty.all(Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5)),
                                                                      padding: WidgetStateProperty.all(
                                                                          EdgeInsets
                                                                              .zero),
                                                                      shape: WidgetStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10), // Rounded corners.
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    icon: playeButtonIsPressed
                                                                        ? Icon(
                                                                            Bootstrap.play_circle_fill,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.white,
                                                                          )
                                                                        : Icon(
                                                                            Bootstrap.pause_circle_fill,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.white,
                                                                          ))),
                                                            SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: IconButton
                                                                    .filled(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            debugPrint("skip next");
                                                                          });
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStateProperty.all(Colors.transparent),
                                                                          overlayColor: WidgetStateProperty.all(Colors
                                                                              .black
                                                                              .withOpacity(0.5)),
                                                                          padding:
                                                                              WidgetStateProperty.all(EdgeInsets.zero),
                                                                          shape:
                                                                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10), // Rounded corners.
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Bootstrap
                                                                              .skip_forward_fill,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                            SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: IconButton
                                                                    .filled(
                                                                        onPressed:
                                                                            () async {
                                                                          debugPrint(
                                                                              "volume button");
                                                                        },
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStateProperty.all(Colors.transparent),
                                                                          overlayColor: WidgetStateProperty.all(Colors
                                                                              .black
                                                                              .withOpacity(0.5)),
                                                                          padding:
                                                                              WidgetStateProperty.all(EdgeInsets.zero),
                                                                          shape:
                                                                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10), // Rounded corners.
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Bootstrap
                                                                              .volume_up,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: IconButton.filled(
                                                    onPressed: () {
                                                      setState(() {
                                                        trayIsMinimized =
                                                            !trayIsMinimized;
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      overlayColor:
                                                          WidgetStateProperty
                                                              .all(Colors.black
                                                                  .withOpacity(
                                                                      0.5)),
                                                      padding:
                                                          WidgetStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      shape: WidgetStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6), // Rounded corners.
                                                        ),
                                                      ),
                                                    ),
                                                    icon: Icon(
                                                      Bootstrap
                                                          .arrow_up_right_square,
                                                      size: 13,
                                                      color: Colors.white,
                                                    ))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        : Container()
                  ],
                ))));
  }
}
