import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:provider/provider.dart';
import '../../generalFunctions/moviesFunction.dart';

class MovieslistWindow extends StatefulWidget {
  const MovieslistWindow({super.key});

  @override
  State<MovieslistWindow> createState() => _MovieslistWindowState();
}

class _MovieslistWindowState extends State<MovieslistWindow> {
  @override
  Widget build(BuildContext context) {
    final movieStreamInstance = Provider.of<MoviesFunction>(context);

    return OnPopupWindowWidget(
      duration: Duration.zero,
      backgroundColor: Colors.transparent,
      windowElevation: 0,
      intend: 1,
      child: Container(
          width: 400,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              itemCount: movieStreamInstance.movieFiles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () => _playSlectedMovie(
                            movieStreamInstance.movieFiles[index]),
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                EdgeInsets.only(left: 10, right: 5)),
                            elevation: WidgetStateProperty.all(0),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Rounded corners.
                              ),
                            ),
                            backgroundColor: movieStreamInstance
                                        .selectedMovieFile ==
                                    movieStreamInstance.movieFiles[index]
                                ? WidgetStateProperty.all(
                                    Colors.white.withOpacity(0.1))
                                : WidgetStateProperty.all(Colors.transparent),
                            overlayColor: WidgetStateProperty.all(
                                Colors.white.withOpacity(0.05))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            movieStreamInstance.movieFiles[index].name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.alatsi(
                              letterSpacing: 2,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.normal,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }

  void _playSlectedMovie(XFile selectedMovie) {
    context.read<MoviesFunction>().selectedMovieFile = selectedMovie;
    context.read<MoviesFunction>().playMovie();
  }
}
