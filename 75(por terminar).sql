--75º
create or alter procedure DEPARTMENT_PROCEDURES
as
	begin
		declare @list varchar(max) = ''
		declare @count int = 1
		declare @totalDeparment int = (select COUNT(DepartmentID) from Department)
		declare @totalCost money
		declare @total money = 0

		print ('DEPARMENT				HEAD				N_PHYSICIANS				T_COST_PROCEDURES')
		print ('-----------------------------------------------------------------------------------------')

			while @count <= @totalDeparment
				--lista
				select @list = @list + d.Name + space(10) + ph.Name + space(10) + cast(COUNT(ph.PhysicianID) as varchar) + space(25) + char(10)
				from Department d	
				join Physician ph on d.Head = ph.PhysicianID
				join Affiliated_With aw on d.DepartmentID = aw.DepartmentID
				where d.DepartmentID = @count
				group by d.Name ,ph.Name

				--Coste
				select @totalCost = @totalCost + 
				from Department
			end
	end
go
execute DEPARTMENT_PROCEDURES