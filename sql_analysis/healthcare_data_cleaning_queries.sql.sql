SELECT * FROM patient_records LIMIT 10;

ALTER TABLE patient_records RENAME COLUMN "Name" TO name;
ALTER TABLE patient_records RENAME COLUMN "Age" TO age;
ALTER TABLE patient_records RENAME COLUMN "Gender" TO gender;
ALTER TABLE patient_records RENAME COLUMN "Blood Type" TO blood_type;
ALTER TABLE patient_records RENAME COLUMN "Medical Condition" TO medical_condition;
ALTER TABLE patient_records RENAME COLUMN "Date of Admission" TO date_of_admission;
ALTER TABLE patient_records RENAME COLUMN "Doctor" TO doctor;
ALTER TABLE patient_records RENAME COLUMN "Hospital" TO hospital;
ALTER TABLE patient_records RENAME COLUMN "Insurance Provider" TO insurance_provider;
ALTER TABLE patient_records RENAME COLUMN "Billing Amount" TO billing_amount;
ALTER TABLE patient_records RENAME COLUMN "Room Number" TO room_number;
ALTER TABLE patient_records RENAME COLUMN "Admission Type" TO admission_type;
ALTER TABLE patient_records RENAME COLUMN "Discharge Date" TO discharge_date;
ALTER TABLE patient_records RENAME COLUMN "Medication" TO medication;
ALTER TABLE patient_records RENAME COLUMN "Test Results" TO test_results;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'patient_records'
ORDER BY ordinal_position;

ALTER TABLE patient_records
ALTER COLUMN date_of_admission TYPE DATE
USING TO_DATE(date_of_admission, 'MM/DD/YYYY');

ALTER TABLE patient_records
ALTER COLUMN discharge_date TYPE DATE
USING TO_DATE(discharge_date, 'MM/DD/YYYY');

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'patient_records'
AND column_name IN ('date_of_admission', 'discharge_date');
