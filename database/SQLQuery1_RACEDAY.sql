CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    DateRegistered DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Participant', 'Organiser'))
);
GO

CREATE TABLE Routes
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    RouteName VARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    StartLocation VARCHAR(150) NOT NULL,
    FinishLocation VARCHAR(150) NOT NULL
);
GO

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    RouteID INT NOT NULL,
    EventName VARCHAR(150) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,
    MaximumParticipants INT NOT NULL,
    Status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Events_Routes
        FOREIGN KEY (RouteID)
        REFERENCES Routes(RouteID)
);
GO

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(255) NOT NULL,

    CONSTRAINT FK_Categories_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
);
GO

CREATE TABLE EventEnrolments
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    UserID INT NOT NULL,
    CategoryID INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_EventEnrolments_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_EventEnrolments_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_EventEnrolments_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
GO

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime TIME NOT NULL,
    Position INT NOT NULL,
    ResultStatus VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Results_EventEnrolments
        FOREIGN KEY (EnrolmentID)
        REFERENCES EventEnrolments(EnrolmentID)
);
GO

INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
    ('John', 'Smith', 'john.smith@raceday.com', 'Hash123!', 'Organiser', '0821234567'),
    ('Sarah', 'Williams', 'sarah.williams@raceday.com', 'Hash456!', 'Organiser', '0832345678'),
    ('Michael', 'Brown', 'michael.brown@email.com', 'Hash789!', 'Participant', '0843456789'),
    ('Emily', 'Jones', 'emily.jones@email.com', 'Hash321!', 'Participant', '0854567890');
GO

INSERT INTO Routes
    (RouteName, DistanceKm, StartLocation, FinishLocation)
VALUES
    ('City Park Run', 5.00, 'City Park Entrance', 'City Park Stadium'),
    ('Coastal Challenge', 10.00, 'Beachfront Promenade', 'Harbour Point'),
    ('Mountain Trail', 21.10, 'Mountain Base Camp', 'Mountain Summit');
GO

INSERT INTO Events
    (OrganiserID, RouteID, EventName, Description, EventDate,
     Location, EntryFee, MaximumParticipants, Status)
VALUES
    (1, 1, 'City Park 5K',
     'A fun 5 kilometre community road race.',
     '2026-10-10', 'City Park',
     100.00, 200, 'Open'),

    (2, 2, 'Coastal 10K Challenge',
     'A scenic 10 kilometre race along the coast.',
     '2026-11-07', 'Coastal Promenade',
     150.00, 300, 'Open'),

    (1, 3, 'Mountain Half Marathon',
     'A challenging 21.1 kilometre mountain trail race.',
     '2026-12-05', 'Mountain Base Camp',
     250.00, 150, 'Open');
GO

INSERT INTO Categories
    (EventID, CategoryName, Description)
VALUES
    (1, 'Junior', '5 kilometre category for younger participants.'),
    (1, 'Open', '5 kilometre category open to all adult participants.'),

    (2, 'Open', '10 kilometre category open to all participants.'),
    (2, 'Veteran', '10 kilometre category for veteran participants.'),

    (3, 'Half Marathon Open', '21.1 kilometre category open to all adult participants.'),
    (3, 'Half Marathon Veteran', '21.1 kilometre category for veteran participants.');
GO

INSERT INTO EventEnrolments
    (EventID, UserID, CategoryID, Status)
VALUES
    (1, 3, 2, 'Confirmed'),
    (2, 3, 3, 'Confirmed'),
    (2, 4, 4, 'Confirmed'),
    (3, 4, 5, 'Confirmed');
GO

INSERT INTO Results
    (EnrolmentID, FinishTime, Position, ResultStatus)
VALUES
    (1, '00:28:45', 12, 'Finished'),
    (2, '00:55:30', 8, 'Finished'),
    (3, '01:02:15', 15, 'Finished');
GO

SELECT * FROM Users;
GO

SELECT * FROM Routes;
GO

SELECT * FROM Events;
GO

SELECT * FROM Categories;
GO

SELECT * FROM EventEnrolments;
GO

SELECT * FROM Results;
GO

SELECT
    u.FirstName + ' ' + u.LastName AS Participant,
    e.EventName,
    c.CategoryName,
    ee.Status AS EnrolmentStatus,
    r.FinishTime,
    r.Position,
    r.ResultStatus
FROM EventEnrolments ee
INNER JOIN Users u
    ON ee.UserID = u.UserID
INNER JOIN Events e
    ON ee.EventID = e.EventID
INNER JOIN Categories c
    ON ee.CategoryID = c.CategoryID
LEFT JOIN Results r
    ON ee.EnrolmentID = r.EnrolmentID;
GO