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