--45º
create or alter procedure NEW_CLIENT
(@name_client varchar(30), @address varchar(100), @city varchar(40), @province varchar(40), @phone char(9))
as
	begin
		if @name_client in (select Nameclient from client where Nameclient = @name_client)
			begin
				print ''
			end
		else	
			if @name_client in (select NameProvince from province where NameProvince = @province)
				begin
					insert into client (Nameclient, Address, City, Idprovince, Phone)
					values (@name_client, @address, @city, @province, @phone)
				end
	end

EXEC NEW_CLIENT 'Trozado Andrés', 'C/ La Luz, 5', 'Espartinas', 'Sevilla', '666238545'
EXEC NEW_CLIENT 'Casitas Armando', 'C/ Traperia, 5', 'Churra', 'Murcia', NULL