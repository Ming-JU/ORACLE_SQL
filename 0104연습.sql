--ADVANCED SQL
--6장 그룹함수


--1
SELECT DEPTNO, SUM(SAL) AS SUM_SAL
FROM EMP
GROUP BY DEPTNO

UNION ALL

SELECT NULL, SUM(SAL)
  FROM EMP
ORDER BY DEPTNO; -- 전체급여의 합계도 보여줌

SELECT DEPTNO, SUM(SAL) AS SUM_SAL
FROM EMP
GROUP BY ROLLUP(DEPTNO);

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

--2

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB); --DEPTNO는 항상 GROUPING에 참여

--추가

SELECT TO_CHAR(HIREDATE,'YYYY') AS YEAR,DEPTNO,JOB,SUM(SAL),
       GROUPING_ID(TO_CHAR(HIREDATE,'YYYY'),DEPTNO,JOB) AS EXPRESSION
  FROM EMP
 GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY')), CUBE(DEPTNO, JOB)
 ORDER BY EXPRESSION, YEAR, DEPTNO, JOB;

--3

SELECT DEPTNO, EMPNO, ENAME, SUM(SAL) AS SAL
FROM EMP
GROUP BY DEPTNO, ROLLUP((EMPNO,ENAME)); --각각 출력후 소계 출력


SELECT deptno, empno, ename, SUM(sal) AS sal
FROM emp
GROUP BY ROLLUP(deptno, (empno,ename)) ; --마지막 전체합계도 출력가능

--4

SELECT deptno, empno, ename,
       DECODE(grouping_id(1,deptno),3,ROUND(AVG(sal),2),SUM(sal)) AS sal --3일때는 평균 그렇지않으면 SUM수행
FROM emp
WHERE deptno = 30
GROUP BY ROLLUP(1,(deptno,empno,ename));


/*
(1,(deptno,empno,ename)) --개별사원
(1)--부서에대한 평균급여
()--전체가 하나의 그룹

grouping_id(1,deptno)
            0    0    => 0 -SUM
            0    1    => 1 -SUM
		    1    1    => 3 -AVG
*/
SELECT deptno, job, SUM(sal),
GROUPING(deptno), GROUPING(job), GROUPING_ID(deptno,job)
FROM emp
GROUP BY CUBE(deptno,job)
ORDER BY 6 ;

SELECT DECODE(GROUPING(1), 0, SUM(sal), AVG(sal)) AS COMPUTE
FROM emp
GROUP BY ROLLUP(1) ;

--5

SELECT DEPTNO, EMPNO
       DECODE(GROUPING_ID(1,DEPTNO,2,EMPNO),1,'DEPT_SUM', 3,'DEPT_AVG',
                                            7,'TOTAL_SUM',15,'TOTAL_AVG',
                                            ENAME) AS ENAME,
       DECODE(GROUPING_ID(1,DEPTNO,2,EMPNO),1,SUM(SAL), 3,ROUND(AVG(SAL),1),
                                            7,SUM(SAL), 15,ROUND(AVG(SAL),1),
                                              SUM(SAL)) AS SAL
                                              
 FROM EMP
 GROUP BY ROLLUP(1,DEPTNO,2,(EMPNO,ENAME));
 
 
SELECT deptno, empno, 
       DECODE(grouping_id(1,deptno,2,empno), 1,'DEPT_SUM', 3,'DEPT_AVG',
                                             7,'TOTAL_SUM', 15,'TOTAL_AVG',
                                             ename) AS ename,
       DECODE(grouping_id(1,deptno,2,empno), 1,SUM(sal), 3,ROUND(AVG(sal),1),
                                             7,SUM(sal), 15,ROUND(AVG(sal),1), 
                                             SUM(sal)) AS sal
FROM emp
GROUP BY ROLLUP(1,deptno,2,(empno,ename));

--6

