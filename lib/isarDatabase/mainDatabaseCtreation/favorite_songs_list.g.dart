// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_songs_list.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavouriteSongsDataCollection on Isar {
  IsarCollection<FavouriteSongsData> get favouriteSongsDatas =>
      this.collection();
}

const FavouriteSongsDataSchema = CollectionSchema(
  name: r'FavouriteSongsData',
  id: 3820535722669914080,
  properties: {
    r'songTitle': PropertySchema(
      id: 0,
      name: r'songTitle',
      type: IsarType.string,
    )
  },
  estimateSize: _favouriteSongsDataEstimateSize,
  serialize: _favouriteSongsDataSerialize,
  deserialize: _favouriteSongsDataDeserialize,
  deserializeProp: _favouriteSongsDataDeserializeProp,
  idName: r'favouriteId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _favouriteSongsDataGetId,
  getLinks: _favouriteSongsDataGetLinks,
  attach: _favouriteSongsDataAttach,
  version: '3.1.0+1',
);

int _favouriteSongsDataEstimateSize(
  FavouriteSongsData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.songTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _favouriteSongsDataSerialize(
  FavouriteSongsData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.songTitle);
}

FavouriteSongsData _favouriteSongsDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavouriteSongsData();
  object.favouriteId = id;
  object.songTitle = reader.readStringOrNull(offsets[0]);
  return object;
}

P _favouriteSongsDataDeserializeProp<P>(
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

Id _favouriteSongsDataGetId(FavouriteSongsData object) {
  return object.favouriteId;
}

List<IsarLinkBase<dynamic>> _favouriteSongsDataGetLinks(
    FavouriteSongsData object) {
  return [];
}

void _favouriteSongsDataAttach(
    IsarCollection<dynamic> col, Id id, FavouriteSongsData object) {
  object.favouriteId = id;
}

extension FavouriteSongsDataQueryWhereSort
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QWhere> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhere>
      anyFavouriteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavouriteSongsDataQueryWhere
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QWhereClause> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhereClause>
      favouriteIdEqualTo(Id favouriteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: favouriteId,
        upper: favouriteId,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhereClause>
      favouriteIdNotEqualTo(Id favouriteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: favouriteId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: favouriteId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: favouriteId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: favouriteId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhereClause>
      favouriteIdGreaterThan(Id favouriteId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: favouriteId, includeLower: include),
      );
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhereClause>
      favouriteIdLessThan(Id favouriteId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: favouriteId, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterWhereClause>
      favouriteIdBetween(
    Id lowerFavouriteId,
    Id upperFavouriteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerFavouriteId,
        includeLower: includeLower,
        upper: upperFavouriteId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavouriteSongsDataQueryFilter
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QFilterCondition> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      favouriteIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favouriteId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      favouriteIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favouriteId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      favouriteIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favouriteId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      favouriteIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favouriteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songTitle',
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songTitle',
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterFilterCondition>
      songTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songTitle',
        value: '',
      ));
    });
  }
}

extension FavouriteSongsDataQueryObject
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QFilterCondition> {}

extension FavouriteSongsDataQueryLinks
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QFilterCondition> {}

extension FavouriteSongsDataQuerySortBy
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QSortBy> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      sortBySongTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songTitle', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      sortBySongTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songTitle', Sort.desc);
    });
  }
}

extension FavouriteSongsDataQuerySortThenBy
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QSortThenBy> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      thenByFavouriteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      thenByFavouriteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      thenBySongTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songTitle', Sort.asc);
    });
  }

  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QAfterSortBy>
      thenBySongTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songTitle', Sort.desc);
    });
  }
}

extension FavouriteSongsDataQueryWhereDistinct
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QDistinct> {
  QueryBuilder<FavouriteSongsData, FavouriteSongsData, QDistinct>
      distinctBySongTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songTitle', caseSensitive: caseSensitive);
    });
  }
}

extension FavouriteSongsDataQueryProperty
    on QueryBuilder<FavouriteSongsData, FavouriteSongsData, QQueryProperty> {
  QueryBuilder<FavouriteSongsData, int, QQueryOperations>
      favouriteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favouriteId');
    });
  }

  QueryBuilder<FavouriteSongsData, String?, QQueryOperations>
      songTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songTitle');
    });
  }
}
