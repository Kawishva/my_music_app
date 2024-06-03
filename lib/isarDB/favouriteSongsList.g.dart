// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favouriteSongsList.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavouriteSongsListCollection on Isar {
  IsarCollection<FavouriteSongsList> get favouriteSongsLists =>
      this.collection();
}

const FavouriteSongsListSchema = CollectionSchema(
  name: r'FavouriteSongsList',
  id: 1224283330321232574,
  properties: {
    r'songPath': PropertySchema(
      id: 0,
      name: r'songPath',
      type: IsarType.string,
    )
  },
  estimateSize: _favouriteSongsListEstimateSize,
  serialize: _favouriteSongsListSerialize,
  deserialize: _favouriteSongsListDeserialize,
  deserializeProp: _favouriteSongsListDeserializeProp,
  idName: r'favouriteSongId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _favouriteSongsListGetId,
  getLinks: _favouriteSongsListGetLinks,
  attach: _favouriteSongsListAttach,
  version: '3.1.0+1',
);

int _favouriteSongsListEstimateSize(
  FavouriteSongsList object,
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

void _favouriteSongsListSerialize(
  FavouriteSongsList object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.songPath);
}

FavouriteSongsList _favouriteSongsListDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavouriteSongsList();
  object.favouriteSongId = id;
  object.songPath = reader.readStringOrNull(offsets[0]);
  return object;
}

P _favouriteSongsListDeserializeProp<P>(
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

Id _favouriteSongsListGetId(FavouriteSongsList object) {
  return object.favouriteSongId;
}

List<IsarLinkBase<dynamic>> _favouriteSongsListGetLinks(
    FavouriteSongsList object) {
  return [];
}

void _favouriteSongsListAttach(
    IsarCollection<dynamic> col, Id id, FavouriteSongsList object) {
  object.favouriteSongId = id;
}

extension FavouriteSongsListQueryWhereSort
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QWhere> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhere>
      anyFavouriteSongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavouriteSongsListQueryWhere
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QWhereClause> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhereClause>
      favouriteSongIdEqualTo(Id favouriteSongId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: favouriteSongId,
        upper: favouriteSongId,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhereClause>
      favouriteSongIdNotEqualTo(Id favouriteSongId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: favouriteSongId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: favouriteSongId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: favouriteSongId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: favouriteSongId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhereClause>
      favouriteSongIdGreaterThan(Id favouriteSongId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(
            lower: favouriteSongId, includeLower: include),
      );
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhereClause>
      favouriteSongIdLessThan(Id favouriteSongId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: favouriteSongId, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterWhereClause>
      favouriteSongIdBetween(
    Id lowerFavouriteSongId,
    Id upperFavouriteSongId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerFavouriteSongId,
        includeLower: includeLower,
        upper: upperFavouriteSongId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavouriteSongsListQueryFilter
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QFilterCondition> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      favouriteSongIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favouriteSongId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      favouriteSongIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favouriteSongId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      favouriteSongIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favouriteSongId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      favouriteSongIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favouriteSongId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songPath',
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songPath',
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathEqualTo(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathGreaterThan(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathLessThan(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathBetween(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathStartsWith(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathEndsWith(
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

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterFilterCondition>
      songPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songPath',
        value: '',
      ));
    });
  }
}

extension FavouriteSongsListQueryObject
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QFilterCondition> {}

extension FavouriteSongsListQueryLinks
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QFilterCondition> {}

extension FavouriteSongsListQuerySortBy
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QSortBy> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      sortBySongPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      sortBySongPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.desc);
    });
  }
}

extension FavouriteSongsListQuerySortThenBy
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QSortThenBy> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      thenByFavouriteSongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteSongId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      thenByFavouriteSongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteSongId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      thenBySongPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QAfterSortBy>
      thenBySongPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songPath', Sort.desc);
    });
  }
}

extension FavouriteSongsListQueryWhereDistinct
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QDistinct> {
  QueryBuilder<FavouriteSongsList, FavouriteSongsList, QDistinct>
      distinctBySongPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songPath', caseSensitive: caseSensitive);
    });
  }
}

extension FavouriteSongsListQueryProperty
    on QueryBuilder<FavouriteSongsList, FavouriteSongsList, QQueryProperty> {
  QueryBuilder<FavouriteSongsList, int, QQueryOperations>
      favouriteSongIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favouriteSongId');
    });
  }

  QueryBuilder<FavouriteSongsList, String?, QQueryOperations>
      songPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songPath');
    });
  }
}
