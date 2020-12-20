SELECT *
FROM EMP 
WHERE DEPTNO = 10 ;

SELECT *
FROM EMP 
WHERE DEPTNO = 20 ;

SELECT *
FROM EMP 
WHERE DEPTNO = 30 ;

SELECT *
FROM EMP 
WHERE DEPTNO < 30 ;

SELECT EMPNO, ENAME, DEPTNO, 30 
FROM EMP ; 

SELECT EMPLOYEE_ID , LAST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

SELECT *
FROM EMP
WHERE ENAME = 'SCOTT';

SELECT * FROM EMPLOYEES;

SELECT *
FROM EMP
WHERE HIREDATE = '1987/04/19';

SELECT * 
FROM EMP 
WHERE HIREDATE != '1987/04/19' ;

SELECT *
FROM EMP
WHERE ENAME <'SCOTT';

SELECT * 
FROM EMP 
WHERE SAL BETWEEN 2000 AND 3000 ;

SELECT * 
FROM EMP 
WHERE SAL BETWEEN 3000 AND 2000 ; 

SELECT * 
FROM EMP 
WHERE ENAME BETWEEN 'A' AND 'C' ; 

SELECT * 
FROM EMP 
WHERE DEPTNO IN (10,20) ; 

SELECT * 
FROM EMP 
WHERE ENAME IN ('SCOTT','JONES') ; 

SELECT * 
FROM EMP 
WHERE HIREDATE IN ('1987/04/19', '1987/04/20') ;

SELECT * 
FROM EMP 
WHERE ENAME = 'S' ;
SELECT * 
FROM EMP 
WHERE ENAME LIKE 'S%' ; 

SELECT * 
FROM EMP 
WHERE ENAME LIKE '%S' ; 

SELECT * 
FROM EMP 
WHERE ENAME LIKE '%S%' ; 

SELECT * 
FROM EMP 
WHERE ENAME LIKE 'S____' ; 

SELECT * 
FROM EMP 
WHERE ENAME LIKE 'S___' ; 



SELECT JOB_ID
FROM EMPLOYEES ;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID LIKE '%A_%';

SELECT *
FROM EMPLOYEES
WHERE JOB_ID LIKE '%A!_%' ESCAPE '!'; --

SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID LIKE '%A_%' ; 

SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID LIKE '%A!_%' ESCAPE '!'; 


SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID LIKE '%A^_^%' ESCAPE '^'; 

SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID LIKE '%_%' ; 

SELECT *
FROM EMP;

SELECT *
FROM EMP
WHERE COMM IS NULL;

SELECT *
FROM EMP
WHERE COMM > NULL;

SELECT *
FROM EMP
WHERE COMM < NULL;

SELECT *
FROM EMP
WHERE COMM = NULL;

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

SELECT *
FROM EMP
WHERE DEPTNO = 10 OR SAL > 2000;

SELECT * 
FROM EMP 
WHERE DEPTNO = 10 
  AND SAL > 2000 ; 
  
SELECT * 
FROM EMP 
WHERE DEPTNO = 10 
   OR SAL > 2000 ; 

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

SELECT * 
FROM EMP
WHERE SAL >=2000
  AND SAL<= 3000;
  
SELECT *
FROM EMP
WHERE DEPTNO IN (10.20);

SELECT *
FROM EMP
WHERE DEPTNO =10
 OR DEPTNO = 20;
 
 SELECT *
 FROM EMP
 WHERE ENAME != 'SCOTT';
 -- NOT 이나 ! 를 이용해서 긍정부정 변화 가능
 
SELECT * 
FROM EMP 
WHERE DEPTNO = 10 
   OR DEPTNO = 30 
  AND SAL > 2000 ;
  
  SELECT * 
FROM EMP 
WHERE DEPTNO = 10 
   OR DEPTNO = 30 
  AND SAL > 2000 ;

SELECT * 
FROM EMP 
WHERE DEPTNO = 10 
   OR (DEPTNO = 30 
  AND SAL > 2000) ;


SELECT * 
FROM EMP 
WHERE (DEPTNO = 10 
    OR DEPTNO = 30)
  AND SAL > 2000 ;


SELECT * 
FROM EMP 
WHERE DEPTNO IN (10,30)
  AND SAL > 2000 ;

SELECT * 
FROM EMP 
WHERE DEPTNO = 30 
  OR  JOB   = 'SALESMAN' 
  AND SAL > 2000 ; 
  

SELECT *
FROM EMP
ORDER BY DEPTNO;

SELECT *
FROM EMP
ORDER BY DEPTNO ASC;


SELECT *
FROM EMP
ORDER BY DEPTNO DESC;

SELECT *
FROM EMP
ORDER BY 8 DESC;

SELECT EMPNO, ENAME, SAL, DEPTNO AS DEPTID
FROM EMP
ORDER BY DEPTID;

SELECT *
FROM EMP
ORDER BY DEPTNO, SAL DESC;

SELECT *
FROM V$VERSION;

SELECT *
FROM EMP
ORDER BY SAL
FETCH FIRST 3 ROWS ONLY; -- 3개만 보여줘
     


SELECT * 
FROM (SELECT * 
      FROM EMP
      ORDER BY SAL) 
WHERE ROWNUM <= 3;  

SELECT *
FROM EMP
WHERE DEPTNO = 10;

SELECT *
FROM EMP
WHERE DEPTNO = &ID;--치환변수

SELECT * 
FROM EMP 
WHERE DEPTNO = &ID ; 

SELECT * 
FROM EMP 
&CONDITION ; 


SELECT EMPNO, ENAME, SAL, &&COL
FROM EMP
ORDER BY &COL;
  