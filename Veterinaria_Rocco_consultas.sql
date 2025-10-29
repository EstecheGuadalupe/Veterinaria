USE Veterinaria_Rocco;

-- -----------------------------------------------------
-- Consultas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Listar las mascotas con sus respectivos dueños
-- -----------------------------------------------------
SELECT mascota.nombre AS nombre_mascota, dueño.nombre AS nombre_dueño
FROM mascota
JOIN dueño_has_mascota ON dueño_has_mascota.mascota_id_mascota = mascota.id_mascota
JOIN dueño ON dueño_has_mascota.dueño_id_dueño = dueño.id_dueño
ORDER BY mascota.nombre;

-- -----------------------------------------------------
-- Historial de consultas de una mascota especifica (fecha, motivo de la consulta, veterinario que lo antendió)
-- -----------------------------------------------------
SELECT mascota.nombre, CONCAT(turno.dia, ' ', turno.fecha_turno) AS fecha, consulta.motivo_realizacion, profesional.nombre
FROM mascota
JOIN turno ON turno.mascota_id_mascota = mascota.id_mascota
JOIN consulta ON consulta.turno_id_turno = turno.id_turno
JOIN profesional ON profesional.id_profesional = turno.profesional_id_profesional
WHERE mascota.nombre = 'Coco';

-- -----------------------------------------------------
-- Promedio de mascotas atendidos en un mes 
-- -----------------------------------------------------
SELECT CAST(AVG(cantidad_mascotas) AS UNSIGNED) AS promedio_mascotas_mes
FROM (
  SELECT COUNT(DISTINCT mascota.id_mascota) AS cantidad_mascotas, 
         MONTH(turno.dia) AS mes, 
         YEAR(turno.dia) AS año
  FROM consulta 
  INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
  INNER JOIN mascota ON turno.mascota_id_mascota = mascota.id_mascota
  WHERE consulta.asistencia = 1  -- Se considera solo las mascotas que fueron a su turno
  GROUP BY mes, año
) AS mascotas_por_mes;

-- -----------------------------------------------------
-- Total de turnos por fecha especifica y cuantos turnos han sido asistidos
-- -----------------------------------------------------
SELECT COUNT(*) AS total_turnos, SUM(consulta.asistencia) AS turnos_asistidos
FROM consulta
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
WHERE turno.fecha_turno = '2024-08-03';  -- Podemos poner cualquier fecha para consultar

-- -----------------------------------------------------
-- Cantidad de mascotas atendidas por mes
-- -----------------------------------------------------
SELECT MONTH(turno.fecha_turno) AS mes, COUNT(DISTINCT mascota.id_mascota) AS cantidad_mascotas 
FROM consulta
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
INNER JOIN mascota ON turno.mascota_id_mascota = mascota.id_mascota
WHERE consulta.asistencia = 1
GROUP BY mes;  

-- -----------------------------------------------------
-- Mascotas con cuenta corriente
-- -----------------------------------------------------
SELECT mascota.nombre AS nombre_mascota, dueño.nombre AS nombre_dueño, turno.fecha_turno AS fecha_turno, pago.monto AS Monto_a_pagar
FROM consulta 
INNER JOIN turno  ON consulta.turno_id_turno = turno.id_turno
INNER JOIN mascota  ON turno.mascota_id_mascota = mascota.id_mascota
INNER JOIN dueño_has_mascota ON dueño_has_mascota.mascota_id_mascota = mascota.id_mascota
INNER JOIN dueño  ON dueño_has_mascota.dueño_id_dueño = dueño.id_dueño
LEFT JOIN pago ON consulta.id_consulta = pago.consulta_id_consulta
WHERE pago.medio_pago = 'cuenta corriente'
ORDER BY nombre_mascota;


-- -----------------------------------------------------
-- Total de gastos por tipo de medio de pago
-- -----------------------------------------------------
SELECT medio_pago, SUM(monto) AS total_monto
FROM pago
WHERE activo = 1 -- Considera solo los pagos activos
GROUP BY medio_pago
ORDER BY total_monto DESC;

-- -----------------------------------------------------
-- Listar los veterinarios que han atendido a más de una cierta cantidad de mascotas
-- -----------------------------------------------------
SELECT profesional.id_profesional, profesional.nombre
FROM profesional 
WHERE (SELECT COUNT(DISTINCT turno.mascota_id_mascota) 
FROM turno 
JOIN consulta  ON turno.id_turno = consulta.turno_id_turno
WHERE turno.profesional_id_profesional = profesional.id_profesional AND consulta.asistencia = 1) > 1 -- Aca podemos cambiar a cualquier valor para consultar
ORDER BY profesional.nombre;

-- -----------------------------------------------------
-- Vistas
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Listar las mascotas con sus respectivos dueños
-- -----------------------------------------------------
CREATE VIEW vista_mascotas_y_dueños AS
SELECT mascota.nombre AS nombre_mascota, dueño.nombre AS nombre_dueño
FROM mascota
JOIN dueño_has_mascota ON dueño_has_mascota.mascota_id_mascota = mascota.id_mascota
JOIN dueño ON dueño_has_mascota.dueño_id_dueño = dueño.id_dueño
ORDER BY mascota.nombre;

SELECT * FROM vista_mascotas_y_dueños;

-- -----------------------------------------------------
-- Historial de consultas de una mascota especifica (fecha, motivo de la consulta, veterinario que lo antendió)
-- -----------------------------------------------------
CREATE VIEW vista_consultas_mascotas AS
SELECT mascota.nombre, CONCAT(turno.dia, ' ', turno.fecha_turno) AS fecha, consulta.motivo_realizacion, profesional.nombre AS nombre_profesional
FROM mascota
JOIN turno ON turno.mascota_id_mascota = mascota.id_mascota
JOIN consulta ON consulta.turno_id_turno = turno.id_turno
JOIN profesional ON profesional.id_profesional = turno.profesional_id_profesional;

SELECT * FROM vista_consultas_mascotas
WHERE nombre = 'Oreo';

-- -----------------------------------------------------
-- Mascotas con cuenta corriente
-- -----------------------------------------------------
CREATE VIEW vista_mascotas_pagos AS
SELECT mascota.nombre AS nombre_mascota, 
       dueño.nombre AS nombre_dueño, 
       turno.fecha_turno AS fecha_turno, 
       pago.monto AS monto_a_pagar,
       pago.medio_pago
FROM consulta 
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
INNER JOIN mascota ON turno.mascota_id_mascota = mascota.id_mascota
INNER JOIN dueño_has_mascota ON dueño_has_mascota.mascota_id_mascota = mascota.id_mascota
INNER JOIN dueño ON dueño_has_mascota.dueño_id_dueño = dueño.id_dueño
LEFT JOIN pago ON consulta.id_consulta = pago.consulta_id_consulta;

SELECT nombre_mascota, nombre_dueño, fecha_turno, monto_a_pagar
FROM vista_mascotas_pagos
WHERE medio_pago = 'cuenta corriente';

-- -----------------------------------------------------
-- Indices
-- -----------------------------------------------------

/*5.1*/
CREATE INDEX idx_mascota_nombre ON mascota(nombre);

/*5.2*/
CREATE INDEX idx_turno_fecha_id ON turno(fecha_turno, id_turno);

/*5.3*/
CREATE INDEX idx_pago_medio ON pago(medio_pago);

/*5.4*/
CREATE INDEX idx_consulta_asistencia ON consulta(asistencia);

/*5.5*/
CREATE INDEX idx_profesional_id_mascota ON turno(profesional_id_profesional, mascota_id_mascota);
