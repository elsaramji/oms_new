// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PatientSummariesTableTable extends PatientSummariesTable
    with TableInfo<$PatientSummariesTableTable, PatientSummaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientSummariesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodTypeMeta = const VerificationMeta(
    'bloodType',
  );
  @override
  late final GeneratedColumn<String> bloodType = GeneratedColumn<String>(
    'blood_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nationalId,
    fullName,
    phoneNumber,
    age,
    gender,
    bloodType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_summaries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatientSummaryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nationalIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('blood_type')) {
      context.handle(
        _bloodTypeMeta,
        bloodType.isAcceptableOrUnknown(data['blood_type']!, _bloodTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_bloodTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientSummaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientSummaryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      bloodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PatientSummariesTableTable createAlias(String alias) {
    return $PatientSummariesTableTable(attachedDatabase, alias);
  }
}

class PatientSummaryRow extends DataClass
    implements Insertable<PatientSummaryRow> {
  final String id;
  final String nationalId;
  final String fullName;
  final String phoneNumber;
  final int age;
  final String gender;
  final String bloodType;
  final DateTime createdAt;
  const PatientSummaryRow({
    required this.id,
    required this.nationalId,
    required this.fullName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['national_id'] = Variable<String>(nationalId);
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['age'] = Variable<int>(age);
    map['gender'] = Variable<String>(gender);
    map['blood_type'] = Variable<String>(bloodType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PatientSummariesTableCompanion toCompanion(bool nullToAbsent) {
    return PatientSummariesTableCompanion(
      id: Value(id),
      nationalId: Value(nationalId),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      age: Value(age),
      gender: Value(gender),
      bloodType: Value(bloodType),
      createdAt: Value(createdAt),
    );
  }

  factory PatientSummaryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientSummaryRow(
      id: serializer.fromJson<String>(json['id']),
      nationalId: serializer.fromJson<String>(json['nationalId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      age: serializer.fromJson<int>(json['age']),
      gender: serializer.fromJson<String>(json['gender']),
      bloodType: serializer.fromJson<String>(json['bloodType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nationalId': serializer.toJson<String>(nationalId),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'age': serializer.toJson<int>(age),
      'gender': serializer.toJson<String>(gender),
      'bloodType': serializer.toJson<String>(bloodType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PatientSummaryRow copyWith({
    String? id,
    String? nationalId,
    String? fullName,
    String? phoneNumber,
    int? age,
    String? gender,
    String? bloodType,
    DateTime? createdAt,
  }) => PatientSummaryRow(
    id: id ?? this.id,
    nationalId: nationalId ?? this.nationalId,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    age: age ?? this.age,
    gender: gender ?? this.gender,
    bloodType: bloodType ?? this.bloodType,
    createdAt: createdAt ?? this.createdAt,
  );
  PatientSummaryRow copyWithCompanion(PatientSummariesTableCompanion data) {
    return PatientSummaryRow(
      id: data.id.present ? data.id.value : this.id,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      bloodType: data.bloodType.present ? data.bloodType.value : this.bloodType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientSummaryRow(')
          ..write('id: $id, ')
          ..write('nationalId: $nationalId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('bloodType: $bloodType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nationalId,
    fullName,
    phoneNumber,
    age,
    gender,
    bloodType,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientSummaryRow &&
          other.id == this.id &&
          other.nationalId == this.nationalId &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.bloodType == this.bloodType &&
          other.createdAt == this.createdAt);
}

class PatientSummariesTableCompanion
    extends UpdateCompanion<PatientSummaryRow> {
  final Value<String> id;
  final Value<String> nationalId;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<int> age;
  final Value<String> gender;
  final Value<String> bloodType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PatientSummariesTableCompanion({
    this.id = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.bloodType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientSummariesTableCompanion.insert({
    required String id,
    required String nationalId,
    required String fullName,
    required String phoneNumber,
    required int age,
    required String gender,
    required String bloodType,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nationalId = Value(nationalId),
       fullName = Value(fullName),
       phoneNumber = Value(phoneNumber),
       age = Value(age),
       gender = Value(gender),
       bloodType = Value(bloodType);
  static Insertable<PatientSummaryRow> custom({
    Expression<String>? id,
    Expression<String>? nationalId,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<int>? age,
    Expression<String>? gender,
    Expression<String>? bloodType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nationalId != null) 'national_id': nationalId,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (bloodType != null) 'blood_type': bloodType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientSummariesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? nationalId,
    Value<String>? fullName,
    Value<String>? phoneNumber,
    Value<int>? age,
    Value<String>? gender,
    Value<String>? bloodType,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PatientSummariesTableCompanion(
      id: id ?? this.id,
      nationalId: nationalId ?? this.nationalId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (bloodType.present) {
      map['blood_type'] = Variable<String>(bloodType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientSummariesTableCompanion(')
          ..write('id: $id, ')
          ..write('nationalId: $nationalId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('bloodType: $bloodType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueueItemsTableTable extends QueueItemsTable
    with TableInfo<$QueueItemsTableTable, QueueItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueueItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queueNumberMeta = const VerificationMeta(
    'queueNumber',
  );
  @override
  late final GeneratedColumn<int> queueNumber = GeneratedColumn<int>(
    'queue_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('waiting'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('normal'),
  );
  static const VerificationMeta _forwardedAtMeta = const VerificationMeta(
    'forwardedAt',
  );
  @override
  late final GeneratedColumn<DateTime> forwardedAt = GeneratedColumn<DateTime>(
    'forwarded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _systolicBpMeta = const VerificationMeta(
    'systolicBp',
  );
  @override
  late final GeneratedColumn<int> systolicBp = GeneratedColumn<int>(
    'systolic_bp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diastolicBpMeta = const VerificationMeta(
    'diastolicBp',
  );
  @override
  late final GeneratedColumn<int> diastolicBp = GeneratedColumn<int>(
    'diastolic_bp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pulseRateMeta = const VerificationMeta(
    'pulseRate',
  );
  @override
  late final GeneratedColumn<int> pulseRate = GeneratedColumn<int>(
    'pulse_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _oxygenSaturationMeta = const VerificationMeta(
    'oxygenSaturation',
  );
  @override
  late final GeneratedColumn<double> oxygenSaturation = GeneratedColumn<double>(
    'oxygen_saturation',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bmiMeta = const VerificationMeta('bmi');
  @override
  late final GeneratedColumn<double> bmi = GeneratedColumn<double>(
    'bmi',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    patientName,
    queueNumber,
    status,
    priority,
    forwardedAt,
    systolicBp,
    diastolicBp,
    pulseRate,
    temperature,
    oxygenSaturation,
    weight,
    height,
    bmi,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queue_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QueueItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('queue_number')) {
      context.handle(
        _queueNumberMeta,
        queueNumber.isAcceptableOrUnknown(
          data['queue_number']!,
          _queueNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_queueNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('forwarded_at')) {
      context.handle(
        _forwardedAtMeta,
        forwardedAt.isAcceptableOrUnknown(
          data['forwarded_at']!,
          _forwardedAtMeta,
        ),
      );
    }
    if (data.containsKey('systolic_bp')) {
      context.handle(
        _systolicBpMeta,
        systolicBp.isAcceptableOrUnknown(data['systolic_bp']!, _systolicBpMeta),
      );
    }
    if (data.containsKey('diastolic_bp')) {
      context.handle(
        _diastolicBpMeta,
        diastolicBp.isAcceptableOrUnknown(
          data['diastolic_bp']!,
          _diastolicBpMeta,
        ),
      );
    }
    if (data.containsKey('pulse_rate')) {
      context.handle(
        _pulseRateMeta,
        pulseRate.isAcceptableOrUnknown(data['pulse_rate']!, _pulseRateMeta),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('oxygen_saturation')) {
      context.handle(
        _oxygenSaturationMeta,
        oxygenSaturation.isAcceptableOrUnknown(
          data['oxygen_saturation']!,
          _oxygenSaturationMeta,
        ),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('bmi')) {
      context.handle(
        _bmiMeta,
        bmi.isAcceptableOrUnknown(data['bmi']!, _bmiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QueueItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueueItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      patientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_name'],
      )!,
      queueNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}queue_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      forwardedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}forwarded_at'],
      )!,
      systolicBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}systolic_bp'],
      ),
      diastolicBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}diastolic_bp'],
      ),
      pulseRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulse_rate'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      oxygenSaturation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}oxygen_saturation'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      bmi: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bmi'],
      ),
    );
  }

  @override
  $QueueItemsTableTable createAlias(String alias) {
    return $QueueItemsTableTable(attachedDatabase, alias);
  }
}

class QueueItemRow extends DataClass implements Insertable<QueueItemRow> {
  final String id;
  final String patientId;
  final String patientName;
  final int queueNumber;
  final String status;
  final String priority;
  final DateTime forwardedAt;
  final int? systolicBp;
  final int? diastolicBp;
  final int? pulseRate;
  final double? temperature;
  final double? oxygenSaturation;
  final double? weight;
  final double? height;
  final double? bmi;
  const QueueItemRow({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.queueNumber,
    required this.status,
    required this.priority,
    required this.forwardedAt,
    this.systolicBp,
    this.diastolicBp,
    this.pulseRate,
    this.temperature,
    this.oxygenSaturation,
    this.weight,
    this.height,
    this.bmi,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['patient_name'] = Variable<String>(patientName);
    map['queue_number'] = Variable<int>(queueNumber);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    map['forwarded_at'] = Variable<DateTime>(forwardedAt);
    if (!nullToAbsent || systolicBp != null) {
      map['systolic_bp'] = Variable<int>(systolicBp);
    }
    if (!nullToAbsent || diastolicBp != null) {
      map['diastolic_bp'] = Variable<int>(diastolicBp);
    }
    if (!nullToAbsent || pulseRate != null) {
      map['pulse_rate'] = Variable<int>(pulseRate);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || oxygenSaturation != null) {
      map['oxygen_saturation'] = Variable<double>(oxygenSaturation);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || bmi != null) {
      map['bmi'] = Variable<double>(bmi);
    }
    return map;
  }

  QueueItemsTableCompanion toCompanion(bool nullToAbsent) {
    return QueueItemsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      patientName: Value(patientName),
      queueNumber: Value(queueNumber),
      status: Value(status),
      priority: Value(priority),
      forwardedAt: Value(forwardedAt),
      systolicBp: systolicBp == null && nullToAbsent
          ? const Value.absent()
          : Value(systolicBp),
      diastolicBp: diastolicBp == null && nullToAbsent
          ? const Value.absent()
          : Value(diastolicBp),
      pulseRate: pulseRate == null && nullToAbsent
          ? const Value.absent()
          : Value(pulseRate),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      oxygenSaturation: oxygenSaturation == null && nullToAbsent
          ? const Value.absent()
          : Value(oxygenSaturation),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      bmi: bmi == null && nullToAbsent ? const Value.absent() : Value(bmi),
    );
  }

  factory QueueItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueueItemRow(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      patientName: serializer.fromJson<String>(json['patientName']),
      queueNumber: serializer.fromJson<int>(json['queueNumber']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      forwardedAt: serializer.fromJson<DateTime>(json['forwardedAt']),
      systolicBp: serializer.fromJson<int?>(json['systolicBp']),
      diastolicBp: serializer.fromJson<int?>(json['diastolicBp']),
      pulseRate: serializer.fromJson<int?>(json['pulseRate']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      oxygenSaturation: serializer.fromJson<double?>(json['oxygenSaturation']),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
      bmi: serializer.fromJson<double?>(json['bmi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'patientName': serializer.toJson<String>(patientName),
      'queueNumber': serializer.toJson<int>(queueNumber),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'forwardedAt': serializer.toJson<DateTime>(forwardedAt),
      'systolicBp': serializer.toJson<int?>(systolicBp),
      'diastolicBp': serializer.toJson<int?>(diastolicBp),
      'pulseRate': serializer.toJson<int?>(pulseRate),
      'temperature': serializer.toJson<double?>(temperature),
      'oxygenSaturation': serializer.toJson<double?>(oxygenSaturation),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
      'bmi': serializer.toJson<double?>(bmi),
    };
  }

  QueueItemRow copyWith({
    String? id,
    String? patientId,
    String? patientName,
    int? queueNumber,
    String? status,
    String? priority,
    DateTime? forwardedAt,
    Value<int?> systolicBp = const Value.absent(),
    Value<int?> diastolicBp = const Value.absent(),
    Value<int?> pulseRate = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    Value<double?> oxygenSaturation = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> bmi = const Value.absent(),
  }) => QueueItemRow(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    patientName: patientName ?? this.patientName,
    queueNumber: queueNumber ?? this.queueNumber,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    forwardedAt: forwardedAt ?? this.forwardedAt,
    systolicBp: systolicBp.present ? systolicBp.value : this.systolicBp,
    diastolicBp: diastolicBp.present ? diastolicBp.value : this.diastolicBp,
    pulseRate: pulseRate.present ? pulseRate.value : this.pulseRate,
    temperature: temperature.present ? temperature.value : this.temperature,
    oxygenSaturation: oxygenSaturation.present
        ? oxygenSaturation.value
        : this.oxygenSaturation,
    weight: weight.present ? weight.value : this.weight,
    height: height.present ? height.value : this.height,
    bmi: bmi.present ? bmi.value : this.bmi,
  );
  QueueItemRow copyWithCompanion(QueueItemsTableCompanion data) {
    return QueueItemRow(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientName: data.patientName.present
          ? data.patientName.value
          : this.patientName,
      queueNumber: data.queueNumber.present
          ? data.queueNumber.value
          : this.queueNumber,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      forwardedAt: data.forwardedAt.present
          ? data.forwardedAt.value
          : this.forwardedAt,
      systolicBp: data.systolicBp.present
          ? data.systolicBp.value
          : this.systolicBp,
      diastolicBp: data.diastolicBp.present
          ? data.diastolicBp.value
          : this.diastolicBp,
      pulseRate: data.pulseRate.present ? data.pulseRate.value : this.pulseRate,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      oxygenSaturation: data.oxygenSaturation.present
          ? data.oxygenSaturation.value
          : this.oxygenSaturation,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      bmi: data.bmi.present ? data.bmi.value : this.bmi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QueueItemRow(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('queueNumber: $queueNumber, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('forwardedAt: $forwardedAt, ')
          ..write('systolicBp: $systolicBp, ')
          ..write('diastolicBp: $diastolicBp, ')
          ..write('pulseRate: $pulseRate, ')
          ..write('temperature: $temperature, ')
          ..write('oxygenSaturation: $oxygenSaturation, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('bmi: $bmi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    patientName,
    queueNumber,
    status,
    priority,
    forwardedAt,
    systolicBp,
    diastolicBp,
    pulseRate,
    temperature,
    oxygenSaturation,
    weight,
    height,
    bmi,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueueItemRow &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.patientName == this.patientName &&
          other.queueNumber == this.queueNumber &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.forwardedAt == this.forwardedAt &&
          other.systolicBp == this.systolicBp &&
          other.diastolicBp == this.diastolicBp &&
          other.pulseRate == this.pulseRate &&
          other.temperature == this.temperature &&
          other.oxygenSaturation == this.oxygenSaturation &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.bmi == this.bmi);
}

class QueueItemsTableCompanion extends UpdateCompanion<QueueItemRow> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> patientName;
  final Value<int> queueNumber;
  final Value<String> status;
  final Value<String> priority;
  final Value<DateTime> forwardedAt;
  final Value<int?> systolicBp;
  final Value<int?> diastolicBp;
  final Value<int?> pulseRate;
  final Value<double?> temperature;
  final Value<double?> oxygenSaturation;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<double?> bmi;
  final Value<int> rowid;
  const QueueItemsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientName = const Value.absent(),
    this.queueNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.forwardedAt = const Value.absent(),
    this.systolicBp = const Value.absent(),
    this.diastolicBp = const Value.absent(),
    this.pulseRate = const Value.absent(),
    this.temperature = const Value.absent(),
    this.oxygenSaturation = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.bmi = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QueueItemsTableCompanion.insert({
    required String id,
    required String patientId,
    required String patientName,
    required int queueNumber,
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.forwardedAt = const Value.absent(),
    this.systolicBp = const Value.absent(),
    this.diastolicBp = const Value.absent(),
    this.pulseRate = const Value.absent(),
    this.temperature = const Value.absent(),
    this.oxygenSaturation = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.bmi = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       patientName = Value(patientName),
       queueNumber = Value(queueNumber);
  static Insertable<QueueItemRow> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? patientName,
    Expression<int>? queueNumber,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<DateTime>? forwardedAt,
    Expression<int>? systolicBp,
    Expression<int>? diastolicBp,
    Expression<int>? pulseRate,
    Expression<double>? temperature,
    Expression<double>? oxygenSaturation,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<double>? bmi,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (patientName != null) 'patient_name': patientName,
      if (queueNumber != null) 'queue_number': queueNumber,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (forwardedAt != null) 'forwarded_at': forwardedAt,
      if (systolicBp != null) 'systolic_bp': systolicBp,
      if (diastolicBp != null) 'diastolic_bp': diastolicBp,
      if (pulseRate != null) 'pulse_rate': pulseRate,
      if (temperature != null) 'temperature': temperature,
      if (oxygenSaturation != null) 'oxygen_saturation': oxygenSaturation,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (bmi != null) 'bmi': bmi,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QueueItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? patientName,
    Value<int>? queueNumber,
    Value<String>? status,
    Value<String>? priority,
    Value<DateTime>? forwardedAt,
    Value<int?>? systolicBp,
    Value<int?>? diastolicBp,
    Value<int?>? pulseRate,
    Value<double?>? temperature,
    Value<double?>? oxygenSaturation,
    Value<double?>? weight,
    Value<double?>? height,
    Value<double?>? bmi,
    Value<int>? rowid,
  }) {
    return QueueItemsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      queueNumber: queueNumber ?? this.queueNumber,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      forwardedAt: forwardedAt ?? this.forwardedAt,
      systolicBp: systolicBp ?? this.systolicBp,
      diastolicBp: diastolicBp ?? this.diastolicBp,
      pulseRate: pulseRate ?? this.pulseRate,
      temperature: temperature ?? this.temperature,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (queueNumber.present) {
      map['queue_number'] = Variable<int>(queueNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (forwardedAt.present) {
      map['forwarded_at'] = Variable<DateTime>(forwardedAt.value);
    }
    if (systolicBp.present) {
      map['systolic_bp'] = Variable<int>(systolicBp.value);
    }
    if (diastolicBp.present) {
      map['diastolic_bp'] = Variable<int>(diastolicBp.value);
    }
    if (pulseRate.present) {
      map['pulse_rate'] = Variable<int>(pulseRate.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (oxygenSaturation.present) {
      map['oxygen_saturation'] = Variable<double>(oxygenSaturation.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (bmi.present) {
      map['bmi'] = Variable<double>(bmi.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('queueNumber: $queueNumber, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('forwardedAt: $forwardedAt, ')
          ..write('systolicBp: $systolicBp, ')
          ..write('diastolicBp: $diastolicBp, ')
          ..write('pulseRate: $pulseRate, ')
          ..write('temperature: $temperature, ')
          ..write('oxygenSaturation: $oxygenSaturation, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('bmi: $bmi, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsultationDraftsTableTable extends ConsultationDraftsTable
    with TableInfo<$ConsultationDraftsTableTable, ConsultationDraftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsultationDraftsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorApprovedMeta = const VerificationMeta(
    'doctorApproved',
  );
  @override
  late final GeneratedColumn<bool> doctorApproved = GeneratedColumn<bool>(
    'doctor_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("doctor_approved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reviewStatusMeta = const VerificationMeta(
    'reviewStatus',
  );
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
    'review_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _subjectiveMeta = const VerificationMeta(
    'subjective',
  );
  @override
  late final GeneratedColumn<String> subjective = GeneratedColumn<String>(
    'subjective',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _objectiveMeta = const VerificationMeta(
    'objective',
  );
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
    'objective',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _assessmentMeta = const VerificationMeta(
    'assessment',
  );
  @override
  late final GeneratedColumn<String> assessment = GeneratedColumn<String>(
    'assessment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
    'plan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _prescriptionsJsonMeta = const VerificationMeta(
    'prescriptionsJson',
  );
  @override
  late final GeneratedColumn<String> prescriptionsJson =
      GeneratedColumn<String>(
        'prescriptions_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    doctorApproved,
    reviewStatus,
    subjective,
    objective,
    assessment,
    plan,
    prescriptionsJson,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consultation_drafts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsultationDraftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('doctor_approved')) {
      context.handle(
        _doctorApprovedMeta,
        doctorApproved.isAcceptableOrUnknown(
          data['doctor_approved']!,
          _doctorApprovedMeta,
        ),
      );
    }
    if (data.containsKey('review_status')) {
      context.handle(
        _reviewStatusMeta,
        reviewStatus.isAcceptableOrUnknown(
          data['review_status']!,
          _reviewStatusMeta,
        ),
      );
    }
    if (data.containsKey('subjective')) {
      context.handle(
        _subjectiveMeta,
        subjective.isAcceptableOrUnknown(data['subjective']!, _subjectiveMeta),
      );
    }
    if (data.containsKey('objective')) {
      context.handle(
        _objectiveMeta,
        objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta),
      );
    }
    if (data.containsKey('assessment')) {
      context.handle(
        _assessmentMeta,
        assessment.isAcceptableOrUnknown(data['assessment']!, _assessmentMeta),
      );
    }
    if (data.containsKey('plan')) {
      context.handle(
        _planMeta,
        plan.isAcceptableOrUnknown(data['plan']!, _planMeta),
      );
    }
    if (data.containsKey('prescriptions_json')) {
      context.handle(
        _prescriptionsJsonMeta,
        prescriptionsJson.isAcceptableOrUnknown(
          data['prescriptions_json']!,
          _prescriptionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsultationDraftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsultationDraftRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      doctorApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}doctor_approved'],
      )!,
      reviewStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_status'],
      )!,
      subjective: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subjective'],
      )!,
      objective: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objective'],
      )!,
      assessment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment'],
      )!,
      plan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan'],
      )!,
      prescriptionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prescriptions_json'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConsultationDraftsTableTable createAlias(String alias) {
    return $ConsultationDraftsTableTable(attachedDatabase, alias);
  }
}

class ConsultationDraftRow extends DataClass
    implements Insertable<ConsultationDraftRow> {
  final String id;
  final String patientId;
  final bool doctorApproved;
  final String reviewStatus;
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;
  final String prescriptionsJson;
  final String syncStatus;
  final DateTime updatedAt;
  const ConsultationDraftRow({
    required this.id,
    required this.patientId,
    required this.doctorApproved,
    required this.reviewStatus,
    required this.subjective,
    required this.objective,
    required this.assessment,
    required this.plan,
    required this.prescriptionsJson,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['doctor_approved'] = Variable<bool>(doctorApproved);
    map['review_status'] = Variable<String>(reviewStatus);
    map['subjective'] = Variable<String>(subjective);
    map['objective'] = Variable<String>(objective);
    map['assessment'] = Variable<String>(assessment);
    map['plan'] = Variable<String>(plan);
    map['prescriptions_json'] = Variable<String>(prescriptionsJson);
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConsultationDraftsTableCompanion toCompanion(bool nullToAbsent) {
    return ConsultationDraftsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      doctorApproved: Value(doctorApproved),
      reviewStatus: Value(reviewStatus),
      subjective: Value(subjective),
      objective: Value(objective),
      assessment: Value(assessment),
      plan: Value(plan),
      prescriptionsJson: Value(prescriptionsJson),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory ConsultationDraftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsultationDraftRow(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      doctorApproved: serializer.fromJson<bool>(json['doctorApproved']),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      subjective: serializer.fromJson<String>(json['subjective']),
      objective: serializer.fromJson<String>(json['objective']),
      assessment: serializer.fromJson<String>(json['assessment']),
      plan: serializer.fromJson<String>(json['plan']),
      prescriptionsJson: serializer.fromJson<String>(json['prescriptionsJson']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'doctorApproved': serializer.toJson<bool>(doctorApproved),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'subjective': serializer.toJson<String>(subjective),
      'objective': serializer.toJson<String>(objective),
      'assessment': serializer.toJson<String>(assessment),
      'plan': serializer.toJson<String>(plan),
      'prescriptionsJson': serializer.toJson<String>(prescriptionsJson),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ConsultationDraftRow copyWith({
    String? id,
    String? patientId,
    bool? doctorApproved,
    String? reviewStatus,
    String? subjective,
    String? objective,
    String? assessment,
    String? plan,
    String? prescriptionsJson,
    String? syncStatus,
    DateTime? updatedAt,
  }) => ConsultationDraftRow(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    doctorApproved: doctorApproved ?? this.doctorApproved,
    reviewStatus: reviewStatus ?? this.reviewStatus,
    subjective: subjective ?? this.subjective,
    objective: objective ?? this.objective,
    assessment: assessment ?? this.assessment,
    plan: plan ?? this.plan,
    prescriptionsJson: prescriptionsJson ?? this.prescriptionsJson,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ConsultationDraftRow copyWithCompanion(
    ConsultationDraftsTableCompanion data,
  ) {
    return ConsultationDraftRow(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      doctorApproved: data.doctorApproved.present
          ? data.doctorApproved.value
          : this.doctorApproved,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      subjective: data.subjective.present
          ? data.subjective.value
          : this.subjective,
      objective: data.objective.present ? data.objective.value : this.objective,
      assessment: data.assessment.present
          ? data.assessment.value
          : this.assessment,
      plan: data.plan.present ? data.plan.value : this.plan,
      prescriptionsJson: data.prescriptionsJson.present
          ? data.prescriptionsJson.value
          : this.prescriptionsJson,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsultationDraftRow(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorApproved: $doctorApproved, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('subjective: $subjective, ')
          ..write('objective: $objective, ')
          ..write('assessment: $assessment, ')
          ..write('plan: $plan, ')
          ..write('prescriptionsJson: $prescriptionsJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    doctorApproved,
    reviewStatus,
    subjective,
    objective,
    assessment,
    plan,
    prescriptionsJson,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsultationDraftRow &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.doctorApproved == this.doctorApproved &&
          other.reviewStatus == this.reviewStatus &&
          other.subjective == this.subjective &&
          other.objective == this.objective &&
          other.assessment == this.assessment &&
          other.plan == this.plan &&
          other.prescriptionsJson == this.prescriptionsJson &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class ConsultationDraftsTableCompanion
    extends UpdateCompanion<ConsultationDraftRow> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<bool> doctorApproved;
  final Value<String> reviewStatus;
  final Value<String> subjective;
  final Value<String> objective;
  final Value<String> assessment;
  final Value<String> plan;
  final Value<String> prescriptionsJson;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ConsultationDraftsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.doctorApproved = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.subjective = const Value.absent(),
    this.objective = const Value.absent(),
    this.assessment = const Value.absent(),
    this.plan = const Value.absent(),
    this.prescriptionsJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsultationDraftsTableCompanion.insert({
    required String id,
    required String patientId,
    this.doctorApproved = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.subjective = const Value.absent(),
    this.objective = const Value.absent(),
    this.assessment = const Value.absent(),
    this.plan = const Value.absent(),
    this.prescriptionsJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId);
  static Insertable<ConsultationDraftRow> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<bool>? doctorApproved,
    Expression<String>? reviewStatus,
    Expression<String>? subjective,
    Expression<String>? objective,
    Expression<String>? assessment,
    Expression<String>? plan,
    Expression<String>? prescriptionsJson,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (doctorApproved != null) 'doctor_approved': doctorApproved,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (subjective != null) 'subjective': subjective,
      if (objective != null) 'objective': objective,
      if (assessment != null) 'assessment': assessment,
      if (plan != null) 'plan': plan,
      if (prescriptionsJson != null) 'prescriptions_json': prescriptionsJson,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsultationDraftsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<bool>? doctorApproved,
    Value<String>? reviewStatus,
    Value<String>? subjective,
    Value<String>? objective,
    Value<String>? assessment,
    Value<String>? plan,
    Value<String>? prescriptionsJson,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ConsultationDraftsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorApproved: doctorApproved ?? this.doctorApproved,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      subjective: subjective ?? this.subjective,
      objective: objective ?? this.objective,
      assessment: assessment ?? this.assessment,
      plan: plan ?? this.plan,
      prescriptionsJson: prescriptionsJson ?? this.prescriptionsJson,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (doctorApproved.present) {
      map['doctor_approved'] = Variable<bool>(doctorApproved.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (subjective.present) {
      map['subjective'] = Variable<String>(subjective.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (assessment.present) {
      map['assessment'] = Variable<String>(assessment.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (prescriptionsJson.present) {
      map['prescriptions_json'] = Variable<String>(prescriptionsJson.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsultationDraftsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorApproved: $doctorApproved, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('subjective: $subjective, ')
          ..write('objective: $objective, ')
          ..write('assessment: $assessment, ')
          ..write('plan: $plan, ')
          ..write('prescriptionsJson: $prescriptionsJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientSummariesTableTable patientSummariesTable =
      $PatientSummariesTableTable(this);
  late final $QueueItemsTableTable queueItemsTable = $QueueItemsTableTable(
    this,
  );
  late final $ConsultationDraftsTableTable consultationDraftsTable =
      $ConsultationDraftsTableTable(this);
  late final PatientDao patientDao = PatientDao(this as AppDatabase);
  late final QueueDao queueDao = QueueDao(this as AppDatabase);
  late final ConsultationDraftDao consultationDraftDao = ConsultationDraftDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    patientSummariesTable,
    queueItemsTable,
    consultationDraftsTable,
  ];
}

typedef $$PatientSummariesTableTableCreateCompanionBuilder =
    PatientSummariesTableCompanion Function({
      required String id,
      required String nationalId,
      required String fullName,
      required String phoneNumber,
      required int age,
      required String gender,
      required String bloodType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PatientSummariesTableTableUpdateCompanionBuilder =
    PatientSummariesTableCompanion Function({
      Value<String> id,
      Value<String> nationalId,
      Value<String> fullName,
      Value<String> phoneNumber,
      Value<int> age,
      Value<String> gender,
      Value<String> bloodType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PatientSummariesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PatientSummariesTableTable> {
  $$PatientSummariesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PatientSummariesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientSummariesTableTable> {
  $$PatientSummariesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientSummariesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientSummariesTableTable> {
  $$PatientSummariesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get bloodType =>
      $composableBuilder(column: $table.bloodType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PatientSummariesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientSummariesTableTable,
          PatientSummaryRow,
          $$PatientSummariesTableTableFilterComposer,
          $$PatientSummariesTableTableOrderingComposer,
          $$PatientSummariesTableTableAnnotationComposer,
          $$PatientSummariesTableTableCreateCompanionBuilder,
          $$PatientSummariesTableTableUpdateCompanionBuilder,
          (
            PatientSummaryRow,
            BaseReferences<
              _$AppDatabase,
              $PatientSummariesTableTable,
              PatientSummaryRow
            >,
          ),
          PatientSummaryRow,
          PrefetchHooks Function()
        > {
  $$PatientSummariesTableTableTableManager(
    _$AppDatabase db,
    $PatientSummariesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientSummariesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PatientSummariesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PatientSummariesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nationalId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String> bloodType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientSummariesTableCompanion(
                id: id,
                nationalId: nationalId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                age: age,
                gender: gender,
                bloodType: bloodType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nationalId,
                required String fullName,
                required String phoneNumber,
                required int age,
                required String gender,
                required String bloodType,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientSummariesTableCompanion.insert(
                id: id,
                nationalId: nationalId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                age: age,
                gender: gender,
                bloodType: bloodType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PatientSummariesTableTable, PatientSummaryRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $PatientSummariesTableTable,
                    PatientSummaryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PatientSummariesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientSummariesTableTable,
      PatientSummaryRow,
      $$PatientSummariesTableTableFilterComposer,
      $$PatientSummariesTableTableOrderingComposer,
      $$PatientSummariesTableTableAnnotationComposer,
      $$PatientSummariesTableTableCreateCompanionBuilder,
      $$PatientSummariesTableTableUpdateCompanionBuilder,
      (
        PatientSummaryRow,
        BaseReferences<
          _$AppDatabase,
          $PatientSummariesTableTable,
          PatientSummaryRow
        >,
      ),
      PatientSummaryRow,
      PrefetchHooks Function()
    >;
typedef $$QueueItemsTableTableCreateCompanionBuilder =
    QueueItemsTableCompanion Function({
      required String id,
      required String patientId,
      required String patientName,
      required int queueNumber,
      Value<String> status,
      Value<String> priority,
      Value<DateTime> forwardedAt,
      Value<int?> systolicBp,
      Value<int?> diastolicBp,
      Value<int?> pulseRate,
      Value<double?> temperature,
      Value<double?> oxygenSaturation,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> bmi,
      Value<int> rowid,
    });
typedef $$QueueItemsTableTableUpdateCompanionBuilder =
    QueueItemsTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> patientName,
      Value<int> queueNumber,
      Value<String> status,
      Value<String> priority,
      Value<DateTime> forwardedAt,
      Value<int?> systolicBp,
      Value<int?> diastolicBp,
      Value<int?> pulseRate,
      Value<double?> temperature,
      Value<double?> oxygenSaturation,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> bmi,
      Value<int> rowid,
    });

class $$QueueItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $QueueItemsTableTable> {
  $$QueueItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get queueNumber => $composableBuilder(
    column: $table.queueNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get forwardedAt => $composableBuilder(
    column: $table.forwardedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get systolicBp => $composableBuilder(
    column: $table.systolicBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diastolicBp => $composableBuilder(
    column: $table.diastolicBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulseRate => $composableBuilder(
    column: $table.pulseRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QueueItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QueueItemsTableTable> {
  $$QueueItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get queueNumber => $composableBuilder(
    column: $table.queueNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get forwardedAt => $composableBuilder(
    column: $table.forwardedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get systolicBp => $composableBuilder(
    column: $table.systolicBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diastolicBp => $composableBuilder(
    column: $table.diastolicBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulseRate => $composableBuilder(
    column: $table.pulseRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QueueItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QueueItemsTableTable> {
  $$QueueItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get queueNumber => $composableBuilder(
    column: $table.queueNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get forwardedAt => $composableBuilder(
    column: $table.forwardedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get systolicBp => $composableBuilder(
    column: $table.systolicBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get diastolicBp => $composableBuilder(
    column: $table.diastolicBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pulseRate =>
      $composableBuilder(column: $table.pulseRate, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get bmi =>
      $composableBuilder(column: $table.bmi, builder: (column) => column);
}

class $$QueueItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QueueItemsTableTable,
          QueueItemRow,
          $$QueueItemsTableTableFilterComposer,
          $$QueueItemsTableTableOrderingComposer,
          $$QueueItemsTableTableAnnotationComposer,
          $$QueueItemsTableTableCreateCompanionBuilder,
          $$QueueItemsTableTableUpdateCompanionBuilder,
          (
            QueueItemRow,
            BaseReferences<_$AppDatabase, $QueueItemsTableTable, QueueItemRow>,
          ),
          QueueItemRow,
          PrefetchHooks Function()
        > {
  $$QueueItemsTableTableTableManager(
    _$AppDatabase db,
    $QueueItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueueItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueueItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueueItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> patientName = const Value.absent(),
                Value<int> queueNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime> forwardedAt = const Value.absent(),
                Value<int?> systolicBp = const Value.absent(),
                Value<int?> diastolicBp = const Value.absent(),
                Value<int?> pulseRate = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> oxygenSaturation = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QueueItemsTableCompanion(
                id: id,
                patientId: patientId,
                patientName: patientName,
                queueNumber: queueNumber,
                status: status,
                priority: priority,
                forwardedAt: forwardedAt,
                systolicBp: systolicBp,
                diastolicBp: diastolicBp,
                pulseRate: pulseRate,
                temperature: temperature,
                oxygenSaturation: oxygenSaturation,
                weight: weight,
                height: height,
                bmi: bmi,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String patientName,
                required int queueNumber,
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime> forwardedAt = const Value.absent(),
                Value<int?> systolicBp = const Value.absent(),
                Value<int?> diastolicBp = const Value.absent(),
                Value<int?> pulseRate = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> oxygenSaturation = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QueueItemsTableCompanion.insert(
                id: id,
                patientId: patientId,
                patientName: patientName,
                queueNumber: queueNumber,
                status: status,
                priority: priority,
                forwardedAt: forwardedAt,
                systolicBp: systolicBp,
                diastolicBp: diastolicBp,
                pulseRate: pulseRate,
                temperature: temperature,
                oxygenSaturation: oxygenSaturation,
                weight: weight,
                height: height,
                bmi: bmi,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QueueItemsTableTable, QueueItemRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $QueueItemsTableTable,
                    QueueItemRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QueueItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QueueItemsTableTable,
      QueueItemRow,
      $$QueueItemsTableTableFilterComposer,
      $$QueueItemsTableTableOrderingComposer,
      $$QueueItemsTableTableAnnotationComposer,
      $$QueueItemsTableTableCreateCompanionBuilder,
      $$QueueItemsTableTableUpdateCompanionBuilder,
      (
        QueueItemRow,
        BaseReferences<_$AppDatabase, $QueueItemsTableTable, QueueItemRow>,
      ),
      QueueItemRow,
      PrefetchHooks Function()
    >;
typedef $$ConsultationDraftsTableTableCreateCompanionBuilder =
    ConsultationDraftsTableCompanion Function({
      required String id,
      required String patientId,
      Value<bool> doctorApproved,
      Value<String> reviewStatus,
      Value<String> subjective,
      Value<String> objective,
      Value<String> assessment,
      Value<String> plan,
      Value<String> prescriptionsJson,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ConsultationDraftsTableTableUpdateCompanionBuilder =
    ConsultationDraftsTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<bool> doctorApproved,
      Value<String> reviewStatus,
      Value<String> subjective,
      Value<String> objective,
      Value<String> assessment,
      Value<String> plan,
      Value<String> prescriptionsJson,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ConsultationDraftsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConsultationDraftsTableTable> {
  $$ConsultationDraftsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get doctorApproved => $composableBuilder(
    column: $table.doctorApproved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjective => $composableBuilder(
    column: $table.subjective,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessment => $composableBuilder(
    column: $table.assessment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prescriptionsJson => $composableBuilder(
    column: $table.prescriptionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConsultationDraftsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsultationDraftsTableTable> {
  $$ConsultationDraftsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get doctorApproved => $composableBuilder(
    column: $table.doctorApproved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjective => $composableBuilder(
    column: $table.subjective,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessment => $composableBuilder(
    column: $table.assessment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prescriptionsJson => $composableBuilder(
    column: $table.prescriptionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConsultationDraftsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsultationDraftsTableTable> {
  $$ConsultationDraftsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<bool> get doctorApproved => $composableBuilder(
    column: $table.doctorApproved,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subjective => $composableBuilder(
    column: $table.subjective,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<String> get assessment => $composableBuilder(
    column: $table.assessment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plan =>
      $composableBuilder(column: $table.plan, builder: (column) => column);

  GeneratedColumn<String> get prescriptionsJson => $composableBuilder(
    column: $table.prescriptionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConsultationDraftsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsultationDraftsTableTable,
          ConsultationDraftRow,
          $$ConsultationDraftsTableTableFilterComposer,
          $$ConsultationDraftsTableTableOrderingComposer,
          $$ConsultationDraftsTableTableAnnotationComposer,
          $$ConsultationDraftsTableTableCreateCompanionBuilder,
          $$ConsultationDraftsTableTableUpdateCompanionBuilder,
          (
            ConsultationDraftRow,
            BaseReferences<
              _$AppDatabase,
              $ConsultationDraftsTableTable,
              ConsultationDraftRow
            >,
          ),
          ConsultationDraftRow,
          PrefetchHooks Function()
        > {
  $$ConsultationDraftsTableTableTableManager(
    _$AppDatabase db,
    $ConsultationDraftsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsultationDraftsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ConsultationDraftsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ConsultationDraftsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<bool> doctorApproved = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
                Value<String> subjective = const Value.absent(),
                Value<String> objective = const Value.absent(),
                Value<String> assessment = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<String> prescriptionsJson = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsultationDraftsTableCompanion(
                id: id,
                patientId: patientId,
                doctorApproved: doctorApproved,
                reviewStatus: reviewStatus,
                subjective: subjective,
                objective: objective,
                assessment: assessment,
                plan: plan,
                prescriptionsJson: prescriptionsJson,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<bool> doctorApproved = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
                Value<String> subjective = const Value.absent(),
                Value<String> objective = const Value.absent(),
                Value<String> assessment = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<String> prescriptionsJson = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsultationDraftsTableCompanion.insert(
                id: id,
                patientId: patientId,
                doctorApproved: doctorApproved,
                reviewStatus: reviewStatus,
                subjective: subjective,
                objective: objective,
                assessment: assessment,
                plan: plan,
                prescriptionsJson: prescriptionsJson,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ConsultationDraftsTableTable,
                    ConsultationDraftRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ConsultationDraftsTableTable,
                    ConsultationDraftRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConsultationDraftsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsultationDraftsTableTable,
      ConsultationDraftRow,
      $$ConsultationDraftsTableTableFilterComposer,
      $$ConsultationDraftsTableTableOrderingComposer,
      $$ConsultationDraftsTableTableAnnotationComposer,
      $$ConsultationDraftsTableTableCreateCompanionBuilder,
      $$ConsultationDraftsTableTableUpdateCompanionBuilder,
      (
        ConsultationDraftRow,
        BaseReferences<
          _$AppDatabase,
          $ConsultationDraftsTableTable,
          ConsultationDraftRow
        >,
      ),
      ConsultationDraftRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientSummariesTableTableTableManager get patientSummariesTable =>
      $$PatientSummariesTableTableTableManager(_db, _db.patientSummariesTable);
  $$QueueItemsTableTableTableManager get queueItemsTable =>
      $$QueueItemsTableTableTableManager(_db, _db.queueItemsTable);
  $$ConsultationDraftsTableTableTableManager get consultationDraftsTable =>
      $$ConsultationDraftsTableTableTableManager(
        _db,
        _db.consultationDraftsTable,
      );
}
