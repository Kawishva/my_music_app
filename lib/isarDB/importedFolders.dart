import 'package:isar/isar.dart';

part 'importedFolders.g.dart';

@Collection()
class ImportedFolders {
  Id importedFolderId = Isar.autoIncrement;
  late String? importedFollderPath;
}
