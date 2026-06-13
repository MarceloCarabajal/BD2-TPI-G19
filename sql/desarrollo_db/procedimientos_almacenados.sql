USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston   (BD2-29)  sp_InsertarPelicula


CREATE PROCEDURE sp_InsertarPelicula
    @ID_Clasificaciones BIGINT,
    @ID_Genero BIGINT,
    @Titulo VARCHAR(150),
    @Sinopsis VARCHAR (1000),
    @Duracion SMALLINT
AS
BEGIN


    --VALIDAMOS SI LA DURACION ES MAYOR A 0
    IF @Duracion <= 0
    BEGIN
        RAISERROR('La duración de la película debe ser mayor a 0 minutos.', 16, 1);
        RETURN;
    END

    -- VALIDAMOS LA EXISTENCIA DE LA CLASIFICACION 
    IF NOT EXISTS (SELECT 1 FROM CLASIFICACIONES WHERE id_clasificacion = @ID_Clasificaciones)
    BEGIN
        RAISERROR('La clasificación especificada no existe.', 16, 1);
        RETURN;
    END

    --VALIDAMOS LA EXISTENCIA DEL GENERO
    IF NOT EXISTS (SELECT 1 FROM GENEROS WHERE id_genero = @ID_Genero)
    BEGIN
        RAISERROR('El género especificado no existe.', 16, 1);
        RETURN;
    END

    BEGIN TRY

        BEGIN TRANSACTION;
        --iNSERTAMOS LOS DATOS RECIBIDOS EN LA TABLA PELICULAS
        INSERT INTO PELICULAS (id_clasificacion, id_genero, titulo,sinopsis, duracion_minutos)
        VALUES (@ID_Clasificaciones , @ID_Genero , @Titulo, @Sinopsis, @Duracion);

        -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
        COMMIT TRANSACTION;
        PRINT 'Película insertada con éxito.';
    END TRY
    BEGIN CATCH
        --SI FALLA SE DESHACE TODO
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END CATCH
END;
GO


-- Gisela   (BD2-30)  sp_CrearFuncion
CREATE PROCEDURE sp_CrearFuncion
    @id_pelicula BIGINT,
    @id_sala BIGINT,
    @fecha_hora DATETIME,
    @precio_base MONEY
AS
BEGIN
    SET NOCOUNT ON;
    -- Verificar si existe la película
    IF NOT EXISTS (SELECT 1 FROM PELICULAS WHERE id_pelicula = @id_pelicula)
    BEGIN
        RAISERROR('Error: La película especificada no existe en el sistema.', 16, 1);
        RETURN;
    END;
    -- Verificar si existe la sala
    IF NOT EXISTS (SELECT 1 FROM SALAS WHERE id_sala = @id_sala)
    BEGIN
        RAISERROR('Error: La sala especificada no existe en el sistema.', 16, 1);
        RETURN;
    END;
    --Verificar que el precio base sea valido
    IF @precio_base <= 0
    BEGIN
        RAISERROR('Error: El precio base de la función debe ser mayor a cero.', 16, 1);
        RETURN;
    END;
    -- Control de superposicion de horarios en la misma sala
    -- Obtenemos la duracion de la pelicula que se quiere programar
    DECLARE @duracion_nueva SMALLINT;
    SELECT @duracion_nueva = duracion_minutos FROM PELICULAS WHERE id_pelicula = @id_pelicula;

    -- Si no tiene duracion asignada, le estimamos un estándar de 120 min + 15 min de limpieza
    IF @duracion_nueva IS NULL SET @duracion_nueva = 135;
    ELSE SET @duracion_nueva = @duracion_nueva + 15;

    -- Buscamos si hay cruces de horarios en esa misma sala
    IF EXISTS (
        SELECT 1 
        FROM FUNCIONES f
        INNER JOIN PELICULAS p ON f.id_pelicula = p.id_pelicula
        WHERE f.id_sala = @id_sala
          AND @fecha_hora >= f.fecha_hora 
          AND @fecha_hora < DATEADD(MINUTE, ISNULL(p.duracion_minutos, 120) + 15, f.fecha_hora)
    )
    BEGIN
        RAISERROR('Error: La sala ya se encuentra ocupada por otra función en ese rango horario.', 16, 1);
        RETURN;
    END;
    --Si paso todos los controles, se registra la funcion
    INSERT INTO FUNCIONES (id_pelicula, id_sala, fecha_hora, precio_base)
    VALUES (@id_pelicula, @id_sala, @fecha_hora, @precio_base);

    PRINT 'Función creada exitosamente.';
END;
GO
-- Henry    (BD2-31)  sp_ReservasPorUsuario / sp_ButacasOcupadasPorFuncion
-- Henry    (BD2-35)  sp_CrearReservaConDetalle  (BEGIN TRAN)

-- Marcelo  (BD2-32, BD2-36)
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

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO PAGOS (id_reserva, id_metodo_pago, total_pagado, estado_pago)
        VALUES (@id_reserva, @id_metodo_pago, @total_pagado, 'Aprobado');

        UPDATE RESERVAS
        SET estado = 'Pagada', total_pagado = @total_pagado
        WHERE id_reserva = @id_reserva;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END CATCH
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
-- Pruebas BD2-32 / BD2-36
 EXEC sp_RegistrarPago @id_reserva = 3, @id_metodo_pago = 1, @total_pagado = 2800.00;
GO