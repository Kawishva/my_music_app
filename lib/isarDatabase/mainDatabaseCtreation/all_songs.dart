import 'package:isar/isar.dart';

part 'all_songs.g.dart';

@Collection()
class AllSongs {
  Id songId = Isar.autoIncrement;
  late String? songPath;
  bool songIsPlaying = false;
  bool songIsMyFavourite = false;
}
