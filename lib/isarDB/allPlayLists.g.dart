// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allPlayLists.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAllPlayListsCollection on Isar {
  IsarCollection<AllPlayLists> get allPlayLists => this.collection();
}

const AllPlayListsSchema = CollectionSchema(
  name: r'AllPlayLists',
  id: 7023600640312580976,
  properties: {
    r'playListName': PropertySchema(
      id: 0,
      name: r'playListName',
      type: IsarType.string,
    ),
    r'songsIdList': PropertySchema(
      id: 1,
      name: r'songsIdList',
      type: IsarType.longList,
    )
  },
  estimateSize: _allPlayListsEstimateSize,
  serialize: _allPlayListsSerialize,
  deserialize: _allPlayListsDeserialize,
  deserializeProp: _allPlayListsDeserializeProp,
  idName: r'playListId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _allPlayListsGetId,
  getLinks: _allPlayListsGetLinks,
  attach: _allPlayListsAttach,
  version: '3.1.0+1',
);

int _allPlayListsEstimateSize(
  AllPlayLists object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.playListName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.songsIdList.length * 8;
  return bytesCount;
}

void _allPlayListsSerialize(
  AllPlayLists object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.playListName);
  writer.writeLongList(offsets[1], object.songsIdList);
}

AllPlayLists _allPlayListsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AllPlayLists();
  object.playListId = id;
  object.playListName = reader.readStringOrNull(offsets[0]);
  object.songsIdList = reader.readLongList(offsets[1]) ?? [];
  return object;
}

P _allPlayListsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _allPlayListsGetId(AllPlayLists object) {
  return object.playListId;
}

List<IsarLinkBase<dynamic>> _allPlayListsGetLinks(AllPlayLists object) {
  return [];
}

void _allPlayListsAttach(
    IsarCollection<dynamic> col, Id id, AllPlayLists object) {
  object.playListId = id;
}

extension AllPlayListsQueryWhereSort
    on QueryBuilder<AllPlayLists, AllPlayLists, QWhere> {
  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhere> anyPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AllPlayListsQueryWhere
    on QueryBuilder<AllPlayLists, AllPlayLists, QWhereClause> {
  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhereClause> playListIdEqualTo(
      Id playListId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: playListId,
        upper: playListId,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhereClause>
      playListIdNotEqualTo(Id playListId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: playListId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: playListId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: playListId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: playListId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhereClause>
      playListIdGreaterThan(Id playListId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: playListId, includeLower: include),
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhereClause>
      playListIdLessThan(Id playListId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: playListId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterWhereClause> playListIdBetween(
    Id lowerPlayListId,
    Id upperPlayListId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerPlayListId,
        includeLower: includeLower,
        upper: upperPlayListId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AllPlayListsQueryFilter
    on QueryBuilder<AllPlayLists, AllPlayLists, QFilterCondition> {
  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playListId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playListName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playListName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      playListNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songsIdList',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songsIdList',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songsIdList',
        value: value,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songsIdList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterFilterCondition>
      songsIdListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsIdList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AllPlayListsQueryObject
    on QueryBuilder<AllPlayLists, AllPlayLists, QFilterCondition> {}

extension AllPlayListsQueryLinks
    on QueryBuilder<AllPlayLists, AllPlayLists, QFilterCondition> {}

extension AllPlayListsQuerySortBy
    on QueryBuilder<AllPlayLists, AllPlayLists, QSortBy> {
  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy> sortByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy>
      sortByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension AllPlayListsQuerySortThenBy
    on QueryBuilder<AllPlayLists, AllPlayLists, QSortThenBy> {
  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy> thenByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.asc);
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy>
      thenByPlayListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.desc);
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy> thenByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QAfterSortBy>
      thenByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension AllPlayListsQueryWhereDistinct
    on QueryBuilder<AllPlayLists, AllPlayLists, QDistinct> {
  QueryBuilder<AllPlayLists, AllPlayLists, QDistinct> distinctByPlayListName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playListName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AllPlayLists, AllPlayLists, QDistinct> distinctBySongsIdList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songsIdList');
    });
  }
}

extension AllPlayListsQueryProperty
    on QueryBuilder<AllPlayLists, AllPlayLists, QQueryProperty> {
  QueryBuilder<AllPlayLists, int, QQueryOperations> playListIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListId');
    });
  }

  QueryBuilder<AllPlayLists, String?, QQueryOperations> playListNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListName');
    });
  }

  QueryBuilder<AllPlayLists, List<int>, QQueryOperations>
      songsIdListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songsIdList');
    });
  }
}
