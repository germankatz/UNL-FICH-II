insert into localidad(descripcion, codigo_postal, id_provincia)
select localidad 'descripcion', cp/1000 'codigo_postal', P.id 'id_provincia' From codpost C
	inner join provincia P
		on C.provincia = P.descripcion
	group by localidad, cp, P.id
	having (cp = (select min(cp) from codpost cc where cc.cp/1000 = C.cp/1000))
