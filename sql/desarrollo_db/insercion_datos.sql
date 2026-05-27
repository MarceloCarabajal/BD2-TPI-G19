USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston

-- Gisela

INSERT INTO COMPLEJOS (nombre, direccion, telefono) VALUES
    ('CineHoyts Abasto', 'Av. Corrientes 3247, CABA', '11-4861-2200'),
    ('Cinépolis Recoleta', 'Vicente López 2050, CABA', '11-4808-0000'),
    ('Showcase Belgrano', 'Av. Monroe 1655, CABA', '11-4789-9100'),
    ('Multiplex Belgrano', 'Vuelta de Obligado 2199, CABA', '11-4781-5500'),
    ('Cinema Devoto', 'José Pedro Varela 4866, CABA', '11-4505-8000');
GO

SELECT * FROM COMPLEJOS;


INSERT INTO SALAS (id_complejo, nombre_sala, capacidad_total, tipo_sala) VALUES
    (1, 'Sala 1', 300, 'IMAX'),
    (1, 'Sala 2', 180, '3D'),
    (2, 'Sala 1', 220, '2D'),
    (3, 'Sala 1', 150, '3D'),
    (4, 'Sala 1', 120, '2D'),
    (5, 'Sala 1', 200, '3D');
GO

SELECT * FROM SALAS;

INSERT INTO FUNCIONES (id_pelicula, id_sala, fecha_hora, precio_base) VALUES
    (1, 1, '2026-06-15 18:00:00', 4500.00), -- Película 1 en Sala 1 (IMAX)
    (2, 2, '2026-06-15 21:30:00', 3500.00), -- Película 2 en Sala 2 (3D)
    (3, 3, '2026-06-16 15:00:00', 2800.00), -- Película 3 en Sala 3 (2D)
    (4, 4, '2026-06-16 20:00:00', 3500.00), -- Película 4 en Sala 4 (3D)
    (5, 5, '2026-06-17 19:15:00', 2500.00), -- Película 5 en Sala 5 (2D)
    (1, 6, '2026-06-17 22:00:00', 3500.00); -- Película 1 en Sala 6 (3D)
GO

SELECT * FROM FUNCIONES;

-- Henry (Parte 1)

INSERT INTO USUARIOS (nombre, apellido, email, password, fecha_registro) VALUES
    ('Martina', 'Gómez', 'martina.gomez@gmail.com', 'Martina123', '2025-03-15'),
    ('Lucas', 'Fernández', 'lucas.fernandez@hotmail.com', 'Lucas123', '2024-05-02'),
    ('Valentina', 'Pereyra', 'valentina.pereyra@gmail.com', 'Valentina123', '2026-03-10'),
    ('Santiago', 'Ramírez', 'santiago.ramirez@yahoo.com', 'Santiago123', GETDATE()),
    ('Camila', 'Torres', 'camila.torres@outlook.com', 'Camila123', '2026-08-20'),
    ('Mateo', 'Suárez', 'mateo.suarez@email.com', 'Mateo123', '2026-11-05')
GO
SELECT * FROM USUARIOS;

INSERT INTO BUTACAS (id_sala, fila, numero) VALUES
    (1, 'A', 1),
    (2, 'B', 5),
    (3, 'A', 3),
    (4, 'C', 7),
    (5, 'D', 12),
    (1, 'E', 9)
GO
SELECT * FROM BUTACAS;

-- Marce

INSERT INTO METODOS_PAGOS (nombre) VALUES
    ('Efectivo'),
    ('Tarjeta de débito'),
    ('Tarjeta de crédito'),
    ('Mercado Pago'),
    ('Transferencia bancaria');
GO
SELECT * FROM METODOS_PAGOS;

-- Pendientes luego de definir los usuarios, funciones y demás datos relacionados para completar las reservas y pagos
-- INSERT INTO RESERVAS (id_usuario, id_funcion, fecha_reserva, total_pagado, estado) VALUES
--     (1, 1, '2026-05-10 12:00:00', 17000.00, 'Pagada'),
--     (2, 1, '2026-05-11 15:30:00', 8500.00, 'Pagada'),
--     (3, 3, '2026-05-12 18:00:00', NULL, 'Pendiente'),
--     (4, 5, '2026-05-13 20:00:00', 10400.00, 'Pagada'),
--     (5, 6, '2026-05-14 11:00:00', NULL, 'Cancelada');
-- GO
-- SELECT * FROM RESERVAS;

-- INSERT INTO PAGOS (id_reserva, id_metodo_pago, fecha_pago, total_pagado, estado_pago) VALUES
--     (1, 3, '2026-05-10 12:05:00', 17000.00, 'Aprobado'),
--     (2, 4, '2026-05-11 15:35:00', 8500.00, 'Aprobado'),
--     (4, 2, '2026-05-13 20:10:00', 10400.00, 'Aprobado');
-- GO
-- SELECT * FROM PAGOS;

-- Henry (Parte 2)

-- INSERT INTO DETALLES_RESERVAS (id_reserva, id_butaca, id_funcion, precio_unitario) VALUES
--     (1, 3, 2, 5200.00),
--     (1, 4, 2, 5200.00),
--     (2, 1, 5, 7500.00),
--     (3, 6, 1, 4500.00),
--     (4, 2, 4, 4800.00),
--     (5, 5, 3, 6000.00)
-- GO
-- SELECT * FROM DETALLES_RESERVAS;