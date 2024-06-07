import 'package:isar/isar.dart';

part 'recent_songs.g.dart';

@Collection()
class RecentSongs {
  Id recentId = Isar.autoIncrement;
  late int? songId;
}
