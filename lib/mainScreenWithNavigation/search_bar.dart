// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_music_app/generalFunctions/audioStream.dart';
import 'package:my_music_app/generalFunctions/navigationBarChange.dart';
import 'package:my_music_app/isarDatabase/databaseHelper/song.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../isarDatabase/databaseHelper/isarDatabaseHelper.dart';

class SongsSearchBar extends StatefulWidget {
  List<SongDataClass> songsData = [];
  final TextEditingController searchTextController = TextEditingController();

  SongsSearchBar({
    super.key,
  });

  @override
  State<SongsSearchBar> createState() => _SongsSearchBarState();
}

class _SongsSearchBarState extends State<SongsSearchBar> {
  @override
  void initState() {
    super.initState();
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
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);
    // Determine the list of songs to display based on the current navigation bar index
    List<SongDataClass> songDataList = dataBaseHelperContext.songDataList;
    List<SongDataClass> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongDataClass> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    if (navigationBarChangeInstance.navigationBarIndex == 1 ||
        navigationBarChangeInstance.navigationBarIndex == 0) {
      widget.songsData = songDataList;
      for (var song in songDataList) {}
    }
    if (navigationBarChangeInstance.navigationBarIndex == 2) {
      for (var song in favouriteSongDataList) {
        widget.songsData = favouriteSongDataList;
      }
    }
    if (navigationBarChangeInstance.navigationBarIndex == 3) {
      for (var song in selectedPlayListSongsDataList) {
        widget.songsData = selectedPlayListSongsDataList;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Container(
        width: 250,
        height: 27,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SearchField(
          controller: widget.searchTextController,
          onSuggestionTap: (value) {
            debugPrint(value.searchKey);
            _songPalyAndPause(value.searchKey);
            widget.searchTextController.clear();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          suggestions: widget.songsData
              .map((song) => SearchFieldListItem(song.songTitle.toString()))
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
              fontSize: 11,
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
            color: Colors.black.withOpacity(0.9),
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
            fillColor: Colors.white.withOpacity(0.1),
            border: InputBorder.none,
            hintText: "search....",
            hintStyle: GoogleFonts.alatsi(
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 0.5,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          ),
        ),
      ),
    );
  }

  void _songPalyAndPause(String selectedSongName) {
    SongDataClass? selectedSong;

    for (var songdata in widget.songsData) {
      if (songdata.songTitle == selectedSongName) {
        selectedSong = songdata;
      }
    }

    if (selectedSong != null) {
      context
          .read<AudiostreamFunctions>()
          .setAudioData(selectedSong, widget.songsData);

      context.read<NavigationBarChange>().setAudioTrayersAreVisible();
      context.read<AudiostreamFunctions>().playMusic();
    }
  }
}
