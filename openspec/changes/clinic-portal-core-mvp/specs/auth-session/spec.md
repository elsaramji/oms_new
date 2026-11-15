# Spec Delta

## Purpose

Manages authenticated clinic staff sessions with strict role-based access control separating administrative intake staff from licensed clinical doctors.

## ADDED Requirements

### Requirement: Role-based Authentication
The system SHALL authenticate clinic staff members using credentials and establish a session containing their designated role claim of either DOCTOR_ASSISTANT or TREATING_DOCTOR.

#### Scenario: Successful doctor login
- **WHEN** user submits valid credentials assigned the TREATING_DOCTOR role
- **THEN** system establishes an authenticated session with doctor privileges and routes to the doctor workspace

#### Scenario: Successful assistant login
- **WHEN** user submits valid credentials assigned the DOCTOR_ASSISTANT role
- **THEN** system establishes an authenticated session with assistant privileges and routes to the patient intake workspace

#### Scenario: Authentication failure
- **WHEN** user submits invalid credentials
- **THEN** system denies authentication and displays a clear error message without disclosing role or username validity

### Requirement: Session and Route Access Control
The system SHALL enforce role-based route guards and operational boundaries preventing DOCTOR_ASSISTANT roles from accessing clinical records or doctor routes.

#### Scenario: Assistant blocked from doctor route
- **WHEN** an authenticated DOCTOR_ASSISTANT attempts to access a doctor queue or clinical record route
- **THEN** system blocks navigation, raises an unauthorized access event, and redirects to the assistant intake dashboard

#### Scenario: Doctor accessing doctor route
- **WHEN** an authenticated TREATING_DOCTOR accesses the doctor queue route
- **THEN** system permits navigation and renders the doctor consultation workspace

### Requirement: Session Invalidation and Logout
The system SHALL terminate staff sessions upon explicit logout or authentication failure, clearing all in-memory role credentials and tokens.

#### Scenario: Explicit logout
- **WHEN** user initiates logout from the workspace header
- **THEN** system invalidates active tokens, wipes the local user session, and redirects to the login screen
