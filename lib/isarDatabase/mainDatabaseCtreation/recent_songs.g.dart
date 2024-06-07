// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_songs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentSongsCollection on Isar {
  IsarCollection<RecentSongs> get recentSongs => this.collection();
}

const RecentSongsSchema = CollectionSchema(
  name: r'RecentSongs',
  id: 7036226978767241819,
  properties: {
    r'songId': PropertySchema(
      id: 0,
      name: r'songId',
      type: IsarType.long,
    )
  },
  estimateSize: _recentSongsEstimateSize,
  serialize: _recentSongsSerialize,
  deserialize: _recentSongsDeserialize,
  deserializeProp: _recentSongsDeserializeProp,
  idName: r'recentId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentSongsGetId,
  getLinks: _recentSongsGetLinks,
  attach: _recentSongsAttach,
  version: '3.1.0+1',
);

int _recentSongsEstimateSize(
  RecentSongs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _recentSongsSerialize(
  RecentSongs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.songId);
}

RecentSongs _recentSongsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentSongs();
  object.recentId = id;
  object.songId = reader.readLongOrNull(offsets[0]);
  return object;
}

P _recentSongsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentSongsGetId(RecentSongs object) {
  return object.recentId;
}

List<IsarLinkBase<dynamic>> _recentSongsGetLinks(RecentSongs object) {
  return [];
}

void _recentSongsAttach(
    IsarCollection<dynamic> col, Id id, RecentSongs object) {
  object.recentId = id;
}

extension RecentSongsQueryWhereSort
    on QueryBuilder<RecentSongs, RecentSongs, QWhere> {
  QueryBuilder<RecentSongs, RecentSongs, QAfterWhere> anyRecentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentSongsQueryWhere
    on QueryBuilder<RecentSongs, RecentSongs, QWhereClause> {
  QueryBuilder<RecentSongs, RecentSongs, QAfterWhereClause> recentIdEqualTo(
      Id recentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: recentId,
        upper: recentId,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterWhereClause> recentIdNotEqualTo(
      Id recentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: recentId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: recentId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: recentId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: recentId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterWhereClause> recentIdGreaterThan(
      Id recentId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: recentId, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterWhereClause> recentIdLessThan(
      Id recentId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: recentId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterWhereClause> recentIdBetween(
    Id lowerRecentId,
    Id upperRecentId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerRecentId,
        includeLower: includeLower,
        upper: upperRecentId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecentSongsQueryFilter
    on QueryBuilder<RecentSongs, RecentSongs, QFilterCondition> {
  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> recentIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recentId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition>
      recentIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recentId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition>
      recentIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recentId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> recentIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> songIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songId',
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition>
      songIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songId',
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> songIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition>
      songIdGreaterThan(
    int? value, {
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

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> songIdLessThan(
    int? value, {
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

  QueryBuilder<RecentSongs, RecentSongs, QAfterFilterCondition> songIdBetween(
    int? lower,
    int? upper, {
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
}

extension RecentSongsQueryObject
    on QueryBuilder<RecentSongs, RecentSongs, QFilterCondition> {}

extension RecentSongsQueryLinks
    on QueryBuilder<RecentSongs, RecentSongs, QFilterCondition> {}

extension RecentSongsQuerySortBy
    on QueryBuilder<RecentSongs, RecentSongs, QSortBy> {
  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension RecentSongsQuerySortThenBy
    on QueryBuilder<RecentSongs, RecentSongs, QSortThenBy> {
  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> thenByRecentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recentId', Sort.asc);
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> thenByRecentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recentId', Sort.desc);
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<RecentSongs, RecentSongs, QAfterSortBy> thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension RecentSongsQueryWhereDistinct
    on QueryBuilder<RecentSongs, RecentSongs, QDistinct> {
  QueryBuilder<RecentSongs, RecentSongs, QDistinct> distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }
}

extension RecentSongsQueryProperty
    on QueryBuilder<RecentSongs, RecentSongs, QQueryProperty> {
  QueryBuilder<RecentSongs, int, QQueryOperations> recentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recentId');
    });
  }

  QueryBuilder<RecentSongs, int?, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }
}
