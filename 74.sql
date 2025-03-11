--74º
create or alter procedure MEDICATION_PATIENTS
as
	begin
		declare @count int = 1
		declare @list varchar(max) = ''
		declare @maxcount int = (select MAX(CodeMed) from Medication)
		print ('Medication		Total_Patients')
		print ('------------------------------')
		while @count <= @maxcount
			begin
				select @list = @list + m.Name + SPACE(10) + CAST(COUNT(*) as varchar)
				from Medication m
				join Prescribes p on m.CodeMed = p.CodeMed
				where m.CodeMed = @count
				group by m.Name
				print (@list)
				set @list = ''
				set @count = @count + 1
			end

	end
go

execute MEDICATION_PATIENTS
