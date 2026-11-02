//SAMPLE DADA INSERTION
SET SERVEROUTPUT ON;
-- 1. INSERT SAMPLE PATIENTS
INSERT INTO patients
(first_name, last_name, date_of_birth, gender, phone, email)
SELECT 'Jean', 'Niyonzima', DATE '1998-04-12',
       'Male', '+250788111111', 'jean.niyonzima@gmail.com'
FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM patients
    WHERE email = 'jean.niyonzima@gmail.com'
);

INSERT INTO patients
(first_name, last_name, date_of_birth, gender, phone, email)
SELECT 'Aline', 'Uwase', DATE '2000-09-20',
       'Female', '+250788222222', 'aline.uwase@gmail.com'
FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM patients
    WHERE email = 'aline.uwase@gmail.com'
);

-- 2. INSERT SAMPLE DOCTORS

INSERT INTO doctors
(first_name, last_name, specialty, phone, email)
SELECT 'Peter', 'Mugisha', 'Cardiology',
       '+250788333333', 'peter.cardiology@gmail.com'
FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM doctors
    WHERE email = 'peter.cardiology@gmail.com'
);

INSERT INTO doctors
(first_name, last_name, specialty, phone, email)
SELECT 'Grace', 'Mukamana', 'Pediatrics',
       '+250788444444', 'grace.pediatrics@gmail.com'
FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM doctors
    WHERE email = 'grace.pediatrics@gmail.com'
);

INSERT INTO doctors
(first_name, last_name, specialty, phone, email)
SELECT 'David', 'Habimana', 'Dermatology',
       '+250788555555', 'david.dermatology@gmail.com'
FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM doctors
    WHERE email = 'david.dermatology@gmail.com'
);

-- 3. INSERT SAMPLE APPOINTMENTS

INSERT INTO appointments
(patient_id, doctor_id, APPOINTMENT_DATETIME, status)
SELECT p.patient_id, d.doctor_id,
       SYSDATE + 2, 'SCHEDULED'
FROM patients p
CROSS JOIN doctors d
WHERE p.email = 'jean.niyonzima@gmail.com'
  AND d.email = 'peter.cardiology@gmail.com'
  AND NOT EXISTS (
      SELECT 1 FROM appointments a
      WHERE a.patient_id = p.patient_id
        AND a.doctor_id = d.doctor_id
        AND a.status = 'SCHEDULED'
  );

INSERT INTO appointments
(patient_id, doctor_id, APPOINTMENT_DATETIME, status)
SELECT p.patient_id, d.doctor_id,
       SYSDATE + 3, 'SCHEDULED'
FROM patients p
CROSS JOIN doctors d
WHERE p.email = 'aline.sample@example.com'
  AND d.email = 'grace.pediatrics@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM appointments a
      WHERE a.patient_id = p.patient_id
        AND a.doctor_id = d.doctor_id
        AND a.status = 'SCHEDULED'
  );

INSERT INTO appointments
(patient_id, doctor_id, APPOINTMENT_DATETIME, status)
SELECT p.patient_id, d.doctor_id,
       SYSDATE + 5, 'COMPLETED'
FROM patients p
CROSS JOIN doctors d
WHERE p.email = 'jean.sample@example.com'
  AND d.email = 'david.dermatology@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM appointments a
      WHERE a.patient_id = p.patient_id
        AND a.doctor_id = d.doctor_id
        AND a.status = 'COMPLETED'
  );

INSERT INTO appointments
(patient_id, doctor_id, APPOINTMENT_DATETIME, status)
SELECT p.patient_id, d.doctor_id,
       SYSDATE + 7, 'CANCELLED'
FROM patients p
CROSS JOIN doctors d
WHERE p.email = 'aline.sample@example.com'
  AND d.email = 'peter.cardiology@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM appointments a
      WHERE a.patient_id = p.patient_id
        AND a.doctor_id = d.doctor_id
        AND a.status = 'CANCELLED'
  );



COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Sample data insertion process completed.'
    );
END;
/
