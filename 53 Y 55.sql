--52º
--PHYSICIANS_PATIENTS_STAY. Create a procedure to display the doctors who have patients who have been hospitalized at least one time.
create or alter procedure PHYSICIANS_PATIENTS_STAY
as
	begin
		declare @list varchar(max) = ''

		select @list = @list + CAST(p.PhysicianID as char(4)) + p.NamePhysician + 
		char(10) + REPLICATE('-',35) + char(10) + 
		STRING_AGG(NamePatient, ',' + char(13) + char(10)) + char(13) + char(10) + char(13) + char(10)
		from PHYSICIAN p
		join patient pa on p.PhysicianID = pa.pcp
		join HOSPITALIZE h on pa.PatientSSN = h.PatientSSN
		group by p.PhysicianID, p.NamePhysician

		print @list
	end
go
execute PHYSICIANS_PATIENTS_STAY

--53º