-- Create the database
CREATE DATABASE dashboard;
USE dashboard;

-- Create alert table
CREATE TABLE sigalert (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    alert_time DATETIME,
    signal_type VARCHAR(50),
    severity_level ENUM('Critical', 'High', 'Moderate', 'Low'),
    sender_name VARCHAR(100),
    sender_phone VARCHAR(15),
    verification_status ENUM('Pending', 'Verified', 'Rejected')
);

-- Insert data into alert table
INSERT INTO sigalert (alert_id, alert_time, signal_type, severity_level, sender_name, sender_phone, verification_status)
VALUES
(1, '2025-02-18 10:00:00', 'Fire', 'Critical', 'John Doe', '123-456-7890', 'Pending'),
(2, '2025-02-18 10:15:00', 'Medical', 'High', 'Jane Smith', '234-567-8901', 'Verified'),
(3, '2025-02-18 10:30:00', 'Law Enforcement', 'Moderate', 'Alice Brown', '345-678-9012', 'Pending');

-- Create locations table
CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    alert_id INT,
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    address VARCHAR(255),
    FOREIGN KEY (alert_id) REFERENCES alert(alert_id) ON DELETE CASCADE
);

-- Insert data into locations table
INSERT INTO locations (alert_id, latitude, longitude, address)
VALUES
(1, 40.7128, -74.0060, '123 Main St, New York, NY'),
(2, 34.0522, -118.2437, '456 Elm St, Los Angeles, CA'),
(3, 41.8781, -87.6298, '789 Pine St, Chicago, IL');

-- Create communications table
CREATE TABLE communications (
    communication_id INT AUTO_INCREMENT PRIMARY KEY,
    alert_id INT,
    timestamp DATETIME,
    message TEXT,
    responder_name VARCHAR(100),
    status ENUM('Sent', 'Received', 'Responding', 'Resolved'),
    FOREIGN KEY (alert_id) REFERENCES alert(alert_id) ON DELETE CASCADE
);

-- Insert data into communications table
INSERT INTO communications (alert_id, timestamp, message, responder_name, status)
VALUES
(1, '2025-02-18 10:05:00', 'Fire reported. Dispatching team.', 'Fire Chief', 'Sent'),
(2, '2025-02-18 10:20:00', 'Medical emergency at Elm St.', 'Paramedic Team 1', 'Responding');

-- Create resources table
CREATE TABLE resources (
    resource_id INT AUTO_INCREMENT PRIMARY KEY,
    alert_id INT,
    resource_type VARCHAR(50),
    status ENUM('Available', 'En Route', 'Responding', 'Idle'),
    eta INT,
    FOREIGN KEY (alert_id) REFERENCES alert(alert_id) ON DELETE CASCADE
);

-- Insert data into resources table
INSERT INTO resources (alert_id, resource_type, status, eta)
VALUES
(1, 'Fire Truck', 'En Route', 10),
(2, 'Ambulance', 'Responding', 5);

-- Create analytics table
CREATE TABLE analytics (
    date DATE,
    alert_type VARCHAR(50),
    alert_count INT,
    average_response_time INT
);

-- Insert data into analytics table
INSERT INTO analytics (date, alert_type, alert_count, average_response_time)
VALUES
('2025-02-17', 'Fire', 5, 12),
('2025-02-17', 'Medical', 3, 8),
('2025-02-17', 'Law Enforcement', 2, 10);

-- Create system_status table
CREATE TABLE system_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME,
    signal_strength INT,
    alert_queue INT
);

-- Insert data into system_status table
INSERT INTO system_status (timestamp, signal_strength, alert_queue)
VALUES
('2025-02-18 10:00:00', 75, 2),
('2025-02-18 10:10:00', 90, 1);
use dashboard;
CREATE TABLE responders (
    responder_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    role VARCHAR(50),
    organization VARCHAR(100),
    contact_info VARCHAR(100),
    status ENUM('Available', 'On-Route', 'Unavailable'),
    current_location VARCHAR(100)
);
SHOW TABLES;
DESCRIBE responders;
SELECT * FROM responders LIMIT 10;
INSERT INTO responders (name, role, organization, contact_info, status, current_location)
VALUES 
    ('John Doe', 'Firefighter', 'City Fire Department', '555-1234', 'Available', 'Station 1'),
    ('Jane Smith', 'Paramedic', 'City EMS', '555-5678', 'On-Route', 'Main St. and 2nd Ave.'),
    ('Alice Brown', 'Police Officer', 'City Police Department', '555-9012', 'Unavailable', 'N/A'),
    ('Michael Johnson', 'Search & Rescue', 'Disaster Response Unit', '555-3456', 'Available', 'Rescue HQ'),
    ('Emily Davis', 'Emergency Technician', 'City EMS', '555-7890', 'On-Route', 'Elm St. and 4th Ave.'),
    ('David Green', 'Firefighter', 'City Fire Department', '555-2468', 'Unavailable', 'Station 2'),
    ('Sophia Wilson', 'Police Officer', 'City Police Department', '555-1357', 'Available', 'City HQ'),
    ('Chris Lee', 'Search & Rescue', 'Disaster Response Unit', '555-8642', 'On-Route', 'Riverfront Park'),
    ('Laura Carter', 'Paramedic', 'City EMS', '555-9753', 'Unavailable', 'Hospital Base'),
    ('James Miller', 'Firefighter', 'City Fire Department', '555-8642', 'Available', 'Station 3');
 use dashboard;
CREATE TABLE incident_response_times (
    incident_id INT PRIMARY KEY,
    signal_type VARCHAR(50),
    severity_level ENUM('Critical', 'High', 'Moderate', 'Low'),
    response_start_time DATETIME,
    arrival_time DATETIME,
    response_duration INT AS (TIMESTAMPDIFF(MINUTE, response_start_time, arrival_time)) VIRTUAL
);

INSERT INTO incident_response_times (incident_id, signal_type, severity_level, response_start_time, arrival_time)
VALUES
    (1, 'Fire', 'Critical', '2025-02-18 14:30:00', '2025-02-18 14:45:00'),
    (2, 'Medical', 'High', '2025-02-18 15:00:00', '2025-02-18 15:25:00'),
    (3, 'Law Enforcement', 'Moderate', '2025-02-18 15:10:00', '2025-02-18 15:40:00'),
    (4, 'Fire', 'High', '2025-02-18 16:00:00', '2025-02-18 16:20:00'),
    (5, 'Medical', 'Critical', '2025-02-18 16:30:00', '2025-02-18 16:50:00'),
    (6, 'Law Enforcement', 'Low', '2025-02-18 17:00:00', '2025-02-18 17:40:00'),
    (7, 'Fire', 'Moderate', '2025-02-18 17:15:00', '2025-02-18 17:35:00'),
    (8, 'Medical', 'Low', '2025-02-18 18:00:00', '2025-02-18 18:50:00'),
    (9, 'Law Enforcement', 'Critical', '2025-02-18 18:30:00', '2025-02-18 18:45:00'),
    (10, 'Fire', 'Critical', '2025-02-18 19:00:00', '2025-02-18 19:15:00');



-- Uncomment below if you actually want to delete the database after everything
-- DROP DATABASE dashboard;
