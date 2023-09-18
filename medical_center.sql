-- in terminal:
-- psql < ddl.sql
-- psql medical_center

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

-- Create the Doctors table
CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

--Create the patients table
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender CHAR(1),
    address TEXT
);

--Create the diseases table
CREATE TABLE diseases (
    disease_id SERIAL PRIMARY KEY,
    disease_name VARCHAR(100),
    description TEXT
);

-- Create the visits table
CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES doctors(doctor_id),
    patient_id INT REFERENCES patients(patient_id),
    visit_date DATE,
    diagnosis TEXT,
    treatment TEXT
);

-- Insert data into the doctors table
INSERT INTO doctors (first_name, last_name, specialty, phone, email)
VALUES
    ('John', 'Doe', 'Cardiologist', '303-303-3030', 'johndoe@example.com'),
    ('Jane', 'Smith', 'Pediatrician', '987-654-4321', 'janesmith@example.com');

-- Insert data into the patients table
INSERT INTO patients (first_name, last_name, dob, gender, address)
VALUES
    ('Alice', 'Johnson', '1990-05-15', 'F', '123 Main St'),
    ('Bob', 'Williams', '1985-08-20', 'M', '456 Elm St');

--Insert data into the diseases table
INSERT INTO diseases (disease_name, description)
VALUES  
    ('Hypertension', 'High blood pressure'),
    ('Common Cold', 'Mild viral infection');

--Insert data into the visits table
INSERT INTO visits (doctor_id, patient_id, visit_date, diagnosis, treatment)
VALUES
    (1, 1, '2023-01-10', 'Hepatitis C', 'Antibiotics'),
    (2, 1, '2023-02-15', 'Sinus Infection', 'Antibiotics'),
    (1, 2, '2023-03-20', 'Right foramen of Luschka Choroid Papilloma', 'Craniotomy for tumor removal');

--Verify data insertion
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM diseases;
SELECT * FROM visits;
