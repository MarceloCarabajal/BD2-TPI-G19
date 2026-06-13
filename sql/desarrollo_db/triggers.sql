USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston
-- Gisela   (BD2-33)  TR_DetallesReservas_EvitarButacaDuplicada
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
