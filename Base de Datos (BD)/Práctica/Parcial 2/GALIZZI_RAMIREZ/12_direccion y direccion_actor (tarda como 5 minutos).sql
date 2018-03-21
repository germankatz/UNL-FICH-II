begin transaction

declare tcur cursor
	for select id from cuentas_afiliado

declare @cid int
declare @ident int
open tcur
fetch next 
	from tcur
	into @cid

while @@fetch_status = 0
begin

	insert into direccion(numero_portal, letra_domicilio, nombre_calle_sin_nomenclar, piso, departamento, manzana, escalera, monoblock, torre, vivienda, edificio, sector, observaciones, id_localidad, id_tipo_domicilio, id_pais)
	select null, null, domicilio, null, null, null, null, null, null, null, null, null, null, L.id, 2, A.id_pais from cuentas_afiliado CA
		inner join cuentas C
			on CA.codigo_sistema_anterior = C.nrocta
		inner join localidad L
			on C.cp/1000 = L.codigo_postal
		inner join afiliado AF
			on CA.id_afiliado = AF.id
		inner join persona_fisica P
			on AF.id_persona_fisica = P.id
		inner join actor A
			on P.id_actor = A.id
		where CA.id = @cid

	if (@@error <> 0)
	begin
		rollback transaction
		return
	end

	set @ident = SCOPE_IDENTITY()
	--SCOPE_IDENTITY
	insert into direccion_actor(item, id_direccion, id_actor)
	select CA.item, @ident, A.id from cuentas_afiliado CA
		inner join afiliado AF
			on CA.id_afiliado = AF.id
		inner join persona_fisica P
			on AF.id_persona_fisica = P.id
		inner join actor A
			on P.id_actor = A.id
		where CA.id = @cid

	if (@@error <> 0)
	begin
		rollback transaction
		return
	end

	fetch next 
		from tcur
		into @cid
end

close tcur
deallocate tcur

commit transaction