# Spec Delta

## Purpose

Provides outpatient reception and intake workflows for patient lookup, quick registration, vital signs capture, and consultation queue forwarding with strict PII/PHI isolation.

## ADDED Requirements

### Requirement: Patient Lookup by Identifier
The system SHALL allow the assistant to search for registered patients by either Egyptian National ID (14 digits) or mobile phone number.

#### Scenario: Patient found by phone or national ID
- **WHEN** assistant enters a valid registered phone number or national ID
- **THEN** system returns the matching patient demographic summary displaying full name, age, gender, blood type, and contact details

#### Scenario: Patient not found
- **WHEN** assistant enters an identifier not matching any existing record
- **THEN** system indicates no match was found and presents an option to register a new patient

### Requirement: New Patient Intake Registration
The system SHALL enable assistants to register a new patient profile with required demographic fields including full name, national ID, phone number, date of birth or age, gender, and blood type.

#### Scenario: Successful patient creation
- **WHEN** assistant submits complete and valid demographic data for a new patient
- **THEN** system creates the patient record, generates a unique patient ID, and displays the patient summary card ready for vitals entry

#### Scenario: Duplicate national ID rejection
- **WHEN** assistant attempts to register a patient with an already existing national ID
- **THEN** system rejects registration and displays a duplicate identity conflict error

### Requirement: Vital Signs Recording
The system SHALL capture patient intake vital signs including systolic and diastolic blood pressure, pulse rate, body temperature, oxygen saturation (SpO2), weight, and height, automatically computing body mass index (BMI).

#### Scenario: Valid vitals entry
- **WHEN** assistant enters valid numerical values for blood pressure, pulse, temperature, SpO2, weight, and height
- **THEN** system validates physiological bounds, computes BMI, and stores the vitals intake snapshot

#### Scenario: Out-of-bounds vitals validation
- **WHEN** assistant enters vital values outside safe physiological limits (such as pulse <= 0 or temperature > 45C)
- **THEN** system highlights the invalid field and prevents queue forwarding until corrected

### Requirement: Patient Forwarding to Doctor Queue
The system SHALL forward an intake-completed patient with their vitals snapshot into the active treating doctor's live consultation queue.

#### Scenario: Successful queue dispatch
- **WHEN** assistant confirms queue forwarding for a patient with recorded vitals
- **THEN** system assigns the patient a queue priority status of waiting, updates the live queue, and notifies the assistant of successful dispatch

### Requirement: PHI Isolation Firewall
The system SHALL strictly isolate Protected Health Information (PHI) from the assistant intake interface, preventing retrieval or rendering of clinical notes, past diagnoses, or prescriptions.

#### Scenario: Assistant data response isolation
- **WHEN** assistant queries patient data
- **THEN** system delivers only demographic summary and intake vitals, omitting clinical notes, medical records, and prescription entities
