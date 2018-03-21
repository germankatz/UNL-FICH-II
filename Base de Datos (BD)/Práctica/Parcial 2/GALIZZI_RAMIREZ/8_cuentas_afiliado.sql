
-- Guardar en #fechas las cuentas de cada afiliado
select P.nro_documento, C.fecafiaa, C.fecafiba, C.nrocta into #fechas from afiliado A
	inner join persona_fisica P
		on A.id_persona_fisica = P.id
	inner join cuentas C
		on P.nro_documento = C.nrodoc
	where (C.fecafiaa is not null) -- NO se puede migrar: fecha de alta nula
	order by P.nro_documento, C.fecafiaa
	

declare @doc int
declare @doc_anterior int
set @doc_anterior = null
declare @fa datetime
declare @fb datetime
declare @item smallint
declare @cta int
declare @id_afi int

-- Iterar sobre #fechas para poder obtener el item en orden cronológico respecto a la fecha de alta
while ((select count(*) from #fechas) > 0)
begin
    select top 1 @doc = nro_documento, @fa = fecafiaa, @fb = fecafiba, @cta = nrocta from #fechas
	if (@doc = @doc_anterior)
		set @item = @item + 1
	else
		set @item = 1

	select @id_afi = A.id from afiliado A
		inner join persona_fisica P
			on A.id_persona_fisica = P.id
		where (P.nro_documento = @doc)

	insert into cuentas_afiliado(item, fecha_alta, fecha_baja, codigo_sistema_anterior, id_afiliado)
							values(@item, @fa, @fb, @cta, @id_afi)

    delete #fechas where nrocta = @cta
	set @doc_anterior = @doc
end

drop table #fechas