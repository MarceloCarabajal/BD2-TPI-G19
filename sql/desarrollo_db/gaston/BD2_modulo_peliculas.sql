-- 1. Tabla  Clasificaciones 
CREATE TABLE CLASIFICACIONES (
    id_clasificacion INT PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(50) NOT NULL
);

-- 2. Tabla  Géneros 
CREATE TABLE GENEROS (
    id_genero INT PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(50) NOT NULL
);

-- 3. Tabla Películas 
CREATE TABLE PELICULAS (
    id_pelicula INT PRIMARY KEY IDENTITY(1,1),
    id_clasificacion INT NOT NULL,
    id_genero INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    sinopsis VARCHAR (1000),
    duracion_minutos INT,
    CONSTRAINT FK_Peliculas_Clasificacion 
        FOREIGN KEY (id_clasificacion) REFERENCES CLASIFICACIONES(id_clasificacion),
    CONSTRAINT FK_Peliculas_Genero 
        FOREIGN KEY (id_genero) REFERENCES GENEROS(id_genero)
);