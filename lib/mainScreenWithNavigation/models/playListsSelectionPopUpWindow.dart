import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:provider/provider.dart';
import '../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../isarDatabase/databaseHelper/temporyPlayList.dart';

class PlayListPopUpWindow extends StatefulWidget {
  final int songId;
  const PlayListPopUpWindow({
    super.key,
    required this.songId,
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
          width: 180,
          height: 250,
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
                  return Container(
                    //  decoration: BoxDecoration(color: Colors.amber),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
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
                        Transform.scale(
                          scale: 0.8, // Scale down the checkbox
                          child: Checkbox(
                              value: temporyPlayListdataList[index]
                                  .songIsInPlayList,
                              tristate: false,
                              activeColor:
                                  Colors.white, // Active color of the checkbox
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
                                  temporyPlayListdataList[index].songId,
                                  temporyPlayListdataList[index].playListId,
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ));
  }

  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  void _addToPlayList(int songId, int playListId) {
    final tempDatabaseInstance = context.read<DataBaseHelper>();

    tempDatabaseInstance.fetchSongsListToSelectedPlayList(playListId);

    tempDatabaseInstance.addOrRemoveSelectedSongsToSelectedPlayList(
        playListId, songId);
  }
}
