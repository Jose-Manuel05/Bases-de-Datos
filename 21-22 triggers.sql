--21º
create or alter trigger TRIG_DROPOUT
on Application after delete
as
	begin
		declare @student_id int = (select StudentId from inserted)
		declare @state varchar(8) = (select StateApplication from inserted)

		if @state = 'Dropout'
			begin
				delete from RANKING 
				where StudentId = @student_id
			end
	end
go

--22º
create or alter trigger TRIG_UPDATE_RANKS2
on ranking after delete
as
	begin
		declare @rank int = (select RankStudent from deleted)

		update RANKING
		set RankStudent = RankStudent - 1
		where RankStudent > @rank
	end
go


select * from APPLICATION