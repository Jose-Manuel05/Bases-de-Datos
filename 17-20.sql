begin transaction

--17�
delete from Orders
where ShippedDate is null and DATEDIFF(DAY, RequiredDate, GETDATE()) >= 10

--18�
delete from PRODUCT
where ProductID not in (
	select od.ProductID
	from ORDER_DETAILS od)
or ProductID in (
	select ProductID
	from ORDER_DETAILS od
	join ORDERS o on od.OrderID = o.OrderID
	where OrderDate >= dateadd(MONTH, -1, GETDATE()
	)
	group by ProductID
	having SUM(Quantity) = 0
);	
--19�
delete from CATEGORY
where CategoryID not in (
	select CategoryID
	from PRODUCT)

--20�
delete from SHIPPER
where ShipperID not in (
	select o.ShipVia
	from ORDERS o)

select ShipperID
from SHIPPER

if @@ERROR = 0
begin
	commit transaction;
end
else
begin 
	rollback;
end