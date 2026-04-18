USE gimnasio_db;

-- ============================================
-- DATOS BASE
-- ============================================

INSERT INTO Grupo_Muscular (nombre_grupo) 
VALUES ('Pecho'), ('Piernas');

SET @id_pecho = (SELECT id_grupo FROM Grupo_Muscular WHERE nombre_grupo = 'Pecho' LIMIT 1);
SET @id_piernas = (SELECT id_grupo FROM Grupo_Muscular WHERE nombre_grupo = 'Piernas' LIMIT 1);

INSERT INTO Ejercicio (nombre_ejercicio, id_grupo) 
VALUES ('Press Banca', @id_pecho), ('Sentadilla', @id_piernas);

-- ============================================
-- CREAR SOCIO + PAGO
-- ============================================

CALL sp_registrar_socio_con_pago(
    'Gonzalo', 
    'Zavala', 
    'gzavala@test.com', 
    5000.00, 
    'Marzo 2026'
);

SET @id_socio = LAST_INSERT_ID();

-- ============================================
-- GENERAR ACTIVIDAD
-- ============================================

INSERT INTO Asistencia (id_socio, fecha_asistencia) 
VALUES (@id_socio, CURDATE());

INSERT INTO Pago (id_socio, fecha_pago, monto, periodo) 
VALUES (@id_socio, CURDATE(), 4500.00, 'Abril 2026');

-- ============================================
-- PRUEBAS
-- ============================================

SELECT * FROM vista_ingresos_mensuales;
SELECT * FROM vista_top_socios;
SELECT * FROM vista_asistencia_por_socio;

SELECT fn_asistencias_mes(@id_socio);
SELECT fn_nombre_grupo_muscular(1);