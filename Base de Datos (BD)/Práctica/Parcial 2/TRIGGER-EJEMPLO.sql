-- Ejemplo de trigger de control de transición de estado
drop table producto

create table producto(
id int identity(0,1) not null,
codigo int not null,
nombre varchar(30) not null,
estado varchar(30) not null,
constraint pk_producto primary key (id),
constraint uk_producto unique (codigo),
constraint chk_producto_estado check (estado in ('EN_EVALUACION','EN_VENTA','EN_COMPRA','EN_COMPRA_VENTA','ANULADO'))
)

-- Diagrama de transición
-- EN_EVALUACION --> EN_VENTA --> ANULADO
--               --> EN_COMPRA --> ANULADO
--               --> EN_COMPRA_VENTA --> ANULADO

--DROP TRIGGER ti_producto
CREATE TRIGGER [dbo].[ti_producto] ON [dbo].[producto]
FOR INSERT
AS
BEGIN

   DECLARE @estado varchar(30), @msj varchar(120)
   
   SELECT @estado = estado FROM inserted
   IF @estado in ('EN_VENTA','EN_COMPRA','ANULADO')
   BEGIN
      SELECT @msj = 'Estado inicial inválido: ' + @estado +' (el estado inicial debe ser ''EN_EVALUACIÓN'')'
      RAISERROR (@msj, 10,1)
      ROLLBACK TRANSACTION
   END
END

CREATE TRIGGER [dbo].[tu_producto] ON [dbo].[producto]
FOR UPDATE
AS
BEGIN

   DECLARE @estado varchar(30), @estado_anterior varchar(30), @msj varchar(120)
   
   SELECT @estado = estado FROM inserted
   select @estado_anterior = estado FROM deleted
   IF ((@estado in ('EN_VENTA','EN_COMPRA','EN_COMPRA_VENTA') AND @estado_anterior <> 'EN_EVALUACION')) OR
      ((@estado = 'ANULADO' AND @estado_anterior NOT IN ('EN_VENTA','EN_COMPRA','EN_COMPRA_VENTA')))
   BEGIN
      SELECT @msj = 'Transición de estados no permitida: ' + @estado_anterior  +' >> ' + @estado
      RAISERROR (@msj, 10,1)
      ROLLBACK TRANSACTION
   END
END


-- Este insert no puede hacerse
INSERT INTO producto values (1, 'Pelota inflable', 'EN_COMPRA')
-- Este insert si
INSERT INTO producto values (1, 'Pelota inflable', 'EN_EVALUACION')
   
select * from producto
-- Este update no puede hacerse
update producto set estado = 'ANULADO' where codigo = 1

-- Este update si
update producto set estado = 'EN_COMPRA' where codigo = 1



