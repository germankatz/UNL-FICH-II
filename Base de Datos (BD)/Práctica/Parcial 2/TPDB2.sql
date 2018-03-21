1)

create table cliente (
	codcli int not null,
	ape varchar(30) not null,
	nom varchar(30) not null,
	dir varchar(40) not null,
	codpost char(9) null default 3000
);

create table productos (
	codprod int not null,
	descr varchar(30) not null,
	precunit money not null,
	stock smallint not null
);
create table pedidos (
	numped int not null,
	fechped datetime not null,
	codcli int not null
);
create table detalle (
	coddetalle int not null,
	numped int not null,
	codprod int not null,
	cant int not null,
	preciotot float null
);
create table proveed (
	codprov int identity(1,1),
	razonsoc varchar(30) not null,
	dir varchar(30) not null
);

2)
insert into cliente (codCli, ape, nom, dir)
  values(1, 'LOPEZ', 'JOSE MARIA', 'Gral. Paz 3124');

3)
insert into cliente (codCli, ape, nom, dir, codPost)
  values(2, 'GERVASOLI', 'MAURO', 'San Luis 472', NULL);

4)


insert into proveed(razonSoc, dir)
  values('FLUKE INGENIERIA', 'RUTA 9 Km. 80')

insert into proveed(razonSoc, dir)
  values('PVD PATCHES', 'Pinar de Rocha 1154')

5)

create table ventas
(
	codVent integer identity(1, 1),
	fechaVent datetime not null default CURRENT_TIMESTAMP,
	usuarioDB varchar(30) not null default CURRENT_USER,
	cant int null
)

6)

insert into ventas(cant)
  values(100);

insert into ventas(cant)
  values(200);

7)

SELECT codCli, ape, nom, dir
 INTO clistafe --crea la tabla automaticamente
 FROM cliente
 WHERE (cliente.codPost = 3000);

8)

INSERT clistafe
 SELECT codCli, ape, nom, dir
 FROM cliente

9)

update cliente
set dir = 'The Crystal Method 168'
where (dir like '%1%');

10)

update cliente
	set codPost = DEFAULT

11)

delete clistafe
	where (ape = 'LOPEZ')

12)

create table #Tempi
(
	codcli int not null,
	ape varchar(30) not null
);

13)

select au_lname, au_fname, address, city
	into #tempau
	from authors
	where (state = 'CA');
