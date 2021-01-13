--0107


SELECT /*+ TEST */ * FROM EMP WHERE DEPTNO = 10 ; 
select /*+ TEST */ * from emp where deptno = 10 ; 

SELECT /*+ TEST */ * 
FROM EMP WHERE DEPTNO = 10 ; 

SELECT /*+ TEST */ * 
FROM EMP 
WHERE DEPTNO = 10 ; 

SELECT * FROM V$SQL 
WHERE UPPER(SQL_TEXT) LIKE 'SELECT /*+ TEST%' ; 

SELECT * FROM EMP WHERE DEPTNO = 10 ;
SELECT * FROM EMP WHERE DEPTNO = 20 ;
SELECT * FROM EMP WHERE DEPTNO = 30 ;

SELECT * 
FROM V$SQL 
WHERE SQL_TEXT LIKE 'SELECT * FROM EMP WHERE DEPTNO%' ;

SELECT * FROM EMP WHERE DEPTNO = :B1 ;

SELECT * 
FROM V$SQL 
WHERE SQL_TEXT LIKE 'SELECT * FROM EMP WHERE DEPTNO%' ;


/*
20210107

SQL 문장의 처리 과정 
Parse (구문분석) : 실행 계획 확보 목적
문법 검사
의미 분석 (객체, 권한 확인)
if 동일 문장 실행 유무
           TRUE: 실행 계획 재사용
           FALSE: 실행 계획 생성 및 저장 
Bind : 바인드 변수에 값 입력 (바인드 변수를 사용할 때)
Execute : 실행 (실행 계획 사용)
Fetch : 검색 결과 인출 (SELECT 명령문만

*/



SELECT * FROM V$DATAFILE ; 
SELECT * FROM V$CONTROLFILE ; 
SELECT * FROM V$LOG ; 
SELECT * FROM V$LOGFILE ; 

SELECT * FROM V$DATABASE ; 
SELECT * FROM V$INSTANCE ; 
SELECT * FROM V$PROCESS ;
SELECT * FROM V$BGPROCESS ;
SELECT * FROM V$SESSION ; 

/*DML 명령문 처리 과정 
PARSE 
BIND 
EXECUTE
DATA, UNDO Block 확보 
LOCK 생성 
Redo Record 생성 
갱신 (insert, update, delete)
*/

--SGA --동시에 여러 프로세스들 에게 허락된 shared 공간 --접근시 잠금장치가 필요(나만을위한공간 할당을 위해)
--PGA --하나의 프로그램에만 할당된 프라이빗한 공간
--둘의 가장 큰차이는 LOCK