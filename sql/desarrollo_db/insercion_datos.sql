USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

--Gaston

-- INSERTS PARA LA TABLA: CLASIFICACIONES

INSERT INTO CLASIFICACIONES (descripcion) VALUES
('ATP - Apta para todo público'),
('SAM 13 - Apta para mayores de 13 años'),
('SAM 16 - Apta para mayores de 16 años'),
('SAM 18 - Apta para mayores de 18 años');

--  INSERTS PARA LA TABLA: GENEROS

INSERT INTO GENEROS (descripcion) VALUES
('Acción'),
('Ciencia Ficción'),
('Drama'),
('Comedia'),
('Terror'),
('Animación');

-- INSERTS PARA LA TABLA: PELICULAS

INSERT INTO PELICULAS (id_clasificacion, id_genero, titulo, sinopsis, duracion_minutos) VALUES
(1, 6, 'Toy Story', 'Un grupo de juguetes vivientes se meten en problemas cuando llega un nuevo juguete espacial.', 81),
(3, 2, 'Matrix', 'Un programador de computación descubre que el mundo en el que vive es una simulación virtual.', 136),
(2, 1, 'The Avengers', 'Los héroes más poderosos de la Tierra se unen para defender el planeta de una amenaza alienígena.', 143),
(4, 5, 'El Conjuro', 'Investigadores paranormales acuden a ayudar a una familia que experimenta sucesos extraños en su granja.', 112),
(1, 4, 'Shrek', 'Un ogro gruñón emprende un viaje junto a un burro parlanchín para rescatar a una princesa.', 90),
(2, 3, 'Interestelar', 'Un grupo de científicos viaja a través de un agujero de gusano en el espacio para encontrar un nuevo hogar para la humanidad.', 169),
(2, 2, 'Jurassic Park', 'Un multimillonario recrea dinosaurios mediante ingeniería genética para un parque de atracciones, pero algo sale terriblemente mal.', 127),
(1, 3, 'Rocky', 'Un boxeador de un barrio humilde recibe la oportunidad de su vida para pelear por el título mundial de peso completo.', 119);
GO

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