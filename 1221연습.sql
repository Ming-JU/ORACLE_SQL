--1

-- UNDEFINE 명령을 실행하여 변수를 제거합니다.
UNDEFINE ENTER_NAME

-- 아래 SELECT 문을 실행하여 employees 테이블의 값을 검색합니다.
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                       WHERE LAST_NAME = '&&ENTER_NAME')
AND LAST_NAME != '&ENTER_NAME';          

--2

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
  FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                 FROM EMPLOYEES)
ORDER BY SALARY;                 
                 
--3
SELECT EMPLOYEE_ID , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                          FROM EMPLOYEES
                         WHERE LAST_NAME LIKE '%u%'); 
                         
--4
SELECT LAST_NAME, DEPARTMENT_ID, JOB_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE LOCATION_ID = 1700); 
                          
--5
SELECT LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE MANAGER_ID = (SELECT EMPLOYEE_ID
                      FROM EMPLOYEES
                      WHERE LAST_NAME = 'King');
                      
--6
SELECT DEPARTMENT_ID, LAST_NAME, JOB_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                         FROM DEPARTMENTS
                        WHERE  DEPARTMENT_NAME = 'Executive');
                        
--7

SELECT LAST_NAME
 FROM EMPLOYEES
 WHERE SALARY > ANY(SELECT SALARY
                     FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 60); 
                    
--8

SELECT EMPLOYEE_ID , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                          FROM EMPLOYEES
                         WHERE LAST_NAME LIKE '%u%')
AND SALARY > (SELECT AVG(SALARY)
               FROM EMPLOYEES);
                         
                        