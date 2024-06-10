// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayListsDataCollection on Isar {
  IsarCollection<PlayListsData> get playListsDatas => this.collection();
}

const PlayListsDataSchema = CollectionSchema(
  name: r'PlayListsData',
  id: 2115070559539117500,
  properties: {
    r'playListName': PropertySchema(
      id: 0,
      name: r'playListName',
      type: IsarType.string,
    ),
    r'songsTitle': PropertySchema(
      id: 1,
      name: r'songsTitle',
      type: IsarType.stringList,
    )
  },
  estimateSize: _playListsDataEstimateSize,
  serialize: _playListsDataSerialize,
  deserialize: _playListsDataDeserialize,
  deserializeProp: _playListsDataDeserializeProp,
  idName: r'playListId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _playListsDataGetId,
  getLinks: _playListsDataGetLinks,
  attach: _playListsDataAttach,
  version: '3.1.0+1',
);

int _playListsDataEstimateSize(
  PlayListsData object,
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
  bytesCount += 3 + object.songsTitle.length * 3;
  {
    for (var i = 0; i < object.songsTitle.length; i++) {
      final value = object.songsTitle[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _playListsDataSerialize(
  PlayListsData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.playListName);
  writer.writeStringList(offsets[1], object.songsTitle);
}

PlayListsData _playListsDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayListsData();
  object.playListId = id;
  object.playListName = reader.readStringOrNull(offsets[0]);
  object.songsTitle = reader.readStringList(offsets[1]) ?? [];
  return object;
}

P _playListsDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playListsDataGetId(PlayListsData object) {
  return object.playListId;
}

List<IsarLinkBase<dynamic>> _playListsDataGetLinks(PlayListsData object) {
  return [];
}

void _playListsDataAttach(
    IsarCollection<dynamic> col, Id id, PlayListsData object) {
  object.playListId = id;
}

extension PlayListsDataQueryWhereSort
    on QueryBuilder<PlayListsData, PlayListsData, QWhere> {
  QueryBuilder<PlayListsData, PlayListsData, QAfterWhere> anyPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlayListsDataQueryWhere
    on QueryBuilder<PlayListsData, PlayListsData, QWhereClause> {
  QueryBuilder<PlayListsData, PlayListsData, QAfterWhereClause>
      playListIdEqualTo(Id playListId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: playListId,
        upper: playListId,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterWhereClause>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterWhereClause>
      playListIdGreaterThan(Id playListId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: playListId, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterWhereClause>
      playListIdLessThan(Id playListId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: playListId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterWhereClause>
      playListIdBetween(
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

extension PlayListsDataQueryFilter
    on QueryBuilder<PlayListsData, PlayListsData, QFilterCondition> {
  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListId',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playListName',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
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

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playListName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playListName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      playListNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playListName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songsTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songsTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songsTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songsTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songsTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterFilterCondition>
      songsTitleLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsTitle',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PlayListsDataQueryObject
    on QueryBuilder<PlayListsData, PlayListsData, QFilterCondition> {}

extension PlayListsDataQueryLinks
    on QueryBuilder<PlayListsData, PlayListsData, QFilterCondition> {}

extension PlayListsDataQuerySortBy
    on QueryBuilder<PlayListsData, PlayListsData, QSortBy> {
  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy>
      sortByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy>
      sortByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension PlayListsDataQuerySortThenBy
    on QueryBuilder<PlayListsData, PlayListsData, QSortThenBy> {
  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy> thenByPlayListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.asc);
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy>
      thenByPlayListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListId', Sort.desc);
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy>
      thenByPlayListName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.asc);
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QAfterSortBy>
      thenByPlayListNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playListName', Sort.desc);
    });
  }
}

extension PlayListsDataQueryWhereDistinct
    on QueryBuilder<PlayListsData, PlayListsData, QDistinct> {
  QueryBuilder<PlayListsData, PlayListsData, QDistinct> distinctByPlayListName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playListName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlayListsData, PlayListsData, QDistinct> distinctBySongsTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songsTitle');
    });
  }
}

extension PlayListsDataQueryProperty
    on QueryBuilder<PlayListsData, PlayListsData, QQueryProperty> {
  QueryBuilder<PlayListsData, int, QQueryOperations> playListIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListId');
    });
  }

  QueryBuilder<PlayListsData, String?, QQueryOperations>
      playListNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playListName');
    });
  }

  QueryBuilder<PlayListsData, List<String>, QQueryOperations>
      songsTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songsTitle');
    });
  }
}
