create or alter procedure PRODUCT_IN_STOCK (@category varchar(15))

as
	begin
		declare @print varchar(max) = ''
		declare @cate varchar(15)
		declare @product_id char(15)
		declare @price char(10)
		declare @nameproduct varchar(45)

		declare product_cursor cursor 
		for select  Category, ProductID, Price, NameProduct
		from PRODUCT
		where Category = @category and Quantity > 0

		open product_cursor 
		fetch next from product_cursor into @cate, @product_id, @price, @nameproduct

		while @@FETCH_STATUS = 0
			begin

				print @nameproduct + space(10) + @price + ' €'
				print 'COMPONENTS:'

				select @print = @print +
				SPACE(5) +
				CAST(pa.NamePart as char(35)) +
				CAST(SUM(up.Quantity) as char(2)) +
				CAST(pa.RetailPrice as char(8)) + ' €' + CHAR(10)
				from PRODUCT p
				join USE_PART up on p.ProductID = up.ProductID
				join PART pa on up.PartID = pa.PartID
				where p.Category = @category and p.ProductID = @product_id
				group by NameProduct, Price, NamePart, RetailPrice



				print @print
				print '-----------------------------------------------'
				set @print = ''

				fetch next from product_cursor into @cate, @product_id, @price, @nameproduct
			end

	close product_cursor
	deallocate product_cursor
	end
go

EXEC PRODUCT_IN_STOCK 'Workstation'

go

--2º
create or alter procedure WORK_EMPLOYEE_MONTH (@month datetime, @year datetime)

as
	begin
		declare @print varchar(max) = ''
		declare @employee varchar(45)
		declare @employee_id char(5)

		declare work_cursor cursor
		for select e.NameEmployee, e.EmployeeID
		from EMPLOYEE e
		join WORK_ORDERS wo on e.EmployeeID = e.EmployeeID
		where MONTH(wo.DateAssembly) = @month and YEAR(wo.DateAssembly) = @year
		group by e.NameEmployee, e.EmployeeID

		open work_cursor
		fetch next from work_cursor into @employee, @employee_id

		while @@FETCH_STATUS = 0
		begin
			print 'Employee: ' + @employee
			print space(5) + 'Product			Units Assembled'
			print space(5) + '================================'

			select @print = @print + SPACE(5) + CAST(Category as char(25)) + 
			CAST(SUM(wo.Quantity) as char(2)) + 
			char(10)
			from WORK_ORDERS wo
			join PRODUCT p on wo.ProductID = p.ProductID
			where @employee_id = wo.EmployeeID and MONTH(wo.DateAssembly) = @month and YEAR(wo.DateAssembly) = @year
			group by Category
			print @print
			set @print = ''


			fetch next from work_cursor into @employee, @employee_id
		end

	close work_cursor
	deallocate work_cursor

	end
go
EXEC WORK_EMPLOYEE_MONTH 3,2025

go

--3º
create or alter procedure BILLS_MONTH (@month as char(3))
as
	begin
		declare @print varchar(max) = ''
		declare @order_id char(6)
		declare @date date
		declare @employee varchar(45)
		declare @client varchar(60)
		declare @subtotal money

		declare bill_cursor cursor
		for select o.OrderID, o.OrderDate, e.NameEmployee, c.NameClient
		from ORDERS o
		join EMPLOYEE e on o.EmployeeID = e.EmployeeID
		join CLIENT c on o.ClientID = c.ClientID
		where MONTH(o.OrderDate) = @month

		open bill_cursor
		fetch next from bill_cursor into @order_id, @date, @employee, @client

		while @@FETCH_STATUS = 0
			begin
				print '**************************************************'
				print 'Order: ' + @order_id + space(10) + @date
				print 'Employee: ' + @employee
				print 'Client: ' + @client
				print 'Product		Category	Quantity	Price'
				print '--------------------------------------------------'

				select @print = @print + CAST(p.NameProduct as char(30)) +
				CAST(p.Category as char(20)) + 
				CAST(p.Quantity as char(2)) +
				CAST(CAST(SUM(od.UnitPrice*od.Quantity)as money)as char(10)) + 
				CHAR(10)
				from PRODUCT p 
				join ORDER_DETAILS od on p.ProductID = od.ProductID
				join ORDERS o on od.OrderID = o.OrderID
				where MONTH(o.OrderDate) = @month
				group by NameProduct, Category, p.Quantity

				set @subtotal = (select SUM(Quantity*UnitPrice) from ORDER_DETAILS)

				print char(10) + 'Subtotal: ' + space(5) + @subtotal
				print char(10) + 'VAT: ' + space(5) + cast(@subtotal*0.21 as char(10)) 
				print char(10) + 'Total: ' + space(5) + cast(@subtotal *1.21 as char(10))

				print @print

				fetch next from bill_cursor into @order_id, @date, @employee, @client

			end
		close bill_cursor
		deallocate bill_cursor
	end
go
EXEC BILLS_MONTH 3