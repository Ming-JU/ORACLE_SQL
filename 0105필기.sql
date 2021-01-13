--0105
SELECT cust_id, cust_fname, phone_number,
       '('||SUBSTR(PHONE_NUMBER,1,3)||') '||SUBSTR(PHONE_NUMBER,5),
       REGEXP_REPLACE(phone_number,'(\d{3})-(\d{3})-(\d{4})','(\1) \2-\3') AS NEW_PHONE
FROM customers
WHERE REGEXP_LIKE(phone_number,'^\d');

SELECT REGEXP_INSTR ('01210298204395834096824350692340952348527123456783498527346902845602940239458029348502394852039458203458203495820349582034958230498203495682409843059739845127346521123456788974502345684586729834573290458045962405693456789', -- Source
                     '(123)(4(56)(78))', -- Pattern
                     1, -- position
                     1, -- occurren
                     ce
                     0, -- return option
                    'i', -- match parameter
                     2 ) "Position" -- Subexpression
FROM dual ;

SELECT REGEXP_INSTR ('0121021234567898204395834096824350692340952348527123456783498527346902845602940239458029348502394852039458203458203495820349582034958230498203495682409843059739845127346521123456788974502345684586729834573290458045962405693456789', -- Source
                     '(123)(4(56)(78))', -- Pattern
                     1, -- position
                     3, -- occurrence
                     0, -- return option
                    'i', -- match parameter
                     2 ) "Position" -- Subexpression
FROM dual ;

/*
SQL 
: DB의 데이터를 제어,조작하는 언어 
단문 형식 (한 번에 하나의 명령문만 실행)
변수 선언 X 
제어문 (로직) 생성 불가능 
예외처리 불가능 
PL/SQL 
: 
화면 구성 불가능 
배치 업무 


BEGIN 
  SELECT  ....

  UPDATE ....

  INSERT ...

  DELETE ....
END ; 
/

*/
SET SERVEROUTPUT ON --설정이필요함/ 설정안되면 결과안보임! 
DECLARE
  v_hiredate 	DATE ;
  v_deptno 	NUMBER(2) NOT NULL 	:= 10 ; --NULL값 들어올수없음
  v_location 	VARCHAR2(13)    := 'Atlanta';
  c_comm 	CONSTANT NUMBER 	:= 1400 ; --CONSTANT:상수로 작업 // 모두 단일값만 가능
BEGIN 
  DBMS_OUTPUT.PUT_LINE ( v_hiredate ) ; 
  DBMS_OUTPUT.PUT_LINE ( v_deptno ) ; 
  DBMS_OUTPUT.PUT_LINE ( v_location ) ; 
  DBMS_OUTPUT.PUT_LINE ( c_comm ) ; 
END ; 
/

SET SERVEROUTPUT ON
DECLARE 
   V_ENAME VARCHAR2(10);
   V_SAL   NUMBER(7,2);
BEGIN
   SELECT ENAME, SAL INTO V_ENAME, V_SAL
   FROM EMP
   WHERE EMPNO = 7788;
END;
/

SELECT * 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'EMP' ;

ALTER TABLE EMP 
DROP CONSTRAINT SYS_C007204 ;

SELECT * 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'EMP' ;


--------------------------------------------------------------------
INSERT INTO EMP (EMPNO,ENAME,SAL,DEPTNO) VALUES (1111,'RYU',1000,10) ; 

UPDATE EMP_SUM
SET SUM_SAL = SUM_SAL + 1000 
WHERE DEPTNO = 10 ; 
--------------------------------------------------------------------
SELECT SAL, DEPTNO
FROM EMP 
WHERE EMPNO = 7876 ; 

UPDATE EMP 
SET SAL = 2000 
WHERE EMPNO = 7876 ; 

UPDATE EMP_SUM
SET SUM_SAL = SUM_SAL - 1100 + 2000 
WHERE DEPTNO = 20 ;
--------------------------------------------------------------------
SELECT SAL, DEPTNO
FROM EMP 
WHERE EMPNO = 1111 ; 

DELETE EMP 
WHERE EMPNO = 1111 ; 

UPDATE EMP_SUM
SET SUM_SAL = SUM_SAL - 1000 
WHERE DEPTNO = 10 ;
--------------------------------------------------------------------

SELECT * 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'EMP' ;


INSERT INTO EMP (EMPNO,ENAME,SAL,DEPTNO) VALUES (1111,'RYU',1000,10) ; 

UPDATE EMP_SUM
SET SUM_SAL = SUM_SAL + 1000 
WHERE DEPTNO = 10 ; 

ROLLBACK; 


BEGIN 
  INSERT INTO EMP (EMPNO,ENAME,SAL,DEPTNO) VALUES (1111,'RYU',1000,10) ; 

  UPDATE EMP_SUM
  SET SUM_SAL = SUM_SAL + 1000 
  WHERE DEPTNO = 10 ; 
--COMMIT;
END ; 
/


SELECT * FROM EMP_SUM ; 

SELECT DEPTNO, SUM(SAL) AS SUM_SAL 
FROM EMP 
GROUP BY DEPTNO ; 
/
ROLLBACK;


--------------------------------------------------------------------
SELECT SAL, DEPTNO
FROM EMP 
WHERE EMPNO = 7876 ; 

UPDATE EMP 
SET SAL = 2000 
WHERE EMPNO = 7876 ; 

UPDATE EMP_SUM
SET SUM_SAL = SUM_SAL - 1100 + 2000 
WHERE DEPTNO = 20 ;
--------------------------------------------------------------------
BEGIN 
  SELECT SAL, DEPTNO
  FROM EMP 
  WHERE EMPNO = 7876 ; 

  UPDATE EMP 
  SET SAL = 2000 
  WHERE EMPNO = 7876 ; 

  UPDATE EMP_SUM
  SET SUM_SAL = SUM_SAL - 1100 + 2000 
  WHERE DEPTNO = 20 ;
END ;
/ --각각의 결과는 PL/SQL블럭으로만 리턴
---------------------------------------------------------------------
DECLARE 
  V_SAL       EMP.SAL%TYPE ;
  V_DEPTNO    EMP.DEPTNO%TYPE ; 
BEGIN 
  SELECT SAL, DEPTNO INTO V_SAL, V_DEPTNO
  FROM EMP 
  WHERE EMPNO = 7876 ; 

  UPDATE EMP 
  SET SAL = 2000 
  WHERE EMPNO = 7876 ; 

  UPDATE EMP_SUM
  SET SUM_SAL = SUM_SAL - V_SAL + 2000 
  WHERE DEPTNO = V_DEPTNO ;
END ;
/

SELECT * FROM EMP WHERE EMPNO = 7876 ; 

SELECT * FROM EMP_SUM ; 

SELECT DEPTNO, SUM(SAL) AS SUM_SAL 
FROM EMP 
GROUP BY DEPTNO ; 


ROLLBACK ;

--------------------------------------------------------------------
DECLARE
    V_SAL       EMP.SAL%TYPE;
    V_DEPTNO    EMP.DEPTNO%TYPE;
BEGIN
    SELECT SAL, DEPTNO INTO V_SAL, V_DEPTNO
    FROM EMP 
    WHERE EMPNO = 7876 ; 
    
    DELETE EMP 
    WHERE EMPNO = 7876 ; 
    
    UPDATE EMP_SUM
    SET SUM_SAL = SUM_SAL - V_SAL 
    WHERE DEPTNO = V_DEPTNO ;
END;    
/

SELECT * FROM EMP;

ROLLBACK;
--------------------------------------------------------------------


SELECT SAL, DEPTNO
FROM EMP
WHERE EMPNO = 7876;

--------------------------------------------------------------------

BEGIN
  DROP TABLE EMP ; 
END ; 
/

BEGIN
  SELECT 
 -- DML - INSERT, UPDATE, DELETE, MERGE 
 -- TCL - COMMIT, ROLLBACK, SAVEPOINT 
 -- INTO절이 꼭 필요, 하나의 행만 반환
END;
/

---------------------------------------------------------------------
SELECT *
FROM SALES--50개씩 잘라서 보여주는 화면 : CURSOR

BEGIN
    DELETE EMP WHERE EMPNO = 7788;
    DELETE EMP WHERE DEPTNO = 10;
END;
/

SELECT * FROM EMP ;
ROLLBACK ; 

BEGIN
   DELETE EMP WHERE EMPNO = 7788 ;
   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' ROWS DELETED');
   
   DELETE EMP WHERE DEPTNO = 10 ; 
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' ROWS DELETED');

END ;
/


SET SERVEROUTPUT ON 
BEGIN
   DELETE EMP WHERE EMPNO = 7788 ;
  
   IF SQL%FOUND THEN 
      DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' rows deleted');  
   ELSE 
      DBMS_OUTPUT.PUT_LINE('NO DELETED');  
   END IF ; 

   DELETE EMP WHERE DEPTNO = 10 ; 
   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' rows deleted'); 
END ;
/

ROLLBACK;

--BEGININSERTINTOEMPVALUES(1111,'RYU',10);END;

-------------------------------------------------------------------------
-- SELECT 문

SET SERVEROUTPUT ON 
DECLARE 
   v_ename	     VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE empno = 7788 ; 

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/
/*
SCOTT : 3000
PL/SQL procedure successfully completed.
*/

SET SERVEROUTPUT ON 
DECLARE 
   v_ename	VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE deptno = 10 ; 

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/
/*
ERROR at line 1:
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 5
?*/
SET SERVEROUTPUT ON 
DECLARE 
   v_ename	VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE empno = 1111 ; 

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/
/*
ERROR at line 1:
ORA-01403: no data found
ORA-06512: at line 5
*/
-----------------------------------------------------------------------------------
--DDL, DCL 문

BEGIN 
  DROP TABLE emp ; 
END ;
/
/*
ERROR at line 2:
ORA-06550: line 2, column 3:
PLS-00103: Encountered the symbol "DROP" when expecting one of the following:
( begin case declare exit for goto if loop mod null pragma raise return select update while with <an identifier> <a double-quoted delimited-identifier> <a bind variable> <<continue close current delete fetch lock insert open rollback
savepoint set sql execute commit forall merge pipe purge
*/
---------------------------------------------------------------------
--제어 구조 작성

--※ IF 문
SET SERVEROUTPUT ON
DECLARE
  v_myage	NUMBER := 10 ;
BEGIN
  IF v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
  END IF;
END;
/
/*
I am a child
PL/SQL procedure successfully completed.
*/
DECLARE
  v_myage	NUMBER := 31 ;
BEGIN
  IF v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
  ELSE
    DBMS_OUTPUT.PUT_LINE(' I am not a child ');
  END IF;
END;
/
/*
I am not a child
PL/SQL procedure successfully completed.
*/
DECLARE
  v_myage	NUMBER ;
BEGIN
  IF v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
  ELSE
    DBMS_OUTPUT.PUT_LINE(' I am not a child ');
  END IF;
END;
/
/*
I am not a child
PL/SQL procedure successfully completed.
*/
DECLARE
  v_myage 	NUMBER := 31 ;
BEGIN
  IF v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
    ELSIF v_myage < 20 THEN
      DBMS_OUTPUT.PUT_LINE(' I am young ');
    ELSIF v_myage < 30 THEN
      DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
    ELSIF v_myage < 40 THEN
      DBMS_OUTPUT.PUT_LINE(' I am in my thirties');
  ELSE
    DBMS_OUTPUT.PUT_LINE(' I am always young ');
  END IF;
END;
/
/*
I am in my thirties
PL/SQL procedure successfully completed.
*/

------------------------------------------------------------------
--※ CASE 표현식

DECLARE
  v_grade	CHAR(1) := UPPER('&grade') ;
  v_appraisal	VARCHAR2(20) ;
BEGIN
  v_appraisal := CASE v_grade	WHEN 'A' THEN 'Excellent'
				           WHEN 'B' THEN 'Very Good'
				           WHEN 'C' THEN 'Good'
		         ELSE 'No such grade'
		      END;
  DBMS_OUTPUT.PUT_LINE ('Grade: '|| v_grade || ' Appraisal ' || v_appraisal);
END;
/
/*
Enter value for grade: B
old   2:   v_grade      CHAR(1) := UPPER('&grade') ;
new   2:   v_grade      CHAR(1) := UPPER('B') ;
Grade: B Appraisal Very Good
PL/SQL procedure successfully completed.
*/

--※ CASE 문

DECLARE 
  v_sum		NUMBER ; 
  v_deptno	NUMBER := &deptid ; 
BEGIN 
  CASE v_deptno 
     WHEN 10 THEN 
	SELECT SUM(sal) INTO v_sum
	FROM emp
	WHERE deptno = 10 ; 
     WHEN 20 THEN
	SELECT SUM(sal) INTO v_sum
	FROM emp
	WHERE deptno = 20 ; 
     WHEN 30 THEN
	SELECT SUM(sal) INTO v_sum
	FROM emp
	WHERE deptno = 30 ; 
     ELSE
	SELECT SUM(sal) INTO v_sum FROM emp ; 
     END CASE ;
  DBMS_OUTPUT.PUT_LINE ( v_sum ) ; 
END ;
/
/*
Enter value for deptid: 30
old   3:   v_deptno     NUMBER := &deptid ;
new   3:   v_deptno     NUMBER := 30 ;
9400
PL/SQL procedure successfully completed.
*/
--------------------------------------------------------------

-- Loop 문 
SET SERVEROUTPUT ON
DECLARE
  v_count	NUMBER(2) := 1 ;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(v_count)) ;
    v_count := v_count + 1 ;
    EXIT WHEN v_count = 4 ;
  END LOOP ;
END;
/
/*
count: 1
count: 2
count: 3
PL/SQL procedure successfully completed.

*/
DECLARE
     v_count   NUMBER(2) := 1 ;
BEGIN
  WHILE  v_count <= 3  LOOP
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(v_count)) ;
    v_count :=  v_count + 1 ;
  END  LOOP ;
END ;
/
/*
count: 1
count: 2
count: 3
PL/SQL procedure successfully completed.
*/
BEGIN 
  FOR i IN 1..3 LOOP 
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(i)) ;
  END LOOP ;
END ;
/
/*
count: 1
count: 2
count: 3
PL/SQL procedure successfully completed.
*/
?
BEGIN 
  FOR i IN REVERSE 1..3 LOOP 
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(i)) ;
  END LOOP ;
END ;
/
/*
count: 3
count: 2
count: 1
PL/SQL procedure successfully completed.
*/
--※ Nested Loops

DECLARE 
  x	NUMBER := 3 ;
  y	NUMBER ;
BEGIN 
  <<OUTER_LOOP>>
  LOOP
    y := 1 ;
    EXIT WHEN x > 5 ; 
    <<INNER_LOOP>>
    LOOP 
      DBMS_OUTPUT.PUT_LINE ( x || ' * ' || y || ' = ' || x * y ) ; 
    --  EXIT OUTER_LOOP WHEN x*y > 15 ; 
      y := y + 1 ; 
      EXIT WHEN y > 5 ; 
    END LOOP INNER_LOOP ; 
    x := x + 1 ; 
  END LOOP OUTER_LOOP ; 
END ;
/

/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
5 * 1 = 5
...
PL/SQL procedure successfully completed.
*/

DECLARE 
  x	NUMBER := 3 ;
  y	NUMBER ;
BEGIN 
  <<OUTER_LOOP>>
  LOOP
    y := 1 ;
    EXIT WHEN x > 5 ; 
    <<INNER_LOOP>>
    LOOP 
      DBMS_OUTPUT.PUT_LINE ( x || ' * ' || y || ' = ' || x * y ) ; 
      EXIT OUTER_LOOP WHEN x*y > 15 ; 
      y := y + 1 ; 
      EXIT WHEN y > 5 ; 
    END LOOP INNER_LOOP ; 
    x := x + 1 ; 
  END LOOP OUTER_LOOP ; 
END ;
/
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
PL/SQL procedure successfully completed.
*/
---------------------------------------------------------------
--※ CONTINUE 문

SET SERVEROUTPUT ON
DECLARE
  v_total		SIMPLE_INTEGER := 0;
BEGIN
  FOR i IN 1..5 LOOP
    v_total := v_total + i;
    DBMS_OUTPUT.PUT_LINE ('Total is: '|| v_total) ;

    CONTINUE WHEN i > 3 ;
    v_total := v_total + i;
    DBMS_OUTPUT.PUT_LINE ('Out of Loop Total is: '|| v_total);
  END LOOP;
END;
/

/*
Total is: 1          		<= 0 + 1 (i)
Out of Loop Total is: 2 	<= 1 + 1 (i)
Total is: 4 			<= 2 + 2 (i)
Out of Loop Total is: 6	<= 4 + 2 (i)
Total is: 9			<= 6 + 3 (i)
Out of Loop Total is: 12	<= 9 + 3 (i)
Total is: 16			<= 12 + 4 (i)
Total is: 21			<= 16 + 5 (i)
PL/SQL procedure successfully completed.
*/?
SET SERVEROUTPUT ON
DECLARE
  v_total		NUMBER := 0;
BEGIN
  <<BeforeTopLoop>>
  FOR i IN 1..5 LOOP
    v_total := v_total + 1;
    DBMS_OUTPUT.PUT_LINE ('Outer Total is: ' || v_total) ;

    FOR j IN 1..5 LOOP
      CONTINUE BeforeTopLoop WHEN i + j > 5 ;
      v_total := v_total + 1;
      DBMS_OUTPUT.PUT_LINE ('Inner Total is: ' || v_total) ;
    END LOOP;
  END LOOP;
END ;
/
/*
Outer Total is: 1		<= 0 + 1 (i=1)
Inner Total is: 2		<= 1 + 1 (i=1 , j=1)
Inner Total is: 3		<= 2 + 1 (i=1 , j=2)
Inner Total is: 4		<= 3 + 1 (i=1 , j=3)
Inner Total is: 5		<= 4 + 1 (i=1 , j=4)
Outer Total is: 6		<= 5 + 1 (i=2)
Inner Total is: 7		<= 6 + 1 (i=2 , j=1)
Inner Total is: 8		<= 7 + 1 (i=2 , j=2)
Inner Total is: 9		<= 8 + 1 (i=2 , j=3)
Outer Total is: 10	<= 9 + 1 (i=3)
Inner Total is: 11	<= 10 + 1 (i=3 , j=1)
Inner Total is: 12	<= 11 + 1 (i=3 , j=2)
Outer Total is: 13	<= 12 + 1 (i=4)
Inner Total is: 14	<= 13 + 1 (i=4 , j=1)
Outer Total is: 15	<= 14 + 1 (i=5)
PL/SQL procedure successfully completed.
*/

DECLARE 
  REC_EMP   EMP%ROWTYPE ; 
BEGIN 
  SELECT * INTO REC_EMP
    FROM EMP 
   WHERE EMPNO = 7788 ; 
   
  DBMS_OUTPUT.PUT_LINE(REC_EMP.ENAME||' '||REC_EMP.SAL) ; 
END ; 
/
---------------------------------------------------------------
--조합 데이터 유형

--※ PL/SQL Record

DECLARE 
  TYPE emp_rec_typ IS RECORD 
  ( ename	VARCHAR2(10), 
   sal		emp.sal%TYPE, 
   job		emp.job%TYPE := 'NONE' ) ; 

  emp_rec	EMP_REC_TYP ; 
BEGIN 
  SELECT ename, sal, job INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 
END ;
/


--※ %ROWTYPE 사용

DECLARE 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 
END ;
/
---------------------------------------------------
--※ Record Type 사용

CREATE TABLE copy_emp 
      AS 
      SELECT * FROM emp 
      WHERE deptno = 10 ; 

DECLARE 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 

  INSERT INTO copy_emp 
  VALUES emp_rec ;

  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7782 ; 

  emp_rec.sal      := emp_rec.sal * 1.2 ; 
  emp_rec.hiredate := SYSDATE ; 

  UPDATE copy_emp 
  SET ROW = emp_rec 
  WHERE empno = 7782 ; 
END ;
/

ROLLBACK;
--------------------------------------------------------------