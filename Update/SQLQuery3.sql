--10º
update EMPLOYEE
set Salary = 2000
where DepartmentID in (
	select d.DepartmentID
	from DEPARTMENT d
	join EMPLOYEE e on d.DepartmentID = e.DepartmentID
	group by d.DepartmentID
	having AVG(Salary) < 2000
)

commit transaction;

rollback;

select Salary
from EMPLOYEE

--11º
update PRODUCT 
set UnitPrice = UnitPrice 
from INFLATION
where Rate > 0.50 and YearInf = 2024

--12º
begin transaction
update ORDERS
set Status = 
    case 
        when ShippedDate < DATEADD(year, -1, GETDATE()) then 'Archived'
        when count(OrderID) > 1000 then 'Priority'
        else 'Regular'
    end;

commit transaction

rollback

select Status
from ORDERS
