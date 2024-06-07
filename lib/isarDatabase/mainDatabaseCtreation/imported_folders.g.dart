// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imported_folders.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetImportedFoldersCollection on Isar {
  IsarCollection<ImportedFolders> get importedFolders => this.collection();
}

const ImportedFoldersSchema = CollectionSchema(
  name: r'ImportedFolders',
  id: -3611729890431601250,
  properties: {
    r'importedFollderPath': PropertySchema(
      id: 0,
      name: r'importedFollderPath',
      type: IsarType.string,
    )
  },
  estimateSize: _importedFoldersEstimateSize,
  serialize: _importedFoldersSerialize,
  deserialize: _importedFoldersDeserialize,
  deserializeProp: _importedFoldersDeserializeProp,
  idName: r'importedFolderId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _importedFoldersGetId,
  getLinks: _importedFoldersGetLinks,
  attach: _importedFoldersAttach,
  version: '3.1.0+1',
);

int _importedFoldersEstimateSize(
  ImportedFolders object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.importedFollderPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _importedFoldersSerialize(
  ImportedFolders object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.importedFollderPath);
}

ImportedFolders _importedFoldersDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImportedFolders();
  object.importedFolderId = id;
  object.importedFollderPath = reader.readStringOrNull(offsets[0]);
  return object;
}

P _importedFoldersDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _importedFoldersGetId(ImportedFolders object) {
  return object.importedFolderId;
}

List<IsarLinkBase<dynamic>> _importedFoldersGetLinks(ImportedFolders object) {
  return [];
}

void _importedFoldersAttach(
    IsarCollection<dynamic> col, Id id, ImportedFolders object) {
  object.importedFolderId = id;
}

extension ImportedFoldersQueryWhereSort
    on QueryBuilder<ImportedFolders, ImportedFolders, QWhere> {
  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhere>
      anyImportedFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ImportedFoldersQueryWhere
    on QueryBuilder<ImportedFolders, ImportedFolders, QWhereClause> {
  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhereClause>
      importedFolderIdEqualTo(Id importedFolderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: importedFolderId,
        upper: importedFolderId,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhereClause>
      importedFolderIdNotEqualTo(Id importedFolderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: importedFolderId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: importedFolderId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: importedFolderId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: importedFolderId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhereClause>
      importedFolderIdGreaterThan(Id importedFolderId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(
            lower: importedFolderId, includeLower: include),
      );
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhereClause>
      importedFolderIdLessThan(Id importedFolderId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: importedFolderId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterWhereClause>
      importedFolderIdBetween(
    Id lowerImportedFolderId,
    Id upperImportedFolderId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerImportedFolderId,
        includeLower: includeLower,
        upper: upperImportedFolderId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImportedFoldersQueryFilter
    on QueryBuilder<ImportedFolders, ImportedFolders, QFilterCondition> {
  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFolderIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importedFolderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFolderIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importedFolderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFolderIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importedFolderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFolderIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importedFolderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importedFollderPath',
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importedFollderPath',
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importedFollderPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importedFollderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importedFollderPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importedFollderPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterFilterCondition>
      importedFollderPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importedFollderPath',
        value: '',
      ));
    });
  }
}

extension ImportedFoldersQueryObject
    on QueryBuilder<ImportedFolders, ImportedFolders, QFilterCondition> {}

extension ImportedFoldersQueryLinks
    on QueryBuilder<ImportedFolders, ImportedFolders, QFilterCondition> {}

extension ImportedFoldersQuerySortBy
    on QueryBuilder<ImportedFolders, ImportedFolders, QSortBy> {
  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      sortByImportedFollderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFollderPath', Sort.asc);
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      sortByImportedFollderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFollderPath', Sort.desc);
    });
  }
}

extension ImportedFoldersQuerySortThenBy
    on QueryBuilder<ImportedFolders, ImportedFolders, QSortThenBy> {
  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      thenByImportedFolderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFolderId', Sort.asc);
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      thenByImportedFolderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFolderId', Sort.desc);
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      thenByImportedFollderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFollderPath', Sort.asc);
    });
  }

  QueryBuilder<ImportedFolders, ImportedFolders, QAfterSortBy>
      thenByImportedFollderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importedFollderPath', Sort.desc);
    });
  }
}

extension ImportedFoldersQueryWhereDistinct
    on QueryBuilder<ImportedFolders, ImportedFolders, QDistinct> {
  QueryBuilder<ImportedFolders, ImportedFolders, QDistinct>
      distinctByImportedFollderPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importedFollderPath',
          caseSensitive: caseSensitive);
    });
  }
}

extension ImportedFoldersQueryProperty
    on QueryBuilder<ImportedFolders, ImportedFolders, QQueryProperty> {
  QueryBuilder<ImportedFolders, int, QQueryOperations>
      importedFolderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importedFolderId');
    });
  }

  QueryBuilder<ImportedFolders, String?, QQueryOperations>
      importedFollderPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importedFollderPath');
    });
  }
}
