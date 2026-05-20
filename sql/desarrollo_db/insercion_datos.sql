USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO

-- Gaston
-- Gisela
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