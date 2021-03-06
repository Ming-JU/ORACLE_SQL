--1
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >12000 ;
--2
SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

--3
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT IN (5000,12000); -- not between 5000 and 12000;

--4

SELECT LAST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE LAST_NAME IN ('Matos','Taylor')
ORDER BY hire_date;

--5
SELECT LAST_NAME, department_id
FROM EMPLOYEES
WHERE department_id IN (20,50)
ORDER BY department_id ASC;

--6
SELECT LAST_NAME "Employee" , SALARY "Monthly Salary"
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 12000 
AND DEPARTMENT_ID IN (20,50);

--7
SELECT LAST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE hire_date >= '2006/01/01' AND hire_date < '2007/01/01';

SELECT *
FROM EMPLOYEES;
--8
SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;
--9 
SELECT LAST_NAME, SALARY, COMMISION_PCT
FROM EMPLOYEES
WHERE COMMISION_PCT IS NOT NULL
ORDER BY 8 DESC , 9 DESC; 

--10
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > &SAL_TMP;

--11
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE manager_id = &mgr_num
ORDER BY &order_col;

--12

SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--13
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%'
AND last_name LIKE '%e%';

--14
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

--15

SELECT last_name "Employee", salary "Monthly Salary",
commission_pct
FROM employees
WHERE commission_pct = .20;

