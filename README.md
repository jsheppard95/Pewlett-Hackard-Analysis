# Pewlett-Hackard-Analysis

## Overview of the analysis
Here we perform an analysis of company data using PostgreSQL to generate a list of the employees eligible for retirement, a breakdown of the number of
retiring employees by title, and list of the employees eligible for the mentorship program for training to replace retiring managers and other company
members with positions requiring significant experience. We consider the six input data files noted below and summarized in the entity relationship
diagram [EmployeeDB.png](EmployeeDB.png). This leads to the tables shown in [schema.sql](schema.sql) which we then query using
[Employee_Database_challenge.sql](Queries/Employee_Database_challenge.sql) to produce the desired retirement information.

### Resources
- Data Source:
  - [departments.csv](Data/departments.csv)
  - [employees.csv](Data/employees.csv)
  - [dept_manager.csv](Data/dept_manager.csv)
  - [salaries.csv](Data/salaries.csv)
  - [dept_emp.csv](Data/dept_emp.csv)
  - [titles.csv](Data/titles.csv)
- Software:
  - PostgreSQL 11.10
  - [QuickDBD](https://www.quickdatabasediagrams.com/)

## Results
- Retirement-Eligible Employees with Titles
  - Output File: [retirement_titles.csv](Data/retirement_titles.csv)
  - Output Table: [retirement_titles.png](Resources/retirement_titles.png)
- Retirement-Eligible Employees with Titles (Unique - Most Recent Title)
  - Output File: [unique_titles.csv](Data/unique_titles.csv)
  - Output Table: [unique_titles.png](Resources/unique_titles.png)
- Number of Retirement-Eligible Employees by Most Recent Title
  - Output File: [retiring_titles.csv](Data/retiring_titles.csv)
  - Output Table: [retiring_titles.png](Resources/retiring_titles.png)
- Employees Eligible for Mentorship Program
  - Output File: [mentorship_eligibility.csv](Data/mentorship_eligibility.csv)
  - Output Table: [mentorship_eligibility.png](Resources/mentorship_eligibility.png)

## Summary
We see using the SQL command `SELECT SUM(count) FROM retiring_titles;` that there are a total of 90,398 positions spanning seven different titles
that will need to be filled due to retiring employees. At first glance, we see in `mentorship_eligibility` that there are only 1,549
retirement-ready employees also eligible to mentor younger employees, and so we check distribution of the number of mentorship program-eligible
employees by title using the following query:
```
-- Count of employees eligible for mentorship program by title
SELECT COUNT(me.title), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;
```
This results in the table shown in [mentorship_titles.png](Resources/mentorship_titles.png). We thus see there are zero retirement-ready managers that
are also eligible for the mentorship program, indicating a gap in the ability to train the next generation of employees.
