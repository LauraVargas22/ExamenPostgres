-- Listar los productos con stock menor a 5 unidades.
SELECT id, nombre AS Producto, stock 
FROM producto
WHERE stock < 5;
-- Calcular ventas totales de un mes específico.
SELECT COUNT(id) AS Numero_Ventas, EXTRACT(MONTH FROM fecha_venta) AS Mes
FROM venta
WHERE EXTRACT(MONTH FROM fecha_venta) = 03
GROUP BY EXTRACT(MONTH FROM fecha_venta);
-- Obtener el cliente con más compras realizadas.
SELECT c.nombre AS Nombre_Cliente, c.apellido AS Apellido_Cliente, COUNT(v.id_cliente) AS Compras_Cliente
FROM cliente c
JOIN venta v ON c.id = v.id_cliente
GROUP BY c.nombre, c.apellido
ORDER BY Compras_Cliente DESC
LIMIT 1;
-- Listar los 5 productos más vendidos.
SELECT p.nombre AS Producto, p.categoria, COUNT(dv.id_producto) AS Ventas_Producto
FROM producto p
JOIN detalle_venta dv ON p.id = dv.id_producto
GROUP BY p.nombre, p.categoria
ORDER BY Ventas_Producto DESC
LIMIT 5;
-- Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.
SELECT id AS Id_Venta, fecha_venta
FROM venta
WHERE fecha_venta BETWEEN NOW() - INTERVAL '1 month' AND NOW() - INTERVAL '3 days';

-- Identificar clientes que no han comprado en los últimos 6 meses.
SELECT c.nombre AS Nombre_Cliente, c.apellido AS Apellido_Cliente
FROM cliente c
LEFT JOIN venta v ON c.id = v.id_cliente
WHERE v.id_cliente IS NULL OR v.fecha_venta < NOW() - INTERVAL '6 months';