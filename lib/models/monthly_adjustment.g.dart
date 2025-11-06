// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_adjustment.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlyAdjustmentCollection on Isar {
  IsarCollection<MonthlyAdjustment> get monthlyAdjustments => this.collection();
}

const MonthlyAdjustmentSchema = CollectionSchema(
  name: r'MonthlyAdjustment',
  id: 5666989571349784092,
  properties: {
    r'adjustmentAmount': PropertySchema(
      id: 0,
      name: r'adjustmentAmount',
      type: IsarType.double,
    ),
    r'adjustmentReason': PropertySchema(
      id: 1,
      name: r'adjustmentReason',
      type: IsarType.string,
    ),
    r'yearMonth': PropertySchema(
      id: 2,
      name: r'yearMonth',
      type: IsarType.string,
    ),
    r'yearMonthIndex': PropertySchema(
      id: 3,
      name: r'yearMonthIndex',
      type: IsarType.string,
    )
  },
  estimateSize: _monthlyAdjustmentEstimateSize,
  serialize: _monthlyAdjustmentSerialize,
  deserialize: _monthlyAdjustmentDeserialize,
  deserializeProp: _monthlyAdjustmentDeserializeProp,
  idName: r'id',
  indexes: {
    r'yearMonthIndex': IndexSchema(
      id: 6420319274240631876,
      name: r'yearMonthIndex',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'yearMonthIndex',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _monthlyAdjustmentGetId,
  getLinks: _monthlyAdjustmentGetLinks,
  attach: _monthlyAdjustmentAttach,
  version: '3.1.0+1',
);

int _monthlyAdjustmentEstimateSize(
  MonthlyAdjustment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.adjustmentReason.length * 3;
  bytesCount += 3 + object.yearMonth.length * 3;
  bytesCount += 3 + object.yearMonthIndex.length * 3;
  return bytesCount;
}

void _monthlyAdjustmentSerialize(
  MonthlyAdjustment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.adjustmentAmount);
  writer.writeString(offsets[1], object.adjustmentReason);
  writer.writeString(offsets[2], object.yearMonth);
  writer.writeString(offsets[3], object.yearMonthIndex);
}

MonthlyAdjustment _monthlyAdjustmentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlyAdjustment();
  object.adjustmentAmount = reader.readDouble(offsets[0]);
  object.adjustmentReason = reader.readString(offsets[1]);
  object.id = id;
  object.yearMonth = reader.readString(offsets[2]);
  return object;
}

P _monthlyAdjustmentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monthlyAdjustmentGetId(MonthlyAdjustment object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlyAdjustmentGetLinks(
    MonthlyAdjustment object) {
  return [];
}

void _monthlyAdjustmentAttach(
    IsarCollection<dynamic> col, Id id, MonthlyAdjustment object) {
  object.id = id;
}

extension MonthlyAdjustmentByIndex on IsarCollection<MonthlyAdjustment> {
  Future<MonthlyAdjustment?> getByYearMonthIndex(String yearMonthIndex) {
    return getByIndex(r'yearMonthIndex', [yearMonthIndex]);
  }

  MonthlyAdjustment? getByYearMonthIndexSync(String yearMonthIndex) {
    return getByIndexSync(r'yearMonthIndex', [yearMonthIndex]);
  }

  Future<bool> deleteByYearMonthIndex(String yearMonthIndex) {
    return deleteByIndex(r'yearMonthIndex', [yearMonthIndex]);
  }

  bool deleteByYearMonthIndexSync(String yearMonthIndex) {
    return deleteByIndexSync(r'yearMonthIndex', [yearMonthIndex]);
  }

  Future<List<MonthlyAdjustment?>> getAllByYearMonthIndex(
      List<String> yearMonthIndexValues) {
    final values = yearMonthIndexValues.map((e) => [e]).toList();
    return getAllByIndex(r'yearMonthIndex', values);
  }

  List<MonthlyAdjustment?> getAllByYearMonthIndexSync(
      List<String> yearMonthIndexValues) {
    final values = yearMonthIndexValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'yearMonthIndex', values);
  }

  Future<int> deleteAllByYearMonthIndex(List<String> yearMonthIndexValues) {
    final values = yearMonthIndexValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'yearMonthIndex', values);
  }

  int deleteAllByYearMonthIndexSync(List<String> yearMonthIndexValues) {
    final values = yearMonthIndexValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'yearMonthIndex', values);
  }

  Future<Id> putByYearMonthIndex(MonthlyAdjustment object) {
    return putByIndex(r'yearMonthIndex', object);
  }

  Id putByYearMonthIndexSync(MonthlyAdjustment object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'yearMonthIndex', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByYearMonthIndex(List<MonthlyAdjustment> objects) {
    return putAllByIndex(r'yearMonthIndex', objects);
  }

  List<Id> putAllByYearMonthIndexSync(List<MonthlyAdjustment> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'yearMonthIndex', objects, saveLinks: saveLinks);
  }
}

extension MonthlyAdjustmentQueryWhereSort
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QWhere> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonthlyAdjustmentQueryWhere
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QWhereClause> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      yearMonthIndexEqualTo(String yearMonthIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'yearMonthIndex',
        value: [yearMonthIndex],
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterWhereClause>
      yearMonthIndexNotEqualTo(String yearMonthIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearMonthIndex',
              lower: [],
              upper: [yearMonthIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearMonthIndex',
              lower: [yearMonthIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearMonthIndex',
              lower: [yearMonthIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearMonthIndex',
              lower: [],
              upper: [yearMonthIndex],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MonthlyAdjustmentQueryFilter
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QFilterCondition> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adjustmentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adjustmentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adjustmentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adjustmentAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adjustmentReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adjustmentReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adjustmentReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adjustmentReason',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      adjustmentReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adjustmentReason',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'yearMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'yearMonth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'yearMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearMonthIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'yearMonthIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'yearMonthIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearMonthIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterFilterCondition>
      yearMonthIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'yearMonthIndex',
        value: '',
      ));
    });
  }
}

extension MonthlyAdjustmentQueryObject
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QFilterCondition> {}

extension MonthlyAdjustmentQueryLinks
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QFilterCondition> {}

extension MonthlyAdjustmentQuerySortBy
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QSortBy> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByAdjustmentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentAmount', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByAdjustmentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentAmount', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByAdjustmentReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentReason', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByAdjustmentReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentReason', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByYearMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonth', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByYearMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonth', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByYearMonthIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonthIndex', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      sortByYearMonthIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonthIndex', Sort.desc);
    });
  }
}

extension MonthlyAdjustmentQuerySortThenBy
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QSortThenBy> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByAdjustmentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentAmount', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByAdjustmentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentAmount', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByAdjustmentReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentReason', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByAdjustmentReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adjustmentReason', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByYearMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonth', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByYearMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonth', Sort.desc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByYearMonthIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonthIndex', Sort.asc);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QAfterSortBy>
      thenByYearMonthIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearMonthIndex', Sort.desc);
    });
  }
}

extension MonthlyAdjustmentQueryWhereDistinct
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QDistinct> {
  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QDistinct>
      distinctByAdjustmentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adjustmentAmount');
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QDistinct>
      distinctByAdjustmentReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adjustmentReason',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QDistinct>
      distinctByYearMonth({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yearMonth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QDistinct>
      distinctByYearMonthIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yearMonthIndex',
          caseSensitive: caseSensitive);
    });
  }
}

extension MonthlyAdjustmentQueryProperty
    on QueryBuilder<MonthlyAdjustment, MonthlyAdjustment, QQueryProperty> {
  QueryBuilder<MonthlyAdjustment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlyAdjustment, double, QQueryOperations>
      adjustmentAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adjustmentAmount');
    });
  }

  QueryBuilder<MonthlyAdjustment, String, QQueryOperations>
      adjustmentReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adjustmentReason');
    });
  }

  QueryBuilder<MonthlyAdjustment, String, QQueryOperations>
      yearMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yearMonth');
    });
  }

  QueryBuilder<MonthlyAdjustment, String, QQueryOperations>
      yearMonthIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yearMonthIndex');
    });
  }
}
