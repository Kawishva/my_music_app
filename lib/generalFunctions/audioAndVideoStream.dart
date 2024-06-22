import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final audioPlayer = AudioPlayer(); // Audio player instance
  VideoPlayerController? videoPlayer; // Video player controller

  Duration songCurrentDuration = Duration.zero; // Current position of the song
  Duration songTotalDuration = Duration.zero; // Total duration of the song
  SongDataClass? selectedSong; // Currently selected song
  List<SongDataClass> songDataList = []; // List of songs
  double volume = 0.3; // Volume level
  PlayerState playerState =
      PlayerState.stopped; // Player state (stopped, playing, etc.)

  AudiostreamFunctions() {
    // Listen to position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      songCurrentDuration = newPosition;
      notifyListeners();
    });

    // Listen to duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      songTotalDuration = newDuration;
      notifyListeners();
    });

    // Listen to when the song is completed
    audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });

    // Listen to player state changes
    audioPlayer.onPlayerStateChanged.listen((newState) {
      playerState = newState;
      notifyListeners();
    });
  }

  // Method to set audio data
  void setAudioData(
      SongDataClass selectedSong, List<SongDataClass> songDataList) {
    this.selectedSong = selectedSong;
    this.songDataList = songDataList;
    notifyListeners();
  }

  // Get remaining duration of the current song
  Duration get remainingDuration {
    return songTotalDuration - songCurrentDuration;
  }

  // Initialize video player with a file path
  Future<void> initializeVideoPlayer(String path) async {
    videoPlayer = VideoPlayerController.file(File(path));
    await videoPlayer!.initialize();
    videoPlayer!.addListener(() {
      if (videoPlayer!.value.isInitialized) {
        songCurrentDuration = videoPlayer!.value.position;
        songTotalDuration = videoPlayer!.value.duration;
        notifyListeners();
      }

      if (videoPlayer!.value.isCompleted) {
        playNextSong();
      }
    });
    notifyListeners();
  }

  // Play music or video based on file extension
  void playMusic() async {
    if (selectedSong!.songPath.endsWith(".mp3")) {
      await audioPlayer.stop();
      await stopVideoPlayer();
      await audioPlayer
          .play(DeviceFileSource(selectedSong!.songPath.toString()));
      await audioPlayer.setVolume(volume); // Set the volume when playing
    } else if (selectedSong!.songPath.endsWith(".mp4")) {
      await stopVideoPlayer();
      await initializeVideoPlayer(selectedSong!.songPath);
      await audioPlayer.stop();
      await videoPlayer!.setVolume(volume);
      await videoPlayer!.play();
      playerState = PlayerState.stopped;
    }
    updateSongPlayState();
    notifyListeners();
  }

  // Resume song playback
  void resumeSong() async {
    await audioPlayer.resume();
    updateSongPlayState();
    notifyListeners();
  }

  // Resume video playback
  void resumeVideo() async {
    await videoPlayer!.play();
    updateSongPlayState();
    notifyListeners();
  }

  // Pause video playback
  void pauseVideo() async {
    await videoPlayer!.pause();
    updateSongPlayState();
    notifyListeners();
  }

  // Pause music playback
  void pauseSong() async {
    await audioPlayer.pause();
    updateSongPlayState();
    notifyListeners();
  }

  // Stop and dispose video player
  Future<void> stopVideoPlayer() async {
    if (videoPlayer != null && videoPlayer!.value.isPlaying) {
      await videoPlayer!.pause();
      await videoPlayer!.dispose();
    }
  }

  // Play or pause music/video based on current state
  void songPlayPause() async {
    if (selectedSong != null) {
      if (playerState != PlayerState.stopped &&
          selectedSong!.songPath.endsWith(".mp3")) {
        if (playerState == PlayerState.playing) {
          pauseSong();
        } else {
          resumeSong();
        }
        stopVideoPlayer();
      } else if (selectedSong!.songPath.endsWith(".mp4")) {
        await audioPlayer.stop();
        if (videoPlayer!.value.isPlaying) {
          pauseVideo();
        } else {
          resumeVideo();
        }
        playerState = PlayerState.stopped;
      } else {
        playMusic();
      }
    }
    notifyListeners();
  }

  // Set volume for audio and video players
  Future<void> setVolume(double newVolume) async {
    volume = newVolume;
    await audioPlayer.setVolume(volume);
    if (videoPlayer != null && videoPlayer!.value.isPlaying) {
      await videoPlayer!.setVolume(volume);
    }
    notifyListeners();
  }

  // Seek to a specific position in the song or video
  void seek(Duration position) async {
    if (selectedSong!.songPath.endsWith(".mp3")) {
      await audioPlayer.seek(position);
    } else if (selectedSong!.songPath.endsWith(".mp4")) {
      videoPlayer!.seekTo(position);
    }
  }

  // Play the next song in the list
  void playNextSong() async {
    int currentIndex = songDataList.indexOf(selectedSong!);
    int nextIndex = (currentIndex + 1) % songDataList.length;
    selectedSong = songDataList[nextIndex];
    playMusic();
  }

  // Play the previous song in the list
  void playPreviousSong() async {
    int currentIndex = songDataList.indexOf(selectedSong!);
    int previousIndex =
        (currentIndex - 1 + songDataList.length) % songDataList.length;
    selectedSong = songDataList[previousIndex];
    playMusic();
  }

  // Update the play state of each song in the list
  void updateSongPlayState() {
    for (var song in songDataList) {
      song.songIsPlaying =
          song == selectedSong && playerState == PlayerState.playing;
    }
    notifyListeners();
  }

  // Getters for various properties
  double get getVolume => volume;
  SongDataClass? get getSelectedSongData => selectedSong;
  Duration get getsongTotalDuration => songTotalDuration;
  Duration get getRemainingDuration => remainingDuration;
  PlayerState get getPlayerState => playerState;
  VideoPlayerController get getVideoPlayer => videoPlayer!;

  // Get the current duration of the song or video
  Duration getCurrentDuration() {
    if (selectedSong != null && selectedSong!.songPath.endsWith(".mp4")) {
      return videoPlayer!.value.position;
    } else {
      return songCurrentDuration;
    }
  }
}
