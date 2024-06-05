import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';

class SongsSearchBar extends StatefulWidget {
  final TextEditingController searchTextController = TextEditingController();

  SongsSearchBar({
    super.key,
  });

  @override
  State<SongsSearchBar> createState() => _SongsSearchBarState();
}

class _SongsSearchBarState extends State<SongsSearchBar> {
  List<int> allSongList = [];

  @override
  void initState() {
    super.initState();
    // Clear the search text controller on initialization.
    widget.searchTextController.clear();
  }

  @override
  void dispose() {
    // Clear the search text controller on disposal.
    widget.searchTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Container(
        width: 250,
        height: 27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.12),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: SearchField(
          controller: widget.searchTextController,
          onSuggestionTap: (value) {
            widget.searchTextController.clear();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          suggestions: allSongList
              .map((songName) => SearchFieldListItem(songName.toString()))
              .toList(),
          suggestionState: Suggestion.hidden,
          scrollbarDecoration: ScrollbarDecoration(
            thumbVisibility: false,
            thickness: 0,
          ),
          suggestionStyle: GoogleFonts.alatsi(
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
              fontSize: 12,
              overflow: TextOverflow.fade,
              color: Colors.white,
            ),
          ),
          searchStyle: GoogleFonts.alatsi(
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.5,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          suggestionItemDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          suggestionsDecoration: SuggestionDecoration(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            elevation: 0,
            // color: Colors.white.withOpacity(0.06),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF022B35).withOpacity(0.6),
                Color(0xFF030B21).withOpacity(0.8),
                Color(0xFF000000).withOpacity(0.9),
                Color(0xFF260000).withOpacity(0.9),
              ],
            ),
            selectionColor: Colors.transparent,
            shadowColor: Colors.transparent,
            hoverColor: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          searchInputDecoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.3),
            border: InputBorder.none,
            hintText: "search....🎧",
            hintStyle: GoogleFonts.alatsi(
              color: Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          ),
        ),
      ),
    );
  }
}
