-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para bdimprenta
CREATE DATABASE IF NOT EXISTS `bdimprenta` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `bdimprenta`;

-- Volcando estructura para tabla bdimprenta.cita
CREATE TABLE IF NOT EXISTS `cita` (
  `id_cita` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `horario` enum('09:00','10:00','15:00','16:00','12:20','12:25','12:15') DEFAULT NULL,
  `estado` enum('programada','realizada','cancelada') DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `f_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_cliente` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.cita: ~8 rows (aproximadamente)
INSERT INTO `cita` (`id_cita`, `fecha`, `horario`, `estado`, `descripcion`, `f_creacion`, `id_cliente`, `id_empleado`) VALUES
	(1, '2024-11-05', NULL, 'programada', 'Reunión para discutir el diseño del proyecto', '2024-10-31 19:25:05', 1, 1),
	(13, '2024-12-02', '', 'programada', 'cita 7', '2024-12-02 15:36:55', 6, 1),
	(14, '2024-12-02', '', 'programada', 'cita 8', '2024-12-02 15:39:57', 1, 1),
	(16, '2024-12-02', '', 'programada', 'cita 9', '2024-12-02 15:40:31', 4, 1),
	(19, '2024-12-02', '', 'programada', 'citaaaa', '2024-12-02 16:22:33', 1, 1),
	(21, '2024-12-02', '', 'programada', 'gaa', '2024-12-02 16:41:00', 4, 1),
	(23, '2024-12-02', '', 'programada', 'nueva cita', '2024-12-02 16:43:17', 4, 1),
	(24, '2024-12-02', '12:15', 'programada', 'cita pa blast', '2024-12-02 17:06:27', 1, 1);

-- Volcando estructura para tabla bdimprenta.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `celular` varchar(12) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `cod_ubigeo` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.cliente: ~5 rows (aproximadamente)
INSERT INTO `cliente` (`id_cliente`, `id_usuario`, `nombre`, `apellido`, `dni`, `celular`, `direccion`, `cod_ubigeo`) VALUES
	(1, 2, 'Andree Blast', 'Melendez', '76032957', '957084266', '', '230110'),
	(2, 3, 'Maria', 'Flores', '32424300', '981289891', '', '230108'),
	(3, 7, 'Elvis', 'Leyva', '73860728', '971899955', NULL, '230108'),
	(4, 8, 'Giacomo', 'Bocchio', '86566886', '929929599', '', '230101'),
	(5, 9, 'Jk', 'Developers', '72252165', '999992266', '', '180206'),
	(6, 10, 'Yoelito', 'Flores', '78985665', '984894844', '', '070105');

-- Volcando estructura para tabla bdimprenta.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `altura` float DEFAULT NULL,
  `ancho` float DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `id_insumo` int(11) DEFAULT NULL,
  `url_img` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  KEY `id_insumo` (`id_insumo`),
  CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `detalle_pedido_ibfk_3` FOREIGN KEY (`id_insumo`) REFERENCES `insumo` (`id_insumo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.detalle_pedido: ~19 rows (aproximadamente)
INSERT INTO `detalle_pedido` (`id_pedido`, `id_producto`, `descripcion`, `altura`, `ancho`, `cantidad`, `id_insumo`, `url_img`) VALUES
	(1, 2, 'Millar de volantes publicitarios', 29.7, 21, 1, 5, NULL),
	(2, 3, 'Stickers adhesivos personalizados', 10, 10, 2, 3, NULL),
	(2, 7, 'Pines personalizados (100 unidades)', NULL, NULL, 1, 6, NULL),
	(3, 1, 'Tarjetas de presentación estándar', 9, 5, 1, 2, NULL),
	(4, 6, 'Roll Screen con impresión personalizada', 100, 85, 1, 6, NULL),
	(5, 4, 'Banner delgado (8 onzas)', 200, 150, 2, 7, NULL),
	(6, 5, 'Lona publicitaria personalizada', 200, 200, 1, 3, NULL),
	(7, 1, 'Tarjeta Mate Millar con nombre Blast ', 5.5, 9, 1, 16, NULL),
	(8, 6, 'Estructura + Impresión (1m x 0.85m) x 4 unidades', 100, 0.85, 4, 14, NULL),
	(9, 5, 'Lona x 5 unidades', 24, 26, 5, 8, NULL),
	(10, 2, 'A5 Millar Volantes x 4 unidades', 14.8, 21, 4, 12, NULL),
	(11, 2, 'A5 Millar Volantes x 4 unidades', 14.8, 21, 4, 13, NULL),
	(12, 3, 'm² Económico: s/.22.00 x 5', 10, 10, 5, 18, NULL),
	(13, 2, 'A5 Millar Volantes: s/.140.00 x 10 unidades', 14.8, 21, 10, 12, NULL),
	(14, 6, 'Estructura + Impresión (1m x 0.85m): s/.90.00 x 15 unidades', 100, 0.85, 15, 14, NULL),
	(15, 8, 'Llaveros x 30', 5, 5, 30, 20, NULL),
	(16, 2, 'A5 Millar Volantes: s/.140.00 x 3 unidades', 14.8, 21, 3, 13, NULL),
	(17, 4, 'Banner Spiderman x 12 ', 14.8, 21, 12, 1, NULL),
	(18, 6, 'Roll Screen Emprendimiento x 5', 100, 200, 5, 14, 'https://dalleprodsec.blob.core.windows.net/private/images/9c37649b-6218-439b-87aa-7c50cd4d864a/generated_00.png?se=2024-11-29T20%3A08%3A46Z&sig=9QRj4xidXE9s8lQaMmrcgSIeSD5GBACn0VRPKdEHftA%3D&ske=2024-12-05T16%3A43%3A49Z&skoid=e52d5ed7-0657-4f62-bc12-7e5dbb260a96&sks=b&skt=2024-11-28T16%3A43%3A49Z&sktid=33e01921-4d64-4f8c-a055-5bdaffd5e33d&skv=2020-10-02&sp=r&spr=https&sr=b&sv=2020-10-02'),
	(19, 5, 'Lona de Pizzas x 50 ', 100, 200, 50, 8, 'https://dalleprodsec.blob.core.windows.net/private/images/27d54e8e-92c2-433b-8fd7-803a5da62c5e/generated_00.png?se=2024-11-29T20%3A15%3A30Z&sig=yZPuM%2FOgk69Ytg36DrBvncBK0Qvgz3X%2BmWWqlZFfZw4%3D&ske=2024-12-05T20%3A02%3A29Z&skoid=e52d5ed7-0657-4f62-bc12-7e5dbb260a96&sks=b&skt=2024-11-28T20%3A02%3A29Z&sktid=33e01921-4d64-4f8c-a055-5bdaffd5e33d&skv=2020-10-02&sp=r&spr=https&sr=b&sv=2020-10-02');

-- Volcando estructura para tabla bdimprenta.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `celular` varchar(12) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `sueldo` int(11) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.empleado: ~3 rows (aproximadamente)
INSERT INTO `empleado` (`id_empleado`, `id_usuario`, `nombre`, `apellido`, `celular`, `cargo`, `sueldo`, `fecha_contratacion`) VALUES
	(1, 2, 'Andrés', 'Sebastián', '912345678', 'Diseñador', 2500, '2024-10-31'),
	(2, 4, 'Elvis', 'Leyva', '987654321', 'Diseñador', 1500, '2023-01-15'),
	(3, 5, 'Chems', 'Chems', '912345678', 'Diseñador', 1200, '2022-11-20');

-- Volcando estructura para tabla bdimprenta.ingreso
CREATE TABLE IF NOT EXISTS `ingreso` (
  `id_ingreso` int(11) NOT NULL AUTO_INCREMENT,
  `id_insumo` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cantidad` int(11) NOT NULL,
  `costo_unitario` decimal(10,2) DEFAULT NULL,
  `costo_total` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `costo_unitario`) STORED,
  `observaciones` text DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ingreso`),
  KEY `id_insumo` (`id_insumo`),
  KEY `fk_proveedor` (`id_proveedor`),
  CONSTRAINT `fk_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE,
  CONSTRAINT `ingreso_ibfk_1` FOREIGN KEY (`id_insumo`) REFERENCES `insumo` (`id_insumo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.ingreso: ~9 rows (aproximadamente)
INSERT INTO `ingreso` (`id_ingreso`, `id_insumo`, `fecha`, `cantidad`, `costo_unitario`, `observaciones`, `id_proveedor`) VALUES
	(3, 2, '2024-10-31 06:25:16', 10, 5.00, '', 4),
	(4, 3, '2024-10-30 19:36:38', 50, 1.00, 'Pliegos de cartulina', 5),
	(5, 2, '2024-10-31 06:24:23', 30, 2.00, '', 1),
	(6, 5, '2024-10-31 06:26:43', 5, 1.00, '', 3),
	(7, 6, '2024-10-31 06:28:21', 30, 40.00, '', 4),
	(8, 7, '2024-10-31 06:29:03', 5, 5.00, '', 5),
	(9, 7, '2024-10-31 06:29:47', 10, 10.00, '', 2),
	(10, 5, '2024-11-25 05:32:13', 10, 0.80, '', 5),
	(11, 5, '2024-11-25 09:41:42', 5, 1.00, '', 3),
	(12, 23, '2024-11-28 20:37:26', 50, 12.00, 'Buena calidad', 10);

-- Volcando estructura para tabla bdimprenta.insumo
CREATE TABLE IF NOT EXISTS `insumo` (
  `id_insumo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio_compra` float DEFAULT NULL,
  PRIMARY KEY (`id_insumo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.insumo: ~22 rows (aproximadamente)
INSERT INTO `insumo` (`id_insumo`, `descripcion`, `stock`, `precio_compra`) VALUES
	(1, 'Banner delgado 1.6 m', 288, 10.5),
	(2, 'Banner delgado 2.2 m', 390, 15),
	(3, 'Banner delgado 3 m', 550, 20),
	(4, 'Banner grueso 1.6 m', 250, 12),
	(5, 'Banner grueso 2.2 m', 155, 18),
	(6, 'Banner grueso 3 m', 330, 25),
	(7, 'Lona translúcida gruesa 1.6 m', 365, 14),
	(8, 'Lona translúcida gruesa 2.2 m', 350, 20),
	(9, 'Lona translúcida gruesa 3 m', 300, 27),
	(10, 'Papel Couche A3', 1000, 80),
	(11, 'Papel Couche A4', 2000, 75),
	(12, 'Papel Couche A5', 1990, 70),
	(13, 'Papel Couche A6', 1991, 45),
	(14, 'Roll Screen 0.8 m x 2 m', 0, 35),
	(15, 'Roll Screen 1 m x 2 m', 15, 40),
	(16, 'Tarjeta mate', 1000, 0.1),
	(17, 'Tarjeta brillo', 1000, 0.12),
	(18, 'Sticker adhesivo estándar', 495, 90),
	(19, 'Sticker adhesivo premium', 300, 95),
	(20, 'Llaveros', 120, 0.8),
	(21, 'Pines', 100, 0.8),
	(22, 'Hoja A4', 0, 10),
	(23, 'Hoja A3', 50, 15);

-- Volcando estructura para procedimiento bdimprenta.obtenerDPyD
DELIMITER //
CREATE PROCEDURE `obtenerDPyD`(
    IN `codUbigeo` VARCHAR(10)
)
BEGIN
    SELECT 
        (SELECT descripcion 
         FROM ubigeo 
         WHERE cod_ubigeo = codUbigeo 
         LIMIT 1) AS DESCRIPCION,
         
        (SELECT descripcion 
         FROM ubigeo 
         WHERE cod_ubigeo = (SELECT cod_ubigeo_sup 
                             FROM ubigeo 
                             WHERE cod_ubigeo = codUbigeo)
         LIMIT 1) AS PROVINCIA,
        
        (SELECT descripcion 
         FROM ubigeo 
         WHERE cod_ubigeo = (SELECT cod_ubigeo_sup 
                             FROM ubigeo 
                             WHERE cod_ubigeo = (SELECT cod_ubigeo_sup 
                                                 FROM ubigeo 
                                                 WHERE cod_ubigeo = codUbigeo))
         LIMIT 1) AS DEPARTAMENTO;
END//
DELIMITER ;

-- Volcando estructura para tabla bdimprenta.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','asignado','procesando','completado') DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `pagado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.pedido: ~19 rows (aproximadamente)
INSERT INTO `pedido` (`id_pedido`, `id_cliente`, `id_empleado`, `fecha_pedido`, `estado`, `total`, `pagado`) VALUES
	(1, 1, NULL, '2024-11-18 15:00:00', 'pendiente', 280.00, 0),
	(2, 1, 1, '2024-11-18 15:30:00', 'asignado', 112.00, 0),
	(3, 1, 1, '2024-11-18 16:00:00', 'procesando', 75.00, 0),
	(4, 2, NULL, '2024-11-18 16:30:00', 'pendiente', 90.00, 1),
	(5, 2, 1, '2024-11-18 17:00:00', 'asignado', 140.00, 1),
	(6, 2, 1, '2024-11-18 17:30:00', 'completado', 25.00, 0),
	(7, 1, NULL, '2024-11-28 12:15:01', 'pendiente', 75.00, NULL),
	(8, 1, 2, '2024-11-28 12:24:27', 'pendiente', 360.00, NULL),
	(9, 1, NULL, '2024-11-28 12:29:48', 'pendiente', 40.00, NULL),
	(10, 4, 2, '2024-11-28 21:19:16', 'pendiente', 560.00, NULL),
	(11, 4, 2, '2024-11-28 21:22:52', 'pendiente', 70.00, NULL),
	(12, 4, NULL, '2024-11-28 21:26:04', 'pendiente', 110.00, 1),
	(13, 4, NULL, '2024-11-28 21:27:16', 'pendiente', 1400.00, NULL),
	(14, 4, NULL, '2024-11-28 21:32:52', 'pendiente', 1350.00, NULL),
	(15, 1, NULL, '2024-11-28 22:32:37', 'pendiente', 2100.00, NULL),
	(16, 4, NULL, '2024-11-29 01:54:04', 'pendiente', 70.00, NULL),
	(17, 4, NULL, '2024-11-29 01:57:31', 'pendiente', 8.00, NULL),
	(18, 4, NULL, '2024-11-29 02:08:58', 'pendiente', 90.00, NULL),
	(19, 4, 2, '2024-11-29 02:15:39', 'asignado', 8.00, NULL);

-- Volcando estructura para tabla bdimprenta.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `precio_base` int(11) DEFAULT NULL,
  `unidad_venta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.producto: ~8 rows (aproximadamente)
INSERT INTO `producto` (`id_producto`, `nombre`, `precio_base`, `unidad_venta`) VALUES
	(1, 'Tarjetas de Presentación', 75, 'por paquete de 100'),
	(2, 'Volantes', 280, 'por millar'),
	(3, 'Stickers Adhesivos', 22, 'por metro cuadrado'),
	(4, 'Banners Personalizados', 8, 'por metro cuadrado'),
	(5, 'Lonas Luminosas', 25, 'por metro cuadrado'),
	(6, 'Roll Screen', 90, 'por estructura (1m x 0.85m)'),
	(7, 'Pines', 70, 'por paquete de 100'),
	(8, 'Llaveros', 70, 'por paquete de 100');

-- Volcando estructura para tabla bdimprenta.proveedor
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) DEFAULT NULL,
  `ruc` char(11) DEFAULT NULL,
  `celular` varchar(12) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.proveedor: ~7 rows (aproximadamente)
INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `ruc`, `celular`, `email`, `direccion`) VALUES
	(1, 'TechCo', '20412345678', '987654321', 'info@techco.com', 'Av. 1'),
	(2, 'EcoGoods', '20487654321', '963852741', 'contact@ecogoods.com', 'Av. 2'),
	(3, 'PrintHub', '20523456789', '741258963', 'sales@printhub.com', 'Av. 3'),
	(4, 'FastServ', '20634567890', '852963741', 'support@fastserv.com', 'Av. 4'),
	(5, 'QuickMart', '20745678901', '321654987', 'hello@quickmart.com', 'Av. 5'),
	(9, 'San Fierro', '20745678512', '945113332', 'sanfierro@gmail.com', 'C/ Los palos, 10'),
	(10, 'Insumos Inc', '20745678508', '945113361', 'insumosinc@gmail.com', 'C/ Las rosas, 10');

-- Volcando estructura para tabla bdimprenta.ubigeo
CREATE TABLE IF NOT EXISTS `ubigeo` (
  `cod_ubigeo` varchar(6) DEFAULT NULL,
  `descripcion` varchar(29) DEFAULT NULL,
  `cod_ubigeo_sup` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla bdimprenta.ubigeo: ~2.063 rows (aproximadamente)
INSERT INTO `ubigeo` (`cod_ubigeo`, `descripcion`, `cod_ubigeo_sup`) VALUES
	('23', 'TACNA', ''),
	('2301', 'TACNA', '23'),
	('230101', 'TACNA', '2301'),
	('230102', 'ALTO DE LA ALIANZA', '2301'),
	('230103', 'CALANA', '2301'),
	('230104', 'CIUDAD NUEVA', '2301'),
	('230105', 'INCLAN', '2301'),
	('230106', 'PACHIA', '2301'),
	('230107', 'PALCA', '2301'),
	('230108', 'POCOLLAY', '2301'),
	('230109', 'SAMA', '2301'),
	('230110', 'GREGORIO ALBARRACIN', '2301');

-- Volcando estructura para tabla bdimprenta.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `tipo` enum('admin','cajero','diseñador','cliente','empleado') DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT NULL,
  `perfil_completo` tinyint(1) DEFAULT NULL,
  `cod_confirmacion` varchar(20) DEFAULT NULL,
  `f_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla bdimprenta.usuario: ~8 rows (aproximadamente)
INSERT INTO `usuario` (`id_usuario`, `email`, `pass`, `tipo`, `estado`, `perfil_completo`, `cod_confirmacion`, `f_creacion`) VALUES
	(1, 'jf2021070309@virtual.upt.pe', '$2y$10$s25AKkF192XyRW.tEzj/OubiPWzNPVX7tubiS/TZ9BBM.wD5Y4HQm', 'cliente', '', NULL, NULL, '2024-10-29 05:52:35'),
	(2, 'andresebast16@gmail.com', '$2y$10$s25AKkF192XyRW.tEzj/OubiPWzNPVX7tubiS/TZ9BBM.wD5Y4HQm', 'cliente', 'activo', NULL, '310135', '2024-10-31 18:11:30'),
	(3, 'flores.2003@gmail.com', '$2y$10$o4plXaPnFq1wSGZloReWmON5gQpqgFy9fkdkG7J9Sn/3fWG37oT3G', 'cliente', 'activo', NULL, '405099', '2024-10-31 18:18:56'),
	(4, 'elvisleyva49@gmail.com', '$2y$10$s/uZYslYXOXgGv.yC3CeeODMUV.5..w5yygx.oRT4l/cO1XucnUgK', 'diseñador', 'activo', NULL, '402718', '2024-11-25 10:02:12'),
	(5, 'chetochems2801@gmail.com', '$2y$10$sbNadtH7qGw4o7eRpdjxLuruQRtoVbVgViWEeudwcoTH38pvNuY1G', 'diseñador', 'activo', NULL, '246794', '2024-11-25 10:04:58'),
	(7, 'elvisleyva2801@gmail.com', '$2y$10$FLUPeuSJJ7L3MJr6qnQuU.U36lo4upZnNdO66fX0NJ4xhdYNKx/SO', 'admin', 'activo', NULL, '713662', '2024-11-28 10:06:19'),
	(8, 'showerflores056@gmail.com', '$2y$10$KVHsucxJRCJzHrgOoXlnb.rVA.mmrn.H0yqb2Kfli0HTD63Kt0asK', 'cliente', 'activo', NULL, '929092', '2024-11-28 13:44:42'),
	(9, 'jkdev38@gmail.com', '$2y$10$hrtW1hDXTkvGoTsJvEgdyOU0cWDxRhv2sa3RZHeplOyfsHYUmsIUC', 'cajero', 'activo', NULL, '279374', '2024-11-28 18:25:26'),
	(10, 'yoelflores.tacna.2016@gmail.com', '$2y$10$Ifinu7Ot5vSYjx5VlQlRF.3I08DB.dr5Y8ZD3YGJeIgOWICBXs/x2', 'cliente', 'activo', NULL, '861948', '2024-11-28 20:39:23');

-- Volcando estructura para disparador bdimprenta.actualizar_stock_insumo
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizar_stock_insumo` AFTER INSERT ON `ingreso` FOR EACH ROW BEGIN
    UPDATE insumo
    SET stock = stock + NEW.cantidad
    WHERE id_insumo = NEW.id_insumo;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
