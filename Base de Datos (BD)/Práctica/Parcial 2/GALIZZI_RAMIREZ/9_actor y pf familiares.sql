alter table actor add nrodoc int
	constraint DF_NRODOC default null

insert into actor(alta, baja, telefono_principal, movil_principal, email_principal, observaciones, id_pais, nrodoc)
select A.alta, null, null, null, null, null,  A.id_pais, F.nrodocfam from datosfam F
	inner join persona_fisica P
		on F.nrodoc = P.nro_documento
	inner join actor A
		on P.id_actor = A.id
	where (nrodocfam is not null -- Numero de doc no nulo
			and fecnac is not null -- Fecha de nacimiento no nula
			and nrodocfam <> 0 -- Numero de documento distinto de 0
			and nrodocfam not in  -- Numero de documento no repetido
					(select nrodocfam from datosfam 
						group by nrodocfam 
						having (count(nrodocfam) > 1 and nrodocfam <> 0))
			and nrodocfam not in -- Familiares que son afiliados y entonces ya fueron cargados
					(select nrodocfam from datosfam D
						inner join persona_fisica PP
							on D.nrodocfam = PP.nro_documento
						group by nrodocfam
						having (count(nrodocfam) = 1)))

insert into persona_fisica(nro_documento, tipo_documento, sexo, apellido, nombre, fecha_nacimiento, fecha_fallecimiento, escolaridad, tiene_discapacidad, id_actor)
select F.nrodocfam, 'NO_INFORMADO' 'tipo_documento', 
										case F.sexo when 'MASCULINO' then 'MASCULINO'
											when 'FEMENINO' then 'FEMENINO'
											else 'NO_INFORMADO'
										end 'sexo',
										rtrim(ltrim(substring(nombre_fam, 1, (CHARINDEX(' ',nombre_fam + ' ')-1)))) 'apellido',
										rtrim(ltrim(substring(nombre_fam, (CHARINDEX(' ',nombre_fam + ' ')+1), len(nombre_fam)))) 'nombre',
										F.fecnac,
										null 'fecha_fallecimiento',
										'NO_INFORMADO' 'escolaridad_actual',
										case when F.discapacitado is null then 0
											else F.discapacitado
										end,
										A.id
	from datosfam F
	inner join actor A
		on F.nrodocfam = A.nrodoc

alter table actor drop constraint DF_NRODOC
alter table actor drop column nrodoc