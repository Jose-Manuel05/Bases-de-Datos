--6º
select NameItem, count(DaysForDeliver) as T_Suppliers
from ITEM i
join ITEMSUPPLIER isp on i.NumItem = isp.NumItem
where DaysForDeliver <= '5' 
group by NameItem
having COUNT(isp.NumSalesman) > '3'

--7º
select CompanyName, count(NumSalesman) as Number_Salesman
from SUPPLIER sp
join SALESMAN s on sp.NumCompany = s.NumCompany
group by CompanyName
having COUNT(NumSalesman) > '2'
order by Number_Salesman desc

--8º
select NameItem, CompanyName
from ITEM i
join ITEMSUPPLIER its on i.NumItem = its.NumItem
join SALESMAN s on its.NumSalesman = s.NumSalesman
join SUPPLIER sp on s.NumCompany = sp.NumCompany
where CompanyName = 'Mecemsa' or CompanyName = 'Alibaba'

--9º
select CompanyName, NameItem, its.PriceCost as COST, od.Price as SOLD_PRICE
from SUPPLIER sp
join SALESMAN s on sp.NumCompany = s.NumCompany
join ITEMSUPPLIER its on s.NumSalesman = its.NumSalesman
join ITEM i on its.NumItem = i.NumItem
join ORDERDETAILS od on i.NumItem = od.NumItem
where od.Price < its.PriceCost and od.ReceivedQty < od.OrderQty

