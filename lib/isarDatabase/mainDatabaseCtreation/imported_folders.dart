import 'package:isar/isar.dart';

part 'imported_folders.g.dart';

@Collection()
class ImportedFolders {
  Id importedFolderId = Isar.autoIncrement;
  late String? importedFollderPath;
}
