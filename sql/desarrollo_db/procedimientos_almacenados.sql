USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston   (BD2-29)  sp_InsertarPelicula
-- Gisela   (BD2-30)  sp_CrearFuncion
-- Henry    (BD2-31)  sp_ReservasPorUsuario / sp_ButacasOcupadasPorFuncion
-- Henry    (BD2-35)  sp_CrearReservaConDetalle  (BEGIN TRAN)

-- Marcelo  (BD2-32)  
CREATE PROCEDURE sp_RegistrarPago
    @id_reserva BIGINT,
    @id_metodo_pago BIGINT,
    @total_pagado MONEY
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM RESERVAS WHERE id_reserva = @id_reserva)
    BEGIN
        RAISERROR('La reserva no existe.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1 FROM RESERVAS
        WHERE id_reserva = @id_reserva AND estado = 'Cancelada'
    )
    BEGIN
        RAISERROR('No se puede registrar pago de una reserva cancelada.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM PAGOS WHERE id_reserva = @id_reserva)
    BEGIN
        RAISERROR('La reserva ya tiene un pago registrado.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM METODOS_PAGOS WHERE id_metodo_pago = @id_metodo_pago)
    BEGIN
        RAISERROR('El metodo de pago no existe.', 16, 1);
        RETURN;
    END
    IF @total_pagado <= 0
    BEGIN
        RAISERROR('El total pagado debe ser mayor a cero.', 16, 1);
        RETURN;
    END
    INSERT INTO PAGOS (id_reserva, id_metodo_pago, total_pagado, estado_pago)
    VALUES (@id_reserva, @id_metodo_pago, @total_pagado, 'Aprobado');
    UPDATE RESERVAS
    SET estado = 'Pagada', total_pagado = @total_pagado
    WHERE id_reserva = @id_reserva;
END;
GO

CREATE PROCEDURE sp_CancelarReserva
    @id_reserva BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM RESERVAS WHERE id_reserva = @id_reserva)
    BEGIN
        RAISERROR('La reserva no existe.', 16, 1);
        RETURN;
    END
    UPDATE RESERVAS
    SET estado = 'Cancelada', total_pagado = NULL
    WHERE id_reserva = @id_reserva;
    UPDATE PAGOS
    SET estado_pago = 'Devuelto'
    WHERE id_reserva = @id_reserva AND estado_pago = 'Aprobado';
END;
GO
-- Pruebas BD2-32
 EXEC sp_RegistrarPago @id_reserva = 3, @id_metodo_pago = 1, @total_pagado = 2800.00;
GO
-- Marcelo  (BD2-36)  TRY/CATCH + TRAN en sp_RegistrarPago