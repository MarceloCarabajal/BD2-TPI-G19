USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston
-- Gisela   (BD2-33) TR_Funciones_BloquearCambioHorarioConReservas
-- Propósito: Automatiza el control de integridad comercial. 
-- Impide modificar el horario de una función si ya registra reservas asociadas
CREATE TRIGGER TR_Funciones_BloquearCambioHorarioConReservas
ON FUNCIONES
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- Evaluamos si se intento modificar la columna fecha_hora
    IF UPDATE(fecha_hora)
    BEGIN
        -- Validamos si la funcion modificada ya tiene filas asociadas en RESERVAS
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN deleted d ON i.id_funcion = d.id_funcion
            INNER JOIN RESERVAS r ON i.id_funcion = r.id_funcion
            WHERE i.fecha_hora <> d.fecha_hora -- Evaluamos que el horario haya cambiado efectivamente
              AND r.estado <> 'Cancelada'       -- Solo cuentan las reservas activas
        )
        BEGIN
            RAISERROR('Error: No se puede modificar el horario de la función porque ya existen usuarios con reservas activas para la misma.', 16, 1);
            ROLLBACK TRANSACTION; -- Cancela el UPDATE erroneo y restaura el horario previo
            RETURN;
        END;
    END;
END;
GO

-- Henry
-- Marcelo  (BD2-34)  TR_Pagos_ActualizarEstadoReserva

-- BD2-34: red de seguridad - sincroniza RESERVAS cuando cambia PAGOS
-- (complementa sp_RegistrarPago y sp_CancelarReserva si se inserta/actualiza PAGOS directo)
CREATE TRIGGER TR_Pagos_ActualizarEstadoReserva
ON PAGOS
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE r
    SET r.estado = 'Pagada',
        r.total_pagado = i.total_pagado
    FROM RESERVAS r
        INNER JOIN inserted i ON r.id_reserva = i.id_reserva
    WHERE i.estado_pago = 'Aprobado'
      AND r.estado <> 'Cancelada';

    UPDATE r
    SET r.estado = 'Cancelada',
        r.total_pagado = NULL
    FROM RESERVAS r
        INNER JOIN inserted i ON r.id_reserva = i.id_reserva
    WHERE i.estado_pago = 'Devuelto'
      AND r.estado <> 'Cancelada';
END;
GO

-- Marcelo  (BD2-61)  TR_Pagos_AlEliminarRevertirReserva
-- BD2-61: si se elimina un pago aprobado, la reserva vuelve a Pendiente
CREATE TRIGGER TR_Pagos_AlEliminarRevertirReserva
ON PAGOS
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE r
    SET r.estado = 'Pendiente',
        r.total_pagado = NULL
    FROM RESERVAS r
        INNER JOIN deleted d ON r.id_reserva = d.id_reserva
    WHERE d.estado_pago = 'Aprobado'
      AND r.estado <> 'Cancelada';
END;
GO

-- Pruebas BD2-34 (ejecutar tras scripts 1-4; reserva 3 debe estar Pendiente sin pago)
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva IN (1, 2, 3, 4);
-- GO

-- Caso red de seguridad: INSERT directo en PAGOS (sin sp_RegistrarPago)
-- INSERT INTO PAGOS (id_reserva, id_metodo_pago, total_pagado, estado_pago)
-- VALUES (3, 1, 2800.00, 'Aprobado');
-- GO
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
-- GO

-- Caso idempotencia: sp_RegistrarPago en reserva ya pagada debe fallar por duplicate (SP, no trigger)
-- EXEC sp_RegistrarPago @id_reserva = 3, @id_metodo_pago = 1, @total_pagado = 2800.00;
-- GO

-- Caso Devuelto: alinear reserva si se actualiza PAGOS directo
-- UPDATE PAGOS SET estado_pago = 'Devuelto' WHERE id_reserva = 3 AND estado_pago = 'Aprobado';
-- GO
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
-- GO
-- GO
