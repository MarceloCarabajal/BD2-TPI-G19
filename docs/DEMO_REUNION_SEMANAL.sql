-- Demo reunion semanal Laura (~8-10 min)
-- Ejecutar en SSMS tras scripts 1-4 (reserva 3 Pendiente si no corrio la prueba BD2-32 al final de procedimientos)

USE BD2_TPI_G19;
GO

-- 1) DDL corregido (mostrar en creacion_bd.sql): BIGINT, MONEY, SMALLINT, DETALLES sin id_funcion

-- 2) Vistas mergeadas - modulo pagos (Marcelo BD2-26)
SELECT * FROM vw_PagosAprobados;
GO
SELECT * FROM vw_RecaudacionPorMetodoPago;
GO

-- 3) Vista butacas libres (Gisela BD2-24 - pedido profe Laura)
SELECT TOP 10 *
FROM vw_ButacasLibresPorFuncion
WHERE id_funcion = 1;
GO

-- 4) Circuito reserva -> pago (preview video final)
SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
GO
EXEC sp_RegistrarPago @id_reserva = 3, @id_metodo_pago = 1, @total_pagado = 2800.00;
GO
SELECT id_reserva, estado, total_pagado FROM RESERVAS WHERE id_reserva = 3;
GO

-- 5) Trigger BD2-34 - red de seguridad (opcional si ya mergeado script 5)
-- INSERT directo en PAGOS actualiza RESERVAS via TR_Pagos_ActualizarEstadoReserva

-- Pendiente equipo (mencionar en Jira):
-- Henry: BD2-25, BD2-27, BD2-31, BD2-35
-- Gaston: BD2-28, BD2-29
-- Gisela: BD2-33 trigger butaca duplicada
