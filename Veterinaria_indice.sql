-- -----------------------------------------------------
-- Creación Base de Datos
-- -----------------------------------------------------
	CREATE DATABASE Veterinaria_Rocco;

	USE Veterinaria_Rocco;

-- -----------------------------------------------------
-- Tabla animal
-- -----------------------------------------------------

	CREATE TABLE animal (
  	id_animal INT NOT NULL,
  	tipo_animal VARCHAR(45) NOT NULL,
  	raza VARCHAR(45) NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	PRIMARY KEY (id_animal));
  
  -- -----------------------------------------------------
-- Tabla mascota
-- -----------------------------------------------------
	
	CREATE TABLE mascota (
  	id_mascota INT NOT NULL,
  	nombre VARCHAR(45) NOT NULL,
  	color VARCHAR(45) NOT NULL,
  	rasgo_identificatorio VARCHAR(45) NOT NULL,
  	codigo_chip_identificatorio INT, -- Si es null significa que no posee chip identificatorio
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	animal_id_animal INT NOT NULL,
  	PRIMARY KEY (id_mascota, animal_id_animal),
  	FOREIGN KEY (animal_id_animal) REFERENCES animal (id_animal));

-- -----------------------------------------------------
-- Tabla dueño
-- -----------------------------------------------------

	CREATE TABLE dueño (
  	id_dueño INT NOT NULL,
  	nombre VARCHAR(45) NOT NULL,
  	direccion VARCHAR(100) NOT NULL,
  	telefono VARCHAR(15) NOT NULL,
  	correo_electronico VARCHAR(100) NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	turno_id_turno INT NOT NULL,
  	PRIMARY KEY (id_dueño));
  
  -- -----------------------------------------------------
-- Tabla dueño has mascota
-- -----------------------------------------------------

	CREATE TABLE dueño_has_mascota (
  	id_dueño_has_mascota INT NOT NULL,
  	dueño_id_dueño INT NOT NULL,
  	mascota_id_mascota INT NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	PRIMARY KEY (id_dueño_has_mascota, dueño_id_dueño, mascota_id_mascota),
  	FOREIGN KEY (dueño_id_dueño) REFERENCES dueño (id_dueño),
  	FOREIGN KEY (mascota_id_mascota) REFERENCES mascota (id_mascota));
  
  -- -----------------------------------------------------
-- Tabla profesional
-- -----------------------------------------------------

	CREATE TABLE profesional (
  	id_profesional INT NOT NULL,
  	nombre VARCHAR(45) NOT NULL,
  	matricula VARCHAR(45) NOT NULL,
  	telefono VARCHAR(20) NOT NULL,
  	oficio VARCHAR(45) NOT NULL,
  	fecha_inicio DATE NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	analisis_id_analisis INT NOT NULL,
  	PRIMARY KEY (id_profesional));
  
  -- -----------------------------------------------------
-- Tabla turno
-- -----------------------------------------------------

	CREATE TABLE turno (
  	id_turno INT NOT NULL,
  	dia ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado') NOT NULL,
  	horario TIME NOT NULL,
  	fecha_turno DATE NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	mascota_id_mascota INT NOT NULL,
  	profesional_id_profesional INT NOT NULL,
    dueño_id_dueño INT NOT NULL,
  	PRIMARY KEY (id_turno, mascota_id_mascota, profesional_id_profesional, dueño_id_dueño),
  	FOREIGN KEY (mascota_id_mascota) REFERENCES mascota (id_mascota),
  	FOREIGN KEY (profesional_id_profesional) REFERENCES profesional (id_profesional),
    FOREIGN KEY (dueño_id_dueño) REFERENCES dueño (id_dueño));
  
  -- -----------------------------------------------------
-- Tabla consulta
-- -----------------------------------------------------

	CREATE TABLE consulta (
  	id_consulta INT NOT NULL,
  	motivo_realizacion VARCHAR(200) NOT NULL,
  	asistencia TINYINT NOT NULL, -- 0 no asistio, 1 asistio
 	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	turno_id_turno INT NOT NULL,
  	PRIMARY KEY (id_consulta, turno_id_turno),
  	FOREIGN KEY (turno_id_turno) REFERENCES turno (id_turno));
  
  -- -----------------------------------------------------
-- Table analisis
-- -----------------------------------------------------

	CREATE TABLE analisis (
  	id_analisis INT NOT NULL,
  	tipo VARCHAR(100) NOT NULL,
  	resultado VARCHAR(200) NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	consulta_id_consulta INT NOT NULL,
    profesional_id_profesional INT NOT NULL,
  	PRIMARY KEY (id_analisis, consulta_id_consulta),
    FOREIGN KEY (profesional_id_profesional) REFERENCES profesional (id_profesional),
  	FOREIGN KEY (consulta_id_consulta) REFERENCES consulta (id_consulta));
  
-- -----------------------------------------------------
-- Tabla receta
-- -----------------------------------------------------

	CREATE TABLE receta (
  	id_receta INT NOT NULL,
  	nombre_medicamento VARCHAR(45) NOT NULL,
  	indicaciones VARCHAR(250) NOT NULL,
  	dosis VARCHAR(150) NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	consulta_id_consulta INT NOT NULL,
  	PRIMARY KEY (id_receta, consulta_id_consulta),
  	FOREIGN KEY (consulta_id_consulta) REFERENCES consulta (id_consulta));
  
-- -----------------------------------------------------
-- Tabla pago 
-- -----------------------------------------------------
	
	CREATE TABLE pago (
  	id_pago INT NOT NULL,
  	monto DECIMAL NOT NULL,
  	medio_pago VARCHAR(45) NOT NULL,
  	fecha TIMESTAMP NOT NULL,
  	fecha_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	activo TINYINT NOT NULL DEFAULT 1,
  	consulta_id_consulta INT NOT NULL,
  	PRIMARY KEY (id_pago, consulta_id_consulta),
  	FOREIGN KEY (consulta_id_consulta) REFERENCES consulta (id_consulta));

-- -----------------------------------------------------	
-- Carga de Datos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Inserción tabla animal
-- -----------------------------------------------------
INSERT INTO animal (id_animal, tipo_animal, raza)
VALUES 
-- Perros
(1, 'Perro', 'Sin raza'),
(2, 'Perro', 'Beagle'),
(3, 'Perro', 'Border Collie'),
(4, 'Perro', 'Golden Retriever'),
(5, 'Perro', 'Salchicha'),
(6, 'Perro', 'Bichón Frisé'),
(7, 'Perro', 'Bóxer'),
(8, 'Perro', 'Caniche toy'),
(9, 'Perro', 'Chow chow'),
-- Gatos
(10, 'Gato', 'Sin raza'),
(11, 'Gato', 'Persa'),
(12, 'Gato', 'Maine Coon'),
(13, 'Gato', 'Sphynx'),
(14, 'Gato', 'Bengala'),
(15, 'Gato', 'Siamés'),
(16, 'Gato', 'Savannah'),
(17, 'Gato', 'British Shorthair'),
-- Pájaros
(18, 'Pájaro', 'Canario'),
(19, 'Pájaro', 'Periquito'),
(20, 'Pájaro', 'Cacatúa'),
(21, 'Pájaro', 'Agapornis'),
(22, 'Pájaro', 'Loro Gris Africano'),
(23, 'Pájaro', 'Pinzón'),
(24, 'Pájaro', 'Diamante Mandarín'),
-- Conejos
(25, 'Conejo', 'Holandés Enano'),
(26, 'Conejo', 'Cabeza de León'),
(27, 'Conejo', 'Rex'),
(28, 'Conejo', 'Lop'),
(29, 'Conejo', 'Angora'),
-- Cobayos
(30, 'Cobayo', 'Abisinio'),
(31, 'Cobayo', 'Americano'),
(32, 'Cobayo', 'Pelo Corto'),
(33, 'Cobayo', 'Peruano');

-- -----------------------------------------------------
-- Inserción tabla mascota
-- -----------------------------------------------------
INSERT INTO mascota (id_mascota, nombre, color, rasgo_identificatorio, codigo_chip_identificatorio, animal_id_animal)
VALUES 
(1, 'Max', 'Negro', 'Orejas caídas', 12345, 1),
(2, 'Bella', 'Blanco', 'Mancha en el ojo izquierdo', 09876, 2),
(3, 'Rocky', 'Marrón', 'Cola corta', 11223, 3),
(4, 'Luna', 'Dorado', 'Collar rojo', 22334, 4),
(5, 'Toby', 'Negro y marrón', 'Patas cortas', 33445, 5),
(6, 'Milo', 'Blanco', 'Orejas redondas', 44556, 6),
(7, 'Nala', 'Marrón claro', 'Hocico grande', 55667, 7),
(8, 'Coco', 'Gris', 'Pequeño y esponjoso', 66778, 8),
(9, 'Chico', 'Blanco y negro', 'Lengua fuera constantemente', 77889, 9),
(10, 'Simba', 'Gris oscuro', 'Bigotes largos', 88990, 10),
(11, 'Misty', 'Blanco', 'Pelo largo', 99001, 11),
(12, 'Shadow', 'Negro', 'Cola larga y esponjosa', 10012, 12),
(13, 'Sphinx', 'Rosa', 'Sin pelaje', 11023, 13),
(14, 'Leo', 'Moteado', 'Manchas naranjas', 12034, 14),
(15, 'Oreo', 'Blanco y negro', 'Orejas triangulares', 13045, 15),
(16, 'Savvy', 'Dorado', 'Ojos grandes', 14056, 16),
(17, 'Whiskers', 'Gris', 'Patas cortas', 15067, 17),
(18, 'Tweety', 'Amarillo', 'Canto fuerte', 16078, 18),
(19, 'Perry', 'Verde', 'Pico grande', 17089, 19),
(20, 'Coco', 'Blanco y amarillo', 'Cresta levantada', 18090, 20),
(21, 'Peach', 'Rosa', 'Alas cortas', 19001, 21),
(22, 'Gris', 'Gris oscuro', 'Plumaje brillante', 20012, 22),
(23, 'Zippy', 'Rojo', 'Pico pequeño', 21023, 23),
(24, 'Diamond', 'Blanco con manchas negras', 'Pico largo', 22034, 24),
(25, 'Bunny', 'Blanco', 'Orejas caídas', 23045, 25),
(26, 'Fluffy', 'Gris claro', 'Melena esponjosa', 24056, 26),
(27, 'Rexy', 'Marrón', 'Pelo rizado', 25067, 27),
(28, 'Loppy', 'Marrón claro', 'Orejas largas', 26078, 28),
(29, 'Snowball', 'Blanco', 'Pelo largo y suave', 27089, 29),
(30, 'Coco', 'Blanco y marrón', 'Ojos grandes', 28090, 30);

-- -----------------------------------------------------
-- Inserción tabla dueño
-- -----------------------------------------------------
INSERT INTO dueño (id_dueño, nombre, direccion, telefono, correo_electronico, turno_id_turno) 
VALUES 
(1, 'Juan Pérez', 'Calle 1, Ciudad', '123456789', 'juan.perez@example.com', 1),
(2, 'Ana García', 'Calle 2, Ciudad', '234567890', 'ana.garcia@example.com', 1),
(3, 'Luis Martínez', 'Calle 3, Ciudad', '345678901', 'luis.martinez@example.com', 2),
(4, 'María López', 'Calle 4, Ciudad', '456789012', 'maria.lopez@example.com', 2),
(5, 'Carlos Ruiz', 'Calle 5, Ciudad', '567890123', 'carlos.ruiz@example.com', 1),
(6, 'Laura Fernández', 'Calle 6, Ciudad', '678901234', 'laura.fernandez@example.com', 2),
(7, 'José Gómez', 'Calle 7, Ciudad', '789012345', 'jose.gomez@example.com', 1),
(8, 'Patricia Torres', 'Calle 8, Ciudad', '890123456', 'patricia.torres@example.com', 2),
(9, 'Raúl Díaz', 'Calle 9, Ciudad', '901234567', 'raul.diaz@example.com', 1),
(10, 'Claudia Morales', 'Calle 10, Ciudad', '012345678', 'claudia.morales@example.com', 2),
(11, 'Santiago Castro', 'Calle 11, Ciudad', '123456780', 'santiago.castro@example.com', 1),
(12, 'Isabel Jiménez', 'Calle 12, Ciudad', '234567891', 'isabel.jimenez@example.com', 2),
(13, 'Fernando Ruiz', 'Calle 13, Ciudad', '345678902', 'fernando.ruiz@example.com', 1),
(14, 'Monica Silva', 'Calle 14, Ciudad', '456789013', 'monica.silva@example.com', 2),
(15, 'Alberto Hernández', 'Calle 15, Ciudad', '567890124', 'alberto.hernandez@example.com', 1),
(16, 'Verónica Castillo', 'Calle 16, Ciudad', '678901235', 'veronica.castillo@example.com', 2),
(17, 'Diego Romero', 'Calle 17, Ciudad', '789012346', 'diego.romero@example.com', 1),
(18, 'Angela Ríos', 'Calle 18, Ciudad', '890123457', 'angela.rios@example.com', 2),
(19, 'Rafael Soto', 'Calle 19, Ciudad', '901234568', 'rafael.soto@example.com', 1),
(20, 'Mariana Vargas', 'Calle 20, Ciudad', '012345679', 'mariana.vargas@example.com', 2),
(21, 'Cecilia Castro', 'Calle 21, Ciudad', '123456791', 'cecilia.castro@example.com', 1),
(22, 'Javier Ponce', 'Calle 22, Ciudad', '234567892', 'javier.ponce@example.com', 2),
(23, 'Gustavo Peña', 'Calle 23, Ciudad', '345678903', 'gustavo.pena@example.com', 1),
(24, 'Elena Medina', 'Calle 24, Ciudad', '456789014', 'elena.medina@example.com', 2),
(25, 'Samuel Morales', 'Calle 25, Ciudad', '567890125', 'samuel.morales@example.com', 1),
(26, 'Liliana Cruz', 'Calle 26, Ciudad', '678901236', 'liliana.cruz@example.com', 2),
(27, 'Victor Salas', 'Calle 27, Ciudad', '789012347', 'victor.salas@example.com', 1),
(28, 'Teresa Ruiz', 'Calle 28, Ciudad', '890123458', 'teresa.ruiz@example.com', 2),
(29, 'Patricio Torres', 'Calle 29, Ciudad', '901234569', 'patricio.torres@example.com', 1),
(30, 'Silvia Castro', 'Calle 30, Ciudad', '012345670', 'silvia.castro@example.com', 2);

-- -----------------------------------------------------
-- Inserción tabla profesional
-- -----------------------------------------------------
INSERT INTO profesional (id_profesional, nombre, matricula, telefono, oficio, fecha_inicio, analisis_id_analisis) 
VALUES 
(1, 'Dr. Andrés Torres', 'MAT-101', '123123123', 'Veterinario', '2020-01-15', 1),
(2, 'Dra. Lucía Medina', 'MAT-102', '234234234', 'Veterinario', '2019-05-22', 1),
(3, 'Eduardo Ramírez', 'MAT-103', '345345345', 'Auxiliar Veterinario', '2021-03-10', 2),
(4, 'Sofía Salazar', 'MAT-104', '456456456', 'Veterinario de Animales Exóticos', '2018-11-05', 2),
(5, 'Carlos Alvarado', 'MAT-105', '567567567', 'Técnico en Farmacia Veterinaria', '2020-06-15', 3),
(6, 'Gabriela Cortés', 'MAT-106', '678678678', 'Asistente de Veterinaria', '2022-02-28', 3),
(7, 'Dr. Javier López', 'MAT-107', '789789789', 'Veterinario', '2017-04-20', 1),
(8, 'Patricia Núñez', 'MAT-108', '890890890', 'Nutricionista Animal', '2019-09-01', 2),
(9, 'Fernando Soto', 'MAT-109', '901901901', 'Veterinario', '2021-01-10', 1),
(10, 'Clara Herrera', 'MAT-110', '012012012', 'Auxiliar Veterinario', '2020-07-18', 3),
(11, 'Santiago Ruiz', 'MAT-111', '123123123', 'Veterinario de Emergencias', '2018-10-12', 1),
(12, 'Isabel Martínez', 'MAT-112', '234234234', 'Veterinario de Rehabilitación', '2020-11-03', 2),
(13, 'Rodolfo Jiménez', 'MAT-113', '345345345', 'Técnico en Imágenes Veterinarias', '2021-08-15', 3),
(14, 'Mónica Reyes', 'MAT-114', '456456456', 'Veterinario', '2017-12-01', 1),
(15, 'Alberto Ortega', 'MAT-115', '567567567', 'Veterinario de Animales de Compañía', '2020-05-09', 1),
(16, 'Verónica Aguirre', 'MAT-116', '678678678', 'Asistente de Veterinaria', '2022-03-11', 3),
(17, 'Diego Fernández', 'MAT-117', '789789789', 'Veterinario', '2019-06-18', 1),
(18, 'Ángela Castro', 'MAT-118', '890890890', 'Veterinario de Animales Exóticos', '2018-08-22', 2),
(19, 'Rafael Paredes', 'MAT-119', '901901901', 'Técnico en Farmacia Veterinaria', '2021-01-25', 3),
(20, 'Mariana Torres', 'MAT-120', '012012012', 'Veterinario', '2020-09-15', 1),
(21, 'Cecilia Morales', 'MAT-121', '123123123', 'Nutricionista Animal', '2022-04-04', 2),
(22, 'Javier Silva', 'MAT-122', '234234234', 'Veterinario de Emergencias', '2017-05-10', 1),
(23, 'Gustavo Medina', 'MAT-123', '345345345', 'Veterinario', '2021-07-22', 1),
(24, 'Elena Vázquez', 'MAT-124', '456456456', 'Veterinario de Rehabilitación', '2019-10-05', 2),
(25, 'Samuel Ortiz', 'MAT-125', '567567567', 'Auxiliar Veterinario', '2020-12-15', 3),
(26, 'Liliana González', 'MAT-126', '678678678', 'Veterinario', '2018-03-30', 1),
(27, 'Victor Jiménez', 'MAT-127', '789789789', 'Veterinario de Animales de Compañía', '2021-02-14', 1),
(28, 'Teresa Mendoza', 'MAT-128', '890890890', 'Técnico en Imágenes Veterinarias', '2020-06-28', 3),
(29, 'Patricio Hernández', 'MAT-129', '901901901', 'Veterinario', '2019-04-10', 1),
(30, 'Silvia Cordero', 'MAT-130', '012012012', 'Asistente de Veterinaria', '2021-08-30', 3);

-- -----------------------------------------------------
-- Inserción tabla dueño_has_mascota
-- -----------------------------------------------------	
INSERT INTO dueño_has_mascota (id_dueño_has_mascota, dueño_id_dueño, mascota_id_mascota) 
VALUES
(1, 1, 1),  -- Juan Pérez es dueño de Max
(2, 2, 2),  -- Ana García es dueña de Bella
(3, 3, 3),  -- Luis Martínez es dueño de Rocky
(4, 4, 4),  -- María López es dueña de Luna
(5, 5, 5),  -- Carlos Ruiz es dueño de Toby
(6, 6, 6),  -- Laura Fernández es dueña de Milo
(7, 7, 7),  -- José Gómez es dueño de Nala
(8, 8, 8),  -- Patricia Torres es dueña de Coco
(9, 9, 9),  -- Raúl Díaz es dueño de Chico
(10, 10, 10),  -- Claudia Morales es dueña de Simba
(11, 11, 11),  -- Santiago Castro es dueño de Misty
(12, 12, 12),  -- Isabel Jiménez es dueña de Shadow
(13, 13, 13),  -- Fernando Ruiz es dueño de Sphinx
(14, 14, 14),  -- Monica Silva es dueña de Leo
(15, 15, 15),  -- Alberto Hernández es dueño de Oreo
(16, 16, 16),  -- Verónica Castillo es dueña de Savvy
(17, 17, 17),  -- Diego Romero es dueño de Whiskers
(18, 18, 18),  -- Angela Ríos es dueña de Tweety
(19, 19, 19),  -- Rafael Soto es dueño de Perry
(20, 20, 20),  -- Mariana Vargas es dueña de Coco
(21, 21, 21),  -- Cecilia Castro es dueña de Peach
(22, 22, 22),  -- Javier Ponce es dueño de Gris
(23, 23, 23),  -- Gustavo Peña es dueño de Zippy
(24, 24, 24),  -- Elena Medina es dueña de Diamond
(25, 25, 25),  -- Samuel Morales es dueño de Bunny
(26, 26, 26),  -- Liliana Cruz es dueña de Fluffy
(27, 27, 27),  -- Victor Salas es dueño de Rexy
(28, 28, 28),  -- Teresa Ruiz es dueña de Loppy
(29, 29, 29),  -- Patricio Torres es dueño de Snowball
(30, 30, 30);  -- Silvia Castro es dueña de Coco

-- -----------------------------------------------------
-- Inserción tabla turno
-- -----------------------------------------------------	
INSERT INTO turno (id_turno, dia, horario, fecha_turno, mascota_id_mascota, profesional_id_profesional, dueño_id_dueño) 
VALUES
(1, 'Lunes', '09:00:00', '2024-08-01', 1, 1, 1),
(2, 'Martes', '10:30:00', '2024-08-02', 2, 2, 2),
(3, 'Miércoles', '14:00:00', '2024-08-03', 3, 3, 3),
(4, 'Jueves', '15:30:00', '2024-08-04', 4, 4, 4),
(5, 'Viernes', '13:00:00', '2024-08-05', 5, 5, 5),
(6, 'Sábado', '08:30:00', '2024-08-06', 6, 6, 6),
(7, 'Lunes', '11:00:00', '2024-08-07', 7, 7, 7),
(8, 'Martes', '12:00:00', '2024-08-08', 8, 8, 8),
(9, 'Miércoles', '16:00:00', '2024-08-09', 9, 9, 9),
(10, 'Jueves', '17:30:00', '2024-08-10', 10, 10, 10),
(11, 'Viernes', '09:00:00', '2024-08-11', 11, 11, 11),
(12, 'Sábado', '10:30:00', '2024-08-12', 12, 12, 12),
(13, 'Lunes', '14:00:00', '2024-08-13', 13, 13, 13),
(14, 'Martes', '15:30:00', '2024-08-14', 14, 14, 14),
(15, 'Miércoles', '13:00:00', '2024-08-15', 15, 15, 15),
(16, 'Jueves', '08:30:00', '2024-08-16', 16, 16, 16),
(17, 'Viernes', '11:00:00', '2024-08-17', 17, 17, 17),
(18, 'Sábado', '12:00:00', '2024-08-18', 18, 18, 18),
(19, 'Lunes', '16:00:00', '2024-08-19', 19, 19, 19),
(20, 'Martes', '17:30:00', '2024-08-20', 20, 20, 20),
(21, 'Miércoles', '09:00:00', '2024-08-21', 21, 21, 21),
(22, 'Jueves', '10:30:00', '2024-08-22', 22, 22, 22),
(23, 'Viernes', '14:00:00', '2024-08-23', 23, 23, 23),
(24, 'Sábado', '15:30:00', '2024-08-24', 24, 24, 24),
(25, 'Lunes', '13:00:00', '2024-08-25', 25, 25, 25),
(26, 'Martes', '08:30:00', '2024-08-26', 26, 26, 26),
(27, 'Miércoles', '11:00:00', '2024-08-27', 27, 27, 27),
(28, 'Jueves', '12:00:00', '2024-08-28', 28, 28, 28),
(29, 'Viernes', '16:00:00', '2024-08-29', 29, 29, 29),
(30, 'Sábado', '17:30:00', '2024-08-30', 30, 30, 30);

-- -----------------------------------------------------
-- Inserción tabla consulta
-- -----------------------------------------------------	
INSERT INTO consulta (id_consulta, motivo_realizacion, asistencia, turno_id_turno) 
VALUES
(1, 'Chequeo de rutina', 1, 1),
(2, 'Vacunación anual', 1, 2),
(3, 'Problemas digestivos', 0, 3),
(4, 'Revisión de heridas', 1, 4),
(5, 'Examen dental', 1, 5),
(6, 'Consulta por comportamiento', 0, 6),
(7, 'Cirugía menor programada', 1, 7),
(8, 'Problemas respiratorios', 1, 8),
(9, 'Chequeo de embarazo', 1, 9),
(10, 'Corte de uñas y limpieza', 0, 10),
(11, 'Consulta por alergias', 1, 11),
(12, 'Desparasitación', 1, 12),
(13, 'Chequeo general', 1, 13),
(14, 'Problemas de movilidad', 0, 14),
(15, 'Vacunación de refuerzo', 1, 15),
(16, 'Consulta por sobrepeso', 0, 16),
(17, 'Revisión postoperatoria', 1, 17),
(18, 'Infección de oído', 1, 18),
(19, 'Problemas en la piel', 0, 19),
(20, 'Cuidado postparto', 1, 20),
(21, 'Chequeo cardíaco', 0, 21),
(22, 'Problemas de visión', 1, 22),
(23, 'Consulta por alimentación', 1, 23),
(24, 'Control de crecimiento', 1, 24),
(25, 'Chequeo de lesiones', 0, 25),
(26, 'Problemas de digestión', 1, 26),
(27, 'Revisión de fracturas', 1, 27),
(28, 'Consulta por pulgas', 0, 28),
(29, 'Revisión de articulaciones', 1, 29),
(30, 'Problemas dentales', 1, 30);

-- -----------------------------------------------------
-- Inserción tabla analisis 
-- -----------------------------------------------------
INSERT INTO analisis (id_analisis, tipo, resultado, consulta_id_consulta, profesional_id_profesional)
VALUES
(1, 'Análisis de sangre', 'Resultados normales', 1, 1), 
(2, 'Examen de orina', 'Leve infección detectada', 2, 3), 
(3, 'Radiografía', 'Fractura mínima', 4, 7), 
(4, 'Limpieza dental', 'Dientes en buen estado', 5, 10), 
(5, 'Examen respiratorio', 'Bronquitis leve', 8, 11), 
(6, 'Ecografía', 'Gestación de 5 semanas', 9, 9),  
(7, 'Análisis de piel', 'Alergias detectadas', 11, 6),  
(8, 'Análisis parasitológico', 'Presencia de parásitos', 12, 19), 
(9, 'Examen físico general', 'Todo en orden', 13, 20), 
(10, 'Pruebas de movilidad', 'Problemas detectados en articulaciones', 17, 8), 
(11, 'Examen auditivo', 'Infección de oído tratada', 18, 7), 
(12, 'Examen dermatológico', 'Problemas cutáneos leves', 19, 12), 
(13, 'Ecocardiograma', 'Resultados normales', 20, 1), 
(14, 'Examen ocular', 'Problemas de visión tratados', 22, 21),  
(15, 'Examen nutricional', 'Sobrepeso leve detectado', 23, 24), 
(16, 'Control de crecimiento', 'Crecimiento normal', 24, 22),  
(17, 'Radiografía de articulaciones', 'Lesiones detectadas', 29, 29), 
(18, 'Examen dental', 'Dientes con caries leves', 30, 5);


-- -----------------------------------------------------
-- Inserción tabla receta
-- -----------------------------------------------------
INSERT INTO receta (id_receta, nombre_medicamento, indicaciones, dosis, consulta_id_consulta) 
VALUES
(1, 'Amoxicilina', 'Administrar por vía oral durante 7 días', '500 mg cada 12 horas', 1),
(2, 'Meloxicam', 'Administrar por vía oral durante 5 días', '7.5 mg cada 24 horas', 4),
(3, 'Enrofloxacina', 'Administrar por vía oral durante 10 días', '50 mg cada 12 horas', 5),
(4, 'Metronidazol', 'Administrar por vía oral durante 7 días', '250 mg cada 8 horas', 7),
(5, 'Prednisona', 'Administrar por vía oral durante 3 días', '10 mg cada 24 horas', 9),
(6, 'Omeprazol', 'Administrar por vía oral durante 14 días', '20 mg cada 24 horas', 11),
(7, 'Doxiciclina', 'Administrar por vía oral durante 7 días', '100 mg cada 12 horas', 13),
(8, 'Carprofeno', 'Administrar por vía oral durante 5 días', '25 mg cada 12 horas', 16),
(9, 'Ciprofloxacina', 'Administrar por vía oral durante 7 días', '250 mg cada 12 horas', 18);

-- -----------------------------------------------------
-- Inserción tabla pago
-- -----------------------------------------------------
INSERT INTO pago (id_pago, monto, medio_pago, fecha, consulta_id_consulta) 
VALUES
(1, 1500.00, 'efectivo', '2024-08-05 10:00:00', 1),
(2, 2000.00, 'tarjeta', '2024-08-06 11:15:00', 2),
(3, 1800.00, 'transferencia', '2024-08-07 09:45:00', 3),
(4, 2300.00, 'tarjeta', '2024-08-08 12:30:00', 4),
(5, 1600.00, 'efectivo', '2024-08-09 15:00:00', 5),
(6, 2100.00, 'transferencia', '2024-08-10 14:00:00', 6),
(7, 1900.00, 'efectivo', '2024-08-11 16:00:00', 7),
(8, 2500.00, 'cuenta corriente', '2024-08-12 17:00:00', 8),
(9, 1750.00, 'efectivo', '2024-08-13 10:45:00', 9),
(10, 2200.00, 'tarjeta', '2024-08-14 11:00:00', 10),
(11, 2400.00, 'efectivo', '2024-08-15 12:15:00', 11),
(12, 2000.00, 'cuenta corriente', '2024-08-16 14:30:00', 12),
(13, 2150.00, 'transferencia', '2024-08-17 16:45:00', 13),
(14, 1900.00, 'efectivo', '2024-08-18 10:00:00', 14),
(15, 2500.00, 'tarjeta', '2024-08-19 12:30:00', 15),
(16, 1800.00, 'transferencia', '2024-08-20 14:00:00', 16),
(17, 2200.00, 'efectivo', '2024-08-21 15:00:00', 17),
(18, 2400.00, 'tarjeta', '2024-08-22 11:00:00', 18);

-- -----------------------------------------------------
-- Consultas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Listar las mascotas con sus respectivos dueños ---
-- -----------------------------------------------------

SELECT mascota.nombre AS nombre_mascota, dueño.nombre AS nombre_dueño
FROM mascota
JOIN dueño_has_mascota ON dueño_has_mascota.mascota_id_mascota = mascota.id_mascota
JOIN dueño ON dueño_has_mascota.dueño_id_dueño = dueño.id_dueño
ORDER BY mascota.nombre;	

-- -----------------------------------------------------
-- Mascota especifica -> Consulta Utilizada Para Primer Indice ---
-- -----------------------------------------------------

SET profiling = 1; -- Activar el perfilado
SELECT * FROM mascota WHERE nombre = 'Coco'; -- O cualquier nombre de la mascota

EXPLAIN /*Para ver como funciona el indice*/  
SELECT * FROM mascota WHERE nombre = 'Coco'; -- O cualquier nombre de la mascota
SHOW PROFILES; -- Ver el tiempo de ejecución de la consulta

-- -----------------------------------------------------
-- Historial de consultas de una mascota especifica (fecha, motivo de la consulta, veterinario que lo antendió)
-- -----------------------------------------------------
SELECT mascota.nombre, CONCAT(turno.dia, ' ', turno.fecha_turno) AS fecha, consulta.motivo_realizacion, profesional.nombre
FROM mascota
JOIN turno ON turno.mascota_id_mascota = mascota.id_mascota
JOIN consulta ON consulta.turno_id_turno = turno.id_turno
JOIN profesional ON profesional.id_profesional = turno.profesional_id_profesional
WHERE mascota.nombre = 'Coco'; -- O cualquier nombre de la mascota

EXPLAIN SELECT mascota.nombre, CONCAT(turno.dia, ' ', turno.fecha_turno) AS fecha, consulta.motivo_realizacion, profesional.nombre
FROM mascota
JOIN turno ON turno.mascota_id_mascota = mascota.id_mascota
JOIN consulta ON consulta.turno_id_turno = turno.id_turno
JOIN profesional ON profesional.id_profesional = turno.profesional_id_profesional
WHERE mascota.nombre = 'Coco'; -- O cualquier nombre de la mascota

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
  WHERE consulta.asistencia = 1  -- Considera solo las consultas donde la mascota asistió
  GROUP BY mes, año
) AS mascotas_por_mes;

-- -----------------------------------------------------
-- Total de turnos por fecha especifica y cuantos turnos han sido asistidos -> Consulta Utilizada Para Segundo Indice ---
-- -----------------------------------------------------

SELECT COUNT(*) AS total_turnos, SUM(consulta.asistencia) AS turnos_asistidos
FROM consulta
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
WHERE turno.fecha_turno = '2024-08-01';  -- Reemplaza con la fecha que desees consultar

EXPLAIN /*Para ver como funciona el indice*/
SELECT COUNT(*) AS total_turnos, SUM(consulta.asistencia) AS turnos_asistidos
FROM consulta
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
WHERE turno.fecha_turno = '2024-08-01';  -- Reemplaza con la fecha que desees consultar

-- -----------------------------------------------------
-- Cantidad de mascotas atendidas por mes -> Consulta Utilizada Para Cuarto Indice ---
-- -----------------------------------------------------

SELECT MONTH(turno.fecha_turno) AS mes, COUNT(DISTINCT mascota.id_mascota) AS cantidad_mascotas 
FROM consulta
INNER JOIN turno ON consulta.turno_id_turno = turno.id_turno
INNER JOIN mascota ON turno.mascota_id_mascota = mascota.id_mascota
WHERE consulta.asistencia = 1
GROUP BY mes;  

EXPLAIN /*Para ver como funciona el indice*/
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
WHERE pago.medio_pago = 'cuenta corriente';


-- -----------------------------------------------------
-- Total de gastos por tipo de medio de pago -> Consulta Utilizada Para Tercer Indice ---
-- -----------------------------------------------------

SELECT medio_pago, SUM(monto) AS total_monto
FROM pago
WHERE activo = 1 -- Considera solo los pagos activos
GROUP BY medio_pago
ORDER BY total_monto DESC;

EXPLAIN /*Para ver como funciona el indice*/
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
WHERE turno.profesional_id_profesional = profesional.id_profesional AND consulta.asistencia = 1) > 1 -- Cambia 5 por la cantidad mínima que desees
ORDER BY profesional.nombre;

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



