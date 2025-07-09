# 🧠 DataProject: Lógica. Consultas de SQL

## 📖 Descripción

Este proyecto consiste en realizar un análisis de una base de datos relacional sobre una empresa de alquiler de películas. El objetivo es aplicar consultas SQL para explorar, limpiar y obtener información relevante, utilizando buenas prácticas y estructuras como vistas, subconsultas y tablas temporales.

El análisis se llevó a cabo mediante la herramienta **DBeaver** conectada a una base de datos PostgreSQL. La base de datos contiene tablas como `film`, `actor`, `rental`, `inventory`, `customer`, `payment`, entre otras.

---

## 🗂 Estructura del Proyecto

📁 Entrega/

├── README.md

├── consultas_resueltas.sql

└── esquema_BBDD_films.png

---

## 🛠 Instalación y Requisitos

Este proyecto fue desarrollado con:

PostgreSQL (v16)

DBeaver como cliente SQL

Sistema operativo: Windows

Pasos para ejecutar el análisis:

Abrir DBeaver y conectar a la base de datos.

Importar el archivo consultas.sql desde el menú Archivo > Abrir.

Ejecutar las consultas comentadas y observar los resultados.

Asegurarse de que la base de datos esté bien conectada y activa.

---

## 📊 Resultados y Conclusiones

A través de las consultas, se logró:

Identificar actores con más participaciones.

Calcular ingresos totales por cliente, película o categoría.

Detectar películas sin devoluciones.

Analizar duraciones medias y alquileres por mes.

Crear vistas y tablas temporales con agrupaciones relevantes.

---

## 🧩 Cobertura de Requisitos

✅ Manejo de DBeaver: conexión, edición y ejecución de scripts SQL.

✅ Archivo del esquema: imagen incluida en la carpeta /esquema.

✅ Consultas sobre una tabla: ejemplos básicos como filtrado, ordenación, agrupaciones.

✅ Relaciones entre tablas: múltiples JOIN para combinar entidades como actores, películas, alquileres.

✅ Subconsultas: tanto en WHERE como en columnas y desde HAVING.

✅ Vistas: creación de vistas con CREATE VIEW.

✅ Estructuras de datos temporales: uso de CREATE TEMP TABLE.

✅ Buenas prácticas: consultas ordenadas, comentadas y con nombres descriptivos.

✅ Interpretación de resultados: se entiende y analiza cada resultado.

✅ Entrega en GitHub: repositorio bien estructurado y documentado.

---

## 🔄 Próximos Pasos

Agregar visualizaciones a partir de los resultados.

Normalizar nombres de columnas mediante alias consistentes.

Crear triggers o funciones para automatizar tareas futuras.

---

## ✒ Autores

Adrián Ochoa

GitHub: https://github.com/LAdrianOB