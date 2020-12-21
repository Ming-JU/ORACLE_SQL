--1

SELECT location_id, street_address, city, state_province, country_name
  FROM   LOCATIONS
NATURAL JOIN COUNTRIES;

--2
SELECT LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
JOIN DEPARTMENTS
USING (DEPARTMENT_ID);

--3
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
USING (location_id)
WHERE LOWER(l.city) = 'toronto';
--4

SELECT w.last_name "Employee", w.employee_id "EMP#",
m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w JOIN employees m
ON (w.manager_id = m.employee_id);

--5
SELECT w.last_name "Employee", w.employee_id "EMP#",
m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w
LEFT OUTER JOIN employees m
ON (w.manager_id = m.employee_id)
ORDER BY 2;

--6
SELECT e.department_id department, e.last_name employee,
c.last_name colleague
FROM employees e JOIN employees c
ON (e.department_id = c.department_id)
WHERE e.employee_id <> c.employee_id
ORDER BY e.department_id, e.last_name, c.last_name;

--7
DESC JOB_GRADES
/
SELECT e.last_name, e.job_id, d.department_name,
e.salary, j.grade_level
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);
--8
SELECT e.last_name, e.hire_date
FROM employees e JOIN employees davies
ON (davies.last_name = 'Davies')
WHERE davies.hire_date < e.hire_date;

--9
SELECT w.last_name, w.hire_date, m.last_name, m.hire_date
FROM employees w JOIN employees m
ON (w.manager_id = m.employee_id)
WHERE w.hire_date < m.hire_date;
