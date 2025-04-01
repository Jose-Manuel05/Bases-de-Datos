--13º
create or alter trigger TRIG_UPDATE_ORDER_ORDERITEM
on ORDERITEM after update
as
	begin
		declare @order_id int = (select Id from inserted)
		declare @product_id int = (select Id from inserted)
		declare @quantity int = (select Quantity from inserted)

		update ORDERITEM
		set UnitPrice = (select UnitPrice from PRODUCT where Id = @product_id)

		declare @unitPrice as decimal(12,2) = (select UnitPrice from ORDERITEM where OrderId = @order_id)

		update ORDERS
		set TotalAmount = @unitPrice * @quantity
		where Id = @order_id
	end
go

insert into ORDERS
values ('01/01/2022',542400,1,0)

insert into ORDERITEM
values (23, 5, 0, 3)

select * from ORDERS
select * from ORDERITEM