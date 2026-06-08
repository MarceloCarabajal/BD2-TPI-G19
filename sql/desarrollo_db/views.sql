USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- ============================================================
-- PARTE 1: CONSULTAS Y SUBCONSULTAS (épica BD2-11)
-- ============================================================
-- Gaston   (BD2-23)

--Listado de peliculas con clasificacion "ATP"

SELECT
    p.id_pelicula,
    p.titulo,
    p.sinopsis,
    p.duracion_minutos,
    c.descripcion AS clasificacion
FROM PELICULAS p  
    INNER JOIN CLASIFICACIONES c on c.id_clasificacion = p.id_clasificacion
where c.descripcion = 'ATP';
GO


--Las peliculas que tengan una mayor duracion que el promedio

SELECT 
    id_pelicula,
    titulo,
    duracion_minutos
FROM PELICULAS 
WHERE duracion_minutos > (
    SELECT AVG(duracion_minutos)
    FROM PELICULAS 
)
ORDER BY duracion_minutos DESC

--Los generos sin peliculas asociadas

SELECT 
    g.id_genero,
    g.descripcion AS Generos_Sin_Pelicula
FROM GENEROS g
    LEFT JOIN PELICULAS p ON p.id_genero = g.id_genero
WHERE p.id_pelicula IS NULL ;


-- Gisela   (BD2-24)

-- Consulta 1: Cantidad de salas por cada complejo comercial
SELECT 
    c.nombre AS complejo_nombre,
    COUNT(s.id_sala) AS cantidad_salas
FROM COMPLEJOS c
LEFT JOIN SALAS s ON c.id_complejo = s.id_complejo
GROUP BY c.id_complejo, c.nombre;
GO

-- Consulta 2: Listado de funciones programadas específicamente en salas "IMAX"
SELECT 
    f.id_funcion,
    p.titulo AS pelicula,
    c.nombre AS complejo,
    s.nombre_sala,
    f.fecha_hora,
    f.precio_base
FROM FUNCIONES f
INNER JOIN PELICULAS p ON f.id_pelicula = p.id_pelicula
INNER JOIN SALAS s ON f.id_sala = s.id_sala
INNER JOIN COMPLEJOS c ON s.id_complejo = c.id_complejo
WHERE s.tipo_sala = 'IMAX';
GO

-- Consulta 3: Complejos que actualmente no registran ninguna función programada
SELECT 
    c.id_complejo,
    c.nombre AS complejo_sin_funciones,
    c.direccion,
    c.telefono
FROM COMPLEJOS c
LEFT JOIN SALAS s ON c.id_complejo = s.id_complejo
LEFT JOIN FUNCIONES f ON s.id_sala = f.id_sala
WHERE f.id_funcion IS NULL;
GO


-- Henry    (BD2-25, BD2-27 integradoras)

-- Marcelo  (BD2-26)

-- Consulta 1: reservas Pendientes sin registro de pago
SELECT
    r.id_reserva,
    r.id_usuario,
    r.id_funcion,
    r.fecha_reserva,
    r.estado
FROM RESERVAS r
    LEFT JOIN PAGOS p ON r.id_reserva = p.id_reserva
WHERE r.estado = 'Pendiente'
  AND p.id_pago IS NULL;
GO

-- Consulta 2: reservas Pagadas cuyo total supera el promedio (subconsulta)
SELECT
    r.id_reserva,
    r.total_pagado,
    r.fecha_reserva
FROM RESERVAS r
WHERE r.estado = 'Pagada'
  AND r.total_pagado > (
        SELECT AVG(total_pagado)
        FROM RESERVAS
        WHERE estado = 'Pagada'
          AND total_pagado IS NOT NULL
    );
GO

-- Consulta 3: recaudacion por mes segun fecha de pago
SELECT
    YEAR(p.fecha_pago) AS anio,
    MONTH(p.fecha_pago) AS mes,
    SUM(p.total_pagado) AS total_recaudado
FROM PAGOS p
WHERE p.estado_pago = 'Aprobado'
GROUP BY YEAR(p.fecha_pago), MONTH(p.fecha_pago)
ORDER BY anio, mes;
GO

-- ============================================================
-- PARTE 2: VISTAS
-- ============================================================
-- Gaston   (BD2-23)  CREATE VIEW vw_CarteleraPeliculas ...


CREATE VIEW vw_CarteleraPeliculas AS

SELECT
    f.id_funcion,
    p.titulo AS Pelicula ,
    c.nombre As Complejo ,
    s.nombre_sala ,
    s.tipo_sala ,
    f.fecha_hora ,
    f.precio_base
FROM FUNCIONES f
    INNER JOIN PELICULAS p ON p.id_pelicula = f.id_pelicula
    INNER JOIN SALAS s ON s.id_sala = f.id_sala
    INNER JOIN COMPLEJOS c ON c.id_complejo = s.id_complejo
GO

--SELECT * FROM vw_CarteleraPeliculas
GO

-- Gisela   (BD2-24)  CREATE VIEW vw_FuncionesCompleto ...

-- BD2-24 : Vista 1: vw_FuncionesCompleto
-- Consolida cartelera, salas, complejos y clasificaciones

CREATE VIEW vw_FuncionesCompleto AS
SELECT 
    f.id_funcion,
    f.fecha_hora,
    f.precio_base,
    p.titulo AS pelicula_titulo,
    p.duracion_minutos,
    g.descripcion AS genero,
    cl.descripcion AS clasificacion,
    s.nombre_sala,
    s.tipo_sala,
    c.nombre AS complejo_nombre,
    c.direccion AS complejo_direccion
FROM FUNCIONES f
INNER JOIN PELICULAS p ON f.id_pelicula = p.id_pelicula
INNER JOIN GENEROS g ON p.id_genero = g.id_genero
INNER JOIN CLASIFICACIONES cl ON p.id_clasificacion = cl.id_clasificacion
INNER JOIN SALAS s ON f.id_sala = s.id_sala
INNER JOIN COMPLEJOS c ON s.id_complejo = c.id_complejo;
GO


-- BD2-24: Vista 2: vw_ButacasLibresPorFuncion (Pedido Profe Laura)
-- Muestra que asientos fisicos no estan ocupados en cada funcion, resolviendo la relacion a traves de la tabla intermedia RESERVAS.

CREATE VIEW vw_ButacasLibresPorFuncion AS
SELECT 
    f.id_funcion,
    f.fecha_hora,
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
WHERE ocupadas.id_butaca IS NULL; -- Si es NULL, la butaca esta libre para esa funcion
GO

-- Henry    (BD2-25)  CREATE VIEW vw_DetalleReservasCompleto ...
-- Marcelo  (BD2-26)

-- BD2-26: pagos aprobados con reserva, metodo de pago y usuario
CREATE VIEW vw_PagosAprobados
AS
    SELECT
        p.id_pago,
        p.id_reserva,
        mp.nombre AS metodo_pago,
        p.total_pagado,
        p.fecha_pago,
        u.email,
        r.estado AS estado_reserva
    FROM PAGOS p
        INNER JOIN RESERVAS r ON p.id_reserva = r.id_reserva
        INNER JOIN METODOS_PAGOS mp ON p.id_metodo_pago = mp.id_metodo_pago
        INNER JOIN USUARIOS u ON r.id_usuario = u.id_usuario
    WHERE p.estado_pago = 'Aprobado';
GO

-- BD2-26: recaudacion agrupada por metodo de pago
CREATE VIEW vw_RecaudacionPorMetodoPago
AS
    SELECT
        mp.nombre AS metodo_pago,
        COUNT(p.id_pago) AS cantidad_pagos,
        SUM(p.total_pagado) AS total_recaudado
    FROM PAGOS p
        INNER JOIN METODOS_PAGOS mp ON p.id_metodo_pago = mp.id_metodo_pago
    WHERE p.estado_pago = 'Aprobado'
    GROUP BY mp.nombre;
GO

-- Pruebas BD2-26
-- SELECT * FROM vw_PagosAprobados;
-- SELECT * FROM vw_RecaudacionPorMetodoPago;
GO
