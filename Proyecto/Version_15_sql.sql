SET QUOTED_IDENTIFIER ON;
GO

CREATE DATABASE bdimprenta;
GO

USE bdimprenta;
GO

-- Tabla usuario
CREATE TABLE usuario (
  id_usuario INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(100),
  pass VARCHAR(255),
  tipo VARCHAR(20) CHECK (tipo IN ('admin', 'cajero', 'diseñador', 'cliente', 'empleado')),
  estado VARCHAR(20) CHECK (estado IN ('activo', 'inactivo')),
  perfil_completo BIT,
  cod_confirmacion VARCHAR(20),
  f_creacion DATETIME DEFAULT GETDATE()
);

-- Tabla cliente

CREATE TABLE cliente (
  id_cliente INT IDENTITY(1,1) PRIMARY KEY,
  id_usuario INT,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  dni VARCHAR(20),
  celular VARCHAR(12),
  direccion VARCHAR(100),
  cod_ubigeo VARCHAR(8) NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla empleado
CREATE TABLE empleado (
  id_empleado INT IDENTITY(1,1) PRIMARY KEY,
  id_usuario INT,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  celular VARCHAR(12),
  cargo VARCHAR(20),
  sueldo INT,
  fecha_contratacion DATE,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla proveedor
CREATE TABLE proveedor (
  id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(150),
  ruc CHAR(11),
  celular VARCHAR(12),
  email VARCHAR(100),
  direccion VARCHAR(200)
);

-- Tabla insumo
CREATE TABLE insumo (
  id_insumo INT IDENTITY(1,1) PRIMARY KEY,
  descripcion VARCHAR(150),
  stock INT,
  precio_compra FLOAT
);

-- Tabla ingreso
CREATE TABLE ingreso (
  id_ingreso INT IDENTITY(1,1) PRIMARY KEY,
  id_insumo INT NOT NULL,
  fecha DATETIME DEFAULT GETDATE(),
  cantidad INT NOT NULL,
  costo_unitario DECIMAL(10,2),
  costo_total AS (cantidad * costo_unitario) PERSISTED,
  observaciones TEXT,
  id_proveedor INT,
  FOREIGN KEY (id_insumo) REFERENCES insumo(id_insumo),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- Tabla producto
CREATE TABLE producto (
  id_producto INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(50),
  precio_base INT,
  unidad_venta VARCHAR(50)
);

-- Tabla pedido
CREATE TABLE pedido (
  id_pedido INT IDENTITY(1,1) PRIMARY KEY,
  id_cliente INT,
  id_empleado INT,
  fecha_pedido DATETIME DEFAULT GETDATE(),
  estado VARCHAR(20) CHECK (estado IN ('pendiente', 'asignado', 'procesando', 'completado')),
  total DECIMAL(10,2),
  pagado BIT,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tabla detalle_pedido
CREATE TABLE detalle_pedido (
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  descripcion TEXT,
  altura FLOAT,
  ancho FLOAT,
  cantidad INT,
  id_insumo INT,
  url_img VARCHAR(400),
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_insumo) REFERENCES insumo(id_insumo)
);

-- Tabla cita
CREATE TABLE cita (
  id_cita INT IDENTITY(1,1) PRIMARY KEY,
  fecha DATE,
  horario VARCHAR(20) CHECK (horario IN ('09:00', '10:00', '15:00', '16:00', '12:20', '12:25', '12:15')),
  estado VARCHAR(20) CHECK (estado IN ('programada', 'realizada', 'cancelada')),
  descripcion VARCHAR(200),
  f_creacion DATETIME DEFAULT GETDATE(),
  id_cliente INT NOT NULL,
  id_empleado INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tabla ubigeo
CREATE TABLE ubigeo (
  cod_ubigeo VARCHAR(6) PRIMARY KEY,
  descripcion VARCHAR(29),
  cod_ubigeo_sup VARCHAR(4)
);

use bdimprenta;
SET DATEFORMAT YMD;
INSERT INTO usuario (email, pass, tipo, estado, perfil_completo, cod_confirmacion, f_creacion)
VALUES
    ('jf2021070309@virtual.upt.pe', '$2y$10$s25AKkF192XyRW.tEzj/OubiPWzNPVX7tubiS/TZ9BBM.wD5Y4HQm', 'cliente', NULL, NULL, NULL, '2024-10-29 05:52:35'),
    ('andresebast16@gmail.com', '$2y$10$s25AKkF192XyRW.tEzj/OubiPWzNPVX7tubiS/TZ9BBM.wD5Y4HQm', 'cliente', 'activo', NULL, '310135', '2024-10-31 18:11:30'),
    ('flores.2003@gmail.com', '$2y$10$o4plXaPnFq1wSGZloReWmON5gQpqgFy9fkdkG7J9Sn/3fWG37oT3G', 'cliente', 'activo', NULL, '405099', '2024-10-31 18:18:56'),
    ('elvisleyva49@gmail.com', '$2y$10$s/uZYslYXOXgGv.yC3CeeODMUV.5..w5yygx.oRT4l/cO1XucnUgK', 'diseñador', 'activo', NULL, '402718', '2024-11-25 10:02:12'),
    ('chetochems2801@gmail.com', '$2y$10$sbNadtH7qGw4o7eRpdjxLuruQRtoVbVgViWEeudwcoTH38pvNuY1G', 'diseñador', 'activo', NULL, '246794', '2024-11-25 10:04:58'),
    ('elvisleyva2801@gmail.com', '$2y$10$FLUPeuSJJ7L3MJr6qnQuU.U36lo4upZnNdO66fX0NJ4xhdYNKx/SO', 'admin', 'activo', NULL, '713662', '2024-11-28 10:06:19'),
    ('showerflores056@gmail.com', '$2y$10$KVHsucxJRCJzHrgOoXlnb.rVA.mmrn.H0yqb2Kfli0HTD63Kt0asK', 'cliente', 'activo', NULL, '929092', '2024-11-28 13:44:42'),
    ('jkdev38@gmail.com', '$2y$10$hrtW1hDXTkvGoTsJvEgdyOU0cWDxRhv2sa3RZHeplOyfsHYUmsIUC', 'cajero', 'activo', NULL, '279374', '2024-11-28 18:25:26'),
    ('yoelflores.tacna.2016@gmail.com', '$2y$10$Ifinu7Ot5vSYjx5VlQlRF.3I08DB.dr5Y8ZD3YGJeIgOWICBXs/x2', 'cliente', 'activo', NULL, '861948', '2024-11-28 20:39:23');


INSERT INTO cliente (id_usuario, nombre, apellido, dni, celular, direccion, cod_ubigeo) 
VALUES
    (2, 'Andree Blast', 'Melendez', '76032957', '957084266', '', ''),
    (3, 'Maria', 'Flores', '32424300', '981289891', '', ''),
    (7, 'Elvis', 'Leyva', '73860728', '971899955', '', ''),
    (8, 'Giacomo', 'Bocchio', '86566886', '929929599', '', ''),
    (9, 'Jk', 'Developers', '72252165', '999992266', '', ''),
    (4, 'Yoelito', 'Flores', '78985665', '984894844', '', '');

INSERT INTO empleado (id_usuario, nombre, apellido, celular, cargo, sueldo, fecha_contratacion)
VALUES
(2, 'Andrés', 'Sebastián', '912345678', 'Diseñador', 2500, '2024-10-31');
