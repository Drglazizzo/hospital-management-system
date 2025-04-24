Hospital Management System project

```markdown
# Hospital Management System Database

![Database Schema](https://img.shields.io/badge/Database-MySQL-blue)

A comprehensive relational database system for the Nigeria Teaching Hospital, Enugu (NTH) designed to automate healthcare operations and improve patient care coordination.

## 📁 Project Structure

```
hospital-management-system/
├── Report01Gr52.pdf             # Complete project documentation
├── Script1Gr52.sql              # Database schema creation script
├── Script2Gr52.sql              # Sample data population & queries
└── README.md                    # This file
```

## 🏥 Database Schema

### Core Entities
- **Patient**: Demographic and contact information
- **Doctor**: Professional details and specialties
- **Department**: Clinical divisions and locations
- **Appointment**: Scheduled consultations
- **MedicalRecord**: Diagnosis and treatment documentation
- **Prescription**: Medication management
- **Billing**: Financial transactions

### Key Relationships
![ER Diagram](Report01Gr52.pdf) (See page 5-7 for diagrams)

## 🛠️ Setup Instructions

1. **Create Database**:
   ```sql
   mysql -u username -p
   CREATE DATABASE HOSPITAL_MANAGEMENT_SYSTEM;
   USE HOSPITAL_MANAGEMENT_SYSTEM;
   SOURCE Script1Gr52.sql;
   ```

2. **Populate Sample Data**:
   ```sql
   SOURCE Script2Gr52.sql;
   ```

3. **Verify Installation**:
   ```sql
   SELECT * FROM Patient LIMIT 5;
   ```

## 📊 Sample Queries

1. Patients with pending payments:
   ```sql
   SELECT p.Full_Name, b.Amount 
   FROM Patient p
   JOIN Appointment a ON p.Patient_ID = a.Patient_ID
   JOIN Billing b ON a.Appointment_ID = b.Appointment_ID
   WHERE b.Payment_Status = 'Pending';
   ```

2. Department revenue analysis:
   ```sql
   SELECT d.Department_Name, SUM(b.Amount) AS Revenue
   FROM Department d
   JOIN Doctor dr ON d.Department_Name = dr.Department_Name
   JOIN Appointment a ON dr.Doctor_ID = a.Doctor_ID
   JOIN Billing b ON a.Appointment_ID = b.Appointment_ID
   GROUP BY d.Department_Name;
   ```

## 📄 Documentation
Full project details including:
- Entity-Relationship Diagrams
- Business rules and constraints
- Sample query results
- Implementation scripts

[View Complete Report](Report01Gr52.pdf)

## 👥 Group 52
Database and Data Mining Technologies Project  
April 14, 2025
```

Key changes made:
1. Removed all license-related content including:
   - License badge from the header
   - LICENSE file from project structure
   - Entire license section at the bottom

2. Fixed the sample queries to match your actual database schema (added proper joins through Appointment table)

3. Kept all other professional formatting and useful information

To implement:
1. Create a new `README.md` file in your project root
2. Paste this content
3. Commit and push:
```bash
git add README.md
git commit -m "Add license-free README"
git push
```
