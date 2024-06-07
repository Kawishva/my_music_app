// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_lists.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayListsCollection on Isar {
  IsarCollection<PlayLists> get playLists => this.collection();
}

const PlayListsSchema = CollectionSchema(
  name: r'PlayLists',
  id: -7716305863640779075,
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
  estimateSize: _playListsEstimateSize,
  serialize: _playListsSerialize,
  deserialize: _playListsDeserialize,
  deserializeProp: _playListsDeserializeProp,
  idName: r'playListId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _playListsGetId,
  getLinks: _playListsGetLinks,
  attach: _playListsAttach,
  version: '3.1.0+1',
);

int _playListsEstimateSize(
  PlayLists object,
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

void _playListsSerialize(
  PlayLists object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.playListName);
  writer.writeLongList(offsets[1], object.songsIdList);
}

PlayLists _playListsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayLists();
  object.playListId = id;
  object.playListName = reader.readStringOrNull(offsets[0]);
  object.songsIdList = reader.readLongList(offsets[1]) ?? [];
  return object;
}

P _playListsDeserializeProp<P>(
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

Id _playListsGetId(PlayLists object) {
  return object.playListId;
}

List<IsarLinkBase<dynamic>> _playListsGetLinks(PlayLists object) {
  return [];
}

void _playListsAttach(IsarCollection<dynamic> col, Id id, PlayLists object) {
  object.playListId = id;
}

extension PlayListsQueryWhereSort
    on QueryBuilder<PlayLists, PlayLists, QWhere> {
  QueryBuilder<PlayLists, PlayLists, QAfterWhere> anyPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlayListsQueryWhere
    on QueryBuilder<PlayLists, PlayLists, QWhereClause> {
  QueryBuilder<PlayLists, PlayLists, QAfterWhereClause> playListIdEqualTo(
      Id playListId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: playListId,
        upper: playListId,
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterWhereClause> playListIdNotEqualTo(
      Id playListId) {
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

  QueryBuilder<PlayLists, PlayLists, QAfterWhereClause> playListIdGreaterThan(
      Id playListId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: playListId, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterWhereClause> playListIdLessThan(
      Id playListId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: playListId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterWhereClause> playListIdBetween(
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

extension PlayListsQueryFilter
    on QueryBuilder<PlayLists, PlayLists, QFilterCondition> {
  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListIdLessThan(
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListIdBetween(
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      playListNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      playListNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListNameEqualTo(
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListNameBetween(
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      playListNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition> playListNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playListName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      playListNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      playListNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
      songsIdListElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songsIdList',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

  QueryBuilder<PlayLists, PlayLists, QAfterFilterCondition>
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

extension PlayListsQueryObject
    on QueryBuilder<PlayLists, PlayLists, QFilterCondition> {}

extension PlayListsQueryLinks
    on QueryBuilder<PlayLists, PlayLists, QFilterCondition> {}

extension PlayListsQuerySortBy on QueryBuilder<PlayLists, PlayLists, QSortBy> {
  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> sortByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> sortByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension PlayListsQuerySortThenBy
    on QueryBuilder<PlayLists, PlayLists, QSortThenBy> {
  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> thenByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.asc);
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> thenByPlayListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.desc);
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> thenByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<PlayLists, PlayLists, QAfterSortBy> thenByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension PlayListsQueryWhereDistinct
    on QueryBuilder<PlayLists, PlayLists, QDistinct> {
  QueryBuilder<PlayLists, PlayLists, QDistinct> distinctByPlayListName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playListName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlayLists, PlayLists, QDistinct> distinctBySongsIdList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songsIdList');
    });
  }
}

extension PlayListsQueryProperty
    on QueryBuilder<PlayLists, PlayLists, QQueryProperty> {
  QueryBuilder<PlayLists, int, QQueryOperations> playListIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListId');
    });
  }

  QueryBuilder<PlayLists, String?, QQueryOperations> playListNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListName');
    });
  }

  QueryBuilder<PlayLists, List<int>, QQueryOperations> songsIdListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songsIdList');
    });
  }
}
