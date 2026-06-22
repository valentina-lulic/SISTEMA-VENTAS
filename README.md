# 📊 SQL Report - Challenger Sistema de Ventas

¡Bienvenido a este repositorio! Este proyecto contiene la resolución del **Challenger de Sistema de Ventas**, un conjunto de 26 consultas SQL diseñadas para interactuar con una base de datos relacional orientada al comercio. 

El objetivo principal es demostrar habilidades en la gestión de datos, desde filtros básicos hasta análisis complejos utilizando uniones (`JOIN`) y funciones de agregación con filtros avanzados (`HAVING`).

---

## 🛠️ Tecnologías y Entorno
* **Motor de Base de Datos:** PostgreSQL / MySQL (Estructura estándar de ventas)
* **Cliente de Base de Datos:** [DBeaver](https://dbeaver.io/)
* **Lenguaje:** SQL

---

## 📐 Estructura de la Base de Datos
Las consultas están adaptadas y optimizadas para la siguiente estructura de entidades y llaves primarias/foráneas:
* `clientes` (`id_cliente`, nombre, email, ...)
* `productos` (`id_producto`, nombre, precio, ...)
* `ventas` (`id_venta`, id_cliente, fecha, ...)
* `detalle_venta` (`id_venta`, id_producto, cantidad, ...)

---

## 🚀 Consultas Incluidas

El archivo principal contiene los scripts organizados y comentados listos para ejecutar en DBeaver. Se dividen en las siguientes categorías:

### 1. Consultas Básicas y Filtros 🔍
* Mostrar registros completos de clientes, productos y ventas.
* Selección de columnas específicas (ej: nombre y email de clientes).
* Filtros de rangos y fechas específicas (ej: ventas del `2026-04-02`).

### 2. Ordenamiento y Detalles ↕️
* Listados ordenados de mayor a menor precio y alfabéticamente.
* Control de existencias y cantidades mínimas en pedidos.

### 3. Métricas y Agregación 🧮
* Conteo total de registros en el sistema.
* Cálculos financieros como el **precio promedio** y la **suma total** de los productos disponibles.

### 4. Consultas Relacionales (JOINS) 🔗
* Vinculación de ventas con sus respectivos clientes y fechas.
* Desglose del detalle de boletas asociando identificadores con nombres reales de productos y cantidades vendidas.

### 5. Agrupamientos Complejos (GROUP BY & HAVING) 📊
* Reportes de ventas por cliente (incluyendo clientes sin compras mediante `LEFT JOIN`).
* Alertas de productos más repetidos en transacciones.
* Filtros avanzados para detectar clientes con compras superiores a ciertos umbrales de unidades.

### 6. El Caso Especial: Consulta Trampa 🪤
* **Reto:** Crear una consulta lógica que no devuelva resultados.
* **Solución aplicada:** Se implementó una contradicción matemática usando operadores `AND` (`precio > 10000 AND precio < 5000`) para demostrar el comportamiento estricto del motor ante condiciones mutuamente excluyentes.

---

## 💾 Cómo usar este Repositorio

1. Abre **DBeaver** y conéctate a tu base de datos de ventas.
2. Copia los scripts del archivo de consultas en un nuevo editor SQL (`Ctrl + Alt + T`).
3. Ejecuta cada consulta de forma individual (`Ctrl + Enter`) para analizar los reportes.

---
Generado con ❤️ para propósitos académicos.
