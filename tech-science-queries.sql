CREATE TABLE clientes (
    cliente_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL, 
    apellido_cliente VARCHAR(100) NOT NULL, 
    email VARCHAR(250) NOT NULL UNIQUE, 
    direccion VARCHAR(250) NOT NULL

);

INSERT INTO clientes (nombre_cliente, apellido_cliente, email, direccion) VALUES 
                     ('Juan', 'Ramirez', 'juanitor@gmail.com', 'Calle 189, Ciudad de Jalisco'),
                     ('Maria', 'Dolores', 'mdolores1@gmail.com', 'Calle 20, Ciudad Chocolate'),
                     ('Pedro', 'Picapiedra', 'ppicap1992@gmail.com', 'Cra 10, Calle 20, Ciudad de Piedra'),
                     ('Ramón', 'Valdez', 'donramon@gmail.com', 'Calle 10, la vecindad, ciudad de mexico');


CREATE TABLE productos (
    producto_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL UNIQUE, 
    stock_producto INTEGER NOT NULL, 
    fecha_vencimiento DATE NOT NULL,
    precio_producto DECIMAL(10, 2) NOT NULL
);

INSERT INTO productos (nombre_producto, stock_producto, fecha_vencimiento, precio_producto) VALUES
                        ('smart-biotic', '100', '2025-12-31', '150.00'),
                        ('cell-regenerator', '50', '2026-06-30', '1200.00'),
                        ('inmunitary system suppressor', '200', '2024-11-15', '300.00'),
                        ('neuron recover', '150', '2025-03-20', '250.00');

CREATE TABLE pedidos ( 
    pedido_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    cliente_id INTEGER NOT NULL REFERENCES clientes(cliente_id)
);

INSERT INTO pedidos (cliente_id) VALUES 
                    (1),
                    (2),
                    (3),
                    (4);

CREATE TABLE detalle_pedidos (
    detalle_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id INTEGER NOT NULL REFERENCES pedidos(pedido_id),
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id),
    cantidad INTEGER NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL
);

INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_venta) VALUES
                        (1, 1, 2, 300.00),
                        (1, 2, 1, 1200.00),
                        (3, 3, 3, 900.00),
                        (4, 4, 1, 250.00);

---- consultas con where y order by

SELECT pedido_id AS pedidos 
	FROM detalle_pedidos
	WHERE precio_venta > 300
	ORDER BY precio_venta DESC;

SELECT stock_producto AS stock
	FROM productos
	WHERE stock_producto > 50 
	ORDER BY precio_producto DESC;

SELECT nombre_cliente as cliente,
		cliente_id
	FROM clientes
	WHERE nombre_cliente LIKE 'Juan'
	ORDER BY cliente_id DESC; 

---- etapa 4:
--cruzar tablas con join
--calcular promedio y totales
--darle formato
--detectar clientes no activos con left join

--- query #1: cruzar tablas, promedio, total y formato
SELECT c.cliente_id as cliente, 
	COUNT(DISTINCT(p.pedido_id)) AS total_pedidos,
	TO_CHAR(SUM(dp.cantidad*dp.precio_venta), 'FM$999,999.00') as venta_total,
	TO_CHAR(AVG(dp.cantidad*dp.precio_venta), 'FM$999,999.00') AS ticket_promedio
	FROM clientes c 
INNER JOIN pedidos p ON c.cliente_id = p.cliente_id 
INNER JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
INNER JOIN productos pr ON dp.producto_id = pr.producto_id
GROUP BY c.cliente_id


----query #2: clientes inactivos
SELECT c.cliente_id as cliente, 
		c.email
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id 
WHERE p.pedido_id IS NULL
ORDER BY c.nombre_cliente; 