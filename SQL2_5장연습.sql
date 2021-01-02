--1
CREATE TABLE dept2
(id NUMBER(7),
name VARCHAR2(25));
DESCRIBE dept2

--2
INSERT INTO dept2
SELECT department_id, department_name
FROM departments;

--3
CREATE TABLE emp2
(id NUMBER(7),
last_name VARCHAR2(25),
first_name VARCHAR2(25),
dept_id NUMBER(7));
DESCRIBE emp2

--4
ALTER TABLE emp2
ADD CONSTRAINT my_emp_id_pk PRIMARY KEY (id);

--5
ALTER TABLE dept2
ADD CONSTRAINT my_dept_id_pk PRIMARY KEY(id);

--6
ALTER TABLE emp2
ADD CONSTRAINT my_emp_dept_id_fk
FOREIGN KEY (dept_id) REFERENCES dept2(id);

--7
ALTER TABLE emp2
ADD commission NUMBER(2,2)
CONSTRAINT my_emp_comm_ck CHECK (commission > 0);

--8

DROP TABLE emp2 PURGE;
DROP TABLE dept2 PURGE;

--9a
CREATE TABLE library_items_ext ( category_id number(12)
, book_id number(6)
, book_price number(8,2)
, quantity number(8)
)
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY emp_dir
ACCESS PARAMETERS (RECORDS DELIMITED BY NEWLINE
FIELDS TERMINATED BY ',')
LOCATION ('library_items.dat')
)
REJECT LIMIT UNLIMITED;

--9b
SELECT * FROM library_items_ext;

--10
CREATE TABLE dept_add_ext (location_id,
street_address, city,
state_province,
country_name)
ORGANIZATION EXTERNAL(
TYPE ORACLE_DATAPUMP
DEFAULT DIRECTORY emp_dir
LOCATION ('oraxx_emp4.exp','oraxx_emp5.exp'))
PARALLEL
AS
SELECT location_id, street_address, city, state_province,
country_name
FROM locations
NATURAL JOIN countries;

SELECT * FROM dept_add_ext;

--11
DROP TABLE emp_books CASCADE CONSTRAINTS;
CREATE TABLE emp_books (book_id number,
title varchar2(20), CONSTRAINT
emp_books_pk PRIMARY KEY (book_id));

INSERT INTO emp_books VALUES(300,'Organizations');
INSERT INTO emp_books VALUES (300,'Change Management');

SET CONSTRAINT emp_books_pk DEFERRED;

ALTER TABLE emp_books DROP CONSTRAINT emp_books_pk;

ALTER TABLE emp_books ADD (CONSTRAINT emp_books_pk PRIMARY KEY
(book_id) DEFERRABLE);


SET CONSTRAINT emp_books_pk DEFERRED;

INSERT INTO emp_books VALUES (300,'Change Management');
INSERT INTO emp_books VALUES (300,'Personality');
INSERT INTO emp_books VALUES (350,'Creativity');

COMMIT;