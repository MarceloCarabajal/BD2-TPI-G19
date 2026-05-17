-- IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TICKETERA_CINES') BEGIN
--     USE master
-- 
--     -- Force disconnect all users from the database
--     ALTER DATABASE TICKETERA_CINES
--     SET SINGLE_USER
--     WITH ROLLBACK IMMEDIATE;
-- 
--     DROP DATABASE TICKETERA_CINES
-- END;
-- 
-- CREATE DATABASE TICKETERA_CINES;
-- GO

USE TICKETERA_CINES;
GO

SET DATEFORMAT 'YMD';
GO

CREATE TABLE USUARIOS(
 id_usuario INT NOT NULL IDENTITY(1, 1),
 nombre VARCHAR(100) NOT NULL,
 apellido VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL,
 password VARCHAR(100) NOT NULL,
 fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT PK_USUARIOS PRIMARY KEY (id_usuario)
);
GO

CREATE TABLE BUTACAS(
 id_butaca INT NOT NULL IDENTITY(1, 1),
 id_sala INT NOT NULL,
 fila VARCHAR(1) NOT NULL,
 numero TINYINT NOT NULL CHECK(numero >= 1),
 CONSTRAINT PK_BUTACAS PRIMARY KEY (id_butaca),
 CONSTRAINT FK_BUTACAS_SALAS
        FOREIGN KEY (id_sala)
        REFERENCES SALAS(id_sala)
);
GO

CREATE TABLE DETALLE_RESERVA(
 id_detalle INT NOT NULL IDENTITY(1, 1),
 id_reserva INT NOT NULL,
 id_butaca INT NOT NULL,
 id_funcion INT NOT NULL,
 precio_unitario MONEY NOT NULL CHECK(precio_unitario >= 0),
 CONSTRAINT PK_DETALLE_RESERVA PRIMARY KEY (id_detalle),
 CONSTRAINT FK_DETALLE_RESERVA_RESERVAS
        FOREIGN KEY (id_reserva)
        REFERENCES RESERVAS(id_reserva),
 CONSTRAINT FK_DETALLE_RESERVA_BUTACAS
        FOREIGN KEY (id_butaca)
        REFERENCES BUTACAS(id_butaca),
 CONSTRAINT FK_DETALLE_RESERVA_FUNCIONES
        FOREIGN KEY (id_funcion)
        REFERENCES FUNCIONES(id_funcion)
);


-- Comentar en la reunión del domingo 17/05/2026

-- 1. El precio_unitario de DETALLE_RESERVA podría ser del tipo money más que decimal(18, 4)
-- 2. Mencionar lo del DER que le falta una cardinalidad entre la tabla FUNCIONES y DETALLE_RESERVA para la FK de id_funcion
-- 3. Revisar si no es necesario incluir el id_usuario dentro de la tabla DETALLE_RESERVA