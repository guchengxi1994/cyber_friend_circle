// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBoardCollection on Isar {
  IsarCollection<Board> get boards => this.collection();
}

const BoardSchema = CollectionSchema(
  name: r'Board',
  id: -7147534215782858650,
  properties: {
    r'bgImage': PropertySchema(
      id: 0,
      name: r'bgImage',
      type: IsarType.string,
    ),
    r'bgType': PropertySchema(
      id: 1,
      name: r'bgType',
      type: IsarType.string,
      enumMap: _BoardbgTypeEnumValueMap,
    ),
    r'createAt': PropertySchema(
      id: 2,
      name: r'createAt',
      type: IsarType.long,
    )
  },
  estimateSize: _boardEstimateSize,
  serialize: _boardSerialize,
  deserialize: _boardDeserialize,
  deserializeProp: _boardDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _boardGetId,
  getLinks: _boardGetLinks,
  attach: _boardAttach,
  version: '3.1.8',
);

int _boardEstimateSize(
  Board object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bgImage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.bgType.name.length * 3;
  return bytesCount;
}

void _boardSerialize(
  Board object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bgImage);
  writer.writeString(offsets[1], object.bgType.name);
  writer.writeLong(offsets[2], object.createAt);
}

Board _boardDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Board();
  object.bgImage = reader.readStringOrNull(offsets[0]);
  object.bgType =
      _BoardbgTypeValueEnumMap[reader.readStringOrNull(offsets[1])] ??
          ImageType.asset;
  object.createAt = reader.readLong(offsets[2]);
  object.id = id;
  return object;
}

P _boardDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (_BoardbgTypeValueEnumMap[reader.readStringOrNull(offset)] ??
          ImageType.asset) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BoardbgTypeEnumValueMap = {
  r'asset': r'asset',
  r'url': r'url',
  r'file': r'file',
  r'none': r'none',
};
const _BoardbgTypeValueEnumMap = {
  r'asset': ImageType.asset,
  r'url': ImageType.url,
  r'file': ImageType.file,
  r'none': ImageType.none,
};

Id _boardGetId(Board object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _boardGetLinks(Board object) {
  return [];
}

void _boardAttach(IsarCollection<dynamic> col, Id id, Board object) {
  object.id = id;
}

extension BoardQueryWhereSort on QueryBuilder<Board, Board, QWhere> {
  QueryBuilder<Board, Board, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BoardQueryWhere on QueryBuilder<Board, Board, QWhereClause> {
  QueryBuilder<Board, Board, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Board, Board, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Board, Board, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Board, Board, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BoardQueryFilter on QueryBuilder<Board, Board, QFilterCondition> {
  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgImage',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgImage',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgImage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgImage',
        value: '',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgImage',
        value: '',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeEqualTo(
    ImageType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeGreaterThan(
    ImageType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeLessThan(
    ImageType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeBetween(
    ImageType lower,
    ImageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgType',
        value: '',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> bgTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgType',
        value: '',
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> createAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> createAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> createAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Board, Board, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BoardQueryObject on QueryBuilder<Board, Board, QFilterCondition> {}

extension BoardQueryLinks on QueryBuilder<Board, Board, QFilterCondition> {}

extension BoardQuerySortBy on QueryBuilder<Board, Board, QSortBy> {
  QueryBuilder<Board, Board, QAfterSortBy> sortByBgImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgImage', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> sortByBgImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgImage', Sort.desc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> sortByBgType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgType', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> sortByBgTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgType', Sort.desc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }
}

extension BoardQuerySortThenBy on QueryBuilder<Board, Board, QSortThenBy> {
  QueryBuilder<Board, Board, QAfterSortBy> thenByBgImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgImage', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByBgImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgImage', Sort.desc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByBgType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgType', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByBgTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bgType', Sort.desc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Board, Board, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension BoardQueryWhereDistinct on QueryBuilder<Board, Board, QDistinct> {
  QueryBuilder<Board, Board, QDistinct> distinctByBgImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bgImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Board, Board, QDistinct> distinctByBgType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bgType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Board, Board, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }
}

extension BoardQueryProperty on QueryBuilder<Board, Board, QQueryProperty> {
  QueryBuilder<Board, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Board, String?, QQueryOperations> bgImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bgImage');
    });
  }

  QueryBuilder<Board, ImageType, QQueryOperations> bgTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bgType');
    });
  }

  QueryBuilder<Board, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }
}
