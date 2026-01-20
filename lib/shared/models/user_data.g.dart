// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserDataCollection on Isar {
  IsarCollection<UserData> get userDatas => this.collection();
}

const UserDataSchema = CollectionSchema(
  name: r'UserData',
  id: 1,
  properties: {
    r'coins': PropertySchema(
      id: 0,
      name: r'coins',
      type: IsarType.long,
    ),
    r'hp': PropertySchema(
      id: 1,
      name: r'hp',
      type: IsarType.double,
    ),
    r'lastDiagnosis': PropertySchema(
      id: 2,
      name: r'lastDiagnosis',
      type: IsarType.dateTime,
    ),
    r'level': PropertySchema(
      id: 3,
      name: r'level',
      type: IsarType.long,
    ),
    r'ownedIds': PropertySchema(
      id: 4,
      name: r'ownedIds',
      type: IsarType.stringList,
    ),
    r'painLevel': PropertySchema(
      id: 5,
      name: r'painLevel',
      type: IsarType.double,
    ),
    r'selectedPosture': PropertySchema(
      id: 6,
      name: r'selectedPosture',
      type: IsarType.long,
    ),
    r'sittingHours': PropertySchema(
      id: 7,
      name: r'sittingHours',
      type: IsarType.double,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _userDataEstimateSize,
  serialize: _userDataSerialize,
  deserialize: _userDataDeserialize,
  deserializeProp: _userDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: 2,
      name: r'userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userDataGetId,
  getLinks: _userDataGetLinks,
  attach: _userDataAttach,
  version: '3.1.0+1',
);

int _userDataEstimateSize(
  UserData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ownedIds.length * 3;
  {
    for (var i = 0; i < object.ownedIds.length; i++) {
      final value = object.ownedIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userDataSerialize(
  UserData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.coins);
  writer.writeDouble(offsets[1], object.hp);
  writer.writeDateTime(offsets[2], object.lastDiagnosis);
  writer.writeLong(offsets[3], object.level);
  writer.writeStringList(offsets[4], object.ownedIds);
  writer.writeDouble(offsets[5], object.painLevel);
  writer.writeLong(offsets[6], object.selectedPosture);
  writer.writeDouble(offsets[7], object.sittingHours);
  writer.writeDateTime(offsets[8], object.updatedAt);
  writer.writeString(offsets[9], object.userId);
}

UserData _userDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserData();
  object.coins = reader.readLong(offsets[0]);
  object.hp = reader.readDouble(offsets[1]);
  object.id = id;
  object.lastDiagnosis = reader.readDateTimeOrNull(offsets[2]);
  object.level = reader.readLong(offsets[3]);
  object.ownedIds = reader.readStringList(offsets[4]) ?? [];
  object.painLevel = reader.readDouble(offsets[5]);
  object.selectedPosture = reader.readLong(offsets[6]);
  object.sittingHours = reader.readDouble(offsets[7]);
  object.updatedAt = reader.readDateTime(offsets[8]);
  object.userId = reader.readStringOrNull(offsets[9]);
  return object;
}

P _userDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userDataGetId(UserData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userDataGetLinks(UserData object) {
  return [];
}

void _userDataAttach(IsarCollection<dynamic> col, Id id, UserData object) {
  object.id = id;
}

extension UserDataByIndex on IsarCollection<UserData> {
  Future<UserData?> getByUserId(String? userId) {
    return getByIndex(r'userId', [userId]);
  }

  UserData? getByUserIdSync(String? userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String? userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String? userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<UserData?>> getAllByUserId(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<UserData?> getAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(UserData object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(UserData object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<UserData> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<UserData> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension UserDataQueryWhereSort on QueryBuilder<UserData, UserData, QWhere> {
  QueryBuilder<UserData, UserData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserDataQueryWhere on QueryBuilder<UserData, UserData, QWhereClause> {
  QueryBuilder<UserData, UserData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserData, UserData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> idBetween(
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

  QueryBuilder<UserData, UserData, QAfterWhereClause> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> userIdEqualTo(
      String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> userIdNotEqualTo(
      String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserDataQueryFilter
    on QueryBuilder<UserData, UserData, QFilterCondition> {
  QueryBuilder<UserData, UserData, QAfterFilterCondition> coinsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> coinsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> coinsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> coinsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> hpEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> hpGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> hpLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> hpBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserData, UserData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserData, UserData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      lastDiagnosisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastDiagnosis',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      lastDiagnosisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastDiagnosis',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastDiagnosisEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastDiagnosis',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      lastDiagnosisGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastDiagnosis',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastDiagnosisLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastDiagnosis',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastDiagnosisBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastDiagnosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> levelEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> levelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> levelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> levelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownedIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownedIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownedIds',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownedIds',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> ownedIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> ownedIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> ownedIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      ownedIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> ownedIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ownedIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> painLevelEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'painLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> painLevelGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'painLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> painLevelLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'painLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> painLevelBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'painLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      selectedPostureEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedPosture',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      selectedPostureGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedPosture',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      selectedPostureLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedPosture',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      selectedPostureBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedPosture',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> sittingHoursEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sittingHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      sittingHoursGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sittingHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> sittingHoursLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sittingHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> sittingHoursBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sittingHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UserDataQueryObject
    on QueryBuilder<UserData, UserData, QFilterCondition> {}

extension UserDataQueryLinks
    on QueryBuilder<UserData, UserData, QFilterCondition> {}

extension UserDataQuerySortBy on QueryBuilder<UserData, UserData, QSortBy> {
  QueryBuilder<UserData, UserData, QAfterSortBy> sortByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByHp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hp', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByHpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hp', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLastDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLastDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByPainLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'painLevel', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByPainLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'painLevel', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySelectedPosture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedPosture', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySelectedPostureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedPosture', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySittingHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sittingHours', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySittingHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sittingHours', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserDataQuerySortThenBy
    on QueryBuilder<UserData, UserData, QSortThenBy> {
  QueryBuilder<UserData, UserData, QAfterSortBy> thenByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByHp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hp', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByHpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hp', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLastDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLastDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByPainLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'painLevel', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByPainLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'painLevel', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySelectedPosture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedPosture', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySelectedPostureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedPosture', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySittingHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sittingHours', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySittingHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sittingHours', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserDataQueryWhereDistinct
    on QueryBuilder<UserData, UserData, QDistinct> {
  QueryBuilder<UserData, UserData, QDistinct> distinctByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coins');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByHp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hp');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByLastDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastDiagnosis');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByOwnedIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownedIds');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByPainLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'painLevel');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctBySelectedPosture() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedPosture');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctBySittingHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sittingHours');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserDataQueryProperty
    on QueryBuilder<UserData, UserData, QQueryProperty> {
  QueryBuilder<UserData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserData, int, QQueryOperations> coinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coins');
    });
  }

  QueryBuilder<UserData, double, QQueryOperations> hpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hp');
    });
  }

  QueryBuilder<UserData, DateTime?, QQueryOperations> lastDiagnosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastDiagnosis');
    });
  }

  QueryBuilder<UserData, int, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<UserData, List<String>, QQueryOperations> ownedIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownedIds');
    });
  }

  QueryBuilder<UserData, double, QQueryOperations> painLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'painLevel');
    });
  }

  QueryBuilder<UserData, int, QQueryOperations> selectedPostureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedPosture');
    });
  }

  QueryBuilder<UserData, double, QQueryOperations> sittingHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sittingHours');
    });
  }

  QueryBuilder<UserData, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<UserData, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
