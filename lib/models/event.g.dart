// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventModelCollection on Isar {
  IsarCollection<EventModel> get eventModels => this.collection();
}

const EventModelSchema = CollectionSchema(
  name: r'EventModel',
  id: 3380270723020586526,
  properties: {
    r'breakMinutes': PropertySchema(
      id: 0,
      name: r'breakMinutes',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'endTime': PropertySchema(
      id: 3,
      name: r'endTime',
      type: IsarType.string,
    ),
    r'jobName': PropertySchema(
      id: 4,
      name: r'jobName',
      type: IsarType.string,
    ),
    r'jobTransportation': PropertySchema(
      id: 5,
      name: r'jobTransportation',
      type: IsarType.double,
    ),
    r'rate': PropertySchema(
      id: 6,
      name: r'rate',
      type: IsarType.double,
    ),
    r'startTime': PropertySchema(
      id: 7,
      name: r'startTime',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _eventModelEstimateSize,
  serialize: _eventModelSerialize,
  deserialize: _eventModelDeserialize,
  deserializeProp: _eventModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'job': LinkSchema(
      id: 7481964532647730049,
      name: r'job',
      target: r'Job',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _eventModelGetId,
  getLinks: _eventModelGetLinks,
  attach: _eventModelAttach,
  version: '3.1.0+1',
);

int _eventModelEstimateSize(
  EventModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.endTime.length * 3;
  {
    final value = object.jobName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.startTime.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _eventModelSerialize(
  EventModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breakMinutes);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.endTime);
  writer.writeString(offsets[4], object.jobName);
  writer.writeDouble(offsets[5], object.jobTransportation);
  writer.writeDouble(offsets[6], object.rate);
  writer.writeString(offsets[7], object.startTime);
  writer.writeString(offsets[8], object.type);
}

EventModel _eventModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventModel(
    breakMinutes: reader.readLong(offsets[0]),
    date: reader.readDateTime(offsets[1]),
    description: reader.readString(offsets[2]),
    endTime: reader.readString(offsets[3]),
    jobName: reader.readStringOrNull(offsets[4]),
    jobTransportation: reader.readDoubleOrNull(offsets[5]),
    rate: reader.readDoubleOrNull(offsets[6]),
    startTime: reader.readString(offsets[7]),
    type: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _eventModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventModelGetId(EventModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _eventModelGetLinks(EventModel object) {
  return [object.job];
}

void _eventModelAttach(IsarCollection<dynamic> col, Id id, EventModel object) {
  object.id = id;
  object.job.attach(col, col.isar.collection<Job>(), r'job', id);
}

extension EventModelQueryWhereSort
    on QueryBuilder<EventModel, EventModel, QWhere> {
  QueryBuilder<EventModel, EventModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventModelQueryWhere
    on QueryBuilder<EventModel, EventModel, QWhereClause> {
  QueryBuilder<EventModel, EventModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<EventModel, EventModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterWhereClause> idBetween(
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

extension EventModelQueryFilter
    on QueryBuilder<EventModel, EventModel, QFilterCondition> {
  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      breakMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      breakMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      breakMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      breakMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      endTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> endTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      endTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jobName',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jobName',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jobName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jobName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jobName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jobTransportation',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jobTransportation',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobTransportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobTransportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobTransportation',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      jobTransportationBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobTransportation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rate',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rate',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> rateBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      startTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      startTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> startTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'startTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      startTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition>
      startTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'startTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension EventModelQueryObject
    on QueryBuilder<EventModel, EventModel, QFilterCondition> {}

extension EventModelQueryLinks
    on QueryBuilder<EventModel, EventModel, QFilterCondition> {
  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> job(
      FilterQuery<Job> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'job');
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterFilterCondition> jobIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'job', 0, true, 0, true);
    });
  }
}

extension EventModelQuerySortBy
    on QueryBuilder<EventModel, EventModel, QSortBy> {
  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByJobName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobName', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByJobNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobName', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByJobTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTransportation', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy>
      sortByJobTransportationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTransportation', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension EventModelQuerySortThenBy
    on QueryBuilder<EventModel, EventModel, QSortThenBy> {
  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByJobName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobName', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByJobNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobName', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByJobTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTransportation', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy>
      thenByJobTransportationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTransportation', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rate', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<EventModel, EventModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension EventModelQueryWhereDistinct
    on QueryBuilder<EventModel, EventModel, QDistinct> {
  QueryBuilder<EventModel, EventModel, QDistinct> distinctByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakMinutes');
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByEndTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByJobName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct>
      distinctByJobTransportation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobTransportation');
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rate');
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByStartTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventModel, EventModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension EventModelQueryProperty
    on QueryBuilder<EventModel, EventModel, QQueryProperty> {
  QueryBuilder<EventModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventModel, int, QQueryOperations> breakMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakMinutes');
    });
  }

  QueryBuilder<EventModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<EventModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<EventModel, String, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<EventModel, String?, QQueryOperations> jobNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobName');
    });
  }

  QueryBuilder<EventModel, double?, QQueryOperations>
      jobTransportationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobTransportation');
    });
  }

  QueryBuilder<EventModel, double?, QQueryOperations> rateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rate');
    });
  }

  QueryBuilder<EventModel, String, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<EventModel, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
