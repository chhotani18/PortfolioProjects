-- 1. Write a procedure to increase the salary of employee 115 based on the following criteria: increase salary by 20% if the experience is more than 10 years, increase salary by 10% if the experience is greater than 5 years, Otherwise 5%.
create or replace procedure Q_1
is
    v_exp number;
    v_inc number;
begin
    select floor((sysdate - hire_date) / 365) into v_exp
    from employees
    where employee_id = 115;

    v_inc := 1.05;

    if v_exp > 10 then
        v_inc := 1.20;
    elsif v_exp > 5 then
        v_inc := 1.10;
    end if;

    update employees set salary = salary * v_inc
    where employee_id = 115;
end;

-- 2. Write a procedure to find the year in which the maximum number of employees joined along with how many joined in each month in that year.
CREATE OR REPLACE PROCEDURE Q_2
IS
    v_year NUMBER;
    v_count NUMBER;
BEGIN
    SELECT
        TO_CHAR(hire_date, 'YYYY') INTO v_year
    FROM employees
    GROUP BY TO_CHAR(hire_date, 'YYYY')
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM employees
        GROUP BY TO_CHAR(hire_date, 'YYYY')
    );

    DBMS_OUTPUT.PUT_LINE('Year : ' || v_year);

    FOR month IN 1 .. 12
    LOOP
        SELECT COUNT(*) INTO v_count
        FROM employees
        WHERE TO_CHAR(hire_date, 'mm') = month AND TO_CHAR(hire_date, 'yyyy') = v_year;

        DBMS_OUTPUT.PUT_LINE('Month : ' || TO_CHAR(month) || ' Employees : ' || TO_CHAR(v_count));
    END LOOP;
END;

-- 3. Create a function that takes a department ID as input and returns the name of the manager of that department.
CREATE OR REPLACE FUNCTION Q_3(v_dept departments.department_id%TYPE)
RETURN VARCHAR2
IS
    v_name employees.first_name%TYPE;
BEGIN
    SELECT first_name INTO v_name
    FROM employees
    WHERE employee_id = (SELECT manager_id FROM departments WHERE department_id = v_dept);
    RETURN v_name;
END;

-- 4. Create a function that takes an employee ID as input and returns the number of jobs done by the employee in the past.
CREATE OR REPLACE FUNCTION Q_4(emp_id job_history.employee_id%TYPE)
RETURN NUMBER
IS
    v_job NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_job
    FROM job_history
    WHERE employee_id = emp_id
    GROUP BY employee_id;
    RETURN v_job;
END;

-- 5. Create a procedure that takes a department ID as input and changes the manager ID for that department to the employee in the department with the highest salary.
CREATE OR REPLACE PROCEDURE Q_5(dept_id departments.department_id%TYPE)
IS
    e_id employees.employee_id%TYPE;
BEGIN
    SELECT employee_id INTO e_id
    FROM employees
    WHERE salary = (SELECT MAX(salary) FROM employees WHERE department_id = dept_id);
    
    UPDATE departments SET manager_id = e_id
    WHERE department_id = dept_id;
END;

-- 6. Create a function that takes a manager ID and returns the names of employees who report to that manager. The names must be returned as a string with a comma separating names.
CREATE OR REPLACE FUNCTION Q_6(v_mngid employees.manager_id%TYPE)
RETURN VARCHAR2
AS
    a VARCHAR2(100) := ' ';
BEGIN
    FOR i IN (SELECT first_name FROM employees WHERE manager_id = v_mngid)
    LOOP
        a := a || ', ' || i.first_name;
    END LOOP;
    RETURN a;
END;


---------------------------------------------------------------------------------------------------------------------------
-- 1. Change commission percentage for employee with ID = 150 based on salary and experience
DECLARE
    v_salary  employees.salary%TYPE;
    v_exp     NUMBER(2);
    v_cp      NUMBER(5,2);
BEGIN
    SELECT salary, FLOOR((SYSDATE - hire_date) / 365) INTO v_salary, v_exp
    FROM employees
    WHERE employee_id = 150;

    IF v_salary > 10000 THEN
        v_cp := 0.4;
    ELSIF v_exp > 10 THEN
        v_cp := 0.35;
    ELSIF v_salary < 3000 THEN
        v_cp := 0.25;
    ELSE
        v_cp := 0.15;
    END IF;

    UPDATE employees SET commission_pct = v_cp
    WHERE employee_id = 150;
    
    COMMIT;
END;

-- 2. Increase the salary of employee 115 based on experience
DECLARE
    v_exp  NUMBER(2);
    v_hike NUMBER(5,2);
BEGIN
    SELECT FLOOR((SYSDATE - hire_date) / 365) INTO v_exp
    FROM employees
    WHERE employee_id = 115;

    v_hike := 1.05;

    CASE
        WHEN v_exp > 10 THEN
            v_hike := 1.20;
        WHEN v_exp > 5 THEN
            v_hike := 1.10;
    END CASE;

    UPDATE employees SET salary = salary * v_hike
    WHERE employee_id = 115;
    
    COMMIT;
END;

-- 3. Display missing employee IDs
DECLARE
     v_min  NUMBER(3);
     v_max  NUMBER(3);
     v_c    NUMBER(1);
BEGIN
     SELECT MIN(employee_id), MAX(employee_id) INTO v_min, v_max
     FROM employees;

     FOR i IN v_min + 1 .. v_max - 1
     LOOP
           SELECT COUNT(*) INTO v_c
           FROM employees
           WHERE employee_id = i;

           IF v_c = 0 THEN
                DBMS_OUTPUT.PUT_LINE(i);
           END IF;
    END LOOP;
END;

-- 4. Display the year in which maximum number of employees joined along with how many joined in each month in that year
DECLARE
      v_year  NUMBER(4);
      v_c     NUMBER(2);
BEGIN
      SELECT TO_CHAR(hire_date, 'yyyy') INTO v_year
      FROM employees
      GROUP BY TO_CHAR(hire_date, 'yyyy')
      HAVING COUNT(*) =
             (SELECT MAX(COUNT(*))
               FROM employees
               GROUP BY TO_CHAR(hire_date, 'yyyy'));

      DBMS_OUTPUT.PUT_LINE('Year : ' || v_year);

      FOR month IN 1 .. 12
      LOOP
          SELECT COUNT(*) INTO v_c
          FROM employees
          WHERE TO_CHAR(hire_date, 'mm') = month AND TO_CHAR(hire_date, 'yyyy') = v_year;

          DBMS_OUTPUT.PUT_LINE('Month : ' || TO_CHAR(month) || ' Employees : ' || TO_CHAR(v_c));
     END LOOP;
END;

-- 5. Create a function that returns the name of the manager of the department
CREATE OR REPLACE FUNCTION get_dept_manager_name(deptid NUMBER)
RETURN VARCHAR2 IS
   v_name  employees.first_name%TYPE;
BEGIN
   SELECT first_name INTO v_name
   FROM employees
   WHERE employee_id = (SELECT manager_id FROM departments WHERE department_id = deptid);

   RETURN v_name;
END;

-- 6. Create a procedure that changes the manager ID for the department to the employee with the highest salary
CREATE OR REPLACE PROCEDURE change_dept_manager(deptid NUMBER) IS
   v_empid  employees.employee_id%TYPE;
BEGIN
   SELECT employee_id INTO v_empid
   FROM employees
   WHERE salary = (SELECT MAX(salary) FROM employees WHERE department_id = deptid)
     AND department_id = deptid;

   UPDATE departments SET manager_id = v_empid
   WHERE department_id = deptid;
   
   COMMIT;
END;
