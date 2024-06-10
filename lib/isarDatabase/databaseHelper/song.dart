import 'dart:typed_data';

class SongDataClass {
  String songTitle;
  String artistName;
  Uint8List imageByteArray;
  String songPath;
  bool songIsPlaying;
  bool songIsMyFavourite;

  SongDataClass(this.songTitle, this.artistName, this.imageByteArray,
      this.songPath, this.songIsPlaying, this.songIsMyFavourite);
}
