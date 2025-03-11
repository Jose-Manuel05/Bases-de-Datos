--11º
declare @city varchar(50) =(select city from STORE where city = 'Baldwin')
select concat(first_name,' ', last_name) as Employee, s.phone
from STAFF s
join STORE st on s.store_id = st.store_id and (city = @city)

--12º
declare @category varchar(50), @model_y smallint = '2016'

select product_name
from PRODUCT p
join CATEGORY c on p.category_id = c.category_id 
where c.category_name like '%Children%' and model_year = @model_y

go

--13º
create or alter procedure EMPLOYEES_STORE (@manager varchar(30))
as
	begin
		select CONCAT(s.first_name,' ', s.last_name) as Employee, CONCAT(m.first_name,' ', m.last_name) as Manager
		from STAFF s
		join STAFF m on s.staff_id = m.manager_id
		join STORE st on m.store_id = st.store_id
		where st.store_name like '%' + @manager + '%'
	end
go
execute EMPLOYEES_STORE 'Rowlett'

go

--14º
create or alter procedure STOCK_CATEGORY_STORE (@category varchar(50), @year smallint)
as
	begin
		select product_name, brand_name, store_name, s.quantity
		from PRODUCT p
		join BRAND b on p.brand_id = b.brand_id
		join STOCK s on p.product_id = s.product_id
		join STORE st on s.store_id = st.store_id
		join CATEGORY c on p.category_id = c.category_id
		where category_name like '%' + @category + '%' and model_year = @year
	end
go
execute STOCK_CATEGORY_STORE @category = 'electric' , @year = '2016'

go

--16º
create or alter procedure TOTAL_ORDERS_STATE_YEAR (@year_order smallint)
as
	begin
		print ('STATE       T.ORDERS')
		print ('====================')
		declare @list varchar(max)
		set @list = ''
		select @list = @list + state + SPACE(10) + cast(count(order_id) as varchar) + char(10)
		from ORDERS o
		join CUSTOMER c on o.customer_id = c.customer_id
		where year(order_date) = @year_order
		group by state
		print @list
	end
go
execute TOTAL_ORDERS_STATE_YEAR @year_order = '2016'

go

--17º
create or alter procedure AMOUNT_CHARGED_MONTH_YEAR (@year smallint)
as
	begin
		print 'MONTHS      TOTAL'
		print '==================='
	end
go
execute AMOUNT_CHARGED_MONTH_YEAR 2017