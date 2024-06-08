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
    List<PlayListData> playListDataList =
        dataBaseHelperContext.playListDataList;

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
                  navigationBarChangeInstance.navigationIndex == 0
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
                buttonOnPressed: () =>
                    _navigationBarIndexChangeFunction(0, -1, 0, "EXPLORE"),
                buttonColor: navigationBarChangeInstance.navigationIndex == 0
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
                    navigationBarChangeInstance.navigationBarIndex == 1
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
                  buttonOnPressed: () =>
                      _navigationBarIndexChangeFunction(1, -1, 0, "All songs"),
                  buttonColor: navigationBarChangeInstance.navigationIndex == 1
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
                    navigationBarChangeInstance.navigationBarIndex == 2
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
                  buttonOnPressed: () =>
                      _navigationBarIndexChangeFunction(2, -1, 0, "Favourites"),
                  buttonColor: navigationBarChangeInstance.navigationIndex == 2
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
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PLAYLISTS",
                      style: GoogleFonts.alatsi(
                        color: Colors.white,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
              Container(
                height: 250,
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
                                ),
                        ],
                        buttonOnPressed: () =>
                            _navigationBarIndexChangeFunction(
                                3,
                                index,
                                playListDataList[index].playListId,
                                playListDataList[index].playListName),
                        buttonColor:
                            navigationBarChangeInstance.playListviewIndex ==
                                    index
                                ? const Color(0xFF44C7FF)
                                : Colors.transparent,
                        buttonName: playListDataList[index].playListName,
                        buttonFontSize: 12,
                        buttonLetterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  },
                ),
              )
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
