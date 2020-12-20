--1
--Q. �׷��Լ��� �ټ� �࿡ ���� ����Ǿ� �׷�� �ϳ��� ����� �����մϴ�.(����)

--2
--Q. �׷��Լ��� ��꿡 NULL�� �����մϴ�.(Ʋ��)

--3
--Q. WHERE ���� �׷��꿡 ���Խ�Ű�� ���� ���� �����մϴ�. (����)

--4
SELECT ROUND(MAX(SALARY),0) "Maximum",
       ROUND(MIN(SALARY),0) "Minimum",
       ROUND(SUM(SALARY),0) "Sum",
       ROUND(AVG(SALARY),0) "Average"
FROM EMPLOYEES;

--5
SELECT JOB_ID, ROUND(MAX(SALARY),0) "Maximum",
               ROUND(MIN(SALARY),0) "Minimum",
               ROUND(SUM(SALARY),0) "Sum",
               ROUND(AVG(SALARY),0) "Average"
FROM EMPLOYEES
GROUP BY JOB_ID;

--06(A)
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID;
--06(B)
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID = '&JOB_TITLE'
GROUP BY JOB_ID;

--07
SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM employees;

--08
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;
--09
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY MIN(salary) DESC;
--10
SELECT COUNT(*) total,
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2005,1,0))"2005",
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2006,1,0))"2006",
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2007,1,0))"2007",
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2008,1,0))"2008"
FROM employees;

--11
SELECT job_id "Job",
SUM(DECODE(department_id , 20, salary)) "Dept 20",
SUM(DECODE(department_id , 50, salary)) "Dept 50",
SUM(DECODE(department_id , 80, salary)) "Dept 80",
SUM(DECODE(department_id , 90, salary)) "Dept 90",
SUM(salary) "Total"
FROM employees
GROUP BY job_id;

