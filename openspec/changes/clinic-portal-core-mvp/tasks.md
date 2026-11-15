# Tasks

## 1. Core Foundation & Shared Infrastructure

- [x] 1.1 Update `pubspec.yaml` with `flutter_bloc`, `get_it`, `injectable`, `dio`, `connectivity_plus`, `drift`, `sqlite3_flutter_libs`, `flutter_screenutil`, `qr_flutter`, `intl`, `fpdart`, `equatable`, and test dependencies; verify resolution via `flutter pub get`.
- [x] 1.2 Implement `core/error` hierarchy (`Failure`, `ServerFailure`, `CacheFailure`, and `ClinicalSafetyException`) and verify with unit tests in `test/core/error/error_test.dart`.
- [x] 1.3 Implement `core/network` (`NetworkInfo` wrapping `connectivity_plus`, Dio client with JWT injection, logging, and error mapping interceptors) and verify with unit tests in `test/core/network/network_info_test.dart`.
- [x] 1.4 Implement `core/database` (Drift `AppDatabase` schema including `PatientSummariesTable`, `ConsultationDraftsTable`, and `QueueItemsTable`, with reactive DAOs) and verify code generation via `dart run build_runner build --delete-conflicting-outputs`.
- [x] 1.5 Implement `core/responsive` (`ResponsiveLayoutBuilder` supporting Tablet `768px-1199px` and Desktop `>=1200px` with `ScreenUtil` 1440x900 base size) and verify breakpoint rendering tests in `test/core/responsive/responsive_layout_builder_test.dart`.
- [x] 1.6 Configure bilingual localization in `core/localization` (ARB files for Arabic `ar` and English `en`, and text direction isolate helper for medical formulations) and verify RTL/LTR formatting tests in `test/core/localization/localization_test.dart`.
- [x] 1.7 Setup Dependency Injection in `core/di` using `get_it` and `injectable`, verifying dependency resolution across all core singletons.

## 2. Authentication & Role-Based Access Control (`auth`)

- [x] 2.1 Implement `auth` domain layer (`UserEntity`, `UserRole` enum: `doctorAssistant` and `treatingDoctor`, `AuthRepository` abstract interface, and `LoginUseCase`) and verify with unit tests in `test/features/auth/domain/login_usecase_test.dart`.
- [x] 2.2 Implement `auth` data layer (`UserModel`, remote/mock `AuthDataSource`, and `AuthRepositoryImpl`) and verify with unit tests in `test/features/auth/data/auth_repository_impl_test.dart`.
- [x] 2.3 Implement `auth` presentation layer (`AuthCubit`, `AuthState`, `LoginPage` with credentials and role selection) and verify state transitions via `test/features/auth/presentation/auth_cubit_test.dart`.
- [x] 2.4 Implement `core/router/app_router.dart` role-based route guards preventing assistant roles from accessing doctor consultation paths, verified by router unit tests.

## 3. Doctor Assistant Patient Intake & Queue Forwarding (`assistant_intake`)

- [x] 3.1 Implement `assistant_intake` domain layer (`PatientSummaryEntity`, `IntakeVitalsEntity`, `SearchPatientUseCase`, `RegisterPatientUseCase`, `ForwardToQueueUseCase` strictly omitting PHI) and verify with unit tests in `test/features/assistant_intake/domain/intake_usecases_test.dart`.
- [x] 3.2 Implement `assistant_intake` data layer (`PatientSummaryModel`, `IntakeVitalsModel`, Drift-backed `IntakeLocalDataSource`, and `IntakeRepositoryImpl`) and verify with unit tests in `test/features/assistant_intake/data/intake_repository_impl_test.dart`.
- [x] 3.3 Implement `assistant_intake` presentation layer (`IntakeCubit`, `PatientLookupWidget` by Phone/National ID, `PatientRegistrationDialog`, and `VitalsEntryForm` with automated BMI calculation) and verify via `test/features/assistant_intake/presentation/intake_cubit_test.dart`.

## 4. Doctor Live Queue & Longitudinal EHR (`doctor_queue_ehr`)

- [x] 4.1 Implement `doctor_queue_ehr` domain layer (`QueuePatientEntity`, `MedicalRecordEntity`, `EhrTimelineEntity`, `AllergyAlertEntity`, `WatchLiveQueueUseCase`, and `GetLongitudinalEhrUseCase`) and verify with unit tests in `test/features/doctor_queue_ehr/domain/queue_ehr_usecases_test.dart`.
- [x] 4.2 Implement `doctor_queue_ehr` data layer (Queue and EHR models, Drift reactive stream DAO query `watchWaitingQueue()`, and `DoctorQueueRepositoryImpl`) and verify with unit tests in `test/features/doctor_queue_ehr/data/doctor_queue_repository_impl_test.dart`.
- [x] 4.3 Implement `doctor_queue_ehr` presentation layer (`DoctorQueueCubit`, `LiveQueueListView`, `LongitudinalEhrTimelineWidget`, and `HighContrastAlertBanner` for severe allergies/chronic conditions) and verify via `test/features/doctor_queue_ehr/presentation/doctor_queue_cubit_test.dart`.

## 5. Clinical Consultation & Mandatory HITL AI Safety Gate (`clinical_consultation`)

- [x] 5.1 Implement `clinical_consultation` domain layer (`AiDraftNoteEntity`, `PrescriptionEntity`, `DraftReviewStatus` enum, and `CommitConsultationUseCase` enforcing `doctorApproved == true` and throwing `ClinicalSafetyException` if false) and verify safety invariant unit tests in `test/features/clinical_consultation/domain/commit_consultation_usecase_test.dart`.
- [x] 5.2 Implement `clinical_consultation` data layer (`ConsultationDraftModel`, `SimulatedAiScribeDataSource` with realistic SOAP generation, Drift draft DAO for `NFR-REL-02` offline resiliency, and `ConsultationRepositoryImpl`) and verify with unit tests in `test/features/clinical_consultation/data/consultation_repository_impl_test.dart`.
- [x] 5.3 Implement `clinical_consultation` presentation layer (`ConsultationCubit`, `SoapNoteEditorWidget`, `SimulatedScribeAudioWidget`, `UnverifiedAiDraftBanner`, `ApproveAndCommitButton`, and `QrPrescriptionDialog`) and verify via `test/features/clinical_consultation/presentation/consultation_cubit_test.dart`.

## 6. Master-Detail Integration & End-to-End Verification

- [x] 6.1 Implement `DoctorMasterDetailScreen` uniting Panel A (Queue/Patient EHR, 35% width) and Panel B (Active Consultation/Draft Review, 65% width) achieving `< 3 clicks` workflow, and verify layout rendering in `test/features/doctor_queue_ehr/presentation/doctor_master_detail_screen_test.dart`.
- [x] 6.2 Execute full test suite (`flutter test`) verifying zero failures across all Clean Architecture layers, role permissions, and clinical safety invariants.
