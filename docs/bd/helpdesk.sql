-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema helpdesk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema helpdesk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `helpdesk`
  DEFAULT CHARACTER SET utf8;
USE `helpdesk`;

-- -----------------------------------------------------
-- Table `helpdesk`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`usuario` (
  `idusuario` INT(11)                          NOT NULL AUTO_INCREMENT,
  `nome`      VARCHAR(255)                     NOT NULL,
  `login`     VARCHAR(45)                      NOT NULL,
  `senha`     VARCHAR(45)                      NOT NULL,
  `tipo`      ENUM ('ADMIN', 'TECNI', 'SOLIC') NOT NULL,
  `ativo`     TINYINT(1)                       NOT NULL DEFAULT '1',
  `imagem`    VARCHAR(255)                     NULL     DEFAULT NULL,
  PRIMARY KEY (`idusuario`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `helpdesk`.`chamado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`chamado` (
  `idchamado`             INT(11)                                                                                            NOT NULL AUTO_INCREMENT,
  `titulo`                VARCHAR(45)                                                                                        NOT NULL,
  `prioridade`            ENUM ('ALTA', 'NORMAL', 'BAIXA')                                                                   NOT NULL,
  `status`                ENUM ('ABERTO', 'ATENDENDO', 'ESPERANDO', 'FECHADO_SUCESSO', 'FECHADO_FALHA', 'FECHADO_CANCELADO') NOT NULL,
  `data`                  DATETIME                                                                                           NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_idsolicitante` INT(11)                                                                                            NOT NULL,
  `usuario_idtecnico`     INT(11)                                                                                            NULL     DEFAULT NULL,
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
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 15
  DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `helpdesk`.`descricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`descricao` (
  `iddescricao`       INT(11)      NOT NULL AUTO_INCREMENT,
  `descricao`         VARCHAR(255) NOT NULL,
  `chamado_idchamado` INT(11)      NOT NULL,
  PRIMARY KEY (`iddescricao`, `chamado_idchamado`),
  INDEX `fk_descricao_chamado_idx` (`chamado_idchamado` ASC),
  CONSTRAINT `fk_descricao_chamado`
  FOREIGN KEY (`chamado_idchamado`)
  REFERENCES `helpdesk`.`chamado` (`idchamado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARACTER SET = utf8;

ALTER TABLE `helpdesk`.`descricao`
  ADD COLUMN `data` DATETIME NOT NULL AFTER `chamado_idchamado`,
  ADD COLUMN `usuario_idautor` INT NOT NULL AFTER `data`,
  ADD INDEX `fk_descricao_usuario_idx` (`usuario_idautor` ASC);
ALTER TABLE `helpdesk`.`descricao`
  ADD CONSTRAINT `fk_descricao_usuario`
FOREIGN KEY (`usuario_idautor`)
REFERENCES `helpdesk`.`usuario` (`idusuario`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


-- -----------------------------------------------------
-- Table `helpdesk`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk`.`historico` (
  `idhistorico`        INT(11)      NOT NULL AUTO_INCREMENT,
  `acao`               VARCHAR(255) NOT NULL,
  `justificativa`      VARCHAR(255) NULL     DEFAULT NULL,
  `hora`               DATETIME     NOT NULL DEFAULT NOW(),
  `usuario_idusuario1` INT(11)      NULL     DEFAULT NULL,
  `chamado_idchamado`  INT(11)      NULL     DEFAULT NULL,
  `usuario_idusuario2` INT(11)      NULL     DEFAULT NULL,
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
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
