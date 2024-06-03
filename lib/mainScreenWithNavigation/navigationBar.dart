import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/navigation_text_button.dart';

class NavigationBarHolder extends StatefulWidget {
  final Function(int navigationBarIndex) navigationBarIndexChangeFunction;
  final List<String> playLists;

  const NavigationBarHolder({
    super.key,
    required this.navigationBarIndexChangeFunction,
    required this.playLists,
  });

  @override
  State<NavigationBarHolder> createState() => _NavigationBarHolderState();
}

class _NavigationBarHolderState extends State<NavigationBarHolder> {
  int navigationBarIndex = 0;
  int playListviewSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9E9E9E).withOpacity(0.09),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 30),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "lib/icons/appicon.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // Explore Button
          NavigationTextButton(
            buttonBoxShadow: [
              navigationBarIndex == 0
                  ? const BoxShadow(
                      color: Color(0xFF44C7FF),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    )
                  : const BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
            ],
            buttonOnPressed: () {
              setState(() {
                navigationBarIndex = 0;
                playListviewSelectedIndex = -1;
              });
              widget.navigationBarIndexChangeFunction(0);
            },
            buttonColor: navigationBarIndex == 0
                ? const Color(0xFF44C7FF)
                : Colors.transparent,
            buttonName: "EXPLORE",
            buttonFontSize: 14,
            buttonLetterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
          // Library Label
          Padding(
            padding: const EdgeInsets.only(right: 37, top: 20),
            child: Text(
              "LIBRARY",
              style: GoogleFonts.alatsi(
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // All Songs Button
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 0),
            child: NavigationTextButton(
              buttonBoxShadow: [
                navigationBarIndex == 1
                    ? const BoxShadow(
                        color: Color(0xFF44C7FF),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 0), // changes position of shadow
                      )
                    : const BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
              ],
              buttonOnPressed: () {
                setState(() {
                  navigationBarIndex = 1;
                  playListviewSelectedIndex = -1;
                });
                widget.navigationBarIndexChangeFunction(1);
              },
              buttonColor: navigationBarIndex == 1
                  ? const Color(0xFF44C7FF)
                  : Colors.transparent,
              buttonName: "All songs",
              buttonFontSize: 12,
              buttonLetterSpacing: 1,
              fontWeight: FontWeight.normal,
            ),
          ),
          // Favourites Button
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: NavigationTextButton(
              buttonBoxShadow: [
                navigationBarIndex == 2
                    ? const BoxShadow(
                        color: Color(0xFF44C7FF),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 0), // changes position of shadow
                      )
                    : const BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
              ],
              buttonOnPressed: () {
                setState(() {
                  navigationBarIndex = 2;
                  playListviewSelectedIndex = -1;
                });
                widget.navigationBarIndexChangeFunction(2);
              },
              buttonColor: navigationBarIndex == 2
                  ? const Color(0xFF44C7FF)
                  : Colors.transparent,
              buttonName: "Favourites",
              buttonFontSize: 12,
              buttonLetterSpacing: 1,
              fontWeight: FontWeight.normal,
            ),
          ),
          // Playlists Label
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 20, bottom: 0),
            child: Text(
              "PLAYLISTS",
              style: GoogleFonts.alatsi(
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // Playlists List
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5),
              itemCount: widget.playLists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: NavigationTextButton(
                    buttonBoxShadow: [
                      playListviewSelectedIndex == index
                          ? const BoxShadow(
                              color: Color(0xFF44C7FF),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            )
                          : const BoxShadow(
                              color: Colors.transparent,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                    ],
                    buttonOnPressed: () {
                      setState(() {
                        navigationBarIndex = 3;
                        playListviewSelectedIndex = index;
                      });
                      widget.navigationBarIndexChangeFunction(3);
                    },
                    buttonColor: playListviewSelectedIndex == index
                        ? const Color(0xFF44C7FF)
                        : Colors.transparent,
                    buttonName: widget.playLists[index],
                    buttonFontSize: 12,
                    buttonLetterSpacing: 1,
                    fontWeight: FontWeight.normal,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
