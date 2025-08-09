CREATE DATABASE IF NOT EXISTS bd_carrito;
USE bd_carrito;
-- Dbase carrito de compras
-- by @moleculax fue creado a partir de visualizacion de esquema
CREATE TABLE IF NOT EXISTS  perfiles (
    id_perfil BIGINT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS  usuarios (
    id_usuario BIGINT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(150),
    password VARCHAR(255),
    id_perfil BIGINT,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);

CREATE TABLE IF NOT EXISTS  direcciones (
    id_direccion BIGINT PRIMARY KEY,
    id_usuario BIGINT,
    direccion TEXT,
    pais VARCHAR(100),
    ciudad VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE IF NOT EXISTS  metodos_pago (
    id_metodo_pago BIGINT PRIMARY KEY,
    descripcion VARCHAR(100),
    estado CHAR(1)
);

CREATE TABLE IF NOT EXISTS  metodos_pago_usuario (
    id_metodo_pago_usuario BIGINT PRIMARY KEY,
    id_usuario BIGINT,
    id_metodo_pago BIGINT,
    datos JSON,
    estado CHAR(1),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodos_pago(id_metodo_pago)
);

CREATE TABLE IF NOT EXISTS  productos (
    id_producto BIGINT PRIMARY KEY,
    nombre VARCHAR(150),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT
);

CREATE TABLE IF NOT EXISTS  carritos (
    id_carrito BIGINT PRIMARY KEY,
    id_usuario BIGINT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    estado CHAR(1),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE IF NOT EXISTS  carrito_detalles (
    id_detalle_carrito BIGINT PRIMARY KEY,
    id_carrito BIGINT,
    id_producto BIGINT,
    cantidad INT,
    FOREIGN KEY (id_carrito) REFERENCES carritos(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE IF NOT EXISTS  compras (
    id_compra BIGINT PRIMARY KEY,
    id_usuario BIGINT,
    fecha_pedido TIMESTAMP,
    sub_total DECIMAL(10,2),
    iva DECIMAL(10,2),
    total DECIMAL(10,2),
    id_direccion BIGINT,
    id_metodo_pago_usuario BIGINT,
    estado CHAR(1),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion),
    FOREIGN KEY (id_metodo_pago_usuario) REFERENCES metodos_pago_usuario(id_metodo_pago_usuario)
);

CREATE TABLE IF NOT EXISTS  compra_detalles (
    id_compra_detalle BIGINT PRIMARY KEY,
    id_compra BIGINT,
    id_producto BIGINT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE IF NOT EXISTS  pagos (
    id_pago BIGINT PRIMARY KEY,
    id_compra BIGINT,
    id_metodo_pago_usuario BIGINT,
    monto DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_metodo_pago_usuario) REFERENCES metodos_pago_usuario(id_metodo_pago_usuario)
);