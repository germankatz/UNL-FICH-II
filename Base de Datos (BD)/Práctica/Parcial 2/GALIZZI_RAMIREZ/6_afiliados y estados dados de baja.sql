-- Buscar afiliados dados de baja
select C.nrodoc, max(C.fecafiba) 'fecha_baja' into #baja from cuentas C
	inner join persona_fisica P
		on C.nrodoc = P.nro_documento
	group by nrodoc
	having (count(C.fecafiba) = count(C.nrodoc))
	order by C.nrodoc

-- Insertar afiliados dados de baja
insert into afiliado(tipo_afiliado, fecha_alta, fecha_baja, observaciones, id_persona_fisica, id_estado_afiliado)
select 'EFECTIVO', A.alta, B.fecha_baja, null, P.id, null from #baja B
	inner join persona_fisica P
		on B.nrodoc = P.nro_documento
	inner join actor A
		on P.id_actor = A.id

-- Crear los 3 estados de cada afiliado dado de baja
-- EN_PROCESO_ALTA
insert into estado_afiliado(secuencia, estado_afiliado, fecha, observaciones, id_afiliado)
select 1, 'EN_PROCESO_ALTA', fecha_alta, null, id from afiliado

-- ACTIVO
insert into estado_afiliado(secuencia, estado_afiliado, fecha, observaciones, id_afiliado)
select 2, 'ACTIVO', fecha_alta, null, id from afiliado

-- BAJA
insert into estado_afiliado(secuencia, estado_afiliado, fecha, observaciones, id_afiliado)
select 3, 'BAJA', fecha_baja, null, id from afiliado

-- Referenciar el ESTADO ACTUAL de cada afiliado dado de baja
update afiliado
	set id_estado_afiliado = (select estado_afiliado.id from estado_afiliado where (afiliado.id = estado_afiliado.id_afiliado and estado_afiliado.secuencia = 3))
	where afiliado.fecha_baja is not null

drop table #baja
