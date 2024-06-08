import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import '../../../isarDatabase/databaseHelper/playlist.dart';
import 'songsListView.dart';

class MainScreenHolder extends StatefulWidget {
  const MainScreenHolder({
    super.key,
  });

  @override
  State<MainScreenHolder> createState() => _MainScreenHolderState();
}

class _MainScreenHolderState extends State<MainScreenHolder> {
  @override
  void initState() {
    super.initState();
    readPlaylist();
  }

// Fetch all playlists data from the database
  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  @override
  Widget build(BuildContext context) {
    final dataBaseHelperContext = Provider.of<DataBaseHelper>(context);
    List<PlayListData> playListDataList =
        dataBaseHelperContext.playListDataList;

    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 5, left: 5, bottom: 95),
          itemCount: playListDataList.length,
          itemBuilder: (context, index) {
            //  context.read<DataBaseHelper>().fetchSongsListToSelectedPlayList(
            //   playListDataList[index].playListId);
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      playListDataList[index].playListName.toUpperCase(),
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
                        width: playListDataList[index]
                                .playListName
                                .length
                                .toDouble() *
                            7,
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
                      playListID: playListDataList[index].playListId,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
