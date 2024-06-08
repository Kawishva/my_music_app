import 'dart:typed_data';

class SongData {
  int songId;
  String songTitle;
  String artistName;
  Uint8List imageByteArray;
  String songPath;
  bool songIsPlaying;
  bool songIsMyFavourite;

  SongData(this.songId, this.songTitle, this.artistName, this.imageByteArray,
      this.songPath, this.songIsPlaying, this.songIsMyFavourite);
}
