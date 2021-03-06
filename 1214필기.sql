SELECT *
FROM EMP;

SELECT EMPNO,ENAME,SAL,DEPTNO
FROM EMP;

SELECT *
FROM EMP
WHERE DEPTNO = 10;

SELECT SUM(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;


SELECT *
FROM departments;

SELECT * FROM TAB;

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT * 
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMP';

DESC EMP
DESC DEPT
DESC EMPLOYEES
DESC DEPARTMENTS


SELECT last_name, salary, salary+300
FROM employees;


SELECT EMPLOYEE_ID,LAST_NAME,SALARY,SALARY*2,SALARY+300
from EMPLOYEES;

SELECT EMPNO,ENAME,SAL,COMM,SAL+NVL(COMM,0) as "salary"
FROM EMP;

SELECT EMPNO EMPID 
              ,ENAME NAME 
              ,SAL "EMP Salary"
FROM EMP ; 

SELECT ENAME || JOB 
FROM EMP ; 

SELECT EMPNO, ENAME, SAL , 'A'
FROM EMP ; 

SELECT ENAME || Q'['s a ' ' ' ' ']' || JOB
FROM EMP;

SELECT DISTINCT DEPTNO, JOB
FROM EMP;


