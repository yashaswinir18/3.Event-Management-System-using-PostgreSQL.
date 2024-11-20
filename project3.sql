-- --Create a database named "EventsManagement."-- 
CREATE DATABASE EventsManagement;
USE EventsManagement;

-- --Create tables for Events, Attendees, and Registrations.
-- --Events- Event_Id, Event_Name, Event_Date, Event_Location, Event_Description
-- --Attendees- Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City
-- --Registrations-Registration_id, Event_Id, Attendee_Id,Registration_Date,Registration_Amount.

CREATE TABLE Events (
    Event_Id INT AUTO_INCREMENT PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(255) NOT NULL,
    Event_Description TEXT
);

CREATE TABLE Attendees (
    Attendee_Id INT AUTO_INCREMENT PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100) UNIQUE NOT NULL,
    Attendee_City VARCHAR(100)
);


CREATE TABLE Registrations (
    Registration_Id INT AUTO_INCREMENT PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) ON DELETE CASCADE,
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id) ON DELETE CASCADE
);


-- 2. Insert some sample data for Events, Attendees, and Registrations tables with respective fields.
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Tech Conference 2024', '2024-12-15', 'San Francisco', 'A conference for tech enthusiasts.'),
    ('Music Festival', '2025-01-10', 'Los Angeles', 'A grand music festival featuring top artists.'),
    ('Art Workshop', '2025-02-20', 'New York', 'An interactive workshop for art lovers.');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('Alice Johnson', '9876543210', 'alice.johnson@example.com', 'Boston'),
    ('Bob Smith', '9876543211', 'bob.smith@example.com', 'Chicago'),
    ('Cathy Lee', '9876543212', 'cathy.lee@example.com', 'San Francisco');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
    (1, 1, '2024-11-10', 100.00),
    (1, 2, '2024-11-12', 100.00),
    (2, 3, '2024-11-15', 150.00);


-- 3. Manage Event Details
-- Inserting a new event.
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Coding Bootcamp', '2025-03-05', 'Seattle', 'A hands-on bootcamp for coding enthusiasts.');

-- --Updating an event's information.
UPDATE Events
SET Event_Date = '2025-01-15', Event_Location = 'San Diego'
WHERE Event_Id = 2;

-- --Deleting an event.
DELETE FROM Events
WHERE Event_Id = 3;


-- --- -4) Manage Track Attendees & Handle Events
-- --a) Inserting a new attendee.
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Daniel Brown', '9876543213', 'daniel.brown@example.com', 'Seattle');

-- --b)Registering an attendee for an event.
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 4, '2024-12-01', 100.00);


-- --5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.
SELECT * FROM Events;

SELECT A.Attendee_Name, A.Attendee_Email, A.Attendee_City
FROM Attendees A
JOIN Registrations R ON A.Attendee_Id = R.Attendee_Id
WHERE R.Event_Id = 1;


SELECT 
    E.Event_Name, 
    COUNT(R.Registration_Id) AS Total_Attendees, 
    SUM(R.Registration_Amount) AS Total_Revenue
FROM Events E
JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name;
