USE BD2_TPI_G19
GO

--PRUEBA DE ROLLBACK CON sp_RegistrarPago


PRINT ' PARTE 1: ESTADO INICIAL ';

-- Revisamos los datos iniciales de la reserva 1
SELECT id_reserva, estado, total_pagado 
FROM RESERVAS 
WHERE id_reserva = 1;


-- Comprobamos que no haya ningún pago registrado aún para esta reserva
SELECT id_pago, id_reserva, total_pagado, estado_pago 
FROM PAGOS 
WHERE id_reserva = 1;
GO

PRINT ' PARTE 2: EJECUTANDO PRIMER PAGO ';

-- Ejecutamos el SP para asentar el pago real por primera vez
EXEC sp_RegistrarPago 
    @id_reserva = 1, 
    @id_metodo_pago = 1, 
    @total_pagado = 4500.00;
GO

PRINT ' VERIFICACIÓN POST-PRIMER PAGO ';
-- El pago debe figurar en la tabla PAGOS
SELECT id_pago, id_reserva, total_pagado, estado_pago 
FROM PAGOS 
WHERE id_reserva = 1;

-- La reserva debería haber cambiado su estado ('Pagada')
SELECT id_reserva, estado, total_pagado 
FROM RESERVAS 
WHERE id_reserva = 1;
GO


PRINT 'PARTE 3: INTENTO DE PAGO DUPLICADO';

BEGIN TRY
    -- Volvemos a mandar exactamente el mismo pago para la misma reserva
    EXEC sp_RegistrarPago 
        @id_reserva = 1, 
        @id_metodo_pago = 1, 
        @total_pagado = 4500.00;
END TRY
BEGIN CATCH
    -- El SP lanzará el RaisError, y acá capturamos el mensaje final en la consola
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    
    RAISERROR (@ErrorMessage, 16, 1);
    
END CATCH;
GO

PRINT 'VERIFICACIÓN DE SEGURIDAD (EL ROLLBACK EVITÓ CAMBIOS) ';
-- Comprobamos que la tabla PAGOS sigue teniendo UN SOLO registro 
SELECT id_pago, id_reserva, total_pagado, estado_pago 
FROM PAGOS 
WHERE id_reserva = 1;

-- Comprobamos que la reserva se mantuvo intacta y segura
SELECT id_reserva, estado, total_pagado 
FROM RESERVAS 
WHERE id_reserva = 1;
GO

-- PARTE 4: LIMPIEZA DE ENTORNO
-- Objetivo: Dejar la base de datos exactamente como estaba antes de empezar.
PRINT 'PARTE 4: LIMPIEZA';

-- Eliminamos el pago que usamos para la simulación
DELETE FROM PAGOS WHERE id_reserva = 1;

-- Reseteamos la reserva a su estado original 
UPDATE RESERVAS 
SET estado = 'Pendiente', total_pagado = NULL 
WHERE id_reserva = 1;
GO
--Restaurado con éxito para la próxima prueba





