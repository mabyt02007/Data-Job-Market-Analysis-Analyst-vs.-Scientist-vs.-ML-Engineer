-- ============================================================
-- Analysis: Salary by role
-- Question: How does average annual salary compare across
--           Data Analyst, Data Scientist, and Machine Learning
--           postings, once pay-period units are normalized?
-- ============================================================

SELECT
  CASE
    WHEN title LIKE '%data analyst%'    THEN 'Data Analyst'
    WHEN title LIKE '%data scientist%'  THEN 'Data Scientist'
    WHEN title LIKE '%machine learning%' THEN 'Machine Learning'
    ELSE 'Other'
  END AS role,
  ROUND(AVG(salary_annual_est), 0) AS avg_salary,
  ROUND(MIN(salary_annual_est), 0) AS min_salary,
  ROUND(MAX(salary_annual_est), 0) AS max_salary,
  COUNT(salary_annual_est) AS postings_with_salary
FROM jobs
WHERE (title LIKE '%data analyst%'
   OR title LIKE '%data scientist%'
   OR title LIKE '%machine learning%')
  AND salary_annual_est IS NOT NULL
  AND salary_annual_est >= 10000   -- excludes corrupted/mislabeled rows
GROUP BY role;

-- ------------------------------------------------------------
-- Result:
--
-- role               avg_salary  min_salary  max_salary  postings_with_salary
-- Data Analyst         103,685      45,760     171,600      20
-- Data Scientist        167,616     119,500     221,000      13
-- Machine Learning       192,825      84,000     281,950      16
--
-- Finding: Machine Learning postings command the highest average
-- salary (~$193K), roughly 86% more than Data Analyst postings
-- (~$104K), with Data Scientist in between (~$168K). Pay
-- hierarchy tracks the skill-depth pattern found in the skills
-- analysis (see 02_skills_by_role.sql).
--
-- Note: sample sizes are modest (13-20 postings per role with
-- disclosed salary) — directional, not statistically robust.
-- ------------------------------------------------------------
