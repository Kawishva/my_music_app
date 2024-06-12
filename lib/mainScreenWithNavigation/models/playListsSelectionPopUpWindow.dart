import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/isarDatabase/databaseHelper/song.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:provider/provider.dart';
import '../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../isarDatabase/databaseHelper/temporyPlayList.dart';

class PlayListPopUpWindow extends StatefulWidget {
  final SongDataClass selectedSong;
  const PlayListPopUpWindow({
    super.key,
    required this.selectedSong,
  });

  @override
  State<PlayListPopUpWindow> createState() => _PlayListPopUpWindowState();
}

class _PlayListPopUpWindowState extends State<PlayListPopUpWindow> {
  @override
  void initState() {
    readPlaylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);

    List<TemporyPlayList> temporyPlayListdataList =
        dataBaseHelperContext.temporyPlayListdataList;

    return OnPopupWindowWidget(
        duration: Duration.zero,
        backgroundColor: Colors.transparent,
        windowElevation: 0,
        intend: 1,
        child: Container(
          width: 190,
          height: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF022B35).withOpacity(0.6),
                Color(0xFF030B21).withOpacity(0.7),
                Color(0xFF000000).withOpacity(0.8),
                Color(0xFF260000).withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Select PlayList",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.alatsi(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      child: widget.selectedSong.imageByteArray.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.memory(
                                width: 40,
                                height: 40,
                                widget.selectedSong.imageByteArray,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Bootstrap.music_note_beamed,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      width: 120,
                      child: Text(
                        widget.selectedSong.songTitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.alatsi(
                          color: Colors.white,
                          //  letterSpacing: 1,
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemCount: temporyPlayListdataList.length,
                      itemBuilder: (context, index) {
                        int number = index + 1;
                        return Container(
                          //  decoration: BoxDecoration(color: Colors.amber),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                number == 1 ? "$number  ." : "$number .",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.alatsi(
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: 110,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    temporyPlayListdataList[index].playListName,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.alatsi(
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Transform.scale(
                                scale: 0.8, // Scale down the checkbox
                                child: Checkbox(
                                    value: temporyPlayListdataList[index]
                                        .songIsInPlayList,
                                    tristate: false,
                                    activeColor: Colors
                                        .white, // Active color of the checkbox
                                    overlayColor: WidgetStateProperty.all(Colors
                                        .transparent), // Transparent overlay color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Rounded corners for the checkbox
                                    ),
                                    focusColor: Colors.white,
                                    onChanged: (ticked) {
                                      temporyPlayListdataList[index]
                                          .songIsInPlayList = ticked ?? false;
                                      _addToPlayList(
                                        temporyPlayListdataList[index]
                                            .songTitle,
                                        temporyPlayListdataList[index]
                                            .playListId,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  void _addToPlayList(String songTitle, int playListId) {
    final tempDatabaseInstance = context.read<DataBaseHelper>();
    tempDatabaseInstance.addOrRemoveSelectedSongsToSelectedPlayList(
        playListId, songTitle);
    tempDatabaseInstance.fetchSongsListToSelectedPlayList(playListId);
  }
}
