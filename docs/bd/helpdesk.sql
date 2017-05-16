-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema helpdesk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema helpdesk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `helpdesk` ;
USE `helpdesk` ;

-- -----------------------------------------------------
-- Table `helpdesk`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `tipo` ENUM('ADMIN', 'TECNI', 'SOLIC') NOT NULL,
  `ativo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `helpdesk`.`chamado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`chamado` (
  `idchamado` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `prioridade` ENUM('ALTA', 'NORMAL', 'BAIXA') NOT NULL,
  `status` ENUM('ABERTO', 'ATENDENDO', 'ESPERANDO', 'FECHADO_SUCESSO', 'FECHADO_FALHA', 'FECHADO_CANCELADO') NOT NULL,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_idsolicitante` INT NOT NULL,
  `usuario_idtecnico` INT NULL,
  PRIMARY KEY (`idchamado`),
  INDEX `fk_chamado_usuario1_idx` (`usuario_idsolicitante` ASC),
  INDEX `fk_chamado_usuario2_idx` (`usuario_idtecnico` ASC),
  CONSTRAINT `fk_chamado_usuario1`
    FOREIGN KEY (`usuario_idsolicitante`)
    REFERENCES `helpdesk`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chamado_usuario2`
    FOREIGN KEY (`usuario_idtecnico`)
    REFERENCES `helpdesk`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `helpdesk`.`descricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`descricao` (
  `iddescricao` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `chamado_idchamado` INT NOT NULL,
  PRIMARY KEY (`iddescricao`, `chamado_idchamado`),
  INDEX `fk_descricao_chamado_idx` (`chamado_idchamado` ASC),
  CONSTRAINT `fk_descricao_chamado`
    FOREIGN KEY (`chamado_idchamado`)
    REFERENCES `helpdesk`.`chamado` (`idchamado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `helpdesk`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`historico` (
  `idhistorico` INT NOT NULL AUTO_INCREMENT,
  `acao` VARCHAR(255) NOT NULL,
  `justificativa` VARCHAR(255) NULL,
  `hora` DATETIME NOT NULL DEFAULT NOW(),
  `usuario_idusuario1` INT NULL,
  `chamado_idchamado` INT NULL,
  `usuario_idusuario2` INT NULL,
  PRIMARY KEY (`idhistorico`),
  INDEX `fk_historico_chamado1_idx` (`chamado_idchamado` ASC),
  INDEX `fk_historico_usuario1_idx` (`usuario_idusuario1` ASC),
  INDEX `fk_historico_usuario2_idx` (`usuario_idusuario2` ASC),
  CONSTRAINT `fk_historico_chamado1`
    FOREIGN KEY (`chamado_idchamado`)
    REFERENCES `helpdesk`.`chamado` (`idchamado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_usuario1`
    FOREIGN KEY (`usuario_idusuario1`)
    REFERENCES `helpdesk`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_usuario2`
    FOREIGN KEY (`usuario_idusuario2`)
    REFERENCES `helpdesk`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
