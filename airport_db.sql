-- =========================================================
-- AIRPORT MANAGEMENT DATABASE
-- =========================================================

DROP DATABASE IF EXISTS airport_db;

CREATE DATABASE airport_db;
USE airport_db;


-- =========================================================
-- 1. AIRLINES TABLE
-- =========================================================

CREATE TABLE Airlines (
    Airline_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airline_Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    IATA_Code CHAR(2) UNIQUE,
    Founded_Year INT,
    Headquarters VARCHAR(100)
);

INSERT INTO Airlines
(Airline_Name, Country, IATA_Code, Founded_Year, Headquarters)
VALUES
('IndiGo', 'India', '6E', 2006, 'Gurugram, India'),
('Air India', 'India', 'AI', 1932, 'New Delhi, India'),
('SpiceJet', 'India', 'SG', 2005, 'Gurugram, India'),
('Vistara', 'India', 'UK', 2015, 'Gurugram, India'),
('Go First', 'India', 'G8', 2005, 'Mumbai, India'),
('AirAsia India', 'India', 'I5', 2013, 'Bengaluru, India'),
('Akasa Air', 'India', 'QP', 2021, 'Mumbai, India'),

('Delta Air Lines', 'United States', 'DL', 1924, 'Atlanta, USA'),
('American Airlines', 'United States', 'AA', 1930, 'Fort Worth, USA'),
('United Airlines', 'United States', 'UA', 1931, 'Chicago, USA'),
('Southwest Airlines', 'United States', 'WN', 1967, 'Dallas, USA'),

('British Airways', 'United Kingdom', 'BA', 1974, 'London, UK'),
('Virgin Atlantic', 'United Kingdom', 'VS', 1984, 'London, UK'),

('Lufthansa', 'Germany', 'LH', 1953, 'Frankfurt, Germany'),
('Air France', 'France', 'AF', 1933, 'Paris, France'),
('KLM Royal Dutch Airlines', 'Netherlands', 'KL', 1919, 'Amstelveen, Netherlands'),

('Emirates', 'United Arab Emirates', 'EK', 1985, 'Dubai, UAE'),
('Etihad Airways', 'United Arab Emirates', 'EY', 2003, 'Abu Dhabi, UAE'),
('Qatar Airways', 'Qatar', 'QR', 1993, 'Doha, Qatar'),

('Singapore Airlines', 'Singapore', 'SQ', 1947, 'Singapore'),
('Cathay Pacific', 'Hong Kong', 'CX', 1946, 'Hong Kong'),
('Japan Airlines', 'Japan', 'JL', 1951, 'Tokyo, Japan'),
('All Nippon Airways', 'Japan', 'NH', 1952, 'Tokyo, Japan'),

('Qantas', 'Australia', 'QF', 1920, 'Sydney, Australia'),
('Turkish Airlines', 'Turkey', 'TK', 1933, 'Istanbul, Turkey'),

('Air Canada', 'Canada', 'AC', 1937, 'Montreal, Canada');


-- =========================================================
-- 2. AIRPORTS TABLE
-- =========================================================

CREATE TABLE Airports (
    Airport_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airport_Name VARCHAR(120) NOT NULL,
    City VARCHAR(80) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    IATA_Code CHAR(3) UNIQUE,
    TimeZone VARCHAR(50)
);

INSERT INTO Airports
(Airport_Name, City, Country, IATA_Code, TimeZone)
VALUES
('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL', 'UTC+05:30'),
('Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India', 'BOM', 'UTC+05:30'),
('Kempegowda International Airport', 'Bengaluru', 'India', 'BLR', 'UTC+05:30'),
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD', 'UTC+05:30'),
('Netaji Subhas Chandra Bose International Airport', 'Kolkata', 'India', 'CCU', 'UTC+05:30'),
('Chennai International Airport', 'Chennai', 'India', 'MAA', 'UTC+05:30'),
('Cochin International Airport', 'Kochi', 'India', 'COK', 'UTC+05:30'),
('Pune International Airport', 'Pune', 'India', 'PNQ', 'UTC+05:30'),
('Sardar Vallabhbhai Patel International Airport', 'Ahmedabad', 'India', 'AMD', 'UTC+05:30'),
('Goa International Airport', 'Goa', 'India', 'GOI', 'UTC+05:30'),

('Hartsfield–Jackson Atlanta International Airport', 'Atlanta', 'United States', 'ATL', 'UTC−05:00'),
('Los Angeles International Airport', 'Los Angeles', 'United States', 'LAX', 'UTC−08:00'),
('John F. Kennedy International Airport', 'New York', 'United States', 'JFK', 'UTC−05:00'),

('London Heathrow Airport', 'London', 'United Kingdom', 'LHR', 'UTC+00:00'),
('Frankfurt Airport', 'Frankfurt', 'Germany', 'FRA', 'UTC+01:00'),
('Charles de Gaulle Airport', 'Paris', 'France', 'CDG', 'UTC+01:00'),

('Dubai International Airport', 'Dubai', 'United Arab Emirates', 'DXB', 'UTC+04:00'),
('Abu Dhabi International Airport', 'Abu Dhabi', 'United Arab Emirates', 'AUH', 'UTC+04:00'),
('Doha Hamad International Airport', 'Doha', 'Qatar', 'DOH', 'UTC+03:00'),

('Singapore Changi Airport', 'Singapore', 'Singapore', 'SIN', 'UTC+08:00'),
('Hong Kong International Airport', 'Hong Kong', 'China', 'HKG', 'UTC+08:00'),
('Tokyo Haneda Airport', 'Tokyo', 'Japan', 'HND', 'UTC+09:00'),
('Tokyo Narita Airport', 'Tokyo', 'Japan', 'NRT', 'UTC+09:00'),

('Sydney Kingsford Smith Airport', 'Sydney', 'Australia', 'SYD', 'UTC+10:00'),
('Istanbul Airport', 'Istanbul', 'Turkey', 'IST', 'UTC+03:00');


-- =========================================================
-- 3. FLIGHTS TABLE
-- =========================================================

CREATE TABLE Flights (
    Flight_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airline_ID INT NOT NULL,
    Flight_Number VARCHAR(10) UNIQUE NOT NULL,
    Source_Airport_ID INT NOT NULL,
    Destination_Airport_ID INT NOT NULL,
    Departure_Time DATETIME NOT NULL,
    Arrival_Time DATETIME NOT NULL,

    Duration INT AS (
        TIMESTAMPDIFF(MINUTE, Departure_Time, Arrival_Time)
    ),

    Status VARCHAR(20) DEFAULT 'Scheduled',

    FOREIGN KEY (Airline_ID)
        REFERENCES Airlines(Airline_ID),

    FOREIGN KEY (Source_Airport_ID)
        REFERENCES Airports(Airport_ID),

    FOREIGN KEY (Destination_Airport_ID)
        REFERENCES Airports(Airport_ID),

    CHECK (Status IN
        ('Scheduled', 'Delayed', 'Boarding', 'Landed', 'Cancelled')
    )
);

INSERT INTO Flights
(Airline_ID, Flight_Number, Source_Airport_ID,
 Destination_Airport_ID, Departure_Time, Arrival_Time, Status)
VALUES

-- Air India
(2, 'AI101', 1, 14,
 '2025-11-20 06:00:00', '2025-11-20 11:30:00', 'Scheduled'),

(2, 'AI302', 1, 6,
 '2025-11-24 09:00:00', '2025-11-24 11:00:00', 'Scheduled'),

(2, 'AI555', 1, 2,
 '2025-11-27 08:00:00', '2025-11-27 10:30:00', 'Scheduled'),

(2, 'AI777', 1, 10,
 '2025-11-30 07:00:00', '2025-11-30 08:30:00', 'Scheduled'),


-- British Airways
(12, 'BA202', 14, 1,
 '2025-11-20 13:00:00', '2025-11-20 23:30:00', 'Scheduled'),

(12, 'BA329', 14, 6,
 '2025-11-24 12:00:00', '2025-11-24 22:00:00', 'Landed'),

(12, 'BA380', 14, 2,
 '2025-11-27 11:00:00', '2025-11-27 21:30:00', 'Scheduled'),


-- Emirates
(17, 'EK501', 17, 1,
 '2025-11-21 04:00:00', '2025-11-21 08:45:00', 'Scheduled'),

(17, 'EK511', 17, 6,
 '2025-11-24 02:00:00', '2025-11-24 06:00:00', 'Scheduled'),

(17, 'EK525', 17, 2,
 '2025-11-27 03:00:00', '2025-11-27 08:00:00', 'Scheduled'),

(17, 'EK908', 17, 10,
 '2025-11-30 14:00:00', '2025-11-30 18:30:00', 'Scheduled'),


-- Lufthansa
(14, 'LH760', 15, 1,
 '2025-11-21 10:00:00', '2025-11-21 20:15:00', 'Scheduled'),

(14, 'LH756', 15, 6,
 '2025-11-24 18:00:00', '2025-11-25 05:00:00', 'Scheduled'),

(14, 'LH764', 15, 2,
 '2025-11-27 17:00:00', '2025-11-28 03:00:00', 'Delayed'),


-- Air France
(15, 'AF228', 16, 1,
 '2025-11-21 14:00:00', '2025-11-22 01:10:00', 'Delayed'),

(15, 'AF165', 16, 6,
 '2025-11-25 10:00:00', '2025-11-26 00:10:00', 'Delayed'),

(15, 'AF222', 16, 2,
 '2025-11-28 13:00:00', '2025-11-29 00:30:00', 'Landed'),


-- Singapore Airlines
(20, 'SQ403', 20, 1,
 '2025-11-22 09:00:00', '2025-11-22 13:45:00', 'Scheduled'),

(20, 'SQ423', 20, 3,
 '2025-11-25 08:00:00', '2025-11-25 12:30:00', 'Scheduled'),

(20, 'SQ438', 20, 9,
 '2025-11-29 09:00:00', '2025-11-29 14:30:00', 'Scheduled'),


-- Qantas
(24, 'QF67', 24, 6,
 '2025-11-22 07:00:00', '2025-11-22 14:00:00', 'Scheduled'),

(24, 'QF70', 24, 3,
 '2025-11-26 06:00:00', '2025-11-26 13:30:00', 'Scheduled'),

(24, 'QF101', 24, 9,
 '2025-11-29 02:00:00', '2025-11-29 08:30:00', 'Scheduled'),


-- Turkish Airlines
(25, 'TK717', 25, 1,
 '2025-11-23 06:00:00', '2025-11-23 11:00:00', 'Boarding'),

(25, 'TK721', 25, 3,
 '2025-11-26 04:00:00', '2025-11-26 09:00:00', 'Boarding'),

(25, 'TK703', 25, 9,
 '2025-11-29 04:30:00', '2025-11-29 09:45:00', 'Scheduled'),

(25, 'TK999', 25, 10,
 '2025-11-30 05:00:00', '2025-11-30 10:00:00', 'Scheduled'),


-- Japan Airlines
(22, 'JL749', 22, 1,
 '2025-11-23 05:30:00', '2025-11-23 11:30:00', 'Scheduled'),

(22, 'JL752', 22, 3,
 '2025-11-26 06:00:00', '2025-11-26 12:00:00', 'Scheduled'),

(22, 'JL812', 22, 9,
 '2025-11-29 11:00:00', '2025-11-29 18:00:00', 'Scheduled'),

(22, 'JL404', 22, 10,
 '2025-11-30 09:30:00', '2025-11-30 16:00:00', 'Delayed'),


-- Air Canada
(26, 'AC43', 13, 1,
 '2025-11-23 08:00:00', '2025-11-23 20:00:00', 'Scheduled'),

(26, 'AC47', 13, 3,
 '2025-11-26 07:00:00', '2025-11-26 19:00:00', 'Landed'),

(26, 'AC57', 13, 9,
 '2025-11-29 06:00:00', '2025-11-29 18:30:00', 'Landed'),

(26, 'AC99', 13, 10,
 '2025-11-30 03:00:00', '2025-11-30 15:00:00', 'Landed');


-- =========================================================
-- 4. PASSENGERS TABLE
-- =========================================================

CREATE TABLE Passengers (
    Passenger_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50),
    Gender CHAR(1) CHECK (Gender IN ('M','F','O')),
    DOB DATE NOT NULL,
    Nationality VARCHAR(50),
    Passport_Number VARCHAR(20) UNIQUE,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

INSERT INTO Passengers
(First_Name, Last_Name, Gender, DOB, Nationality,
 Passport_Number, Email, Phone)
VALUES
('Aarav', 'Sharma', 'M', '2001-04-12', 'Indian',
 'IN9823451', 'aarav.sharma@example.com', '9876543210'),

('Vivaan', 'Mehta', 'M', '1999-07-22', 'Indian',
 'IN1283945', 'vivaan.mehta@example.com', '9876501234'),

('Diya', 'Kapoor', 'F', '2002-11-15', 'Indian',
 'IN9834521', 'diya.kapoor@example.com', '9876509876'),

('Myra', 'Singh', 'F', '1998-03-10', 'Indian',
 'IN9834112', 'myra.singh@example.com', '9876509988'),

('Reyansh', 'Verma', 'M', '2000-06-05', 'Indian',
 'IN9845123', 'reyansh.verma@example.com', '9876512345'),

('Ethan', 'Brown', 'M', '1995-12-18', 'American',
 'US8123456', 'ethan.brown@example.com', '2025550145'),

('Olivia', 'Davis', 'F', '1997-08-22', 'American',
 'US8234591', 'olivia.davis@example.com', '2025550198'),

('Liam', 'Wilson', 'M', '1996-02-11', 'American',
 'US8345129', 'liam.wilson@example.com', '2025550177'),

('Emma', 'Taylor', 'F', '1994-10-01', 'American',
 'US8456123', 'emma.taylor@example.com', '2025550133'),

('Noah', 'Anderson', 'M', '1993-05-19', 'American',
 'US8125674', 'noah.anderson@example.com', '2025550185'),

('Aiko', 'Tanaka', 'F', '1999-06-14', 'Japanese',
 'JP5634121', 'aiko.tanaka@example.jp', '819012345678'),

('Haruto', 'Sato', 'M', '1998-03-22', 'Japanese',
 'JP5734128', 'haruto.sato@example.jp', '819012346789'),

('Yui', 'Nakamura', 'F', '2001-12-25', 'Japanese',
 'JP5834512', 'yui.nakamura@example.jp', '819012347890'),

('Ren', 'Kobayashi', 'M', '1997-09-15', 'Japanese',
 'JP5934511', 'ren.kobayashi@example.jp', '819012349012'),

('Hana', 'Yamada', 'F', '1996-01-08', 'Japanese',
 'JP5034192', 'hana.yamada@example.jp', '819012341234'),

('Oliver', 'Smith', 'M', '1989-03-17', 'British',
 'UK1234098', 'oliver.smith@example.uk', '447123456780'),

('Amelia', 'Johnson', 'F', '1992-11-02', 'British',
 'UK2345098', 'amelia.johnson@example.uk', '447123456781'),

('George', 'Evans', 'M', '1991-05-28', 'British',
 'UK3456782', 'george.evans@example.uk', '447123456782'),

('Isla', 'Walker', 'F', '1993-09-19', 'British',
 'UK4567891', 'isla.walker@example.uk', '447123456783'),

('Harry', 'Harris', 'M', '1990-07-13', 'British',
 'UK5678912', 'harry.harris@example.uk', '447123456784'),

('Lucas', 'Martin', 'M', '1994-01-22', 'French',
 'FR9834123', 'lucas.martin@example.fr', '331654890123'),

('Louise', 'Bernard', 'F', '1997-06-11', 'French',
 'FR9745231', 'louise.bernard@example.fr', '331654892345'),

('Hugo', 'Petit', 'M', '1995-09-03', 'French',
 'FR9654132', 'hugo.petit@example.fr', '331654893210'),

('Camille', 'Robert', 'F', '1996-02-27', 'French',
 'FR9876541', 'camille.robert@example.fr', '331654894567'),

('Leo', 'Richard', 'M', '1993-08-14', 'French',
 'FR9543217', 'leo.richard@example.fr', '331654895678'),

('Mohammed', 'Al-Farsi', 'M', '1992-04-06', 'UAE',
 'AE7654321', 'mohammed.alfarsi@example.ae', '971501234567'),

('Aisha', 'Al-Nuaimi', 'F', '1997-10-21', 'UAE',
 'AE7543219', 'aisha.alnuaimi@example.ae', '971501234568'),

('Omar', 'Al-Suwaidi', 'M', '1998-07-12', 'UAE',
 'AE7432198', 'omar.suwaidi@example.ae', '971501234569'),

('Fatima', 'Al-Mazrouei', 'F', '2000-11-09', 'UAE',
 'AE7321984', 'fatima.almazrouei@example.ae', '971501234570'),

('Yousef', 'Al-Mansoori', 'M', '1996-01-15', 'UAE',
 'AE7219874', 'yousef.mansoori@example.ae', '971501234571'),

('Carlos', 'Rodriguez', 'M', '1988-03-16', 'Spanish',
 'ES9874512', 'carlos.rod@example.es', '349123456781'),

('Sofia', 'Garcia', 'F', '1990-07-28', 'Spanish',
 'ES9841239', 'sofia.garcia@example.es', '349123456782'),

('Mateo', 'Lopez', 'M', '1992-05-11', 'Spanish',
 'ES9812347', 'mateo.lopez@example.es', '349123456783'),

('Lucia', 'Sanchez', 'F', '1994-12-08', 'Spanish',
 'ES9741234', 'lucia.sanchez@example.es', '349123456784'),

('Diego', 'Perez', 'M', '1996-09-02', 'Spanish',
 'ES9642137', 'diego.perez@example.es', '349123456785'),

('Chen', 'Wei', 'M', '1987-05-17', 'Chinese',
 'CN7634512', 'chen.wei@example.cn', '8613812345678'),

('Mei', 'Hua', 'F', '1991-02-03', 'Chinese',
 'CN7543126', 'mei.hua@example.cn', '8613812345689'),

('Li', 'Jun', 'M', '1989-11-12', 'Chinese',
 'CN7432198', 'li.jun@example.cn', '8613812345690'),

('Xiao', 'Lan', 'F', '1993-07-20', 'Chinese',
 'CN7321984', 'xiao.lan@example.cn', '8613812345691'),

('Wang', 'Fang', 'M', '1994-04-01', 'Chinese',
 'CN7219873', 'wang.fang@example.cn', '8613812345692'),

('Kim', 'Min-Jun', 'M', '1997-03-30', 'Korean',
 'KR6754321', 'kim.minjun@example.kr', '821017654321'),

('Park', 'Seo-Yeon', 'F', '1999-09-18', 'Korean',
 'KR6643218', 'seo.yeon@example.kr', '821017654322'),

('Lee', 'Ji-Ho', 'M', '1996-06-05', 'Korean',
 'KR6532197', 'ji.ho@example.kr', '821017654323'),

('Choi', 'Hye-Jin', 'F', '1995-10-29', 'Korean',
 'KR6421983', 'hye.jin@example.kr', '821017654324'),

('Jung', 'Woo-Sik', 'M', '1994-01-19', 'Korean',
 'KR6319872', 'woo.sik@example.kr', '821017654325');


-- =========================================================
-- 5. TICKETS TABLE
-- =========================================================

CREATE TABLE Tickets (
    Ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
    Passenger_ID INT NOT NULL,
    Flight_ID INT NOT NULL,
    Seat_Number VARCHAR(10),

    Booking_Date DATE DEFAULT (CURRENT_DATE),

    Class VARCHAR(20)
        CHECK (Class IN ('Economy', 'Business', 'First')),

    Price DECIMAL(10,2)
        CHECK (Price >= 0),

    Payment_Status VARCHAR(20)
        DEFAULT 'Pending',

    FOREIGN KEY (Passenger_ID)
        REFERENCES Passengers(Passenger_ID),

    FOREIGN KEY (Flight_ID)
        REFERENCES Flights(Flight_ID)
);

INSERT INTO Tickets
(Passenger_ID, Flight_ID, Seat_Number, Booking_Date,
 Class, Price, Payment_Status)
VALUES
(1, 1, '12A', '2025-11-01', 'Economy', 4500.00, 'Confirmed'),
(2, 2, '14C', '2025-11-02', 'Economy', 5200.00, 'Confirmed'),
(3, 3, '08B', '2025-11-03', 'Economy', 4800.00, 'Confirmed'),
(4, 4, '16D', '2025-11-03', 'Economy', 6100.00, 'Confirmed'),
(5, 5, '22A', '2025-11-04', 'Economy', 3500.00, 'Cancelled'),
(6, 6, '19F', '2025-11-05', 'Economy', 5400.00, 'Confirmed'),
(7, 7, '10C', '2025-11-05', 'Economy', 5000.00, 'Confirmed'),
(8, 8, '07A', '2025-11-05', 'Economy', 6500.00, 'Confirmed'),
(9, 9, '09E', '2025-11-05', 'Economy', 4700.00, 'Confirmed'),
(10, 10, '11B', '2025-11-06', 'Economy', 4900.00, 'Confirmed'),

(11, 11, '18C', '2025-11-06', 'Economy', 5200.00, 'Confirmed'),
(12, 12, '03A', '2025-11-07', 'Economy', 5700.00, 'Confirmed'),
(13, 13, '05B', '2025-11-07', 'Economy', 3900.00, 'Cancelled'),
(14, 14, '21F', '2025-11-08', 'Economy', 7600.00, 'Confirmed'),
(15, 15, '14D', '2025-11-08', 'Economy', 4500.00, 'Confirmed'),

(16, 16, '06A', '2025-11-09', 'Economy', 5100.00, 'Confirmed'),
(17, 17, '12C', '2025-11-09', 'Economy', 5800.00, 'Confirmed'),
(18, 18, '15E', '2025-11-10', 'Economy', 6200.00, 'Confirmed'),
(19, 19, '02A', '2025-11-10', 'Economy', 6800.00, 'Confirmed'),
(20, 20, '17B', '2025-11-11', 'Economy', 5400.00, 'Confirmed'),

(21, 21, '20F', '2025-11-11', 'Economy', 4300.00, 'Confirmed'),
(22, 22, '24C', '2025-11-12', 'Economy', 5600.00, 'Confirmed'),
(23, 23, '13E', '2025-11-12', 'Economy', 4900.00, 'Confirmed'),
(24, 24, '04A', '2025-11-13', 'Economy', 7000.00, 'Confirmed'),
(25, 25, '01D', '2025-11-14', 'Economy', 7200.00, 'Confirmed');


-- =========================================================
-- 6. EMPLOYEES TABLE
-- =========================================================

CREATE TABLE Employees (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50),
    Gender CHAR(1) CHECK (Gender IN ('M','F','O')),
    DOB DATE,
    Role VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    Hire_Date DATE DEFAULT (CURRENT_DATE),
    Airport_ID INT,

    FOREIGN KEY (Airport_ID)
        REFERENCES Airports(Airport_ID)
);

INSERT INTO Employees
(First_Name, Last_Name, Gender, DOB, Role,
 Department, Salary, Hire_Date, Airport_ID)
VALUES
('Rahul', 'Sharma', 'M', '1985-03-15',
 'Pilot', 'Flight Operations', 120000.00, '2019-03-15', 1),

('Ananya', 'Mehta', 'F', '1990-07-21',
 'Co-Pilot', 'Flight Operations', 85000.00, '2020-07-21', 1),

('Karan', 'Singh', 'M', '1992-01-10',
 'Cabin Crew', 'In-Flight Service', 45000.00, '2021-01-10', 1),

('Priya', 'Iyer', 'F', '1993-09-05',
 'Cabin Crew', 'In-Flight Service', 46000.00, '2022-09-05', 1),

('Vikram', 'Nair', 'M', '1988-11-12',
 'Ground Staff', 'Airport Services', 38000.00, '2018-11-12', 1),

('Sanya', 'Kapoor', 'F', '1984-05-09',
 'Pilot', 'Flight Operations', 125000.00, '2017-05-09', 2),

('Mohit', 'Gupta', 'M', '1989-02-18',
 'Co-Pilot', 'Flight Operations', 83000.00, '2019-02-18', 2),

('Ritika', 'Arora', 'F', '1991-06-22',
 'Cabin Crew', 'In-Flight Service', 47000.00, '2021-06-22', 2),

('Arjun', 'Verma', 'M', '1987-10-03',
 'Security Officer', 'Security', 52000.00, '2020-10-03', 2),

('Dev', 'Rao', 'M', '1990-04-25',
 'Ground Staff', 'Airport Services', 39000.00, '2018-04-25', 2),

('Neha', 'Bajaj', 'F', '1986-08-30',
 'Pilot', 'Flight Operations', 118000.00, '2020-08-30', 3),

('Rohan', 'Malhotra', 'M', '1991-03-14',
 'Co-Pilot', 'Flight Operations', 82000.00, '2021-03-14', 3),

('Simran', 'Kaur', 'F', '1994-01-17',
 'Cabin Crew', 'In-Flight Service', 45500.00, '2022-01-17', 3),

('Aman', 'Saxena', 'M', '1989-05-11',
 'Technician', 'Maintenance', 60000.00, '2019-05-11', 3),

('Rita', 'Patel', 'F', '1990-12-08',
 'Ground Staff', 'Airport Services', 37000.00, '2017-12-08', 3),

('Harsh', 'Joshi', 'M', '1983-06-27',
 'Pilot', 'Flight Operations', 130000.00, '2018-06-27', 4),

('Isha', 'Desai', 'F', '1988-02-19',
 'Co-Pilot', 'Flight Operations', 84000.00, '2020-02-19', 4),

('Kabir', 'Sethi', 'M', '1992-09-14',
 'Cabin Crew', 'In-Flight Service', 49000.00, '2021-09-14', 4),

('Meera', 'Raghav', 'F', '1991-03-05',
 'Gate Agent', 'Passenger Service', 41000.00, '2018-03-05', 4),

('Aditya', 'Kulkarni', 'M', '1987-11-22',
 'Technician', 'Maintenance', 62000.00, '2019-11-22', 4),

('Suresh', 'Pillai', 'M', '1982-10-10',
 'Security Officer', 'Security', 55000.00, '2016-10-10', 1),

('Anjali', 'Chopra', 'F', '1980-04-01',
 'Manager', 'Operations', 95000.00, '2015-04-01', 2),

('Gautam', 'Reddy', 'M', '1981-12-18',
 'Manager', 'Maintenance', 98000.00, '2016-12-18', 3),

('Yash', 'Thakur', 'M', '1993-11-25',
 'Cabin Crew', 'In-Flight Service', 48000.00, '2022-11-25', 4),

('Sneha', 'Vasudev', 'F', '1992-05-07',
 'Ground Staff', 'Airport Services', 36500.00, '2021-05-07', 2);


-- =========================================================
-- 7. BAGGAGE TABLE
-- =========================================================

CREATE TABLE Baggage (
    Baggage_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ticket_ID INT NOT NULL,
    Weight DECIMAL(5,2) CHECK (Weight >= 0),
    Baggage_Tag VARCHAR(20) UNIQUE,
    Status VARCHAR(20) DEFAULT 'Checked-In',

    FOREIGN KEY (Ticket_ID)
        REFERENCES Tickets(Ticket_ID)
);

INSERT INTO Baggage
(Ticket_ID, Weight, Baggage_Tag, Status)
VALUES
(1, 18.50, 'BAG001', 'Loaded'),
(2, 22.00, 'BAG002', 'Loaded'),
(3, 7.20, 'BAG003', 'Cleared'),
(4, 16.00, 'BAG004', 'Loaded'),
(5, 6.50, 'BAG005', 'Cleared'),

(6, 19.30, 'BAG006', 'Loaded'),
(7, 23.00, 'BAG007', 'Loaded'),
(8, 8.00, 'BAG008', 'Cleared'),
(9, 20.50, 'BAG009', 'Loaded'),
(10, 5.80, 'BAG010', 'Cleared'),

(11, 17.60, 'BAG011', 'Loaded'),
(12, 21.00, 'BAG012', 'Loaded'),
(13, 9.10, 'BAG013', 'Cleared'),
(14, 18.00, 'BAG014', 'Loaded'),
(15, 7.70, 'BAG015', 'Cleared'),

(16, 24.50, 'BAG016', 'Loaded'),
(17, 19.80, 'BAG017', 'Loaded'),
(18, 6.90, 'BAG018', 'Cleared'),
(19, 22.30, 'BAG019', 'Loaded'),
(20, 8.40, 'BAG020', 'Cleared'),

(21, 15.20, 'BAG021', 'Loaded'),
(22, 23.70, 'BAG022', 'Loaded'),
(23, 7.00, 'BAG023', 'Cleared'),
(24, 18.90, 'BAG024', 'Loaded'),
(25, 9.50, 'BAG025', 'Cleared');


-- =========================================================
-- DISPLAY ALL TABLES
-- =========================================================

SELECT * FROM Airlines;

SELECT * FROM Airports;

SELECT * FROM Flights;

SELECT * FROM Passengers;

SELECT * FROM Tickets;

SELECT * FROM Employees;

SELECT * FROM Baggage;


-- =========================================================
-- DISPLAY TABLE STRUCTURES
-- =========================================================

SHOW COLUMNS FROM Airlines;

SHOW COLUMNS FROM Airports;

SHOW COLUMNS FROM Flights;

SHOW COLUMNS FROM Passengers;

SHOW COLUMNS FROM Tickets;

SHOW COLUMNS FROM Employees;

SHOW COLUMNS FROM Baggage;


-- =========================================================
-- SEARCH / ANALYTICAL QUERIES
-- =========================================================


-- =========================================================
-- #1 AIRPORTS WITH MOST DEPARTING FLIGHTS
-- =========================================================

SELECT
    a.Airport_Name,
    a.City,
    a.Country,
    COUNT(f.Flight_ID) AS Total_Departing_Flights
FROM Airports a
JOIN Flights f
    ON a.Airport_ID = f.Source_Airport_ID
GROUP BY
    a.Airport_ID,
    a.Airport_Name,
    a.City,
    a.Country
ORDER BY Total_Departing_Flights DESC;


-- =========================================================
-- #2 TOP 5 FLIGHTS BY REVENUE
-- =========================================================

SELECT
    f.Flight_Number,
    al.Airline_Name,
    CONCAT(dep.City, ' → ', arr.City) AS Route,
    SUM(t.Price) AS Total_Revenue,
    COUNT(t.Ticket_ID) AS Tickets_Sold
FROM Flights f
JOIN Airlines al
    ON f.Airline_ID = al.Airline_ID
JOIN Airports dep
    ON f.Source_Airport_ID = dep.Airport_ID
JOIN Airports arr
    ON f.Destination_Airport_ID = arr.Airport_ID
JOIN Tickets t
    ON f.Flight_ID = t.Flight_ID
WHERE t.Payment_Status = 'Confirmed'
GROUP BY
    f.Flight_ID,
    f.Flight_Number,
    al.Airline_Name,
    dep.City,
    arr.City
ORDER BY Total_Revenue DESC
LIMIT 5;


-- =========================================================
-- #3 TOP 10 PASSENGERS BY TOTAL FLIGHTS
-- =========================================================

SELECT
    p.Passenger_ID,
    CONCAT(p.First_Name, ' ', p.Last_Name) AS Passenger_Name,
    p.Nationality,
    COUNT(t.Ticket_ID) AS Total_Flights,
    COUNT(DISTINCT t.Flight_ID) AS Unique_Flights,
    SUM(t.Price) AS Total_Spent
FROM Passengers p
JOIN Tickets t
    ON p.Passenger_ID = t.Passenger_ID
WHERE t.Payment_Status = 'Confirmed'
GROUP BY
    p.Passenger_ID,
    p.First_Name,
    p.Last_Name,
    p.Nationality
ORDER BY Total_Flights DESC
LIMIT 10;


-- =========================================================
-- #4 FIND DELAYED FLIGHTS
-- =========================================================

SELECT
    f.Flight_Number,
    al.Airline_Name,
    CONCAT(dep.City, ' → ', arr.City) AS Route,
    f.Departure_Time,
    f.Status
FROM Flights f
JOIN Airlines al
    ON f.Airline_ID = al.Airline_ID
JOIN Airports dep
    ON f.Source_Airport_ID = dep.Airport_ID
JOIN Airports arr
    ON f.Destination_Airport_ID = arr.Airport_ID
WHERE f.Status = 'Delayed';


-- =========================================================
-- #5 AIRLINE-WISE FLIGHT STATUS AND DELAY PERCENTAGE
-- =========================================================

SELECT
    al.Airline_Name,
    al.Country,

    COUNT(f.Flight_ID) AS Total_Flights,

    SUM(
        CASE
            WHEN f.Status = 'Delayed' THEN 1
            ELSE 0
        END
    ) AS Delayed_Flights,

    SUM(
        CASE
            WHEN f.Status = 'Scheduled' THEN 1
            ELSE 0
        END
    ) AS Scheduled_Flights,

    SUM(
        CASE
            WHEN f.Status = 'Landed' THEN 1
            ELSE 0
        END
    ) AS Landed_Flights,

    SUM(
        CASE
            WHEN f.Status = 'Boarding' THEN 1
            ELSE 0
        END
    ) AS Boarding_Flights,

    ROUND(
        (
            SUM(
                CASE
                    WHEN f.Status = 'Delayed' THEN 1
                    ELSE 0
                END
            ) / COUNT(*)
        ) * 100,
        2
    ) AS Delay_Percentage

FROM Airlines al
JOIN Flights f
    ON al.Airline_ID = f.Airline_ID

GROUP BY
    al.Airline_ID,
    al.Airline_Name,
    al.Country

ORDER BY Delay_Percentage DESC;