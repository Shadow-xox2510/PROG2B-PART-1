# RaceDay Event Management System

## Programming 2B – Part 1

RaceDay is a web-based event management system designed for the South African road running, walking and cycling community.

The system allows organisers to create and manage events, categories, participant enrolments and race results. Participants can register, browse events, enrol in races and view their personal results.

## User Roles

### Organiser

* Create, update and delete events
* Manage event categories
* View participant enrolments
* Capture race results

### Participant

* Register and log in
* View and update profile
* Browse available events
* Enrol in events by selecting a category
* View personal race results

## Project Documentation

The `/docs` folder contains:
- Entity Relationship Diagram (ERD)
- API Endpoint Plan

The `/database` folder contains:
- SQL Database Script

## Setup Instructions

1. Open SQL Server Management Studio (SSMS).
2. Open `database/SQLQuery1_RACEDAY.sql`.
3. Run the script on a fresh SQL Server instance.
4. The script creates the `RaceDayDB` database, tables, relationships, constraints and sample data.

## Database Testing

The SQL database was tested using SQL Server Management Studio.

Verification queries were used to confirm that:
- All six tables were created successfully.
- Primary and foreign-key relationships are present.
- Seed data is available for all entities.
- Enrolments can exist without a result.

## Main System Features

- User registration and login
- User profile management
- Event creation and management
- Event category management
- Participant enrolment
- Race result management
- Role-based functionality for organisers and participants

## Technologies

- C#
- SQL Server
- SQL Server Management Studio (SSMS)
- Git
- GitHub
- GitHub Actions



