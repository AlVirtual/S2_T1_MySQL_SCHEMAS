-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`canals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canals` (
  `idCanal` INT NOT NULL AUTO_INCREMENT,
  `nomCanal` VARCHAR(45) NOT NULL,
  `descripcioCanal` VARCHAR(45) NOT NULL,
  `timecreacioCanal` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCanal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuaris` (
  `idUsuari` INT NOT NULL AUTO_INCREMENT,
  `canals_idCanal` INT NOT NULL,
  `nomUsuari` VARCHAR(16) NOT NULL,
  `passwordUsuari` VARCHAR(32) NOT NULL,
  `emailUsuari` VARCHAR(255) NOT NULL,
  `datanaixementUsuari` DATE NOT NULL,
  `sexeUsuari` VARCHAR(45) NOT NULL,
  `paisUsuari` VARCHAR(45) NOT NULL,
  `codipostalUsuari` INT(8) NOT NULL,
  PRIMARY KEY (`idUsuari`, `canals_idCanal`),
  INDEX `fk_usuaris_canals1_idx` (`canals_idCanal` ASC) VISIBLE,
  CONSTRAINT `fk_usuaris_canals1`
    FOREIGN KEY (`canals_idCanal`)
    REFERENCES `youtube`.`canals` (`idCanal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `youtube`.`estats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`estats` (
  `idEstat` INT NOT NULL AUTO_INCREMENT,
  `descripcioEstat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `idVideo` INT NOT NULL AUTO_INCREMENT,
  `estats_idEstat` INT NOT NULL,
  `usuaris_idUsuari` INT NOT NULL,
  `titolVideo` VARCHAR(45) NOT NULL,
  `descripcioVideo` VARCHAR(255) NOT NULL,
  `tamanyVideo` INT NOT NULL,
  `nomarxiuVieo` VARCHAR(45) NOT NULL,
  `duradaVideo` FLOAT NOT NULL,
  `miniaturaVideo` BLOB NOT NULL,
  `reproduccionsVideo` INT NOT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `timepublicacioVideo` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVideo`, `estats_idEstat`, `usuaris_idUsuari`),
  INDEX `fk_videos_estats1_idx` (`estats_idEstat` ASC) VISIBLE,
  INDEX `fk_videos_usuaris1_idx` (`usuaris_idUsuari` ASC) VISIBLE,
  CONSTRAINT `fk_videos_estats1`
    FOREIGN KEY (`estats_idEstat`)
    REFERENCES `youtube`.`estats` (`idEstat`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetes` (
  `idEtiqueta` INT NOT NULL AUTO_INCREMENT,
  `videos_idVideo` INT NOT NULL,
  `nomEtiqueta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEtiqueta`, `videos_idVideo`),
  INDEX `fk_etiquetes_videos1_idx` (`videos_idVideo` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetes_videos1`
    FOREIGN KEY (`videos_idVideo`)
    REFERENCES `youtube`.`videos` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`suscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`suscripcions` (
  `usuaris_idUsuari` INT NOT NULL,
  `canals_idCanal` INT NOT NULL,
  PRIMARY KEY (`usuaris_idUsuari`, `canals_idCanal`),
  INDEX `fk_usuaris_has_canals_canals1_idx` (`canals_idCanal` ASC) VISIBLE,
  INDEX `fk_usuaris_has_canals_usuaris1_idx` (`usuaris_idUsuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuaris_has_canals_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuaris_has_canals_canals1`
    FOREIGN KEY (`canals_idCanal`)
    REFERENCES `youtube`.`canals` (`idCanal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `youtube`.`givemethelike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`givemethelike` (
  `usuaris_idUsuari` INT NOT NULL,
  `videos_idVideo` INT NOT NULL,
  `likeGivemethelike` TINYINT(1) NULL,
  `dislikeGivemethelike` TINYINT(1) NULL,
  `timeGivemethelike` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuaris_idUsuari`, `videos_idVideo`),
  INDEX `fk_givemethelike_videos1_idx` (`videos_idVideo` ASC) VISIBLE,
  CONSTRAINT `fk_givemethelike_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_givemethelike_videos1`
    FOREIGN KEY (`videos_idVideo`)
    REFERENCES `youtube`.`videos` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`estatsplaylists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`estatsplaylists` (
  `idEstatplaylist` INT NOT NULL,
  `nomEstatplaylist` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstatplaylist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `idPlaylist` INT NOT NULL AUTO_INCREMENT,
  `estatsplaylists_idEstatplaylist` INT NOT NULL,
  `nomPlaylist` VARCHAR(45) NOT NULL,
  `timePlaylist` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPlaylist`, `estatsplaylists_idEstatplaylist`),
  INDEX `fk_playlists_estatsplaylists1_idx` (`estatsplaylists_idEstatplaylist` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_estatsplaylists1`
    FOREIGN KEY (`estatsplaylists_idEstatplaylist`)
    REFERENCES `youtube`.`estatsplaylists` (`idEstatplaylist`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlistsusuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlistsusuaris` (
  `usuaris_idUsuari` INT NOT NULL,
  `playlists_idPlaylist` INT NOT NULL,
  PRIMARY KEY (`usuaris_idUsuari`, `playlists_idPlaylist`),
  INDEX `fk_usuaris_has_playlists_playlists1_idx` (`playlists_idPlaylist` ASC) VISIBLE,
  INDEX `fk_usuaris_has_playlists_usuaris1_idx` (`usuaris_idUsuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuaris_has_playlists_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuaris_has_playlists_playlists1`
    FOREIGN KEY (`playlists_idPlaylist`)
    REFERENCES `youtube`.`playlists` (`idPlaylist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `youtube`.`playlistvideos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlistvideos` (
  `playlists_idPlaylist` INT NOT NULL,
  `videos_idVideo` INT NOT NULL,
  PRIMARY KEY (`playlists_idPlaylist`, `videos_idVideo`),
  INDEX `fk_playlists_has_videos_videos1_idx` (`videos_idVideo` ASC) VISIBLE,
  INDEX `fk_playlists_has_videos_playlists1_idx` (`playlists_idPlaylist` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_videos_playlists1`
    FOREIGN KEY (`playlists_idPlaylist`)
    REFERENCES `youtube`.`playlists` (`idPlaylist`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_videos_videos1`
    FOREIGN KEY (`videos_idVideo`)
    REFERENCES `youtube`.`videos` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentaris` (
  `idComentari` INT NOT NULL AUTO_INCREMENT,
  `usuaris_idUsuari` INT NOT NULL,
  `videos_idVideo` INT NOT NULL,
  `textComentari` VARCHAR(255) NOT NULL,
  `timeComentari` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentari`, `usuaris_idUsuari`, `videos_idVideo`),
  INDEX `fk_comentaris_videos1_idx` (`videos_idVideo` ASC) VISIBLE,
  INDEX `fk_comentaris_usuaris1_idx` (`usuaris_idUsuari` ASC) VISIBLE,
  CONSTRAINT `fk_comentaris_videos1`
    FOREIGN KEY (`videos_idVideo`)
    REFERENCES `youtube`.`videos` (`idVideo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comentaris_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`usuarismarcacomentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuarismarcacomentaris` (
  `usuaris_idUsuari` INT NOT NULL,
  `comentaris_idComentari` INT NOT NULL,
  `agradaUsuarismarcacomentari` TINYINT(1) NULL,
  `noagradaUsuarismarcacomentari` TINYINT(1) NULL,
  `timeUsuarimarcacomentari` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuaris_idUsuari`, `comentaris_idComentari`),
  INDEX `fk_usuaris_has_comentaris_comentaris1_idx` (`comentaris_idComentari` ASC) VISIBLE,
  INDEX `fk_usuaris_has_comentaris_usuaris1_idx` (`usuaris_idUsuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuaris_has_comentaris_usuaris1`
    FOREIGN KEY (`usuaris_idUsuari`)
    REFERENCES `youtube`.`usuaris` (`idUsuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuaris_has_comentaris_comentaris1`
    FOREIGN KEY (`comentaris_idComentari`)
    REFERENCES `youtube`.`comentaris` (`idComentari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
