create database DELIC_MEDIA

create table INGREDIENT(
	NameIngr varchar(30) not null primary key ,
	Colour varchar(30) not null,
	Category varchar(20) not null, 
	GrowSeasons varchar(20) not null,

);

create table CUISINE(
	Style varchar(20) not null primary key, 
	Contry varchar(20) not null
);

create table CHEF(
	Id_Chef tinyint not null identity primary key,
	Name_Chef varchar(30) not null, 
	Surname_Chef varchar(30) not null,
	Specialities varchar(60) not null
);

create table RECIPE(
	Id_Recipe int not null identity primary key,
	Name_Recipe varchar(60) not null,
	Prep_Time time not null,
	Cook_Time time not null,
	Occasions varchar(30) not null,
	Id_Chef tinyint not null,
	Id_Style varchar(20) not null,
	foreign key (Id_Chef) references Chef(Id_Chef),
	foreign key (Id_Style) references Cuisine(Style)

);

create table INGREDIENT_RECIPE(
	Quantity int not null,
	Type_M varchar(30) not null,
	Name_Ingr varchar(30) not null,
	Id_Recipe tinyint identity not null,
	primary key (Name_Ingr,Id_Recipe),
	
);

create table COOKBOOK(
	ISBN char(13) not null primary key,
	Title varchar(30) not null, 
	Pub_Date date not null,
	Pages tinyint not null,
	check (ISBN like ('^{3}[0-9]-^{10}[0-9]$'))
);

create table COOKBOOK_RECIPE(
	ISBN char(13) not null,
	Id_Recipe int not null,
	primary key (ISBN,Id_Recipe),
	foreign key (ISBN) references COOKBOOK(ISBN),
	foreign key (Id_Recipe) references RECIPE(Id_Recipe),
	check (ISBN like ('^{3}[0-9]-^{10}[0-9]$'))
	
);

create table USERS(
	Id_User tinyint identity primary key,
	Name_Users varchar(30),
	Email varchar(30),
	check (Email like ('__%@__%.__%'))
);

create table USER_RECIPE(
	Id_User tinyint,
	Id_Recipe int,
	primary key (Id_User,Id_Recipe),
	foreign key (Id_User) references USERS(Id_User),
	foreign key (Id_Recipe) references RECIPE(Id_Recipe),
);