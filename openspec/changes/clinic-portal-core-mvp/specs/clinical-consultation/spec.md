# Spec Delta

## Purpose

Enables clinical SOAP note documentation, simulated AI Clinical Scribe capture, temporary draft review, mandatory Human-in-the-Loop doctor approval, and QR-secured e-prescribing.

## ADDED Requirements

### Requirement: Dual Note Capture Modes
The system SHALL support both direct manual keyboard entry and simulated AI Clinical Scribe dictation for capturing Subjective, Objective, Assessment, and Plan (SOAP) clinical notes.

#### Scenario: Manual SOAP documentation
- **WHEN** doctor inputs text directly into the SOAP form fields
- **THEN** system updates the active draft note with the entered clinical details

#### Scenario: AI Scribe simulated dictation
- **WHEN** doctor initiates simulated voice dictation and requests transcription
- **THEN** system simulates audio processing and populates SOAP fields and recommended prescriptions into an unverified draft state

### Requirement: AI Draft State and Unverified Warning Banner
The system SHALL initialize all AI Scribe outputs with an unapproved draft review status and display a persistent visual warning banner indicating doctor verification is mandatory.

#### Scenario: Draft instantiation with warning
- **WHEN** AI Scribe populates note fields
- **THEN** system marks draft reviewStatus as draft with doctorApproved set to false and renders the persistent banner stating "Unverified AI Draft - Requires Doctor Review & Approval"

### Requirement: Draft Review and Modification
The system SHALL allow the doctor to inspect, edit, add, or delete any content within the AI-generated SOAP note and proposed medication list prior to approval.

#### Scenario: Doctor modifies AI draft content
- **WHEN** doctor edits medication dosage or amends clinical notes
- **THEN** system preserves modifications in the active draft while maintaining unapproved status until explicit finalization

### Requirement: Mandatory Human-in-the-Loop (HITL) Approval Safety Gate
The system SHALL enforce an unbypassable safety invariant preventing consultation commitment or prescription issuance unless doctorApproved is explicitly confirmed as true.

#### Scenario: Successful consultation commitment with doctor approval
- **WHEN** doctor reviews all clinical entries and triggers "Approve & Commit"
- **THEN** system sets doctorApproved to true, commits the consultation to the permanent EHR, marks queue status completed, and generates the secured prescription

#### Scenario: Rejection of unapproved commit attempt
- **WHEN** a commit operation is invoked while doctorApproved is false
- **THEN** system aborts the operation, raises a ClinicalSafetyException, and informs the doctor that explicit review and approval are required

### Requirement: QR-Secured E-Prescription Generation
The system SHALL generate a digitally verifiable, QR-encoded electronic prescription upon consultation commitment containing patient demographics, visit metadata, prescribed regimens, and cryptographic/verification hash.

#### Scenario: QR prescription rendering
- **WHEN** consultation commitment succeeds
- **THEN** system displays the finalized E-Prescription card with a scannable QR code encoding the prescription verification payload

### Requirement: Offline Draft Resiliency
The system SHALL cache active consultation drafts in local persistent storage so that network disconnections do not cause loss of clinical documentation.

#### Scenario: Offline draft persistence and recovery
- **WHEN** device connectivity is lost during an active consultation session
- **THEN** system saves the current draft locally with pending sync status and reloads it seamlessly when the consultation is resumed
