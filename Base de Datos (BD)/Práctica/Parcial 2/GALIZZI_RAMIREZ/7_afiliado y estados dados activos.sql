-- Buscar afiliados NO dados de baja
select C.nrodoc into #alta from cuentas C
	inner join persona_fisica P
		on C.nrodoc = P.nro_documento
	group by C.nrodoc
	having (count(C.fecafiba) <> count(C.nrodoc))
	order by C.nrodoc

insert into afiliado(tipo_afiliado, fecha_alta, fecha_baja, observaciones, id_persona_fisica, id_estado_afiliado)
select 'EFECTIVO', A.alta, null, null, P.id, null from #alta AL
	inner join persona_fisica P
		on AL.nrodoc = P.nro_documento
	inner join actor A
		on P.id_actor = A.id

-- Crear los 2 estados de cada afiliado activo

-- EN_PROCESO_ALTA
insert into estado_afiliado(secuencia, estado_afiliado, fecha, observaciones, id_afiliado)
select 1, 'EN_PROCESO_ALTA', fecha_alta, null, id from afiliado where fecha_baja is null

-- ACTIVO
insert into estado_afiliado(secuencia, estado_afiliado, fecha, observaciones, id_afiliado)
select 2, 'ACTIVO', fecha_alta, null, id from afiliado where fecha_baja is null

-- ESTADO ACTUAL
update afiliado
	set id_estado_afiliado = (select estado_afiliado.id from estado_afiliado where (afiliado.id = estado_afiliado.id_afiliado and estado_afiliado.secuencia = 2))
	where afiliado.fecha_baja is null

drop table #alta