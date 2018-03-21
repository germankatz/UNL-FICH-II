create trigger tr_estado_afiliado
on estado_afiliado
for insert
as
	declare @id_af int
	declare @ea_actual varchar(30)
	declare @ea_anterior varchar(30)
	select @id_af = id_afiliado, @ea_actual = estado_afiliado from inserted
	
	select @ea_anterior = estado_afiliado from estado_afiliado
		where (id_afiliado = @id_af and secuencia = (select max(secuencia) from estado_afiliado EA
														where (EA.id_afiliado = @id_af)))
	
	if (@ea_anterior = 'EN_PROCESO_ALTA')
	begin
		if (@ea_actual <> 'ACTIVO')
			rollback transaction
	end

	if (@ea_anterior = 'ACTIVO')
	begin
		if (@ea_actual <> 'QUIEBRA' and @ea_actual <> 'INHABILITADO' and @ea_actual <> 'BAJA')
			rollback transaction
	end

	if (@ea_anterior = 'QUIEBRA' or @ea_anterior = 'INHABILITADO')
	begin
		if (@ea_actual <> 'BAJA' and @ea_actual <> 'ACTIVO')
			rollback transaction
	end

	if (@ea_anterior = 'BAJA')
	begin
		if (@ea_actual <> 'ACTIVO')
			rollback transaction
	end
	
return

