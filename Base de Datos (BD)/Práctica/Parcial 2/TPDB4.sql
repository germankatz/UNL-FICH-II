1)

exec sp_helpdb
use tempdb
select * from pubs.dbo.authors

2)

DECLARE @Mens varchar(40)
SET @Mens = 'Just testing...'
SELECT @Mens
go --procesa lo anterior al go y continua con lo que sigue

SELECT @Mens --falla porque al estar el go anterior la variable local @mens ya no existe
go

3)

DECLARE @Cant smallint
UPDATE sales
 SET qty = qty + 100,
 @cant = qty
 WHERE stor_id = 7067

print @cant

4)

print 'El último código de error registrado fue ' + convert(varchar(10),@@error)

5)

declare @precio float,
		@relacion varchar(20)
select @precio = price from titles
	where title_id = 'BU1111'
if @precio < 10
	set @relacion = 'menor'
else
	if @precio = 10
		set @relacion = 'igual'
	else
		set @relacion = 'mayor'

print 'El precio es ' + @relacion + ' a $10.'

6)

create table t1 (
	id int identity(1,1),
	fechahora datetime not null default current_timestamp
)

declare @cont int
set @cont = 0
while @cont < 100
begin
	insert into t1 default values
	set @cont = @cont + 1
end

select * from t1

7)

begin transaction
insert into pedido(numPed, fechPed, codCli) values(1108, CURRENT_TIMESTAMP, 22)
declare @pu int
select @pu = precUnit from productos where (codProd = 100)
insert into detalle(codDetalle, numPed, codProd, cant, precioTot) values(1200, 1108, 100, 5, 5*@pu)
update productos set stock = stock-5
commit transaction
