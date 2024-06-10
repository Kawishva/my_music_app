import 'package:isar/isar.dart';

part 'favorite_songs_list.g.dart';

@Collection()
class FavouriteSongsData {
  Id favouriteId = Isar.autoIncrement;
  late String? songTitle;
}
