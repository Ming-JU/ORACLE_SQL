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
: SQL ��ɹ� �ȿ� ���Ե� �� �ٸ� SELECT ��ɹ� 

Q. JONES ���� �� ���� �޿��� �޴� ���? */

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


-- Single row subquery : ���ϵǴ� �� ������ 1��
-- Multiple row subquery: ���ϵǴ� �� ������ 2�� �̻�
-- Multiple column subquery: ���ϵǴ� �÷� ������ 2���̻�

--GROUP BY���� ������ ��� ������ SUBQUERY ��� ����
----------------------------------------------------------------------
--�������� SUBQUERY (WHERE,HAVING)

-- Single row subquery : ���ϵǴ� �� ������ 1�� ���� �� �� ������ ���(=, <>,>,>=,<,<=)


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

-- Multiple row subquery: ���ϵǴ� �� ������ 2�� �̻� 
                        --�񱳿����� IN, ANY, ALL �̿� 

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
WHERE SAL >ALL (SELECT AVG(SAL) --AND ����
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
WHERE SAL >ANY (SELECT AVG(SAL) --OR ����
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
                
-- Multiple column subquery: ���ϵǴ� �÷� ������ 2���̻� (�񱳿����� IN�� ����)

--Q. �μ��� �ּ� �޿��� �޴� ���?
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
               GROUP BY DEPTNO) ;  --�μ��� �ּұ޿��� ������ �޿��� �޴� ���(�μ���ȣ�� �������)

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
 --NOT IN �� ������� �ʴ°� ����
