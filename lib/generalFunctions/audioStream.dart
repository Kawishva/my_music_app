import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../isarDatabase/databaseHelper/song.dart';

class AudiostreamFunctions extends ChangeNotifier {
  final player = AudioPlayer();
  SongData? selectedAudio;

  void setAudioData(SongData selectedSong) {
    this.selectedAudio = selectedSong;

    notifyListeners();
  }

  Future<void> playMusic(String musicPath) async {
    await player.play(musicPath as Source);
  }

  SongData? get getSelectedSongData => this.selectedAudio;
}
