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

-- =========================
-- TABLA: Membresia 
-- =========================

CREATE TABLE Membresia (
    id_membresia INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado ENUM('ACTIVA','VENCIDA'),
    FOREIGN KEY (id_socio) REFERENCES Socio(id_socio)
);

-- =========================
-- TABLA: Plan 
-- =========================

CREATE TABLE Plan (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2)
);

-- =========================
-- TABLA: Pago_Detalle 
-- =========================

CREATE TABLE Pago_Detalle (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pago INT,
    id_plan INT,
    FOREIGN KEY (id_pago) REFERENCES Pago(id_pago),
    FOREIGN KEY (id_plan) REFERENCES Plan(id_plan)
);

-- =========================
-- TABLA: Entrenador 
-- =========================
CREATE TABLE Entrenador (
    id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

-- =========================
-- TABLA: Rutina_entrenador_socio
-- =========================
CREATE TABLE Rutina_Entrenador (
    id_rutina INT,
    id_socio INT,
    id_entrenador INT,
    PRIMARY KEY (id_rutina, id_socio, id_entrenador),
    FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina),
    FOREIGN KEY (id_socio) REFERENCES Socio(id_socio),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador)
);

-- =========================
-- TABLA: Objetivo 
-- =========================
CREATE TABLE Objetivo (
    id_objetivo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100)
);

-- =========================
-- TABLA: Socio_Objetivo 
-- =========================
CREATE TABLE Socio_Objetivo (
    id_socio INT,
    id_objetivo INT,
    PRIMARY KEY (id_socio, id_objetivo),
    FOREIGN KEY (id_socio) REFERENCES Socio(id_socio),
    FOREIGN KEY (id_objetivo) REFERENCES Objetivo(id_objetivo)
);

-- =========================
-- TABLA: fact_pagos 
-- =========================
CREATE TABLE fact_pagos (
    id_fact INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT,
    fecha_pago DATE,
    monto DECIMAL(10,2),
    periodo VARCHAR(20)
);