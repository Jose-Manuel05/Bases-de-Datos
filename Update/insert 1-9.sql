--1º
create table DISTRIBUTED_STATISTICS (
	TypeResources varchar(50),
	TotalDistributed decimal(6,2) not null,
	TypeQty char(6) not null
);

insert into DISTRIBUTED_STATISTICS (TypeResources, TotalDistributed, TypeQty)
select r.TypeRes, sum(d.Quantity) as TotalDistributed, d.TypeQty 
from RESOURCES r
join DISTRIBUTION d on r.IdRes = d.IdRes
group by r.TypeRes, d.TypeQty
;

select * 
from DISTRIBUTED_STATISTICS

--2º
create table BENEFICIARY_STADISTICS(
	NameBeneficiary varchar(50) not null,
	Age tinyint not null,
	TypeResources varchar(50),
	TotalRes as char(4),
	TypeQty char(5)
);

insert into BENEFICIARY_STADISTICS
select b.NameBene, DATEDIFF(year, b.DateOfBirth, GETDATE()), r.TypeRes,
sum(d.Quantity), d.TypeQty
from RESOURCES r
join DISTRIBUTION d on d.IdRes=r.IdRes
join BENEFICIARY b on b.IdBene=d.IdBene
where DATEDIFF(year, b.DateOfBirth, GETDATE()) > 60
group by b.NameBene, b.DateOfBirth, r.TypeRes, d.Quantity,d.TypeQty

select * 
from BENEFICIARY_STADISTICS

--3º
create table DONOR_STADISTICS (
	Donorld char(3) not null,
	NameDonor varchar(50) not null,
	TotalAmount decimal(6,2) not null,
	AvgAmount decimal(6,6) not null
);

insert into DONOR_STADISTICS(Donorld, NameDonor, TotalAmount, AvgAmount)
select d.DonorID, concat(NameDonor, ' (',d.TypeDonor,')'), SUM(do.Amount), AVG(do.Amount)
from DONOR d
join DONATION do on d.DonorID = do.DonorID
group by d.DonorID, d.NameDonor, TypeDonor

select * 
from DONOR_STADISTICS

--4º
drop table if exists dbo.SUMMARY_PROJECT
create table SUMMARY_PROJECT (
	Disaster varchar(30),
	NameProject varchar(50),
	TotalHours decimal(4,1),
	TotalVolunteer int
);

insert into SUMMARY_PROJECT (Disaster, NameProject, TotalHours, TotalVolunteer)
select CONCAT(TypeDisaster, '-', LocationDis) as Disaster, NameProject, SUM(HoursWork), COUNT(NumVol)
from DISASTER d
join RELIEF_PROJECT rp on d.IdDisaster = rp.IdDisaster
join VOLUNTEER_HOURS vh on rp.IdProject = vh.IdProject
group by TypeDisaster, LocationDis, NameProject

select *
from SUMMARY_PROJECT

--5º
drop table if exists dbo.VOLUNTEERS_INCENTIVE
create table VOLUNTEERS_INCENTIVE(
	Namevol varchar(30) not null, 
	TotalHours decimal(5,1) not null,
	Incentive smallmoney not null
);

insert into VOLUNTEERS_INCENTIVE
select NameVol, SUM(HoursWork), case
when sum(vh.HoursWork) >= 90 then 100
when sum(vh.HoursWork) >= 60 then 70
when sum(vh.HoursWork) >= 10 then 30
else 0
end as Incentive
from VOLUNTEER v
join VOLUNTEER_HOURS vh on v.NumVol = vh.NumVol
group by NameVol
order by SUM(HoursWork)

select *
from VOLUNTEERS_INCENTIVE