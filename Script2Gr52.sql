USE HOSPITAL_MANAGEMENT_SYSTEM;

# Hospital Management System Database Queries 
select * from Department;
select * from Patient;
select * from Doctor;
select * from Appointment;
select * from MedicalRecord;
select * from Prescription;
select * from Billing;

#1 A query to retrieve the names of patients with pending payments, the names of the doctors who attended to them, the appointment dates, the reasons for their visits, and their next appointment dates

SELECT 
    p.Full_Name AS Patient,
    d.Doctor_Name AS Doctor,
    DATE_FORMAT(a.Appointment_Date, '%Y-%m-%d') AS Appointment_Date,
    a.Reason AS Visit_Reason,
    (SELECT MIN(a2.Appointment_Date) 
     FROM Appointment a2 
     WHERE a2.Patient_ID = p.Patient_ID 
     AND a2.Appointment_Date > CURRENT_DATE()) AS Next_Appointment_Date
FROM 
    Patient p
JOIN 
    Appointment a ON p.Patient_ID = a.Patient_ID
JOIN 
    Doctor d ON a.Doctor_ID = d.Doctor_ID
JOIN 
    Billing b ON a.Appointment_ID = b.Appointment_ID
WHERE 
    b.Payment_Status = 'Pending'
ORDER BY 
    p.Full_Name, a.Appointment_Date
LIMIT 0, 1000;

#2 Calculate the revenue contribution of each department as a percentage of the total hospital revenue.

 SELECT 
    dept.Department_Name,
    CONCAT('N', FORMAT(SUM(b.Amount), 2)) AS Total_Revenue,
    CONCAT(ROUND((SUM(b.Amount) * 100 / (SELECT SUM(Amount) FROM Billing WHERE Payment_Status = 'Paid')), 2), '%') AS Revenue_Percentage
FROM Department dept
LEFT JOIN Doctor d ON dept.Department_Name = d.Department_Name
LEFT JOIN Appointment a ON d.Doctor_ID = a.Doctor_ID
LEFT JOIN Billing b ON a.Appointment_ID = b.Appointment_ID
WHERE b.Payment_Status = 'Paid'
GROUP BY dept.Department_Name
ORDER BY Total_Revenue DESC;

# Analyze the distribution of visit reasons across different age groups (e.g., 0-18, 19-35, 36-50, 51+

SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, p.Birth_Date, CURDATE()) <= 18 THEN '0-18'
        WHEN TIMESTAMPDIFF(YEAR, p.Birth_Date, CURDATE()) BETWEEN 19 AND 35 THEN '19-35'
        WHEN TIMESTAMPDIFF(YEAR, p.Birth_Date, CURDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END AS Age_Group,
    a.Reason AS Visit_Reason,
    COUNT(a.Appointment_ID) AS Count
FROM 
    Appointment a
JOIN 
    Patient p ON a.Patient_ID = p.Patient_ID
GROUP BY 
    Age_Group, a.Reason
ORDER BY 
    Age_Group, Count DESC;
    
    #4 Generate a detailed report of all prescriptions issued
    
    SELECT 
        p.Full_Name AS Patient,
        pr.Medication_Name AS Medication,
        pr.Dosage,
        pr.Frequency,
        pr.Duration,
        DATE_FORMAT(a.Appointment_Date, '%Y-%m-%d') AS Visit_Date,
        d.Doctor_Name AS Prescribed_By
    FROM Prescription pr
    JOIN Appointment a ON pr.Appointment_ID = a.Appointment_ID
    JOIN Patient p ON a.Patient_ID = p.Patient_ID
    JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
    WHERE a.Appointment_Date BETWEEN '2023-11-01' AND '2023-11-07'
    ORDER BY p.Full_Name, pr.Medication_Name;
    
    #5 Generate a report that analyzes revenue based on the payment methods used in the hospital
    
    SELECT 
        Payment_Method,
        COUNT(*) AS Transaction_Count,
        CONCAT('N', FORMAT(SUM(Amount), 2)) AS Total_Amount,
        CONCAT('N', FORMAT(AVG(Amount), 2)) AS Average_Amount,
        CONCAT(ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM Billing), 0), '%') AS Percentage
    FROM Billing
    GROUP BY Payment_Method
    ORDER BY Total_Amount DESC;