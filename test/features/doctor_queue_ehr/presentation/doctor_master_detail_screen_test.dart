import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_state.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_cubit.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_state.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_state.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/pages/doctor_master_detail_screen.dart';

class MockDoctorQueueCubit extends Mock implements DoctorQueueCubit {}
class MockConsultationCubit extends Mock implements ConsultationCubit {}
class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late MockDoctorQueueCubit mockQueueCubit;
  late MockConsultationCubit mockConsultationCubit;
  late MockAuthCubit mockAuthCubit;

  const tDoctor = UserEntity(
    id: 'doc-1',
    name: 'Dr. Mohamed Mostafa',
    username: 'doctor',
    role: UserRole.treatingDoctor,
    token: 'jwt_mock',
  );

  final tQueuePatient = QueuePatientEntity(
    id: 'q-1',
    patientId: 'pat-1',
    patientName: 'Ali Hassan',
    queueNumber: 1,
    status: 'waiting',
    priority: 'normal',
    forwardedAt: DateTime(2026, 11, 15),
    vitals: const IntakeVitalsEntity(
      systolicBp: 120,
      diastolicBp: 80,
      pulseRate: 72,
      temperature: 37.0,
      oxygenSaturation: 98.0,
      weight: 70.0,
      height: 175.0,
    ),
  );

  final tDraft = AiDraftNoteEntity(
    id: 'draft-1',
    patientId: 'pat-1',
    subjective: 'Complains of epigastric pain',
    objective: 'Normal vitals',
    assessment: 'Gastritis',
    plan: 'Antacids',
    doctorApproved: false,
    updatedAt: DateTime(2026, 11, 15),
  );

  setUp(() {
    mockQueueCubit = MockDoctorQueueCubit();
    mockConsultationCubit = MockConsultationCubit();
    mockAuthCubit = MockAuthCubit();

    when(() => mockQueueCubit.startQueueSubscription()).thenReturn(null);
    when(() => mockQueueCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockConsultationCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthCubit.state).thenReturn(const Authenticated(tDoctor));
  });

  Widget buildTestWidget({
    required DoctorQueueState queueState,
    required ConsultationState consultationState,
  }) {
    when(() => mockQueueCubit.state).thenReturn(queueState);
    when(() => mockConsultationCubit.state).thenReturn(consultationState);

    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorQueueCubit>.value(value: mockQueueCubit),
        BlocProvider<ConsultationCubit>.value(value: mockConsultationCubit),
        BlocProvider<AuthCubit>.value(value: mockAuthCubit),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: DoctorMasterDetailScreen(currentDoctor: tDoctor),
      ),
    );
  }

  testWidgets('renders desktop split screen with queue and prompt when no patient is selected',
      (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      buildTestWidget(
        queueState: DoctorQueueLoaded(queuePatients: [tQueuePatient]),
        consultationState: const ConsultationInitial(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Live Queue (1)'), findsOneWidget);
    expect(find.text('Ali Hassan'), findsOneWidget);
    expect(find.text('No Active Patient Selected'), findsOneWidget);
  });

  testWidgets('renders consultation draft and unverified warning banner when patient is selected',
      (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      buildTestWidget(
        queueState: DoctorQueueLoaded(
          queuePatients: [tQueuePatient],
          selectedPatient: tQueuePatient,
        ),
        consultationState: ConsultationDraftLoaded(draft: tDraft),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byKey(const Key('unverified_ai_draft_banner')), findsOneWidget);
    expect(find.byKey(const Key('soap_subjective_field')), findsOneWidget);
    expect(find.byKey(const Key('approve_and_commit_button')), findsOneWidget);
  });
}
