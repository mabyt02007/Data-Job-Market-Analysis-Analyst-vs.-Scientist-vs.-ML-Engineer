# Data Job Market Analysis: Analyst vs. Scientist vs. ML Engineer

An end-to-end data analysis project using **MySQL** for data cleaning and querying, paired with an interactive **Tableau** dashboard to analyze skill demand and salary distribution across Data Analyst, Data Scientist, and Machine Learning Engineer positions.

 **Interactive Dashboard:**
[https://public.tableau.com/app/profile/muhammad.ahmed.bilal/viz/DataJobMarketAnalysisAnalystvs_Scientistvs_MLEngineer/DataCareerSkillsSalaryDashboard]

---

##  Business Question
For entry-level and early-career job seekers entering the data space:
* What technical skills are most in demand across different data roles?
* How does annual compensation vary between Data Analyst, Data Scientist, and Machine Learning Engineer roles?
* Which specific tool combinations yield the highest market value?

---

##  Dataset Overview
* **Source:** ~15,900 job postings including job titles, locations, raw salary ranges, pay periods, full job descriptions, and posting dates.
* **Database Engine:** MySQL
* **Currency:** USD (verified uniform currency across all rows)

---

##  Data Cleaning & Pipeline (`01_data_cleaning.sql`)
To ensure data integrity, several key data cleaning operations were executed prior to analysis:

1. **Timestamp Conversion:** Converted `posted_date` from Unix epoch milliseconds into standard `DATETIME` format.
2. **Salary Normalization:** Built a unified annual salary metric. Approximately 11% of job postings logged hourly, weekly, or monthly rates directly in the same column as annual compensation. All non-annual pay rates were standardized to an estimated annual salary using a standard 2,080-hour work year (e.g., converting a raw `$37/hr` entry into `$76,960/yr`).
3. **Imputation & Filtering:**
   * Calculated a robust `median_salary` feature from `min_salary` and `max_salary` midpoints (imputing the ~94% null raw `med_salary` column).
   * Applied a `$10,000` annual salary floor filter to remove corrupted outlier records (e.g., postings mislabeled as `YEARLY` with a `$36.50` value).

---

##  SQL Analysis & Key Queries

### 1. Skill Demand by Role (`02_skills_by_role.sql`)
* Extracted and calculated the presence rate of core technical skills (**SQL**, **Python**, **Excel**, **Tableau**) across target job titles using string pattern matching and aggregations.

### 2. Salary Breakdown by Role (`03_salary_by_role.sql`)
* Computed minimum, maximum, and average annual salary metrics for each role category to establish compensation benchmarks.

---

##  Key Findings & Market Insights

* **SQL is the Universal Foundation:** SQL is the single most consistent requirement across all three roles, appearing in **67% to 71%** of all job postings.
* **The Python Divide:** Python proficiency forms a sharp dividing line between Data Analysts (**31%** demand) and Data Scientists (**96%** demand).
* **Clear Compensation Hierarchy:** Average salaries directly reflect technical skill depth:
  * **Data Analyst:** ~$104,000 / year
  * **Data Scientist:** ~$168,000 / year
  * **Machine Learning Engineer:** ~$193,000 / year *(~86% higher than Data Analyst roles)*
* **Tool Specialization:** Business intelligence and reporting tools (**Tableau**, **Excel**) are heavily concentrated in Data Analyst and Data Scientist roles, and are virtually non-existent in Machine Learning Engineer postings.

---

##  Notes & Limitations
* **Salary Disclosures:** Approximately 65% of job postings in the raw dataset did not disclose explicit salary figures. Salary metrics are based on the subset of postings with disclosed pay.
* **Sample Size:** Salary metrics reflect a directional sample size (~13–20 postings with full pay disclosure per role category). Findings highlight macro market directional trends rather than strict statistical inference.

---

##  Tools & Technologies Used
* **Database & Querying:** MySQL (Data Wrangling, Filtering, Aggregations, Window Functions)
* **Data Visualization:** Tableau Public (Interactive Dashboard Design, KPI Cards, Comparative Charts)
* **Version Control:** Git & GitHub


MySQL (data cleaning, querying) · Tableau Public (dashboard)
