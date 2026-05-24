USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston
-- Gisela

-- Gisela

-- INSERTS: COMPLEJOS 

INSERT INTO COMPLEJOS (nombre, direccion, telefono) VALUES
    ('CineHoyts Abasto', 'Av. Corrientes 3247, CABA', '11-4861-2200'),
    ('Cinépolis Recoleta', 'Vicente López 2050, CABA', '11-4808-0000'),
    ('Showcase Belgrano', 'Av. Monroe 1655, CABA', '11-4789-9100'),
    ('Multiplex Belgrano', 'Vuelta de Obligado 2199, CABA', '11-4781-5500'),
    ('Cinema Devoto', 'José Pedro Varela 4866, CABA', '11-4505-8000');
GO

SELECT * FROM COMPLEJOS;


-- INSERTS: SALAS (Mínimo 5 - Distribuidas en los complejos anteriores)

INSERT INTO SALAS (id_complejo, nombre_sala, capacidad_total, tipo_sala) VALUES
    (1, 'Sala 1 - IMAX', 300, 'IMAX'),
    (1, 'Sala 2 - 3D', 180, '3D'),
    (2, 'Sala Monster 2D', 220, '2D'),
    (3, 'Sala 3D Belgrano', 150, '3D'),
    (4, 'Sala 4 - 2D', 120, '2D'),
    (5, 'Sala Comfort 3D', 200, '3D');
GO

SELECT * FROM SALAS;

-- INSERTS: FUNCIONES

INSERT INTO FUNCIONES (id_pelicula, id_sala, fecha_hora, precio_base) VALUES
    (1, 1, '2026-06-15 18:00:00', 4500.00), -- Película 1 en Sala 1 (IMAX)
    (2, 2, '2026-06-15 21:30:00', 3500.00), -- Película 2 en Sala 2 (3D)
    (3, 3, '2026-06-16 15:00:00', 2800.00), -- Película 3 en Sala 3 (2D)
    (4, 4, '2026-06-16 20:00:00', 3500.00), -- Película 4 en Sala 4 (3D)
    (5, 5, '2026-06-17 19:15:00', 2500.00), -- Película 5 en Sala 5 (2D)
    (1, 6, '2026-06-17 22:00:00', 3500.00); -- Película 1 en Sala 6 (3D)
GO

SELECT * FROM FUNCIONES;

-- Henry

-- Marce
INSERT INTO Metodos_Pagos (nombre) VALUES
    ('Efectivo'),
    ('Tarjeta de débito'),
    ('Tarjeta de crédito'),
    ('Mercado Pago'),
    ('Transferencia bancaria');
GO
SELECT * FROM Metodos_Pagos;

-- Pendientes luego de definir los usuarios, funciones y demás datos relacionados para completar las reservas y pagos
-- INSERT INTO Reservas (id_usuario, id_funcion, fecha_reserva, total_pagado, estado) VALUES
--     (1, 1, '2026-05-10 12:00:00', 17000.00, 'Pagada'),
--     (2, 1, '2026-05-11 15:30:00', 8500.00, 'Pagada'),
--     (3, 3, '2026-05-12 18:00:00', NULL, 'Pendiente'),
--     (4, 5, '2026-05-13 20:00:00', 10400.00, 'Pagada'),
--     (5, 6, '2026-05-14 11:00:00', NULL, 'Cancelada');
-- GO

-- INSERT INTO Pagos (id_reserva, id_metodo_pago, fecha_pago, total_pagado, estado_pago) VALUES
--     (1, 3, '2026-05-10 12:05:00', 17000.00, 'Aprobado'),
--     (2, 4, '2026-05-11 15:35:00', 8500.00, 'Aprobado'),
--     (4, 2, '2026-05-13 20:10:00', 10400.00, 'Aprobado');
-- GO