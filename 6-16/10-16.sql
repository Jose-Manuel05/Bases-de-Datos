--10º
UPDATE EMPLOYEE
SET Salary = Salary * 1.10
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM EMPLOYEE
    GROUP BY DepartmentID
    HAVING AVG(Salary) < 2000
);
--11º
UPDATE PRODUCT
SET UnitPrice = UnitPrice * (1 + i.Rate)
FROM PRODUCT p
JOIN SUPPLIER s ON p.SupplierID = s.SupplierID
JOIN INFLATION i ON s.CountryName = i.CountryName AND i.YearInf = '2024'
WHERE i.Rate > 0.05;

--12º


--13º
UPDATE CUSTOMER
SET CompanyName = 'VIP-' + CompanyName
WHERE CustomerID IN (
    SELECT CustomerID
    FROM ORDERS
    WHERE Status = 'Completed'
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 10
);

--14º
UPDATE CUSTOMER
SET IsActive = 0
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM ORDERS
    WHERE DATEDIFF(YEAR, OrderDate, GETDATE()) <= 1
);

--15º


--16º
UPDATE PRODUCT
SET UnitPrice = UnitPrice * 0.80
WHERE ProductID IN (
    SELECT ProductID
    FROM ORDER_DETAILS od
	join ORDERS o on od.OrderID = o.OrderID
    WHERE ShippedDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY ProductID
    HAVING SUM(Quantity) < 50
);