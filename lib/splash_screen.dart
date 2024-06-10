import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'isarDatabase/databaseHelper/isarDatabaseHelper.dart';
import 'mainScreenWithNavigation/main_screen_with_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    reedSongs();
    readPlaylist();
    readFavourite();
    super.initState();
  }

  // Fetch all songs data from the database
  void reedSongs() {
    context.read<DataBaseHelper>().fetchSongAtStartUp();
  }

  // Fetch all playlists data from the database
  void readPlaylist() {
    context.read<DataBaseHelper>().fetchAllPlayListsDataFromDataBase();
  }

  // Fetch all favourite songs data from the database
  void readFavourite() {
    context.read<DataBaseHelper>().fetchFavouriteSongsFromSongData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlutterSplashScreen.fadeIn(
          // Setting the gradient for the splash screen background
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF022B35),
              Color(0xFF030B21),
              Color(0xFF000000),
              Color.fromARGB(255, 38, 0, 0),
            ],
          ),
          // Duration for the fade-in animation
          duration: Duration(seconds: 2),
          // Widget to display during the animation
          childWidget: Transform.scale(
            scale: 3, // Scales the child widget by a factor of 3
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "lib/icons/appicon.png",
              ),
            ),
          ),
          // The next screen to navigate to after the animation
          nextScreen: MainScreenWithNavigation(),
        ),
      ),
    );
  }
}
