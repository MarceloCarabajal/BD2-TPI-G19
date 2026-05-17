/*
    BD2 - TPI Grupo 19
    Script unificado de creación de base de datos y tablas.
    Base de datos: BD2_TPI_G19

*/

IF DB_ID(N'BD2_TPI_G19') IS NOT NULL
BEGIN
    ALTER DATABASE BD2_TPI_G19 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BD2_TPI_G19;
END
GO

CREATE DATABASE BD2_TPI_G19
    COLLATE Latin1_General_CI_AI;
GO

USE BD2_TPI_G19;
GO

SET DATEFORMAT ymd;
GO

-- gaston

CREATE TABLE CLASIFICACIONES (
    id_clasificacion INT NOT NULL IDENTITY(1, 1),
    descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CLASIFICACIONES PRIMARY KEY (id_clasificacion)
);
GO

CREATE TABLE GENEROS (
    id_genero INT NOT NULL IDENTITY(1, 1),
    descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_GENEROS PRIMARY KEY (id_genero)
);
GO

CREATE TABLE PELICULAS (
    id_pelicula INT NOT NULL IDENTITY(1, 1),
    id_clasificacion INT NOT NULL,
    id_genero INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    sinopsis VARCHAR(1000) NULL,
    duracion_minutos INT NULL,
    CONSTRAINT PK_PELICULAS PRIMARY KEY (id_pelicula),
    CONSTRAINT FK_PELICULAS_CLASIFICACION
        FOREIGN KEY (id_clasificacion) REFERENCES CLASIFICACIONES (id_clasificacion),
    CONSTRAINT FK_PELICULAS_GENERO
        FOREIGN KEY (id_genero) REFERENCES GENEROS (id_genero)
);
GO

-- gisela

CREATE TABLE Complejos (
    id_complejo INT NOT NULL IDENTITY(1, 1),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NULL,
    CONSTRAINT PK_Complejos PRIMARY KEY (id_complejo)
);
GO

CREATE TABLE Salas (
    id_sala INT NOT NULL IDENTITY(1, 1),
    id_complejo INT NOT NULL,
    nombre_sala VARCHAR(50) NOT NULL,
    capacidad_total INT NOT NULL,
    tipo_sala VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Salas PRIMARY KEY (id_sala),
    CONSTRAINT FK_Salas_Complejos
        FOREIGN KEY (id_complejo) REFERENCES Complejos (id_complejo),
    CONSTRAINT CK_Salas_TipoSala CHECK (tipo_sala IN ('2D', '3D', 'IMAX')),
    CONSTRAINT CK_Salas_Capacidad CHECK (capacidad_total > 0)
);
GO

CREATE TABLE Funciones (
    id_funcion INT NOT NULL IDENTITY(1, 1),
    id_pelicula INT NOT NULL,
    id_sala INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    precio_base DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Funciones PRIMARY KEY (id_funcion),
    CONSTRAINT FK_Funciones_Salas
        FOREIGN KEY (id_sala) REFERENCES Salas (id_sala),
    CONSTRAINT FK_Funciones_Peliculas
        FOREIGN KEY (id_pelicula) REFERENCES PELICULAS (id_pelicula),
    CONSTRAINT CK_Funciones_PrecioBase CHECK (precio_base > 0),
    CONSTRAINT CK_Funciones_FechaHora CHECK (fecha_hora > GETDATE())
);
GO

-- ========== Henry (parte 1) ==========

CREATE TABLE USUARIOS (
    id_usuario INT NOT NULL IDENTITY(1, 1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_USUARIOS PRIMARY KEY (id_usuario),
    CONSTRAINT UQ_USUARIOS_Email UNIQUE (email)
);
GO

CREATE TABLE BUTACAS (
    id_butaca INT NOT NULL IDENTITY(1, 1),
    id_sala INT NOT NULL,
    fila VARCHAR(1) NOT NULL,
    numero TINYINT NOT NULL,
    CONSTRAINT PK_BUTACAS PRIMARY KEY (id_butaca),
    CONSTRAINT FK_BUTACAS_SALAS FOREIGN KEY (id_sala) REFERENCES Salas (id_sala),
    CONSTRAINT CK_BUTACAS_Numero CHECK (numero >= 1),
    CONSTRAINT UQ_BUTACAS_SalaFilaNumero UNIQUE (id_sala, fila, numero)
);
GO

-- marcelo

CREATE TABLE Metodos_Pagos (
    id_metodo_pago INT NOT NULL IDENTITY(1, 1),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Metodos_Pagos PRIMARY KEY (id_metodo_pago),
    CONSTRAINT UQ_Metodos_Pagos_Nombre UNIQUE (nombre)
);
GO

CREATE TABLE Reservas (
    id_reserva INT NOT NULL IDENTITY(1, 1),
    id_usuario INT NOT NULL,
    id_funcion INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT GETDATE(),
    total_pagado DECIMAL(10, 2) NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT PK_Reservas PRIMARY KEY (id_reserva),
    CONSTRAINT FK_Reservas_Usuarios FOREIGN KEY (id_usuario) REFERENCES USUARIOS (id_usuario),
    CONSTRAINT FK_Reservas_Funciones FOREIGN KEY (id_funcion) REFERENCES Funciones (id_funcion),
    CONSTRAINT CK_Reservas_Estado CHECK (estado IN ('Pendiente', 'Pagada', 'Cancelada')),
    CONSTRAINT CK_Reservas_TotalPagado CHECK (total_pagado IS NULL OR total_pagado >= 0)
);
GO

CREATE TABLE Pagos (
    id_pago INT NOT NULL IDENTITY(1, 1),
    id_reserva INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT GETDATE(),
    total_pagado DECIMAL(10, 2) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT PK_Pagos PRIMARY KEY (id_pago),
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY (id_reserva) REFERENCES Reservas (id_reserva),
    CONSTRAINT FK_Pagos_Metodos_Pagos FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pagos (id_metodo_pago),
    CONSTRAINT UQ_Pagos_Reserva UNIQUE (id_reserva),
    CONSTRAINT CK_Pagos_TotalPagado CHECK (total_pagado > 0),
    CONSTRAINT CK_Pagos_Estado CHECK (estado_pago IN ('Pendiente', 'Aprobado', 'Rechazado', 'Devuelto'))
);
GO

-- henry (parte 2)

CREATE TABLE DETALLE_RESERVA (
    id_detalle INT NOT NULL IDENTITY(1, 1),
    id_reserva INT NOT NULL,
    id_butaca INT NOT NULL,
    id_funcion INT NOT NULL,
    precio_unitario MONEY NOT NULL,
    CONSTRAINT PK_DETALLE_RESERVA PRIMARY KEY (id_detalle),
    CONSTRAINT FK_DETALLE_RESERVA_RESERVAS FOREIGN KEY (id_reserva) REFERENCES Reservas (id_reserva),
    CONSTRAINT FK_DETALLE_RESERVA_BUTACAS FOREIGN KEY (id_butaca) REFERENCES BUTACAS (id_butaca),
    CONSTRAINT FK_DETALLE_RESERVA_FUNCIONES FOREIGN KEY (id_funcion) REFERENCES Funciones (id_funcion),
    CONSTRAINT CK_DETALLE_RESERVA_Precio CHECK (precio_unitario >= 0),
    CONSTRAINT UQ_DETALLE_RESERVA_FuncionButaca UNIQUE (id_funcion, id_butaca)
);
GO

PRINT 'Base de datos BD2_TPI_G19 creada correctamente.';
GO