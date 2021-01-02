--1
CREATE OR REPLACE VIEW employees_vu AS
SELECT employee_id, last_name employee, department_id
FROM employees;

--2
SELECT *
FROM employees_vu;

--3
SELECT employee, department_id
FROM employees_vu;

--4
CREATE VIEW dept80 AS
SELECT employee_id empno, last_name employee,
department_id deptno
FROM employees
WHERE department_id = 80
WITH CHECK OPTION CONSTRAINT emp_dept_80;

--5
DESCRIBE dept80
SELECT *
FROM dept80;

--6
UPDATE dept80
SET deptno = 50
WHERE employee = 'Abel';

--7

SELECT view_name, text
FROM user_views;

--8
DROP VIEW employees_vu;
DROP VIEW dept80;
DROP VIEW dept50;

