create table INGREDIENT(
	ID_Ign char(3) primary key not null,
	Name_Ing varchar(20) not null
);

create table BEER (
	ID_Beer char(10) primary key,
	Name_Beer varchar(20),
	Style varchar(20), 
	ABV decimal(2, 2),
	Price money
);

create table BURGER (
	ID char(10) primary key not null,
	Name_Burguer varchar(20) not null,
	Burger_Description varchar(100) not null,
	Price money,
	ID_Beer char(10),
	foreign key (ID_Beer) references BEER(ID_Beer)
);

create table INGREDIENT_BURGER (
	ID_Ing char(3),
	ID_Burger char(10),
	TypeM varchar(50),
	Quantity decimal(10,2)
	primary key (ID_Ing, ID_Burger),
	foreign key (ID_Ing) references INGREDIENT(ID_Ing),
	foreign key (ID_Burger) references BURGER(ID)
);

create table DIET (
	ID_Diet char(3) primary key,
	Name_Diet varchar(20) 
);

create table BURGER_DIET(
	ID_Burger char(10),
	ID_Diet char (3),
	primary key (ID_Burger,ID_Diet)
);

create table FIZZY_DRINK (
	ID_Drink char(3) primary key not null,
	Name_Drink char(20) not null,
	Price money not null
);

create table SIDE_ORDER (
	ID_Side char(3) primary key not null,
	Name_Side varchar(20) not null
);

create table SMALL(
	Price money,
	ID_SideOrder char(3),
	foreign key (ID_SideOrder) references SideOrder(ID_Side)
);
create table MEDIUMS(
	Price money, 
	ID_SideOrder char(3),
	foreign key (ID_SideOrder) references SideOrder(ID_Side)
);
create table LARGE(
	Price money, 
	ID_SideOrder char(3),
	foreign key (ID_SideOrder) references SideOrder(ID_Side)
);

create table MENU (
	ID_Menu char(3) primary key not null,

);