--10º
create or alter trigger TRIG_UPDATE_BILL
on PHONECALL
after insert
as
	begin
		declare @dni varchar(20) = (select DNI from inserted)
		declare @seconds int = (select Seconds from inserted)
		declare @month int = (select month(DateCall) from inserted)
		declare @year int = (select year(DateCall) from inserted)
		declare @codeplan int = (select CodePlan from CUSTOMER where DNI = @dni)
		declare @connectionFee money = (select ConnectionFee from PRICINGPLAN where Code = @codeplan)
		declare @pricePerSecond money = (select PricePerSecond from PRICINGPLAN where Code = @codeplan)
		declare @callCost money = (@connectionFee + (@seconds * @pricePerSecond))

		merge into BILL 
		using (select @dni as DNI, @month as MonthCall, @year as YearCall) as source
		on BILL.DNI = source.DNI 
		   and BILL.MonthCall = source.MonthCall 
		   and BILL.YearCall = source.YearCall
		when matched then
			update set Amount = Amount + @callCost
		when not matched then
			insert values (@dni, @month, @year, @callCost);
	end
go

select * from CUSTOMER
select * from PRICINGPLAN


--11º

--12º