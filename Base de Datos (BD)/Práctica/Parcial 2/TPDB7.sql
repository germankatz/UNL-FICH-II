1)

create trigger tg_cliente
on cliente
for insert,delete
as
	raiserror('El número de filas afectadas fue %d',16,1,@@rowcount)

insert into cliente values (1,'Ramírez','Darién','Sgto. Cabral 1746',3000);


2)

select * from sysobjects 
	where (type = 'TR')

3)

select * from sysobjects 
	where name = 'cliente'

4)

exec sp_helptext employee_insupd

5)

select * into autores from authors

create trigger tg_autores
on autores
for insert,update,delete
as
	raiserror('El número de filas afectadas fue %d',16,1,@@rowcount)

delete from autores
	where au_id = '172-32-1176';

delete from autores
	where au_id = '213-46-8915'

6)

create trigger tg_autores_iu
on autores
for insert,update
as
	print 'Datos insertados en transaction log: '
	select * from inserted
	print 'Datos eliminados en transaction log: '
	select * from deleted

insert into autores
values ('111-11-1111','Lynne','Jeff','415 658-9932','Gálvez y Ochoa','Berkeley','CA','94705',1)
	
update autores
set au_fname = 'Nicanor'
where au_id = '111-11-1111'

7)

create trigger tg_productos_iu
on productos
for insert,update
as
	begin transaction
	declare @stock int
	select @stock = stock from inserted
	if @stock < 0
	begin
		raiserror('El stock insertado es negativo',16,1)
		rollback transaction
	end
	else
		commit transaction

insert into productos
values (3,'Ike',$520,230)

update productos
set stock = 12
where codProd = 3
