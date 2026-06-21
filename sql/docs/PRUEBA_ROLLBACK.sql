
-- BD2-37 — Prueba de manejo de errores con sp_RegistrarPago
-- Requisitos: scripts 1→6 ejecutados (insercion_datos + procedimientos + triggers).
-- Usa reserva 3: estado inicial Pendiente, sin pago (ver insercion_datos.sql).

USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

PRINT '=== PARTE 1: ESTADO INICIAL (reserva 3) ===';
GO

SELECT id_reserva, estado, total_pagado
FROM RESERVAS
WHERE id_reserva = 3;

SELECT id_pago, id_reserva, total_pagado, estado_pago
FROM PAGOS
WHERE id_reserva = 3;
GO

PRINT '=== PARTE 2: PRIMER PAGO (debe ejecutarse correctamente) ===';
GO

EXEC sp_RegistrarPago
    @id_reserva = 3,
    @id_metodo_pago = 1,
    @total_pagado = 2800.00;
GO

PRINT '=== VERIFICACIÓN POST-PRIMER PAGO ===';
GO

SELECT id_pago, id_reserva, total_pagado, estado_pago
FROM PAGOS
WHERE id_reserva = 3;

SELECT id_reserva, estado, total_pagado
FROM RESERVAS
WHERE id_reserva = 3;
GO

PRINT '=== PARTE 3: INTENTO DE PAGO DUPLICADO ===';
PRINT 'Nota: el SP valida ANTES de BEGIN TRANSACTION. Si ya existe pago,';
PRINT '      hace RAISERROR + RETURN sin abrir transacción (no hay ROLLBACK aquí).';
GO

BEGIN TRY
    EXEC sp_RegistrarPago
        @id_reserva = 3,
        @id_metodo_pago = 1,
        @total_pagado = 2800.00;
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    PRINT 'Error capturado (esperado): ' + @ErrorMessage;
    RAISERROR(@ErrorMessage, 16, 1);
END CATCH;
GO

PRINT '=== VERIFICACIÓN DE INTEGRIDAD (no debe haber cambios respecto al paso anterior) ===';
GO

-- Debe seguir habiendo UN solo pago
SELECT id_pago, id_reserva, total_pagado, estado_pago
FROM PAGOS
WHERE id_reserva = 3;

SELECT id_reserva, estado, total_pagado
FROM RESERVAS
WHERE id_reserva = 3;
GO

PRINT '=== PARTE 4: LIMPIEZA (restaurar reserva 3 al estado semilla) ===';
PRINT 'DELETE dispara TR_Pagos_AlEliminarRevertirReserva (BD2-61): reserva vuelve a Pendiente.';
GO

DELETE FROM PAGOS
WHERE id_reserva = 3;

SELECT id_reserva, estado, total_pagado
FROM RESERVAS
WHERE id_reserva = 3;

SELECT id_pago, id_reserva, total_pagado, estado_pago
FROM PAGOS
WHERE id_reserva = 3;
GO

PRINT '=== FIN: reserva 3 debe quedar Pendiente, sin pago (como insercion_datos.sql) ===';
GO




