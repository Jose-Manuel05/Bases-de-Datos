--6º
CREATE TABLE DONATIONS_EXPENSES (
    CenterId INT,
    NameCenter VARCHAR(100),
    TotalDonations MONEY,
    TotalExpenses MONEY
);

INSERT INTO DONATIONS_EXPENSES (CenterId, NameCenter, TotalDonations, TotalExpenses)
SELECT R.CenterId, R.NameCenter, ISNULL(SUM(D.Amount), 0) AS TotalDonations, ISNULL(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount / 100.0)), 0) AS TotalExpenses
FROM RELIEF_CENTER R
JOIN DONATION D ON R.CenterId = D.CenterId
JOIN ORDERS O ON R.CenterId = O.CenterId
JOIN ORDERS_DETAILS OD ON O.IdOrder = OD.IdOrder
GROUP BY R.CenterId, R.NameCenter;

--7º
CREATE TABLE DISASTER_BENEFICIARY_VOLUNTEER (
    IdDisaster SMALLINT,
    TypeDisaster VARCHAR(10),
    LocationDis VARCHAR(50),
    TotalBeneficiaries INT,
    TotalVolunteers INT
);

INSERT INTO DISASTER_BENEFICIARY_VOLUNTEER (IdDisaster, TypeDisaster, LocationDis, TotalBeneficiaries, TotalVolunteers)
SELECT D.TypeDisaster, D.LocationDis, D.Severity, ISNULL(COUNT(B.IdBene), 0) AS TotalBeneficiaries, ISNULL((
	SELECT COUNT(DISTINCT VH.NumVol) 
	FROM VOLUNTEER_HOURS VH 
	JOIN RELIEF_PROJECT RP ON VH.IdProject = RP.IdProject 
	WHERE RP.IdDisaster = D.IdDisaster), 0) AS TotalVolunteers
FROM DISASTER D
JOIN BENEFICIARY B ON D.IdDisaster = B.IdDisaster
GROUP BY D.TypeDisaster, D.LocationDis, D.Severity, D.IdDisaster;