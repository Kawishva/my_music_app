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
  List<SongData> songsData = [];
  List<String> songsName = [];
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
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);
    // Determine the list of songs to display based on the current navigation bar index
    List<SongData> songDataList = dataBaseHelperContext.songDataList;
    List<SongData> favouriteSongDataList =
        dataBaseHelperContext.favouriteSongDataList;
    List<SongData> selectedPlayListSongsDataList =
        dataBaseHelperContext.selectedPlayListSongsDataList;

    if (navigationBarChangeInstance.navigationBarIndex == 1 ||
        navigationBarChangeInstance.navigationBarIndex == 0) {
      widget.songsData = songDataList;
      for (var song in songDataList) {
        widget.songsName.add(song.songTitle);
      }
    }
    if (navigationBarChangeInstance.navigationBarIndex == 2) {
      for (var song in favouriteSongDataList) {
        widget.songsData = favouriteSongDataList;
        widget.songsName.add(song.songTitle);
      }
    }
    if (navigationBarChangeInstance.navigationBarIndex == 3) {
      for (var song in selectedPlayListSongsDataList) {
        widget.songsData = selectedPlayListSongsDataList;
        widget.songsName.add(song.songTitle);
      }
    }

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
            debugPrint(value.searchKey);
            _songPalyAndPause(value.searchKey);
            widget.searchTextController.clear();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          suggestions: widget.songsName
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

  void _songPalyAndPause(String selectedSongName) {
    SongData? selectedSong;

    for (var songdata in widget.songsData) {
      if (songdata.songTitle == selectedSongName) {
        selectedSong = songdata;
      }
    }

    if (selectedSong != null) {
      context.read<AudiostreamFunctions>().setAudioData(selectedSong);

      context.read<NavigationBarChange>().setAudioTrayersAreVisible();

      context.read<NavigationBarChange>().setplayListNamgechange(true);

      context.read<DataBaseHelper>().songPalyAndPause(selectedSong.songId);

      context.read<AudiostreamFunctions>().playMusic();
    }
  }
}
