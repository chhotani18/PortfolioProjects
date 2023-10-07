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
