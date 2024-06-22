// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_music_app/generalFunctions/moviesFunction.dart';
import 'package:my_music_app/mainScreenWithNavigation/main_screen_with_navigation.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'models/audioButtons.dart';
import 'models/moviesList_window.dart';
import 'models/volumeSlider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isControllersVisible = true;
  List<XFile> importedMovieFiles = [];
  final FocusNode keyboardFucusNode = FocusNode();

  @override
  void initState() {
    importedMovieFiles.clear();
    keyboardFucusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    keyboardFucusNode.dispose();
    importedMovieFiles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieStreamInstance = Provider.of<MoviesFunction>(context);

    return Scaffold(
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode:
              keyboardFucusNode, // Ensure this is in focus to capture key events
          autofocus: true, // Ensure this is in focus to capture key events
          onKey: (RawKeyEvent event) {
            if (event.isKeyPressed(LogicalKeyboardKey.space) ||
                event.isKeyPressed(LogicalKeyboardKey.mediaPlayPause)) {
              movieStreamInstance.moviePlayPause();
              setState(() {
                isControllersVisible = !isControllersVisible;
              });
            }
            if (event.isKeyPressed(LogicalKeyboardKey.f6) ||
                event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              movieStreamInstance.playNextMovie();
            }
            if (event.isKeyPressed(LogicalKeyboardKey.f4) ||
                event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              movieStreamInstance.playPreviousMovie();
            }
            if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              double currentVolume = movieStreamInstance.volume;

              if (currentVolume != 1.0 && currentVolume < 1.00) {
                currentVolume = currentVolume + 0.05;
                movieStreamInstance.setVolume(currentVolume);
              } else {
                debugPrint("current volume = 100");
              }
            }
            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              double currentVolume = movieStreamInstance.volume;

              if (currentVolume != 0.0 && currentVolume > 0.00) {
                currentVolume = currentVolume - 0.05;
                movieStreamInstance.setVolume(currentVolume);
              } else {
                debugPrint("current volume = 00");
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: movieStreamInstance.videoPlayerController != null
                      ? Transform.scale(
                          scale: 1.0,
                          child: AspectRatio(
                              aspectRatio: movieStreamInstance
                                  .videoPlayerController!.value.aspectRatio,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isControllersVisible =
                                        !isControllersVisible;
                                  });

                                  debugPrint(isControllersVisible.toString());
                                },
                                child: VideoPlayer(
                                    movieStreamInstance.videoPlayerController!),
                              )),
                        )
                      : Icon(
                          Bootstrap.tv,
                          color: Colors.white,
                          size: 250,
                        ),
                ),
              ),
              isControllersVisible
                  ? FadeInUp(
                      animate: true,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ProgressBar(
                                progress:
                                    movieStreamInstance.movieCurrentDuration,
                                total: movieStreamInstance.movieTotalDuration,
                                barCapShape: BarCapShape.round,
                                progressBarColor: Colors.white,
                                baseBarColor: Colors.white.withOpacity(0.24),
                                bufferedBarColor:
                                    Colors.white.withOpacity(0.24),
                                thumbColor: Colors.white,
                                barHeight: 5,
                                thumbGlowRadius: 0,
                                thumbRadius: 4,
                                timeLabelLocation: TimeLabelLocation.sides,
                                timeLabelTextStyle: GoogleFonts.alatsi(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                ),
                                onSeek: (duration) {
                                  movieStreamInstance.seek(duration);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Tooltip(
                                          message: "Go to Music PLayer",
                                          child: AudioButtons(
                                              onButtonPressed: () {
                                                if (movieStreamInstance
                                                        .videoPlayerController !=
                                                    null) {
                                                  movieStreamInstance
                                                      .pauseVideo();
                                                }

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainScreenWithNavigation()),
                                                );
                                              },
                                              buttonIcon:
                                                  Bootstrap.music_note_beamed,
                                              buttonWidth: 25,
                                              buttonHeight: 25,
                                              buttonIconSize: 15,
                                              buttonBorderRadiusSize: 7),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Tooltip(
                                            message: "Select Movies",
                                            child: AudioButtons(
                                                onButtonPressed: () =>
                                                    _onSelectMovies(),
                                                buttonIcon:
                                                    Bootstrap.plus_circle,
                                                buttonWidth: 25,
                                                buttonHeight: 25,
                                                buttonIconSize: 15,
                                                buttonBorderRadiusSize: 7),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AudioButtons(
                                              onButtonPressed: () =>
                                                  _playPreviousMovie(),
                                              buttonIcon:
                                                  Bootstrap.skip_backward_fill,
                                              buttonWidth: 25,
                                              buttonHeight: 25,
                                              buttonIconSize: 15,
                                              buttonBorderRadiusSize: 7),
                                          AudioButtons(
                                              onButtonPressed: () =>
                                                  _moviePlayAndPause(),
                                              buttonIcon: movieStreamInstance
                                                              .videoPlayerController !=
                                                          null &&
                                                      movieStreamInstance
                                                          .videoPlayerController!
                                                          .value
                                                          .isPlaying
                                                  ? Bootstrap.pause_fill
                                                  : Bootstrap.play_fill,
                                              buttonWidth: 30,
                                              buttonHeight: 30,
                                              buttonIconSize: 30,
                                              buttonBorderRadiusSize: 10),
                                          AudioButtons(
                                              onButtonPressed: () =>
                                                  _playNextMovie(),
                                              buttonIcon:
                                                  Bootstrap.skip_forward_fill,
                                              buttonWidth: 25,
                                              buttonHeight: 25,
                                              buttonIconSize: 15,
                                              buttonBorderRadiusSize: 7),
                                        ],
                                      ),
                                    ),
                                    // Expand/Collapse button

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Builder(builder: (context) {
                                              return AudioButtons(
                                                  onButtonPressed: () =>
                                                      _changeVolume(context),
                                                  buttonIcon:
                                                      Bootstrap.volume_up,
                                                  buttonWidth: 25,
                                                  buttonHeight: 25,
                                                  buttonIconSize: 15,
                                                  buttonBorderRadiusSize: 7);
                                            }),
                                            Text(
                                              ((movieStreamInstance.volume *
                                                          100)
                                                      .toInt())
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.alatsi(
                                                color: Colors.white,
                                                //letterSpacing: 1,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Tooltip(
                                            message: "Movie List",
                                            child: Builder(builder: (context) {
                                              return AudioButtons(
                                                  onButtonPressed: () =>
                                                      _moviesListPopUpWindow(
                                                          context),
                                                  buttonIcon:
                                                      Bootstrap.list_task,
                                                  buttonWidth: 25,
                                                  buttonHeight: 25,
                                                  buttonIconSize: 15,
                                                  buttonBorderRadiusSize: 7);
                                            }),
                                          ),
                                        ),
                                        // Playlist (visible when expanded)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void _moviePlayAndPause() {
    context.read<MoviesFunction>().moviePlayPause();
  }

  void _playNextMovie() {
    context.read<MoviesFunction>().playNextMovie();
  }

  void _playPreviousMovie() {
    context.read<MoviesFunction>().playPreviousMovie();
  }

  void _changeVolume(BuildContext newContext) {
    showDialog(context: newContext, builder: (context) => VolumePopUpSlider());
  }

  void _moviesListPopUpWindow(BuildContext newContext) {
    showDialog(context: newContext, builder: (context) => MovieslistWindow());
  }

  // Displays a popup window for playlist selection.
  Future<void> _onSelectMovies() async {
    importedMovieFiles.clear();
    context.read<MoviesFunction>().movieFiles.clear();

    const XTypeGroup fileTypes = XTypeGroup(
      label: 'All Files',
      extensions: <String>['*'],
    );

    importedMovieFiles = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      fileTypes,
    ]);

    context
        .read<MoviesFunction>()
        .setMovieData(importedMovieFiles, importedMovieFiles.first);
  }
}
