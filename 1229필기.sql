--1229

DROP TABLE DEPT2 CASCADE CONSTRAINTS PURGE ; 
CREATE TABLE DEPT2 

AS SELECT * FROM DEPT ; --검색된내용을 그대로 테이블에 입력까지 해줌

SELECT * FROM USER_INDEXES 
WHERE TABLE_NAME = 'DEPT2' ;

ALTER TABLE DEPT2 
ADD CONSTRAINT DEPT2_PK PRIMARY KEY(DEPTNO) ; --이제 NULL, 중복값 허용 안됨

SELECT * FROM USER_INDEXES 
WHERE TABLE_NAME = 'DEPT2' ;--검색되는행이 생김(인덱스가 검색되는것)/ 제약조건이 생기면 인덱스가 자동으로 생성

SELECT * FROM USER_IND_COLUMNS 
WHERE TABLE_NAME = 'DEPT2' ; --제약조건이 추가된 열까지 확인

DROP TABLE EMP2 PURGE ; 
CREATE TABLE EMP2 
AS SELECT * FROM EMP ; --EMP내용을 복제해서 EMP2를 생성



ALTER TABLE EMP2 
ADD CONSTRAINT EMP2_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO) ;-- 제약조건 추가(FK), 존재하는 값만 참조

SELECT * FROM USER_INDEXES 
WHERE TABLE_NAME = 'EMP2' ; --인덱스가 자동으로 생성XX 

----------------------------------------------------------------------------

UPDATE EMP2 
SET DEPTNO = 30 
WHERE EMPNO = 7788  ;

UPDATE EMP2 ---ERROR 
SET DEPTNO = 50 
WHERE EMPNO = 7788  ; --없는 DEPTNO이기때문에 에러


DELETE DEPT2 
WHERE DEPTNO = 40 ; --아무도 쓰는사람이없기때문에 삭제가능


DELETE DEPT2 
WHERE DEPTNO = 10 ; --참조하고 있는 행들이 있기때문에 삭제가 불가능하다.

ROLLBACK;

ALTER TABLE EMP2 
DROP CONSTRAINT EMP2_FK ; 

ALTER TABLE DEPT2 
DROP CONSTRAINT DEPT2_PK ; 

ALTER TABLE DEPT2 
ADD CONSTRAINT DEPT2_PK PRIMARY KEY(DEPTNO) ;

ALTER TABLE EMP2 
ADD CONSTRAINT EMP2_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO) ON DELETE CASCADE ;

DELETE DEPT2 
WHERE DEPTNO = 10 ; 


SELECT * FROM DEPT2 ; --10번이 사라짐 

SELECT * FROM EMP2 ; --DEPTNO =10 인 행들이 삭제됨

ROLLBACK ; 

ALTER TABLE EMP2 
DROP CONSTRAINT EMP2_FK ; 

ALTER TABLE EMP2 
ADD CONSTRAINT EMP2_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO) ON DELETE SET NULL ;

DELETE DEPT2 
WHERE DEPTNO = 10 ; 

SELECT * FROM DEPT2; 
SELECT * FROM EMP2 ; --DEPTNO =10이삭제되면서 NULL로 변경됨

ROLLBACK; 

UPDATE DEPT2  ---ERROR
SET DEPTNO = 15
WHERE DEPTNO = 10;


DROP TABLE DEPT2 ;


DROP TABLE DEPT2 CASCADE CONSTRAINTS PURGE ; --참조하는 키들이있으면 먼저 지워라!


--------------------------------------------------------------

--Q. 각각 부서의 최소 급여를 받는 사원? 


SELECT * 
FROM EMP 
WHERE SAL IN (SELECT MIN(SAL) 
             FROM EMP 
             GROUP BY DEPTNO);
             
DELETE FROM EMP WHERE ENAME LIKE 'RYU' ;            


UPDATE EMP 
SET SAL = 950 
WHERE EMPNO = 7788 ; 

SELECT * 
FROM EMP 
WHERE(DEPTNO, SAL) IN (SELECT DEPTNO, MIN(SAL) 
                FROM EMP
               GROUP BY DEPTNO) ; --여러조건을 한번에 비교할수있음// 비교연산자는 IN만 가능하다.

ROLLBACK;

-------------------------------------------------------------------------------------------------

--Q. 각각 부서의 최소 급여를 받는 사원? + 최소 급여도 함께 검색 

SELECT *
FROM EMP 
WHERE (DEPTNO, SAL) IN ( SELECT DEPTNO, MIN(SAL) 
                           FROM EMP 
                          GROUP BY DEPTNO ) ; 

SELECT E.*, SAL AS MIN_SAL
FROM EMP E
WHERE (DEPTNO, SAL) IN ( SELECT DEPTNO, MIN(SAL) 
                           FROM EMP 
                          GROUP BY DEPTNO ) ; 

SELECT E.*, J.MIN_SAL
FROM EMP E JOIN (SELECT DEPTNO, MIN(SAL) AS MIN_SAL
                   FROM EMP 
                  GROUP BY DEPTNO) J
 ON  E.SAL=J.MIN_SAL
AND E.DEPTNO=J.DEPTNO;

SELECT E.*, J.MIN_SAL
FROM EMP E JOIN (SELECT DEPTNO, MIN(SAL) AS MIN_SAL
                   FROM EMP 
                  GROUP BY DEPTNO) J
 ON  E.SAL>J.MIN_SAL
AND E.DEPTNO=J.DEPTNO;

-------------------------------------------------------------------------------------------

SELECT MANAGER_ID 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID IN (174,141) ; 



SELECT DEPARTMENT_ID
FROM EMPLOYEES 
WHERE EMPLOYEE_ID IN (174,141) ; 

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (174,141)
  AND MANAGER_ID IN (124,149)
  AND DEPARTMENT_ID IN (50,80);


SELECT MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES 
WHERE EMPLOYEE_ID IN (174,141) ; 

UPDATE EMPLOYEES 
SET MANAGER_ID = 149
WHERE EMPLOYEE_ID = 144 ;

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (174,141)
  AND MANAGER_ID IN (124,149)
  AND DEPARTMENT_ID IN (50,80);
  
SELECT * 
FROM EMPLOYEES 
WHERE (MANAGER_ID, DEPARTMENT_ID) IN (SELECT MANAGER_ID, DEPARTMENT_ID
                                        FROM EMPLOYEES 
                                       WHERE EMPLOYEE_ID IN (174,141)) 
  AND  EMPLOYEE_ID NOT IN (174,141) ; 
  
  
ROLLBACK;  
----------------------------------------------------------------

SELECT * 
FROM EMP 
WHERE SAL > (SELECT SAL 
              FROM EMP 
              WHERE ENAME = 'JONES') ; 
              
----------------------------------------------------------------

--Q. 소속 부서의 평균 급여보다 더 많은 급여를 받는 사원? 

SELECT *
FROM EMP
WHERE SAL > ALL (SELECT AVG(SAL)
               FROM EMP
              GROUP BY DEPTNO); --ERROR는 나지않지만 답은 아님

SELECT *
FROM EMP 
WHERE (DEPTNO,SAL) IN (SELECT DEPTNO, AVG(SAL)
                        FROM EMP 
                      GROUP BY DEPTNO) ;


SELECT E.*  --FROM절 서브쿼리 : 인라인뷰
FROM EMP E 
JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL
       FROM EMP 
     GROUP BY DEPTNO) A 
  ON E.DEPTNO = A.DEPTNO 
 AND E.SAL    > A.AVG_SAL ; 
 
 
 SELECT E.*, A.AVG_SAL 
FROM EMP E 
JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL
       FROM EMP 
     GROUP BY DEPTNO) A 
  ON E.DEPTNO = A.DEPTNO 
 AND E.SAL    > A.AVG_SAL ;

 
--찐 SOL

SELECT * 
FROM EMP 
WHERE SAL > 2000 ; 

SELECT *
FROM EMP E 
WHERE SAL > (SELECT AVG(SAL)
              FROM EMP
              WHERE DEPTNO = E.DEPTNO) ; 

----------------------------------------------------------------------

--Q. EMP 테이블에 10번 DEPTNO 가 존재 ? 

SELECT *
FROM EMP
WHERE DEPTNO = 10;

SELECT *
FROM EMP 
WHERE DEPTNO = 40 ; 

SELECT *
FROM EMP 
WHERE DEPTNO = 10 
  AND ROWNUM = 1 ;  --있다면 하나만 검색하고 끝
  
SELECT 'YES'
FROM DUAL ; 

SELECT 'YES'
FROM DUAL 
WHERE  1 = 1 ;

SELECT 'YES'  
FROM DUAL 
WHERE EXISTS (SELECT *
               FROM EMP 
               WHERE DEPTNO = 10
               AND ROWNUM = 1) ; --ROWNUM =1은 암시적으로 실행 // RETURN TRUE
               
--Q. 한 명이라도 근무하는 사원이 있는 부서들의 정보 ? 

SELECT * 
FROM DEPARTMENTS  ; 

SELECT * 
FROM EMPLOYEES ;

SELECT *
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)  ;


SELECT *
FROM DEPARTMENTS D 
WHERE EXISTS (SELECT *
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = D.DEPARTMENT_ID)  ;

SELECT *
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)  ;

SELECT *
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID NOT IN (SELECT NVL(DEPARTMENT_ID,-1) FROM EMPLOYEES)  ;

SELECT *
FROM DEPARTMENTS D 
WHERE NOT EXISTS (SELECT *
                  FROM EMPLOYEES
                  WHERE DEPARTMENT_ID = D.DEPARTMENT_ID)  ;

SELECT *
FROM DEPARTMENTS D 
WHERE EXISTS (SELECT *
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = D.DEPARTMENT_ID)  ; --8번실행됨

----------------------------------------------------------------------

SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO ; 

SELECT DEPTNO, SUM(SAL)
FROM EMP 
GROUP BY DEPTNO 
HAVING SUM(SAL) > (SELECT AVG(SUM(SAL))
                     FROM EMP
                    GROUP BY DEPTNO) ; 

WITH EMP_SUM AS (SELECT DEPTNO, SUM(SAL) AS SUM_SAL 
                   FROM EMP 
                  GROUP BY DEPTNO) 
SELECT *
FROM EMP_SUM ; 


WITH EMP_SUM AS (SELECT DEPTNO, SUM(SAL) AS SUM_SAL 
                   FROM EMP 
                  GROUP BY DEPTNO) 
SELECT *
FROM EMP_SUM 
WHERE SUM_SAL > (SELECT AVG(SUM_SAL)
                   FROM EMP_SUM) ; 


----------------------------------------------------

WITH EMP_DEP AS 
(SELECT *
FROM EMPLOYEES E 
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID)
SELECT LAST_NAME, DEPARTMENT_NAME, SALARY
FROM EMP_DEP 
WHERE (SALARY, JOB_ID) IN (SELECT SALARY, JOB_ID
                           FROM EMP_DEP
                           WHERE LOCATION_ID=1700);

INSERT INTO EMP2 
SELECT * FROM EMP ; 


CREATE OR REPLACE VIEW EMPV10
AS
SELECT * FROM EMP 
WHERE DEPTNO = 10 ; 

INSERT INTO EMPV10 
VALUES (.......) ; 

INSERT INTO (SELECT * FROM EMP 
              WHERE DEPTNO = 10) 
VALUES (.......) ; 

UPDATE EMPV10 
SET SAL = 6000 
WHERE EMPNO = 7839 ; 

UPDATE (SELECT * FROM EMP 
        WHERE DEPTNO = 10)  
SET SAL = 6000 
WHERE EMPNO = 7839 ; 

ALTER TABLE EMP 
ADD (DNAME VARCHAR2(10)) ; 

SELECT * FROM EMP ;

UPDATE EMP 
SET DNAME = 'ACCOUNTING' 
WHERE DEPTNO = 10 ; 

UPDATE EMP E 
SET DNAME = (SELECT DNAME 
               FROM DEPT 
              WHERE DEPTNO = E.DEPTNO) ;

SELECT * FROM EMP ; 

ALTER TABLE EMP 
DROP (DNAME) ; 

DELETE EMP
WHERE EMPNO IN (SELECT EMPNO FROM EMP_HISTORY) ;

DELETE EMP E 
WHERE EXISTS (SELECT 1 
              FROM EMP_HISTORY 
              WHERE EMPNO = E.EMPNO) ; 



------------------------------------------------------------

CREATE TABLE EMP 
(EMPNO   NUMBER, 
 ENAME   VARCHAR2(10), 
 HIREDATE DATE DEFAULT  SYSDATE) ;

INSERT INTO EMP 
VALUES (1234, 'ABC', TO_DATE('20201229','YYYYMMDD'));

INSERT INTO EMP (EMPNO, ENAME)
VALUES (1234, 'ABC');

INSERT INTO EMP 
VALUES (1234, 'ABC', DEFAULT);

INSERT INTO XXXXX VALUES (XXXXXXX) ;
DROP TABLE EMP2 PURGE; 

CREATE TABLE EMP2 
AS 
SELECT * 
FROM EMP 
WHERE SAL > 2000 ; 

UPDATE EMP2 
SET SAL = SAL * 0.5 
WHERE DEPTNO = 20 ; 

COMMIT ; 

SELECT * FROM EMP ; 


SELECT * FROM EMP ; 
SELECT * FROM EMP2 ; 

UPDATE EMP2 E 
SET (SAL,COMM) = (SELECT SAL,COMM 
                  FROM EMP 
                  WHERE EMPNO = E.EMPNO) ;


INSERT INTO EMP2 
SELECT * 
FROM EMP E
WHERE NOT EXISTS (SELECT 1 
                    FROM EMP2 
                   WHERE EMPNO = E.EMPNO) ; 

SELECT * FROM EMP2 ; 

ROLLBACK ; 

MERGE INTO EMP2 C 
USING EMP E 
ON (C.EMPNO = E.EMPNO) 
WHEN MATCHED THEN 
UPDATE 
SET C.SAL = E.SAL 
   ,C.COMM = E.COMM 
WHEN NOT MATCHED THEN 
INSERT 
VALUES (E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO) ;

COMMIT;

------------------------------------------------------------------------------
SELECT 'CREATE SYNONYM '||TABLE_NAME||' FOR TEST.'||TABLE_NAME||';'
FROM ALL_TABLES 
WHERE OWNER = 'TEST' ; 


CREATE SYNONYM SALGRADE FOR TEST.SALGRADE;
CREATE SYNONYM REGIONS FOR TEST.REGIONS;
CREATE SYNONYM EMPLOYEES FOR TEST.EMPLOYEES;
CREATE SYNONYM RETIRED_EMP FOR TEST.RETIRED_EMP;
CREATE SYNONYM JOB_HISTORY FOR TEST.JOB_HISTORY;
CREATE SYNONYM JOB_GRADES FOR TEST.JOB_GRADES;
CREATE SYNONYM CUSTOMERS FOR TEST.CUSTOMERS;
CREATE SYNONYM PRODUCTS FOR TEST.PRODUCTS;
CREATE SYNONYM ORDERS FOR TEST.ORDERS;
CREATE SYNONYM ORDER_ITEMS FOR TEST.ORDER_ITEMS;
CREATE SYNONYM ORDER_CANCEL FOR TEST.ORDER_CANCEL;
CREATE SYNONYM WISHLIST FOR TEST.WISHLIST;
CREATE SYNONYM BLACKLIST FOR TEST.BLACKLIST;
CREATE SYNONYM DORMANT_HIST FOR TEST.DORMANT_HIST;

--------------------------------------------------------------

/*
Q1. CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여, 
    WISHLIST(관심상품)에 저장된 상품이있는 고객의 주문 합계(SUM(orders.order_total))를 다음과 같이 검색하시오.
    참고. WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품을 의미한다.

검색 결과

   CUST_ID CUST_FNAME      CUST_LNAME       ORDER_TOT
---------- --------------- --------------- ----------
       105 Matthias        MacGraw            61376.5
       120 Diane           Higgins                416
       122 Maurice         Daltrey           103834.4
       143 Sachin          Neeson             27132.6
       155 Frederico       Romero             23431.9
       165 Charlotte       Fonda                 2519
       166 Dheeraj         Alexander              309
       167 Gerard          Hershey                 48
...

42 rows selected.
*/

--MY SOL
SELECT C.CUST_ID,C.CUST_FNAME, C.CUST_LNAME, SUM(O.ORDER_TOTAL)
 FROM CUSTOMERS C
 JOIN ORDERS O
 ON C.CUST_ID = O.CUST_ID
 AND EXISTS( SELECT CUST_ID
              FROM WISHLIST
            WHERE DELETED = 'N'
            AND CUST_ID = C.CUST_ID)
GROUP BY C.CUST_ID, C.CUST_FNAME,C.CUST_LNAME;


--SOL
SELECT *
FROM CUSTOMERS 
WHERE CUST_ID = 101 ; 

SELECT * 
FROM WISHLIST 
WHERE CUST_ID = 101 ; 

SELECT * 
FROM ORDERS 
WHERE CUST_ID = 101 ; 

SELECT SUM(ORDER_TOTAL) 
FROM ORDERS 
WHERE CUST_ID = 101 ; 

SQL> SELECT c.cust_id
           ,c.cust_fname
           ,c.cust_lname
           ,SUM(o.order_total) AS order_total
       FROM  customers c 
            ,orders    o
            ,wishlist  w 
     WHERE c.cust_id   = o.cust_id
       AND c.cust_id   = w.cust_id
       AND w.deleted   = 'N'
    GROUP BY c.cust_id
            ,c.cust_fname
            ,c.cust_lname 
    ORDER BY c.cust_id ;

SQL> SELECT c.cust_id
           ,c.cust_fname
           ,c.cust_lname
           ,SUM(o.order_total) AS order_total
       FROM  customers c 
       JOIN  orders    o
         ON c.cust_id   = o.cust_id
       JOIN wishlist  w 
         ON c.cust_id   = w.cust_id
      WHERE w.deleted   = 'N'
    GROUP BY c.cust_id
            ,c.cust_fname
            ,c.cust_lname 
    ORDER BY c.cust_id ;


--SQL> SELECT c.cust_id
           ,c.cust_fname
           ,c.cust_lname
           ,SUM(o.order_total) AS order_total
      FROM customers c 
      JOIN orders    o
        ON c.cust_id   = o.cust_id
     WHERE c.cust_id IN (SELECT cust_id
                           FROM wishlist 
                          WHERE deleted = 'N') 
    GROUP BY c.cust_id
            ,c.cust_fname
            ,c.cust_lname 
    ORDER BY c.cust_id ;

SQL> SELECT c.cust_id
           ,c.cust_fname
           ,c.cust_lname
           ,SUM(o.order_total) AS order_total
      FROM  customers c 
           ,orders    o
     WHERE c.cust_id   = o.cust_id
       AND EXISTS (SELECT *
                     FROM wishlist 
                    WHERE cust_id = c.cust_id
                      AND deleted = 'N') 
    GROUP BY c.cust_id
            ,c.cust_fname
            ,c.cust_lname 
    ORDER BY c.cust_id ;


SELECT E.*
FROM DEPT D
    ,EMP  E 
WHERE D.DEPTNO = E.DEPTNO ; 

SELECT * 
FROM EMP 
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT) ; 






/*
Q2.	CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여 
    고객별 주문 금액의 합계(SUM(order_total))와 관심상품 목록의 합계(SUM(unit_price*quantity))를 검색하시오. 
    참고. WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품을 의미한다.

검색 결과 

   CUST_ID CUST_FNAME      CUST_LNAME         ORD_TOT   WISH_TOT
---------- --------------- --------------- ---------- ----------
       105 Matthias        MacGraw            61376.5        908
       120 Diane           Higgins                416        448
       122 Maurice         Daltrey           103834.4      312.8
       143 Sachin          Neeson             27132.6        414
       155 Frederico       Romero             23431.9      993.6
       165 Charlotte       Fonda                 2519        449
       166 Dheeraj         Alexander              309        486
       167 Gerard          Hershey                 48        332
...

42 rows selected.
*/

--SOL
SELECT c.cust_id, c.cust_fname, c.cust_lname
           ,SUM(o.order_total) AS ord_tot
           ,SUM(w.unit_price * w.quantity) AS wish_tot
       FROM customers c
           ,orders o 
           ,wishlist w
      WHERE c.cust_id = o.cust_id
        AND c.cust_id = w.cust_id
        AND w.deleted = 'N'
     GROUP BY c.cust_id, c.cust_fname, c.cust_lname
     ORDER BY c.cust_id ;


--풀이 

--SQL> 
SELECT c.cust_id, c.cust_fname, c.cust_lname
           ,SUM(o.order_total) AS ord_tot
           ,SUM(w.unit_price * w.quantity) AS wish_tot
       FROM customers c
           ,orders o 
           ,wishlist w
      WHERE c.cust_id = o.cust_id
        AND c.cust_id = w.cust_id
        AND w.deleted = 'N'
     GROUP BY c.cust_id, c.cust_fname, c.cust_lname
     ORDER BY c.cust_id ;

--모범 답안 

--SQL> 
SELECT c.cust_id, c.cust_fname, c.cust_lname, o.ord_tot, w.wish_tot
     FROM  customers c
          ,(SELECT cust_id
                  ,SUM(order_total) AS ord_tot
              FROM orders 
            GROUP BY cust_id) o
          ,(SELECT cust_id
                  ,SUM(unit_price * quantity) AS wish_tot
             FROM wishlist
            WHERE deleted = 'N'
            GROUP BY cust_id) w 
    WHERE c.cust_id = o.cust_id
      AND c.cust_id = w.cust_id
    ORDER BY c.cust_id ;
    
 /*   
PRODS, SALES 테이블을 이용하여 제품별 판매 수량(QUANTITY_SOLD)의 합계를 다음과 같이 검색하시오. 단, 판매되지 않은 제품이 존재한다면 해당 제품도 함께 표시

검색 결과

   PROD_ID PROD_NAME                                            SOLD_SUM
---------- -------------------------------------------------- ----------
        13 5MP Telephoto Digital Camera                             6002
        14 17" LCD w/built-in HDTV Tuner                            5998
        15 Envoy 256MB - 40GB                                       5766
        16 Y Box                                                    6929
        17 Mini DV Camcorder with 3.5" Swivel LCD                   6160
        18 Envoy Ambassador                                         9591
        19 Laptop carrying case                                    10430
        20 Home Theatre Package with DVD-Audio/Video Play          10826
        21 18" Flat Panel Graphics Monitor                          5202
        22 Envoy External Keyboard                                  3441
        23 External 101-key keyboard                               19642
...

72 rows selected.
*/
--SQL> 
SELECT p.prod_id, p.prod_name, SUM(s.quantity_sold) AS sold_sum
       FROM prods p, sales s 
      WHERE p.prod_id = s.prod_id(+) 
     GROUP BY p.prod_id, p.prod_name ;

--SQL> 
SELECT p.prod_id, p.prod_name, SUM(s.quantity_sold) AS sold_sum
       FROM prods p LEFT OUTER JOIN sales s 
         ON p.prod_id = s.prod_id
     GROUP BY p.prod_id, p.prod_name ;

--SQL> 
SELECT /*+ NO_QUERY_TRANSFORMATION */ 
            p.prod_id, p.prod_name, SUM(s.quantity_sold) AS sold_sum
       FROM prods p, sales s 
      WHERE p.prod_id = s.prod_id(+) 
     GROUP BY p.prod_id, p.prod_name ;


--SQL> 
SELECT p.prod_id, p.prod_name, s.sold_sum
       FROM prods p, ( SELECT prod_id, SUM(quantity_sold) AS sold_sum
                         FROM sales 
                       GROUP BY prod_id ) s 
      WHERE p.prod_id = s.prod_id (+) ; 

--SQL> 
SELECT p.prod_id, p.prod_name, s.sold_sum
       FROM prods p 
       LEFT OUTER JOIN
            ( SELECT prod_id, SUM(quantity_sold) AS sold_sum
                FROM sales
              GROUP BY prod_id ) s 
         ON p.prod_id = s.prod_id ; 


/*
4.2000보다 많은 급여를 받는 사원정보와 부서정보를 검색한다. 
단, 근무하는 사원이 없는 부서정보도 함께 검색하시오.

검색 결과

    DEPTNO DNAME          LOC                EMPNO ENAME             SAL
---------- -------------- ------------- ---------- ---------- ----------
        10 ACCOUNTING     NEW YORK            7782 CLARK            2450
        10 ACCOUNTING     NEW YORK            7839 KING             5000
        20 RESEARCH       DALLAS              7566 JONES            2975
        20 RESEARCH       DALLAS              7788 SCOTT            3000
        20 RESEARCH       DALLAS              7902 FORD             3000
        30 SALES          CHICAGO             7698 BLAKE            2850
        40 OPERATIONS     BOSTON                                        

7개 행이 선택되었습니다
*/

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	       ,EMP  E 
	  WHERE D.DEPTNO = E.DEPTNO (+) 
	    AND E.SAL    > 2000 ; 
		
--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	   LEFT OUTER JOIN 
	        EMP  E 
	     ON D.DEPTNO = E.DEPTNO
      WHERE E.SAL    > 2000 ; 

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	       ,EMP  E 
	  WHERE D.DEPTNO = E.DEPTNO (+) 
	    AND (E.SAL    > 2000 OR E.SAL IS NULL); 
		
--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	   LEFT OUTER JOIN 
	        EMP  E 
	     ON D.DEPTNO = E.DEPTNO
      WHERE E.SAL    > 2000 OR E.SAL IS NULL ; 

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	      ,EMP  E 
	 WHERE E.DEPTNO (+) = D.DEPTNO 
	   AND E.SAL (+)    > 2000; 
		
--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
       LEFT OUTER JOIN 
	       EMP  E 
	   ON D.DEPTNO = E.DEPTNO
       AND E.SAL    > 2000 ; 

-------------------------------------------------------------

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	   LEFT OUTER JOIN 
	        EMP  E 
	     ON D.DEPTNO = E.DEPTNO
      WHERE E.SAL    > 3000 OR E.SAL IS NULL ; 

--SQL> 
SELECT *
       FROM (SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
               FROM DEPT D LEFT OUTER JOIN EMP  E 
    	            ON D.DEPTNO = E.DEPTNO) 
      WHERE SAL > 3000 OR SAL IS NULL ; 



--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
       LEFT OUTER JOIN 
	       EMP  E 
	   ON D.DEPTNO = E.DEPTNO
       AND E.SAL    > 3000 ; 

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
       LEFT OUTER JOIN 
	      (SELECT *
              FROM  EMP
             WHERE SAL > 3000)  E 
	   ON D.DEPTNO = E.DEPTNO  ; 

--SQL> 
SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
       FROM DEPT D 
	      ,EMP  E 
	 WHERE E.DEPTNO (+) = D.DEPTNO 
	   AND E.SAL (+)    > 2000; 
	

/*
5. 'Asten'(CUSTOMERS.CITY)에 거주하는 고객이 관심 상품(WISHLIST)에 등록한 상품과 실제 주문한 상품(ORDERS, ORDER_ITEMS)의 제품별 금액의 합(SUM(UNIT_PRICE*QUANTITY))을 검색하시오. 이때 관심 상품에만 등록 된 금액과, 관심 상품 등록 없이 주문한 제품의 금액 합도 함께 검색한다. 

검색 결과

   CUST_ID CUST_LNAME           PRODUCT_ID   WISH_TOT  ORDER_TOT
---------- -------------------- ---------- ---------- ----------
       148 Steenburgen                1910          0        117
       148 Steenburgen                1948    16035.6    10357.6
       148 Steenburgen                2289          0       4752
...
       326 Olin                       1806         50          0
       345 Weaver                     2384        599          0
       349 Glenn                      3139       78.2          0

52 rows selected.
*/

SELECT c.cust_id, c.cust_lname, x.product_id, x.wish_tot, x.order_tot
     FROM (SELECT cust_id, cust_lname
             FROM customers  
            WHERE city = 'Asten') c
         ,(SELECT NVL(w.cust_id, o.cust_id)       AS cust_id
                 ,NVL(w.product_id, o.product_id) AS product_id
                 ,NVL(w.wish_tot,0)               AS wish_tot
                 ,NVL(o.order_tot,0)              AS order_tot
            FROM (SELECT cust_id
                        ,product_id
                        ,SUM(unit_price * quantity) AS wish_tot
                    FROM wishlist
                   WHERE deleted = 'N'
                  GROUP BY cust_id, product_id) w
            FULL OUTER JOIN
                (SELECT o.cust_id
                       ,i.product_id
                       ,SUM(i.unit_price * i.quantity) AS order_tot
                   FROM orders o
                       ,order_items i
                  WHERE o.order_id = i.order_id 
                  GROUP BY o.cust_id, i.product_id) o
            ON o.cust_id    = w.cust_id 
           AND o.product_id = w.product_id) x 
     WHERE c.cust_id = x.cust_id 
     ORDER BY c.cust_id, x.product_id ;


SELECT c.cust_id, c.cust_lname, x.product_id, x.wish_tot, x.order_tot
       FROM (SELECT cust_id, cust_lname 
               FROM customers 
              WHERE city = 'Asten') c ,
            (SELECT cust_id
                   ,product_id
                   ,SUM(wish_tot)  AS wish_tot,
                   ,SUM(order_tot) AS order_tot
               FROM (SELECT cust_id
                           ,product_id
                           ,unit_price * quantity AS wish_tot
                           ,0                     AS order_tot
                       FROM wishlist
                      WHERE deleted = 'N'
                     UNION ALL
                     SELECT o.cust_id
                           ,i.product_id
                           ,0
                           ,i.unit_price * i.quantity AS order_tot
                      FROM orders o,
                           order_items i
                     WHERE o.order_id = i.order_id)
            GROUP BY cust_id, product_id) x
     WHERE c.cust_id = x.cust_id
    ORDER BY c.cust_id, x.product_id ;
/*
EMP 테이블에서 1981년도에 입사한 사원들을 입사 월별로 인원수를 검색하시오. 
     단, 사원이 없는 월도 함께 출력 

검색 결과

HIRE                 CNT
------------- ----------
1981/01                0
1981/02                2
1981/03                0
1981/04                1
1981/05                1
1981/06                1
1981/07                0
1981/08                0
1981/09                2
1981/10                0
1981/11                1
1981/12                2

12 rows selected.

*/
WITH THIRE AS (SELECT '1981/01' AS HIRE
               FROM DUAL 
               UNION ALL
               SELECT '1981/02' 
               FROM DUAL 
               UNION ALL
               SELECT '1981/03' 
               FROM DUAL 
               UNION ALL
               SELECT '1981/04' 
               FROM DUAL )
SELECT *
FROM THIRE A 
LEFT OUTER JOIN (SELECT TO_CHAR(HIREDATE,'YYYY/MM') AS HIRE, COUNT(*) AS CNT
                 FROM EMP
                 WHERE TO_CHAR(HIREDATE,'YYYY') = '1981'
                 GROUP BY TO_CHAR(HIREDATE,'YYYY/MM')) B
  ON A.HIRE = B.HIRE ;
 

SELECT '1981/'||LPAD(ROWNUM,2,'0') AS HIRE
FROM EMP 
WHERE ROWNUM <= 12 ;

SELECT A.HIRE, NVL(B.CNT,0)
FROM (SELECT '1981/'||LPAD(ROWNUM,2,'0') AS HIRE
      FROM EMP 
      WHERE ROWNUM <= 12) A 
LEFT OUTER JOIN (SELECT TO_CHAR(HIREDATE,'YYYY/MM') AS HIRE, COUNT(*) AS CNT
                 FROM EMP
                 WHERE TO_CHAR(HIREDATE,'YYYY') = '1981'
                 GROUP BY TO_CHAR(HIREDATE,'YYYY/MM')) B
  ON A.HIRE = B.HIRE
  ORDER BY 1;
  
SELECT *
FROM DUAL ;

SELECT ROWNUM, LEVEL 
FROM DUAL 
CONNECT BY LEVEL <= 12 ;  --공식처럼 외워부러

SELECT *
FROM DUAL ;

SELECT ROWNUM, LEVEL 
FROM DUAL 
CONNECT BY LEVEL <= 12 ; 

SELECT '1981/'||LPAD(ROWNUM,2,'0') AS HIRE
FROM DUAL 
CONNECT BY LEVEL <= 12 ; 

SELECT '1981/'||LPAD(LEVEL,2,'0') AS HIRE
FROM DUAL 
CONNECT BY LEVEL <= 12 ; 

SELECT '1981/'||LPAD(LEVEL,2,'0') AS HIRE
FROM DUAL 
CONNECT BY LEVEL <= 24 ; 

SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1))
FROM DUAL 
CONNECT BY LEVEL <= 24 ; 

SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS HIRE
FROM DUAL 
CONNECT BY LEVEL <= 12 ; 


--모범 답안 

SELECT b.hire, NVL(a.cnt,0) CNT
FROM (SELECT TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
       FROM emp
      WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
                         AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
     GROUP BY TO_CHAR(hiredate,'YYYY/MM')) a,
    (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
       FROM dual
     CONNECT BY LEVEL <= 12) b
WHERE a.hire (+) = b.hire
ORDER BY 1 ;









/*
7. EMP 테이블에서 1981년도에 입사한 사원들을 부서번호, 입사 월별로 인원수를 검색하시오. 
     단. 입사한 사원이 없는 월도 함께 출력 

검색 결과

    DEPTNO HIRE                 CNT
---------- ------------- ----------
        10 1981/01                0
        10 1981/02                0
        10 1981/03                0
        10 1981/04                0
        10 1981/05                0
        10 1981/06                1
        10 1981/07                0
        10 1981/08                0
        10 1981/09                0
        10 1981/10                0
        10 1981/11                1
        10 1981/12                0
        20 1981/01                0
        20 1981/02                0
        20 1981/03                0
        20 1981/04                1
        20 1981/05                0
        20 1981/06                0
        20 1981/07                0
        20 1981/08                0
        20 1981/09                0
        20 1981/10                0
        20 1981/11                0
        20 1981/12                1
        30 1981/01                0
        30 1981/02                2
        30 1981/03                0
        30 1981/04                0
        30 1981/05                1
        30 1981/06                0
        30 1981/07                0
        30 1981/08                0
        30 1981/09                2
        30 1981/10                0
        30 1981/11                0
        30 1981/12                1

36 rows selected. 
*/

SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
  FROM emp
 WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
                    AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
 GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM') ; 

------------------------------------------------------------------------------------------------------------------------
--SOL
SELECT b.DEPTNO, b.hire, NVL(a.cnt,0) CNT
       FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
               FROM emp
              WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
                                 AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
             GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
      RIGHT OUTER JOIN 
            (SELECT 10 AS DEPTNO, 
                    TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
               FROM dual
             CONNECT BY LEVEL <= 12
			 UNION ALL 
			 SELECT 20 AS DEPTNO, TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
               FROM dual
             CONNECT BY LEVEL <= 12
			 UNION ALL 
			 SELECT 30 AS DEPTNO, TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
               FROM dual
             CONNECT BY LEVEL <= 12) b
      ON  a.deptno = b.deptno 
	 AND  a.hire = b.hire
     ORDER BY 1,2 ;
-----------------------------------------------------------------------------------------------------------
SELECT b.DEPTNO, b.hire, NVL(a.cnt,0) CNT
       FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
               FROM emp
              WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
                                 AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
             GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
      RIGHT OUTER JOIN 
            (SELECT D.DEPTNO, H.HIRE
			   FROM (SELECT DEPTNO 
			           FROM DEPT 
			          WHERE DEPTNO <= 30)  D 
               CROSS JOIN 
                    (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
                       FROM dual
                     CONNECT BY LEVEL <= 12)  H
			) b
      ON  a.deptno = b.deptno 
	 AND  a.hire = b.hire
     ORDER BY 1,2 ;

--------------------------------------------------------------------------------------------------------
SELECT A.DEPTNO, b.hire, NVL(a.cnt,0) CNT
       FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
               FROM emp
              WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
                                 AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
             GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
             PARTITION BY (A.DEPTNO)			 
      RIGHT OUTER JOIN 
            (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') AS hire
               FROM dual
             CONNECT BY LEVEL <= 12) b
      ON a.hire = b.hire
     ORDER BY 1,2; 

/*
8. SALES, CUSTS 테이블을 이용하여 CUSTS.COUNTRY_ID가 52778 이면서 구매 내역이 하나도 없는 고객 정보를 검색하시오. 

검색 결과 

   CUST_ID CUST_LAST_NAME  CUST_YEAR_OF_BIRTH CUST_CITY           
---------- --------------- ------------------ --------------------
      4596 Lloyd                         1948 Valencia            
     19585 Ziegler                       1963 El Campello         
     43900 Underhill                     1966 Torrevieja          
     20020 Konur                         1968 Barcelona           
     41104 Gilmour                       1956 Paterna             
...
1933 rows selected. 
*/
--SQL> 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
      FROM custs 
      WHERE country_id = 52778
        AND cust_id NOT IN ( SELECT cust_id FROM sales ) ; 

--SQL> 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
      FROM custs c
      WHERE country_id = 52778
        AND NOT EXISTS ( SELECT 1
		                   FROM sales
                          WHERE cust_id = c.cust_id ) ; 

CREATE SYNONYM custs FOR test.custs;

/*
9.SALES, CUSTS 테이블을 이용하여 CUSTS.COUNTRY_ID가 52778 이면서 1998년 10월에 10건 이상의 구매 내역을 갖는 고객 정보를 검색하시오. 

검색 결과 

   CUST_ID CUST_LAST_NAME  CUST_YEAR_OF_BIRTH CUST_CITY           
---------- --------------- ------------------ --------------------
       477 Garvin                        1958 Paterna             
      2006 Laycock                       1953 Malaga              
         2 Koch                          1957 Salamanca           
      2382 Hardy                         1928 Sabadell            
...   
17 rows selected.
*/

--SQL> 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
      FROM custs c
      WHERE country_id = 52778
        AND cust_id IN ( SELECT cust_id 
		                   FROM sales
                          WHERE time_id BETWEEN TO_DATE('19981001','YYYYMMDD')
						           AND TO_DATE('19981101','YYYYMMDD') - 1/86400
                          GROUP BY cust_id
                         HAVING COUNT(cust_id) >= 10) ;

--SQL> 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
      FROM custs c
      WHERE country_id = 52778
        AND EXISTS ( SELECT *
		               FROM sales
                      WHERE time_id BETWEEN TO_DATE('19981001','YYYYMMDD')
						                AND TO_DATE('19981101','YYYYMMDD') - 1/86400
                        AND cust_id = c.cust_id
                      GROUP BY cust_id
                      HAVING COUNT(cust_id) >= 10) ;

/*
10. CUSTS.COUNTRY_ID가 52778 이면서 구매 내역이 하나도 없거나, COUNTRY_ID가 52778 이면서 1998년 10월에 10건 이상의 구매 내역을 갖는 고객 정보를 검색하시오. 단, 구매 내역이 있는 고객은 구매 수량에 대해서 함께 검색하며, 구매 수량을 기준으로 내림차순, 고객 번호는 오름차순으로 정렬합니다. 

검색 결과

   CUST_ID CUST_LAST_NAME  CUST_YEAR_OF_BIRTH CUST_CITY              CNT
---------- --------------- ------------------ --------------- ----------
      1919 Ingold                        1953 Lloret de Mar           35
       427 Hanes                         1989 Paterna                 22
      2382 Hardy                         1928 Sabadell                22
...
     50982 Neila                         1943 Elche                    0
     50984 Lein                          1936 Torrevieja               0
    102997 Drescher                      1962 Sevilla                  0

1950 rows selected.
*/

