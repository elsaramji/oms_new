# Proposal

## Why

Outpatient clinics face operational bottlenecks, clinical documentation fatigue, and compliance risks when administrative intake and clinical workflows lack strict separation and safety guardrails. The One Medical System (OMS) - Clinic Portal MVP solves this by providing a unified, bilingual (Arabic/English) Desktop/Web and Tablet interface with role-based PHI boundaries (isolating patient intake from clinical notes) and a mandatory Human-in-the-Loop (HITL) safety gate for AI-assisted clinical documentation and QR e-prescribing.

## What Changes

- Implement feature-first Clean Architecture separating `domain`, `data`, and `presentation` layers with strict SOLID compliance.
- Introduce Role-Based Access Control (RBAC) separating `DOCTOR_ASSISTANT` (PII and intake vitals only) from `TREATING_DOCTOR` (full longitudinal EHR and clinical consultation).
- Add Doctor Assistant intake workflow: patient search by Phone/National ID, new patient registration, vital signs recording (BP, Pulse, Temp, SpO2, BMI), and live queue forwarding.
- Add Doctor live consultation queue with reactive stream updates and longitudinal EHR timeline view featuring high-contrast clinical alerts (allergies, chronic diseases).
- Add Clinical Consultation workflow with dual note capture (Manual SOAP entry or Simulated AI Clinical Scribe).
- Implement mandatory Human-in-the-Loop (HITL) AI safety gate: AI Scribe notes initialize in unapproved `DRAFT` status and cannot be committed without explicit doctor review and approval, raising `ClinicalSafetyException` if bypassed.
- Add QR-secured E-Prescription generation upon consultation commitment.
- Implement reactive local database caching using Drift for offline draft resiliency (`NFR-REL-02`) and queue streaming.
- Implement responsive Master-Detail split-screen UX for Tablet (768px-1199px) and Desktop (>=1200px) achieving `< 3 clicks` consultation completion (`NFR-USE-01`).
- Implement bilingual healthcare UX (Arabic primary RTL, English secondary LTR) with bidirectional isolates for medical terms and drug regimens (`NFR-USE-03`).

## Capabilities

### New Capabilities
- `auth-session`: Authentication and role-based session management (`DOCTOR_ASSISTANT` vs `TREATING_DOCTOR`) with route protection and token-driven role claims.
- `assistant-intake`: Patient search by Phone/National ID, intake registration, vital signs entry, and live queue forwarding with strict PII/PHI isolation (`FR-AST-01`, `FR-AUTH-02`).
- `doctor-queue-ehr`: Reactive live consultation queue management and longitudinal EHR timeline with high-contrast critical alerts (`FR-DOC-01`, `FR-DOC-02`).
- `clinical-consultation`: Clinical SOAP note documentation, simulated AI Clinical Scribe, draft state lifecycle, mandatory HITL doctor approval safety gate, and QR-secured E-Prescription generation (`FR-AI-02`, `FR-AI-04`, `FR-RX-01`).

### Modified Capabilities
*(None - greenfield project with no pre-existing specs)*

## Impact

- **Dependencies**: Adds `flutter_bloc`, `get_it`, `injectable`, `dio`, `connectivity_plus`, `drift`, `sqlite3_flutter_libs`, `flutter_screenutil`, `qr_flutter`, `intl`, `fpdart`, `equatable`, and testing tools (`mocktail`, `bloc_test`, `build_runner`, `injectable_generator`, `drift_dev`).
- **Codebase**: Establishes `lib/core` (di, error, network, localization, responsive, router) and `lib/features` (`auth`, `assistant_intake`, `doctor_queue_ehr`, `clinical_consultation`).
- **Safety & Compliance**: Enforces zero PHI leakage to assistant intake models and compile-time/runtime HITL verification prior to consultation commit.
