/*
    BD2 - TPI Plataforma de Reservas de Entradas de Cine
    Módulo: Reservas, Pagos y Métodos_Pago
    Responsable: Marcelo Carabajal

    Objetivo:
    Crear las tablas correspondientes al flujo de reservas y pagos.

    Tablas del módulo:
    - Reservas
    - Metodos_Pagos
    - Pagos

*/

------------------------------------------------------------
-- Tabla: Reservas
------------------------------------------------------------
CREATE DATABASE TICKETERA_CINES
Collate Latin1_General_CI_AI
GO

USE TICKETERA_CINES;
GO

CREATE TABLE Reservas
(
    id_reserva INT IDENTITY(1,1) NOT NULL,
    id_usuario INT NOT NULL,
    id_funcion INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT GETDATE(),
    total_pagado DECIMAL(10,2) NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',

    CONSTRAINT PK_Reservas PRIMARY KEY (id_reserva),

    CONSTRAINT FK_Reservas_Usuarios
        FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),

    CONSTRAINT FK_Reservas_Funciones
        FOREIGN KEY (id_funcion) REFERENCES Funciones(id_funcion),

    CONSTRAINT CK_Reservas_Estado
        CHECK (estado IN ('Pendiente', 'Pagada', 'Cancelada')),

    CONSTRAINT CK_Reservas_TotalPagado
        CHECK (total_pagado IS NULL OR total_pagado >= 0)
);
GO


------------------------------------------------------------
-- Tabla: Metodos_Pagos
------------------------------------------------------------

CREATE TABLE Metodos_Pagos
(
    id_metodo_pago INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,

    CONSTRAINT PK_Metodos_Pagos PRIMARY KEY (id_metodo_pago),

    CONSTRAINT UQ_Metodos_Pagos_Nombre
        UNIQUE (nombre)
);
GO


------------------------------------------------------------
-- Tabla: Pagos
------------------------------------------------------------

CREATE TABLE Pagos
(
    id_pago INT IDENTITY(1,1) NOT NULL,
    id_reserva INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT GETDATE(),
    total_pagado DECIMAL(10,2) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'Pendiente',

    CONSTRAINT PK_Pagos PRIMARY KEY (id_pago),

    CONSTRAINT FK_Pagos_Reservas
        FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva),

    CONSTRAINT FK_Pagos_Metodos_Pagos
        FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pagos(id_metodo_pago),

    CONSTRAINT UQ_Pagos_Reserva
        UNIQUE (id_reserva),

    CONSTRAINT CK_Pagos_TotalPagado
        CHECK (total_pagado > 0),

    CONSTRAINT CK_Pagos_Estado
        CHECK (estado_pago IN ('Pendiente', 'Aprobado', 'Rechazado', 'Devuelto'))
);
GO


------------------------------------------------------------
-- Datos iniciales: Metodos_Pagos
------------------------------------------------------------

INSERT INTO Metodos_Pagos (nombre)
VALUES
('Efectivo'),
('Tarjeta de credito'),
('Tarjeta de debito'),
('Mercado Pago'),
('Transferencia');
GO

-- Listar métodos de pago disponibles.
SELECT 
    id_metodo_pago,
    nombre
FROM Metodos_Pagos;
GO



------------------------------------------------------------
-- Ejemplo de inserts de prueba
-- Descomentar cuando ya existan Usuarios y Funciones.
------------------------------------------------------------

/*
INSERT INTO Reservas (id_usuario, id_funcion, fecha_reserva, total_pagado, estado)
VALUES (1, 1, GETDATE(), NULL, 'Pendiente');
GO

INSERT INTO Pagos (id_reserva, id_metodo_pago, fecha_pago, total_pagado, estado_pago)
VALUES (1, 1, GETDATE(), 5000.00, 'Aprobado');
GO

UPDATE Reservas
SET estado = 'Pagada',
    total_pagado = 5000.00
WHERE id_reserva = 1;
GO
*/
