import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final audioPlayer = AudioPlayer();
  VideoPlayerController? videoPlayer;

  Duration songCurrentDuration = Duration.zero;
  Duration songTotalDuration = Duration.zero;
  SongDataClass? selectedSong;
  List<SongDataClass> songDataList = [];
  double volume = 0.3;
  PlayerState playerState = PlayerState.stopped;

  void setAudioData(
      SongDataClass selectedSong, List<SongDataClass> songDataList) {
    this.selectedSong = selectedSong;
    this.songDataList = songDataList;
    notifyListeners();
  }

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

  Duration get remainingDuration {
    return songTotalDuration - songCurrentDuration;
  }

  Future<void> initializeVideoPlayer(String path) async {
    videoPlayer = VideoPlayerController.file(File(path));
    await videoPlayer!.initialize();
    videoPlayer!.addListener(() {
      if (videoPlayer!.value.isInitialized) {
        songCurrentDuration = videoPlayer!.value.position;
        songTotalDuration = videoPlayer!.value.duration;
        notifyListeners();
      }
    });
    notifyListeners();
  }

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

  void resumeSong() async {
    await audioPlayer.resume();

    updateSongPlayState();
    notifyListeners();
  }

  void resumeVideo() async {
    await videoPlayer!.play();
    updateSongPlayState();
    notifyListeners();
  }

  void pauseVideo() async {
    await videoPlayer!.pause();
    updateSongPlayState();
    notifyListeners();
  }

  void pauseMusic() async {
    await audioPlayer.pause();
    updateSongPlayState();
    notifyListeners();
  }

  Future<void> stopVideoPlayer() async {
    if (videoPlayer != null && videoPlayer!.value.isPlaying) {
      await videoPlayer!.pause();
      await videoPlayer!.dispose();
    }
  }

  void songPlayPause() async {
    if (selectedSong != null) {
      if (playerState != PlayerState.stopped &&
          selectedSong!.songPath.endsWith(".mp3")) {
        if (playerState == PlayerState.playing) {
          pauseMusic();
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

  Future<void> setVolume(double newVolume) async {
    volume = newVolume;
    await audioPlayer.setVolume(volume);
    if (videoPlayer!.value.isPlaying && videoPlayer != null) {
      await videoPlayer!.setVolume(volume);
    }

    notifyListeners();
  }

  void seek(Duration position) async {
    if (selectedSong!.songPath.endsWith(".mp3")) {
      await audioPlayer.seek(position);
    } else if (selectedSong!.songPath.endsWith(".mp4")) {
      videoPlayer!.seekTo(position);
    }
  }

  void playNextSong() async {
    int currentIndex = songDataList.indexOf(selectedSong!);
    int nextIndex = (currentIndex + 1) % songDataList.length;
    selectedSong = songDataList[nextIndex];
    playMusic();
  }

  void playPreviousSong() async {
    int currentIndex = songDataList.indexOf(selectedSong!);
    int previousIndex =
        (currentIndex - 1 + songDataList.length) % songDataList.length;
    selectedSong = songDataList[previousIndex];
    playMusic();
  }

  void updateSongPlayState() {
    for (var song in songDataList) {
      song.songIsPlaying =
          song == selectedSong && playerState == PlayerState.playing;
    }
    notifyListeners();
  }

  double get getVolume => volume;
  SongDataClass? get getSelectedSongData => this.selectedSong;
  Duration get getsongTotalDuration => this.songTotalDuration;
  Duration get getRemainingDuration => this.remainingDuration;
  PlayerState get getPlayerState => this.playerState;
  VideoPlayerController get getVideoPlayer => this.videoPlayer!;

  Duration getCurrentDuration() {
    if (selectedSong!.songPath.endsWith(".mp4")) {
      return this.videoPlayer!.value.position;
    } else {
      return this.songCurrentDuration;
    }
  }
}
