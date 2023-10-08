-- Q1: Write PL/SQL triggers of the following using HR schema:

-- Q1i: Ensure no changes can be made to EMPLOYEES table before 6 am and after 10 pm in a day.
create or replace trigger no_change
before update or insert or delete
on employees
for each row
begin
   if to_char(sysdate, 'HH24') < 6 and to_char(sysdate, 'HH24') > 20 then
         raise_application_error('no changes can be made');
   end if;
end;

-- Q1ii: Create a Trigger to ensure the salary of the employee is not decreased.
create or replace trigger salary
before update
on employees
for each row
begin
   if :old.salary > :new.salary then
         raise_application_error('salary cannot be decreased');
   end if;
end;

-- Q1iii: Create a trigger to ensure the employee and manager belong to the same department. (Code for this part is missing.)

-- Q1iv: Whenever the job is changed for an employee, write the following details into job history. Employee ID, old job ID, old department ID, hire date of the employee for start date, system date for end date. But if a row is already present for employee job history then the start date should be the end date of that row +1.
create or replace trigger log
after update of job_id
on employees
for each row
declare
v_end   date;
v_start date;
begin
   select max(end_date) into v_end
   from job_history
   where employee_id = :old.employee_id;   
   if v_end is null then
      v_start := :old.hire_date;
   else
      v_start := v_end + 1;
   end if;
   insert into job_history values (:old.employee_id, v_start, sysdate, :old.job_id, :old.department_id);
end;

-- Q2: Suppose we have a Worker table as follows:

-- Q2i: Declare a sequence for workerID that begins from 1.
create sequence worker_id
start with 1
increment by 1
nomaxvalue;

-- Q2ii: Write a trigger that automatically inserts the primary key with a sequential number when inserting a record in the worker table.
create trigger auto_insert
before insert on worker
for each row
begin
   select worker_id.nextval into :new.workerID from dual;
end;

-- Q3: Suppose we have the following two tables:

-- Q3i: Write a statement-level trigger that updates the Total in the OrderHeader table with the total value of the OrderItem records whenever an insert, update, or delete event occurs on the OrderItem table. For any update error, raise an exception.
create or replace trigger total
before insert or update or delete 
on OrderItem
declare 
   sum_subtotal number;
begin
   if inserting then
      select sum(:new.Subtotal) 
      into sum_subtotal
      from OrderItem;
      update OrderHeader 
      set Total = sum_Subtotal ;
   end if;
   if updating then
      select sum(:old.Subtotal)
      into sum_subtotal
      from OrderItem;
      update OrderHeader 
      set Total = sum_Subtotal;
   end if;
   if deleting then
      select sum(:new.Subtotal)
      into sum_subtotal
      from OrderItem;
      update OrderHeader 
      set Total = sum_Subtotal ;
   end if;
end;
