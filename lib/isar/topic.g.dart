// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTopicCollection on Isar {
  IsarCollection<Topic> get topics => this.collection();
}

const TopicSchema = CollectionSchema(
  name: r'Topic',
  id: 5334984740663963266,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 1,
      name: r'createAt',
      type: IsarType.long,
    ),
    r'done': PropertySchema(
      id: 2,
      name: r'done',
      type: IsarType.bool,
    ),
    r'maxReplyCount': PropertySchema(
      id: 3,
      name: r'maxReplyCount',
      type: IsarType.long,
    )
  },
  estimateSize: _topicEstimateSize,
  serialize: _topicSerialize,
  deserialize: _topicDeserialize,
  deserializeProp: _topicDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'replies': LinkSchema(
      id: -5174005178110276142,
      name: r'replies',
      target: r'TopicReply',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _topicGetId,
  getLinks: _topicGetLinks,
  attach: _topicAttach,
  version: '3.1.8',
);

int _topicEstimateSize(
  Topic object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _topicSerialize(
  Topic object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeLong(offsets[1], object.createAt);
  writer.writeBool(offsets[2], object.done);
  writer.writeLong(offsets[3], object.maxReplyCount);
}

Topic _topicDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Topic();
  object.content = reader.readStringOrNull(offsets[0]);
  object.createAt = reader.readLong(offsets[1]);
  object.done = reader.readBool(offsets[2]);
  object.id = id;
  object.maxReplyCount = reader.readLong(offsets[3]);
  return object;
}

P _topicDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _topicGetId(Topic object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _topicGetLinks(Topic object) {
  return [object.replies];
}

void _topicAttach(IsarCollection<dynamic> col, Id id, Topic object) {
  object.id = id;
  object.replies.attach(col, col.isar.collection<TopicReply>(), r'replies', id);
}

extension TopicQueryWhereSort on QueryBuilder<Topic, Topic, QWhere> {
  QueryBuilder<Topic, Topic, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TopicQueryWhere on QueryBuilder<Topic, Topic, QWhereClause> {
  QueryBuilder<Topic, Topic, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Topic, Topic, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Topic, Topic, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Topic, Topic, QAfterWhereClause> idBetween(
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

extension TopicQueryFilter on QueryBuilder<Topic, Topic, QFilterCondition> {
  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> createAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> createAtGreaterThan(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> createAtLessThan(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> createAtBetween(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> doneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'done',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Topic, Topic, QAfterFilterCondition> maxReplyCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxReplyCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> maxReplyCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxReplyCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> maxReplyCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxReplyCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> maxReplyCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxReplyCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TopicQueryObject on QueryBuilder<Topic, Topic, QFilterCondition> {}

extension TopicQueryLinks on QueryBuilder<Topic, Topic, QFilterCondition> {
  QueryBuilder<Topic, Topic, QAfterFilterCondition> replies(
      FilterQuery<TopicReply> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'replies');
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'replies', length, true, length, true);
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'replies', 0, true, 0, true);
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'replies', 0, false, 999999, true);
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'replies', 0, true, length, include);
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'replies', length, include, 999999, true);
    });
  }

  QueryBuilder<Topic, Topic, QAfterFilterCondition> repliesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'replies', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TopicQuerySortBy on QueryBuilder<Topic, Topic, QSortBy> {
  QueryBuilder<Topic, Topic, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByMaxReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReplyCount', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> sortByMaxReplyCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReplyCount', Sort.desc);
    });
  }
}

extension TopicQuerySortThenBy on QueryBuilder<Topic, Topic, QSortThenBy> {
  QueryBuilder<Topic, Topic, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByMaxReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReplyCount', Sort.asc);
    });
  }

  QueryBuilder<Topic, Topic, QAfterSortBy> thenByMaxReplyCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReplyCount', Sort.desc);
    });
  }
}

extension TopicQueryWhereDistinct on QueryBuilder<Topic, Topic, QDistinct> {
  QueryBuilder<Topic, Topic, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Topic, Topic, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<Topic, Topic, QDistinct> distinctByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'done');
    });
  }

  QueryBuilder<Topic, Topic, QDistinct> distinctByMaxReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxReplyCount');
    });
  }
}

extension TopicQueryProperty on QueryBuilder<Topic, Topic, QQueryProperty> {
  QueryBuilder<Topic, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Topic, String?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<Topic, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<Topic, bool, QQueryOperations> doneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'done');
    });
  }

  QueryBuilder<Topic, int, QQueryOperations> maxReplyCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxReplyCount');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTopicReplyCollection on Isar {
  IsarCollection<TopicReply> get topicReplys => this.collection();
}

const TopicReplySchema = CollectionSchema(
  name: r'TopicReply',
  id: 3156967209846682427,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 1,
      name: r'createAt',
      type: IsarType.long,
    ),
    r'reaction': PropertySchema(
      id: 2,
      name: r'reaction',
      type: IsarType.byte,
      enumMap: _TopicReplyreactionEnumValueMap,
    ),
    r'replyType': PropertySchema(
      id: 3,
      name: r'replyType',
      type: IsarType.byte,
      enumMap: _TopicReplyreplyTypeEnumValueMap,
    )
  },
  estimateSize: _topicReplyEstimateSize,
  serialize: _topicReplySerialize,
  deserialize: _topicReplyDeserialize,
  deserializeProp: _topicReplyDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: 7182188776465688024,
      name: r'user',
      target: r'User',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _topicReplyGetId,
  getLinks: _topicReplyGetLinks,
  attach: _topicReplyAttach,
  version: '3.1.8',
);

int _topicReplyEstimateSize(
  TopicReply object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _topicReplySerialize(
  TopicReply object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeLong(offsets[1], object.createAt);
  writer.writeByte(offsets[2], object.reaction.index);
  writer.writeByte(offsets[3], object.replyType.index);
}

TopicReply _topicReplyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TopicReply();
  object.content = reader.readStringOrNull(offsets[0]);
  object.createAt = reader.readLong(offsets[1]);
  object.id = id;
  object.reaction =
      _TopicReplyreactionValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          Reaction.like;
  object.replyType =
      _TopicReplyreplyTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          ReplyType.text;
  return object;
}

P _topicReplyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_TopicReplyreactionValueEnumMap[reader.readByteOrNull(offset)] ??
          Reaction.like) as P;
    case 3:
      return (_TopicReplyreplyTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          ReplyType.text) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TopicReplyreactionEnumValueMap = {
  'like': 0,
  'dislike': 1,
  'none': 2,
};
const _TopicReplyreactionValueEnumMap = {
  0: Reaction.like,
  1: Reaction.dislike,
  2: Reaction.none,
};
const _TopicReplyreplyTypeEnumValueMap = {
  'text': 0,
  'image': 1,
  'animatedEmoji': 2,
  'emoji': 3,
};
const _TopicReplyreplyTypeValueEnumMap = {
  0: ReplyType.text,
  1: ReplyType.image,
  2: ReplyType.animatedEmoji,
  3: ReplyType.emoji,
};

Id _topicReplyGetId(TopicReply object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _topicReplyGetLinks(TopicReply object) {
  return [object.user];
}

void _topicReplyAttach(IsarCollection<dynamic> col, Id id, TopicReply object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<User>(), r'user', id);
}

extension TopicReplyQueryWhereSort
    on QueryBuilder<TopicReply, TopicReply, QWhere> {
  QueryBuilder<TopicReply, TopicReply, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TopicReplyQueryWhere
    on QueryBuilder<TopicReply, TopicReply, QWhereClause> {
  QueryBuilder<TopicReply, TopicReply, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TopicReply, TopicReply, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterWhereClause> idBetween(
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

extension TopicReplyQueryFilter
    on QueryBuilder<TopicReply, TopicReply, QFilterCondition> {
  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> createAtEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      createAtGreaterThan(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> createAtLessThan(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> createAtBetween(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> reactionEqualTo(
      Reaction value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reaction',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      reactionGreaterThan(
    Reaction value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reaction',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> reactionLessThan(
    Reaction value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reaction',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> reactionBetween(
    Reaction lower,
    Reaction upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reaction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> replyTypeEqualTo(
      ReplyType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'replyType',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition>
      replyTypeGreaterThan(
    ReplyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'replyType',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> replyTypeLessThan(
    ReplyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'replyType',
        value: value,
      ));
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> replyTypeBetween(
    ReplyType lower,
    ReplyType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'replyType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TopicReplyQueryObject
    on QueryBuilder<TopicReply, TopicReply, QFilterCondition> {}

extension TopicReplyQueryLinks
    on QueryBuilder<TopicReply, TopicReply, QFilterCondition> {
  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> user(
      FilterQuery<User> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterFilterCondition> userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }
}

extension TopicReplyQuerySortBy
    on QueryBuilder<TopicReply, TopicReply, QSortBy> {
  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByReaction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reaction', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByReactionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reaction', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByReplyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'replyType', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> sortByReplyTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'replyType', Sort.desc);
    });
  }
}

extension TopicReplyQuerySortThenBy
    on QueryBuilder<TopicReply, TopicReply, QSortThenBy> {
  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByReaction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reaction', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByReactionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reaction', Sort.desc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByReplyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'replyType', Sort.asc);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QAfterSortBy> thenByReplyTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'replyType', Sort.desc);
    });
  }
}

extension TopicReplyQueryWhereDistinct
    on QueryBuilder<TopicReply, TopicReply, QDistinct> {
  QueryBuilder<TopicReply, TopicReply, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TopicReply, TopicReply, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<TopicReply, TopicReply, QDistinct> distinctByReaction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reaction');
    });
  }

  QueryBuilder<TopicReply, TopicReply, QDistinct> distinctByReplyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'replyType');
    });
  }
}

extension TopicReplyQueryProperty
    on QueryBuilder<TopicReply, TopicReply, QQueryProperty> {
  QueryBuilder<TopicReply, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TopicReply, String?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<TopicReply, int, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<TopicReply, Reaction, QQueryOperations> reactionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reaction');
    });
  }

  QueryBuilder<TopicReply, ReplyType, QQueryOperations> replyTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'replyType');
    });
  }
}
