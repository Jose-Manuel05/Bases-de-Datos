--11º
create or alter trigger TRIG_WONGAMES
on MATCH instead of insert
as
	begin
		declare @team1 varchar(50) = (select Team1 from inserted)
		declare @team2 varchar(50) = (select Team2 From inserted)
		declare @wonsetteam1 int = (select WonSetTeam1 from inserted)

		if @wonsetteam1 = 3
			begin
				update TEAM
				set WonGames = WonGames + 1
				where Team = @team1
			end
		else 
			begin
				update TEAM
				set WonGames = WonGames + 1
				where Team = @team2
			end
	end
go

--12º
create or alter trigger TRIG_UPDATE_PLAYED
on PLAYED instead of insert
as
	begin
		declare @player_id int = (select PlayerId from inserted)

		update PLAYER
		set PlayedMatches = PlayedMatches + 1
		where PlayerId = @player_id
	end
go