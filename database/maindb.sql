CREATE TABLE `tuser` (
  `idUser` char(36) NOT NULL DEFAULT (uuid()),
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
   PRIMARY KEY (`idUser`)
);

CREATE TABLE `tcategory` (
  `idCategory` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(500) NOT NULL,
  `categoryDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`idCategory`)
);

CREATE TABLE `tproduct` (
  `idProduct` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(50) NOT NULL,
  `productBrand` varchar(100) NOT NULL,
  `productPrice` int(11) NOT NULL,
  `productImg` varchar(500) NOT NULL DEFAULT 'https://images.unsplash.com/photo-1539683255143-73a6b838b106?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=632&q=80',
  `productCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProduct`),
  FOREIGN KEY (`productCategory`) REFERENCES `tcategory` (`idCategory`)
);

INSERT INTO `tcategory`(`categoryName`, `categoryDescription`) 
VALUES ("Cardistry", "Las barajas enfocadas a cardistry son barajas prémium, con acabados impresionantes para que cualquier show de se vea simplemente impresionante. Son livianas y no se recomiendan para practicar lanzamientos."),
("Throwable cards", "Las cartas que tienen el objetivo de ser lanzadas, son cartas duras, pero finas, con la capacidad de penetrar cualquier objeto sin importar su dureza. Perfectas para practicar lanzamiento de cartas."),
("Poker", "Cartas enfocadas al juego, disfruta de una tarde de poker con las barajas mas premium.");

INSERT INTO `tproduct`(`productName`, `productBrand`, `productPrice`, `productImg`, `productCategory`) 
VALUES 
("007 Cardistry", "Theory11", 450900, "https://i.ibb.co/QDvN8hJ/jamesbond.png", 1), 
("SolarMatrix", "Bierdof", 178900, "https://images-na.ssl-images-amazon.com/images/I/41Bl6PTLPWL.jpg", 1),
("Cardistry Green Edition", "Biclycle" ,190900 , "https://images.unsplash.com/photo-1562766879-ce73e9394f94?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=820&q=80", 1), 
("Citizens Premium Edition", "Pluribus & Unum", 322900, "https://images.unsplash.com/photo-1615229337219-52fa96d6e9f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80", 2),
("Banshees", "Banshees", 459900, "https://images-na.ssl-images-amazon.com/images/I/51GF3Q2d4kL._AC_SX466_.jpg", 2),
("Bicycle Guardians - Black Edition", "Bicycle", 90900, "https://images.unsplash.com/photo-1577137026054-be825cb4b0c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1574&q=80", 3),
("Hudson Premium Deck", "Hudson", 390000, "https://images.unsplash.com/photo-1559323516-be2f83ce450b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1317&q=80", 3),
("Monarchs Black Edition", "Theory11", 192900, "https://images.unsplash.com/photo-1530405018134-136fa7826184?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=700&q=80", 3);

DELIMITER //
CREATE PROCEDURE get_all_products()
BEGIN
	SELECT idProduct, productName, productBrand, productPrice, productImg, categoryName 
    from tproduct 
    INNER JOIN tcategory 
    ON tproduct.productCategory = tcategory.idCategory;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_products_by_categoryId(IN categoryId INT(11))
BEGIN
	SELECT idProduct, productName, productBrand, productPrice, productImg, categoryName 
    from tproduct 
    INNER JOIN tcategory 
    ON tproduct.productCategory = tcategory.idCategory
    WHERE tcategory.idCategory = categoryId;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_all_categories()
BEGIN
	SELECT idCategory, categoryName
    from tcategory;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_category_name(IN categoryId INT(11))
BEGIN
	SELECT categoryName
    from tcategory WHERE idCategory = categoryId;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_new_product(IN productNAme VARCHAR(50), IN productBrand VARCHAR(100), IN productPrice INT(11), IN productImg VARCHAR(500), IN productCategory INT(11)) 
  NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
BEGIN 
  INSERT INTO tproduct (productName, productBrand, productPrice, productImg, productCategory) 
  VALUES(productName, productBrand, productPrice, productImg, productCategory); 
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE find_user_by_email(IN email varchar(200)) 
  NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
BEGIN 
  SELECT email from tuser where tuser.email = email; 
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE create_new_user(IN firstName varchar(50), IN lastName varchar(50),IN email varchar(200), IN password varchar(500)) 
  NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
BEGIN 
  INSERT INTO tuser (name, lastname, email, password) VALUES (firstName, lastName, email, password); 
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE login_user(IN email varchar(200), IN password varchar(500)) 
  NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
BEGIN 
  SELECT tuser.idUser, tuser.name, tuser.lastname, tuser.email from tuser WHERE tuser.email = email and tuser.password = password;
END//
DELIMITER ;