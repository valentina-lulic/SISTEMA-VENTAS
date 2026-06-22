-- =====================================
-- REPORTE SQL - CHALLENGER SISTEMA VENTAS
-- =====================================

-- la verdad como introducción, me gustaría mencionar que SQL me parece un lenguaje
-- bastante intuitivo y fácil de usar, solo tienes que aprender inglés básico.
-- Además es una herramienta muy útil e indispensable para el almacenamiento de 
-- datos en una empresa.

-- 1. Mostrar todos los clientes registrados
select * from clientes; -- la palabra "select" selecciona las columnas de la tabla 'clientes'

-- 2. Mostrar todos los productos disponibles
select * from productos; -- como dice la palabra selecciona los registros y columnas de la tabla 'productos'

-- 3. Mostrar todas las ventas realizadas
select * from ventas; -- nos trae todos los registros y columnas de la tabla 'ventas'.

-- 4. Mostrar solo nombre y email de clientes
SELECT nombre, email FROM clientes; -- acá se demuestra que podemos traer los datos sin el *, solo llamando las columnas.

-- 5. Mostrar solo nombre y precio de productos
SELECT nombre, precio FROM productos; -- acá filtramos llamando solo ciertas columnas.

-- 6. Productos con precio mayor a 50000
select * from productos where precio > 50000; -- en inglés sería literalmente: 'seleccionar productos donde le precio sea mayor a 50.000', es eso, estamos filtrando.


-- 7. Ventas realizadas el 2026-04-02
select * from ventas where fecha = '2026-04-02'; -- seleccionamos desde ventas donde la fecha es la que se indica.

-- 8. Productos ordenados de mayor a menor precio
select * from productos order by precio desc; -- seleccionamos los productos y los ordenamos con 'order by', para descender aplicamos 'desc'.

-- 9. Clientes ordenados por nombre
select * from clientes order by nombre asc; -- seleccionamos clientes con 'select', los ordenamos con 'order by', para ordenarlos de forma ascendente usamos 'ASC', el orden x defecto de SQL.

-- 10. Detalles de venta con cantidad >= 2
select * from detalle_venta where cantidad >= 2; -- llamamos desde detalle_venta y con '>= 2' vemos los datos de productos que se hayna comprado 2 o mas unidades de un producto.

-- 11. Total de clientes
select count(*) as total_clientes from clientes; -- con count contamos el numero total de filas, y con as le ponemos un alias al resultado de esto.

-- 12. Total de productos
select count(*) as total_productos from productos; -- con count contamos la totalidad de productos.

-- 13. Total de ventas
select count(*) as total_ventas from ventas; -- con count contamos el total de las ventas.

-- 14. Precio promedio de productos 
select AVG(precio) as precio_promedio from productos; -- Average suma todos los precios y los divide por el total de productos.

-- 15. Suma total de precios de productos
select SUM(precio) as suma_total_precios from productos; -- con sum, sumamos los valores de la columna 'precio', de TODOS los productos.

-- 16. Mostrar venta + nombre del cliente + fecha -- con JOIN conectamos la tabla ventas (v) con clientes (c) usando el ID que tienen en común.
SELECT v.id_venta, c.nombre AS nombre_cliente, v.fecha 
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente;

-- 17. Mostrar detalle de ventas con id_venta + nombre producto + cantidad -- conectamos el detalle de la venta con los productos para mostrar el nombre y numero de cada articulo.
SELECT dv.id_venta, p.nombre AS nombre_producto, dv.cantidad 
FROM detalle_venta dv
JOIN productos p ON dv.id_producto = p.id_producto;

-- 18. Mostrar nombre del cliente + id de venta + fecha -- muy similar a las 16, coenctamos con JOIN pero priorizamos mostrar los datos del cliente.
SELECT c.nombre AS nombre_cliente, v.id_venta, v.fecha 
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente;

-- 19. Mostrar nombre del producto + cantidad vendida + id de venta -- Unimos el detalle con productos para saber qué se vendió, cuánto y en qué número de boleta/factura
SELECT p.nombre AS nombre_producto, dv.cantidad, dv.id_venta 
FROM detalle_venta dv
JOIN productos p ON dv.id_producto = p.id_producto;

-- 20. Mostrar cuántas ventas ha realizado cada cliente -- con GROUP BY agrupamos los resultados por cliente. LEFT JOIN asegura que salgan incluso los clientes con 0 ventas
SELECT c.nombre, COUNT(v.id_venta) AS total_ventas 
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nombre;

-- 21. Mostrar solo los clientes con más de una venta -- HAVING funciona como un WHERE, pero se ejecuta DESPUÉS de agrupar y contar los datos.
SELECT c.nombre, COUNT(v.id_venta) AS total_ventas 
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(v.id_venta) > 1;

-- 22. Mostrar cuántas veces aparece cada producto en detalle_venta -- Contamos cuántas transacciones distintas incluyen a cada producto (no la cantidad de unidades, sino las veces que se pidió).
SELECT p.nombre, COUNT(dv.id_producto) AS repeticiones 
FROM productos p
LEFT JOIN detalle_venta dv ON p.id_producto = dv.id_producto
GROUP BY p.id_producto, p.nombre;

-- 23. Mostrar solo los productos que aparecen más de una vez -- Filtramos el agrupamiento anterior para mostrar únicamente los productos populares (q aparecen más de una vez).
SELECT p.nombre, COUNT(dv.id_producto) AS repeticiones 
FROM productos p
JOIN detalle_venta dv ON p.id_producto = dv.id_producto
GROUP BY p.id_producto, p.nombre
HAVING COUNT(dv.id_producto) > 1;

-- 24. Mostrar las ventas que tienen más de un producto asociado -- Agrupamos el detalle por el ID de la venta y contamos cuántos productos diferentes incluye el carrito.
SELECT id_venta, COUNT(id_producto) AS total_productos_distintos 
FROM detalle_venta 
GROUP BY id_venta
HAVING COUNT(id_producto) > 1;

-- 25. Mostrar clientes cuya suma total de unidades compradas sea mayor a 2. -- Sumamos la columna 'cantidad' de todos los detalles de un cliente y filtra a los que lleven más de 2 unidades en total.
SELECT c.nombre, SUM(dv.cantidad) AS total_unidades_compradas 
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
GROUP BY c.id_cliente, c.nombre
HAVING SUM(dv.cantidad) > 2;

-- 26. Consulta trampa que no devuelva resultados
SELECT * FROM productos WHERE precio > 10000 AND precio < 5000;


-- Explicar por qué el resultado vacío es correcto

-- En la lógica de bases de datos, el operador AND exige que ambas condiciones se
-- cumplan estrictamente y al mismo tiempo para cada registro evaluado. 
-- Es matemáticamente imposible que un producto tenga un precio que sea 
-- simultáneamente mayor a 10,000 y menor a 5,000. Al no existir ningún registro 
-- que pueda cumplir con esta condición mutuamente excluyente, el motor de la base
-- de datos devuelve un conjunto de datos vacío (0 filas), lo cual demuestra que el
-- sistema funciona correctamente según las reglas lógicas solicitadas.


