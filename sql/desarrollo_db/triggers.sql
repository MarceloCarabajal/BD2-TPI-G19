USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gisela   (BD2-33) TR_Funciones_BloquearCambioHorarioConReservas
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

-- Gisela   (BD2-62)  TR_DetallesReservas_EvitarButacaDuplicada
-- Proposito: Impide que dos reservas distintas asignen la misma
-- butaca para la misma funcion durante un INSERT.

CREATE TRIGGER TR_DetallesReservas_EvitarButacaDuplicada
ON DETALLES_RESERVAS
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN RESERVAS r_nueva ON i.id_reserva = r_nueva.id_reserva
        INNER JOIN DETALLES_RESERVAS dr ON dr.id_butaca = i.id_butaca
        INNER JOIN RESERVAS r_vieja ON dr.id_reserva = r_vieja.id_reserva
        WHERE r_nueva.id_funcion = r_vieja.id_funcion
          AND r_nueva.id_reserva <> r_vieja.id_reserva
          AND r_vieja.estado <> 'Cancelada'
    )
    BEGIN
        RAISERROR('Error: La butaca seleccionada ya se encuentra reservada para esta función.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

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

-- ============================================================
-- PRUEBAS (épica BD2-14)
-- ============================================================
-- BD2-42 (Marcelo) — Ejecutar en orden tras scripts 1-6 sobre BD limpia
-- Precondición (insercion_datos.sql): reserva 3 Pendiente sin fila en PAGOS

-- Verificación estado inicial recomendado
-- -- Tabla FUNCIONES
-- SELECT id_funcion, id_pelicula, id_sala, precio_base FROM FUNCIONES ORDER BY id_funcion ASC;
-- GO
-- -- Tabla RESERVAS
--  SELECT id_reserva, id_usuario, id_funcion, estado, total_pagado FROM RESERVAS ORDER BY id_reserva ASC;
--  GO
-- -- Tabla DETALLES_RESERVAS
--  SELECT id_detalle, id_reserva, id_butaca, precio_unitario FROM DETALLES_RESERVAS ORDER BY id_detalle ASC;
--  GO
-- -- Tabla PAGOS
--  SELECT id_pago, id_reserva, estado_pago, total_pagado, fecha_pago FROM PAGOS ORDER BY id_pago ASC;
--  GO

-- ------------------------------------------------------------
-- TR_Funciones_BloquearCambioHorarioConReservas
-- ------------------------------------------------------------
-- -- BD2-33 (Gisela) - Trigger
-- -- Caso exitoso: función 4 no tiene reservas activas, por lo tanto permite modificar fecha_hora
-- UPDATE FUNCIONES 
-- SET fecha_hora = DATEADD(hour, 1, fecha_hora) WHERE id_funcion = 4;
-- GO
-- -- Caso de error: función 1 tiene reservas activas (1 y 2), por lo tanto el trigger bloquea el UPDATE y hace ROLLBACK
-- UPDATE FUNCIONES 
-- SET fecha_hora = DATEADD(hour, 1, fecha_hora) WHERE id_funcion = 1;
-- GO
-- -- BD2-43 (Henry) - Transacciones / Rollback
-- -- Verificación del estado de la tabla FUNCIONES y RESERVAS
-- SELECT id_funcion, fecha_hora, id_pelicula, id_sala, precio_base FROM FUNCIONES ORDER BY id_funcion ASC;
-- GO
-- SELECT id_reserva, id_usuario, id_funcion, estado, total_pagado FROM RESERVAS ORDER BY id_reserva ASC;
-- GO

-- ------------------------------------------------------------
-- TR_DetallesReservas_EvitarButacaDuplicada
-- ------------------------------------------------------------
-- -- BD2-62 (Gisela) - Trigger
-- -- Caso exitoso: se agrega una butaca no ocupada para la reserva 3
-- EXEC sp_CrearReservaConDetalle @id_usuario = 3, @id_funcion = 3, @id_butaca = 1;
-- GO
-- -- Caso de error: butaca 1 ya está reservada para la función 1 en otra reserva activa
-- -- Reserva 1 usa butaca 1 para función 1, por eso esta inserción debe fallar y hacer ROLLBACK
-- EXEC sp_CrearReservaConDetalle @id_usuario = 2, @id_funcion = 1, @id_butaca = 1;
-- GO
-- -- BD2-43 (Henry) - Transacciones / Rollback
-- -- Verificación del estado de la tabla RESERVAS y DETALLES_RESERVAS
-- SELECT id_reserva, id_usuario, id_funcion, estado FROM RESERVAS;
-- GO
-- SELECT id_detalle, id_reserva, id_butaca, precio_unitario FROM DETALLES_RESERVAS ORDER BY id_detalle ASC;
-- GO

-- ------------------------------------------------------------
-- TR_Pagos_ActualizarEstadoReserva - INSERT
-- ------------------------------------------------------------
-- -- BD2-34 (Marcelo) — INSERT
-- -- Caso exitoso: se inserta un pago aprobado para la reserva 3 y el trigger actualiza RESERVAS a Pagada
-- INSERT INTO PAGOS (id_reserva, id_metodo_pago, total_pagado, estado_pago)
-- VALUES (3, 1, 2800.00, 'Aprobado');
-- GO
-- Caso de error: estado_pago inválido, falla por CHECK y no debe insertar ni actualizar RESERVAS
-- INSERT INTO PAGOS (id_reserva, id_metodo_pago, total_pagado, estado_pago)
-- VALUES (3, 1, 2800.00, 'Procesando');
-- GO
-- -- Verificación del estado de las tablas PAGOS y RESERVAS
-- SELECT id_pago, id_reserva, estado_pago, total_pagado FROM PAGOS WHERE id_reserva = 3;
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
-- GO

-- ------------------------------------------------------------
-- TR_Pagos_AlEliminarRevertirReserva
-- ------------------------------------------------------------
-- -- BD2-61 (Marcelo) - Trigger
-- -- Caso exitoso: al eliminar un pago aprobado, la reserva vuelve a Pendiente (ejecutar tras INSERT anterior)
-- DELETE FROM PAGOS WHERE id_reserva = 3;
-- GO
-- Caso de error: se intenta eliminar un pago inexistente, no afecta registros
-- DELETE FROM PAGOS WHERE id_reserva = 999;
-- GO
-- -- Verificación del estado de las tablas PAGOS y RESERVAS
-- SELECT id_pago, id_reserva, estado_pago, total_pagado FROM PAGOS WHERE id_reserva IN (3, 999);
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
-- GO

-- ------------------------------------------------------------
-- TR_Pagos_ActualizarEstadoReserva - UPDATE
-- ------------------------------------------------------------
-- -- BD2-34 (Marcelo) — UPDATE
-- -- Caso exitoso: al cambiar un pago aprobado a Devuelto, la reserva pasa a Cancelada
-- UPDATE PAGOS SET estado_pago = 'Devuelto' WHERE id_reserva = 4 AND estado_pago = 'Aprobado';
-- GO
-- Caso de error: estado_pago inválido, falla por CHECK y no debe modificar RESERVAS
-- UPDATE PAGOS SET estado_pago = 'Procesando' WHERE id_reserva = 4;
-- GO
-- Verificación del estado de las tablas PAGOS y RESERVAS
-- SELECT id_pago, id_reserva, estado_pago, total_pagado FROM PAGOS WHERE id_reserva = 4;
-- SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 4;
-- GO