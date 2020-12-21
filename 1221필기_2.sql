/*SUBQUERY 
: SQL ��ɹ� �ȿ� ���Ե� �� �ٸ� SELECT ��ɹ� 
SUBQUERY�� MAIN QUERY���� ���� ����� �� �ְ�, 
�� ����� SUBQUERY�� ��ġ�� ������ ���� (MAIN QUERY�� �� ����� ���)*/

-- 1. �������� SUBQUERY (WHERE, HAVING)
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


--2. FROM ���� SUBQUERY (Inline View)
----���� ����� �����ϴµ� �ʿ��� ��������(�κ�����)�� ����
----ORDER BY �� ��� ����

--Q. �Ҽ� �μ��� ��ձ޿����� �� ���� �޿��� �޴� ���? 

/* ����������
SELECT *
FROM EMP
WHERE SAL > ANY (SELECT AVG(SAL)
            FROM EMP
            GROUP BY DEPTNO);  --�ҼӺμ��� ��հ� ���Ѱ��� �ƴ�
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


--TOP-N ����
SELECT *
FROM (SELECT * 
      FROM EMP 
      ORDER BY SAL DESC)
WHERE ROWNUM <= 3; --������ ��������� ����������  


--Q.������� �Ի����ڸ� �������
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

--Q. �޿��� �������� �������� �����Ͽ� 6~10���� ����� �˻�

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

���� ������ �÷��� �����ϴ� �������� 
Main Query �� ���� ����Ǹ鼭 �ĺ����� �����ǰ�,
�ĺ����� �÷����� ���������� ����, ��ũ�۸��� ����Ǹ� �� ����� ����
���ϵ� ����� �ĺ����� ���ϸ鼭 ���� 
�ĺ����� ������ ���� �ݺ� ���� */


SELECT * 
FROM EMP E 
WHERE SAL > (SELECT AVG(SAL)
               FROM EMP 
              WHERE DEPTNO = E.DEPTNO) ; 
