--Using postgreSQL
-- 1) Find all the departments where the minimum salary is less than 2000.
SELECT department_name from departments 
where department_id in 
(SELECT distinct(department_id) from employees where salary >2000);

-- 2) Find all the countries where no employees exist.

SELECT country_name from countries where country_id not in
(SELECT l.country_id from locations l where location_id in (
SELECT d.location_id from departments d where department_id in (
SELECT distinct(e.department_id) from employees e)));
-- 3) From the following tables write a query to find all the jobs, having at least 2 employees in a
-- single department.(don’t use joins)
SELECT job_title from jobs where job_id in 
(SELECT distinct(j.job_id) from employees j where j.department_id 
in (SELECT d.department_id from employees d where 2 <= 
(SELECT count(e.employee_id) from employees e where e.department_id = d.department_id)));
-- 4)From the following tables write a query to find all the countries, having cities with all the city
-- names starting with 'a'.(don’t use joins)
SELECT c.country_name from countries c where
(SELECT count(l1.city) from locations l1 where l1.country_id=c.country_id)=
(SELECT count(l2.city) from locations l2 where l2.country_id=c.country_id and l2.city like 'a%');
-- 5)From the following tables write a query to find all the departments, having no cities
SELECT d.department_name FROM departments d WHERE d.location_id IN
(SELECT l.location_id FROM locations l WHERE l.city IS NULL) OR location_id IS NULL;
