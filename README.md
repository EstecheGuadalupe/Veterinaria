# Sistema de Gestión para Veterinaria – Modelado de Datos & SQL

Este proyecto consiste en el diseño y desarrollo de una base de datos para una veterinaria, con el objetivo de gestionar información relacionada con mascotas, dueños, turnos, consultas médicas, profesionales y pagos.

Incluye:
✅ Modelo relacional completo  
✅ Creación de tablas con claves primarias y foráneas  
✅ Consultas SQL para explotación de datos  
✅ Vistas e índices para mejorar rendimiento  
✅ Integridad referencial entre todas las entidades principales

---

## Estructura de la Base de Datos

La base de datos está compuesta por las siguientes entidades:

- **animal**  
- **mascota**  
- **dueño**
- **profesional**
- **turno**
- **consulta**
- **pago**
- **analisis**
- **receta**
- **dueño_has_mascota** (relación N:M)

📌 Relaciones clave:
- Un **dueño puede tener varias mascotas**
- Una **mascota puede tener varios turnos**
- Cada **turno deriva en una consulta**
- Una **consulta puede incluir pagos, recetas o análisis**

---

## Consultas SQL Implementadas

Se incorporaron consultas enfocadas en indicadores de negocio como:

- Listado de mascotas con sus dueños
- Historial de consultas por mascota
- Promedio mensual de mascotas atendidas
- Cantidad de turnos por fecha y asistencia
- Gastos por medio de pago
- Veterinarios con mayor atención a pacientes

Se incluyen también **vistas** e **índices** para mejorar performance:

```sql
CREATE VIEW vista_mascotas_y_dueños AS ...
CREATE INDEX idx_mascota_nombre ON mascota(nombre);
