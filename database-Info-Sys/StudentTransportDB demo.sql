USE master;
GO

-- Drop existing database if needed
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'StudentTransportDB')
BEGIN
    ALTER DATABASE StudentTransportDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StudentTransportDB;
END
GO

CREATE DATABASE StudentTransportDB;
GO

USE StudentTransportDB;
GO

-- Create Tables
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(128) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN ('Student', 'Driver', 'TransportManager')) NOT NULL,
    IsActive BIT DEFAULT 1 NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Residence NVARCHAR(100) NOT NULL,
    CampusLocation NVARCHAR(100) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    LicenseNumber NVARCHAR(50) UNIQUE NOT NULL,
    IsAvailable BIT DEFAULT 1 NOT NULL,
    FOREIGN KEY (DriverID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Stations (
    StationID INT IDENTITY(1,1) PRIMARY KEY,
    StationName NVARCHAR(100) NOT NULL,
    Type NVARCHAR(20) CHECK (Type IN ('Residence', 'Campus')) NOT NULL,
    Location NVARCHAR(200) NOT NULL
);

CREATE TABLE Buses (
    BusID INT IDENTITY(1,1) PRIMARY KEY,
    BusNumber NVARCHAR(20) UNIQUE NOT NULL,
    Capacity INT NOT NULL,
    CurrentDriverID INT NULL,
    FOREIGN KEY (CurrentDriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE Schedules (
    ScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    BusID INT NOT NULL,
    DepartureStationID INT NOT NULL,
    ArrivalStationID INT NOT NULL,
    DepartureTime DATETIME NOT NULL,
    EstimatedArrivalTime DATETIME NOT NULL,
    IsActive BIT DEFAULT 1 NOT NULL,
    FOREIGN KEY (BusID) REFERENCES Buses(BusID),
    FOREIGN KEY (DepartureStationID) REFERENCES Stations(StationID),
    FOREIGN KEY (ArrivalStationID) REFERENCES Stations(StationID)
);

CREATE TABLE BusStatusLog (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    BusID INT NOT NULL,
    DriverID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Ready', 'InProgress', 'OffDuty', 'Maintenance')) NOT NULL,
    StatusTime DATETIME DEFAULT GETDATE() NOT NULL,
    FOREIGN KEY (BusID) REFERENCES Buses(BusID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    ScheduleID INT NOT NULL,
    BookingTime DATETIME DEFAULT GETDATE() NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Confirmed', 'Cancelled')) DEFAULT 'Confirmed',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ScheduleID) REFERENCES Schedules(ScheduleID)
);
GO

-- Insert Sample Data
-- 1. Stations (6 records)
INSERT INTO Stations (StationName, Type, Location) VALUES
('Main Campus Gate A', 'Campus', '123 University Ave'),
('Harmony Res', 'Residence', '456 Student St'),
('Science Campus', 'Campus', '789 Research Blvd'),
('Garden Res', 'Residence', '101 Garden Ave'),
('Engineering Campus', 'Campus', '202 Tech Park'),
('Mountain View Res', 'Residence', '303 Mountain Rd');

-- 2. Users (6 records per role)
-- Transport Managers
INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) VALUES
('admin1@uni.com', 'hash1', 'John', 'Doe', 'TransportManager'),
('admin2@uni.com', 'hash2', 'Jane', 'Smith', 'TransportManager'),
('admin3@uni.com', 'hash3', 'Robert', 'Johnson', 'TransportManager'),
('admin4@uni.com', 'hash4', 'Emily', 'Williams', 'TransportManager'),
('admin5@uni.com', 'hash5', 'Michael', 'Brown', 'TransportManager'),
('admin6@uni.com', 'hash6', 'Sarah', 'Davis', 'TransportManager');

-- Drivers
INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) VALUES
('driver1@uni.com', 'hash7', 'David', 'Miller', 'Driver'),
('driver2@uni.com', 'hash8', 'Lisa', 'Wilson', 'Driver'),
('driver3@uni.com', 'hash9', 'James', 'Taylor', 'Driver'),
('driver4@uni.com', 'hash10', 'Mary', 'Anderson', 'Driver'),
('driver5@uni.com', 'hash11', 'Daniel', 'Thomas', 'Driver'),
('driver6@uni.com', 'hash12', 'Jennifer', 'Jackson', 'Driver');

-- Students
INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) VALUES
('student1@uni.com', 'hash13', 'Emma', 'White', 'Student'),
('student2@uni.com', 'hash14', 'Noah', 'Harris', 'Student'),
('student3@uni.com', 'hash15', 'Olivia', 'Martin', 'Student'),
('student4@uni.com', 'hash16', 'Liam', 'Thompson', 'Student'),
('student5@uni.com', 'hash17', 'Ava', 'Garcia', 'Student'),
('student6@uni.com', 'hash18', 'William', 'Martinez', 'Student');

-- 3. Students (6 records)
INSERT INTO Students (StudentID, Residence, CampusLocation)
SELECT u.UserID, 
    CASE u.Email 
        WHEN 'student1@uni.com' THEN 'Harmony Res'
        WHEN 'student2@uni.com' THEN 'Garden Res'
        WHEN 'student3@uni.com' THEN 'Mountain View Res'
        WHEN 'student4@uni.com' THEN 'Harmony Res'
        WHEN 'student5@uni.com' THEN 'Garden Res'
        WHEN 'student6@uni.com' THEN 'Mountain View Res'
    END,
    'Main Campus'
FROM Users u
WHERE u.Role = 'Student';

-- 4. Drivers (6 records)
INSERT INTO Drivers (DriverID, LicenseNumber)
SELECT u.UserID, 'DRV-' + CAST(u.UserID AS NVARCHAR(10))
FROM Users u
WHERE u.Role = 'Driver';

-- 5. Buses (6 records)
INSERT INTO Buses (BusNumber, Capacity) VALUES
('BUS-101', 30),
('BUS-102', 40),
('BUS-103', 35),
('BUS-104', 25),
('BUS-105', 45),
('BUS-106', 30);

-- Assign drivers to buses using a reliable method
;WITH NumberedDrivers AS (
    SELECT DriverID, ROW_NUMBER() OVER (ORDER BY DriverID) AS RowNum
    FROM Drivers
),
NumberedBuses AS (
    SELECT BusID, ROW_NUMBER() OVER (ORDER BY BusID) AS RowNum
    FROM Buses
)
UPDATE b
SET CurrentDriverID = d.DriverID
FROM Buses b
INNER JOIN NumberedBuses nb ON b.BusID = nb.BusID
INNER JOIN NumberedDrivers d ON nb.RowNum = d.RowNum;

-- 6. Schedules (6 records) - Fixed syntax
DECLARE @today DATETIME = GETDATE();

INSERT INTO Schedules (BusID, DepartureStationID, ArrivalStationID, DepartureTime, EstimatedArrivalTime)
SELECT 
    BusID,
    DepartureStationID,
    ArrivalStationID,
    DepartureTime,
    EstimatedArrivalTime
FROM (VALUES
    (1, 1, 2, DATEADD(HOUR, 7, @today), DATEADD(MINUTE, 30, DATEADD(HOUR, 7, @today))),
    (2, 3, 4, DATEADD(HOUR, 8, @today), DATEADD(MINUTE, 45, DATEADD(HOUR, 8, @today))),
    (3, 5, 6, DATEADD(HOUR, 9, @today), DATEADD(MINUTE, 35, DATEADD(HOUR, 9, @today))),
    (4, 2, 1, DATEADD(HOUR, 10, @today), DATEADD(MINUTE, 30, DATEADD(HOUR, 10, @today))),
    (5, 4, 3, DATEADD(HOUR, 11, @today), DATEADD(MINUTE, 45, DATEADD(HOUR, 11, @today))),
    (6, 6, 5, DATEADD(HOUR, 12, @today), DATEADD(MINUTE, 35, DATEADD(HOUR, 12, @today)))
) AS SchedData(BusID, DepartureStationID, ArrivalStationID, DepartureTime, EstimatedArrivalTime);

-- 7. BusStatusLog (6 records) - Optimized
INSERT INTO BusStatusLog (BusID, DriverID, Status)
SELECT 
    b.BusID,
    b.CurrentDriverID,
    CASE b.BusID
        WHEN 1 THEN 'Ready'
        WHEN 2 THEN 'InProgress'
        WHEN 3 THEN 'OffDuty'
        WHEN 4 THEN 'Ready'
        WHEN 5 THEN 'Maintenance'
        WHEN 6 THEN 'InProgress'
    END
FROM Buses b;

-- 8. Bookings (6 records) - Optimized
INSERT INTO Bookings (StudentID, ScheduleID)
SELECT 
    s.StudentID,
    sc.ScheduleID
FROM (
    VALUES 
        ('student1@uni.com', 1),
        ('student2@uni.com', 2),
        ('student3@uni.com', 3),
        ('student4@uni.com', 4),
        ('student5@uni.com', 5),
        ('student6@uni.com', 6)
) AS StudentBookings(Email, ScheduleID)
INNER JOIN Users u ON u.Email = StudentBookings.Email
INNER JOIN Students s ON s.StudentID = u.UserID
INNER JOIN Schedules sc ON sc.ScheduleID = StudentBookings.ScheduleID;
GO