-- Personas no migradas debido a que todas sus fechas de alta eran nulas
select nrodoc, min(fecafiaa) 'alta' from cuentas
	group by nrodoc
	having (min(fecafiaa) is null)

-- Personas no migradas debido a que su nacionalidad no coincide con el nombre de ningún país
select nrodoc from cuentas
	where (nrodoc not in (select nrodoc from cuentas C
							inner join pais P
								on C.nacionalidad = P.descripcion))
	group by nrodoc

-- Cuentas de afiliados que no se puede migrar: fecha de alta nula
select P.nro_documento, C.fecafiaa, C.fecafiba, C.nrocta from afiliado A
	inner join persona_fisica P
		on A.id_persona_fisica = P.id
	inner join cuentas C
		on P.nro_documento = C.nrodoc
	where (C.fecafiaa is null)

-- Familiares no migrados porque su nro de documento es nulo, cero, o está repetido. Ya que en estos casos no se puede crear su persona fisica
select * from datosfam where (nrodocfam is null or nrodocfam = 0 
								or nrodocfam in
									(select nrodocfam from datosfam 
										group by nrodocfam 
										having (count(nrodocfam) > 1 and nrodocfam <> 0)))


-- Familiares no migrados porque su fecha de nacimiento es nula.
select * from datosfam where (fecnac is null)