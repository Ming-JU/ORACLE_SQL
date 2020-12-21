--20201221

--REVIEW
SELECT *
FROM EMP ; 

SELECT * 
FROM DEPT ;

SELECT E.*, D.DNAME, D.LOC
FROM EMP   E 
    ,DEPT  D 
WHERE E.DEPTNO = D.DEPTNO 
  AND E.SAL    > 2000 ; 

SELECT E.*, D.DNAME, D.LOC
FROM EMP   E 
JOIN DEPT  D 
  ON E.DEPTNO = D.DEPTNO 
WHERE E.SAL    > 2000 ; 

SELECT *
FROM EMP  E
   , DEPT D
WHERE E.DEPTNO (+) = D.DEPTNO;

SELECT SAL
FROM EMP 
WHERE ENAME = 'JONES';

SELECT *
FROM EMP
WHERE SAL > 2975 ; 

SELECT *
FROM EMP J
    ,EMP E
WHERE J.ENAME = 'JONES'
  AND E.SAL   > J.SAL ; 
  
SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO ; 

SELECT DEPTNO, JOB, SUM(SAL) -- ERROR 
FROM EMP 
GROUP BY DEPTNO ; 

SELECT ENAME, SUM(SAL) 
FROM EMP 
GROUP BY ENAME ; 

SELECT ENAME, EMPNO, SUM(SAL) -- ERROR 
FROM EMP 
GROUP BY ENAME ; 


/*SUBQUERY 
: SQL 명령문 안에 포함된 또 다른 SELECT 명령문 

Q. JONES 보다 더 많은 급여를 받는 사원? */

SELECT SAL 
FROM EMP 
WHERE ENAME = 'JONES' ; 

SELECT * 
FROM EMP 
WHERE SAL > 2975 ; 

SELECT * 
FROM EMP 
WHERE SAL > (SELECT SAL 
             FROM EMP 
             WHERE ENAME = 'JONES') ; 
             

SELECT * 
FROM EMP 
WHERE SAL > (SELECT MIN(SAL)
             FROM EMP 
             GROUP BY DEPTNO) ; 


-- Single row subquery : 리턴되는 행 개수가 1개
-- Multiple row subquery: 리턴되는 행 개수가 2개 이상
-- Multiple column subquery: 리턴되는 컬럼 개수가 2개이상

--GROUP BY절을 제외한 모든 절에서 SUBQUERY 사용 가능
----------------------------------------------------------------------
--조건절의 SUBQUERY (WHERE,HAVING)

-- Single row subquery : 리턴되는 행 개수가 1개 단일 행 비교 연산자 사용(=, <>,>,>=,<,<=)


SELECT * 
FROM EMP 
WHERE SAL > (SELECT SAL 
             FROM EMP 
             WHERE ENAME = 'JONES') ; 

SELECT * 
FROM EMP 
WHERE SAL > (2975) ; 


SELECT * 
FROM EMP 
WHERE SAL < (2975) ;

SELECT * 
FROM EMP 
WHERE SAL = (2975) ;

SELECT * 
FROM EMP 
WHERE SAL != (2975) ;

-- Multiple row subquery: 리턴되는 행 개수가 2개 이상 
                        --비교연산자 IN, ANY, ALL 이용 

SELECT *  ---------ERROR 
FROM EMP 
WHERE SAL = (SELECT MIN(SAL)
               FROM EMP 
              GROUP BY DEPTNO) ; 



SELECT * 
FROM EMP 
WHERE SAL = (SELECT MIN(SAL)
               FROM EMP 
              GROUP BY DEPTNO) ; 
SELECT * --------ERROR
FROM EMP
WHERE SAL = 950
      SAL = 800    
      SAL = 1300 ;


SELECT *
FROM EMP
WHERE SAL = 950
   OR  SAL = 800    
   OR  SAL = 1300 ;


SELECT *
FROM EMP
WHERE SAL IN ( 950 , 800, 1300);

SELECT *
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL)
               FROM EMP 
              GROUP BY DEPTNO) ; 

SELECT *
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);


SELECT * ------ERROR
FROM EMP
WHERE SAL > (SELECT AVG(SAL) 
               FROM EMP);
            GROUP BY DEPTNO);
            
SELECT *
FROM EMP
WHERE SAL > 1566
  AND SAL > 2175
  AND SAL > 2916;
   
   
SELECT *
FROM EMP
WHERE SAL >ALL (SELECT AVG(SAL) --AND 연산
                FROM EMP
                GROUP BY DEPTNO);            

SELECT * 
FROM EMP 
WHERE SAL > (SELECT MAX(AVG(SAL))
             FROM EMP
             GROUP BY DEPTNO ) ;
             




SELECT *
FROM EMP
WHERE SAL > 1566
   OR SAL > 2175
   OR SAL > 2916;
   

SELECT *
FROM EMP
WHERE SAL >ANY (SELECT AVG(SAL) --OR 연산
                FROM EMP
                GROUP BY DEPTNO);      
SELECT * 
FROM EMP 
WHERE SAL > (SELECT MIN(AVG(SAL))
             FROM EMP
             GROUP BY DEPTNO ) ;
                
SELECT * 
FROM EMP 
WHERE SAL >ANY (1566, 2175, 2916) ; 


SELECT * 
FROM EMP 
WHERE SAL >ALL (1566, 2175, 2916) ; 


SELECT *
FROM EMP 
WHERE SAL IN (950, 800,1300) ; 

SELECT *
FROM EMP 
WHERE SAL =ANY (950, 800,1300) ; 

SELECT * 
FROM EMP 
WHERE SAL = 950 
   OR SAL = 800 
   OR SAL = 1300 ; 
                
-- Multiple column subquery: 리턴되는 컬럼 개수가 2개이상 (비교연산자 IN만 가능)

--Q. 부서별 최소 급여를 받는 사람?
SELECT * 
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL)
               FROM EMP 
               GROUP BY DEPTNO) ; 

SELECT MIN (SAL) , DEPTNO
FROM EMP
GROUP BY DEPTNO;
--------------
UPDATE EMP 
SET SAL = 950 
WHERE EMPNO = 7788 ;

SELECT * FROM EMP 
WHERE EMPNO = 7788 ; 

SELECT * 
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL)
               FROM EMP 
               GROUP BY DEPTNO) ;  --부서별 최소급여와 동일한 급여를 받는 사원(부서번호와 상관없음)

SELECT * 
FROM EMP 
WHERE (DEPTNO,SAL) IN (SELECT DEPTNO, MIN(SAL)
                         FROM EMP
                        GROUP BY DEPTNO) ; 

ROLLBACK ;
SELECT * FROM EMP WHERE EMPNO = 7788 ;

SELECT * 
FROM DEPT 
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP) ; 

SELECT * 
FROM DEPT 
WHERE DEPTNO IN (10,10,20,20,30,30);

SELECT * 
FROM DEPT 
WHERE DEPTNO NOT IN (SELECT DEPTNO FROM EMP) ; 


SELECT * 
FROM DEPT 
WHERE DEPTNO NOT IN (10,10,20,20,30,30); 


SELECT * 
FROM DEPT 
WHERE DEPTNO NOT IN (SELECT DEPTNO FROM EMP);

---------------------------------------------------------

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN  (SELECT DEPARTMENT_ID FROM EMPLOYEES);

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN  (SELECT DEPARTMENT_ID FROM EMPLOYEES);

SELECT * 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID 
                            FROM EMPLOYEES
                            WHERE DEPARTMENT_ID IS NOT NULL) ; 

SELECT * 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID NOT IN (SELECT NVL(DEPARTMENT_ID,-1)
                            FROM EMPLOYEES) ; 



SELECT * 
FROM DEPT 
WHERE DEPTNO IN (10,20,30,NULL) ; 

SELECT * 
FROM DEPT 
WHERE DEPTNO = 10 
   OR DEPTNO = 20 
   OR DEPTNO = 30 
   OR DEPTNO = NULL ;   


SELECT * 
FROM DEPT 
WHERE DEPTNO NOT IN (10,20,30,NULL) ; 

SELECT * 
FROM DEPT 
WHERE DEPTNO != 10 
  AND DEPTNO != 20 
  AND DEPTNO != 30 
  AND DEPTNO != NULL ;   
 --NOT IN 은 사용하지 않는게 좋음
