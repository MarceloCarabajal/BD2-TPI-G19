USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston   (BD2-29)  sp_InsertarPelicula
CREATE PROCEDURE sp_InsertarPelicula
    @ID_Clasificaciones BIGINT,
    @ID_Genero BIGINT,
    @Titulo NVARCHAR(150),
    @Sinopsis NVARCHAR(1000),
    @Duracion SMALLINT
AS
BEGIN
    -- VALIDAMOS SI LA DURACION ES MAYOR A 0
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

    -- VALIDAMOS LA EXISTENCIA DEL GENERO
    IF NOT EXISTS (SELECT 1 FROM GENEROS WHERE id_genero = @ID_Genero)
    BEGIN
        RAISERROR('El género especificado no existe.', 16, 1);
        RETURN;
    END

    BEGIN TRY

        BEGIN TRANSACTION;
        -- INSERTAMOS LOS DATOS RECIBIDOS EN LA TABLA PELICULAS
        INSERT INTO PELICULAS (id_clasificacion, id_genero, titulo,sinopsis, duracion_minutos)
        VALUES (@ID_Clasificaciones , @ID_Genero , @Titulo, @Sinopsis, @Duracion);

        -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
        COMMIT TRANSACTION;
        PRINT 'Película insertada con éxito.';
    END TRY
    BEGIN CATCH
        -- SI FALLA SE DESHACE TODO
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
    -- Verificar que el precio base sea valido
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
    -- Si paso todos los controles, se registra la funcion
    INSERT INTO FUNCIONES (id_pelicula, id_sala, fecha_hora, precio_base)
    VALUES (@id_pelicula, @id_sala, @fecha_hora, @precio_base);

    PRINT 'Función creada exitosamente.';
END;
GO

-- Henry    (BD2-31)  sp_ReservasPorUsuario / sp_ButacasOcupadasPorFuncion
CREATE PROCEDURE sp_ReservasPorUsuario
    @id_usuario BIGINT
AS
BEGIN
    -- Validamos que el id del usuario es válido
    IF @id_usuario < 1
    BEGIN
        RAISERROR('El id de usuario no es válido, recuerde que el id tiene que ser un número positivo mayor a 0.', 16, 1);
        RETURN;
    END
    -- Consultamos si existe ese usuario en el sistema
    IF NOT EXISTS (SELECT 1 FROM USUARIOS WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('El usuario especificado no existe en el sistema.', 16, 1);
        RETURN;
    END;
    -- Si no existe una reserva para ese usuario, se lo notificamos
    IF NOT EXISTS (SELECT 1 FROM RESERVAS WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('El usuario aún no tiene reservas realizadas.', 16, 1);
        RETURN;
    END;
    -- Mostramos las reservas desde la más reciente a la más antigua
    ELSE
        SELECT
            vw_drc.id_reserva,
            vw_drc.id_usuario,
            vw_drc.nombre,
            vw_drc.apellido,
            vw_drc.email,
            vw_drc.fecha_registro_usuario,
            vw_drc.id_funcion,
            vw_drc.id_butaca,
            vw_drc.precio_unitario,
            vw_drc.total_pagado,
            vw_drc.fecha_reserva,
            vw_drc.estado_reserva
        FROM vw_DetalleReservasCompleto vw_drc
        WHERE id_usuario = @id_usuario
        ORDER BY vw_drc.fecha_reserva DESC, vw_drc.id_reserva ASC;
END;
GO

CREATE PROCEDURE sp_ButacasOcupadasPorFuncion
    @id_funcion BIGINT
AS
BEGIN
    -- Validamos que el id de la función sea válido
    IF @id_funcion < 1
    BEGIN
        RAISERROR('El id de función no es válido, recuerde que el id tiene que ser un número positivo mayor a 0.', 16, 1);
        RETURN;
    END
    -- Consultamos si existe esa función en el sistema
    IF NOT EXISTS (SELECT 1 FROM FUNCIONES WHERE id_funcion = @id_funcion)
    BEGIN
        RAISERROR('La función especificada no existe en el sistema.', 16, 1);
        RETURN;
    END;
    -- Si no existe una reserva para esa función, se lo notificamos
    IF NOT EXISTS (SELECT 1 FROM RESERVAS WHERE id_funcion = @id_funcion)
    BEGIN
        RAISERROR('La función aún no tiene reservas realizadas.', 16, 1);
        RETURN;
    END;
    -- Mostramos las butacas por función desde la más reciente a la más antigua
    ELSE
        SELECT 
            f.id_funcion,
            f.fecha_hora as fecha_funcion,
            p.titulo AS pelicula,
            s.nombre_sala,
            b.id_butaca,
            b.fila,
            b.numero AS numero_butaca
        FROM FUNCIONES f
        INNER JOIN PELICULAS p ON f.id_pelicula = p.id_pelicula
        INNER JOIN SALAS s ON f.id_sala = s.id_sala
        INNER JOIN BUTACAS b ON s.id_sala = b.id_sala
        LEFT JOIN (
            -- Subconsulta para mapear que butacas ya se vendieron para que funcion
            SELECT r.id_funcion, dr.id_butaca 
            FROM DETALLES_RESERVAS dr
            INNER JOIN RESERVAS r ON dr.id_reserva = r.id_reserva
        ) ocupadas ON f.id_funcion = ocupadas.id_funcion AND b.id_butaca = ocupadas.id_butaca
        WHERE ocupadas.id_butaca IS NOT NULL -- Si es NULL, la butaca esta libre para esa funcion
        AND f.id_funcion = @id_funcion
        ORDER BY f.id_funcion ASC, fecha_funcion DESC, b.fila ASC, numero_butaca ASC; 
END;
GO

-- Henry    (BD2-35)  sp_CrearReservaConDetalle  (BEGIN TRAN)
CREATE PROCEDURE sp_CrearReservaConDetalle
    @id_usuario BIGINT,
    @id_funcion BIGINT,
    @id_butaca BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    --- VALIDACIONES DEL ID DE USUARIO
    -- Validamos que el id del usuario es válido
    IF @id_usuario < 1
    BEGIN
        RAISERROR('El id de usuario no es válido, recuerde que el id tiene que ser un número positivo mayor a 0.', 16, 1);
        RETURN;
    END
    -- Consultamos si existe ese usuario en el sistema
    IF NOT EXISTS (SELECT 1 FROM USUARIOS WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('El usuario especificado no existe en el sistema.', 16, 1);
        RETURN;
    END;
    --- VALIDACIONES DEL ID DE FUNCIÓN
    -- Validamos que el id de la función sea válido
    IF @id_funcion < 1
    BEGIN
        RAISERROR('El id de función no es válido, recuerde que el id tiene que ser un número positivo mayor a 0.', 16, 1);
        RETURN;
    END
    -- Consultamos si existe esa función en el sistema
    IF NOT EXISTS (SELECT 1 FROM FUNCIONES WHERE id_funcion = @id_funcion)
    BEGIN
        RAISERROR('La función especificada no existe en el sistema.', 16, 1);
        RETURN;
    END;
    --- VALIDACIONES DEL ID DE BUTACA
    -- Validamos que el id de la butaca sea válido
    IF @id_butaca < 1
    BEGIN
        RAISERROR('El id de butaca no es válido, recuerde que el id tiene que ser un número positivo mayor a 0.', 16, 1);
        RETURN;
    END
    -- Consultamos si existe esa butaca en el sistema
    IF NOT EXISTS (SELECT 1 FROM BUTACAS WHERE id_butaca = @id_butaca)
    BEGIN
        RAISERROR('La butaca especificada no existe en el sistema.', 16, 1);
        RETURN;
    END;
    -- Si se pasan todas las validaciones, entonces empezamos el proceso para guardar la reserva
    BEGIN TRY
        BEGIN TRANSACTION;
        -- Buscamos si es la primera vez que el usuario hace una reserva para esa función
        IF NOT EXISTS(
            SELECT 
                1
            FROM RESERVAS
            WHERE id_usuario = @id_usuario AND id_funcion = @id_funcion
        )
        BEGIN
            -- Insertamos los datos recibidos en la tabla RESERVAS
            INSERT INTO RESERVAS (id_usuario, id_funcion, total_pagado)
            VALUES (@id_usuario, @id_funcion, NULL);
        END;
        -- Hacemos lo siguiente tanto para agregar una butaca a una reserva ya hecha por el usuario o para una nueva reserva
        -- Obtenemos el id de la reserva
        DECLARE @id_reserva BIGINT;
        SELECT TOP 1
            @id_reserva = id_reserva 
        FROM RESERVAS 
        WHERE id_usuario = @id_usuario 
        AND id_funcion = @id_funcion
        AND estado <> 'Cancelada'
        ORDER BY id_reserva DESC;
        
        -- Obtenemos el precio unitario de la butaca
        DECLARE @precio_unitario MONEY;
        SELECT
            @precio_unitario = precio_base
        FROM FUNCIONES
        WHERE id_funcion = @id_funcion
        
        INSERT INTO DETALLES_RESERVAS (id_reserva, id_butaca, precio_unitario)
        VALUES (@id_reserva, @id_butaca, @precio_unitario)

        -- Si todo se realizó correctamente, confirmamos los cambios
        PRINT 'La reserva se registró exitosamente.';
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si un proceso falla durante la ejecución, se deshace todo
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END CATCH
END;
GO

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
        
        PRINT 'El pago se registró exitosamente.';

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
    
    PRINT 'Se canceló la reserva exitosamente.';
END;
GO

-- Pruebas BD41 (Marcelo) sp_InsertarPelicula
-- Caso exitoso
-- EXEC sp_InsertarPelicula @ID_Clasificaciones = 1, @ID_Genero = 1, @Titulo = 'Prueba', @Sinopsis = 'Prueba de sinopsis', @Duracion = 120;
-- GO
-- Caso de error (duracion negativa)
-- EXEC sp_InsertarPelicula @ID_Clasificaciones = 1, @ID_Genero = 1, @Titulo = 'Prueba', @Sinopsis = 'Prueba de sinopsis', @Duracion = -120;
-- GO

-- Pruebas BD2-41 (Marcelo) sp_CrearFuncion
-- Caso exitoso
-- EXEC sp_CrearFuncion @id_pelicula = 1, @id_sala = 1, @fecha_hora = '2026-07-01 20:00:00', @precio_base = 500.00;
-- GO
-- Caso de error (sala ocupada en mismo horario)
-- EXEC sp_CrearFuncion @id_pelicula = 1, @id_sala = 1, @fecha_hora = '2026-07-01 20:00:00', @precio_base = 600.00;
-- GO

-- Pruebas BD2-41 (Marcelo) sp_ReservasPorUsuario
-- Caso exitoso
-- EXEC sp_ReservasPorUsuario @id_usuario = 1;
-- GO
-- Caso de error (usuario inexistente)
-- EXEC sp_ReservasPorUsuario @id_usuario = 999;
-- GO

-- Pruebas BD2-41 (Marcelo) sp_ButacasOcupadasPorFuncion
-- Caso exitoso
-- EXEC sp_ButacasOcupadasPorFuncion @id_funcion = 1;
-- GO
-- Caso de error (funcion inexistente)
-- EXEC sp_ButacasOcupadasPorFuncion @id_funcion = 999;
-- GO

-- Pruebas BD2-41 (Marcelo) sp_CrearReservaConDetalle
-- Caso exitoso
-- EXEC sp_CrearReservaConDetalle @id_usuario = 3, @id_funcion = 5, @id_butaca = 1
-- GO
-- Caso de error (butaca ya ocupada en misma función)
-- EXEC sp_CrearReservaConDetalle @id_usuario = 3, @id_funcion = 5, @id_butaca = 6
-- GO

-- Pruebas BD2-41 (Marcelo) sp_RegistrarPago
-- Caso exitoso
-- EXEC sp_RegistrarPago @id_reserva = 3, @id_metodo_pago = 1, @total_pagado = 2800.00;
-- GO
-- Caso de error (reserva cancelada o ya pagada)
-- EXEC sp_RegistrarPago @id_reserva = 4, @id_metodo_pago = 1, @total_pagado = 2800.00;
-- GO
-- SELECT * from PAGOS where id_reserva = 3;
-- GO

-- Pruebas BD2-41 (Marcelo) sp_CancelarReserva
-- Caso exitoso
-- EXEC sp_CancelarReserva @id_reserva = 3;
-- GO
-- Caso de error (reserva inexistente)
-- EXEC sp_CancelarReserva @id_reserva = 999;
-- GO