--42º
create or alter procedure NEW_STUDENT
(@dni char(11), @first_name varchar(50), @middle_name varchar(50),@last_name varchar(50), @addres varchar(100), @city varchar(50), @phone char(9), @date date, @region varchar(100))
as
	begin
		if @dni in (select dni from table_student where dni = @dni)
			begin 
				print ('The studnet ' + @first_name + @middle_name + @last_name + 'Is alredy in the database')
			end
		else
			begin
				insert into table_student
				values (@dni, @first_name, @middle_name, @last_name, @addres, @city, @phone, @date, @region)
			end
	end

EXEC NEW_STUDENT '85.236.125P','Armando', 'Casitas', 'Rojas', 'Los Luceros, 10', 'Alicante',
'666585696','10/10/1990','C.Valenciana'

EXEC NEW_STUDENT '12.123.123C','José', 'Ruiz', 'Pérez', 'C/Mayor,6', 'San Vicente',
'666454545','23/06/1989','C.Valenciana'go--43ºcreate or alter procedure DELETE_STUDENT (@dni char(11))as	begin		if @dni not in (select DNI from table_student where DNI = @dni)			begin				print ('The DNI ' + @dni + 'does  not exist in the database')			end		else			begin				delete from table_student where DNI = @dni			end	endEXEC DELETE_STUDENT '85.236.125P'
EXEC DELETE_STUDENT '88.888.125P'go--44º create or alter procedure UPDATE_PHONE(@dni char(11) ,@phone char(9))as	begin		if @dni not in (select DNI from table_student where DNI = @dni)			begin				print ('The DNI ' + @dni + ' does  not exist in the database')			end		else			begin				update table_student				set Phone = @phone			end	endEXEC UPDATE_PHONE '85.236.125P', '652363636'
EXEC UPDATE_PHONE '88.888.125P', '623568989'go