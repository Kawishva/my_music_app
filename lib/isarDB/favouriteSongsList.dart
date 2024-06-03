import 'package:isar/isar.dart';

part 'favouriteSongsList.g.dart';

@Collection()
class FavouriteSongsList {
  Id favouriteSongId = Isar.autoIncrement;
  late String? songPath;
}
