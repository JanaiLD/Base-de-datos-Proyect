-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS playlist_db;
USE playlist_db;

-- Crear la tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear la tabla de canciones
CREATE TABLE IF NOT EXISTS canciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    artista VARCHAR(255) NOT NULL,
    album VARCHAR(255),
    duracion TIME,
    genero VARCHAR(100),
    fecha_lanzamiento DATE,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear la tabla de playlists
CREATE TABLE IF NOT EXISTS playlists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear la tabla de relaciones playlist-cancion
CREATE TABLE IF NOT EXISTS playlist_canciones (
    playlist_id INT,
    cancion_id INT,
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (cancion_id) REFERENCES canciones(id),
    PRIMARY KEY (playlist_id, cancion_id)
);

-- Crear la tabla de etiquetas de canciones
CREATE TABLE IF NOT EXISTS etiquetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Crear la tabla de relaciones cancion-etiqueta
CREATE TABLE IF NOT EXISTS cancion_etiquetas (
    cancion_id INT,
    etiqueta_id INT,
    FOREIGN KEY (cancion_id) REFERENCES canciones(id),
    FOREIGN KEY (etiqueta_id) REFERENCES etiquetas(id),
    PRIMARY KEY (cancion_id, etiqueta_id)
);

-- Crear la tabla para almacenar configuraciones personalizadas de ordenamiento
CREATE TABLE IF NOT EXISTS configuraciones_ordenamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear la tabla para almacenar las reglas de cada configuración de ordenamiento
CREATE TABLE IF NOT EXISTS reglas_ordenamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    configuracion_id INT,
    criterio VARCHAR(255) NOT NULL,
    orden VARCHAR(4) CHECK (orden IN ('ASC', 'DESC')),
    FOREIGN KEY (configuracion_id) REFERENCES configuraciones_ordenamiento(id)
);
