--20210106

--명시적 커서 사용

SET SERVEROUTPUT ON
DECLARE 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp
  WHERE deptno = 10 ;

  DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
END ;
/

DECLARE 
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  OPEN emp_cur ; 

  FETCH emp_cur INTO emp_rec ; 
  DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 

  FETCH emp_cur INTO emp_rec ; 
  DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 

  CLOSE emp_cur ; 
END ;
/

?

DECLARE 
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  OPEN emp_cur ; 
  LOOP 
    FETCH emp_cur INTO emp_rec ; 
    EXIT WHEN emp_cur%NOTFOUND ; 
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
  CLOSE emp_cur ; 
END ;
/

DECLARE 
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
BEGIN 
  FOR emp_rec IN emp_cur LOOP
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
END ;
/


BEGIN 
  FOR emp_rec IN ( SELECT * FROM emp WHERE deptno = 10 ) LOOP
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
END ;
/

DECLARE 
  CURSOR emp_cur ( p_deptno	NUMBER ) IS 
    SELECT * FROM emp WHERE deptno = p_deptno ; 
BEGIN 
  FOR emp_rec IN emp_cur (10) LOOP
    DBMS_OUTPUT.PUT_LINE ( emp_rec.deptno || ' : ' || emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 

  FOR emp_rec IN emp_cur (20) LOOP
    DBMS_OUTPUT.PUT_LINE ( emp_rec.deptno || ' : ' || emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
END ;
/


BEGIN --ERROR
UPDATE EMP 
SET SAL = 4000 
WHERE EMPNO = 7839 ; 

UPDATE EMP 
SET EMPNO = 7788 
WHERE EMPNO = 7566 ; 

UPDATE EMP 
SET SAL = 4000 
WHERE EMPNO = 7369 ; 
END ; 
/
--예외처리
SET SERVEROUTPUT ON 
BEGIN 
  UPDATE EMP 
  SET SAL = 4000 
  WHERE EMPNO = 7839 ; 

  UPDATE EMP 
  SET EMPNO = 7788 
  WHERE EMPNO = 7566 ; 

  UPDATE EMP 
  SET SAL = 4000 
  WHERE EMPNO = 7369 ; 
EXCEPTION 
  WHEN OTHERS THEN 
     DBMS_OUTPUT.PUT_LINE(SQLERRM) ; 
END ; 
/

SELECT * FROM EMP WHERE EMPNO = 7839 ;
SELECT * FROM EMP WHERE EMPNO = 7369 ;

ROLLBACK;