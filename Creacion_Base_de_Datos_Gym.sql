-- ============================================
-- Proyecto 1 - Base de Datos Gimnasio
-- Autor: Zavala Gonzalo
-- ============================================

--   Creamos la base de datos
CREATE DATABASE IF NOT EXISTS gimnasio_db;
USE gimnasio_db;

--   Creamos las tablas   --
-- =========================
-- TABLA: Socio
-- =========================
CREATE TABLE Socio (
    id_socio INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_alta DATE NOT NULL,
    estado ENUM('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
    PRIMARY KEY (id_socio),
    UNIQUE (email)
);

-- =========================
-- TABLA: Pago
-- =========================
CREATE TABLE Pago (
    id_pago INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    periodo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_pago),
    INDEX idx_pago_socio (id_socio),
    FOREIGN KEY (id_socio)
        REFERENCES Socio(id_socio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- TABLA: Asistencia
-- =========================
CREATE TABLE Asistencia (
    id_asistencia INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    fecha_asistencia DATE NOT NULL,
    PRIMARY KEY (id_asistencia),
    INDEX idx_asistencia_socio (id_socio),
    FOREIGN KEY (id_socio)
        REFERENCES Socio(id_socio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- TABLA: Grupo_Muscular
-- =========================
CREATE TABLE Grupo_Muscular (
    id_grupo INT AUTO_INCREMENT,
    nombre_grupo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_grupo),
    UNIQUE (nombre_grupo)
);

-- =========================
-- TABLA: Ejercicio
-- =========================
CREATE TABLE Ejercicio (
    id_ejercicio INT AUTO_INCREMENT,
    nombre_ejercicio VARCHAR(100) NOT NULL,
    id_grupo INT NOT NULL,
    PRIMARY KEY (id_ejercicio),
    INDEX idx_ejercicio_grupo (id_grupo),
    FOREIGN KEY (id_grupo)
        REFERENCES Grupo_Muscular(id_grupo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================
-- TABLA: Rutina
-- =========================
CREATE TABLE Rutina (
    id_rutina INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    PRIMARY KEY (id_rutina),
    INDEX idx_rutina_socio (id_socio),
    FOREIGN KEY (id_socio)
        REFERENCES Socio(id_socio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- TABLA: Rutina_Ejercicio
-- =========================
CREATE TABLE Rutina_Ejercicio (
    id_rutina INT NOT NULL,
    id_ejercicio INT NOT NULL,
    PRIMARY KEY (id_rutina, id_ejercicio),
    INDEX idx_rej_ejercicio (id_ejercicio),
    FOREIGN KEY (id_rutina)
        REFERENCES Rutina(id_rutina)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_ejercicio)
        REFERENCES Ejercicio(id_ejercicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

