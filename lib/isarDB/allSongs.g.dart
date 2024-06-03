// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allSongs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAllSongsCollection on Isar {
  IsarCollection<AllSongs> get allSongs => this.collection();
}

const AllSongsSchema = CollectionSchema(
  name: r'AllSongs',
  id: -3197410461205064049,
  properties: {
    r'songPath': PropertySchema(
      id: 0,
      name: r'songPath',
      type: IsarType.string,
    )
  },
  estimateSize: _allSongsEstimateSize,
  serialize: _allSongsSerialize,
  deserialize: _allSongsDeserialize,
  deserializeProp: _allSongsDeserializeProp,
  idName: r'songId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _allSongsGetId,
  getLinks: _allSongsGetLinks,
  attach: _allSongsAttach,
  version: '3.1.0+1',
);

int _allSongsEstimateSize(
  AllSongs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.songPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _allSongsSerialize(
  AllSongs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.songPath);
}

AllSongs _allSongsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AllSongs();
  object.songId = id;
  object.songPath = reader.readStringOrNull(offsets[0]);
  return object;
}

P _allSongsDeserializeProp<P>(
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

Id _allSongsGetId(AllSongs object) {
  return object.songId;
}

List<IsarLinkBase<dynamic>> _allSongsGetLinks(AllSongs object) {
  return [];
}

void _allSongsAttach(IsarCollection<dynamic> col, Id id, AllSongs object) {
  object.songId = id;
}

extension AllSongsQueryWhereSort on QueryBuilder<AllSongs, AllSongs, QWhere> {
  QueryBuilder<AllSongs, AllSongs, QAfterWhere> anySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AllSongsQueryWhere on QueryBuilder<AllSongs, AllSongs, QWhereClause> {
  QueryBuilder<AllSongs, AllSongs, QAfterWhereClause> songIdEqualTo(Id songId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: songId,
        upper: songId,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterWhereClause> songIdNotEqualTo(
      Id songId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: songId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: songId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: songId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: songId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterWhereClause> songIdGreaterThan(
      Id songId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: songId, includeLower: include),
      );
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterWhereClause> songIdLessThan(Id songId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: songId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterWhereClause> songIdBetween(
    Id lowerSongId,
    Id upperSongId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerSongId,
        includeLower: includeLower,
        upper: upperSongId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AllSongsQueryFilter
    on QueryBuilder<AllSongs, AllSongs, QFilterCondition> {
  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songPath',
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songPath',
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterFilterCondition> songPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songPath',
        value: '',
      ));
    });
  }
}

extension AllSongsQueryObject
    on QueryBuilder<AllSongs, AllSongs, QFilterCondition> {}

extension AllSongsQueryLinks
    on QueryBuilder<AllSongs, AllSongs, QFilterCondition> {}

extension AllSongsQuerySortBy on QueryBuilder<AllSongs, AllSongs, QSortBy> {
  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> sortBySongPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.asc);
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> sortBySongPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.desc);
    });
  }
}

extension AllSongsQuerySortThenBy
    on QueryBuilder<AllSongs, AllSongs, QSortThenBy> {
  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> thenBySongPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.asc);
    });
  }

  QueryBuilder<AllSongs, AllSongs, QAfterSortBy> thenBySongPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.desc);
    });
  }
}

extension AllSongsQueryWhereDistinct
    on QueryBuilder<AllSongs, AllSongs, QDistinct> {
  QueryBuilder<AllSongs, AllSongs, QDistinct> distinctBySongPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songPath', caseSensitive: caseSensitive);
    });
  }
}

extension AllSongsQueryProperty
    on QueryBuilder<AllSongs, AllSongs, QQueryProperty> {
  QueryBuilder<AllSongs, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }

  QueryBuilder<AllSongs, String?, QQueryOperations> songPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songPath');
    });
  }
}
