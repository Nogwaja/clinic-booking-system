-- Clinic Booking System - SQL Schema
-- Author: [Your Name]
-- Description: This SQL script creates a relational database
--              for managing patients, doctors, appointments,
--              treatments, and specializations in a clinic.

--Drop tables in correct order to avoid FK errors
DROP TABLE IF EXISTS Appointment_Treatments;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Specializations;

-- Table: Specializations
-- Description: Stores doctor specialties
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 
--Table: Doctors
-- Description: Stores doctor information
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- 
-- Table: Patients
-- Description: Stores patient information

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE
);

-- Table: Appointments
-- Description: Links doctors and patients
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Table: Treatments
-- Description: Stores treatment types
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- Table: Appointment_Treatments (Join Table)
-- Description: Many-to-many relationship between
--              Appointments and Treatments

CREATE TABLE Appointment_Treatments (
    appointment_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
