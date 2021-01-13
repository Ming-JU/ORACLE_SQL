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

SQL ������ ó�� ���� 
Parse (�����м�) : ���� ��ȹ Ȯ�� ����
���� �˻�
�ǹ� �м� (��ü, ���� Ȯ��)
if ���� ���� ���� ����
           TRUE: ���� ��ȹ ����
           FALSE: ���� ��ȹ ���� �� ���� 
Bind : ���ε� ������ �� �Է� (���ε� ������ ����� ��)
Execute : ���� (���� ��ȹ ���)
Fetch : �˻� ��� ���� (SELECT ��ɹ���

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

/*DML ��ɹ� ó�� ���� 
PARSE 
BIND 
EXECUTE
DATA, UNDO Block Ȯ�� 
LOCK ���� 
Redo Record ���� 
���� (insert, update, delete)
*/

--SGA --���ÿ� ���� ���μ����� ���� ����� shared ���� --���ٽ� �����ġ�� �ʿ�(���������Ѱ��� �Ҵ��� ����)
--PGA --�ϳ��� ���α׷����� �Ҵ�� �����̺��� ����
--���� ���� ū���̴� LOCK