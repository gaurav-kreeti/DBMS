--using PostgreSQL
--1. . From the following tables write a SQL query to find the details of an employee.
-- Return full name, email, salary, Department Name, postal code, and City.
Select CONCAT(e.first_name,' ',e.last_name) as "full name",e.email,e.salary,d.department_name,
l.pincode,l.city from employees e,departments d,locations l
where e.department_id=d.department_id and d.location_id=l.location_id;

-- 2. From the following tables write a SQL query to find the departments whose location is
-- in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province,
-- street_address.
SELECT d.department_name
from departments d,locations l
where d.location_id=l.location_id and l.city in('Jammu Kashmir','Jharkhand');
-- 3. From the following tables write a SQL query to find the count of employees present in
-- different jobs whose average salary is greater than 10,000. Return all the jobs with
-- employee count, Job Name, and average salary
SELECT COUNT(e.employee_id) as "employee count",j.job_title,avg(e.salary) as "Avg salary"
from employees e,jobs j
where e.job_id=j.job_id
Group by job_title
Having avg(e.salary)>10000;

-- 4 From the following table write a SQL query to find all the first_names and
-- last_names in both dependents and employees tables. Return the duplicate records as
-- well and order the records in descending order of the last_name column.

SELECT e.first_name as "employees first name",e.last_name as "employees first name",
d.first_name as "dependents first name",d.last_name as "dependents last name"
from employees e
FULL OUTER JOIN dependents d ON e.employee_id=d.employee_id
order by e.last_name desc;

-- 5. From the following table write a SQL query to list every employee that has a manager
-- with the name of his or her manager.
SELECT CONCAT(e.first_name,' ',e.last_name) as "employee name",CONCAT(e1.first_name,' ',e1.last_name) as 
"Manager name"
from employees e,employees e1
where cast(e.manager_id as int)=e1.employee_id;
-- 6. Find the departments that have more than 5 employees earning a salary greater than
-- 50,000 and are located in either New York or California. Include the department name,
-- location, and the number of employees meeting the criteria.
SELECT d.department_name,l.city,COUNT(e.employee_id) as "Count of employees"
FROM employees e,departments d,locations l
where e.department_id=d.department_id and d.location_id=l.location_id and 
l.city in('New York','California')and e.salary>50000
Group by department_name,l.city
Having count(e.employee_id)>5;
-- 7. List any employees who have dependents and have a job title that includes the word
-- 'manager', and sort the results by department name in ascending order
SELECT CONCAT(e.first_name,' ',e.last_name) as "employee name"
from employees e,dependents d,departments dr,jobs j
where e.employee_id=d.employee_id and e.department_id=dr.department_id and e.job_id=j.job_id
and j.job_title like '%manager%'
order by dr.department_name;

-- 8 Add a column in the dependent table called “city” depicting their current location of
-- stay. Find all employees who have been hired in the past 3 years and have dependents
-- living in a city that is different from the city they work in (if I work in Kolkata, then my
-- dependent should not be in Kolkata).
-- Additionally, only include employees whose salary is greater than the average salary of
-- their job title(suppose, my job_title is ”developer” and the salary is 80k, and the average
-- salary under the same job_title “developer” is 70k), and whose manager's job title
-- includes the word 'director'. Finally, include the department name and location of each
-- employee, and sort the results by department name in ascending order

alter table dependents add column "city" varchar(255);