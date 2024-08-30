INSERT INTO Proveedores (ID_Proveedor, Nombre, Contacto) 
VALUES (1, 'Proveedor A', 'contacto@proveedora.com');

UPDATE Proveedores 
SET Nombre = 'Proveedor B', Contacto = 'contacto@proveedorb.com' 
WHERE ID_Proveedor = 1;

DELETE FROM Proveedores 
WHERE ID_Proveedor = 1;

INSERT INTO Compras (ID_Compra, ID_Cliente, Fecha, Total) 
VALUES (1, 123, '2024-08-29', 1000);

UPDATE Compras 
SET Total = 1200 
WHERE ID_Compra = 1;

DELETE FROM Compras 
WHERE ID_Compra = 1;

INSERT INTO DetalleCompra (ID_Compra, ID_Producto, Cantidad, PrecioUnitario) 
VALUES (1, 45, 10, 100);

UPDATE DetalleCompra 
SET Cantidad = 12 
WHERE ID_Compra = 1 AND ID_Producto = 45;

DELETE FROM DetalleCompra 
WHERE ID_Compra = 1 AND ID_Producto = 45;

SELECT C.ID_Compra, C.Fecha, CL.Nombre, C.Total
FROM Compras C
JOIN Clientes CL ON C.ID_Cliente = CL.ID_Cliente
WHERE EXTRACT(YEAR FROM C.Fecha) = 2024 
  AND EXTRACT(MONTH FROM C.Fecha) = 8;

SELECT ID_Compra AS Numero, Fecha, Total
FROM Compras
UNION ALL
SELECT ID_Venta AS Numero, Fecha, Total
FROM Ventas;

SELECT P.ID_Produccion, P.Fecha, P.Total
FROM Producciones P
JOIN DetalleProduccion DP ON P.ID_Produccion = DP.ID_Produccion
WHERE P.Fecha BETWEEN '2020-01-01' AND '2020-12-31'
  AND DP.ID_Producto IN (
    SELECT ID_Producto 
    FROM Ventas
    JOIN DetalleVenta DV ON Ventas.ID_Venta = DV.ID_Venta
    WHERE CategoriaProducto = 'Cecina'
    GROUP BY ID_Producto
    ORDER BY SUM(DV.Cantidad) DESC
    LIMIT 5
  );
