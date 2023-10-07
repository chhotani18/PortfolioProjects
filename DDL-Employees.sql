create table Department (
    Department_ID number constraint department_pk primary key,
    Department_name varchar2(50),
    Manager_Name varchar2(50),
    Location varchar2(50)
);


create table Employee (
    Employee_ID number not null constraint employee_pk primary key,
    Employee_Name varchar2(30),
    Email varchar2(50),
    Department_ID number
);


Insert into Department(Department_ID, Department_Name, Manager_Name , Location)
        values(1,'Marketing','Steve King','USA');
        
Insert into Department
        values(2,'Sales',NULL,NULL);
        
Insert into Department (Department_ID, Location)
        values(3,'UK');

Insert into Employee 
values(1,'Mark Fleming', 'mfleming@gmail.com',1)   

Insert into Employee 
values(2,'Adam Smith' , NULL, 1)    