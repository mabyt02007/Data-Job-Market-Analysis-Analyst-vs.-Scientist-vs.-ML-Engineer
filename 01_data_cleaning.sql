-- Data Job Market Analysis — Data Cleaning
-- Dataset: LinkedIn/Indeed-style job postings (job title, location,
--          salary range, pay period, description, posted date)

-- Allow bulk UPDATEs without a primary-key WHERE clause (safe here
-- since we intentionally want to update every row)
SET SQL_SAFE_UPDATES = 0;

-- 1. Fix posted_date: source stored as Unix epoch milliseconds
ALTER TABLE jobs ADD COLUMN posted_date_clean DATETIME;

UPDATE jobs
SET posted_date_clean = FROM_UNIXTIME(posted_date / 1000);

-- 2. Build a reliable median salary column
--    med_salary is sparse (~94% null); fall back to the
--    midpoint of min_salary/max_salary where available
ALTER TABLE jobs ADD COLUMN med_salary_calc DECIMAL(12,2);

UPDATE jobs
SET med_salary_calc = CASE
  WHEN med_salary IS NOT NULL THEN med_salary
  WHEN min_salary IS NOT NULL AND max_salary IS NOT NULL
       THEN (min_salary + max_salary) / 2
  ELSE NULL
END;


-- 3. Normalize pay period to a single annual salary estimate
--    (raw min_salary/max_salary mixed hourly, weekly, monthly,
--    and yearly figures in the same columns — e.g. an hourly
--    rate of $37 looked like a $37/year outlier before this fix)

ALTER TABLE jobs ADD COLUMN salary_annual_est DECIMAL(12,2);

UPDATE jobs
SET salary_annual_est = CASE
  WHEN pay_period = 'HOURLY'  THEN med_salary_calc * 2080  
  WHEN pay_period = 'WEEKLY'  THEN med_salary_calc * 52
  WHEN pay_period = 'MONTHLY' THEN med_salary_calc * 12
  WHEN pay_period = 'YEARLY'  THEN med_salary_calc
  ELSE med_salary_calc
END;

-- 4. Exclude clearly corrupted salary rows
--    A handful of rows labeled pay_period = 'YEARLY' still had
--    implausible values (e.g. $36.50/year) — likely a mislabeled
--    hourly figure at the source. Rather than guess the true
--    value, these are filtered out of salary analysis via a
--    floor rather than deleted, keeping the row for non-salary
--    analysis (skills, location, title).

-- Example diagnostic used during cleaning:
-- SELECT title, pay_period, min_salary, max_salary, med_salary,
--        med_salary_calc, salary_annual_est
-- FROM jobs
-- WHERE salary_annual_est < 1000;

-- Applied downstream as: AND salary_annual_est >= 10000


-- 5. Currency check (confirmed single-currency dataset — no
--    conversion needed)

-- SELECT DISTINCT currency FROM jobs;  -- returned only 'USD'


-- 6. Sanity checks after cleaning
SELECT
  MIN(salary_annual_est) AS min_salary,
  MAX(salary_annual_est) AS max_salary,
  ROUND(AVG(salary_annual_est), 0) AS avg_salary,
  COUNT(salary_annual_est) AS postings_with_salary,
  COUNT(*) AS total_postings
FROM jobs;
