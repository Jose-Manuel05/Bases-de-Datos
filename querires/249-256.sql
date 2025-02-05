--249º
select first_name, last_name, department_name
from employees e
left join departments d on e.department_id = d.department_id
where e.department_id in (
	select department_id
	from employees
	where last_name = 'Taylor')

--250º
select job_title, department_name, CONCAT(first_name,' ',last_name) as Employee_name, start_date
from jobs j 
join employees e on j.job_id = e.job_id
join departments d on e.department_id = d.department_id
join job_history jh on j.job_id = jh.job_id
where start_date > '2004-01-01' and end_date < '2008-10-31'

--251º
	SELECT e.employee_id, CONCAT(first_name,' ',last_name) AS Employee_name, j.max_salary - e.salary AS salary_difference, j.max_salary as Real_salary
	FROM employees e
	JOIN jobs j ON e.job_id = j.job_id
	JOIN departments d ON e.department_id = d.department_id
	WHERE d.department_name = 'Accounting';

--252º
SELECT c.country_name, l.city, COUNT(DISTINCT d.department_id) AS total_departments
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
JOIN countries c on l.country_id = c.country_id
GROUP BY l.city, c.country_name
HAVING COUNT(e.employee_id) >= 2;

--253º
	
--254º
SELECT e.employee_id, e.first_name, e.last_name, DATEDIFF(day, jh.start_date, jh.end_date) AS days_worked
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
JOIN departments d ON jh.department_id = d.department_id
WHERE d.department_name = 'Sales';

--255º



--256º
SELECT e.first_name, e.last_name, jh.job_id AS Job_title, jh.start_date, jh.end_date
FROM employees e
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id
LEFT JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.employee_id, jh.start_date;