create database WORLD_VISION

create table ASSOCIATION(
	Code_Assoc tinyint not null identity primary key,
	Name_Assoc varchar(60) not null,
	AddressAssoc varchar(30) not null,
	Phone char(9) not null,
	check (Phone like ('^[0-9]{9}'))
);

create table PROJECT(
	Code_Project tinyint not null identity primary key,
	Description_Proj text not null,
	Amount_Money smallmoney not null,
	Project_Start_Date date not null,
	Project_End_Date date not null,
	Code_Assoc tinyint not null,
	foreign key (Code_Assoc) references ASSOCIATION(Code_Assoc),
	check (Project_End_Date >= Project_Start_Date),
	check (Code_Project like ('PROJ[0-9][0-9][0-9]'))
);

create table COLLABORATOR(
	NIF tinyint not null identity primary key,
	Name_Collaborator varchar(30) not null,
	Addres_Collab varchar(30) not null,
	Phone char(9) not null,
	Account int not null,
	check (Phone like ('^[0-9]{9}')),
	check (Account like('^[0-9]{18}')),
	check (NIF like ('^[0-9]{2}.^[0-9]{3}.^[0-9]{3}[A-Z]$'))
);

create table PAYMENT(
	Number_Payment int not null identity primary key,
	Concept varchar(20) not null,
	Amount_Money money not null,
	Date_Payment date not null,
	NIF_COLLABORATOR tinyint not null,
	foreign key (NIF_COLLABORATOR) references COLLABORATOR(NIF),
	check (NIF_COLLABORATOR like ('^[0-9]{2}.^[0-9]{3}.^[0-9]{3}[A-Z]$'))

);

create table DONOR(
	Id_Donor tinyint identity primary key,
	Name_Donor varchar(30) not null,
	Addres_Donor varchar(30) not null,
	Phone char(9) not null,
	Email varchar(30) not null,
	check (Phone like ('^[0-9]{9}$')),
	check (Email like ('__%@__%.__%'))
);

create table DONATION(
	Date_Donation date not null,
	Amount_Money money not null,
	Id_Donor tinyint not null,
	Code_Project tinyint not null,
	primary key (Date_Donation,Id_Donor,Code_Project),
	foreign key (Id_Donor) references DONOR(Id_Donor),
	foreign key (Code_Project) references PROJECT(Code_Project),
);