import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final player = AudioPlayer();
  SongData? selectedSong;
  SongData? nextSong;
  SongData? previusSong;

  void setAudioData(
      SongData selectedSong, SongData nextSong, SongData previusSong) {
    this.selectedSong = selectedSong;
    this.nextSong = nextSong;
    this.previusSong = previusSong;

    notifyListeners();
  }

  Future<void> playMusic(String musicPath) async {
    await player.play(musicPath as Source);
  }

  SongData? get getSelectedSongData => this.selectedSong;
  SongData? get getNextSongData => this.nextSong;
  SongData? get getPreviousSongData => this.previusSong;
}
