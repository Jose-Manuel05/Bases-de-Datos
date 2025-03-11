
USE FERIA_ARTE_LOCAL
create table Feria(
	feria_id int identity primary key not null,
	nombre varchar(100) not null,
	ubicacion varchar(255) not null,
	fecha_inicio date not null,
	fecha_fin date not null
);

create table Artista(
	artista_id int primary key identity not null,
	nombre varchar(100) not null,
	biografia text not null,
	contacto varchar(100) not null
);

create table Obra(
	obra_id int primary key identity not null,
	titulo varchar(100) not null,
	año_creacion date not null,
	tecnica varchar(100) not null,
	precio decimal(6,2) not null,
	artista_id int,
	visitante_id int,
	foreign key (artista_id) references Artista(artista_id),
	foreign key (visitante_id) references Visitante(visitante_id)
);

create table Stand(
	stand_id int primary key identity not null,
	numero int not null,
	feria_id int,
	artista_id int,
	foreign key (feria_id) references Feria (feria_id),
	foreign key (artista_id) references Artista(artista_id)
);

create table Venta(
	venta_id int primary key identity not null,
	precio_final decimal(6,2) not null,
	nombre_comprador varchar(100) not null,
	fecha_venta date not null,
	obra_id int
	foreign key (obra_id) references Obra (obra_id)
);

create table Visitante(
	visitante_id int primary key identity,
	nombre varchar(100),
	correo varchar(100),
	tipo_entrada varchar(50)
);

create table Organizador(
	organizador_id int primary key identity not null,
	nombre varchar(100) not null,
	rol varchar(50) not null,
	contacto varchar(100) not null,
	feria_id int,
	foreign key (feria_id) references Feria (feria_id)
);