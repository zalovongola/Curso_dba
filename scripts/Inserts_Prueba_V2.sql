USE gimnasio_db;

-- Datos para probar Funciones y Vistas de Ejercicios
INSERT INTO Grupo_Muscular (nombre_grupo) VALUES ('Pecho'), ('Piernas');
INSERT INTO Ejercicio (nombre_ejercicio, id_grupo) VALUES ('Press Banca', 1), ('Sentadilla', 2);

-- Datos para probar el Stored Procedure
CALL sp_registrar_socio_con_pago('Gonzalo', 'Zavala', 'gzavala@test.com', 5000.00, 'Marzo 2026');

-- Datos para generar historial en Vistas
INSERT INTO Asistencia (id_socio, fecha_asistencia) VALUES (1, CURDATE());
INSERT INTO Pago (id_socio, fecha_pago, monto, periodo) VALUES (1, CURDATE(), 4500.00, 'Abril 2026');