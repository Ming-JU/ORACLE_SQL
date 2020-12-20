SELECT ENAME, LOWER(ENAME),SAL/7, ROUND(SAL/7,2),
       HIREDATE, ADD_MONTHS(HIREDATE,1)
FROM EMP;


SELECT SUM(SAL), AVG(SAL)
FROM EMP;

SELECT SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

--20201216 

SELECT ENAME, LOWER(ENAME), SAL/7, ROUND(SAL/7, 2), 
       HIREDATE, ADD_MONTHS(HIREDATE,1)
FROM EMP ;  

SELECT SUM(SAL), AVG(SAL)
FROM EMP ; 

SELECT SUM(SAL), AVG(SAL)
FROM EMP 
GROUP BY DEPTNO ; 



SELECT 1234 
FROM EMP ; 

SELECT 1234 
FROM DEPT ; 

SELECT 1234
FROM DUAL ; 

SELECT * 
FROM DUAL ; 

SELECT SYSDATE
FROM DUAL;

----------------------------------------------------------------

SELECT UPPER(ename)
      ,LOWER(ename)
      ,INITCAP(ename)
FROM emp; 

SELECT ENAME
      ,SAL
FROM emp
WHERE LOWER(ename)='scott';   

SELECT SUBSTR(ename,1,3) 
FROM emp; 

SELECT ename
      ,LENGTH(ename)
FROM emp; 

SELECT LENGTH('가나다라마')
FROM DUAL; 

SELECT LENGTHB('가나다라마') -- 문자열이 사용하는 바이트를 반환
FROM DUAL; 

SELECT ENAME
      ,INSTR(ENAME,'M') 
FROM EMP; 

SELECT INSTR('abcdefg@naver.com','@') -- 문자열이 몇번쨰에 위치하는지 반환
FROM DUAL; 


SELECT ename
      ,REPLACE(sal, 0, '*') -- 일부분을 지정한 문자열로 변환
FROM emp; 

SELECT ename
      ,LPAD(sal,10,'*') as salary1
      ,RPAD(sal,10,'*') as salary2 --오른쪽 혹은 왼쪽에  별채우기
  FROM emp; 

SELECT 'smith'
      ,LTRIM('smith','s') --S잘림
      ,RTRIM('smith','h') --H잘림
      ,TRIM('s' from 'smith') --원하는거 지정해서 제거
FROM dual; --더미테이블

SELECT * 
FROM emp 
WHERE ename = 'SCOTT' ; 

UPDATE emp 
SET ename = 'SCOTT  ' 
WHERE empno = 7788 ; 

SELECT * 
FROM emp 
WHERE ename = 'SCOTT' ; 

SELECT * 
FROM emp 
WHERE trim(ename) = 'SCOTT' ; 

SELECT ename, length(ename)
FROM emp 
WHERE empno = 7788 ; 

UPDATE emp 
SET ename = trim(ename) 
WHERE empno = 7788 ; 

SELECT ename, length(ename)
FROM emp 
WHERE empno = 7788 ; 

COMMIT ; 



----------------------------------------------------------------
SELECT 876.567
      ,ROUND(876.567,1)
      ,ROUND(876.567,0)
      ,ROUND(876.567)
      ,ROUND(876.567,-1)
FROM dual; 

SELECT 876.567
      ,TRUNC(876.567,1)
      ,TRUNC(876.567,0)
      ,TRUNC(876.567)
      ,TRUNC(876.567,-1)
FROM dual; 

SELECT MOD(10,3)
FROM DUAL; 

SELECT empno, MOD(empno,2)
FROM emp; 

SELECT empno, ename 
FROM emp
WHERE MOD(empno,2) = 0; 

SELECT 10/3, FLOOR(10/3), CEIL(10/3)
FROM DUAL;

--------------------------------------------------------------------

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL;

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY TO_CHAR(SAL); --문자에서는 1이 젤작은거라서 1100이 젤큰거로 나온다.

SELECT EMPNO, ENAME, SAL, LPAD(TO_CHAR(SAL),4,'0') --원하는 길이, 남는 왼쪽자리에 채울것 EX) 0
FROM EMP
ORDER BY 4;


SELECT TO_DATE('95/12/16','YY/MM/DD')
FROM DUAL ; 

SELECT TO_DATE('20/12/16','YY/MM/DD')
FROM DUAL ; 

SELECT TO_DATE('95/12/16','RR/MM/DD')
FROM DUAL ; 

SELECT TO_DATE('20/12/16','RR/MM/DD')
FROM DUAL ; 


SELECT SYSDATE 
FROM DUAL ; 


SELECT SESSIONTIMEZONE , SYSDATE, CURRENT_DATE
FROM DUAL ; 

SELECT DBTIMEZONE, SESSIONTIMEZONE , SYSDATE, CURRENT_DATE
FROM DUAL ; 



SELECT SYSDATE 
FROM DUAL ; 

SELECT SYSDATE + 1
      ,SYSDATE + 1/24
      ,SYSDATE + 1/1440
      ,SYSDATE + 1/86400
FROM DUAL ; 

SELECT ENAME 
      ,HIREDATE
      ,SYSDATE-HIREDATE 
FROM EMP ;

SELECT ENAME 
      ,HIREDATE
      ,TRUNC(SYSDATE-HIREDATE)
FROM EMP ;

SELECT ENAME 
      ,HIREDATE
      ,TRUNC(SYSDATE-HIREDATE)/365
FROM EMP ;

SELECT ENAME 
      ,HIREDATE
      ,SYSDATE+HIREDATE
FROM EMP ; --날짜와 날짜를 더하는것은 불가능

----------------------------------------------------------------------
SELECT ename, HIREDATE, 
       MONTHS_BETWEEN(sysdate,hiredate)
  FROM emp; 

SELECT ENAME, HIREDATE, 
       ADD_MONTHS(HIREDATE,1), ADD_MONTHS(HIREDATE,-1)
FROM EMP ; 

SELECT ENAME, HIREDATE, 
       NEXT_DAY(HIREDATE,'월요일')
FROM EMP ; 

SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE)
FROM EMP ; 

SELECT ENAME, HIREDATE
      ,ROUND(HIREDATE,'YYYY')
      ,ROUND(HIREDATE,'MM')
      ,ROUND(HIREDATE,'DD')
FROM EMP ; 


SELECT ENAME, HIREDATE
      ,TRUNC(HIREDATE,'YYYY')
      ,TRUNC(HIREDATE,'MM')
      ,TRUNC(HIREDATE,'DD')
FROM EMP ; 

SELECT SYSDATE
       ,ROUND(SYSDATE,'DD')
FROM DUAL;       

SELECT CURRENT_DATE
,TRUNC(CURRENT_DATE,'YEAR')
,TRUNC(CURRENT_DATE,'MM')
,TRUNC(CURRENT_DATE,'DD')
FROM DUAL;

------------------------------------------------------

SELECT 12 + 13
FROM DUAL;


SELECT 12 + '13'
FROM DUAL;

SELECT '12' + '13' 
FROM DUAL;  --암시적 데이터 유형 변환

SELECT *
FROM EMP
WHERE DEPTNO = '10';

SELECT '1' , 1 ,DUMP('1'), DUMP(1)
FROM DUAL;

---------------------------------------------------
SELECT EMPNO, ENAME,SAL,12,'a',
'2020/12/16',
TO_DATE('2020/12/16','YYYY/MM/DD')
FROM EMP;

SELECT ENAME
      ,HIREDATE
      ,TO_CHAR(HIREDATE, 'YYYY')
      ,TO_CHAR(HIREDATE, 'YEAR')
      ,TO_CHAR(HIREDATE, 'Year')
FROM EMP;    

SELECT ENAME
      ,TO_CHAR(HIREDATE,'MONTH')
      ,TO_CHAR(HIREDATE,'MON')
      ,TO_CHAR(HIREDATE,'MM')
FROM EMP ;

SELECT ENAME
      ,TO_CHAR(HIREDATE,'DD')
      ,TO_CHAR(HIREDATE,'DDSPTH')
FROM EMP ;


SELECT ENAME, HIREDATE, 
       TO_CHAR(HIREDATE, 'Month DD, YYYY'),
       TO_CHAR(HIREDATE, 'fmMonth DD, YYYY') 
FROM EMP ; 

SELECT ENAME, HIREDATE,
       TO_CHAR(HIREDATE, 'Q'), --쿼터:분기값
       TO_CHAR(HIREDATE, 'W'), --그 월에서의 몆주차
       TO_CHAR(HIREDATE, 'WW'), --해당연도에서의 몇주차
       TO_CHAR(HIREDATE, 'DAY'), --요일
       TO_CHAR(HIREDATE, 'DY'), --첫번쨰글자(약자)
       TO_CHAR(HIREDATE, 'Day'), --요일 소문자
       TO_CHAR(HIREDATE, 'D') --요일의 순서 일요일이 1
FROM EMP ; 

SELECT ENAME, SAL,
       TO_CHAR(SAL, '99,999.00'), --9는 자리가 비어도 아무것도 안씀 0은 비어있으면 0으로채움
       TO_CHAR(SAL, '$00,000.00'),
       TO_CHAR(SAL, 'L99,999.00')
FROM EMP;       

SELECT TO_NUMBER('12345'),'12345'
FROM DUAL;

SELECT '$1,500', TO_NUMBER('$1,500','$99,999')
FROM DUAL;


SELECT ROUND(TO_DATE('2020/12/16 00:00:00' 
                    ,'YYYY/MM/DD HH24:MI:SS'),'YYYY')
FROM DUAL;

SELECT EMPNO, ENAME, SAL, COMM, SAL + COMM
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, COMM , SAL + NVL(COMM,0)
FROM EMP ; 

SELECT MGR, NVL(MGR, 'NO MANAGER')
FROM EMP ; 

SELECT MGR, NVL(TO_CHAR(MGR), 'NO MANAGER')
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0), 
       NVL2(COMM, 'SAL+COMM', 'SAL')
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0), 
       NVL2(COMM, SAL+COMM, SAL),
       NVL2(COMM, 'SAL+COMM', 'SAL')
FROM EMP ; 

SELECT COMM,MGR, NVL(COMM,MGR)
FROM EMP ; 

SELECT COMM,MGR, NVL(COMM,NVL(MGR,NVL(SAL,NVL(EMPNO,1))))
FROM EMP ; 

SELECT COALESCE(COMM,MGR,SAL,EMPNO,1)
FROM EMP ; 


----------------------------------------------

SELECT EMPNO, ENAME, SAL, DEPTNO, 
       SAL * 1.1
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, DEPTNO, 
       SAL * 1.1
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, DEPTNO, SAL * 1.1 
FROM EMP 
WHERE DEPTNO = 10 ;

SELECT EMPNO, ENAME, SAL, DEPTNO, SAL * 1.15 
FROM EMP 
WHERE DEPTNO = 20 ;
SELECT EMPNO, ENAME, SAL, DEPTNO, SAL * 1.2
FROM EMP 
WHERE DEPTNO = 30 ;

SELECT EMPNO, ENAME, SAL, DEPTNO, 
       CASE DEPTNO WHEN 10 THEN SAL * 1.1 
                   WHEN 20 THEN SAL * 1.15 
                   WHEN 30 THEN SAL * 1.2 
       ELSE SAL * 1.3 END 
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, DEPTNO, 
       DECODE(DEPTNO,10,SAL * 1.1 
                    ,20,SAL * 1.15 
                    ,30,SAL * 1.2 
                       ,SAL * 1.3)
FROM EMP ; 

SELECT EMPNO, ENAME, SAL, DEPTNO, 
       CASE WHEN DEPTNO IN (10,20) THEN SAL * 1.1 
            WHEN DEPTNO > 20       THEN SAL * 1.15 
        ELSE SAL * 1.3 END 
FROM EMP ; 

SELECT * 
FROM V$VERSION ; 

11g, 19c


7 - 8 - 8i - 9i - 10g - 11g -  (12c - 18c - 19c - 21c)
                                         12c
