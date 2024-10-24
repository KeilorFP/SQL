#Obtener los nombres de los clientes cuya dirección sea en la Comunidad de Madrid.
SELECT c.nombre AS "Nombres de los clientes"
FROM case.cliente c
Where c.id_direccion IN (
SELECT d.id_direccion
FROM case.direcciones d
WHERE d.comunidad_autonoma like "%Madrid%");

#Obtener la información completa del Proveedor (código, nombre, dirección, teléfono). En caso de no disponer de información de ciudad o comunidad, 
#mostrar el valor como nulo. Ignorar los identificadores, salvo los del proveedor.
SELECT p.id_proveedor AS "Código del Proveedor", 
       p.nombre AS "Nombre del Proveedor", 
       p.telefono AS "Teléfono", 
       d.calle AS "Calle",
       d.numero_calle AS "Numero de la calle",
	   d.ciudad AS "Ciudad", 
       d.comunidad_autonoma AS "Comunidad Autónoma"
FROM case.proveedores p 
LEFT JOIN case.direcciones d 
ON p.id_direccion = d.id_direccion;

#Obtener la información completa del cliente, excepto el teléfono, ignorando aquellos identificadores salvo el del cliente (código, nombre, dirección, uno de los teléfonos disponibles)
#de aquellos cuya fecha de factura sea la más antigua del sistema. En caso de no disponer de información de la factura para ese cliente,
#debemos ignorar el registro, al igual que si no tenemos información de la ciudad o comunidad.
SELECT c.id_cliente AS "Código del Cliente", 
       c.nombre AS "Nombre del Cliente", 
       d.calle AS "Calle", 
       d.numero_calle AS "Número de la Calle", 
       d.ciudad AS "Ciudad", 
       d.comunidad_autonoma AS "Comunidad Autónoma", 
       f.fecha AS "Fecha de la Factura"
FROM case.cliente c
JOIN case.direcciones d 
  ON c.id_direccion = d.id_direccion
JOIN case.factura f
  ON c.id_cliente = f.id_cliente
WHERE d.ciudad IS NOT NULL 
  AND d.comunidad_autonoma IS NOT NULL
  AND f.fecha = (
      SELECT MIN(f2.fecha) 
      FROM case.factura f2
  );

#Obtener aquellos productos que únicamente comercialice un único proveedor.  Se desea conocer la información completa del producto,
#incluida la información sobre la categoría a la que pertenece.
#Contar el número de productos en cada factura.
SELECT p.nombre AS "Productos únicos",
       c.nombre AS "Nombre de la Categoría",
       c.descripcion AS "Descripción del Producto",
       COUNT(pv.unidades_vendidas) AS "Cantidad en Factura"
FROM case.productos p
JOIN case.categoria c 
  ON p.categoria_id = c.categoria_id
JOIN case.productos_venta pv 
  ON p.id_productos = pv.id_productos
WHERE p.id_productos IN (
    SELECT pp.id_productos
    FROM case.proveedores_productos pp
    GROUP BY pp.id_productos
    HAVING COUNT(pp.id_proveedor) = 1
)
GROUP BY p.id_productos, p.nombre, c.nombre, c.descripcion
LIMIT 0, 500;

#Obtener el nombre del producto que se haya comprado alguna vez cómo único elemento dentro de una compra. Se necesita el identificador y el nombre de forma única.
SELECT DISTINCT p.id_productos AS "ID del Producto", 
                p.nombre AS "Nombre del Producto"
FROM case.productos p
JOIN case.productos_venta pv
  ON p.id_productos = pv.id_productos
GROUP BY p.id_productos, p.nombre
HAVING SUM(pv.unidades_vendidas) = 1;

#Escribir la consulta para obtener los clientes (es suficiente con conocer su nombre) que han comprado más de tres productos en alguna de sus compras. 
#Luego, ordena los resultados de mayor número de productos a menor.
SELECT DISTINCT c.nombre AS "Nombre del cliente",
                SUM(pv.unidades_vendidas) AS "Cantidad de productos comprados"
FROM case.cliente c
JOIN case.factura f 
ON c.id_cliente = f.id_cliente
JOIN case.productos_venta pv
ON f.id_factura= pv.id_factura
GROUP BY c.nombre
HAVING SUM(pv.unidades_vendidas) > 3
ORDER BY SUM(pv.unidades_vendidas) DESC;

#Escribir la consulta que nos permita disponer de la información necesaria para conocer los nombres de los clientes que aún no hayan ejecutado ninguna compra.
SELECT c.nombre AS "Nombre del cliente"
FROM case.cliente c
LEFT JOIN case.factura f 
  ON c.id_cliente = f.id_cliente
WHERE f.id_factura IS NULL;

#Escribir la consulta que nos permita disponer del nombre e identificador de los clientes que han efectuado alguna venta, 
#pero aún no se dispone de información de su factura.
SELECT DISTINCT c.nombre AS "Nombre del cliente",
                c.id_cliente AS "Identificador"
FROM case.cliente c
JOIN case.productos_venta pv 
  ON pv.id_factura IS NOT NULL
LEFT JOIN case.factura f 
  ON pv.id_factura = f.id_factura
WHERE f.id_factura IS NULL;

#Se desea contactar con proveedores, mediante correo postal, si cuentan con algún producto que cumpla las siguientes condiciones:
#Su precio sea menor de 5 euros y disponga de menos de 50 unidades.
SELECT DISTINCT p.nombre AS "Nombre del proveedor"
FROM case.proveedores p
JOIN case.proveedores_productos pp
  ON p.id_proveedor = pp.id_proveedor
JOIN case.productos pr 
  ON pp.id_productos = pr.id_productos
WHERE pr.precio_unidad < 5 AND pr.stock_actual < 50;
#Su precio esté entre 100 y 500 euros y disponga entre 10 y 20 unidades.
SELECT DISTINCT p.nombre AS "Nombre del proveedor"
FROM case.proveedores p
JOIN case.proveedores_productos pp
  ON p.id_proveedor = pp.id_proveedor
JOIN case.productos pr 
  ON pp.id_productos = pr.id_productos
WHERE pr.precio_unidad BETWEEN 100 AND 500 
  AND pr.stock_actual BETWEEN 10 AND 20;
  
#Su precio sea mayor de 500 euros y disponga de menos de 6 unidades.
SELECT DISTINCT p.nombre AS "Nombre del proveedor"
FROM case.proveedores p
JOIN case.proveedores_productos pp
  ON p.id_proveedor = pp.id_proveedor
JOIN case.productos pr 
  ON pp.id_productos = pr.id_productos
WHERE pr.precio_unidad >500 AND pr.stock_actual < 6;
#Se desea obtener un listado de las ventas con el siguiente detalle:
#Fecha de la venta, total de la compra y descuento aplicado.
SELECT f.fecha AS "Fecha de la venta",
       f.coste_total AS "Total de la compra",
       f.descuento AS "Descuento aplicado"
FROM case.factura f;

#Del producto se desea conocer el código del producto, su nombre y la descripción de la categoría a la que pertenece.
SELECT p.id_productos AS "Codigo del producto",
       p.nombre AS "Nombre del producto",
       c.descripcion AS "Descripcion del producto"
FROM case.productos p
JOIN case.categoria c
ON c.categoria_id= p.categoria_id;
#Sobre el proveedor del producto sólo interesa conocer la web.
SELECT p.pagina_web AS "Pagina web del proveedor",
	    p.nombre AS "Nombre del proveedor"
FROM case.proveedores p
#Del cliente se quiere conocer su nombre, su código y la ciudad donde vive.
SELECT  c.id_cliente AS "Codigo del cliente",
        c.nombre AS "Nombre del cliente",
        d.ciudad AS "Ciudad del cliente"
FROM case.cliente c
JOIN case.direcciones d
ON c.id_direccion= d.id_direccion;
#Obtener el nombre del proveedor junto con el total de productos que tiene. Se quiere renombrar el valor de conteo por “total_productos”,
#y obtener el resultado ordenado de menor a mayor.
SELECT p.nombre AS "Nombre del proveedor",
       COUNT(pr.stock_actual) AS "Total_productos"
FROM case.proveedores p
JOIN case.proveedores_productos pp
ON p.id_proveedor = pp.id_proveedor
JOIN case.productos pr
ON pr.id_productos= pp.id_productos
GROUP BY p.nombre, p.id_proveedor
ORDER BY COUNT(pr.stock_actual) ASC;
#Obtener el nombre del cliente que más gasto haya tenido en todo el histórico del que se dispone.
SELECT c.nombre AS "Nombre del cliente"
FROM case.cliente c
JOIN case.factura f ON c.id_cliente = f.id_cliente
GROUP BY c.id_cliente, c.nombre
ORDER BY SUM(f.coste_total) DESC
LIMIT 1;
#Obtener el nombre del cliente y su teléfono, concatenando los distintos teléfonos en una misma columna, separado por comas.
#Mostrar el valor NULL en caso de no disponer de teléfonos de contactos.
SELECT c.nombre AS "Nombre del cliente",
       IFNULL(GROUP_CONCAT(t.telefono SEPARATOR ', '), 'NULL') AS "Teléfonos"
FROM case.cliente c
LEFT JOIN case.telefono_cliente t 
ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente, c.nombre;

