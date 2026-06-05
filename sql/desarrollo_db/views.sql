USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- ============================================================
-- PARTE 1: CONSULTAS Y SUBCONSULTAS (épica BD2-11)
-- ============================================================
-- Gaston   (BD2-23)
-- Gisela   (BD2-24)
-- Henry    (BD2-25, BD2-27 integradoras)
-- Marcelo  (BD2-26)

-- consulta 1: reservas Pendientes sin registro de pago
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
-- Gisela   (BD2-24)  CREATE VIEW vw_FuncionesCompleto ...
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
