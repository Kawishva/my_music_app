import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final player = AudioPlayer();
  Duration songCurrentDuration = Duration.zero;
  Duration songTotalDuration = Duration.zero;
  SongDataClass? selectedSong;
  List<SongDataClass> songDataList = [];
  double volume = 0.5;
  PlayerState playerState = PlayerState.stopped;

  void setAudioData(
      SongDataClass selectedSong, List<SongDataClass> songDataList) {
    this.selectedSong = selectedSong;
    this.songDataList = songDataList;
    notifyListeners();
  }

  AudiostreamFunctions() {
    // Listen to position changes
    player.onPositionChanged.listen((newPosition) {
      songCurrentDuration = newPosition;
      notifyListeners();
    });

    // Listen to duration changes
    player.onDurationChanged.listen((newDuration) {
      songTotalDuration = newDuration;
      notifyListeners();
    });

    // Listen to when the song is completed
    player.onPlayerComplete.listen((event) {
      playNextSong();
    });

    // Listen to player state changes
    player.onPlayerStateChanged.listen((newState) {
      playerState = newState;
      notifyListeners();
    });
  }

  Duration get remainingDuration {
    return songTotalDuration - songCurrentDuration;
  }

  void playMusic() async {
    await player.stop();
    await player.play(DeviceFileSource(selectedSong!.songPath.toString()));
    await player.setVolume(volume); // Set the volume when playing
    updateSongPlayState();
    notifyListeners();
  }

  void resumeSong() async {
    await player.resume();
    updateSongPlayState();
    notifyListeners();
  }

  void pauseMusic() async {
    await player.pause();
    updateSongPlayState();
    notifyListeners();
  }

  void songPlayPause() {
    if (selectedSong != null) {
      if (playerState != PlayerState.stopped) {
        if (playerState == PlayerState.playing) {
          pauseMusic();
        } else {
          resumeSong();
        }
      } else {
        playMusic();
      }
    }
  }

  Future<void> setVolume(double newVolume) async {
    volume = newVolume;
    await player.setVolume(volume);
    notifyListeners();
  }

  void seek(Duration position) async {
    await player.seek(position);
  }

  void playNextSong() {
    int currentIndex = songDataList.indexOf(selectedSong!);
    int nextIndex = (currentIndex + 1) % songDataList.length;
    selectedSong = songDataList[nextIndex];
    playMusic();
  }

  void playPreviousSong() {
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
  Duration get getCurrentDureation => this.songCurrentDuration;
  Duration get getsongTotalDuration => this.songTotalDuration;
  Duration get getRemainingDuration => this.remainingDuration;
  PlayerState get getPlayerState => this.playerState;
}
