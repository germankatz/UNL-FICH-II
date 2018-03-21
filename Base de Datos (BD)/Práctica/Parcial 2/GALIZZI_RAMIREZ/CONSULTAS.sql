-- 1. Determinar el afiliado (codigo) que tiene mayor número de cuentas de detalle y que no estén dadas de baja.
select top 1 id_afiliado from cuentas_afiliado
	group by id_afiliado, fecha_baja
	having fecha_baja is null
	order by (count(*)) desc


-- 2. Listado de afiliados que tienen como familiar a otro afiliado (No nos funciona)
select * from familiares F
	inner join persona_fisica P
		on F.id_persona_fisica_persona = P.id
	inner join afiliado A
		on P.id = A.id_persona_fisica



-- 3. Dada una localidad ...
create procedure sp_afiliados_localidad
 (@id int)
as
select P.tipo_documento, P.nro_documento, P.apellido, P.nombre, E.estado_civil, count(CA.id_afiliado) 'Nro de cuentas', count(id_familiares) 'Nro familiares asociados'  from direccion D
		inner join direccion_actor DA
			on D.id = DA.id_direccion
		inner join actor A
			on DA.id_actor = A.id
		inner join persona_fisica P
			on A.id = P.id_actor
		inner join afiliado AF
			on P.id = AF.id_persona_fisica
		inner join estado_civil_persona E
			on P.id_estado_civil_persona = E.id
		inner join cuentas_afiliado CA
			on AF.id = CA.id_afiliado
		inner join familiar_afiliado FA
			on AF.id = FA.id_afiliado
		group by P.tipo_documento, P.nro_documento, P.apellido, P.nombre, E.estado_civil, D.id_localidad, AF.id
		having (D.id_localidad = @id)-- 121629 santa fe
return

-- Ejemplo: Afiliados de santa fe
exec sp_afiliados_localidad @id = 121629