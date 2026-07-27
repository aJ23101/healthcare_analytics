--Q1 What is the average billing amount by admission type?
SELECT admission_type, AVG(billing_amount)AS avg_billing FROM patient_records GROUP BY admission_type ORDER BY avg_billing DESC;

--Q2 Which hospitals handle the most patients?
SELECT hospital,COUNT(*) AS total_patients FROM patient_records GROUP BY hospital ORDER BY total_patients DESC LIMIT 5;

--Q3 Which insurance providers cover the highest number of patients?
SELECT insurance_provider,COUNT(*) AS total_patients FROM patient_records GROUP BY insurance_provider ORDER BY total_patients DESC;

--Q4 What is the average billing amount per length of stay?
SELECT AVG(billing_amount / NULLIF(discharge_date - date_of_admission, 0))AS avg_cost_per_day FROM patient_records;

--Q5 What is the average billing amount by age group?
SELECT CASE WHEN age < 20 THEN '0-19' WHEN age BETWEEN 20 AND 40 THEN '20-40' WHEN age BETWEEN 41 AND 60 THEN '41-60' ELSE '60+'
END AS age_group,AVG(billing_amount) AS avg_billing FROM patient_records GROUP BY age_group ORDER BY age_group;

--Q6 Top 5 highest individual billing records?
SELECT name, billing_amount FROM patient_records ORDER BY billing_amount DESC LIMIT 5;

--Q7 Rank hospitals by revenue
WITH hospital_revenue AS (SELECT hospital, SUM(billing_amount) AS total_revenue FROM patient_records GROUP BY hospital)
SELECT *, RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank FROM hospital_revenue;

--Q8 Top patients per hospital
SELECT * FROM (SELECT hospital, name, billing_amount, RANK() OVER (PARTITION BY hospital ORDER BY billing_amount DESC) AS rank
FROM patient_records) ranked WHERE rank <= 3;

--Q9 Identify high-cost patients?
SELECT * FROM patient_records WHERE billing_amount > (SELECT AVG(billing_amount)FROM patient_records);

--Q10 Running total of revenue over time
SELECT date_of_admission, SUM(billing_amount) AS daily_revenue,SUM(SUM(billing_amount)) OVER (ORDER BY date_of_admission)
AS running_total_revenue FROM patient_records GROUP BY date_of_admission ORDER BY date_of_admission;
