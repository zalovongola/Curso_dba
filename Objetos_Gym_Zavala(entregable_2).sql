USE gimnasio_db;

-- 1. VISTAS
CREATE OR REPLACE VIEW vista_detalle_asistencia AS
SELECT s.nombre, s.apellido, a.fecha_asistencia FROM Socio s
JOIN Asistencia a ON s.id_socio = a.id_socio;

CREATE OR REPLACE VIEW vista_resumen_pagos AS
SELECT s.nombre, s.apellido, SUM(p.monto) AS total, COUNT(p.id_pago) AS cant
FROM Socio s JOIN Pago p ON s.id_socio = p.id_socio GROUP BY s.id_socio;

-- 2. FUNCIONES
DELIMITER //
CREATE FUNCTION fn_nombre_grupo_muscular(p_id_ejercicio INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE v_nombre VARCHAR(50);
    SELECT gm.nombre_grupo INTO v_nombre FROM Grupo_Muscular gm
    JOIN Ejercicio e ON gm.id_grupo = e.id_grupo WHERE e.id_ejercicio = p_id_ejercicio;
    RETURN v_nombre;
END //

CREATE FUNCTION fn_asistencias_mes(p_id_socio INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_total INT;
    SELECT COUNT(*) INTO v_total FROM Asistencia
    WHERE id_socio = p_id_socio AND MONTH(fecha_asistencia) = MONTH(CURDATE());
    RETURN v_total;
END //
DELIMITER ;

-- 3. STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE sp_registrar_socio_con_pago(IN p_nom VARCHAR(50), IN p_ape VARCHAR(50), IN p_mail VARCHAR(100), IN p_monto DECIMAL(10,2), IN p_per VARCHAR(20))
BEGIN
    INSERT INTO Socio (nombre, apellido, email, fecha_alta) VALUES (p_nom, p_ape, p_mail, CURDATE());
    INSERT INTO Pago (id_socio, fecha_pago, monto, periodo) VALUES (LAST_INSERT_ID(), CURDATE(), p_monto, p_per);
END //
DELIMITER ;

-- 4. TRIGGERS
CREATE TABLE IF NOT EXISTS Log_Estado_Socio (id_log INT AUTO_INCREMENT PRIMARY KEY, id_socio INT, estado_ant VARCHAR(20), estado_nue VARCHAR(20), fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TRIGGER tr_auditoria_estado_socio BEFORE UPDATE ON Socio FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO Log_Estado_Socio (id_socio, estado_ant, estado_nue) VALUES (OLD.id_socio, OLD.estado, NEW.estado);
    END IF;
END //
DELIMITER ;