import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/daos/consultation_draft_dao.dart';
import 'package:oms_new/core/database/daos/patient_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/core/di/injection.dart';
import 'package:oms_new/core/network/network_info.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('Dependency Injection configures and resolves all core singletons', () async {
    await configureDependencies();

    expect(getIt.isRegistered<Connectivity>(), isTrue);
    expect(getIt.isRegistered<NetworkInfo>(), isTrue);
    expect(getIt.isRegistered<AppDatabase>(), isTrue);
    expect(getIt.isRegistered<PatientDao>(), isTrue);
    expect(getIt.isRegistered<QueueDao>(), isTrue);
    expect(getIt.isRegistered<ConsultationDraftDao>(), isTrue);
    expect(getIt.isRegistered<Dio>(), isTrue);

    final connectivity = getIt<Connectivity>();
    final networkInfo = getIt<NetworkInfo>();
    final appDatabase = getIt<AppDatabase>();
    final patientDao = getIt<PatientDao>();
    final queueDao = getIt<QueueDao>();
    final draftDao = getIt<ConsultationDraftDao>();
    final dio = getIt<Dio>();

    expect(connectivity, isNotNull);
    expect(networkInfo, isNotNull);
    expect(appDatabase, isNotNull);
    expect(patientDao, isNotNull);
    expect(queueDao, isNotNull);
    expect(draftDao, isNotNull);
    expect(dio, isNotNull);
  });
}
