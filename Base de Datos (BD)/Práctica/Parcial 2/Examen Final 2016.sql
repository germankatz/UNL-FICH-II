begin transaction
--
create table ganancias (
	columna1 varchar(100) null,
	columna2 varchar(100) null,
	columna3 varchar(100) null,
	columna4 varchar(100) null,
);
--
declare curpubs cursor
for
select S.stor_id,sum(S.qty*T.price) from titles T
	inner join sales S
		on T.title_id = S.title_id
	group by S.stor_id
	order by 2

open curpubs

declare @monto money

select sum(S.qty*T.price) 'precio' into #temp from titles T
	inner join sales S
		on T.title_id = S.title_id
	group by S.stor_id
select @monto = max(precio) from #temp

drop table #temp

declare @id = char(4),
		@suma = money,
		@ganancia = varchar(50)

fetch next from curpubs into @id,@precio
while @@fetch_status = 0
begin
	if @precio < round(@monto*0.25)
	begin
		select @ganancia = columna4 from ganancias
		if @ganancia = null
			insert into ganancias (calumna4) values (@id)
		else 
			insert into ganancias (calumna4) values (@ganancias+'_'+@id)
	end
	else if @precio < round(@monto*0.5)
	begin
		select @ganancia = columna3 from ganancias
		if @ganancia = null
			insert into ganancias (calumna3) values (@id)
		else 
			insert into ganancias (calumna3) values (@ganancias+'_'+@id)
	end
	else if @precio < round(@monto*0.75)
	begin
		select @ganancia = columna4 from ganancias
		if @ganancia = null
			insert into ganancias (calumna2) values (@id)
		else 
			insert into ganancias (calumna2) values (@ganancias+'_'+@id)
	end
	else
	begin
		select @ganancia = columna1 from ganancias
		if @ganancia = null
			insert into ganancias (calumna1) values (@id)
		else 
			insert into ganancias (calumna1) values (@ganancias+'_'+@id)
	end
	fetch next from curpubs into @id,@precio
end

close curpubs
deallocate curpubs
--
declare @monto money

select sum(S.qty*T.price) 'precio' into #temp from titles T
	inner join sales S
		on T.title_id = S.title_id
	group by S.stor_id
select @monto = max(precio) from #temp

drop table #temp

declare @sql varchar(100)

set @sql = 'alter table ganancias rename column columna1 to GananciasHasta$'+convert(round(@monto,0),varchar(20));
exec(@sql);
set @sql = 'alter table ganancias rename column columna1 to GananciasHasta$'+convert(round(@monto*0.75,0),varchar(20));
exec(@sql);
set @sql = 'alter table ganancias rename column columna1 to GananciasHasta$'+convert(round(@monto*0.5,0),varchar(20));
exec(@sql);
set @sql = 'alter table ganancias rename column columna1 to GananciasHasta$'+convert(round(@monto*0.25,0),varchar(20));
exec(@sql);

commit transaction
