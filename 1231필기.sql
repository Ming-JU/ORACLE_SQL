--1231
CREATE SYNONYM customers FOR test.customers;
CREATE SYNONYM products FOR test.products;
CREATE SYNONYM orders FOR test.orders;
CREATE SYNONYM order_items FOR test.order_items;
CREATE SYNONYM order_cancel FOR test.order_cancel;
CREATE SYNONYM wishlist FOR test.wishlist;
CREATE SYNONYM blacklist FOR test.blacklist;
CREATE SYNONYM dormant_hist FOR test.dormant_hist;
CREATE SYNONYM custs FOR sh.customers;
CREATE SYNONYM prods FOR sh.products;
CREATE SYNONYM sales FOR sh.sales;
CREATE SYNONYM times FOR sh.times;
CREATE SYNONYM channels FOR sh.channels;
CREATE SYNONYM promotions FOR sh.promotions;
CREATE SYNONYM keynote FOR user30.keynote;
CREATE SYNONYM chatting FOR user30.chatting;
CREATE SYNONYM all_chatting FOR user30.all_chatting;
CREATE SYNONYM kospi FOR user30.kospi;

COMMIT;
-----------------------------------------------------------------------------------

SELECT * FROM CHATTING;
SELECT * FROM ALL_CHATTING;
SELECT * FROM KOSPI;
SELECT * FROM KEYNOTE;

-----------------------------------------------------------------------------------
/*
1. EMP 테이블에서 20번 부서에 근무하는 사원들을 입사 일자를 기준으로 정렬하여 다음과 같이 검색하시오. 
     START_DATE : 입사 일자가 포함된 한 주의 시작일 (일요일)
     END_DATE   : 입사 일자가 포함된 한 주의 종료일 (토요일) 

검색 결과

     EMPNO ENAME      HIREDATE   DAY          START_DATE END_DATE  
---------- ---------- ---------- ------------ ---------- ----------
      7369 SMITH      1980/12/17 WED          1980/12/14 1980/12/20
      7566 JONES      1981/04/02 THU          1981/03/29 1981/04/04
      7902 FORD       1981/12/03 THU          1981/11/29 1981/12/05
      7788 SCOTT      1987/04/19 SUN          1987/04/19 1987/04/25
      7876 ADAMS      1987/05/23 SAT          1987/05/17 1987/05/23

5 rows selected.
*/

SELECT EMPNO, ENAME,HIREDATE, TO_CHAR(HIREDATE, 'DY') , 
        TRUNC(HIREDATE,'DY') START_DATE, TRUNC(HIREDATE+6,'DAY')-1 END_DATE
FROM EMP
WHERE DEPTNO = 20
ORDER BY HIREDATE;

SELECT *
FROM EMP;
-------------------------------------------------------------------------------------------------


/*
2.SALES 테이블에서, TIME_ID 컬럼의 값이 '1998/05/01' 일을 포함한 한 주(일요일-토요일)의 판매 내역을 요일 별로 금액(AMOUNT_SOLD) 합계를 검색하시오. 단, 검색 결과는 일요일부터 토요일까지 정렬합니다. 

검색 결과

DAY             SUM(AMOUNT_SOLD)
--------------- ----------------
Sunday                 213986.56
Monday                  86039.97
Tuesday                 26093.72
Wednesday               17584.96
Thursday                99296.19
Friday                  11996.05
Saturday                25852.07

7 rows selected.
*/
SELECT TO_CHAR(time_id, 'Day') AS day, SUM(amount_sold) 
     FROM sales 
     WHERE time_id BETWEEN TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'D') 
                       AND TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'D') + 7 - 1/86400 
     GROUP BY time_id 
     ORDER BY time_id ;

추가 실습 

DROP TABLE T1 PURGE; 
CREATE TABLE t1 (c1    NUMBER, c2    DATE) ; 
INSERT INTO t1 
 SELECT level, ADD_MONTHS(SYSDATE,-3) + level - 1 
   FROM dual 
 CONNECT BY level <= 200 ; 
COMMIT ; 
SELECT c1, TO_CHAR(c2, 'YYYY/MM/DD HH24:MI:SS') AS DT
   FROM t1 
 ORDER BY c1 ;

SELECT * FROM t1

--오늘		
WHERE c2 BETWEEN TRUNC(SYSDATE) 
     AND TRUNC(SYSDATE+1) - 1/86400 ;
--어제		
WHERE c2 BETWEEN TRUNC(SYSDATE-1) 
      AND TRUNC(SYSDATE) - 1/86400 ; 
--내일		
WHERE c2 BETWEEN TRUNC(SYSDATE+1) 
     AND TRUNC(SYSDATE+2) - 1/86400 ;
--이번 주	
WHERE c2 BETWEEN TRUNC(SYSDATE,'D') 
     AND TRUNC(SYSDATE,'D') + 7 - 1/86400 ;
--지난 주	
WHERE c2 BETWEEN TRUNC(SYSDATE-7,'D') 
     AND TRUNC(SYSDATE-7,'D') + 7 - 1/86400 ;
--다음 주	
WHERE c2 BETWEEN TRUNC(SYSDATE+7,'D') 
      AND TRUNC(SYSDATE+7,'D') + 7 - 1/86400 ;
--이번 달	
WHERE c2 BETWEEN TRUNC(SYSDATE,'MM') 
      AND TRUNC(ADD_MONTHS(SYSDATE,1),'MM') - 1/86400 ;
--지난 달	
WHERE c2 BETWEEN TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')
      AND TRUNC(SYSDATE,'MM') - 1/86400 ;
--다음 달	
WHERE c2 BETWEEN TRUNC(ADD_MONTHS(SYSDATE,1),'MM')
      AND TRUNC(ADD_MONTHS(SYSDATE,2),'MM') - 1/86400 ;


-----------------------------------------------------------------------------------------------
/*
3.다음 명령문을 실행하여 실습 테이블을 만들고, 오늘이 포함된 달의 일자를 검색하면서 주차를 표시하시오. 
     (FWEEK: 회계기준의 주차, CWEEK: 달력의 주차)
*/
DROP TABLE T1 PURGE ; 
CREATE TABLE t1 (c1    NUMBER, c2    DATE) ; 

INSERT INTO t1 
SELECT level, TRUNC(ADD_MONTHS(SYSDATE,-3)) + level - 1 
FROM dual 
CONNECT BY level <= 200 ; 

COMMIT ; 
SELECT c1, c2
FROM t1 
ORDER BY c1 ;

SELECT *
FROM T1 
WHERE c2 BETWEEN TRUNC(SYSDATE,'MM') 
             AND TRUNC(ADD_MONTHS(SYSDATE,1),'MM') - 1/86400 ;

SELECT C1, C2, TO_CHAR(C2,'W')
FROM T1 
WHERE c2 BETWEEN TRUNC(SYSDATE,'MM') 
             AND TRUNC(ADD_MONTHS(SYSDATE,1),'MM') - 1/86400 ;

SELECT c1
           ,c2
       	   ,TO_CHAR(c2,'W') AS FWEEK
       	   ,(TRUNC(C2,'D') - TRUNC(TRUNC(C2,'MM'),'D'))/7 + 1 AS CWEEK
       FROM t1 
       WHERE c2 BETWEEN TRUNC(SYSDATE,'MM')
                    AND TRUNC(ADD_MONTHS(SYSDATE,1),'MM')-1/86400 ; 

SELECT TIME_ID, SUM(AMOUNT_SOLD)
FROM SALES
WHERE TIME_ID BETWEEN TO_DATE('19980501','YYYYMMDD')
                 AND  TO_DATE('19980601','YYYYMMDD') - 1/86400
GROUP BY TIME_ID 
ORDER BY 1 ;


/*
        C1 C2                 
---------- -------------------
         1 2020/09/30 00:00:00
         2 2020/10/01 00:00:00
         3 2020/10/02 00:00:00
         4 2020/10/03 00:00:00
         5 2020/10/04 00:00:00
         6 2020/10/05 00:00:00
         7 2020/10/06 00:00:00
         8 2020/10/07 00:00:00
         9 2020/10/08 00:00:00
        10 2020/10/09 00:00:00
        11 2020/10/10 00:00:00
        12 2020/10/11 00:00:00
...


검색 결과 

        C1 C2                  FWEEK      CWEEK
---------- ------------------- ----- ----------
        63 2020/12/01 00:00:00 1              1
        64 2020/12/02 00:00:00 1              1
        65 2020/12/03 00:00:00 1              1
        66 2020/12/04 00:00:00 1              1
        67 2020/12/05 00:00:00 1              1
        68 2020/12/06 00:00:00 1              2
        69 2020/12/07 00:00:00 1              2
        70 2020/12/08 00:00:00 2              2
        71 2020/12/09 00:00:00 2              2
        72 2020/12/10 00:00:00 2              2
        73 2020/12/11 00:00:00 2              2
        74 2020/12/12 00:00:00 2              2
        75 2020/12/13 00:00:00 2              3
        76 2020/12/14 00:00:00 2              3
        77 2020/12/15 00:00:00 3              3
        78 2020/12/16 00:00:00 3              3
        79 2020/12/17 00:00:00 3              3
        80 2020/12/18 00:00:00 3              3
        81 2020/12/19 00:00:00 3              3
        82 2020/12/20 00:00:00 3              4
        83 2020/12/21 00:00:00 3              4
        84 2020/12/22 00:00:00 4              4
        85 2020/12/23 00:00:00 4              4
        86 2020/12/24 00:00:00 4              4
        87 2020/12/25 00:00:00 4              4
        88 2020/12/26 00:00:00 4              4
        89 2020/12/27 00:00:00 4              5
        90 2020/12/28 00:00:00 4              5
        91 2020/12/29 00:00:00 5              5
        92 2020/12/30 00:00:00 5              5
        93 2020/12/31 00:00:00 5              5

31개 행이 선택되었습니다. 

*/


/*4.EMPLOYEES 테이블을 이용하여 부서별 최대 급여를 받는 사원 정보를 검색하시오. 

검색 결과 

LAST_NAME                     SALARY JOB_ID     DEPARTMENT_ID
------------------------- ---------- ---------- -------------
Whalen                          4400 AD_ASST               10
Hartstein                      13000 MK_MAN                20
Higgins                        12008 AC_MGR               110
King                           24000 AD_PRES               90
Hunold                          9000 IT_PROG               60
Mourgos                         5800 ST_MAN                50
Abel                           11000 SA_REP                80

7 rows selected.
*/
SELECT e.last_name, e.salary, e.job_id, e.department_id
       FROM employees e
      WHERE e.salary = ( SELECT MAX(salary) 
                           FROM employees se
                          WHERE se.department_id = e.department_id ) ;
                          
                          
SELECT e.last_name, e.salary, e.job_id, e.department_id
       FROM EMPLOYEES E
       JOIN (SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SAL 
               FROM EMPLOYEES 
              GROUP BY DEPARTMENT_ID) M 
        ON E.DEPARTMENT_ID = M.DEPARTMENT_ID 
       AND E.SALARY        = M.MAX_SAL ; 
       
       

SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP ; 

SELECT DEPTNO, EMPNO, ENAME, SAL, MAX(SAL)
FROM EMP 
GROUP BY DEPTNO ;

SELECT * 
FROM (SELECT DEPTNO, EMPNO, ENAME, SAL, 
             MAX(SAL) OVER(PARTITION BY DEPTNO) AS MAX_SAL 
       FROM EMP) 
WHERE SAL = MAX_SAL ;


SELECT last_name, 
            salary, 
            job_id, 
            department_id
      FROM ( SELECT last_name, 
                    salary, 
                    job_id, 
                    department_id, 
                    MAX(salary) OVER(PARTITION BY department_id) AS max
              FROM employees e) 
     WHERE salary = max ;




/*5.EMP 테이블에서 급여를 가장 많이 받는 2명을 검색하시오. 
        단, 동일한 급여를 받는 사원이 둘 이상 있다면 함께 검색한다. 

검색 결과

     EMPNO ENAME             SAL     DEPTNO
---------- ---------- ---------- ----------
      7839 KING             5000         10
      7902 FORD             3000         20
      7788 SCOTT            3000         20

3 rows selected.
*/
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM (SELECT * 
        FROM EMP 
       ORDER BY SAL DESC) 
WHERE ROWNUM <= 2 ; 
   
SQL> SELECT empno, ename, sal, deptno
       FROM emp
      WHERE sal IN (SELECT sal
                      FROM (SELECT DISTINCT sal
                              FROM emp
                            ORDER BY sal DESC)
                     WHERE rownum <= 2)
     ORDER BY sal DESC ;


SELECT RANK()       OVER(ORDER BY SAL DESC) AS RK
      ,DENSE_RANK() OVER(ORDER BY SAL DESC) AS DK
      ,ROW_NUMBER() OVER(ORDER BY SAL DESC) AS RN
      ,E.*
FROM EMP E; 

SELECT empno, ename, sal, deptno 
       FROM (SELECT empno, ename, sal, deptno, RANK() OVER (ORDER BY sal DESC) AS rank 
               FROM emp)  
      WHERE rank <= 2 ;

SELECT empno, ename, sal
     FROM emp 
     ORDER BY sal DESC 
     FETCH FIRST 2 ROWS WITH TIES ; 



/*
6.EMP 테이블에서, 부서별(DEPTNO) 가장 많은 급여(SAL)를 받는 사원을 한 명씩 검색하시오.
        단, 동일한 급여를 받는 사원이 여러 명일 경우에도 한 명만 검색한다. 

검색 결과

     EMPNO ENAME             SAL     DEPTNO
---------- ---------- ---------- ----------
      7839 KING             5000         10
      7788 SCOTT            3000         20
      7698 BLAKE            2850         30
*/
SELECT EMPNO,ENAME,SAL,DEPTNO
  FROM (SELECT EMPNO,ENAME,SAL,DEPTNO
  FROM EMP
  GROUP BY ;
        
SELECT empno, ename, sal, deptno
       FROM ( SELECT * 
              FROM emp 
              WHERE deptno = 10
              ORDER BY sal DESC ) 
       WHERE rownum = 1 
       UNION ALL 
      SELECT empno, ename, sal, deptno
       FROM ( SELECT * 
              FROM emp 
              WHERE deptno = 20
              ORDER BY sal DESC ) 
      WHERE rownum = 1
      UNION ALL 
      SELECT empno, ename, sal, deptno
        FROM ( SELECT * 
               FROM emp 
              WHERE deptno = 30
              ORDER BY sal DESC ) 
      WHERE rownum = 1 ; 

SELECT empno, ename, sal, deptno 
   FROM emp a
  WHERE sal = ( SELECT MAX(sal) 
                  FROM emp 
                 WHERE deptno = a.deptno ) 
  ORDER BY deptno ;

SELECT empno, ename, sal, deptno
   FROM (SELECT empno, ename, sal, deptno, 
                ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rank 
           FROM emp ) 
  WHERE rank = 1 ; 
        
/*7.CHATTING 테이블에서 학생별 채팅 횟수를 다음과 같이 검색하시오. 가장 많은 횟수부터 검색

검색 결과 

NAME              CNT
--------------- -----
오대남             72
안정민             61
정다은             49
권우철             49
이준호             48
김윤아             46
강민주             34
양귀재             32
백승민             27
우성호             26
한지현             26
나해린             24
최수림             23
정인하             22
조민호             21
김효준             19
김수지             16
오주한             15
양채현             14
이은성              1

20개 행이 선택되었습니다. 
*/
SELECT  FROM CHATTING;

SELECT SUBSTR(text,14,3) AS NAME, SUBSTR(text,26) AS text
FROM chatting
ORDER BY ; 

SELECT name, COUNT(*) AS CNT 
FROM (SELECT SUBSTR(text,14,3) AS NAME, SUBSTR(text,26) AS text
      FROM chatting)
GROUP BY name 
ORDER BY cnt DESC ;

/*
8. ALL_CHATTING 테이블에서 날짜별, 학생별 채팅 횟수를 다음과 같이 검색하시오. 날짜와 채팅 횟수를 기준으로 정렬

검색 결과 

YYMMDD   NAME              COUNT(*)
-------- --------------- ----------
20201214 오대남(PC)              90
20201214 안정민                  77
20201214 김윤아                  58
20201214 정다은                  58
20201214 권우철                  56
...
129개 행이 선택되었습니다. 
*/
SELECT SUBSTR(TEXT, 1, 8) AS YYMMDD
      ,SUBSTR(TEXT, INSTR(TEXT, '발신자')+4, INSTR(TEXT, '수신자') - INSTR(TEXT, '발신자') -4) AS NAME, COUNT(*)
FROM ALL_CHATTING
GROUP BY SUBSTR(TEXT, 1, 8), SUBSTR(TEXT, INSTR(TEXT, '발신자')+4, INSTR(TEXT, '수신자') - INSTR(TEXT, '발신자') -4)
ORDER BY 1, 3 DESC;

SELECT SUBSTR(text,1,8)  AS YYMMDD
            ,REGEXP_SUBSTR(text,'(발신자 )(.+)( 수신자 모두)',1,1,'i',2) AS NAME      
            ,REGEXP_SUBSTR(text,'(수신자 모두 : )(.+)',1,1,'i',2)       AS TEXT
FROM all_chatting ; 

SELECT yymmdd, name, count(*) 
FROM (SELECT SUBSTR(text,1,8)  AS YYMMDD
            ,REGEXP_SUBSTR(text,'(발신자 )(.+)( 수신자 모두)',1,1,'i',2) AS NAME      
            ,REGEXP_SUBSTR(text,'(수신자 모두 : )(.+)',1,1,'i',2)       AS TEXT
      FROM all_chatting)
GROUP BY yymmdd, name 
ORDER BY 1, 3 DESC ;

/*KEYNOTE 테이블에서 단어별 사용된 횟수를 검색 (횟수를 기준으로 내림차순 정렬)

검색 결과

WORD                   CNT
-------------------- -----
the                    101
to                      72
and                     66
of                      57
a                       54
in                      52
that                    35
we                      31
I                       29
America                 21
...
803개 행이 선택되었습니다.
*/
SELECT WORD, COUNT(*) AS CNT 
FROM (SELECT DECODE(B.NO,1,REGEXP_SUBSTR(TEXT,'([[:alpha:]]+)( )',1,1,'i',1)
                               ,REGEXP_SUBSTR(TEXT,'( )([[:alpha:]]+)',1,B.NO-1,'i',2)) AS WORD
               FROM KEYNOTE A 
               CROSS JOIN 
                   (SELECT LEVEL AS NO 
                      FROM DUAL
                    CONNECT BY LEVEL <= 242) B )
WHERE WORD IS NOT NULL  
GROUP BY WORD  
ORDER BY CNT DESC ;

/*
10. KOSPI_EXT 테이블을 이용하여, 종목별 종가에 대한 5일 이동평균 값을 계산하시오. 

검색 결과 

STID   STDATE          CLOSE       MAVG
------ ---------- ---------- ----------
000880 2000/01/04       6442       6442
000880 2000/01/05       5994       6218
000880 2000/01/06       5538    5991.33
000880 2000/01/07       5547    5880.25
000880 2000/01/10       5592     5822.6
000880 2000/01/11       5950     5724.2
000880 2000/01/12       5744     5674.2
...
13,089개 행이 선택되었습니다. 
*/
SELECT stid, stdate, close,
       ROUND(AVG(close) 
             OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
FROM kospi ; 

SELECT *
FROM (SELECT stid, stdate, close,
             ROUND(AVG(close) 
                OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
      FROM kospi) A 
WHERE stdate IN (SELECT LAST_DAY(ADD_MONTHS(TO_DATE('20000101','YYYYMMDD'),LEVEL-1))
                 FROM DUAL  
                 CONNECT BY LEVEL <= 220); 

/*
11.KOSPI 테이블을 이용하여, 종목별 거래 마지막일의 5일 이동평균 값을 검색하시오. 

검색 결과

STID           MA
------ ----------
000880      46560
003280       1531
003490      36610
*/
SELECT stid, MAX(mavg) KEEP(DENSE_RANK FIRST ORDER BY stdate DESC) AS MA
FROM (SELECT stid, stdate, close,
             ROUND(AVG(close) 
                OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
      FROM kospi)
GROUP BY stid; 

