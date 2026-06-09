USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston   (BD2-28)  CREATE FUNCTION fn_ObtenerDuracionPelicula ...

CREATE FUNCTION fn_ObtenerDuracionPelicula
(
    @idPelicula INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Duracion INT;

    SELECT @Duracion = duracion_minutos 
    FROM Peliculas                      
    WHERE id_pelicula = @idpelicula;  

    -- Si la película no existe o no tiene duración se devuelve 0
    RETURN ISNULL(@Duracion, 0);
END;
GO

--Uso de la funcion ejemplo
--select 
--id_pelicula , titulo , dbo.fn_ObtenerDuracionPelicula(id_pelicula) As Duracion_Pelicula
--FROM PELICULAS
--WHERE id_pelicula = 3



-- Gisela
-- Henry
-- Marcelo