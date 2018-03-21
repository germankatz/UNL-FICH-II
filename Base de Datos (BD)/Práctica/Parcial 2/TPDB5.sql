1)

declare curpubs cursor
	for select T.price from titles T
			inner join publishers P
				on T.pub_id = P.pub_id
			where P.pub_id = '0736'
	for update

open curpubs
declare @precio money
fetch next from curpubs into @precio
while @@fetch_status = 0
begin
	if @precio <= 10
		update titles
		set price = price * 1.25
		where current of curpubs
	else
		update titles
		set price = price * 0.75
		where current of curpubs
	fetch next from curpubs into @precio
end
close curpubs
deallocate curpubs

2)
begin transaction
declare curpubs cursor
for select T.title,T.type,sum(S.qty) from titles T
		inner join sales S
			on T.title_id = S.title_id
		group by T.title_id,year(S.ord_date),T.title,T.type
for update

open curpubs
declare @titulo varchar(60),
		@tipo varchar(60),
		@suma int,
		@cont int
select price from titles
fetch next from curpubs into @titulo,@tipo,@suma
while @@fetch_status = 0
begin
	if @suma > 1000
	begin
		update titles
		set price = price * 0.9
		where current of curpubs
		set @cont = @cont + 1
	end
	else if @tipo = 'popular_type' or @titulo like '%computer%'
		 begin
			update titles
			set price = price * 0.5
			where current of curpubs
			set @cont = @cont +1
		 end
		 else
		 begin
			update titles
			set price = price * 0.75
			where current of curpubs
			set @cont = @cont + 1
		 end
	fetch next from curpubs into @titulo,@tipo,@suma
end
select @cont
select price from titles
close curpubs
deallocate curpubs
rollback transaction
--

begin transaction
--Cursor
declare curpubs cursor for
	select T.title,T.type,sum(S.qty),T.price from titles T
		inner join sales S
			on T.title_id = S.title_id
		group by T.title,T.type,year(S.ord_date),T.price
--

open curpubs
declare @titulo varchar(80),
		@tipo char(12),
		@cantidad smallint,
		@precio money,
		@cont int

set @cont = 0

fetch next from curpubs into
	@titulo,@tipo,@cantidad,@precio

while @@fetch_status=0
begin
	if @cantidad > 1000
		begin
			print @titulo+' '+convert(varchar(10),@precio) 
			update titles
			set price = @precio*0.9
			where current of curpubs
			set @cont = @cont+1 
			print @titulo+' '+convert(varchar(10),@precio)
		end
	else
		if @tipo = 'popular_comp' or @titulo like '%computer%'
		begin
			print @titulo+' '+convert(varchar(10),@precio) 
			update titles
			set price = @precio*0.5
			where current of curpubs
			set @cont = @cont+1 
			print @titulo+' '+convert(varchar(10),@precio)
		end	
		else
		begin
			print @titulo+' '+convert(varchar(10),@precio) 
			update titles
			set price = @precio*0.75
			where current of curpubs
			set @cont = @cont+1 
			print @titulo+' '+convert(varchar(10),@precio)
		end
	fetch next from curpubs into
	@titulo,@tipo,@cantidad,@precio
end --end while
print @cont
close curpubs
deallocate curpubs
rollback transaction
