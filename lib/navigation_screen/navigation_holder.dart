// ignore_for_file: avoid_unnecessary_containers

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
  bool playeButtonIsPressed = false;

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
                      Color(0xFF030C28), // Dark blue
                      // Color(0xFF19566B), // Medium blue
                      Color(0xFF133B74), // Light blue
                      Color(0xFF302b63), // Dark purple
                      Color(
                          0xFF0f2027), // Dark blue (again for smoother transition)
                    ],
                  ),
                ),
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
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  : const BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    )
                            ],
                            buttonOnPressed: () {
                              setState(() {
                                selectedIndex = 0;
                                listviewSelectedIndex = -1;
                                playeButtonIsPressed = !playeButtonIsPressed;
                              });
                            },
                            buttonColor: selectedIndex == 0
                                ? const Color(0xFF44C7FF)
                                : Colors.transparent,
                            buttonName: "EXPLORE",
                            buttonFontSize: 14,
                            buttonLetterSpacing: 3,
                            fontColor: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 32, top: 20),
                            child: Text(
                              "LIBRARY",
                              style: GoogleFonts.alatsi(
                                  color: Colors.lightBlueAccent,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: NavigationTextButton(
                              buttonBoxShadow: [
                                selectedIndex == 1
                                    ? const BoxShadow(
                                        color: Color(0xFF44C7FF),
                                        spreadRadius: 3,
                                        blurRadius: 8,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      )
                                    : const BoxShadow(
                                        color: Colors.transparent,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
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
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      )
                                    : const BoxShadow(
                                        color: Colors.transparent,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
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
                                  color: Colors.lightBlueAccent,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                itemCount: playLists.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5),
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

                    playeButtonIsPressed
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 10),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color(0xFF9E9E9E).withOpacity(0.09),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  playeButtonIsPressed =
                                                      !playeButtonIsPressed;
                                                });
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.lightBlueAccent),
                                                padding:
                                                    WidgetStateProperty.all(
                                                        EdgeInsets.zero),
                                                shape: WidgetStateProperty.all<
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
                                                    .arrow_down_left_square,
                                                size: 15,
                                                color: Colors.white,
                                              ))),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                      "Song Name",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.alatsi(
                                          color: Colors.lightBlueAccent,
                                          letterSpacing: 3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Icon(
                                              Bootstrap.music_note_beamed,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                ))));
  }
}
