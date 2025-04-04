--23º
create or alter trigger TRIG_INSERT_ORDERS_DETAILS
on order_Details after insert
as 
	begin
		declare @order_id int = (select OrderID from inserted)
		declare @product_id int = (select ProductID from inserted)
		declare @quantity smallint = (select Quantity from inserted)
		declare @unit_price money = (select UnitPrice from Products where ProductID = @product_id)



	end
go