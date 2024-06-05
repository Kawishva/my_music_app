import 'package:isar/isar.dart';

part 'allSongs.g.dart';

@Collection()
class AllSongs {
  Id songId = Isar.autoIncrement;
  late String? songPath;
  bool songIsPlaying = false;
}
