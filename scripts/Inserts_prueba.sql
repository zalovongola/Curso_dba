-- ============================================
-- Inserts iniciales
-- ============================================

USE gimnasio_db;

-- Socios
INSERT INTO Socio (nombre, apellido, email, fecha_alta)
VALUES 
('Juan', 'Perez', 'juan@email.com', '2025-01-01'),
('Maria', 'Lopez', 'maria@email.com', '2025-02-01');

-- Grupos musculares
INSERT INTO Grupo_Muscular (nombre_grupo)
VALUES ('Pecho'), ('Espalda'), ('Piernas');

-- Ejercicios
INSERT INTO Ejercicio (nombre_ejercicio, id_grupo)
VALUES 
('Press Banca', 1),
('Dominadas', 2),
('Sentadilla', 3);

-- Pagos
INSERT INTO Pago (id_socio, fecha_pago, monto, periodo)
VALUES
(1, '2025-01-05', 15000.00, 'Enero'),
(2, '2025-02-05', 15000.00, 'Febrero');

-- Asistencias
INSERT INTO Asistencia (id_socio, fecha_asistencia)
VALUES
(1, '2025-01-10'),
(1, '2025-01-12'),
(2, '2025-02-10');

-- Rutina
INSERT INTO Rutina (id_socio, fecha_creacion)
VALUES (1, '2025-01-15');

-- Rutina_Ejercicio
INSERT INTO Rutina_Ejercicio (id_rutina, id_ejercicio)
VALUES
(1,1),
(1,2);

