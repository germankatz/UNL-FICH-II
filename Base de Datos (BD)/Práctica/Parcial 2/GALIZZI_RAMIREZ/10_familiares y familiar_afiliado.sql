-- Ids de personas fisicas afiliadas
select P.id into #id_pf_af from afiliado A
	inner join persona_fisica P
		on A.id_persona_fisica = P.id

-- Ids de personas fisicas no afiliadas (familiares)
select id into #id_pf_fam from persona_fisica
	where (id not in (select id from #id_pf_af))

-- Datos del familiar
select nrodoc 'nro_documento_afiliado', nrodocfam 'nro_documento_familiar', fecnac 'fecha_nacimiento_familiar', parentesco 'vinculo', P.id 'id_persona_fisica_persona' into #fam from datosfam D
	inner join persona_fisica P
		on D.nrodocfam = P.nro_documento
	inner join #id_pf_fam F
		on P.id = F.id
	order by nro_documento_afiliado, fecha_nacimiento_familiar

begin transaction

declare @doc int
declare @doc_anterior int
set @doc_anterior = null
declare @doc_familiar int
declare @fn datetime
declare @fa datetime
declare @fb datetime
declare @item smallint
declare @id_afi int
declare @vinculo varchar(30)

declare @id_pf_persona int
declare @id_pf_pariente int
declare @id_fam int

-- Iterar sobre #fam para poder obtener el item en orden cronológico respecto a la fecha de alta
while ((select count(*) from #fam) > 0)
begin
    select top 1	@doc = nro_documento_afiliado,
					@doc_familiar = nro_documento_familiar,
					@fn = fecha_nacimiento_familiar,
					@id_pf_persona = id_persona_fisica_persona,
					@vinculo = case when vinculo in ('FAMILIAR_TUTOR','PADRASTRO','ABUELO','CONCUBINO','NIETO','PADRE','A_CARGO','HIJASTRO','HIJO','CONYUGE') then vinculo
					else 'NO_INFORMADO' end
		from #fam

	if (@doc = @doc_anterior)
		set @item = @item + 1
	else
		set @item = 1

	select @id_pf_pariente = id from persona_fisica where nro_documento = @doc

	select @fa = fecha_alta, @fb = fecha_baja, @id_afi = id from afiliado where id_persona_fisica = @id_pf_pariente

	insert into familiares(item, fecha_desde, fecha_hasta, vinculo, observaciones, id_persona_fisica_persona, id_persona_fisica_pariente)
		values(@item,
				case when @vinculo in ('HIJO', 'HIJASTRO', 'NIETO') then @fn
				else @fa end,
				null,
				@vinculo,
				null,
				@id_pf_persona,
				@id_pf_pariente)

	select @id_fam = id from familiares where (item = @item and id_persona_fisica_persona = @id_pf_persona)

	insert into familiar_afiliado(item, fecha_alta, fecha_baja, observaciones, id_afiliado, id_familiares)
							values(@item, @fa, @fb, null, @id_afi, @id_fam)

	if (@@error <> 0)
	begin
		select @item, @id_afi, @id_fam, @doc, @doc_anterior, @doc_familiar
		rollback transaction
		return
	end

    delete #fam where (nro_documento_familiar = @doc_familiar)
	set @doc_anterior = @doc
end

commit transaction

drop table #fam
drop table #id_pf_af
drop table #id_pf_fam