USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston

-- INSERTS PARA LA TABLA: CLASIFICACIONES

INSERT INTO CLASIFICACIONES (descripcion) VALUES
('ATP - Apta para todo público'),
('SAM 13 - Apta para mayores de 13 años'),
('SAM 16 - Apta para mayores de 16 años'),
('SAM 18 - Apta para mayores de 18 años');
GO
-- SELECT * FROM CLASIFICACIONES;

-- INSERTS PARA LA TABLA: GENEROS

INSERT INTO GENEROS (descripcion) VALUES
('Acción'),
('Ciencia Ficción'),
('Drama'),
('Comedia'),
('Terror'),
('Animación');
GO
-- SELECT * FROM GENEROS;

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
-- SELECT * FROM PELICULAS;

-- Gisela

-- INSERTS PARA LA TABLA: COMPLEJOS

INSERT INTO COMPLEJOS (nombre, direccion, telefono) VALUES
    ('CineHoyts Abasto', 'Av. Corrientes 3247, CABA', '11-4861-2200'),
    ('Cinépolis Recoleta', 'Vicente López 2050, CABA', '11-4808-0000'),
    ('Showcase Belgrano', 'Av. Monroe 1655, CABA', '11-4789-9100'),
    ('Multiplex Belgrano', 'Vuelta de Obligado 2199, CABA', '11-4781-5500'),
    ('Cinema Devoto', 'José Pedro Varela 4866, CABA', '11-4505-8000');
GO
-- SELECT * FROM COMPLEJOS;

-- INSERTS PARA LA TABLA: SALAS

INSERT INTO SALAS (id_complejo, nombre_sala, capacidad_total, tipo_sala) VALUES
    (1, 'Sala 1', 300, 'IMAX'),
    (1, 'Sala 2', 180, '3D'),
    (2, 'Sala 1', 220, '2D'),
    (3, 'Sala 1', 150, '3D'),
    (4, 'Sala 1', 120, '2D'),
    (5, 'Sala 1', 200, '3D');
GO
-- SELECT * FROM SALAS;

-- INSERTS PARA LA TABLA: FUNCIONES

INSERT INTO FUNCIONES (id_pelicula, id_sala, fecha_hora, precio_base) VALUES
    (1, 1, DATEADD(hour, 18, DATEADD(day, 7, CAST(CAST(GETDATE() AS DATE) AS DATETIME))), 4500.00),
    (2, 2, DATEADD(hour, 21, DATEADD(minute, 30, DATEADD(day, 7, CAST(CAST(GETDATE() AS DATE) AS DATETIME)))), 3500.00),
    (3, 3, DATEADD(hour, 15, DATEADD(day, 8, CAST(CAST(GETDATE() AS DATE) AS DATETIME))), 2800.00),
    (4, 4, DATEADD(hour, 20, DATEADD(day, 8, CAST(CAST(GETDATE() AS DATE) AS DATETIME))), 3500.00),
    (5, 5, DATEADD(hour, 19, DATEADD(minute, 15, DATEADD(day, 9, CAST(CAST(GETDATE() AS DATE) AS DATETIME)))), 2500.00),
    (1, 6, DATEADD(hour, 22, DATEADD(day, 9, CAST(CAST(GETDATE() AS DATE) AS DATETIME))), 3500.00);
GO
-- SELECT * FROM FUNCIONES;

-- Henry (Parte 1)

-- INSERTS PARA LA TABLA: USUARIOS

INSERT INTO USUARIOS (nombre, apellido, email, password, fecha_registro) VALUES
    ('Martina', 'Gómez', 'martina.gomez@gmail.com', 'Martina123', '2025-03-15'),
    ('Lucas', 'Fernández', 'lucas.fernandez@hotmail.com', 'Lucas123', '2024-05-02'),
    ('Valentina', 'Pereyra', 'valentina.pereyra@gmail.com', 'Valentina123', '2026-03-10'),
    ('Santiago', 'Ramírez', 'santiago.ramirez@yahoo.com', 'Santiago123', GETDATE()),
    ('Camila', 'Torres', 'camila.torres@outlook.com', 'Camila123', '2026-08-20'),
    ('Mateo', 'Suárez', 'mateo.suarez@email.com', 'Mateo123', '2026-11-05');
GO
-- SELECT * FROM USUARIOS;


-- INSERTS PARA LA TABLA: BUTACAS

INSERT INTO BUTACAS (id_sala, fila, numero) VALUES
    (1, 'A', 1), -- id_butaca = 1 (Para Función 1 - Sala 1)
    (1, 'A', 2), -- id_butaca = 2 (Para Función 1 - Sala 1)
    (1, 'B', 5), -- id_butaca = 3 (Para Función 1 - Sala 1)
    (2, 'B', 6), -- id_butaca = 4 (Para Función 2 - Sala 2)
    (3, 'A', 3), -- id_butaca = 5 (Para Función 3 - Sala 3)
    (5, 'D', 12),-- id_butaca = 6 (Para Función 5 - Sala 5)
    (6, 'F', 4); -- id_butaca = 7 (Para Funcion 6 - Sala 6)
GO
-- SELECT * FROM BUTACAS;

-- Marcelo

-- INSERTS PARA LA TABLA: METODOS_PAGOS

INSERT INTO METODOS_PAGOS (nombre) VALUES
    ('Efectivo'),
    ('Tarjeta de débito'),
    ('Tarjeta de crédito'),
    ('Mercado Pago'),
    ('Transferencia bancaria');
GO
-- SELECT * FROM METODOS_PAGOS;

-- INSERTS PARA LA TABLA: RESERVAS

INSERT INTO RESERVAS (id_usuario, id_funcion, fecha_reserva, total_pagado, estado) VALUES
    (1, 1, '2026-05-10 12:00:00', 17000.00, 'Pagada'),
    (2, 1, '2026-05-11 15:30:00', 8500.00, 'Pagada'),
    (3, 3, '2026-05-12 18:00:00', NULL, 'Pendiente'),
    (4, 5, '2026-05-13 20:00:00', 10400.00, 'Pagada'),
    (5, 6, '2026-05-14 11:00:00', NULL, 'Cancelada');
GO
-- SELECT * FROM RESERVAS;

-- INSERTS PARA LA TABLA: PAGOS

INSERT INTO PAGOS (id_reserva, id_metodo_pago, fecha_pago, total_pagado, estado_pago) VALUES
    (1, 3, '2026-05-10 12:05:00', 17000.00, 'Aprobado'),
    (2, 4, '2026-05-11 15:35:00', 8500.00, 'Aprobado'),
    (4, 2, '2026-05-13 20:10:00', 10400.00, 'Aprobado');
GO
-- SELECT * FROM PAGOS;

-- Henry (Parte 2)

-- INSERTS PARA LA TABLA: DETALLES_RESERVAS

INSERT INTO DETALLES_RESERVAS 
    (id_reserva, id_butaca, precio_unitario) VALUES
    (1, 1, 4500.00), -- Reserva 1 (Función 1 - Sala 1) -> Usa Butaca 1 (Sala 1) 
    (1, 2, 4500.00), -- Reserva 1 (Función 1 - Sala 1) -> Usa Butaca 2 (Sala 1)
    (2, 3, 4500.00), -- Reserva 2 (Función 1 - Sala 1) -> Usa Butaca 3 (Sala 1)
    (3, 5, 2800.00), -- Reserva 3 (Función 3 - Sala 3) -> Usa Butaca 5 (Sala 3)
    (4, 6, 2500.00), -- Reserva 4 (Función 5 - Sala 5) -> Usa Butaca 6 (Sala 5)
    (5, 7, 3500.00); -- Reserva 5 (Función 6 - Sala 6) -> Usa Butaca 7 (Sala 6)
GO
-- SELECT * FROM DETALLES_RESERVAS;

PRINT 'Todos los registros de la Base de datos BD2_TPI_G19 fueron insertados correctamente.';
GO