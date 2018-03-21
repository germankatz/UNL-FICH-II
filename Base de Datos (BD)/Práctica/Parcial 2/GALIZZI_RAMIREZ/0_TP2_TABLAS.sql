create table provincia
(
	id int primary key identity(1, 1),
	codigo char(1) unique not null,
	descripcion varchar(60) not null
)

create table localidad
(
	id int primary key identity(1, 1),
	codigo as id,
	descripcion varchar(60) not null,
	codigo_postal int,
	id_provincia int not null foreign key references provincia(id),
	constraint u_localidad unique(codigo, id_provincia)
)

create table pais
(
	id int primary key identity(1, 1),
	codigo varchar(3) unique not null,
	descripcion varchar(60) not null,
)

create table tipo_domicilio
(
	id int primary key identity(1, 1),
	codigo smallint unique not null,
	descripcion varchar(60) not null,
)

create table direccion
(
	id int primary key identity(1, 1),
	numero_portal int,
	letra_domicilio varchar(5),
	nombre_calle_sin_nomenclar varchar(120),
	piso varchar(20),
	departamento varchar(20),
	manzana varchar(20),
	escalera varchar(20),
	monoblock varchar(20),
	torre varchar(20),
	vivienda varchar(20),
	edificio varchar(20),
	sector varchar(20),
	observaciones varchar(20),
	id_localidad int not null foreign key references localidad(id),
	id_tipo_domicilio int not null foreign key references tipo_domicilio(id),
	id_pais int not null foreign key references pais(id)
)

create table actor
(
	id int primary key identity(1, 1),
	codigo as id,
	alta datetime not null,
	baja datetime,
	telefono_principal varchar(20),
	movil_principal varchar(20),
	email_principal varchar(120),
	observaciones varchar(255),
	id_pais	int not null foreign key references pais(id),
	constraint u_actor unique(codigo)
)

create table direccion_actor
(
	id int primary key identity(1, 1),
	item smallint not null,
	id_direccion int foreign key references direccion(id),
	id_actor int foreign key references actor(id),
	constraint u_direccion_actor unique(item, id_actor)
)

create table persona_fisica
(
	id int primary key identity(1, 1),
	sexo varchar(30) not null constraint chk_sexo check (sexo in ('MASCULINO', 'FEMENINO', 'NO_INFORMADO')),
	apellido varchar(120) not null,
	nombre varchar(120) not null,
	fecha_nacimiento datetime not null,
	fecha_fallecimiento datetime,
	escolaridad varchar(30) not null constraint chk_escolaridad check (escolaridad in ('PRIMARIA', 'SECUNDARIA', 'TERCIARIA', 'UNIVERSITARIA', 'NO_POSEE', 'NO_INFORMADO')),
	tiene_discapacidad bit not null,
	id_actor int not null foreign key references actor(id),
	nro_documento int not null,
	tipo_documento varchar(30) not null constraint chk_tipodoc check (tipo_documento in ('DNI', 'LE', 'LC', 'CEDULA', 'PASAPORTE', 'NO_INFORMADO')),
	constraint u_persona_fisica unique(nro_documento, tipo_documento)
)

create table estado_civil_persona
(
	id int primary key identity(1, 1),
	item smallint not null,
	fecha_desde datetime not null,
	fecha_hasta datetime,
	estado_civil varchar(30) not null constraint chk_estado_civil check (estado_civil in ('SOLTERO', 'CASADO', 'UNIDO_DE_HECHO', 'SEPARADO', 'DIVORCIADO', 'VIUDO', 'FALLECIDO', 'NO_INFORMADO')),
	id_persona_fisica int not null foreign key references persona_fisica(id),
	constraint u_estado_civil_persona unique(item, id_persona_fisica)
)

alter table persona_fisica add
id_estado_civil_persona int null foreign key references estado_civil_persona(id)


create table familiares
(
	id int primary key identity(1, 1),
	item smallint not null,
	fecha_desde datetime not null,
	fecha_hasta datetime,
	vinculo varchar(30) not null constraint chk_vinculo check (vinculo in ('CONYUGE', 'HIJO', 'HIJASTRO', 'A_CARGO', 'PADRE', 'NIETO', 'CONCUBINO', 'NO_INFORMADO', 'ABUELO', 'PADRASTRO', 'FAMILIAR_TUTOR')),
	observaciones varchar(256),
	id_persona_fisica_persona int not null foreign key references persona_fisica(id),
	id_persona_fisica_pariente int not null foreign key references persona_fisica(id),
	constraint u_familiares unique(item, id_persona_fisica_persona)
)

create table afiliado
(
	id int primary key identity(1, 1),
	codigo as id,
	tipo_afiliado varchar(30) not null constraint chk_tipoafiliado check (tipo_afiliado in ('VOLUNTARIO', 'EFECTIVO')),
	fecha_alta datetime not null,
	fecha_baja datetime,
	observaciones varchar(256),
	id_persona_fisica int not null foreign key references persona_fisica(id)
)

create table estado_afiliado
(
	id int primary key identity(1, 1),
	secuencia smallint not null,
	estado_afiliado varchar(30) constraint chk_estado_afiliado check (estado_afiliado in ('EN_PROCESO_ALTA', 'ACTIVO', 'QUIEBRA', 'INHABILITADO', 'BAJA')),
	fecha datetime not null,
	observaciones varchar(256),
	id_afiliado int not null foreign key references afiliado(id),
	constraint u_estado_afiliado unique(secuencia, id_afiliado)
)

alter table afiliado add
id_estado_afiliado int null foreign key references estado_afiliado(id)


create table familiar_afiliado
(
	id int primary key identity(1, 1),
	item smallint not null,
	fecha_alta datetime not null,
	fecha_baja datetime,
	observaciones varchar(256),
	id_afiliado int not null foreign key references afiliado(id),
	id_familiares int not null foreign key references familiares(id),
	constraint u_familiar_afiliado unique(item, id_afiliado)
)

create table cuentas_afiliado
(
	id int primary key identity(1, 1),
	item smallint not null,
	fecha_alta datetime not null,
	fecha_baja datetime,
	codigo_sistema_anterior int not null,
	id_afiliado int not null foreign key references afiliado(id),
	constraint u_cuentas_afiliado unique(item, id_afiliado)
)
