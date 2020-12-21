/*SUBQUERY 
: SQL 명령문 안에 포함된 또 다른 SELECT 명령문 
SUBQUERY는 MAIN QUERY보다 먼저 실행될 수 있고, 
그 결과를 SUBQUERY가 위치한 곳으로 리턴 (MAIN QUERY가 그 결과를 사용)*/

-- 1. 조건절의 SUBQUERY (WHERE, HAVING)
SELECT * 
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL)
                FROM EMP 
               GROUP BY DEPTNO) ; 

SELECT *   -- ERROR 
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL)
                FROM EMP 
               GROUP BY DEPTNO
               ORDER BY MIN(SAL)) ; 


--2. FROM 절의 SUBQUERY (Inline View)
----최종 결과를 생성하는데 필요한 사전집합(부분집합)을 정의
----ORDER BY 절 사용 가능

--Q. 소속 부서의 평균급여보다 더 많은 급여를 받는 사원? 

/* 시행착오들
SELECT *
FROM EMP
WHERE SAL > ANY (SELECT AVG(SAL)
            FROM EMP
            GROUP BY DEPTNO);  --소속부서의 평균과 비교한것은 아님
SELECT * 
FROM EMP 
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, AVG(SAL) 
                        FROM EMP 
                        GROUP BY DEPTNO) ; 

SELECT *
FROM EMP 
WHERE DEPTNO IN (SELECT DEPTNO 
                  FROM EMP 
                 GROUP BY DEPTNO) 
  AND SAL    >ANY (SELECT AVG(SAL)
                  FROM EMP 
                 GROUP BY DEPTNO) ;

SELECT *
FROM EMP 
WHERE SAL >ANY (SELECT AVG(SAL)
                FROM EMP 
                GROUP BY DEPTNO) ; 
SELECT *
FROM EMP 
WHERE SAL >(SELECT AVG(SAL)
              FROM EMP );  */


            
--SOL

SELECT E.*, A.AVG_SAL
FROM EMP E 
JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL 
       FROM EMP 
       GROUP BY DEPTNO) A 
  ON E.DEPTNO = A.DEPTNO 
 AND E.SAL    > A.AVG_SAL ; 


CREATE TABLE EMP_AVG
AS
SELECT DEPTNO, AVG(SAL) AS AVG_SAL 
FROM EMP 
GROUP BY DEPTNO ; 

SELECT * FROM EMP_AVG;

SELECT *
FROM EMP     E 
JOIN EMP_AVG A 
  ON E.DEPTNO = A.DEPTNO ; 
  
SELECT *
FROM EMP     E 
JOIN EMP_AVG A 
  ON E.DEPTNO = A.DEPTNO 
 AND E.SAL    > A.AVG_SAL  ; 
  
SELECT E.*, A.AVG_SAL
FROM EMP E 
JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL 
       FROM EMP 
       GROUP BY DEPTNO) A 
  ON E.DEPTNO = A.DEPTNO 
 AND E.SAL    < A.AVG_SAL ; 
----------------------------------------------------------
SELECT *
FROM EMP
ORDER BY SAL DESC ; 

SELECT ROWNUM, E.*
FROM EMP E; 

SELECT ROWNUM, E.*
FROM EMP E
WHERE ROWNUM <= 3 ; 


SELECT ROWNUM, E.*
FROM EMP E
WHERE ROWNUM <= 3 
ORDER BY SAL DESC ; 


--TOP-N 질의
SELECT *
FROM (SELECT * 
      FROM EMP 
      ORDER BY SAL DESC)
WHERE ROWNUM <= 3; --문장의 실행순서를 고려해줘야함  


--Q.가장빠른 입사일자를 가진사람
SELECT *
  FROM (SELECT *
         FROM EMP
         ORDER BY HIREDATE)
 WHERE ROWNUM <= 3;         
 
SELECT ROWNUM, E.*
FROM EMP E 
WHERE ROWNUM = 1 ; 


SELECT ROWNUM, E.*
FROM EMP E 
WHERE ROWNUM = 2 ; 

SELECT ROWNUM, E.*
FROM EMP E 
WHERE ROWNUM = 3 ; 

SELECT ROWNUM, E.*
FROM EMP E 
WHERE ROWNUM > 3 ; 

SELECT ROWNUM, EMPNO, ENAME, SAL, DEPTNO 
FROM EMP ; 

--Q. 급여를 내립차순 기준으로 정렬하여 6~10등의 사원을 검색

SELECT ROWNUM, E.*
FROM EMP E 
WHERE ROWNUM IN(6,10)
ORDER BY SAL DESC;

SELECT * 
FROM ( SELECT ROWNUM ,  
        FROM EMP 
        ORDER BY SAL DESC )
WHERE ROWNUM BETWEEN 6 AND 10;
 
 --SOL
 
SELECT ROWNUM, B.*
FROM (SELECT ROWNUM AS R2, A.*
      FROM (SELECT ROWNUM AS R1, E.* 
            FROM EMP E
            ORDER BY SAL DESC) A ) B 
WHERE R2 BETWEEN 6 AND 10;      

/*
* Correlated Subquery 

상위 쿼리의 컬럼을 참조하는 서브쿼리 
Main Query 가 먼저 실행되면서 후보행이 결정되고,
후보행의 컬럼값이 서브쿼리에 공급, 서크붜리가 실행되면 그 결과를 리턴
리턴된 결과는 후보행을 평가하면서 사용됨 
후보행의 개수에 따라 반복 실행 */


SELECT * 
FROM EMP E 
WHERE SAL > (SELECT AVG(SAL)
               FROM EMP 
              WHERE DEPTNO = E.DEPTNO) ; 
