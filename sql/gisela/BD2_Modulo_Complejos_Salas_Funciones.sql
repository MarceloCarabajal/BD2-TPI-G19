/* BD2 - TPI Plataforma de Reservas de Entradas de Cine
    Módulo: Complejos, Salas y Funciones
    Responsable: Gisela Lanzillotta

    Objetivo:
    Crear las tablas correspondientes a la infraestructura física y los horarios de las funciones.
*/


------------------------------------------------------------
-- Tabla: Complejos
------------------------------------------------------------
CREATE TABLE Complejos (
    id_complejo INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NULL,

    CONSTRAINT PK_Complejos PRIMARY KEY (id_complejo)
);
GO

------------------------------------------------------------
-- Tabla: Salas
------------------------------------------------------------
CREATE TABLE Salas (
    id_sala INT IDENTITY(1,1) NOT NULL,
    id_complejo INT NOT NULL,
    nombre_sala VARCHAR(50) NOT NULL,
    capacidad_total INT NOT NULL,
    tipo_sala VARCHAR(10) NOT NULL,

    CONSTRAINT PK_Salas PRIMARY KEY (id_sala),
    CONSTRAINT FK_Salas_Complejos FOREIGN KEY (id_complejo) REFERENCES Complejos(id_complejo),
    CONSTRAINT CK_Salas_TipoSala CHECK (tipo_sala IN ('2D', '3D', 'IMAX'))
);
GO

------------------------------------------------------------
-- Tabla: Funciones
------------------------------------------------------------
CREATE TABLE Funciones (
    id_funcion INT IDENTITY(1,1) NOT NULL,
    id_pelicula INT NOT NULL, 
    id_sala INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    precio_base DECIMAL(10, 2) NOT NULL,

    CONSTRAINT PK_Funciones PRIMARY KEY (id_funcion),
    CONSTRAINT FK_Funciones_Salas FOREIGN KEY (id_sala) REFERENCES Salas(id_sala),
    CONSTRAINT FK_Funciones_Peliculas FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula),
    CONSTRAINT CK_Funciones_PrecioBase CHECK (precio_base > 0),
    CONSTRAINT CK_Funciones_FechaHora CHECK (fecha_hora > GETDATE())
);
GO






