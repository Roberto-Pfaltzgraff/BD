-- MySQL Script generated by MySQL Workbench
-- Sun Nov 17 15:40:00 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Oficina
-- -----------------------------------------------------
-- Projeto conceitual de Ordem de Serviço para Oficina Mecânica.
-- Desafio do Bootcamp de Analise de Dados com Power BI da DIO & Suzano.

-- -----------------------------------------------------
-- Schema Oficina
--
-- Projeto conceitual de Ordem de Serviço para Oficina Mecânica.
-- Desafio do Bootcamp de Analise de Dados com Power BI da DIO & Suzano.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Oficina` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Oficina` ;

-- -----------------------------------------------------
-- Table `Oficina`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Especialidade` (
  `idEspecialidade` INT NOT NULL AUTO_INCREMENT,
  `Especialidade` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`idEspecialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `nomeEquipe` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idEquipe`),
  UNIQUE INDEX `nomeEquipe_UNIQUE` (`nomeEquipe` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Mecanico` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(70) NOT NULL,
  `endLogradouro` VARCHAR(50) NOT NULL,
  `endNumero` INT NULL,
  `endBairro` VARCHAR(30) NULL,
  `endCidade` VARCHAR(30) NULL,
  `endUF` VARCHAR(2) NULL,
  `Especialidade_idEspecialidade` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`Codigo`),
  INDEX `fk_Mecanico_Especialidade_idx` (`Especialidade_idEspecialidade` ASC) VISIBLE,
  INDEX `fk_Mecanico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Especialidade`
    FOREIGN KEY (`Especialidade_idEspecialidade`)
    REFERENCES `Oficina`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecanico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `Oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(70) NOT NULL,
  `CPF_CNPJ` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_CNPJ_UNIQUE` (`CPF_CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `placaVeiculo` VARCHAR(10) NOT NULL,
  `fabricanteVeiculo` VARCHAR(50) NOT NULL,
  `modeloVeiculo` VARCHAR(50) NULL,
  `anoModeloVeiculo` INT NULL,
  `anoFabrilVeiculo` INT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  UNIQUE INDEX `placaVeiculo_UNIQUE` (`placaVeiculo` ASC) VISIBLE,
  INDEX `fk_Veiculo_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`OS` (
  `idOS` INT NOT NULL AUTO_INCREMENT,
  `tipoOS` VARCHAR(20) NOT NULL,
  `dataEmissaoOS` DATE NOT NULL,
  `statusOS` VARCHAR(30) NOT NULL,
  `valorOS` DECIMAL(10,2) NULL,
  `dataEntregaOS` DATE NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`idOS`),
  INDEX `fk_OS_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_OS_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_OS_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_OS_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `Oficina`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `Oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chk_tipoOS1`
    CHECK (tipoOS in ('CONSERTO', 'REVISAO'))
	)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `nomeServico` VARCHAR(50) NOT NULL,
  `valorServico` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idServico`),
  UNIQUE INDEX `nomeServico_UNIQUE` (`nomeServico` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Peca` (
  `idPeca` INT NOT NULL AUTO_INCREMENT,
  `nomePeca` VARCHAR(50) NOT NULL,
  `fabricantePeca` VARCHAR(45) NULL,
  `valorPeca` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Item_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Item_OS` (
  `idItem_OS` INT NOT NULL AUTO_INCREMENT,
  `OS_idOS` INT NOT NULL,
  `Servico_idServico` INT NULL,
  `Peca_idPeca` INT NULL,
  `qtdItem_OS` INT NOT NULL DEFAULT 1,
  `valorUnitarioItem_OS` DECIMAL(7,2) NULL,
  INDEX `fk_Item_OS_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_Item_OS_Peca1_idx` (`Peca_idPeca` ASC) VISIBLE,
  PRIMARY KEY (`idItem_OS`),
  UNIQUE INDEX `UK_idOS_Peca_Serv` (`OS_idOS` ASC, `Servico_idServico` ASC, `Peca_idPeca` ASC) VISIBLE,
  CONSTRAINT `fk_Item_OS_OS1`
    FOREIGN KEY (`OS_idOS`)
    REFERENCES `Oficina`.`OS` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_OS_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `Oficina`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_OS_Peca1`
    FOREIGN KEY (`Peca_idPeca`)
    REFERENCES `Oficina`.`Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chk_Servico_xor_Peca`
    CHECK (
      (Servico_idServico IS NOT NULL AND Peca_idPeca IS NULL) OR 
      (Servico_idServico IS NULL AND Peca_idPeca IS NOT NULL)
    ))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
