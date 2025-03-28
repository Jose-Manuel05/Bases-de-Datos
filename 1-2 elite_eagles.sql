--1º 
create or alter trigger TRIG_INSERT
on DEFAULTER
after update
as
	begin
		declare @id int = (select IdMember from inserted)
		declare @sport varchar(8) = (select Sport from inserted)
		declare @fee int = (select Registration_fee from REGISTERED)

		if @fee = 0
			begin
				insert into DEFAULTER
				values (@id, @sport)
			end

	end
go

--2º
create or alter trigger TRIG_UPDATE
on REGISTERED
after update
as
	begin
		declare @id int = (select IdMember from MEMBER)
		declare @sport varchar(8) = (select Sport from inserted)
		declare @fee_old bit = (select Registration_fee from deleted)
		declare @fee_new bit = (select Registration_fee from inserted)

		if @fee_old = 0 and @fee_new = 1
			begin
				delete from DEFAULTER
				where IdMember = @id and Sport = @sport
			end
	end
go
