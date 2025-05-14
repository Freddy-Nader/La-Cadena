-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 14, 2025 at 11:59 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `la_cadena`
--

-- --------------------------------------------------------

--
-- Table structure for table `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `id_usuario`, `id_producto`) VALUES
(1, 3, 12),
(2, 1, 4),
(3, 7, 19),
(4, 5, 2),
(5, 10, 25),
(6, 14, 11),
(7, 8, 33),
(8, 6, 7),
(9, 2, 17),
(10, 13, 22);

-- --------------------------------------------------------

--
-- Table structure for table `historial`
--

CREATE TABLE `historial` (
  `id_compra` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `historial`
--

INSERT INTO `historial` (`id_compra`, `id_usuario`, `id_producto`) VALUES
(1, 1, 3),
(2, 1, 5),
(3, 2, 6),
(4, 2, 15),
(5, 3, 1),
(6, 3, 9),
(7, 4, 12),
(8, 4, 18),
(9, 5, 22),
(10, 5, 8),
(11, 6, 20),
(12, 6, 25),
(13, 7, 7),
(14, 7, 10),
(15, 8, 2),
(16, 8, 26),
(17, 9, 13),
(18, 9, 33),
(19, 10, 4),
(20, 10, 31),
(21, 11, 5),
(22, 11, 29),
(23, 12, 6),
(24, 12, 19),
(25, 13, 8),
(26, 13, 23),
(27, 14, 3),
(28, 14, 28),
(29, 15, 11),
(30, 15, 21);

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `num_serie` varchar(30) NOT NULL COMMENT 'Nombre/número de serie establecido por el fabricante. Se usa en los URLs de las imágenes.',
  `descripcion` varchar(300) NOT NULL,
  `fabricante` varchar(50) NOT NULL,
  `materiales` varchar(50) NOT NULL,
  `colores` varchar(50) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `precio` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `num_serie`, `descripcion`, `fabricante`, `materiales`, `colores`, `stock`, `precio`) VALUES
(1, 'Marcador Permanente Punta Cincel Rojo', 'PA-MAP2050HA', 'Marcador resistente de tinta indeleble para múltiples superficies.', 'Pascua', 'Plástico, tinta permanente', 'Rojo', 144, 6),
(2, 'Marcador Permanente Punta Cincel Negro', 'PA-MAP2050A', 'Marcador ideal para etiquetado permanente con tinta negra duradera.', 'Pascua', 'Plástico, tinta permanente', 'Negro', 144, 6),
(3, 'Marcador Permanente Punta Cincel Azul', 'PA-MAP2050AZ', 'Marcador versátil de color azul, punta cincel para trazos gruesos.', 'Pascua', 'Plástico, tinta permanente', 'Azul', 144, 6),
(4, 'Marcador Doble Punta Permanente Colores', 'PA-MAP2050SUR', 'Marcador con doble punta y variedad de colores para uso intensivo.', 'Pascua', 'Plástico, tinta', 'Surtido', 144, 8),
(5, 'Marcador de Pizarrón Blanco Negro', 'PA-MAP26A', 'Marcador para pizarras blancas, borrado fácil y limpio.', 'Pascua', 'Plástico, tinta para pizarra', 'Negro', 144, 6),
(6, 'Marcador de Pizarrón Blanco Rojo', 'PA-MAP26R', 'Marcador de borrado en seco color rojo para pizarras blancas.', 'Pascua', 'Plástico, tinta para pizarra', 'Rojo', 144, 6),
(7, 'Marcador de Pizarrón Blanco Azul', 'PA-MAP26AZ', 'Marcador de borrado en seco con tinta azul.', 'Pascua', 'Plástico, tinta para pizarra', 'Azul', 144, 6),
(8, 'Marcador de Pizarrón Blanco Surtido', 'PA-MAP26SUR', 'Set de marcadores de pizarra con varios colores.', 'Pascua', 'Plástico', 'Surtido', 144, 7),
(9, 'Marcatextos Colores Neon Blister 4 PZ Surt', 'MAT-1081-SET', 'Marcatextos de colores neón en presentación blister.', 'Pascua', 'Plástico, tinta fosforescente', 'Neón surtido', 120, 14),
(10, 'Marcador para Tela Punta Cincel y Fino', 'MAT-1082-SET', 'Marcadores textiles con doble punta para decoración en tela.', 'Pascua', 'Plástico, tinta para tela', 'Surtido', 120, 14),
(11, 'Perforadora Dos Orificios 20 Hojas', 'PA-PER20', 'Perforadora metálica para 2 orificios, capacidad 20 hojas.', 'Pascua', 'Metal', 'Negro', 72, 40),
(12, 'Perforadora Dos Orificios 30 Hojas', 'PA-PER30', 'Perforadora reforzada para alto volumen, hasta 30 hojas.', 'Pascua', 'Metal', 'Negro', 72, 50),
(13, 'Perforadora Dos Orificios 70 Hojas', 'PA-PER70', 'Perforadora profesional de gran capacidad, hasta 70 hojas.', 'Pascua', 'Metal', 'Negro', 48, 98),
(14, 'Corrector en Cinta 12M', 'PA-CORCINT', 'Corrector seco en cinta de 12 metros para precisión.', 'Pascua', 'Plástico, cinta blanca', 'Blanco', 72, 21),
(15, 'Corrector en Cinta 6M', 'PA-CORCINT6', 'Corrector práctico con cinta de 6 metros.', 'Pascua', 'Plástico, cinta blanca', 'Blanco', 72, 16),
(16, 'Corrector en Cinta Retráctil 4M', 'PA-GCOR1', 'Corrector retráctil con carcasa protectora.', 'Pascua', 'Plástico', 'Transparente', 72, 16),
(17, 'Juego de Geometría con Estuche', 'PA-GEOSET', 'Juego completo de geometría con estuche rígido.', 'Pascua', 'Plástico y metal', 'Surtido', 60, 25),
(18, 'Compás Brazo Largo', 'PA-CM-TIG6', 'Compás de brazo largo para trazos amplios.', 'Pascua', 'Metal', 'Gris', 144, 28),
(19, 'Flauta Dulce Soprano', 'PA-FLAU01', 'Flauta dulce ideal para iniciación musical.', 'Pascua', 'Plástico', 'Marfil', 240, 29),
(20, 'Regla Super Flexible F30', 'PA-REGM30SFR', 'Regla flexible que no se rompe al doblarse.', 'Pascua', 'Plástico flexible', 'Surtido', 360, 7),
(21, 'Regla Metálica de Aluminio 30 CM', 'PA-REGM30PL', 'Regla precisa de aluminio anodizado.', 'Pascua', 'Aluminio', 'Plateado', 200, 25),
(22, 'Regla Metálica de Aluminio 60 CM', 'PA-REGM60PL', 'Regla larga y robusta de 60 cm para uso técnico.', 'Pascua', 'Aluminio', 'Plateado', 200, 35),
(23, 'Etiquetadora de 8 Dígitos', 'ETIQ-001', 'Etiquetadora manual para precios con 8 dígitos.', 'Pascua', 'Plástico, metal', 'Rojo y negro', 30, 147),
(24, 'Rodillo Entintador para Etiquetadora', 'ETI-TIN12', 'Rodillo compatible con etiquetadora de precios.', 'Pascua', 'Goma y tinta', 'Negro', 12, 12),
(25, 'Etiqueta Marca Precio Blanco', 'ETI2212-BA', 'Etiquetas blancas para precios, adhesivo fuerte.', 'Pascua', 'Papel adhesivo', 'Blanco', 600, 7),
(26, 'Etiqueta Marca Precio Rosa', 'ETI2212-RA', 'Etiquetas color rosa para promociones.', 'Pascua', 'Papel adhesivo', 'Rosa', 600, 7),
(27, 'Etiqueta Marca Precio Amarilla', 'ETI2212-AM', 'Etiquetas amarillas llamativas para resaltar precios.', 'Pascua', 'Papel adhesivo', 'Amarillo', 600, 7),
(28, 'Etiqueta Marca Precio Verde', 'ETI2212-VE', 'Etiquetas verdes para marcar productos.', 'Pascua', 'Papel adhesivo', 'Verde', 600, 7),
(29, 'Crayones Gruesos 12 Piezas Triangulares Lavables', 'CRAG-TRI12', 'Crayones lavables con forma triangular para fácil agarre.', 'Pascua', 'Cera no tóxica', 'Surtido', 144, 14),
(30, 'Crayones Gruesos 8 Piezas Triangulares Lavables', 'CRAG-TRI08', 'Crayones lavables triangulares para manos pequeñas.', 'Pascua', 'Cera no tóxica', 'Surtido', 144, 10),
(31, 'Sacapuntas con Depósito en Blister 1 PZ', 'PA-SACB01', 'Sacapuntas individual con depósito, en empaque blister.', 'Pascua', 'Plástico, acero', 'Surtido', 144, 16),
(32, 'Sacapuntas con Depósito en Caja Exhibidora', 'PA-SACB01-C', 'Sacapuntas en caja exhibidora para mostrador.', 'Pascua', 'Plástico, acero', 'Surtido', 120, 17),
(33, 'Sacapuntas de Plástico con Depósito 25 PZAS', 'PA-SAC5012BTE', 'Bote con 25 sacapuntas con depósito.', 'Pascua', 'Plástico, acero', 'Surtido', 100, 38),
(34, 'Sacapuntas de Plástico Rectángulo, Bote 60 PZ', 'PA-SAC5008TE', 'Bote con 60 sacapuntas plásticos rectangulares.', 'Pascua', 'Plástico', 'Surtido', 100, 58),
(55, 'Sacapuntas Plástico 2 Orificios Bote 25pz', 'PA-SAC5013BTE', 'Diseño clásico de doble orificio, ideal para lápices estándar y jumbo.', 'Pascua', 'Plástico', 'Surtido', 150, 35),
(56, 'Geoplano 16.5x15.0 cm', 'PA-GP15SUR', 'Geoplano de plástico resistente para actividades escolares y matemáticas.', 'Pascua', 'Plástico', 'Surtido', 100, 42),
(57, 'Cinta de Empaque Transparente 48mm x 150m', 'CINTP-43500', 'Cinta adhesiva transparente de gran longitud, ideal para embalaje.', 'Pascua', 'Plástico y adhesivo acrílico', 'Transparente', 60, 60),
(58, 'Dados de Plástico 12 mm Blíster 12 Pzas', 'DAP-16008B', 'Set de dados plásticos multicolores en empaque tipo blíster.', 'Pascua', 'Plástico', 'Multicolor', 144, 14),
(59, 'Notas Adhesivas 3x3 100 Hojas Verde Neon', 'PA-YG075-VD', 'Notas autoadhesivas en color verde neón de fácil escritura.', 'Pascua', 'Papel adhesivo', 'Verde neón', 480, 6),
(60, 'Notas Adhesivas 3x3 100 Hojas Azul Neon', 'PA-YG075-A', 'Notas adhesivas con color azul vibrante, tamaño 3x3 pulgadas.', 'Pascua', 'Papel adhesivo', 'Azul neón', 480, 6),
(61, 'Engrapadora Tira Completa Cromo de Golpe', 'ENG-2017-PL', 'Engrapadora de cuerpo metálico resistente con acabado cromado.', 'Pascua', 'Metal cromado', 'Plateado', 32, 65),
(62, 'Engrapadora Tira Completa Negra Metálica con Cubierta', 'ENG-2018-AA', 'Engrapadora metálica con cubierta plástica para comodidad y estilo.', 'Pascua', 'Metal y plástico', 'Negro', 48, 28),
(63, 'Cinchos de Plástico 10 cm Negro con 25 Pzas', 'PA-CINCH25-10', 'Cinchos de sujeción plásticos ideales para cableado y organización.', 'Pascua', 'Nylon', 'Negro', 300, 12),
(64, 'Exacto Metálico con 6 Cuchillas de Repuesto', 'EXAM-001', 'Cúter metálico de precisión con cuchillas intercambiables.', 'Pascua', 'Metal', 'Plateado', 200, 22);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contraseña` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `num_tarjeta` varchar(16) NOT NULL,
  `cp` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `contraseña`, `fecha_nacimiento`, `num_tarjeta`, `cp`) VALUES
(1, 'Ana', 'Ramírez López', 'ana.ramirez@example.com', 'ana1234', '1995-03-12', '4893567812345678', 11200),
(2, 'Luis', 'Martínez Ríos', 'luis.martinez@example.com', 'lmartinez22', '1990-07-08', '5291348712347856', 53000),
(3, 'Fernanda', 'Gómez Ruiz', 'fernanda.gomez@example.com', 'fergom95', '1998-11-21', '6234789123456210', 44100),
(4, 'Carlos', 'Hernández Peña', 'carlos.hp@example.com', 'chp2023', '1989-05-16', '4123678956123401', 76000),
(5, 'María', 'Santos Vega', 'maria.sv@example.com', 'mvega21', '1993-08-10', '5012768945612089', 90210),
(6, 'Eduardo', 'Núñez Soto', 'edu.nunez@example.com', 'edn2024', '1991-02-05', '6489273456718920', 3100),
(7, 'Julia', 'Cervantes Mora', 'julia.cervantes@example.com', 'jcm1234', '1996-09-29', '3928456721940011', 63000),
(8, 'Diego', 'Ortega León', 'diego.ortega@example.com', 'dleo456', '1994-04-03', '5092837482619374', 58000),
(9, 'Regina', 'Flores Aguilar', 'regina.flores@example.com', 'rfaguilar!', '2000-01-15', '6789012345678901', 10200),
(10, 'Jorge', 'Paredes Luna', 'jorge.pl@example.com', 'jpluna99', '1988-12-30', '7890123456789012', 14000),
(11, 'Claudia', 'Delgado Bravo', 'claudia.delgado@example.com', 'claudel2023', '1997-06-18', '8901234567890123', 45000),
(12, 'Iván', 'Castillo Romero', 'ivan.castillo@example.com', 'icastillo45', '1992-03-22', '9012345678901234', 97000),
(13, 'Mónica', 'Ríos Téllez', 'monica.rt@example.com', 'mrtz2000', '1999-10-09', '2345678901234567', 4300),
(14, 'Sebastián', 'Pineda Vargas', 'sebastian.pv@example.com', 'spvarg88', '1993-01-19', '3456789012345678', 15000),
(15, 'Valeria', 'Cano Salinas', 'valeria.cano@example.com', 'vcano21', '1990-11-04', '4567890123456789', 76030);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `carrito-usuarios` (`id_usuario`),
  ADD KEY `carrito-producto` (`id_producto`);

--
-- Indexes for table `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `historial-usuario` (`id_usuario`),
  ADD KEY `historial-producto` (`id_producto`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `historial`
--
ALTER TABLE `historial`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito-producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `carrito-usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Constraints for table `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial-producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `historial-usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
