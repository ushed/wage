// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJobCollection on Isar {
  IsarCollection<Job> get jobs => this.collection();
}

const JobSchema = CollectionSchema(
  name: r'Job',
  id: -5961302972855324388,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'rates': PropertySchema(
      id: 1,
      name: r'rates',
      type: IsarType.doubleList,
    ),
    r'transportation': PropertySchema(
      id: 2,
      name: r'transportation',
      type: IsarType.double,
    )
  },
  estimateSize: _jobEstimateSize,
  serialize: _jobSerialize,
  deserialize: _jobDeserialize,
  deserializeProp: _jobDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _jobGetId,
  getLinks: _jobGetLinks,
  attach: _jobAttach,
  version: '3.1.0+1',
);

int _jobEstimateSize(
  Job object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.rates.length * 8;
  return bytesCount;
}

void _jobSerialize(
  Job object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeDoubleList(offsets[1], object.rates);
  writer.writeDouble(offsets[2], object.transportation);
}

Job _jobDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Job(
    name: reader.readString(offsets[0]),
    rates: reader.readDoubleList(offsets[1]) ?? [],
    transportation: reader.readDouble(offsets[2]),
  );
  object.id = id;
  return object;
}

P _jobDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jobGetId(Job object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jobGetLinks(Job object) {
  return [];
}

void _jobAttach(IsarCollection<dynamic> col, Id id, Job object) {
  object.id = id;
}

extension JobQueryWhereSort on QueryBuilder<Job, Job, QWhere> {
  QueryBuilder<Job, Job, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JobQueryWhere on QueryBuilder<Job, Job, QWhereClause> {
  QueryBuilder<Job, Job, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Job, Job, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Job, Job, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Job, Job, QAfterWhereClause> idBetween(
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

extension JobQueryFilter on QueryBuilder<Job, Job, QFilterCondition> {
  QueryBuilder<Job, Job, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Job, Job, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Job, Job, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Job, Job, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rates',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rates',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rates',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rates',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> ratesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rates',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> transportationEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> transportationGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> transportationLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Job, Job, QAfterFilterCondition> transportationBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transportation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension JobQueryObject on QueryBuilder<Job, Job, QFilterCondition> {}

extension JobQueryLinks on QueryBuilder<Job, Job, QFilterCondition> {}

extension JobQuerySortBy on QueryBuilder<Job, Job, QSortBy> {
  QueryBuilder<Job, Job, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> sortByTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transportation', Sort.asc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> sortByTransportationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transportation', Sort.desc);
    });
  }
}

extension JobQuerySortThenBy on QueryBuilder<Job, Job, QSortThenBy> {
  QueryBuilder<Job, Job, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> thenByTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transportation', Sort.asc);
    });
  }

  QueryBuilder<Job, Job, QAfterSortBy> thenByTransportationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transportation', Sort.desc);
    });
  }
}

extension JobQueryWhereDistinct on QueryBuilder<Job, Job, QDistinct> {
  QueryBuilder<Job, Job, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Job, Job, QDistinct> distinctByRates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rates');
    });
  }

  QueryBuilder<Job, Job, QDistinct> distinctByTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transportation');
    });
  }
}

extension JobQueryProperty on QueryBuilder<Job, Job, QQueryProperty> {
  QueryBuilder<Job, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Job, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Job, List<double>, QQueryOperations> ratesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rates');
    });
  }

  QueryBuilder<Job, double, QQueryOperations> transportationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transportation');
    });
  }
}
