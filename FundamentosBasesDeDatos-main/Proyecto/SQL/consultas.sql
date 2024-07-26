/* 1. Conocer las ventas de productos en cada sucursal */
SELECT s.id_sucursal, s.nombre sucursal, producto, SUM(cantidad) cantidad FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN (
  -- Selecciona todos los productos de cada ticket
  SELECT t.num_ticket num_ticket, t.curp_empleado curp_empleado, c.nombre producto, rc.cantidad cantidad FROM ticket t
  JOIN registrar_comida rc ON t.num_ticket = rc.num_ticket
  JOIN comida c ON rc.clave_venta = c.clave_venta
  UNION
  SELECT t.num_ticket, t.curp_empleado, s.nombre, rs.cantidad FROM ticket t
  JOIN registrar_salsas rs ON t.num_ticket = rs.num_ticket
  JOIN salsas s ON rs.clave_venta = s.clave_venta
) temp
ON e.curp = temp.curp_empleado
GROUP BY s.id_sucursal, sucursal, producto
ORDER BY s.id_sucursal;

/* 2. Conocer el top 3 de las sucursales que han tenido más ventas */
SELECT s.id_sucursal, s.nombre sucursal, SUM(cantidad) cantidad FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN (
  -- Selecciona todas las ventas de cada ticket
  SELECT num_ticket, curp_empleado, SUM(cantidad) cantidad
  FROM (
    SELECT t.num_ticket num_ticket, t.curp_empleado curp_empleado, rc.cantidad cantidad FROM ticket t
    JOIN registrar_comida rc ON t.num_ticket = rc.num_ticket
    UNION
    SELECT t.num_ticket, t.curp_empleado, rs.cantidad FROM ticket t
    JOIN registrar_salsas rs ON t.num_ticket = rs.num_ticket
  ) temp_i
  GROUP BY num_ticket, curp_empleado
) temp
ON e.curp = temp.curp_empleado
GROUP BY s.id_sucursal, sucursal
ORDER BY cantidad DESC
LIMIT 3;

/* 3. Todas las colonias de donde vienen los clientes a una sucursal */
SELECT DISTINCT s.id_sucursal, s.nombre sucursal, c.colonia FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
JOIN cliente c ON t.curp_cliente = c.curp
ORDER BY s.id_sucursal;

/* 4. Número clientes atendidos por sucursal */
SELECT s.id_sucursal, s.nombre sucursal, COUNT(*) clientes_atendidos FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
GROUP BY s.id_sucursal, sucursal
ORDER BY s.id_sucursal;

/* 5. Número clientes atendidos por periodo */
SELECT COUNT(*) clientes_atendidos FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
WHERE t.fecha BETWEEN '2022-06-11' AND '2022-06-15';


/* 6. Número clientes atendidos por periodo en una sucursal dada */
SELECT s.id_sucursal, s.nombre sucursal, COUNT(*) clientes_atendidos FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
WHERE t.fecha BETWEEN '2022-06-11' AND '2022-06-15'
GROUP BY s.id_sucursal, sucursal
ORDER BY s.id_sucursal;

/* 7. Top 10 de los productos más vendidos */
SELECT c.nombre producto, SUM(rc.cantidad) cantidad FROM registrar_comida rc
JOIN comida c ON rc.clave_venta = c.clave_venta
GROUP BY producto
UNION
SELECT s.nombre producto, SUM(rs.cantidad) cantidad FROM registrar_salsas rs
JOIN salsas s ON rs.clave_venta = s.clave_venta
GROUP BY producto
ORDER BY cantidad DESC
LIMIT 10;

/* 8. Consulta para obtener un listado del total de ingredientes consumidos por todas las sucursales
 * el dia 11 de Junio de 2022
 */
SELECT nombre, SUM(suma)
FROM
    ((SELECT nombre, SUM(t2.cantidad * t3.cantidad) suma
    FROM ((SELECT num_ticket
           FROM ticket
           WHERE fecha = '2022-06-11') t1 NATURAL JOIN registrar_comida) t2
           JOIN ingredientes_comida t3 ON t2.clave_venta = t3.clave_venta
    GROUP BY nombre)
    UNION
    (SELECT nombre, sum(t2.cantidad * t3.cantidad)
    FROM ((SELECT num_ticket
           FROM ticket
           WHERE fecha = '2022-06-11') t1 NATURAL JOIN registrar_salsas) t2
           JOIN ingredientes_salsas t3 ON t2.clave_venta = t3.clave_venta
    GROUP BY nombre)) comidas_y_salsas
GROUP BY nombre;


/* 9. Consulta para obtener las ganancias por sucursal sin contemplar promociones porque hubo un error en el diseño :C */
SELECT id_sucursal, nombre, SUM(ticket_subtotal.total) ganancias
FROM
    ((SELECT id_sucursal, nombre, curp FROM
     sucursal NATURAL JOIN empleado WHERE es_mesero) sucursal_mesero
    JOIN
    (SELECT curp_empleado, num_ticket, sum(subtotal) total
    FROM
        ((SELECT curp_empleado, num_ticket, sum(cantidad * T1.precio) subtotal
        FROM ticket NATURAL JOIN registrar_comida NATURAL JOIN (SELECT clave_venta, precio, MAX(fecha)
                                  FROM historico_comida
                                  GROUP BY clave_venta, precio) T1
        GROUP BY num_ticket)
        UNION
        (SELECT curp_empleado, num_ticket, sum(cantidad * T2.precio) subtotal
        FROM ticket NATURAL JOIN registrar_salsas NATURAL JOIN (SELECT clave_venta, precio, MAX(fecha)
                                  FROM historico_salsas
                                  GROUP BY clave_venta, precio) T2
        GROUP BY num_ticket)) total_ticket
    GROUP BY curp_empleado, num_ticket) ticket_subtotal ON sucursal_mesero.curp = ticket_subtotal.curp_empleado)
GROUP BY id_sucursal, nombre;

/* 10. Ventas realizadas por sucursal y método de pago específico */
SELECT s.id_sucursal, s.nombre sucursal, t.metodo_pago, COUNT(*) numero_ventas FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
GROUP BY s.id_sucursal, sucursal, t.metodo_pago
ORDER BY s.id_sucursal;

/* 11. Ventas realizadas a domicilio o en sitio por sucursal */
SELECT s.id_sucursal, s.nombre sucursal,
  (CASE t.a_domicilio WHEN 't' THEN 'A DOMICILIO' ELSE 'EN SITIO' END) entrega,
  COUNT(*) numero_ventas
FROM sucursal s
JOIN empleado e ON s.id_sucursal = e.id_sucursal
JOIN ticket t ON e.curp = t.curp_empleado
GROUP BY s.id_sucursal, sucursal, entrega
ORDER BY s.id_sucursal, entrega;
