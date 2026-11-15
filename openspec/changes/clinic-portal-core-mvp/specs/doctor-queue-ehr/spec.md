# Spec Delta

## Purpose

Provides real-time consultation queue monitoring and longitudinal Electronic Health Record timeline exploration with high-contrast clinical safety alerts for treating doctors.

## ADDED Requirements

### Requirement: Real-time Live Consultation Queue
The system SHALL display an ordered list of waiting patients forwarded by clinic assistants, updating reactively as queue states change.

#### Scenario: Queue stream updates
- **WHEN** a new patient is forwarded by the assistant or consultation status changes
- **THEN** system updates the queue list in real time without requiring manual page refresh

#### Scenario: Queue patient display details
- **WHEN** doctor views the waiting queue
- **THEN** system displays each patient queue card showing queue order, patient full name, wait duration, and intake vital highlights

### Requirement: Patient Selection and Consultation Activation
The system SHALL allow the doctor to select a patient from the queue, opening their medical record and transitioning queue status to in-consultation.

#### Scenario: Patient selection
- **WHEN** doctor selects a waiting patient from the queue
- **THEN** system loads the patient longitudinal EHR into the context panel and activates the clinical consultation workspace

### Requirement: Longitudinal EHR Timeline
The system SHALL present a chronological timeline of the patient past medical visits, previous diagnoses, past vitals trends, and prior medication history.

#### Scenario: Timeline exploration
- **WHEN** doctor navigates the longitudinal EHR panel
- **THEN** system displays past clinical encounters in reverse chronological order with visit date, attending clinician, diagnosis, and prescribed therapies

### Requirement: High-Contrast Clinical Safety Alerts
The system SHALL prominently display high-contrast, persistent visual warning badges for recorded allergies and chronic conditions in the patient context header.

#### Scenario: Severe allergy presentation
- **WHEN** a selected patient has recorded severe allergies (such as Penicillin or NSAIDs)
- **THEN** system renders high-contrast, prominent allergy alert banners in the persistent header and consultation panel

#### Scenario: Chronic disease alerts
- **WHEN** a selected patient has recorded chronic conditions (such as Diabetes or Hypertension)
- **THEN** system renders distinct chronic condition chips alongside the primary vital indicators
