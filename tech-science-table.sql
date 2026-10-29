CREATE TABLE clientes (
    cliente_id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL UNIQUE, 
    apellido_cliente VARCHAR(100) NOT NULL UNIQUE, 
    email VARCHAR(250) NOT NULL UNIQUE, 
    direccion VARCHAR(250) NOT NULL,

);

INSERT INTO clientes (cliente_id, nombre_cliente, apellido_cliente, email, direccion) VALUES 
                     ('1', 'Juan', 'Ramirez', 'juanitor@gmail.com', 'Calle 189, Ciudad de Jalisco'),
                     ('2', 'Maria', 'Dolores', 'mdolores1@gmail.com', 'Calle 20, Ciudad Chocolate'),
                     ('3', 'Pedro', 'Picapiedra', 'ppicap1992@gmail.com', 'Cra 10, Calle 20, Ciudad de Piedra'),
                     ('4', 'Ramón', 'Valdez', 'donramon@gmail.com', 'Calle 10, la vecindad, ciudad de mexico');


CREATE TABLE productos (
    producto_id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL UNIQUE, 
    stock_producto INTEGER NOT NULL, 
    fecha_vencimiento DATE NOT NULL,
    precio_producto DECIMA(10, 2) NOT NULL,
);

INSERT INTO productos (producto_id, nombre_producto, stock_producto, fecha_vencimiento, precio_producto) VALUES
                        ('1', 'smart-biotic', '100', '2025-12-31', '150.00'),
                        ('2', 'cell-regenerator', '50', '2026-06-30', '1200.00'),
                        ('3', 'inmunitary system suppressor', '200', '2024-11-15', '300.00'),
                        ('4', 'neuron recover', '150', '2025-03-20', '250.00');

CREATE TABLE pedidos ( 
    pedido_id GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    cliente_id INTEGER NOT NULL REFERENCES clientes(cliente_id),
);

INSERT INTO pedidos (pedido_id, cliente_id) VALUES 
                    ('1', '1'),
                    ('2', '2'),
                    ('3', '3'),
                    ('4', '4');

CREATE TABLE detalle_pedidos (
    detalle_id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id),
    cantidad INTEGER NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
)

INSERT INTO detalle_pedidos (detalle_id, producto_id, cantidad, precio_venta) VALUES
                        ('1', '1', '2', '300.00'),
                        ('2', '2', '1', '1200.00'),
                        ('3', '3', '3', '900.00'),
                        ('4', '4', '1', '250.00');
