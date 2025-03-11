--1º
create table LOG_YEAR_ACCOMMODATION_RATING(
	year_booking date not null,
	Name_accommodation varchar(25) not null,
	Average_rating int not null
)

insert into LOG_YEAR_ACCOMMODATION_RATING
select YEAR(b.DateBooking), NameAccom, AVG(Rating)
from BOOKING b
join ACCOMMODATION a on b.AccommodationID = a.AccommodationID
join REVIEW_ACC ra on b.AccommodationID = ra.AccommodationID
where YEAR(DateBooking) = '2024'
group by DateBooking, NameAccom

--2º
create table LOG_YEAR_TOUR_RATING(
	year_booking date not null,
	Name_tour varchar(25) not null,
	Average_rating int not null
)

insert into LOG_YEAR_TOUR_RATING
select YEAR(b.DateBooking), t1.NameTour, AVG(rt.Rating)
from BOOKING b
join TOUR t1 on b.TourID1 = t1.TourID
join TOUR t2 on b.TourID2 = t2.TourID
join REVIEW_TOUR rt on b.TourID1 = rt.TourID
where YEAR(b.DateBooking) = 2024
group by DateBooking, t1.NameTour

--3º
update ACCOMMODATION
set PricePerNight = PricePerNight * 1.10
where AccommodationID in (
	select top 3 AccommodationID
	from BOOKING 
	where YEAR(DateBooking) = 2024
	group by AccommodationID
	order by COUNT(BookingID) asc)
--4º
update ACCOMMODATION
set PricePerNight = PricePerNight * 0.85
where AccommodationID in (
	select top 3 AccommodationID
	from BOOKING 
	where YEAR(DateBooking) = 2024)
--5º
update TOUR
set Season1 = 0, Season2 = 0, Season3 = 0, Season4 = 0
where TourID = (
	select top 1 t.TourID 
	from TOUR t
	left join BOOKING b1 on t.TourID = b1.TourID1
	left join BOOKING b2 on t.TourID = b2.TourID2
	group by t.TourID
	order by COUNT(t.TourID) asc)

select Status
from BOOKING
--6º
delete CUSTOMER
where CustomerID not in (
	select CustomerID
	from BOOKING
	where Status != 'Cancelled'
	group by CustomerID
	having COUNT(BOOKING.BookingID) = 0)
--7º