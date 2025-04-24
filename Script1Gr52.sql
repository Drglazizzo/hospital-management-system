CREATE DATABASE HOSPITAL_MANAGEMENT_SYSTEM;

USE HOSPITAL_MANAGEMENT_SYSTEM;

-- DEPARTMENT TABLE CREATION
CREATE TABLE Department (
    Department_Name VARCHAR(255) PRIMARY KEY,
    Location VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(15)
);

-- PATIENT TABLE CREATION
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Full_Name VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Birth_Date DATE NOT NULL,
    Phone_Number VARCHAR(15),
    Home_Address VARCHAR(255),
    ID_Card_Number VARCHAR(20)
);

-- DOCTOR TABLE CREATION
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Department_Name VARCHAR(255) NOT NULL,
    Professional_Title VARCHAR(50),
    Specialty VARCHAR(255) NOT NULL,
    Contact_Number VARCHAR(15),
    Email_Address VARCHAR(255),
    FOREIGN KEY (Department_Name) REFERENCES Department(Department_Name)
);

-- APPOINTMENT TABLE CREATION
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE
);

-- MEDICAL RECORD TABLE CREATION
CREATE TABLE MedicalRecord (
    Record_ID INT PRIMARY KEY,
    Doctor_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    Diagnosis TEXT NOT NULL,
    Treatment TEXT,
    Record_Date DATE NOT NULL,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE
);

-- PRESCRIPTION TABLE CREATION
CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Appointment_ID INT NOT NULL,
    Medication_Name VARCHAR(255) NOT NULL,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID) ON DELETE CASCADE
);

-- BILLING TABLE CREATION
CREATE TABLE Billing (
    Billing_ID INT PRIMARY KEY,
    Appointment_ID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Billing_Date DATE NOT NULL,
    Payment_Status ENUM('Paid', 'Pending', 'Cancelled') NOT NULL DEFAULT 'Pending',
    Payment_Method ENUM('Cash', 'Card', 'Insurance') NOT NULL,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- DEPARTMENT DATA (7 records)
INSERT INTO Department VALUES
('Cardiology', 'Building A, Floor 2', '08051122334'),
('Neurology', 'Building B, Floor 3', '08062233445'),
('Pediatrics', 'Building C, Ground Floor', '08073344556'),
('Orthopedics', 'Building D, Floor 1', '08084455667'),
('Radiology', 'Building E, Basement', '08095566778'),
('Dermatology', 'Building F, Floor 4', '08106677889'),
('Gastroenterology', 'Building G, Floor 5', '08117788990');

-- PATIENT DATA (7 records)
INSERT INTO Patient VALUES
(10001, 'Chinonso Ugwu', 'Male', '1985-06-15', '08031234567', '45 Owerri Street', 'A12345678'),
(10002, 'Adaobi Nwankwo', 'Female', '1990-03-22', '08149876543', '12 Aba Road', 'B23456789'),
(10003, 'Chidinma Okoro', 'Female', '1978-11-10', '09023456789', '8 Akwa Ibom Avenue', 'C34567890'),
(10004, 'Emeka Okafor', 'Male', '1982-07-25', '08065432109', '10 Awka Road', 'D45678901'),
(10005, 'Amara Eze', 'Female', '1995-02-14', '08176543210', '5 Onitsha Lane', 'E56789012'),
(10006, 'Ifeanyi Nnamdi', 'Male', '1970-09-18', '08087654321', '3 Enugu Crescent', 'F67890123'),
(10007, 'Chioma Obi', 'Female', '1988-12-03', '09098765432', '15 Aba Close', 'G78901234');

-- DOCTOR DATA (7 records)
INSERT INTO Doctor VALUES
(20001, 'Dr. Obinna Eze', 'Male', 'Cardiology', 'Consultant', 'Cardiologist', '08034567890', 'obinna.eze@unth.edu'),
(20002, 'Dr. Ngozi Okonkwo', 'Female', 'Neurology', 'Senior Consultant', 'Neurologist', '08056789012', 'ngozi.okonkwo@unth.edu'),
(20003, 'Dr. Chinedu Okafor', 'Male', 'Orthopedics', 'Consultant', 'Orthopedic Surgeon', '08067890123', 'chinedu.okafor@unth.edu'),
(20004, 'Dr. Ada Nwosu', 'Female', 'Pediatrics', 'Senior Registrar', 'Pediatrician', '08078901234', 'ada.nwosu@unth.edu'),
(20005, 'Dr. Uche Ogbonna', 'Male', 'Radiology', 'Consultant', 'Radiologist', '08089012345', 'uche.ogbonna@unth.edu'),
(20006, 'Dr. Chinwe Ani', 'Female', 'Dermatology', 'Consultant', 'Dermatologist', '08090123456', 'chinwe.ani@unth.edu'),
(20007, 'Dr. Ekene Okeke', 'Male', 'Gastroenterology', 'Senior Consultant', 'Gastroenterologist', '08101234567', 'ekene.okeke@unth.edu');

-- APPOINTMENT DATA (7 records)
INSERT INTO Appointment VALUES
(30001, 10001, 20001, '2023-11-01 10:00:00', 'Hypertension follow-up', 'Completed'),
(30002, 10002, 20002, '2023-11-02 11:30:00', 'Chronic headaches evaluation', 'Completed'),
(30003, 10003, 20003, '2023-11-03 14:00:00', 'Knee pain assessment', 'Scheduled'),
(30004, 10004, 20004, '2023-11-04 09:15:00', 'Child wellness checkup', 'Completed'),
(30005, 10005, 20005, '2023-11-05 13:45:00', 'X-ray for suspected fracture', 'Scheduled'),
(30006, 10006, 20006, '2023-11-06 16:00:00', 'Skin rash examination', 'Completed'),
(30007, 10007, 20007, '2023-11-07 10:30:00', 'Stomach pain diagnosis', 'Scheduled');

-- MEDICAL RECORD DATA (7 records)
INSERT INTO MedicalRecord VALUES
(40001, 20001, 10001, 'Hypertension Stage 1', 'Prescribed Amlodipine 5mg daily', '2023-11-01'),
(40002, 20002, 10002, 'Migraine with aura', 'Recommended lifestyle changes and pain management', '2023-11-02'),
(40003, 20003, 10003, 'Osteoarthritis of knee', 'Suggested physiotherapy and joint supplements', '2023-11-03'),
(40004, 20004, 10004, 'Pediatric viral infection', 'Advised rest and fluids', '2023-11-04'),
(40005, 20005, 10005, 'Suspected wrist fracture', 'Ordered X-ray imaging', '2023-11-05'),
(40006, 20006, 10006, 'Contact dermatitis', 'Prescribed topical corticosteroids', '2023-11-06'),
(40007, 20007, 10007, 'Acute gastritis', 'Recommended antacids and dietary changes', '2023-11-07');

-- PRESCRIPTION DATA (7 records)
INSERT INTO Prescription VALUES
(50001, 30001, 'Amlodipine', '5mg tablet', 'Once daily', '30 days'),
(50002, 30002, 'Sumatriptan', '50mg tablet', 'As needed for migraine', '10 doses'),
(50003, 30003, 'Ibuprofen', '400mg tablet', 'Every 8 hours with food', '7 days'),
(50004, 30004, 'Paracetamol', '120mg/5ml suspension', '5ml every 6 hours', '5 days'),
(50005, 30005, 'Diclofenac', '50mg tablet', 'Twice daily after meals', '10 days'),
(50006, 30006, 'Hydrocortisone', '1% cream', 'Apply to affected area twice daily', '14 days'),
(50007, 30007, 'Omeprazole', '20mg capsule', 'Once daily before breakfast', '28 days');

-- BILLING DATA (7 records)
INSERT INTO Billing VALUES
(60001, 30001, 5000.00, '2023-11-01', 'Paid', 'Insurance'),
(60002, 30002, 7500.00, '2023-11-02', 'Paid', 'Card'),
(60003, 30003, 12000.00, '2023-11-03', 'Pending', 'Cash'),
(60004, 30004, 3000.00, '2023-11-04', 'Paid', 'Insurance'),
(60005, 30005, 10000.00, '2023-11-05', 'Pending', 'Cash'),
(60006, 30006, 8000.00, '2023-11-06', 'Paid', 'Insurance'),
(60007, 30007, 15000.00, '2023-11-07', 'Pending', 'Card');

