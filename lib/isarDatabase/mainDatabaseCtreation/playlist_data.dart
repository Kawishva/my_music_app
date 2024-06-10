import 'package:isar/isar.dart';

part 'playlist_data.g.dart';

@Collection()
class PlayListsData {
  Id playListId = Isar.autoIncrement;
  late String? playListName;
  late List<String> songsTitle = List.empty(growable: true);
}
