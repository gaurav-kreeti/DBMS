--PostgreSQL--
--1. Write the query to get the department and department wise total(sum) salary,
--display it in ascending order according to salary.
Select departments.department_name,sum(employees.salary) as total_salary
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name
order by total_salary;
--2. Write the query to get the department, total no. employee of each department,
--total(sum) salary with respect to department from "Employee" table.
Select departments.department_name,count(*),sum(employees.salary) as total_salary
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name;
--3. Get department wise maximum salary from "Employee" table order by salary ascending
Select departments.department_name,max(employees.salary) as max_salary
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name
order by max_salary;
--4. Write a query to get the departments where average salary is more than 60k
Select departments.department_name,avg(employees.salary) as avg_salary_greater_than_60k
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name
Having avg(salary)>60000;
--5. Write down the query to fetch department name assign to more than one Employee
Select departments.department_name,count(*) as count_greater_than_1
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name
Having count(*)>1;
--6. Write a query to show department_name and assigned To where assigned To
--will be “One candidate” if its assigned to only one employee otherwise
--“Multiple candidates”
Select departments.department_name,case
    when count(*)=1 then 'One candidate'
    else 'Multiple candidates'
end assigned_to
from departments,employees
where departments.department_id=employees.department_id
Group by departments.department_name;