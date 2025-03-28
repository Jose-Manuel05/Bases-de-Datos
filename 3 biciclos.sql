--3º
create or alter trigger TRIG_UPDATE_STOCK
on order_item 
after insert
as
	begin
		declare @order int = (select order_id from inserted)
		declare @store_id int = (select store_id from ORDERS where order_id = @order)
		declare @item_id int = (select item_id from inserted)
		declare @quantity int = (select quantity from inserted)
		declare @product int = (select product_id from inserted)
		declare @price money = (select list_price from ORDER_ITEM where product_id = @product)
		
		update ORDER_ITEM
		set list_price = @price
		where order_id = @order and item_id = @item_id

		update STOCK
		set quantity = quantity - @quantity
		where product_id = @product and store_id = @store_id

		end
go