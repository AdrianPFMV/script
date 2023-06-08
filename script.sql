-- MySQL Script generated by MySQL Workbench
-- Thu Jun  8 17:34:42 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema podcast
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema podcast
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `podcast` DEFAULT CHARACTER SET utf8 ;
USE `podcast` ;

-- -----------------------------------------------------
-- Table `podcast`.`foro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`foro` (
  `idFORO` INT(11) NOT NULL AUTO_INCREMENT,
  `comentarios` VARCHAR(45) NULL DEFAULT NULL,
  `participantes` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idFORO`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`podcast` (
  `idPODCAST` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `decode` VARCHAR(45) NULL DEFAULT NULL,
  `audio` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `logo` VARCHAR(45) NULL DEFAULT NULL,
  `USUARIO_idUSUARIO` INT(11) NOT NULL,
  `FORO_idFORO` INT(11) NOT NULL,
  PRIMARY KEY (`idPODCAST`, `USUARIO_idUSUARIO`, `FORO_idFORO`),

  CONSTRAINT `fk_PODCAST_FORO1`
    FOREIGN KEY (`FORO_idFORO`)
    REFERENCES `podcast`.`foro` (`idFORO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`capitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`capitulo` (
  `idCAPITULO` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `fecha` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `urlAudio` VARCHAR(45) NULL DEFAULT NULL,
  `CAPITULOcol` VARCHAR(45) NULL DEFAULT NULL,
  `PODCAST_idPODCAST` INT(11) NOT NULL,
  `PODCAST_USUARIO_idUSUARIO` INT(11) NOT NULL,
  `PODCAST_FORO_idFORO` INT(11) NOT NULL,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCAPITULO`, `PODCAST_idPODCAST`, `PODCAST_USUARIO_idUSUARIO`, `PODCAST_FORO_idFORO`),
 
  CONSTRAINT `fk_CAPITULO_PODCAST1`
    FOREIGN KEY (`PODCAST_idPODCAST` , `PODCAST_USUARIO_idUSUARIO` , `PODCAST_FORO_idFORO`)
    REFERENCES `podcast`.`podcast` (`idPODCAST` , `USUARIO_idUSUARIO` , `FORO_idFORO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`categoria` (
  `idCategoria` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`categoria_has_podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`categoria_has_podcast` (
  `CATEGORIA_idCategoria` VARCHAR(45) NOT NULL,
  `PODCAST_idPODCAST` INT(11) NOT NULL,
  `PODCAST_USUARIO_idUSUARIO` INT(11) NOT NULL,
  `PODCAST_FORO_idFORO` INT(11) NOT NULL,
  PRIMARY KEY (`CATEGORIA_idCategoria`, `PODCAST_idPODCAST`, `PODCAST_USUARIO_idUSUARIO`, `PODCAST_FORO_idFORO`),
  
  CONSTRAINT `fk_CATEGORIA_has_PODCAST_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_idCategoria`)
    REFERENCES `podcast`.`categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIA_has_PODCAST_PODCAST1`
    FOREIGN KEY (`PODCAST_idPODCAST` , `PODCAST_USUARIO_idUSUARIO` , `PODCAST_FORO_idFORO`)
    REFERENCES `podcast`.`podcast` (`idPODCAST` , `USUARIO_idUSUARIO` , `FORO_idFORO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`comentario` (
  `idCOMENTARIO` INT(11) NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(45) NULL DEFAULT NULL,
  `fecha` VARCHAR(45) NULL DEFAULT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `CAPITULO_idCAPITULO` INT(11) NOT NULL,
  `CAPITULO_PODCAST_idPODCAST` INT(11) NOT NULL,
  `CAPITULO_PODCAST_USUARIO_idUSUARIO` INT(11) NOT NULL,
  `CAPITULO_PODCAST_FORO_idFORO` INT(11) NOT NULL,
  `USUARIO_idUSUARIO` INT(11) NOT NULL,
  PRIMARY KEY (`idCOMENTARIO`, `CAPITULO_idCAPITULO`, `CAPITULO_PODCAST_idPODCAST`, `CAPITULO_PODCAST_USUARIO_idUSUARIO`, `CAPITULO_PODCAST_FORO_idFORO`, `USUARIO_idUSUARIO`),
 
  CONSTRAINT `fk_COMENTARIO_CAPITULO1`
    FOREIGN KEY (`CAPITULO_idCAPITULO` , `CAPITULO_PODCAST_idPODCAST` , `CAPITULO_PODCAST_USUARIO_idUSUARIO` , `CAPITULO_PODCAST_FORO_idFORO`)
    REFERENCES `podcast`.`capitulo` (`idCAPITULO` , `PODCAST_idPODCAST` , `PODCAST_USUARIO_idUSUARIO` , `PODCAST_FORO_idFORO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 42
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`usuario` (
  `idUSUARIO` INT(11) NOT NULL AUTO_INCREMENT,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `password` CHAR(255) NULL DEFAULT NULL,
  `edad` INT(11) NULL DEFAULT NULL,
  `telefono` INT(11) NULL DEFAULT NULL,
  `fotoPeril` VARCHAR(45) NULL DEFAULT NULL,
  `salt` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idUSUARIO`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `podcast`.`podcast_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast`.`podcast_has_usuario` (
  `PODCAST_idPODCAST` INT(11) NOT NULL,
  `PODCAST_USUARIO_idUSUARIO` INT(11) NOT NULL,
  `USUARIO_idUSUARIO` INT(11) NOT NULL,
  PRIMARY KEY (`PODCAST_idPODCAST`, `PODCAST_USUARIO_idUSUARIO`, `USUARIO_idUSUARIO`),
 
  CONSTRAINT `fk_PODCAST_has_USUARIO_PODCAST1`
    FOREIGN KEY (`PODCAST_idPODCAST` , `PODCAST_USUARIO_idUSUARIO`)
    REFERENCES `podcast`.`podcast` (`idPODCAST` , `USUARIO_idUSUARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PODCAST_has_USUARIO_USUARIO1`
    FOREIGN KEY (`USUARIO_idUSUARIO`)
    REFERENCES `podcast`.`usuario` (`idUSUARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
