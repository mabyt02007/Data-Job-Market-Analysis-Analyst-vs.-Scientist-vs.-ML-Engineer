# Data-Job-Market-Analysis-Analyst-vs.-Scientist-vs.-ML-Engineer
Data Job Market Analysis: Analyst vs. Scientist vs. ML Engineer

SQL analysis and Tableau dashboard comparing skill demand and salary across Data Analyst, Data Scientist, and Machine Learning job postings.

Live dashboard: Data Career Skills & Salary Dashboard

Business question

What skills are actually in demand for entry-level data roles, and how does pay differ between Data Analyst, Data Scientist, and Machine Learning positions?

Data

~15,900 job postings (title, location, salary range, pay period, description, posted date), loaded into MySQL and cleaned prior to analysis.

Data cleaning (01_data_cleaning.sql)
Converted posted_date from Unix epoch milliseconds to a standard datetime.
Built a reliable median salary column, since the source med_salary field was ~94% null — filled from the midpoint of min_salary/max_salary where available.
Normalized pay period to a common annual figure. Roughly 11% of postings stored hourly, weekly, or monthly rates in the same column as annual salaries — for example, an unconverted $37/hour rate looked identical to a $37/year outlier before this fix. All figures were converted to an estimated annual salary based on a standard 2,080-hour work year.
Identified and excluded a small number of rows with corrupted salary values (e.g. a posting labeled YEARLY with a $36.50 salary) via a $10,000 floor, rather than guessing the intended value.
Confirmed the dataset uses a single currency (USD), so no currency conversion was needed.

All figures below use a plain "approx." rather than the ~ symbol to avoid Markdown rendering it as strikethrough.

Analysis
02_skills_by_role.sql — skill mention rate (Python, SQL, Excel, Tableau) by role
03_salary_by_role.sql — average, min, and max annual salary by role
Key findings
SQL is the most consistently in-demand skill across all three roles (67-71% of postings), while Python sharply separates Data Scientist postings (96%) from Data Analyst postings (31%).
Machine Learning roles pay the most on average (approx. $193K), about 86% more than Data Analyst roles (approx. $104K), with Data Scientist in between (approx. $168K) — a pay hierarchy that tracks the skill-depth pattern found in the skills analysis.
Tableau and Excel are largely Analyst/Scientist-specific skills and are absent from Machine Learning postings entirely.
Notes & limitations
Sample sizes for the salary analysis are modest (13-20 postings per role with disclosed pay) — findings are directional, not statistically robust.
approx. 65% of postings did not disclose salary at all; salary analysis is limited to the subset that did.
Tools

MySQL (data cleaning, querying) · Tableau Public (dashboard)

MySQL (data cleaning, querying) · Tableau Public (dashboard)
