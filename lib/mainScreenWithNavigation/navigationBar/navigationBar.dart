import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/mainScreenWithNavigation/navigationBar/popUpWindow.dart';
import 'package:provider/provider.dart';
import '../../generalFunctions/navigationBarChange.dart';
import '../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../isarDatabase/databaseHelper/playlist.dart';
import '../models/audioButtons.dart';
import '../models/navigation_text_button.dart';

class NavigationBarHolder extends StatefulWidget {
  final TextEditingController newPlaylistName = TextEditingController();

  NavigationBarHolder({
    super.key,
  });

  @override
  State<NavigationBarHolder> createState() => _NavigationBarHolderState();
}

class _NavigationBarHolderState extends State<NavigationBarHolder> {
  @override
  void initState() {
    widget.newPlaylistName.clear();
    readPlaylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);
    List<PlayListClass> playListDataList =
        dataBaseHelperContext.playListDataList;

    return Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*   Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 0, top: 20),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    "lib/icons/app_icon.png",
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),*/

              // Library Label
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 50),
                child: Text(
                  "LIBRARY",
                  style: GoogleFonts.alatsi(
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              // All Songs Button
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 0),
                child: NavigationTextButton(
                  buttonBoxShadow: [
                    navigationBarChangeInstance.navigationBarIndex == 0
                        ? const BoxShadow(
                            color: Colors.white,
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
                  buttonOnPressed: () =>
                      _navigationBarIndexChangeFunction(0, -1, 0, "All songs"),
                  buttonColor: navigationBarChangeInstance.navigationIndex == 0
                      ? Colors.white
                      : Colors.transparent,
                  buttonName: "All songs",
                  buttonFontSize: 15,
                  buttonLetterSpacing: 1,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // Favourites Button
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: NavigationTextButton(
                  buttonBoxShadow: [
                    navigationBarChangeInstance.navigationBarIndex == 1
                        ? const BoxShadow(
                            color: Colors.white,
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
                  buttonOnPressed: () =>
                      _navigationBarIndexChangeFunction(1, -1, 0, "Favourites"),
                  buttonColor: navigationBarChangeInstance.navigationIndex == 1
                      ? Colors.white
                      : Colors.transparent,
                  buttonName: "Favourites",
                  buttonFontSize: 15,
                  buttonLetterSpacing: 1,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // Playlists Label
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PLAYLISTS",
                      style: GoogleFonts.alatsi(
                        color: Colors.white,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Builder(builder: (context) {
                      return AudioButtons(
                        onButtonPressed: () => _onCreatePopUpWindow(context),
                        buttonIcon: Bootstrap.plus_circle,
                        buttonWidth: 30,
                        buttonHeight: 30,
                        buttonIconSize: 20,
                        buttonBorderRadiusSize: 7,
                      );
                    }),
                  ],
                ),
              ),
              // Playlists List

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    itemCount: playListDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: NavigationTextButton(
                          buttonBoxShadow: [
                            navigationBarChangeInstance
                                        .playListviewSelectedIndex ==
                                    index
                                ? const BoxShadow(
                                    color: Colors.white,
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
                                  ),
                          ],
                          buttonOnPressed: () =>
                              _navigationBarIndexChangeFunction(
                                  2,
                                  index,
                                  playListDataList[index].playListId,
                                  playListDataList[index].playListName),
                          buttonColor:
                              navigationBarChangeInstance.playListviewIndex ==
                                      index
                                  ? Colors.white
                                  : Colors.transparent,
                          buttonName: playListDataList[index].playListName,
                          buttonFontSize: 15,
                          buttonLetterSpacing: 1,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]));
  }

  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  void _navigationBarIndexChangeFunction(int navigationBarIndex,
      int playListviewSelectedIndex, int playListId, String playListName) {
    final navigationBarChangeInstance = context.read<NavigationBarChange>();

    navigationBarChangeInstance.setplayListNamgechange(false);

    navigationBarChangeInstance.navigationBarIndexChangeFunction(
        navigationBarIndex, playListviewSelectedIndex, playListName);

    context.read<DataBaseHelper>().fetchSongsListToSelectedPlayList(playListId);
  }

  void _onCreatePopUpWindow(BuildContext newContext) {
// Display the pop-up window
    showDialog(
      context: newContext,
      builder: (context) => PopUpWindowHolder(
        onPressedCreateButton: () {
          Navigator.pop(context);
          context
              .read<DataBaseHelper>()
              .saveNewPlayListToDataBase(widget.newPlaylistName.text);
          widget.newPlaylistName.clear();
        },
        onPressedCloseButton: () {
          Navigator.pop(context);
          widget.newPlaylistName.clear();
        },
        newPlaylistNameController: this.widget.newPlaylistName,
        hintText: "New PLayList",
        icon: Bootstrap.music_note_list,
      ),
    );
  }
}
