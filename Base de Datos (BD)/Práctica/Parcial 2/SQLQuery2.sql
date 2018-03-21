drop table #titulos
drop table #ventastotales

-- Publicaciones con mas de un autor
select T.title_id into #titulos from titles T
	inner join titleauthor TA
		on (T.title_id = TA.title_id)
	group by T.title_id
	having (count(*) > 1)

select * from #titulos

-- Ventas totales de cada autor
select A.au_id, au_lname, au_fname, sum(qty*price) 'Ventas' into #ventastotales from authors A
		inner join titleauthor TA
			on TA.au_id = A.au_id
		inner join titles T
			on T.title_id = TA.title_id
		inner join sales S
			on T.title_id = S.title_id
		group by A.au_id, au_lname, au_fname


select * from #ventastotales

declare tcur cursor
	for select title_id from #titulos
	for read only

declare @tid varchar(6)
open tcur
fetch next 
	from tcur
	into @tid
declare @id smallint
set @id = 1
while @@fetch_status = 0
begin
	
	-- Ventas totales de cada autor de la publicación actual del cursor
	select A.au_id, A.au_lname, A.au_fname, ventas into #ventasportit from authors A
		inner join titleauthor TA
			on TA.au_id = A.au_id
		inner join titles T
			on T.title_id = TA.title_id
		inner join sales S
			on T.title_id = S.title_id
		inner join #ventastotales V
			on A.au_id = V.au_id
		group by A.au_id, A.au_lname, A.au_fname, T.title_id, ventas
		having (@tid = T.title_id)

	--select * from #ventasportit
	declare @au_id varchar(11), @au_lname varchar(40)
	select @au_id = au_id, @au_lname = au_lname from #ventasportit
		where (ventas = (select max(ventas) from #ventasportit))

	-- Insertar autor nuevo
	insert into authors
	select '999-99-999' + convert(char, @id) 'au_id', au_lname + ' Y OTROS' 'au_lname', au_fname, phone, address, city, state, zip, contract from authors where au_id = @au_id

	-- Insertar TA nuevo
	insert into titleauthor
	select '999-99-999' + convert(char, @id) 'au_id', title_id, au_ord, royaltyper from titleauthor TA
		inner join authors A
			on A.au_id = TA.au_id
		where (title_id = @tid and TA.au_id = @au_id)
	set @id = @id+1

	drop table #ventasportit

	fetch next 
		from tcur
		into @tid
end



close tcur
deallocate tcur