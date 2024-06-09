import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final player = AudioPlayer();
  Duration songCurrentDuration = Duration.zero;
  Duration songTotalDuration = Duration.zero;
  SongData? selectedSong;
  double volume = 0.5;

  void setAudioData(SongData selectedSong) {
    this.selectedSong = selectedSong;

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
      // playNextSong(); is to play next song when current song is completed
    });
  }

  Duration get remainingDuration {
    return songTotalDuration - songCurrentDuration;
  }

  void playMusic() async {
    await player.stop();
    await player.play(DeviceFileSource(selectedSong!.songPath));
    await player.setVolume(volume); // Set the volume when playing
    notifyListeners();
  }

  void resumeSong() async {
    await player.resume();
    notifyListeners();
  }

  void pauseMusic() async {
    await player.pause();
    notifyListeners();
  }

  void songPlayPause() {
    if (selectedSong != null) {
      if (selectedSong!.songIsPlaying) {
        pauseMusic();
      } else {
        resumeSong();
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

  double get getVolume => volume;
  SongData? get getSelectedSongData => this.selectedSong;
  Duration get getCurrentDureation => this.songCurrentDuration;
  Duration get getsongTotalDuration => this.songTotalDuration;
  Duration get getRemainingDuration => this.remainingDuration;
}
