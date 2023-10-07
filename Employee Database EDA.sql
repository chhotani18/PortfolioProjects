-- 1. How many employees have been hired in each department in June?
SELECT department_id, COUNT(*)
FROM employees
WHERE TO_CHAR(hire_date, 'MM') = '06'
GROUP BY department_id;

-- 2. Display the details of all the CLERKS and IT Programmers whose salaries are more than $10,000 and they were hired before 1st Friday of 2005.
SELECT *
FROM employees
WHERE (SUBSTR(job_id, 4) = 'CLERK' OR job_id = 'IT_PROG')
  AND salary > 10000
  AND hire_date < NEXT_DAY(TO_DATE('01-JAN-05', 'DD-MON-RR'), 'FRIDAY');

-- 3. Display the first name, salary, and commission percentage of all the employees who are not working in Marketing or Accounting departments and whose commission percentage is not less than 10% and not greater than 30%.
SELECT first_name, salary, commission_pct, job_id
FROM employees
WHERE job_id NOT IN ('Marketing', 'Accounting')
  AND commission_pct BETWEEN 0.10 AND 0.30;

-- 4. Write a query that produces the following results: <Employee Name> hired on <Hire Date> earns <Salary> monthly but wants <3 times salary>.
SELECT first_name || ' hired on ' || TO_CHAR(hire_date, 'DD-MON-YY') || ' earns $' || TO_CHAR(salary) || ' monthly but wants $' || TO_CHAR(salary * 3)
FROM employees;

-- 5. Display first name, last name, full name, and length of full name of all the employees where last name contains the character ‘b’ after the 3rd position.
SELECT first_name, last_name, first_name || ' ' || last_name AS full_name, LENGTH(first_name || ' ' || last_name) AS full_name_length
FROM employees
WHERE INSTR(last_name, 'b', 4) > 0;

-- 6. Convert the session from the container database to the pluggable database in Oracle.
ALTER SESSION SET CONTAINER = orclpdb;

-- 7. Display the name of all the pluggable databases and their open modes present in Oracle.
SELECT name, open_mode
FROM v$pdbs;

-- 8. Change to user ‘SUser’ having password ‘mykey’ and unlock the account at the same time.
ALTER USER SUser IDENTIFIED BY mykey ACCOUNT UNLOCK;

-- 9. Assume that your pluggable database is mounted but not open. Write the command to open your pluggable database.
ALTER PLUGGABLE DATABASE orclpdb OPEN;

-- 10. Assume that you have a user-defined database as ‘sales’ with password ‘pass’. Write a command to establish a database connection to this pluggable database present in Oracle.
CONNECT sales/pass@orclpdb;
