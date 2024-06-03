import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'songsListView.dart';

class MainScreenHolder extends StatefulWidget {
  final List<String> allSongList, playLists;
  final Function() onPlayAndPauseButtonPressed;

  const MainScreenHolder({
    super.key,
    required this.allSongList,
    required this.playLists,
    required this.onPlayAndPauseButtonPressed,
  });

  @override
  State<MainScreenHolder> createState() => _MainScreenHolderState();
}

class _MainScreenHolderState extends State<MainScreenHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 5, left: 5, bottom: 95),
          itemCount: widget.playLists.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.playLists[index].toUpperCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alatsi(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: Container(
                        height: 2,
                        width: widget.playLists[index].length.toDouble() * 7,
                        decoration: BoxDecoration(
                            color: Color(0xFF860B02),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              )
                            ]),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: SongsListView(
                      allSongList: this.widget.allSongList,
                      onPlayAndPauseButtonPressed: () =>
                          this.widget.onPlayAndPauseButtonPressed(),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
