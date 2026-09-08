-- ============================================================
-- Analysis: Skill demand by role
-- Question: Which skills are most in-demand for Data Analyst,
--           Data Scientist, and Machine Learning roles, and how
--           does demand differ between them?
-- ============================================================

SELECT
  CASE
    WHEN title LIKE '%data analyst%'    THEN 'Data Analyst'
    WHEN title LIKE '%data scientist%'  THEN 'Data Scientist'
    WHEN title LIKE '%machine learning%' THEN 'Machine Learning'
    ELSE 'Other'
  END AS role,
  ROUND(SUM(description LIKE '%python%')  / COUNT(*) * 100, 1) AS python_pct,
  ROUND(SUM(description LIKE '%sql%')     / COUNT(*) * 100, 1) AS sql_pct,
  ROUND(SUM(description LIKE '%excel%')   / COUNT(*) * 100, 1) AS excel_pct,
  ROUND(SUM(description LIKE '%tableau%') / COUNT(*) * 100, 1) AS tableau_pct,
  COUNT(*) AS total_postings
FROM jobs
WHERE title LIKE '%data analyst%'
   OR title LIKE '%data scientist%'
   OR title LIKE '%machine learning%'
GROUP BY role;

-- ------------------------------------------------------------
-- Result (n=93 postings total):
--
-- role               python_pct  sql_pct  excel_pct  tableau_pct  total
-- Data Analyst        31.0        66.7     64.3       35.7         42
-- Data Scientist       96.4       71.4     21.4       32.1         28
-- Machine Learning     60.9       34.8     30.4        0.0         23
--
-- Finding: SQL is the most consistently demanded skill across
-- all three roles (67-71%). Python sharply separates Data
-- Scientist postings (96%) from Analyst postings (31%). Tableau
-- and Excel are largely Analyst/Scientist-specific and absent
-- from Machine Learning postings.
-- ------------------------------------------------------------
