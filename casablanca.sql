--1º
create or alter procedure REWARDS_REPORT (@month datetime, @year datetime, @money smallmoney)
as
	begin
		declare @print varchar(max) = ''

		print 'CUSTOMER				TOTAL'
		print '============================='

		select @print = @print +
		cast(CONCAT(c.firstname,' ',c.lastname) as char(18))+
		cast(Cast(SUM(amount) as money)as char(7))+' €' +CHAR(10)
		from CUSTOMER c
		join RENTAL r on c.CustomerID = r.CustomerID
		join PAYMENT p on r.RentalID = p.RentalID
		where YEAR(RentalDate) = @year and MONTH(RentalDate) = @month
		group by FirstName, LastName
		having SUM(Amount) >= @money
		print @print
	end
	go
EXEC REWARDS_REPORT 5, 2005, 30

go

--2º
create or alter procedure COMPARE_STORES
as
begin
	set language 'ENGLISH'
	declare @list varchar(max)=''
	declare @totalstores int
	declare @numstore int=1

	select @totalstores=max(storeid)
	from store

	while @numstore<=@totalstores
	begin 
		SELECT @list=@list+namestore+char(10)+'Manager: '+firstname+ CHAR(10)
		FROM store st
		join STAFF sf on st.ManagerID = sf.StaffID
		WHERE st.storeid=@numstore
		SET @list=@list+'==================================='+CHAR(10)
		SELECT @list=@list+cast(YEAR(PaymentDate)as varchar)+'    '+
		cast(datename(month,PaymentDate)as char(12))+
		cast(SUM(amount) as char(10))+' €'+CHAR(10)
		FROM store st
		join STAFF sf on st.StoreID = sf.StoreID
		join PAYMENT p on sf.StaffID = p.StaffID
		WHERE st.StoreID=@numstore 
		GROUP BY datename(month,PaymentDate),month(PaymentDate),YEAR(PaymentDate)
		ORDER BY YEAR(PaymentDate), month(PaymentDate)
		print @list
		set @numstore+=1
		set @list=''
	end
end
go
execute COMPARE_STORES

go

--3º
CREATE or alter PROCEDURE NEW_CUSTOMER 
@storename varchar(30), @fname varchar(45), @lname varchar(45), @email varchar(45)
AS
BEGIN
	declare @storeid int=0

	--check if the customer exists using the email account
	if @email not in (select email from customer)
	BEGIN 
		--check if the store exists
		set @storeid=(select storeid from STORE where NameStore like '%'+@storename+'%')
		if @storeid=0
		begin
			print 'The name of the store is not correct'
			return
		end
		INSERT INTO customer
		VALUES
		(@fname, @lname, @email,1,@storeid, getdate())
		if @@error = 0
		begin
    		print 'Customer inserted' 
		end
		else
		begin
			print 'the insertion failed'
		end;

	END
	ELSE
	BEGIN
		PRINT 'THE CUSTOMER ALREADY EXISTS'
		return
	END
END
go
EXEC NEW_CUSTOMER 'Lethbridge', 'ANTONIO', 'RUIZ', 'ANTONIORUIZ@gmail.com'

go

--4º
create or alter procedure ACTOR_FILM_RATING (@name varchar(45), @surname varchar(45))
as
	begin
		declare @print varchar(max) = ''
		declare @actorID int = 0

		set @actorID = (select ActorID
						from ACTOR
						where FirstName = @name and LastName = @surname)

		print @name + ' ' + @surname
		print '---------------------------------'
		select @print=@print+cast(title as char(25))+cast(cast(avg(cast(rating as decimal(2,1))) as decimal(2,1)) as varchar)+CHAR(10)
		from FILM_ACTOR, FILM, INVENTORY,RENTAL, REVIEW
		where FILM_ACTOR.ActorID=@actorID and FILM.FilmID=FILM_ACTOR.FilmID and
		FILM.FilmID=INVENTORY.FilmID and RENTAL.InventoryID=INVENTORY.InventoryID and
		RENTAL.RentalID=REVIEW.rentalID
		group by title
		print @print

	end
go
EXEC ACTOR_FILM_RATING 'Penelope', 'Guiness'