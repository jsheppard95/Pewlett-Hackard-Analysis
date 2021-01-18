-- Deliverable 1: Number of Retiring Employees by Title
-- Table of employees with titles eligible for retirement
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Retrieve number of employees by most recent job title
-- who are eligible for retirement
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Deliverable 2: Employees Eligible for the Mentorship Program
-- Table of employees born 1965-01-01 to 1965-12-31
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, ti.to_date DESC;

-- Deliverable 3: Summary/Additional Queries
-- Total number of roles that need to be filled
SELECT SUM(count) FROM retiring_titles;

-- Count of employees eligible for mentorship program by title
SELECT COUNT(me.title), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;

-- Employees with departments eligible for retirement
DROP TABLE retirement_departments;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	de.to_date,
	d.dept_name
INTO retirement_departments
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;
-- View the table
SELECT * FROM retirement_departments;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rd.emp_no) rd.emp_no,
	rd.first_name,
	rd.last_name,
	rd.dept_name
INTO unique_departments
FROM retirement_departments as rd
ORDER BY rd.emp_no, rd.to_date DESC;
-- View the table
SELECT * FROM unique_departments;

-- Retrieve number of employees by most recent department
-- who are eligible for retirement
SELECT COUNT(ud.dept_name), ud.dept_name
INTO retiring_departments
FROM unique_departments as ud
GROUP BY ud.dept_name
ORDER BY COUNT(ud.dept_name) DESC;
-- View the table
SELECT * FROM retiring_departments;

-- Employees eligible for mentorship program with most recent department
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
INTO mentorship_dept_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC;
-- View the table
SELECT * FROM mentorship_dept_eligibility;

-- Count of employees eligible for mentorship program by department
SELECT COUNT(mde.dept_name), mde.dept_name
FROM mentorship_dept_eligibility as mde
GROUP BY mde.dept_name
ORDER BY COUNT(mde.dept_name) DESC;