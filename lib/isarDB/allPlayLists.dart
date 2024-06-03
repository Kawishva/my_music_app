import 'package:isar/isar.dart';

part 'allPlayLists.g.dart';

@Collection()
class AllPlayLists {
  Id playListId = Isar.autoIncrement;
  late String? playListName;
  late List<int> songsIdList;
}
