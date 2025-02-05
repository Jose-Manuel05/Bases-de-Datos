create database ENTERPRISE
use ENTERPRISE
create table Client (
    dni char(9) primary key, 
    name varchar(50) not null,
    surname1 varchar(50) not null,
    surname2 varchar(50),
    address varchar(100),
    card_no char(16) unique
);

use ENTERPRISE
create table Renting (
    code int primary key identity, 
    dateRenting date not null, 
    days_no date not null, 
    km_current decimal(3,1) not null, 
    km_return decimal(3,1),
    dni_client char(9) not null,
    code_v int not null,
	code_of int not null,
	dni char(9) not null,
    foreign key (dni_client) references Client(dni),
    foreign key (code_v) references Vehicle(code_v),
	foreign key (code_of) references Office(cod_of),
	foreign key (dni) references Employee(dni)
);

use ENTERPRISE
create table Vehicle (
    code_v int primary key,
    model varchar(50) not null,
    type varchar(50) not null,
    colour varchar(30),
    code_m int not null,
    foreign key (code_m) references Brand(code_m)
);

use ENTERPRISE
create table Brand (
    code_m int primary key,
    n_brand varchar(50) not null
);

use ENTERPRISE
create table Office (
    cod_of int primary key,
    address varchar(100) not null,
    phone char(15)
);

use ENTERPRISE
create table Employee (
    dni char(9) primary key,
    name varchar(50) not null,
    surname1 varchar(50) not null,
    surname2 varchar(50),
    address varchar(100),
    account_no char(20) unique,

);

use ENTERPRISE
create table Course (
    code_c int primary key identity,
    date date not null,
    n_hours int not null,
    descrip varchar(255),
    dni_employee char(9) not null,
    foreign key (dni_employee) references Employee(dni)
);
