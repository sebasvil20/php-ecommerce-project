-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2021 a las 02:41:28
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `decks_ecommerce`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_product` (IN `productNAme` VARCHAR(50), IN `productBrand` VARCHAR(100), IN `productPrice` INT(11), IN `productImg` VARCHAR(500), IN `productCategory` INT(11))  NO SQL
BEGIN 
  INSERT INTO tproduct (productName, productBrand, productPrice, productImg, productCategory) 
  VALUES(productName, productBrand, productPrice, productImg, productCategory); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_user` (IN `firstName` VARCHAR(50), IN `lastName` VARCHAR(50), IN `email` VARCHAR(200), IN `password` VARCHAR(500))  NO SQL
BEGIN 
  INSERT INTO tuser (name, lastname, email, password) VALUES (firstName, lastName, email, password); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_user_by_email` (IN `email` VARCHAR(200))  NO SQL
BEGIN 
  SELECT tuser.email from tuser where tuser.email = email; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_categories` ()  BEGIN
	SELECT idCategory, categoryName
    from tcategory;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_products` ()  BEGIN
	SELECT idProduct, productName, productBrand, productPrice, productImg, categoryName 
    from tproduct 
    INNER JOIN tcategory 
    ON tproduct.productCategory = tcategory.idCategory ORDER BY tproduct.idProduct DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_category_name` (IN `categoryId` INT(11))  BEGIN
	SELECT categoryName
    from tcategory WHERE idCategory = categoryId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_products_by_categoryId` (IN `categoryId` INT(11))  BEGIN
	SELECT idProduct, productName, productBrand, productPrice, productImg, categoryName 
    from tproduct 
    INNER JOIN tcategory 
    ON tproduct.productCategory = tcategory.idCategory 
    WHERE tcategory.idCategory = categoryId  ORDER BY tproduct.idProduct DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_user` (IN `email` VARCHAR(200), IN `password` VARCHAR(500))  NO SQL
BEGIN 
  SELECT tuser.idUser, tuser.name, tuser.lastname, tuser.email from tuser WHERE tuser.email = email and tuser.password = password;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tcategory`
--

CREATE TABLE `tcategory` (
  `idCategory` int(11) NOT NULL,
  `categoryName` varchar(500) NOT NULL,
  `categoryDescription` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tcategory`
--

INSERT INTO `tcategory` (`idCategory`, `categoryName`, `categoryDescription`) VALUES
(1, 'Cardistry', 'Las barajas enfocadas a cardistry son barajas prémium, con acabados impresionantes para que cualquier show de se vea simplemente impresionante. Son livianas y no se recomiendan para practicar lanzamientos.'),
(2, 'Throwable cards', 'Las cartas que tienen el objetivo de ser lanzadas, son cartas duras, pero finas, con la capacidad de penetrar cualquier objeto sin importar su dureza. Perfectas para practicar lanzamiento de cartas.'),
(3, 'Poker', 'Cartas enfocadas al juego, disfruta de una tarde de poker con las barajas mas premium.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tproduct`
--

CREATE TABLE `tproduct` (
  `idProduct` int(11) NOT NULL,
  `productName` varchar(50) NOT NULL,
  `productBrand` varchar(100) NOT NULL,
  `productPrice` int(11) NOT NULL,
  `productImg` varchar(500) NOT NULL DEFAULT 'https://images.unsplash.com/photo-1539683255143-73a6b838b106?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=632&q=80',
  `productCategory` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tproduct`
--

INSERT INTO `tproduct` (`idProduct`, `productName`, `productBrand`, `productPrice`, `productImg`, `productCategory`) VALUES
(1, '007 Cardistry', 'Theory11', 450900, 'https://i.ibb.co/QDvN8hJ/jamesbond.png', 1),
(2, 'SolarMatrix', 'Bierdof', 178900, 'https://images-na.ssl-images-amazon.com/images/I/41Bl6PTLPWL.jpg', 1),
(3, 'Cardistry Green Edition', 'Biclycle', 190900, 'https://images.unsplash.com/photo-1562766879-ce73e9394f94?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=820&q=80', 1),
(4, 'Citizens Premium Edition', 'Pluribus & Unum', 322900, 'https://images.unsplash.com/photo-1615229337219-52fa96d6e9f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80', 2),
(5, 'Banshees', 'Banshees', 459900, 'https://images-na.ssl-images-amazon.com/images/I/51GF3Q2d4kL._AC_SX466_.jpg', 2),
(6, 'Bicycle Guardians - Black Edition', 'Bicycle', 90900, 'https://images.unsplash.com/photo-1577137026054-be825cb4b0c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1574&q=80', 3),
(7, 'Hudson Premium Deck', 'Hudson', 390000, 'https://images.unsplash.com/photo-1559323516-be2f83ce450b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1317&q=80', 3),
(8, 'Monarchs Black Edition', 'Theory11', 192900, 'https://images.unsplash.com/photo-1530405018134-136fa7826184?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=700&q=80', 3),
(10, 'Violet Luna Moon', '52 Kards', 172900, 'https://cdn.shopify.com/s/files/1/0956/5418/products/63817-alt1_1024x1024.png?v=1557292165', 3),
(11, 'Stargazer new moon', 'Bicycle', 99900, 'https://pbs.twimg.com/media/EhedHzzX0AAFyvy.jpg:large', 3),
(12, 'Memento Mori', 'Chris ramsay', 139000, 'https://images-na.ssl-images-amazon.com/images/I/61KlUKF1tWL._AC_SL1125_.jpg', 1),
(13, 'Neon Cardistry Deck', 'Bicycle', 190000, 'https://spielkartenshop.com/media/image/product/2912/lg/bicycle-neon-cardistry-playing-cards.jpg', 1),
(14, 'Mandalorian Deck', 'Theory11', 56000, 'https://www.mundomagos.com/wp-content/uploads/2021/05/Baraja-Mandalorian.jpg', 2),
(15, 'Hops & Barley', 'Jocu', 145000, 'https://jocu.cards/wp-content/uploads/2020/10/IMG_9850.jpg', 3),
(16, 'Paperwave Venomous Edition', '52 Kards', 123500, 'https://spielkartenshop.com/media/image/product/5308/lg/paperwave-venomous-edition-playing-cards.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tuser`
--

CREATE TABLE `tuser` (
  `idUser` char(36) NOT NULL DEFAULT uuid(),
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tuser`
--

INSERT INTO `tuser` (`idUser`, `name`, `lastname`, `email`, `password`) VALUES
('a9e5f67d-bff7-11eb-83bd-48ba4e4ee5de', 'Sebastian', 'Villegas', 'sebasvil20@gmail.com', 'd3190b35eb1bbdf9c70bff4679cf21d86e7ec650');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tcategory`
--
ALTER TABLE `tcategory`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indices de la tabla `tproduct`
--
ALTER TABLE `tproduct`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `productCategory` (`productCategory`);

--
-- Indices de la tabla `tuser`
--
ALTER TABLE `tuser`
  ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tcategory`
--
ALTER TABLE `tcategory`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tproduct`
--
ALTER TABLE `tproduct`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tproduct`
--
ALTER TABLE `tproduct`
  ADD CONSTRAINT `tproduct_ibfk_1` FOREIGN KEY (`productCategory`) REFERENCES `tcategory` (`idCategory`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
