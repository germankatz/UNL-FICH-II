-- Estados civiles de afiliados
insert into estado_civil_persona(item, fecha_desde, fecha_hasta, estado_civil, id_persona_fisica)
select CA.item, CA.fecha_alta, CA.fecha_baja, 
					case when estacivil in ('SOLTERO', 'CASADO', 'UNIDO_DE_HECHO', 'SEPARADO', 'DIVORCIADO', 'VIUDO', 'FALLECIDO') then estacivil
					else 'NO_INFORMADO' end,
					P.id
	from cuentas_afiliado CA
		inner join afiliado A
			on CA.id_afiliado = A.id
		inner join persona_fisica P
			on A.id_persona_fisica = P.id
		inner join cuentas C
			on P.nro_documento = C.nrodoc
		where (CA.codigo_sistema_anterior = C.nrocta)

-- Estados civiles de familiares
insert into estado_civil_persona(item, fecha_desde, fecha_hasta, estado_civil, id_persona_fisica)
select 1, A.alta, A.baja, 'NO_INFORMADO', P.id from familiares F
	inner join persona_fisica P
		on F.id_persona_fisica_persona = P.id
	inner join actor A
		on P.id_actor = A.id

-- Estados actuales
update persona_fisica
	set id_estado_civil_persona = (select estado_civil_persona.id from estado_civil_persona
										where (persona_fisica.id = estado_civil_persona.id_persona_fisica and
												estado_civil_persona.item = (select max(item) from estado_civil_persona where persona_fisica.id = estado_civil_persona.id_persona_fisica)))