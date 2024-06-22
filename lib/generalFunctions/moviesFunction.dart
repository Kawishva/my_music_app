import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MoviesFunction extends ChangeNotifier {
  VideoPlayerController? videoPlayerController;
  List<XFile> movieFiles = [];
  XFile? selectedMovieFile;
  double volume = 0.3;
  Duration movieCurrentDuration = Duration.zero;
  Duration movieTotalDuration = Duration.zero;

  void setMovieData(List<XFile> movieFiles, XFile? selectedMovieFile) {
    this.movieFiles = movieFiles;
    this.selectedMovieFile = selectedMovieFile;
    if (this.selectedMovieFile != null) {
      playMovie();
    }
    notifyListeners();
  }

  Future<void> initializeVideoPlayer(File movieFile) async {
    videoPlayerController = VideoPlayerController.file(movieFile);
    await videoPlayerController!.initialize();
    videoPlayerController!.addListener(() {
      if (videoPlayerController!.value.isInitialized) {
        movieCurrentDuration = videoPlayerController!.value.position;
        movieTotalDuration = videoPlayerController!.value.duration;
        notifyListeners();
      }

      if (videoPlayerController!.value.isCompleted) {
        playNextMovie();
      }
    });
    notifyListeners();
  }

  Future<void> playMovie() async {
    await stopVideoPlayer();
    if (selectedMovieFile != null) {
      await initializeVideoPlayer(File(selectedMovieFile!.path));
      await videoPlayerController!.setVolume(volume);
      await videoPlayerController!.play();
      notifyListeners();
    }
  }

  Future<void> stopVideoPlayer() async {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        await videoPlayerController!.pause();
      }
      await videoPlayerController!.dispose();
      videoPlayerController = null;
    }
  }

  Future<void> resumeVideo() async {
    if (videoPlayerController != null) {
      await videoPlayerController!.play();
      notifyListeners();
    }
  }

  Future<void> pauseVideo() async {
    if (videoPlayerController != null) {
      await videoPlayerController!.pause();
      notifyListeners();
    }
  }

  Future<void> moviePlayPause() async {
    if (selectedMovieFile != null) {
      if (videoPlayerController != null) {
        if (videoPlayerController!.value.isPlaying) {
          await pauseVideo();
        } else {
          await resumeVideo();
        }
      } else {
        await playMovie();
      }
    }
    notifyListeners();
  }

  Future<void> playNextMovie() async {
    int currentIndex = movieFiles.indexOf(selectedMovieFile!);
    int nextIndex = (currentIndex + 1) % movieFiles.length;
    selectedMovieFile = movieFiles[nextIndex];
    await playMovie();
    notifyListeners();
  }

  Future<void> playPreviousMovie() async {
    int currentIndex = movieFiles.indexOf(selectedMovieFile!);
    int previousIndex =
        (currentIndex - 1 + movieFiles.length) % movieFiles.length;
    selectedMovieFile = movieFiles[previousIndex];
    await playMovie();
    notifyListeners();
  }

  Future<void> setVolume(double newVolume) async {
    volume = newVolume;
    if (videoPlayerController != null) {
      await videoPlayerController!.setVolume(volume);
    }
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    if (videoPlayerController != null) {
      await videoPlayerController!.seekTo(position);
    }
    notifyListeners();
  }
}
