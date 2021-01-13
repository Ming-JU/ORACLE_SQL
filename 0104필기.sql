--20210104

--FROM 절의 서브쿼리 (Inline View)
--order by 사용 가능 (~8i)

-TOP-n 질의 

SELECT * 
FROM (SELECT *
        FROM EMP 
       ORDER BY HIREDATE ASC)
WHERE ROWNUM <= 5 ; 


SELECT *
FROM EMP E 
WHER EMP.SAL > 2000 ; 

SELECT ROWNUM, B.*
FROM (SELECT ROWNUM AS RK, A.* 
      FROM (SELECT *
            FROM EMP 
            ORDER BY HIREDATE ASC) A 
      ) B ; 

SELECT ROWNUM, B.*
FROM (SELECT ROWNUM AS RK, A.* 
      FROM (SELECT *
            FROM EMP 
            ORDER BY HIREDATE ASC) A 
      ) B 
WHERE RK BETWEEN 5 AND 10; 


SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL DESC
FETCH FIRST 2 ROWS ONLY;

SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL DESC
FETCH FIRST 2 ROWS WITH TIES; -- 중복값도 출력해줌

SELECT empno, ename, sal 
FROM emp 
ORDER BY sal DESC
OFFSET 2 ROWS FETCH FIRST 2 ROWS ONLY ; --2개 건너뛰고 출력

------------------------------------------------------------------

SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO ; 

SELECT SUM(SAL)
FROM EMP ; 

SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO 
UNION ALL 
SELECT NULL, SUM(SAL)
FROM EMP ; 

SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO) ; --접근한번 -> 성능좋아심 // 항상좋은건 아님

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, JOB ; 

SELECT DEPTNO, JOB, SAL 
FROM EMP 
ORDER BY DEPTNO, JOB ;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB) ; 

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, JOB 
UNION ALL
SELECT DEPTNO, NULL, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO 
UNION 
SELECT NULL, NULL, SUM(SAL)
FROM EMP ; 


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY CUBE(JOB, DEPTNO) ; --모든경우의수를 만들어줌
/*
(JOB,DEPTNO)
(DEPTNO)
(JOB)
() --이 결과들이 모두 나옴
*/

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB, MGR) ; 
/*
(DEPTNO, JOB, MGR)
(DEPTNO, JOB)
(DEPTNO)
() --ROLLUP사용시 컬럼의 순서가 중요하다
*/

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ; 

/*
(DEPTNO, JOB, MGR)
(DEPTNO, JOB)
(DEPTNO, MGR)
(JOB,MGR)
(DEPTNO)
(JOB)
(MGR)
()
*/

--Q. (DEPTNO, JOB), (DEPTNO,MGR) 두 표현식으로 그룹을 생성하여 SUM(SAL) 검색? 

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ; --원하지않는 정보가 너무 많이 나옴

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY GROUPING SETS((DEPTNO,JOB), (DEPTNO,MGR)) ; 

/*ROLLUP, CUBE, GROUPING SETS 중에 골라서 쓰기
상대적으로 CUBE를 쓸일은 거의없음
접근을 한번하기 때문에 성능이 좋아질 때도 있음
성능고려 안하면 좋음*/

SELECT *
FROM EMP;

SELECT MGR, SUM(SAL)
FROM EMP 
GROUP BY MGR ; 

SELECT DEPTNO, JOB, MGR, SUM(SAL), 
       GROUPING(DEPTNO), GROUPING(JOB), GROUPING(MGR)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ;  --GROUPING 컬럼의 값이 1이면 참여안함 0이면 참여함


SELECT DEPTNO, JOB, MGR, SUM(SAL), 
       GROUPING(DEPTNO), GROUPING(JOB), GROUPING(MGR)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) 
HAVING GROUPING(DEPTNO) = 0 
    AND GROUPING(JOB) =  0 
   AND GROUPING(MGR)   = 1 ; 


SELECT DEPTNO, JOB, MGR, SUM(SAL), 
       GROUPING(DEPTNO), GROUPING(JOB), GROUPING(MGR), 
       GROUPING_ID(DEPTNO, JOB, MGR)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ; 

SELECT DEPTNO, JOB, MGR, SUM(SAL), 
       GROUPING(DEPTNO), GROUPING(JOB), GROUPING(MGR),  
       GROUPING_ID(DEPTNO, JOB, MGR)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) 
HAVING GROUPING_ID(DEPTNO, JOB, MGR) IN (1, 2) ;  --GROUPING ID는 누가 참여했는지안했는지 십진수로 확인
--예를들면 010 = 2, 100=4 


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO,JOB) ;
------------------------------------------------------------------------------

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO,JOB) ;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, ROLLUP(JOB) ; --전체사원급여의합은 보여주지않음
--=> (DEPTNO,JOB),(DEPTNO)

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, ROLLUP(JOB.MGR); -- 특정그룹이 따로 그루핑에 참여하게하려면 따로쓰기

SELECT EMPNO, ENAME, SUM(SAL)
FROM EMP 
GROUP BY EMPNO, ENAME ; --각사원의 급여가나옴


SELECT EMPNO, ENAME, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP ((EMPNO, ENAME)) ; --맨밑에는 전체사원의 급여의 합 //두개이상의 컬럼을 묶어서 제거하는 작업가능

SELECT EMPNO, ENAME, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP (DEPTNO,(EMPNO, ENAME)) ; 

/*
(DEPTNO,EMPNO,ENAME)
(DEPTNO)
()
*/

SELECT 1, SUM(SAL)
FROM EMP
GROUP BY 1; --모든행에 1을채워넣고 GROUPING함

SELECT GROUPING(1), SUM(SAL)
FROM EMP
GROUP BY ROLLUP(1); --위처럼 계산하고, 빠져나가면 GROUP BY가 작동하지않음 -> 행2개

SELECT CASE GROUPING(1) WHEN 0 THEN SUM(SAL) 
                   ELSE  AVG(SAL) END 
FROM EMP 
GROUP BY ROLLUP(1) ; 

SELECT SUM(SAL), AVG(SAL)
FROM EMP;

 SELECT *
   FROM ( SELECT deptno, job, sal 
            FROM emp ) 
  PIVOT (SUM(sal) FOR job IN ('ANALYST'   AS analyst, --여기서 열머릿글이 정해짐
                              'CLERK'     AS clerk,
                              'MANAGER'   AS manager, 
                              'PRESIDENT' AS president, 
                              'SALESMAN'  AS salesman)) 
 ORDER BY deptno ;
 
--------------------------------------------------------------------------- 
SELECT SUM(SAL), AVG(SAL) 
FROM EMP ; 

-->행갯수를 늘리고 싶으면


SELECT *
FROM (SELECT SUM(SAL) AS SUM_SAL, AVG(SAL) AS AVG_SAL 
      FROM EMP) A
CROSS JOIN 
     (SELECT ROWNUM AS NO 
        FROM DUAL 
       CONNECT BY LEVEL <= 2) ; 


SELECT *
FROM (SELECT SUM(SAL) AS SUM_SAL, AVG(SAL) AS AVG_SAL 
      FROM EMP) A
CROSS JOIN 
     (SELECT ROWNUM AS NO 
        FROM DUAL 
       CONNECT BY LEVEL <= 2) B; 


SELECT B.NO, DECODE(B.NO,1,A.SUM_SAL
                        ,2,A.AVG_SAL) 
FROM (SELECT SUM(SAL) AS SUM_SAL, AVG(SAL) AS AVG_SAL 
      FROM EMP) A
CROSS JOIN 
     (SELECT ROWNUM AS NO 
        FROM DUAL 
       CONNECT BY LEVEL <= 2) B; 


SELECT * FROM SOURCE_DATA;



SELECT s.empno, s.year, s.week_id, 
            DECODE(no, 1, 'MON', 2, 'TUE', 3, 'WED', 4, 'THUR', 5, 'FRI') AS DAY,
            DECODE(no, 1, sales_mon, 
2, sales_tue, 
3, sales_wed, 
4, sales_thur, 
5, sales_fri) AS SALES_QTY
       FROM source_data s
     CROSS JOIN
           (SELECT LEVEL AS NO 
              FROM dual 
            CONNECT BY LEVEL <= 5) d ;
            
            
SELECT empno, year, week_id, day, sales_qty
  FROM source_data 
UNPIVOT ( sales_qty FOR day IN (sales_mon AS 'MON',
                                sales_tue AS 'TUE',
                                sales_wed AS 'WED',
                                sales_thur AS 'THUR',
                                sales_fri  AS 'FRI')) ; 





SELECT empno, 
       SUM(sales_mon), 
       SUM(sales_tue), 
       SUM(sales_wed), 
       SUM(sales_thur), 
       SUM(sales_fri)
FROM source_data 
GROUP BY empno; 

SELECT EMPNO, DAY, SUM(SALES_QTY)
FROM (SELECT s.empno, s.year, s.week_id, 
            DECODE(no, 1, 'MON', 2, 'TUE', 3, 'WED', 4, 'THUR', 5, 'FRI') AS DAY,
            DECODE(no, 1, sales_mon, 
                       2, sales_tue, 
                       3, sales_wed, 
                       4, sales_thur, 
                       5, sales_fri) AS SALES_QTY
  FROM source_data s
CROSS JOIN
      (SELECT LEVEL AS NO 
         FROM dual 
       CONNECT BY LEVEL <= 5) d )
GROUP BY EMPNO, DAY ; --비정형데이터를 정형데이터처럼! 작업이 더 편리해질수있다.



---------------------------------------------------------------------------------------------------

SELECT empno, ename, sal, deptno, SUM(sal)
  FROM emp
GROUP BY DEPTNO ; 

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, S.SUM_SAL 
FROM EMP E 
JOIN (SELECT DEPTNO, SUM(SAL) AS SUM_SAL 
        FROM EMP 
	   GROUP BY DEPTNO) S 
  ON E.DEPTNO = S.DEPTNO ; 

SELECT empno, ename, sal, deptno, SUM(sal) OVER() 
  FROM emp; 

SELECT empno, ename, sal, deptno, SUM(sal) OVER(PARTITION BY deptno)
  FROM emp; 

SELECT empno, ename, sal, deptno, SUM(sal) OVER() 
  FROM emp
WHERE DEPTNO  = 20 ; 

SELECT empno, ename, sal,
       SUM(sal) over ( ORDER BY empno 
                       ROWS BETWEEN 1 PRECEDING 
                                AND 1 FOLLOWING ) AS physical
FROM emp
ORDER BY empno ;

FROM emp
ORDER BY empno ;


SELECT empno, ename, sal, 
       SUM(sal) OVER(ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING 
                                             AND CURRENT ROW) 
FROM emp ;

SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY empno) 
  FROM emp ;
  
SELECT empno, ename, sal, DEPTNO, 
       SUM(sal) OVER(PARTITION BY DEPTNO
                     ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING 
                                             AND CURRENT ROW) 
FROM emp ;

FROM emp ;

SELECT *
FROM EMP 
ORDER BY COMM ; 

SELECT *
FROM EMP 
ORDER BY COMM ASC NULLS LAST ; 

SELECT *
FROM EMP 
ORDER BY COMM DESC NULLS FIRST ; 

SELECT *
FROM EMP 
ORDER BY COMM ASC NULLS FIRST ; 

SELECT *
FROM EMP 
ORDER BY COMM DESC NULLS LAST ; 

-------------------------------------------------

SELECT * 
FROM EMP 
WHERE EMPNO = 7839 ; 

SELECT * 
FROM EMP 
WHERE MGR = 7839 ; 

SELECT * 
FROM EMP 
WHERE MGR = 7566 ; 

SELECT * 
FROM EMP 
WHERE MGR = 7788 ; 

SELECT * 
FROM EMP 
WHERE MGR = 7876 ; 


--------------------------------------------------------
SELECT *
FROM EMP 
START WITH EMPNO = 7839 
CONNECT BY PRIOR EMPNO = MGR ;

SELECT LPAD(' ',LEVEL*2-2)||ENAME AS NAME
      ,LEVEL
      ,EMPNO
      ,MGR
FROM EMP 
START WITH EMPNO = 7839 
CONNECT BY PRIOR EMPNO = MGR ;

SELECT LPAD(' ',LEVEL*2-2)||ENAME AS NAME
      ,LEVEL
      ,EMPNO
      ,MGR
FROM EMP 
START WITH EMPNO = 7839 
CONNECT BY EMPNO = PRIOR MGR ;

SELECT *
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO ; 

/*
5 SELECT 
1 FROM 
4 WHERE 
2 START WITH 
3 CONNECT BY  PRIOR  PK (EMPNO) =  FK (MGR)
*/
