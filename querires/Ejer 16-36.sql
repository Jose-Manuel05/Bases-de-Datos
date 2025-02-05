--16º
create table Therme(
ThemeID INT Identity(1,1) PRIMARY KEY,
NameTheme VARCHAR(30) NOT NULL
)
insert into Therme
values
('Fiction'),('Family'),('War'),('Love');

select * from Therme

--17º
create table Copia(
ISBN CHAR(10) PRIMARY KEY,
Title VARCHAR(45) NOT NULL,
ThemeID INT,
PublisherID INT,
Units TINYINT NOT NULL
foreign key (ThemeID) references Therme(ThemeID),
foreign key (PublisherID) references Publisher(PublisherID)
);

insert into Copia
values
('8415323256','Conjunto vacio','3','1','7');

select * from Copia

--18º
create table Lending(
DNI char(11) not null,
ISBN char(10) not null, 
DateLending date not null,
primary key (DNI, ISBN, DateLending),
foreign key (DNI) references Member(DNI),
foreign key (ISBN) references Copia(ISBN)
);

insert into Lending
values
('21.459.236L','8415323256','2021-10-10')

--19º
alter table Member
add Email varchar(50);

insert into Member
values
('21.563.234J','Filadelfo','Marco','Toro','666253698','1968-10-15','2015-02-01','filmar@gmail.com');

select * from Member

--20º
alter table Lending
add DateReturn Date;

select* from Lending

--21º
alter table Member
alter column NameMember varchar(50);

select * from Member

--22º
alter table Copia
add Year_Publication Date;

select * from Copia

--23º
alter table Copia
drop column Year_Publication;

select * from Copia

--Progres Check
--24º
create database PRACTICE

--25º

use PRACTICE
create table Employee(
	Code int identity primary key,
    Name varchar(30) not null,
    Salary decimal(8, 2) check (Salary between 1500 and 2500));

--26º
use PRACTICE

create table Course(
	Code char(4) primary key,
	NameCourse varchar(40) not null unique,
	DayCourse char(9) not null
	check (DayCourse IN ('Tuesday', 'Thursday')));

--27º

use PRACTICE
create table Student(
	DNI char(12) primary key,
	NameStudent varchar(40) not null,
	Gender char(8) not null
	check (Gender IN ('Man', 'Woman', 'Bigender')));

--28º

use PRACTICE
create table Teacher(
	Code char(3) primary key,
	NameTeacher varchar(40) not null unique,
	Country varchar(60) default 'Spain',
	Email varchar(100) unique
	check (Email like '__%@__%.__%'));

--29º

use PRACTICE
create table Author(
	Code int identity primary key,
	NameAuthor varchar(40) not null unique,
	Country varchar(60) not null,
	BirthDate date not null,
	DeathDate date,
	check (Country in ('Spain','France','England')),
	check (DeathDate > BirthDate));

--30º

use PRACTICE
create table Ofice (
	Code char(3) primary key,
	NameOffice varchar(30) not null unique,
	PhoneNumber char(9),
	HolidayPeriod char(9) not null, 
	check (PhoneNumber like '^[0-9]{9}$'),
	check (HolidayPeriod in ('June', 'July', 'August', 'September')));

--31º

use PRACTICE
create table Book (
    isbn char(17) primary key,
    namebook varchar(100) not null,
    price decimal(5, 2) not null,
    category varchar(50) not null,
	check (price >= 10 and price <= 35)
);

alter table book 
add constraint isbn check (isbn like '[0-9]{x}')

--32º

use PRACTICE
create table Subject (
    code int primary key identity,
    namesubject varchar(40) not null,
    hours tinyint not null check (hours >= 2 and hours <= 8),
    codteacher char(3) not null,
    foreign key (codteacher) references Teacher(Code)
);

--33º

use PRACTICE
create table Mark (
    codteacher char(3) not null,
    dnistudent char(12) not null,
    mark decimal(4, 1) not null check (mark >= 0 and mark <= 10),
    foreign key (codteacher) references teacher(Code),
    foreign key (dnistudent) references student(DNI),
    primary key (codteacher, dnistudent)
);


--34º

use PRACTICE
create table Publisher (
    code char(3) primary key,
    namepublisher varchar(50) unique not null,
    postalcode char(4) not null,
    country varchar(20) not null default 'spain',
    phonenumber varchar(20) not null
);

--35º

use PRACTICE
create table Products (
    code char(6) primary key,
    nameproduct varchar(30) unique not null,
    quantity int not null check (quantity between 1 and 99)
);
