--158º ??
	select first_name, last_name, salary, department_name, job_title
	from employees e
	join departments d on e.department_id = d.department_id
	join jobs j on e.job_id = j.job_id
	where e.job_id = (
		select job_id
		from employees
		where first_name = 'Daniel' and last_name = 'Faviet')

--159º
select first_name, last_name, salary
from employees
where salary > (
	select salary
	from employees
	where first_name = 'Michael' and last_name = 'Hartstein')

--160º
select first_name, last_name, department_name, salary
from employees e
join departments d on e.department_id = d.department_id
where salary > 2 *(
	select AVG(salary)
	from employees e2
	where e.department_id = e2.department_id)
order by first_name, last_name asc

--161º
select first_name, last_name, department_name, salary
from employees e 
join departments d on e.department_id = d.department_id
where salary = (
	select MIN(salary)
	from employees e2
	where e.department_id = e2.department_id)

--162º ??
select first_name, last_name
from employees e
where salary = (
	select min(salary)
	from employees e2
	where e.department_id = e2.department_id)

--163º ??
select first_name, last_name, job_title
from employees e
join jobs j on e.job_id = j.job_id
where manager_id like (
	select manager_id
	from employees
	where first_name = 'Payam' and last_name = 'Kaufling')

--164º
select first_name, last_name, hire_date
from employees e
where department_id = (
	select department_id
	from employees e2
	where first_name = 'Alexander' and last_name = 'Khoo')
and not (first_name = 'Alexander' and last_name = 'Khoo')

--165º
select first_name, last_name, job_title
from employees e
join jobs j on e.job_id = j.job_id
where manager_id not in (
	select manager_id
	from employees e2
	where (first_name = 'Alexander' and last_name = 'Hunold') or (last_name = 'Adam' and last_name = 'Fripp') or (first_name = 'John' and last_name = 'Russell') and e.department_id = e2.department_id)

--166º ??
select CONCAT(first_name,' ',last_name) as Employee
from employees e
join departments d on e.department_id = d.department_id
where e.department_id in (
	select e2.department_id
	from employees e2
	join departments d2 on e2.department_id = d2.department_id
	join locations l2 on d2.location_id = l2.location_id
	where country_id = 'UK')

--167º
select department_name, SUM(salary) as Total_salary, COUNT(employee_id) as Total_Employees
from employees e
join departments d on e.department_id = d.department_id
group by department_name
having COUNT(e.employee_id) >= 5 and SUM(e.salary) < (
	select SUM(e2.salary)
	from employees e2
	join departments d2 on e2.department_id = d2.department_id
	where department_name = 'Shipping')

--168
select CONCAT(first_name,' ',last_name) as Employee, department_name, salary
from employees e
join departments d on e.department_id = d.department_id
where salary > (
	select avg(salary)
	from employees e2
	where e.department_id = e2.department_id) 
and department_name like '%IT%'
