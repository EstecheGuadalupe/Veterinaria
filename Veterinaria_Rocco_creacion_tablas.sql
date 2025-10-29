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

