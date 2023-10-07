
-- 1. Display details of the departments where the first name of the manager is MICHAEL.
SELECT *
FROM departments
WHERE manager_id IN
  (SELECT employee_id
   FROM employees
   WHERE UPPER(first_name) LIKE '%MICHAEL%');

-- 2. Display jobs where the minimum salary is less than the salary of employee 105.
SELECT *
FROM jobs
WHERE min_salary < (SELECT salary FROM employees WHERE employee_id = 105);

-- 3. Display the number of employees joined in each year into department 30.
SELECT TO_CHAR(hire_date, 'yyyy'), COUNT(*)
FROM employees
WHERE department_id = 30
GROUP BY TO_CHAR(hire_date, 'yyyy');

-- 4. Display details of departments in which the maximum salary is more than 10000.
SELECT *
FROM departments
WHERE department_id IN
  (SELECT department_id
   FROM employees
   GROUP BY department_id
   HAVING MAX(salary) > 10000);

-- 5. Display jobs into which employees joined in the current year.
SELECT *
FROM jobs
WHERE job_id IN
  (SELECT job_id
   FROM employees
   WHERE TO_CHAR(hire_date, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY'));

-- 6. Display employees who did not do any job in the past.
SELECT *
FROM employees
WHERE employee_id NOT IN
  (SELECT employee_id
   FROM job_history);

-- 7. Display job title and average salary for employees who did a job in the past.
SELECT JOB_TITLE, AVG(SALARY)
FROM jobs
NATURAL JOIN employees
GROUP BY JOB_TITLE
HAVING EMPLOYEE_ID IN
    (SELECT EMPLOYEE_ID FROM JOB_HISTORY);

-- 8. Display details of managers who manage more than 5 employees.
SELECT FIRST_NAME
FROM employees
WHERE employee_id IN
  (SELECT manager_id
   FROM employees
   GROUP BY manager_id
   HAVING COUNT(*) > 5);

-- 9. Display details of the current job for employees who worked as IT Programmers in the past.
SELECT *
FROM jobs
WHERE job_id IN
  (SELECT job_id
   FROM employees
   WHERE employee_id IN
     (SELECT employee_id
      FROM job_history
      WHERE job_id = 'IT_PROG'));

-- 10. Display the city of the employee whose employee ID is 105.
SELECT CITY
FROM locations
WHERE location_id =
    (SELECT location_id
     FROM departments
     WHERE department_id =
        (SELECT department_id
         FROM employees
         WHERE employee_id = 105));

-- Challenge Solution

-- 1. Display job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY)
FROM EMPLOYEES
NATURAL JOIN JOBS
GROUP BY JOB_TITLE;

-- 2. Create a table Customer( Customer_ID , Name , Email, Phone), insert 2 rows of sample data, and impose primary key (Customer_ID) and Check on (Email: @ symbol).
CREATE TABLE Customer (
    Customer_ID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50) CHECK (Email LIKE '%@%'),
    Phone VARCHAR(20)
);

-- 3. Display employee name and the country in which he/she is working.
SELECT FIRST_NAME, COUNTRY_NAME
FROM EMPLOYEES
JOIN DEPARTMENTS USING (DEPARTMENT_ID)
JOIN LOCATIONS USING (LOCATION_ID)
JOIN COUNTRIES USING (COUNTRY_ID);

-- 4. Display country name, city, and the number of departments where the department has more than 5 employees.
SELECT COUNTRY_NAME, CITY, COUNT(DEPARTMENT_ID)
FROM COUNTRIES
JOIN LOCATIONS USING (COUNTRY_ID)
JOIN DEPARTMENTS USING (LOCATION_ID)
WHERE DEPARTMENT_ID IN
   (SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(DEPARTMENT_ID) > 5)
GROUP BY COUNTRY_NAME, CITY;

-- 5. Write a query to find out which employees have a manager who works for a department based in the US.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE MANAGER_ID IN
  (SELECT EMPLOYEE_ID
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID IN
     (SELECT DEPARTMENT_ID
      FROM DEPARTMENTS
      WHERE LOCATION_ID IN
        (SELECT LOCATION_ID
         FROM LOCATIONS
         WHERE COUNTRY_ID = 'US')));
