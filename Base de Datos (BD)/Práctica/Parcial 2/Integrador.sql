-- Estructura para tabla de auditoria:

CREATE PROCEDURE ObtenerID (@tabla varchar(40), @idn integer OUTPUT) As
BEGIN
	Select @idn = Ultimo From Setup Where Tabla = @tabla
END

CREATE TRIGGER InsertarBadSeller ON authors FOR delete As
BEGIN
	Declare @au_idViejo varchar(12),
		@au_lname varchar(40), @au_fname varchar(20),
		@phone char(12), @address varchar(40),
		@city varchar(20), @state char(2),
		@zip char(5)
	Declare curDeleted scroll CURSOR FOR
		Select au_id, au_lname, au_fname, phone, address, city, state, zip from deleted
	for read only
	Open curDeleted
	Fetch last from curDeleted into
		@au_idViejo, @au_lname, @au_fname, @phone, @address, @city, @state, @zip
	Declare @nuevaid integer
	Exec ObtenerID 'AutoresBadSeller', @nuevaid OUTPUT
	Insert into AutoresBadSeller values (@nuevaid, @au_idViejo, @au_lname, @au_fname, @phone, @address, @city, @state, @zip)
	Close curDeleted
	Deallocate curDeleted
END

CREATE TABLE Setup (
	Tabla varchar(40) NOT NULL,
	Ultimo Integer)

CREATE TABLE AutoresBadSeller (
	IDAutor SmallInt NOT NULL,
	au_idViejo varchar(12),
	au_lname varchar(40) NOT NULL,
	au_fname varchar(20) NOT NULL,
	phone char(12) NULL,
	address varchar(40) NULL,
	city varchar(20) NULL,
	state char(2) NULL,
	zip char(5) NULL)

CREATE TRIGGER AumentarID ON AutoresBadSeller FOR insert As
BEGIN
	Update Setup Set Ultimo = Ultimo + 1 Where Tabla = 'AutoresBadSeller'
END

INSERT Setup VALUES ('AutoresBadSeller', 1)

-- Fin estructura de auditoria.

-- Procedimientos a llamar desde principal:

CREATE PROCEDURE EliminarAutor (@autor_id id) As
BEGIN
	Select title_id into #TitleTemp from titleauthor TA where TA.au_id = @autor_id
	Delete titleauthor Where au_id = @autor_id
	Delete sales Where title_id in (Select title_id from #TitleTemp)
	Delete authors Where au_id = @autor_id
	Delete titles Where title_id in (Select title_id from #TitleTemp)
	Drop table #TitleTemp
END

-- Fin de procedimientos de principal.

-- Principal:

----------------------------------------------------------------------------------
----------------------------------- INICIO BATCH ---------------------------------
----------------------------------------------------------------------------------

BEGIN TRANSACTION

	Declare @auid id, @titid tid, @v smallint,
		@auactual id,
		@eliminar smallint

	Declare curAutores cursor for
		Select TA.au_id, TA.title_id, ventas from titleauthor TA INNER JOIN
		(Select SA.title_id, SUM(qty) ventas from sales SA where ord_date BETWEEN '01/01/1993' AND '31/12/1994' group by title_id) S
		ON S.title_id = TA.title_id Order By au_id

	Open curAutores

	Fetch Next from curAutores into @auid, @titid, @v

	While @@fetch_status = 0
	Begin

		Set @eliminar = 1
	
		If ((Select count(title_id) from titleauthor where au_id = @auid) > 0
		And (Select sum(qty) from sales S inner join titleauthor TA on S.title_id = TA.title_id where au_id = @auid) > 0
		And (Select count(T1.au_id) from titleauthor T1, titleauthor T2 where T1.title_id = T2.title_id and T1.au_id != T2.au_id and T2.au_id = @auid) = 0)
		Begin

			Set @auactual = @auid

			While @auid = @auactual And @@fetch_status = 0
			Begin

				If @v >= 25
					Set @eliminar = 0
				Fetch Next from curAutores into @auid, @titid, @v
			End

			If @eliminar = 1
				Exec EliminarAutor @auactual

		End
		Else
			Fetch Next from curAutores into @auid, @titid, @v

	End

	Close curAutores
	Deallocate curAutores

COMMIT TRANSACTION

----------------------------------------------------------------------------------
----------------------------------- FIN BATCH ------------------------------------
----------------------------------------------------------------------------------