--56º
create or alter procedure NURSE_SHIFTS
as
	begin
		declare @print varchar(max) = ''



		select @print = @print +
		'NURSE: ' + n.NameNurse + char(10) +
		'-----------------------------------' + char(10) + 
		STRING_AGG(CONCAT('FLOOR: ', BlockFloor
		' CODE : ', Blockcode, space(3), cast(cast(start as date) as char(12)),
		cast(cast(start as time) as char(5)), space(3), cast(cast(finish as date) as char(12)),
		cast(cast(finish as time) as char(5))), char(10))
		from NURSE n 
		join ON_CALL oc on n.NurseID = oc.NurseID
	end
	print @print
go
execute NURSE_SHIFTS