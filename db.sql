DROP DATABASE IF EXISTS techzone;
CREATE DATABASE techzone;
\c techzone;

CREATE TABLE IF NOT EXISTS tienda (
    id serial PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS proveedor (
    id serial PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(255),
    telefono VARCHAR(20)
);

CREATE TYPE tipo_categoria AS ENUM ('Accesorios', 'Celulares', 'Laptops', 'Componente Electrónico');

CREATE TABLE IF NOT EXISTS producto (
    id serial PRIMARY KEY,
    nombre VARCHAR(50),
    categoria tipo_categoria,
    precio DECIMAL(10,2),
    stock INTEGER
);

CREATE TABLE IF NOT EXISTS cliente (
    id serial PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(255),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS venta (
    id serial PRIMARY KEY,
    id_cliente INTEGER,
    fecha_venta DATE,
    CONSTRAINT cliente_id_FK FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS detalle_venta (
    id serial PRIMARY KEY,
    id_venta INTEGER,
    id_producto INTEGER,
    cantidad INTEGER,
    CONSTRAINT venta_id_FK FOREIGN KEY (id_venta) REFERENCES venta(id) ON DELETE CASCADE,
    CONSTRAINT producto_id_FK FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS producto_proveedor (
    id serial PRIMARY KEY,
    id_producto INTEGER,
    id_proveedor INTEGER,
    CONSTRAINT producto_proveedor_id_FK FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE CASCADE,
    CONSTRAINT proveedor_producto_id_FK FOREIGN KEY (id_proveedor) REFERENCES proveedor(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS proveedor_tienda (
    id serial PRIMARY KEY,
    id_tienda INTEGER,
    id_proveedor INTEGER,
    CONSTRAINT tienda_id_FK FOREIGN KEY (id_tienda) REFERENCES tienda(id) ON DELETE CASCADE,
    CONSTRAINT proveedor_tienda_id_FK FOREIGN KEY (id_proveedor) REFERENCES proveedor(id) ON DELETE CASCADE
);