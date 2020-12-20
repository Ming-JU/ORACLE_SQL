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

SELECT LENGTH('�����ٶ�')
FROM DUAL; 

SELECT LENGTHB('�����ٶ�') -- ���ڿ��� ����ϴ� ����Ʈ�� ��ȯ
FROM DUAL; 

SELECT ENAME
      ,INSTR(ENAME,'M') 
FROM EMP; 

SELECT INSTR('abcdefg@naver.com','@') -- ���ڿ��� ������� ��ġ�ϴ��� ��ȯ
FROM DUAL; 


SELECT ename
      ,REPLACE(sal, 0, '*') -- �Ϻκ��� ������ ���ڿ��� ��ȯ
FROM emp; 

SELECT ename
      ,LPAD(sal,10,'*') as salary1
      ,RPAD(sal,10,'*') as salary2 --������ Ȥ�� ���ʿ�  ��ä���
  FROM emp; 

SELECT 'smith'
      ,LTRIM('smith','s') --S�߸�
      ,RTRIM('smith','h') --H�߸�
      ,TRIM('s' from 'smith') --���ϴ°� �����ؼ� ����
FROM dual; --�������̺�

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
ORDER BY TO_CHAR(SAL); --���ڿ����� 1�� �������Ŷ� 1100�� ��ū�ŷ� ���´�.

SELECT EMPNO, ENAME, SAL, LPAD(TO_CHAR(SAL),4,'0') --���ϴ� ����, ���� �����ڸ��� ä��� EX) 0
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
FROM EMP ; --��¥�� ��¥�� ���ϴ°��� �Ұ���

----------------------------------------------------------------------
SELECT ename, HIREDATE, 
       MONTHS_BETWEEN(sysdate,hiredate)
  FROM emp; 

SELECT ENAME, HIREDATE, 
       ADD_MONTHS(HIREDATE,1), ADD_MONTHS(HIREDATE,-1)
FROM EMP ; 

SELECT ENAME, HIREDATE, 
       NEXT_DAY(HIREDATE,'������')
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
FROM DUAL;  --�Ͻ��� ������ ���� ��ȯ

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
       TO_CHAR(HIREDATE, 'Q'), --����:�бⰪ
       TO_CHAR(HIREDATE, 'W'), --�� �������� �p����
       TO_CHAR(HIREDATE, 'WW'), --�ش翬�������� ������
       TO_CHAR(HIREDATE, 'DAY'), --����
       TO_CHAR(HIREDATE, 'DY'), --ù��������(����)
       TO_CHAR(HIREDATE, 'Day'), --���� �ҹ���
       TO_CHAR(HIREDATE, 'D') --������ ���� �Ͽ����� 1
FROM EMP ; 

SELECT ENAME, SAL,
       TO_CHAR(SAL, '99,999.00'), --9�� �ڸ��� �� �ƹ��͵� �Ⱦ� 0�� ��������� 0����ä��
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
