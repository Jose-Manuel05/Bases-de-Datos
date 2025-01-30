if exists (select 1 
		   from sys.databases 
		   where ([name] = N'School'))
	BEGIN 
		use master
		drop database School
	END
GO
create database School
go

use School
go
create table Student (
	DNI char(12) primary key not null,
	Student_Name varchar(30) not null,
	Surname1 varchar(30) not null,
	Surname2 varchar (30) not null,
	check (DNI like '^[0-9]{11}$'),
);

use School
create table Subjects (
	Code int identity primary key not null,
	Name_Subjects varchar(20) not null,
	Subject_hours tinyint not null
);

use School
create table Student_Subject (
	Code_subject int,
	DNI_Student char(12),
	mark decimal(4,2),
	check (mark between 0 and 10),
	primary key (Code_Subject, DNI_Student),
	foreign key (Code_subject) references Subjects(Code),
	foreign key (DNI_Student) references Student(DNI)
);

insert into Student
values
('021.459.236L','Eugene','Oregon','Perico')

insert into Subjects
values 
('Programing','8'),(' Operating Systems','5'), ('Mark-up Languages','3')

insert into Student_Subject 
values
()