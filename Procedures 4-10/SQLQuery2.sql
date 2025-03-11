--4º
create or alter procedure EMPLOYEE_SALES_BY_DATES (@ShippedDate1 date, @ShippedDate2 date)
as
	begin
		select Country, LastName, FirstName, ShippedDate, o.OrderID, sum(UnitPrice) as SaleAmount
		from Employees e
		join Orders o on e.EmployeeID = o.EmployeeID
		join Order_Details od on o.OrderID = od.OrderID
		where ShippedDate between @ShippedDate1 and @ShippedDate2
		group by Country, LastName, FirstName, ShippedDate, o.OrderID
	end
go
execute EMPLOYEE_SALES_BY_DATES @ShippedDate1 = '01/07/1996', @ShippedDate2 = '23/07/1996'

go

--5º
create or alter procedure CUST_ORDERS_DETAILS (@id_order smallint)
as
	begin
		select ProductName, od.UnitPrice, Quantity, 
		CONCAT(ROUND(od.Discount*100, 0), '%') as Discount, 
		ROUND((od.UnitPrice * od.Quantity) * (1 - od.Discount), 2) as Final_Price
		from Products p 
		join Order_Details od on p.ProductID = od.ProductID
		where od.OrderID = @id_order
	end
go
execute CUST_ORDERS_DETAILS @id_order = 10250

go

--6º
create or alter procedure CUST_ORDERS_SHIPPERS (@cust_ID char(5))
as
	begin
		select OrderID, FORMAT(o.OrderDate, '%d/%m/%y') AS OrderDate,
        FORMAT(o.RequiredDate, '%d/%m/%y') AS RequiredDate,
        FORMAT(o.ShippedDate, '%d/%m/%y') AS ShippedDate, 
		DATEDIFF(DAY, OrderDate, RequiredDate) as Diff_Order_Req, 
		CompanyName
		from Orders o 
		join Shippers s on o.ShipVia = s.ShipperID
		where o.CustomerID = @cust_ID
	end
go
execute CUST_ORDERS_SHIPPERS @cust_ID = TOMSP

go

--7º
create or alter procedure FIVE_MOST_EXP_PRODUCTS 
as
	begin
		select top 5 ProductName AS Five_Most_Exp_Products,
        p.UnitPrice
		from Products p
		order by p.UnitPrice desc
	end
go
execute FIVE_MOST_EXP_PRODUCTS

go

--8º??
create or alter procedure SALES_CUSTOMER_COUNTRY_YEAR (@country varchar(15), @year datetime)
as
	begin
		select CompanyName, count(OrderID) as Total_purchased
		from Customers c
		join Orders o on c.CustomerID = o.CustomerID
		group by CompanyName
	end
go 
execute SALES_CUSTOMER_COUNTRY_YEAR @country = 'Spain', @year = '1996'

go

--9º
create or alter procedure SALES_BETWEEN_DATES (@date1 datetime, @date2 datetime)
as
	begin
		select o.OrderID, FORMAT(o.ShippedDate, '%d/%m/%y') AS ShippedDate, SUM(Quantity * UnitPrice*(1-Discount)) as Subtotal
		from Orders o
		join Order_Details od on o.OrderID = od.OrderID
		where ShippedDate between @date1 and @date2
		group by o.OrderID, ShippedDate
	end
go
execute SALES_BETWEEN_DATES @date1 = '01/01/1997' , @date2 = '05/01/1997'

go

--10º
create or alter procedure SALES_BETWEEN_YEARS (@year1 INT, @year2 INT)
as
	begin
		select YEAR(ShippedDate) as ShippedYear, CONCAT(SUM(Quantity * UnitPrice*(1-Discount)), ' €') as Total
		from Orders o
		join Order_Details od on o.OrderID = od.OrderID
		where YEAR(ShippedDate) between @year1 and @year2
		group by YEAR(ShippedDate)
		order by YEAR(ShippedDate) asc
	end
go
execute SALES_BETWEEN_YEARS @year1 = '1996', @year2 = '1998'