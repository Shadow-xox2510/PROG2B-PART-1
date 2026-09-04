# Database Relationships

The RaceDay database contains the following relationships:

- Users to Events: One-to-Many
- Routes to Events: One-to-Many
- Events to Categories: One-to-Many
- Users to EventEnrolments: One-to-Many
- Events to EventEnrolments: One-to-Many
- Categories to EventEnrolments: One-to-Many
- EventEnrolments to Results: One-to-Zero-or-One

Results are linked to events indirectly through EventEnrolments.
