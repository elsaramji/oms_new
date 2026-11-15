import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';
import 'package:oms_new/features/clinical_consultation/domain/usecases/commit_consultation_usecase.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_cubit.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_state.dart';

class MockConsultationRepository extends Mock implements ConsultationRepository {}
class MockCommitConsultationUseCase extends Mock implements CommitConsultationUseCase {}

void main() {
  late MockConsultationRepository mockRepository;
  late MockCommitConsultationUseCase mockCommitUseCase;
  late ConsultationCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      AiDraftNoteEntity(
        id: '',
        patientId: '',
        updatedAt: DateTime.now(),
      ),
    );
    registerFallbackValue(
      CommitConsultationParams(
        draftNote: AiDraftNoteEntity(
          id: '',
          patientId: '',
          updatedAt: DateTime.now(),
        ),
        doctorApproved: false,
        patientName: '',
        doctorName: '',
      ),
    );
  });

  setUp(() {
    mockRepository = MockConsultationRepository();
    mockCommitUseCase = MockCommitConsultationUseCase();

    cubit = ConsultationCubit(
      repository: mockRepository,
      commitConsultationUseCase: mockCommitUseCase,
    );
  });

  tearDown(() => cubit.close());

  final tDraft = AiDraftNoteEntity(
    id: 'draft-1',
    patientId: 'pat-1',
    subjective: 'Headache',
    objective: 'Normal vitals',
    assessment: 'Tension headache',
    plan: 'Rest and hydration',
    prescriptions: const [],
    reviewStatus: DraftReviewStatus.draft,
    doctorApproved: false,
    updatedAt: DateTime(2026, 11, 15),
  );

  final tAiGeneratedDraft = tDraft.copyWith(
    subjective: 'AI transcribed headache',
    isAiGenerated: true,
  );

  test('initial state is ConsultationInitial', () {
    expect(cubit.state, equals(const ConsultationInitial()));
  });

  blocTest<ConsultationCubit, ConsultationState>(
    'generateAiScribe updates draft with AI generated content and preserves draft status',
    seed: () => ConsultationDraftLoaded(draft: tDraft),
    build: () {
      when(() => mockRepository.generateSimulatedAiScribe('pat-1'))
          .thenAnswer((_) async => Right(tAiGeneratedDraft));
      return cubit;
    },
    act: (cubit) => cubit.generateAiScribe('pat-1'),
    expect: () => [
      ConsultationDraftLoaded(draft: tDraft, isGeneratingScribe: true),
      ConsultationDraftLoaded(draft: tAiGeneratedDraft, isGeneratingScribe: false),
    ],
  );

  blocTest<ConsultationCubit, ConsultationState>(
    'setDoctorApproval updates doctorApproved and reviewStatus',
    seed: () => ConsultationDraftLoaded(draft: tDraft),
    build: () {
      when(() => mockRepository.saveDraft(any()))
          .thenAnswer((_) async => const Right(unit));
      return cubit;
    },
    act: (cubit) => cubit.setDoctorApproval(true),
    expect: () => [
      isA<ConsultationDraftLoaded>().having(
        (s) => s.draft.doctorApproved,
        'doctorApproved',
        isTrue,
      ),
    ],
    verify: (cubit) {
      final current = cubit.state as ConsultationDraftLoaded;
      expect(current.draft.doctorApproved, isTrue);
      expect(current.draft.reviewStatus, equals(DraftReviewStatus.approved));
    },
  );

  blocTest<ConsultationCubit, ConsultationState>(
    'commitConsultation catches ClinicalSafetyException if unapproved',
    seed: () => ConsultationDraftLoaded(draft: tDraft), // unapproved draft
    build: () {
      when(() => mockCommitUseCase(any())).thenThrow(
        const ClinicalSafetyException(
          'Doctor review required',
          violationCode: 'UNAPPROVED_AI_DRAFT_COMMIT',
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.commitConsultation(
      patientName: 'Ali Hassan',
      doctorName: 'Dr. Mohamed Mostafa',
    ),
    expect: () => [
      ConsultationDraftLoaded(draft: tDraft, isCommitting: true),
      ConsultationDraftLoaded(
        draft: tDraft,
        isCommitting: false,
        errorMessage: 'Doctor review required',
      ),
    ],
  );
}
