-- Table Creation
CREATE TABLE Passengers
(
Passenger_id INT AUTO_INCREMENT PRIMARY KEY,
First_name VARCHAR(50),
Last_name VARCHAR(50),
Gender VARCHAR(50),
Age INT,
Nationality TEXT
);

CREATE TABLE Airport
(
Airport_id INT AUTO_INCREMENT PRIMARY KEY,
Airport_name VARCHAR(50),
Airport_country_code VARCHAR(50),
Country_name VARCHAR(50),
Airport_continent VARCHAR(50),
Continents VARCHAR(50)
);

CREATE TABLE Flights
(
Flight_id INT AUTO_INCREMENT PRIMARY KEY,
Passenger_id INT,
Airport_id INT,
Departure_date DATE,
Arrival_airport VARCHAR(50),
Pilot_name VARCHAR(50),
Flight_status VARCHAR(50),
FOREIGN KEY (Passenger_id) REFERENCES Passengers (Passenger_id),
FOREIGN KEY (Airport_id) REFERENCES Airport (Airport_id)
);

-- Import tables from file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/passengers.csv'
INTO TABLE passengers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/airport.csv'
INTO TABLE airport
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/flights.csv'
INTO TABLE flights
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

-- Cleaning Step
-- Checking for missing values
SELECT 
    SUM(CASE WHEN passenger_id IS NULL THEN 1 ELSE 0 END) AS passenger_id_nulls,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS first_name_nulls,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS last_name_nulls,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_nulls,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_nulls,
    SUM(CASE WHEN Nationality IS NULL THEN 1 ELSE 0 END) AS Nationality_nulls
FROM passengers;

SELECT 
    SUM(CASE WHEN airport_name IS NULL THEN 1 ELSE 0 END) AS airport_name_nulls,
    SUM(CASE WHEN airport_country_code IS NULL THEN 1 ELSE 0 END) AS airport_country_code_nulls,
    SUM(CASE WHEN country_name IS NULL THEN 1 ELSE 0 END) AS country_name_nulls,
    SUM(CASE WHEN airport_continent IS NULL THEN 1 ELSE 0 END) AS airport_continent_nulls,
    SUM(CASE WHEN Continents IS NULL THEN 1 ELSE 0 END) AS Continents_nulls
FROM airport;

SELECT
    SUM(CASE WHEN departure_date IS NULL THEN 1 ELSE 0 END) AS departure_date_nulls,
    SUM(CASE WHEN arrival_airport IS NULL THEN 1 ELSE 0 END) AS arrival_airport_nulls,
    SUM(CASE WHEN pilot_name IS NULL THEN 1 ELSE 0 END) AS pilot_name_nulls,
    SUM(CASE WHEN flight_status IS NULL THEN 1 ELSE 0 END) AS flight_status_nulls
FROM flights;

-- Feature Engineering
ALTER TABLE flights ADD COLUMN flight_year INT;
ALTER TABLE flights ADD COLUMN flight_month INT;
ALTER TABLE flights ADD COLUMN flight_day INT;

UPDATE flights SET flight_year = YEAR(Departure_date);
UPDATE flights SET flight_month = MONTH(Departure_date);
UPDATE flights SET flight_day = DAY(Departure_date);


SELECT COUNT(*) FROM Passengers;
SELECT COUNT(*) FROM Airport;
SELECT COUNT(*) FROM Flights;


UPDATE passengers SET Nationality = REPLACE(Nationality, '\r', '');	
UPDATE airport SET Continents = REPLACE(Continents, '\r', '');	
UPDATE flights SET Flight_status = REPLACE(Flight_status, '\r', '');	

SELECT Nationality, HEX(Nationality) FROM passengers WHERE Nationality LIKE '%\r%';
SELECT Continents, HEX(Continents) FROM airport WHERE Continents LIKE '%\r%';
SELECT Flight_status, HEX(Flight_status) FROM flights WHERE Flight_status LIKE '%\r%';

