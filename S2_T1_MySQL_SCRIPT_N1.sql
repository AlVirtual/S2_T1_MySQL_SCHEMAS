-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` ;
-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveidor` (
  `nif` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(45) NOT NULL,
  `numero` SMALLINT(5) NOT NULL,
  `pis` TINYINT(2) NOT NULL,
  `porta` TINYINT(2) NOT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `codipostal` SMALLINT(5) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `telefon` SMALLINT(12) NOT NULL,
  `fax` SMALLINT(12) NOT NULL,
  PRIMARY KEY (`nif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Marca` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `NomMarca` VARCHAR(45) NOT NULL,
  `proveidor_nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarca`, `proveidor_nif`),
  INDEX `fk_Marca_proveidor1_idx` (`proveidor_nif` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_proveidor1`
    FOREIGN KEY (`proveidor_nif`)
    REFERENCES `Optica`.`proveidor` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`tipus montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`tipus montura` (
  `idtipus montura` INT NOT NULL AUTO_INCREMENT,
  `tipus montura` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipus montura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`ulleres` (
  `idulleres` INT NOT NULL AUTO_INCREMENT,
  `Marca_idMarca` INT NOT NULL,
  `graudaciodreta` FLOAT NOT NULL,
  `graduacioesquerra` FLOAT NOT NULL,
  `colormontura` VARCHAR(45) NOT NULL,
  `colordreta` VARCHAR(45) NOT NULL,
  `coloresquerra` VARCHAR(45) NOT NULL,
  `preu` FLOAT NOT NULL,
  `tipus montura_idtipus montura` INT NOT NULL,
  PRIMARY KEY (`idulleres`, `Marca_idMarca`, `tipus montura_idtipus montura`),
  INDEX `fk_ulleres_Marca1_idx` (`Marca_idMarca` ASC) VISIBLE,
  INDEX `fk_ulleres_tipus montura1_idx` (`tipus montura_idtipus montura` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `Optica`.`Marca` (`idMarca`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ulleres_tipus montura1`
    FOREIGN KEY (`tipus montura_idtipus montura`)
    REFERENCES `Optica`.`tipus montura` (`idtipus montura`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`client` (
  `idclient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `dataregistre` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recomanatper` INT NULL,
  PRIMARY KEY (`idclient`),
  UNIQUE INDEX `dataregistre_UNIQUE` (`dataregistre` ASC) VISIBLE,
  INDEX `fk_client_client1_idx` (`recomanatper` ASC) VISIBLE,
  CONSTRAINT `fk_client_client1`
    FOREIGN KEY (`recomanatper`)
    REFERENCES `Optica`.`client` (`idclient`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`empleat` (
  `idempleat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idempleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`venta` (
  `ulleres_idulleres` INT NOT NULL,
  `client_idclient` INT NOT NULL,
  `empleat_idempleat` INT NOT NULL,
  PRIMARY KEY (`ulleres_idulleres`, `client_idclient`, `empleat_idempleat`),
  INDEX `fk_venta_client1_idx` (`client_idclient` ASC) VISIBLE,
  INDEX `fk_venta_empleat1_idx` (`empleat_idempleat` ASC) VISIBLE,
  CONSTRAINT `fk_venta_ulleres1`
    FOREIGN KEY (`ulleres_idulleres`)
    REFERENCES `Optica`.`ulleres` (`idulleres`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_venta_client1`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `Optica`.`client` (`idclient`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_venta_empleat1`
    FOREIGN KEY (`empleat_idempleat`)
    REFERENCES `Optica`.`empleat` (`idempleat`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`marca ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`marca ulleres` (
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nom`))
ENGINE = InnoDB;

USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`provincies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`provincies` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`localitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`localitats` (
  `idlocalitat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `provincies_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idlocalitat`, `provincies_idprovincia`),
  INDEX `fk_localitats_provincies1_idx` (`provincies_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_localitats_provincies1`
    FOREIGN KEY (`provincies_idprovincia`)
    REFERENCES `Pizzeria`.`provincies` (`idprovincia`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `codipostal` INT(8) NOT NULL,
  `telefon` INT(12) NOT NULL,
  `localitats_idlocalitat` INT NOT NULL,
  PRIMARY KEY (`idClient`, `localitats_idlocalitat`),
  INDEX `fk_clients_localitats1_idx` (`localitats_idlocalitat` ASC) VISIBLE,
  CONSTRAINT `fk_clients_localitats1`
    FOREIGN KEY (`localitats_idlocalitat`)
    REFERENCES `Pizzeria`.`localitats` (`idlocalitat`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`botigues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`botigues` (
  `idBotigua` INT NOT NULL AUTO_INCREMENT,
  `adreçaBotiga` VARCHAR(45) NOT NULL,
  `codipostalBotiga` INT(8) NOT NULL,
  `localitats_idlocalitat` INT NOT NULL,
  PRIMARY KEY (`idBotigua`, `localitats_idlocalitat`),
  INDEX `fk_botigues_localitats1_idx` (`localitats_idlocalitat` ASC) VISIBLE,
  CONSTRAINT `fk_botigues_localitats1`
    FOREIGN KEY (`localitats_idlocalitat`)
    REFERENCES `Pizzeria`.`localitats` (`idlocalitat`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comandesClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comandesClient` (
  `idComanda` INT NOT NULL AUTO_INCREMENT,
  `clients_idclient` INT NOT NULL,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `domicili` VARCHAR(45) NOT NULL,
  `botigues_idBotigua` INT NOT NULL,
  `importComanda` FLOAT NOT NULL,
  PRIMARY KEY (`idComanda`, `clients_idclient`, `botigues_idBotigua`),
  INDEX `fk_comandes_clients1_idx` (`clients_idclient` ASC) VISIBLE,
  INDEX `fk_comandesClient_botigues1_idx` (`botigues_idBotigua` ASC) VISIBLE,
  CONSTRAINT `fk_comandes_clients1`
    FOREIGN KEY (`clients_idclient`)
    REFERENCES `Pizzeria`.`clients` (`idClient`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandesClient_botigues1`
    FOREIGN KEY (`botigues_idBotigua`)
    REFERENCES `Pizzeria`.`botigues` (`idBotigua`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoriesPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoriesPizza` (
  `idcategoriesPizza` INT NOT NULL AUTO_INCREMENT,
  `nomCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoriesPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`productes` (
  `idProducte` INT NOT NULL AUTO_INCREMENT,
  `nomProducte` VARCHAR(45) NOT NULL,
  `descripcioProducte` VARCHAR(45) NOT NULL,
  `imatgeProducte` BLOB NOT NULL,
  `preuProducte` FLOAT NOT NULL,
  `categoriesPizza_idcategoriesPizza` INT NOT NULL,
  PRIMARY KEY (`idProducte`, `categoriesPizza_idcategoriesPizza`),
  UNIQUE INDEX `nomproducte_UNIQUE` (`nomProducte` ASC) VISIBLE,
  INDEX `fk_productes_categoriesPizza1_idx` (`categoriesPizza_idcategoriesPizza` ASC) VISIBLE,
  CONSTRAINT `fk_productes_categoriesPizza1`
    FOREIGN KEY (`categoriesPizza_idcategoriesPizza`)
    REFERENCES `Pizzeria`.`categoriesPizza` (`idcategoriesPizza`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`detallComandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`detallComandes` (
  `lineaComanda` INT NOT NULL AUTO_INCREMENT,
  `comandesClient_idComanda` INT NOT NULL,
  `productes_idProducte` INT NOT NULL,
  `cantitatProducte` TINYINT(2) NOT NULL,
  PRIMARY KEY (`lineaComanda`, `comandesClient_idComanda`, `productes_idProducte`),
  INDEX `fk_comandesClient_has_productes_productes1_idx` (`productes_idProducte` ASC) VISIBLE,
  INDEX `fk_detallsComandes_comandesClient1_idx` (`comandesClient_idComanda` ASC) VISIBLE,
  CONSTRAINT `fk_comandesClient_has_productes_productes1`
    FOREIGN KEY (`productes_idProducte`)
    REFERENCES `Pizzeria`.`productes` (`idProducte`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detallsComandes_comandesClient1`
    FOREIGN KEY (`comandesClient_idComanda`)
    REFERENCES `Pizzeria`.`comandesClient` (`idComanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`carrecEmpleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`carrecEmpleats` (
  `idCarrecEmpleat` INT NOT NULL AUTO_INCREMENT,
  `carrecEmpleat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCarrecEmpleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleats` (
  `idEmpleat` INT NOT NULL AUTO_INCREMENT,
  `nomEmpleat` VARCHAR(45) NOT NULL,
  `cognomsEmpleat` VARCHAR(45) NOT NULL,
  `nifEmpleat` VARCHAR(45) NOT NULL,
  `telefonEmpleat` INT(12) NOT NULL,
  `carrecEmpleats_idCarrecEmpleat` INT NOT NULL,
  PRIMARY KEY (`idEmpleat`, `carrecEmpleats_idCarrecEmpleat`),
  INDEX `fk_empleats_carrecEmpleats1_idx` (`carrecEmpleats_idCarrecEmpleat` ASC) VISIBLE,
  CONSTRAINT `fk_empleats_carrecEmpleats1`
    FOREIGN KEY (`carrecEmpleats_idCarrecEmpleat`)
    REFERENCES `Pizzeria`.`carrecEmpleats` (`idCarrecEmpleat`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comandesDomicili`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comandesDomicili` (
  `comandesClient_idComanda` INT NOT NULL,
  `empleats_idEmpleat` INT NOT NULL,
  `lliuramentDomicili` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_comandesDomicili_comandesClient1_idx` (`comandesClient_idComanda` ASC) VISIBLE,
  INDEX `fk_comandesDomicili_empleats1_idx` (`empleats_idEmpleat` ASC) VISIBLE,
  PRIMARY KEY (`comandesClient_idComanda`, `empleats_idEmpleat`),
  CONSTRAINT `fk_comandesDomicili_comandesClient1`
    FOREIGN KEY (`comandesClient_idComanda`)
    REFERENCES `Pizzeria`.`comandesClient` (`idComanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandesDomicili_empleats1`
    FOREIGN KEY (`empleats_idEmpleat`)
    REFERENCES `Pizzeria`.`empleats` (`idEmpleat`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
