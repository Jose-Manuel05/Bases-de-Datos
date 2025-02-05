--41�
create view [Customer from france] as
select CompanyName, City, Country
from Customers
where Country = 'France'


--42�
create view [Suppliers from Canada or Germany] as
select CompanyName, ContactName, Country
from Suppliers
where Country in ('Canada', 'Germany')

--43�
create view [Display prodcuts higer] as
select ProductName, UnitPrice
from Products
where UnitPrice > '50'

--44�
create view [Products less than 8 and not category 8] as
select ProductName, CategoryID, UnitPrice
from Products
where UnitPrice < '8' and CategoryID != '8'

