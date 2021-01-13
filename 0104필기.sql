--20210104

--FROM ���� �������� (Inline View)
--order by ��� ���� (~8i)

-TOP-n ���� 

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
FETCH FIRST 2 ROWS WITH TIES; -- �ߺ����� �������

SELECT empno, ename, sal 
FROM emp 
ORDER BY sal DESC
OFFSET 2 ROWS FETCH FIRST 2 ROWS ONLY ; --2�� �ǳʶٰ� ���

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
GROUP BY ROLLUP(DEPTNO) ; --�����ѹ� -> �������ƽ� // �׻������� �ƴ�

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
GROUP BY CUBE(JOB, DEPTNO) ; --������Ǽ��� �������
/*
(JOB,DEPTNO)
(DEPTNO)
(JOB)
() --�� ������� ��� ����
*/

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB, MGR) ; 
/*
(DEPTNO, JOB, MGR)
(DEPTNO, JOB)
(DEPTNO)
() --ROLLUP���� �÷��� ������ �߿��ϴ�
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

--Q. (DEPTNO, JOB), (DEPTNO,MGR) �� ǥ�������� �׷��� �����Ͽ� SUM(SAL) �˻�? 

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ; --�������ʴ� ������ �ʹ� ���� ����

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM EMP 
GROUP BY GROUPING SETS((DEPTNO,JOB), (DEPTNO,MGR)) ; 

/*ROLLUP, CUBE, GROUPING SETS �߿� ��� ����
��������� CUBE�� ������ ���Ǿ���
������ �ѹ��ϱ� ������ ������ ������ ���� ����
���ɰ�� ���ϸ� ����*/

SELECT *
FROM EMP;

SELECT MGR, SUM(SAL)
FROM EMP 
GROUP BY MGR ; 

SELECT DEPTNO, JOB, MGR, SUM(SAL), 
       GROUPING(DEPTNO), GROUPING(JOB), GROUPING(MGR)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB, MGR) ;  --GROUPING �÷��� ���� 1�̸� �������� 0�̸� ������


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
HAVING GROUPING_ID(DEPTNO, JOB, MGR) IN (1, 2) ;  --GROUPING ID�� ���� �����ߴ������ߴ��� �������� Ȯ��
--������� 010 = 2, 100=4 


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO,JOB) ;
------------------------------------------------------------------------------

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO,JOB) ;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, ROLLUP(JOB) ; --��ü����޿������� ������������
--=> (DEPTNO,JOB),(DEPTNO)

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO, ROLLUP(JOB.MGR); -- Ư���׷��� ���� �׷��ο� �����ϰ��Ϸ��� ���ξ���

SELECT EMPNO, ENAME, SUM(SAL)
FROM EMP 
GROUP BY EMPNO, ENAME ; --������� �޿�������


SELECT EMPNO, ENAME, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP ((EMPNO, ENAME)) ; --�ǹؿ��� ��ü����� �޿��� �� //�ΰ��̻��� �÷��� ��� �����ϴ� �۾�����

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
GROUP BY 1; --����࿡ 1��ä���ְ� GROUPING��

SELECT GROUPING(1), SUM(SAL)
FROM EMP
GROUP BY ROLLUP(1); --��ó�� ����ϰ�, ���������� GROUP BY�� �۵��������� -> ��2��

SELECT CASE GROUPING(1) WHEN 0 THEN SUM(SAL) 
                   ELSE  AVG(SAL) END 
FROM EMP 
GROUP BY ROLLUP(1) ; 

SELECT SUM(SAL), AVG(SAL)
FROM EMP;

 SELECT *
   FROM ( SELECT deptno, job, sal 
            FROM emp ) 
  PIVOT (SUM(sal) FOR job IN ('ANALYST'   AS analyst, --���⼭ ���Ӹ����� ������
                              'CLERK'     AS clerk,
                              'MANAGER'   AS manager, 
                              'PRESIDENT' AS president, 
                              'SALESMAN'  AS salesman)) 
 ORDER BY deptno ;
 
--------------------------------------------------------------------------- 
SELECT SUM(SAL), AVG(SAL) 
FROM EMP ; 

-->�హ���� �ø��� ������


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
GROUP BY EMPNO, DAY ; --�����������͸� ����������ó��! �۾��� �� ���������ִ�.



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
