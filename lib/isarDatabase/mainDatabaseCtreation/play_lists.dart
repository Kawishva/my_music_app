import 'package:isar/isar.dart';

part 'play_lists.g.dart';

@Collection()
class PlayLists {
  Id playListId = Isar.autoIncrement;
  late String? playListName;
  late List<int> songsIdList = List.empty(growable: true);
}
