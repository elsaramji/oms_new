# Design

## Context

See `proposal.md` for business motivation and `specs/` for behavioral requirements.
The current codebase is a newly generated Flutter application (`oms_new`) on Flutter 3.x / Dart 3.14.0. The prototype must support healthcare providers in bilingual environments (Arabic RTL primary, English LTR secondary) on Desktop and Tablet screen sizes, enforcing strict clinical safety boundaries and statutory PHI protections.

## Goals / Non-Goals

**Goals:**
- Provide a robust, testable Feature-First Clean Architecture split into `domain`, `data`, and `presentation` layers with 100% adherence to SOLID principles.
- Enforce strict separation of concerns between `DOCTOR_ASSISTANT` (PII intake only) and `TREATING_DOCTOR` (full longitudinal EHR and consultation).
- Ensure mandatory Human-in-the-Loop (HITL) doctor approval before committing any AI-assisted notes or issuing e-prescriptions.
- Provide reactive real-time queue streaming and offline draft resiliency (`NFR-REL-02`) via Drift (SQLite).
- Deliver a master-detail split-screen layout (< 3 clicks to review and approve, `NFR-USE-01`) optimized for 1440x900 desktop and 768-1199px tablet resolutions.
- Support bidirectional Arabic/English rendering without layout distortion or corrupted Latin drug formulations (`NFR-USE-03`).

**Non-Goals:**
- Mobile (phone) screen layouts (< 768px width) are out of scope for this clinic portal MVP.
- Real-time speech-to-text cloud API integration (simulated mock dictation stream is used for prototype validation).
- Direct backend hardware integration with physical thermal receipt printers or smart-card readers.
- Custom graphic design systems (standard Material 3 widgets are strictly used).

## Decisions

### Decision 1: Feature-First Clean Architecture Layering
- **Approach**: Organize codebase by feature (`auth`, `assistant_intake`, `doctor_queue_ehr`, `clinical_consultation`), where each feature contains isolated `domain`, `data`, and `presentation` directories.
- **Rule**: `domain` has zero Flutter dependencies, importing only `fpdart` and `equatable`. UseCases have a single responsibility (`call(...)`).
- **Alternative Considered**: Layer-first architecture (`lib/controllers`, `lib/models`, `lib/views`). Rejected because it creates tight coupling across domains and degrades scalability as features grow.

### Decision 2: Dependency Injection via `get_it` & `injectable`
- **Approach**: Code-generated service locator using `@singleton`, `@lazySingleton`, and `@injectable` annotations, configured via `configureDependencies()`.
- **Rule**: Every repository, data source, and use case receives dependencies via constructor injection to guarantee testability.
- **Alternative Considered**: `Provider` / manual wiring. Rejected due to boilerplate and lack of compile-time verification for multi-layer dependency graphs.

### Decision 3: Local Persistence & Reactive Streams with Drift (SQLite)
- **Approach**: Use Drift with `sqlite3_flutter_libs` to manage local relational persistence for patient summaries, consultation drafts, and live queue items.
- **Rationale**: Drift DAOs provide auto-updating Dart `Stream`s via `watch()` queries that feed BLoCs without manual polling, while offering encrypted/durable local draft caching (`NFR-REL-02`).
- **Alternative Considered**: `Hive` or in-memory cache. Rejected because relational constraints, schema migrations, and reactive table triggers in Drift provide medical-grade reliability for draft persistence.

### Decision 4: Mandatory Human-in-the-Loop AI Safety Gate
- **Approach**: Enforce the invariant at both presentation and domain layers:
  1. `AiDraftNoteEntity` is initialized with `reviewStatus = DraftReviewStatus.draft` and `doctorApproved = false`.
  2. UI displays an amber/red warning banner: *"Unverified AI Draft - Requires Doctor Review & Approval"*.
  3. `CommitConsultationUseCase` evaluates `if (!params.draftNote.doctorApproved) throw ClinicalSafetyException(...)`.
- **Alternative Considered**: UI-only validation (disabling commit button). Rejected because critical health safety invariants must be enforced within the pure domain logic regardless of caller.

### Decision 5: Responsive Split-Screen UX (< 3 Clicks)
- **Approach**: Configure `flutter_screenutil` with base size `1440x900` (`minTextAdapt: true`, `splitScreenMode: true`) and a custom `ResponsiveLayoutBuilder` with breakpoints:
  - Tablet: `768px <= width < 1200px` (flexible split 40/60 or collapsible side drawer).
  - Desktop: `width >= 1200px` (permanent split 35/65 Master-Detail).
- **Workflow**: Click 1 (Select queue patient) -> Click 2 (Review/Edit AI draft) -> Click 3 (Approve & Commit).

### Decision 6: Bilingual Healthcare Text Isolates (Arabic/English)
- **Approach**: Standard `flutter_localizations` with ARB files (`intl_ar.arb`, `intl_en.arb`). Wrap all drug names, dosage metrics (e.g., `500mg TID x 5d`), and ICD-10 strings in directional isolate markers (Unicode `\u2067` and `\u2069` or `Directionality(textDirection: TextDirection.ltr)`).
- **Alternative Considered**: English-only clinical fields. Rejected because administrative staff and regional compliance require Arabic interface with mixed-script clinical fidelity.

## Risks / Trade-offs

- **[Risk] Drift platform compilation on Windows / Web targets** → **Mitigation**: Use `sqlite3_flutter_libs` for desktop and standard drift fallback or `WasmDatabase` setup for web targets; ensure mock in-memory fallback for unit tests.
- **[Risk] ScreenUtil scaling artifacts on non-standard aspect ratios** → **Mitigation**: Combine ScreenUtil with flexible flex layouts (`Row`, `Expanded`, `LayoutBuilder`) rather than rigid fixed height/width values.
- **[Risk] Assistant inadvertently requesting clinical routes via deep link** → **Mitigation**: Implement role-based router guards in `core/router/app_router.dart` checking authenticated role claims before allowing route resolution.
- **[Risk] Network disconnection during active consultation commit** → **Mitigation**: Flag draft with `SyncStatus.pending_commit` in Drift; sync automatically when `NetworkInfo.isConnected` transitions to true.

## Migration Plan

1. Add required dependencies to `pubspec.yaml`.
2. Generate base infrastructure: `lib/core` (di, error, network, localization, responsive, router, database).
3. Scaffold feature directories: `auth`, `assistant_intake`, `doctor_queue_ehr`, `clinical_consultation`.
4. Run `build_runner` for `injectable` and `drift`.
5. Implement unit tests mirroring domain and presentation layers in `test/`.
