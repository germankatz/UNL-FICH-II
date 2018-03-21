
-- Personas que tienen al menos una fecha de alta no nula y es la mayor
select nrodoc, max(fecafiaa) 'alta' into #altamin_t from cuentas
	group by nrodoc
	having (max(fecafiaa) is not null)

select A.nrodoc, A.alta, tipdoc, sexo, nyap, fechanac into #altamin from cuentas C
	inner join #altamin_t A
		on A.nrodoc = C.nrodoc
	where (C.nrocta = (select top 1 CC.nrocta from cuentas CC where C.nrodoc = CC.nrodoc))

-- Personas cuya nacionalidad en la tabla cuentas coincide con el nombre del país
select nrodoc, P.id into #docpais from cuentas C
	inner join pais P
		on C.nacionalidad = P.descripcion
	group by nrodoc, P.id
	having (nrodoc <> 92810842) -- Tiene más de una nacionalidad

alter table actor add nrodoc int

GO

insert into actor(alta, baja, telefono_principal, movil_principal, email_principal, observaciones, id_pais, nrodoc)
select A.alta, null, null, null, null, null, D.id, A.nrodoc from #altamin A
	inner join #docpais D
		on A.nrodoc = D.nrodoc

insert into persona_fisica(nro_documento, tipo_documento, sexo, apellido, nombre, fecha_nacimiento, fecha_fallecimiento, escolaridad, tiene_discapacidad, id_actor, id_estado_civil_persona)
select A.nrodoc 'nro_documento', 
			case A.tipdoc	when 1 then 'LE'
							when 2 then 'LC'
							when 3 then 'DNI'
							else 'NO_INFORMADO'
			end 'tipo_documento',
			case A.sexo when 'MASCULINO' then 'MASCULINO'
						when 'FEMENINO' then 'FEMENINO'
						else 'NO_INFORMADO'
			end 'sexo',
			rtrim(ltrim(substring(nyap, 1, (CHARINDEX(' ',nyap + ' ')-1)))) 'apellido',
			rtrim(ltrim(substring(nyap, (CHARINDEX(' ',nyap + ' ')+1), len(nyap)))) 'nombre',
			A.fechanac,
			null 'fecha_fallecimiento',
			'NO_INFORMADO' 'escolaridad_actual',
			0 'tiene_discapacidad',
			AC.id 'id_actor',
			null 'id_estado_civil_persona'
		from #altamin A
	inner join #docpais D
		on A.nrodoc = D.nrodoc
	inner join actor AC
		on D.nrodoc = AC.nrodoc
	where (A.fechanac is not null)
	order by nro_documento

alter table actor drop column nrodoc

drop table #docpais
drop table #altamin
drop table #altamin_t