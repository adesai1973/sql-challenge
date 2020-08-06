
CREATE TABLE "employees" (
    "emp_no" int PRIMARY KEY  NOT NULL,
    "emp_title_id" varchar(10)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" char   NOT NULL,
    "hire_date" date  NOT NULL
);

SELECT * FROM employees;

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL,
    FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no")
);

SELECT * FROM salaries;

CREATE TABLE "titles" (
    "title_id" varchar(10) PRIMARY KEY  NOT NULL,
    "title" varchar(30)   NOT NULL
);

SELECT * FROM titles;

CREATE TABLE "departments" (
    "dept_no"   varchar(10) PRIMARY KEY   NOT NULL,
    "dept_name" varchar(30)   NOT NULL
);

SELECT * FROM departments;

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(10)   NOT NULL,
    FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    FOREIGN KEY("dept_no") REFERENCES "departments" ("dept_no")
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
    "emp_no" int   NOT NULL,
    FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no")
);

SELECT * FROM dept_manager;

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees, salaries
WHERE employees.emp_no = salaries.emp_no;

SELECT employees.first_name, employees.last_name,  employees.hire_date
FROM employees
WHERE employees.hire_date > '01/01/86' AND employees.hire_date < '12/31/86';

SELECT * FROM dept_manager;

SELECT d.dept_no, d.dept_name, e.emp_no, t.title, e.last_name, e.first_name
FROM employees e
JOIN titles t
ON e.emp_title_id = t.title_id
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE t.title = 'Manager';

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' 
AND e.last_name LIKE 'B%';

SELECT e.emp_no, t.title, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN titles t
ON e.emp_title_id = t.title_id
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

DROP VIEW IF EXISTS employees_salaries;

CREATE VIEW employees_salaries AS
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary, titles.title
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
JOIN titles
ON employees.emp_title_id = titles.title_id;

SELECT * FROM employees_salaries;

