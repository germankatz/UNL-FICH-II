1)

create proc sp_obtenerprecio
as
	select price from titles
		where title_id = 'PS2091'
return

exec sp_obtenerprecio

2)

exec sp_help @objname = sp_obtenerprecio

3)

select name,id,type from sysobjects
	where name = 'sp_obtenerprecio'

4)

select name from sysobjects
	where type = 'P'

5)

exec sp_helptext @objname = sp_obtenerprecio
exec sp_helptext @objname = sp_help

6)

create proc sp_obtenerprecio2 (@codigo varchar(10))
as
	select price from titles
		where title_id = @codigo
return

exec sp_obtenerprecio2 @codigo = 'PS1372'

7)

create proc sp_verventas @id int,@orden varchar(30),@cant int
as
	select ord_date from sales
		where stor_id = @id, ord_num = @orden, qty = @cant
return

exec sp_verventas @id = 7067,
		  @orden = 'P2121',
		  @cant = 120

exec sp_verventas 7067,    --@id
		  'P2121', --@orden
	          120	   --@cant

8)

create proc sp_obtenerprecio3 (@codigo varchar(10) = null)
as
	select price from titles
		where title_id = @codigo
return

exec sp_obtenerprecio3 @codigo = 'PS1372'
exec sp_obtenerprecio3

9)

create proc sp_obtenerprecio4 (@codigo varchar(10) = null)
as
	if @codigo is null
	begin
		print 'El SP sp_obtenerprecio4 requiere del parámetro title_id'
		return
	end
	select price from titles
		where title_id = @codigo
return

exec sp_obtenerprecio4 @codigo = 'PS1372'
exec sp_obtenerprecio4

10)

create table productos (
	codprod int not null,
	descr varchar(30) not null,
	precunit money not null,
	stock smallint not null
);

create table detalle (
	coddetalle int not null,
	numped int not null,
	codprod int not null,
	cant int not null,
	preciotot money null
)

insert into productos values (10,'Articulo 1',$50,20);
insert into productos values (20,'Articulo 2',$70,40)

create proc sp_buscarprecio @codprod int,@precunit money output
as
	select @precunit = precunit from productos
		where codprod = @codprod
return

declare @precioobtenido money
exec sp_buscarprecio 10,@precioobtenido output
select @precioobtenido 'Parámetro de salida'

create proc sp_insertardetalle 
	@coddetalle int,
	@numped int,
	@codprod int,
	@cant int
as
	declare @precioobtenido money
	exec sp_buscarprecio @codprod,@precioobtenido output
	insert into detalle values (@coddetalle,@numped,@codprod,@cant,@cant * @precioobtenido)
	if @@rowcount = 1
		print 'Se insertó una fila'
return

11)

exec sp_insertardetalle
	@CodDetalle = 1540,
	@NumPed = 120,
	@CodProd = 10,
	@Cant = 2

12)

declare @estado int
exec @estado = sp_insertardetalle
	@CodDetalle = 1540,
	@NumPed = 120,
	@CodProd = 10
      --@Cant = 2

print @estado

13)

CREATE PROCEDURE sp_BuscarPrecio2
 (@CodProd int, -- Parametro de entrada 
 @PrecUnit money OUTPUT) -- Parametro de salida
 AS
 SELECT @PrecUnit = PrecUnit
 FROM Productos
 WHERE CodProd = @Codprod
 IF @@RowCount = 0
 RETURN 70 -- No se encontro el producto 
IF @PrecUnit IS NULL
 RETURN 71 -- El producto existe pero su precio es NULL
 RETURN 0 -- El producto existe y su precio no es NULL 

CREATE PROCEDURE sp_InsertaDetalle2
 (@CodDetalle Int, -- Parametro de entrada a sp_InsertaDetalle2
 @NumPed Int, -- Parametro de entrada a sp_InsertaDetalle2
 @CodProd int, -- Parametro de entrada a sp_InsertaDetalle2 y al inner proc
 @Cant Int) -- Parametro de entrada a sp_InsertaDetalle2
 AS
 DECLARE @PrecioObtenido MONEY --Parametro de salida del inner procedure
 DECLARE @StatusRetorno Int
 EXECUTE @StatusRetorno = sp_BuscarPrecio2 @CodProd, @PrecioObtenido OUTPUT
 IF @StatusRetorno != 0
 BEGIN
 IF @StatusRetorno = 70
 RAISERROR ('Codigo de producto inexistente', 16, 1)
 ELSE
 IF @StatusRetorno = 71
 RAISERROR ('El producto %d no posee precio', 16, 1, @CodProd)
 ELSE
 RAISERROR ('Error en el SP sp_BuscarPrecio2', 16, 1)
 RETURN 99
 END 
 INSERT Detalle Values(@CodDetalle, @NumPed, @CodProd, @Cant, 
 @Cant * @PrecioObtenido)
 IF @@Error != 0
 RETURN 77
 If @@RowCount = 1
 PRINT 'Se inserto una fila'
 RETURN 0

exec sp_InsertaDetalle2
	@CodDetalle = 1540,
	@NumPed = 120,
	@CodProd = 30,
	@Cant = 2

14)

select pub_id,pub_name into editoriales from publishers
	where (1 < 0)

15)

create proc sp_pubs
as
	select pub_id,pub_name from publishers
return

insert editoriales
	exec sp_pubs
