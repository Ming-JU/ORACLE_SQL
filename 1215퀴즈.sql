
--1��
SELECT last_name, job_id, salary AS Sal
FROM employees;

--2��
SELECT *
FROM job_grades;

--3��
SELECT employee_id, last_name, SALARY*12 ANNUAL_SALARY
FROM employees;

--4��
DESCRIBE departments 

SELECT *
FROM departments;

--5��
DESCRIBE employees

SELECT employee_id, last_name, job_id, hire_date AS startdate
FROM employees;

--6��
SELECT job_id
FROM employees;


--7��

DESCRIBE employees

SELECT employee_id AS "EMP #", last_name AS "Employee" , job_id AS "Job" , hire_date AS "Hire Date"
FROM employees; 

--8
SELECT last_name||', '||job_id "Employee and Title"
FROM employees; 


--9
SELECT employee_id || ',' || first_name || ',' || last_name
|| ',' || email || ',' || phone_number || ','|| job_id
|| ',' || manager_id || ',' || hire_date || ','
|| salary || ',' || commission_pct || ',' ||
department_id
THE_OUTPUT
FROM employees;












