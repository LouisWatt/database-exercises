-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `DOB` DATE NULL,
  `Address` VARCHAR(70) NULL,
  `PhoneNr` VARCHAR(10) NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`idDoctor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `idMedical` INT NOT NULL,
  `Doctor` INT NOT NULL,
  `Overtime_rate` INT NULL,
  PRIMARY KEY (`idMedical`),
  INDEX `fk_Medical_1_idx` (`Doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_1`
    FOREIGN KEY (`Doctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  `Doctor` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`idSpecialist`),
  INDEX `fk_Specialist_1_idx` (`Doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_1`
    FOREIGN KEY (`Doctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(70) NULL,
  `PhoneNr` VARCHAR(10) NULL,
  `DOB` DATE NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Patient` INT NOT NULL,
  `Doctor` INT NOT NULL,
  `Date` DATE NULL,
  `Time` VARCHAR(45) NULL,
  PRIMARY KEY (`idAppointment`),
  INDEX `fk_Appointment_1_idx` (`Doctor` ASC) VISIBLE,
  INDEX `fk_Appointment_2_idx` (`Patient` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_1`
    FOREIGN KEY (`Doctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_2`
    FOREIGN KEY (`Patient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Patient` INT NOT NULL,
  `Details` VARCHAR(90) NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`idPayment`),
  INDEX `fk_Payment_1_idx` (`Patient` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_1`
    FOREIGN KEY (`Patient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `Doctor` INT NULL,
  `Payment` INT NULL,
  `Total` INT NULL,
  PRIMARY KEY (`idBill`),
  INDEX `fk_Bill_2_idx` (`Doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_2`
    FOREIGN KEY (`Doctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment-bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment-bill` (
  `idpayment-bill` INT NOT NULL,
  `Payment` INT NOT NULL,
  `Bill` INT NOT NULL,
  PRIMARY KEY (`idpayment-bill`),
  INDEX `fk_payment-bill_2_idx` (`Bill` ASC) VISIBLE,
  INDEX `fk_payment-bill_1_idx` (`Payment` ASC) VISIBLE,
  CONSTRAINT `fk_payment-bill_1`
    FOREIGN KEY (`Payment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment-bill_2`
    FOREIGN KEY (`Bill`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
