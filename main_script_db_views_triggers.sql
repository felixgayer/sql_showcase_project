-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema final project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema final project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `final project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `final project` ;

-- -----------------------------------------------------
-- Table `final project`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `city_id_UNIQUE` (`city_id` ASC) VISIBLE,
  UNIQUE INDEX `city_name_UNIQUE` (`city_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`postal_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`postal_region` (
  `region_id` INT NOT NULL AUTO_INCREMENT,
  `region` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`postal_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`postal_code` (
  `zip_code` VARCHAR(8) NOT NULL,
  `postal_region_region_id` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  PRIMARY KEY (`zip_code`),
  UNIQUE INDEX `zip_code_UNIQUE` (`zip_code` ASC) VISIBLE,
  INDEX `fk_postal_code_postal_region1_idx` (`postal_region_region_id` ASC) VISIBLE,
  INDEX `fk_postal_code_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_postal_code_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `final project`.`city` (`city_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_postal_code_postal_region1`
    FOREIGN KEY (`postal_region_region_id`)
    REFERENCES `final project`.`postal_region` (`region_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`address` (
  `customer_address_id` INT NOT NULL AUTO_INCREMENT,
  `street_name` VARCHAR(80) NOT NULL,
  `house_nr` VARCHAR(5) NOT NULL,
  `floor_nr` VARCHAR(2) NOT NULL,
  `door` VARCHAR(5) NOT NULL,
  `postal_code_zip_code` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`customer_address_id`),
  UNIQUE INDEX `customer_address_id_UNIQUE` (`customer_address_id` ASC) VISIBLE,
  INDEX `fk_address_postal_code1_idx` (`postal_code_zip_code` ASC) VISIBLE,
  CONSTRAINT `fk_address_postal_code1`
    FOREIGN KEY (`postal_code_zip_code`)
    REFERENCES `final project`.`postal_code` (`zip_code`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(3) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_nr` VARCHAR(13) NOT NULL,
  `payment_method` VARCHAR(15) NOT NULL,
  `address_customer_address_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  INDEX `fk_customer_address1_idx` (`address_customer_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_customer_address_id`)
    REFERENCES `final project`.`address` (`customer_address_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10000032
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`profession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`profession` (
  `profession_id` INT NOT NULL AUTO_INCREMENT,
  `profession_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`profession_id`),
  UNIQUE INDEX `profession_id_UNIQUE` (`profession_id` ASC) VISIBLE,
  UNIQUE INDEX `profession_name_UNIQUE` (`profession_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_nr` VARCHAR(13) NOT NULL,
  `postal_region_region_id` INT NOT NULL,
  `profession_profession_id` INT NOT NULL,
  `employee_rating` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_postal_region1_idx` (`postal_region_region_id` ASC) VISIBLE,
  INDEX `fk_employee_profession1_idx` (`profession_profession_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_postal_region1`
    FOREIGN KEY (`postal_region_region_id`)
    REFERENCES `final project`.`postal_region` (`region_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_profession1`
    FOREIGN KEY (`profession_profession_id`)
    REFERENCES `final project`.`profession` (`profession_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`log_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`log_table` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `log_message` VARCHAR(255) NOT NULL,
  `log_values` VARCHAR(100) NOT NULL,
  `timestamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`service` (
  `service_id` INT NOT NULL AUTO_INCREMENT,
  `service_type` VARCHAR(60) NOT NULL,
  `price_per_hour` FLOAT NOT NULL,
  `profession_profession_id` INT NOT NULL,
  `service_rating` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE INDEX `service_id_UNIQUE` (`service_id` ASC) VISIBLE,
  INDEX `fk_services_profession1_idx` (`profession_profession_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_profession1`
    FOREIGN KEY (`profession_profession_id`)
    REFERENCES `final project`.`profession` (`profession_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `date_of_issue` DATETIME NOT NULL,
  `amount_in_eur` FLOAT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final project`.`service_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final project`.`service_order` (
  `service_order_id` INT NOT NULL AUTO_INCREMENT,
  `date_of_service` DATETIME NOT NULL,
  `date_of_booking` DATETIME NOT NULL,
  `total_amount_eur` FLOAT NOT NULL,
  `hours_of_work` TINYINT(1) NOT NULL,
  `fulfilled` TINYINT NOT NULL,
  `employee_confirmed` TINYINT NOT NULL,
  `rating` TINYINT NULL DEFAULT NULL,
  `customer_customer_id` INT NOT NULL,
  `employee_employee_id` INT NOT NULL,
  `service_service_id` INT NOT NULL,
  `transactions_transaction_id` INT NOT NULL,
  PRIMARY KEY (`service_order_id`),
  UNIQUE INDEX `service_order_id_UNIQUE` (`service_order_id` ASC) VISIBLE,
  INDEX `fk_service_order_customer1_idx` (`customer_customer_id` ASC) VISIBLE,
  INDEX `fk_service_order_employee1_idx` (`employee_employee_id` ASC) VISIBLE,
  INDEX `fk_service_order_service1_idx` (`service_service_id` ASC) VISIBLE,
  INDEX `fk_service_order_transactions1_idx` (`transactions_transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_service_order_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `final project`.`customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_service_order_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `final project`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_service_order_service1`
    FOREIGN KEY (`service_service_id`)
    REFERENCES `final project`.`service` (`service_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_service_order_transactions1`
    FOREIGN KEY (`transactions_transaction_id`)
    REFERENCES `final project`.`transactions` (`transaction_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Insert data -----------------------------------------
-- -----------------------------------------------------

-- Customer

INSERT INTO `final project`.`customer` (`Customer_ID`, `Title`, `First_name`, `Last_name`, `email`, `phone_nr`, `Payment_method`, `address_customer_address_id`) VALUES 
(010000001, 'Mr', 'Rodrigo', 'Cruz Martins Cruz', 'Rodrigo.Cruz@yahoo.com', '0035181225155', 'MB Way', '020000001'),
(010000002, 'Mrs', 'Inês', 'Santos Mendes Martins', 'Inês.Santos@hotmail.com', '0035197293559', 'Credit card', '020000002'),
(010000003, 'Mr', 'Santiago', 'Barbosa Carvalho Castro', 'Santiago.Barbosa@icloud.com', '0035150201626', 'MB Way', '020000003'),
(010000004, 'Mrs', 'Laura', 'Madeira Mendes Carvalho', 'Laura.Madeira@icloud.com', '0035115258155', 'MB Way', '020000004'),
(010000005, 'Mrs', 'Beatriz', 'Martins Cabral Silva', 'Beatriz.Martins@outlook.com', '0035126658736', 'Credit card', '020000005'),
(010000006, 'Mr', 'Lourenço', 'Cruz Silva Henriques', 'Lourenço.Cruz@hotmail.com', '0035162630681', 'MB Way', '020000006'),
(010000007, 'Mr', 'Rodrigo', 'Souza Ribeiro Silva', 'Rodrigo.Souza@icloud.com', '0035180325308', 'Credit card', '020000007'),
(010000008, 'Mrs', 'Mariana', 'Souza Martins Pedro', 'Mariana.Souza@hotmail.com', '0035115661581', 'Credit card', '020000008'),
(010000009, 'Mrs', 'Cláudia', 'Mendes Pedro Mendes', 'Cláudia.Mendes@yahoo.com', '0035142773126', 'Credit card', '020000009'),
(010000010, 'Mrs', 'Madalena', 'Cruz Mendes Pedro', 'Madalena.Cruz@gmail.com', '0035193464304', 'Credit card', '020000010'),
(010000011, 'Mr', 'João', 'Barbosa Pedro Cruz', 'João.Barbosa@hotmail.com', '0035195421880', 'MB Way', '020000011'),
(010000012, 'Mr', 'Santiago', 'Madeira Costa Costa', 'Santiago.Madeira@icloud.com', '0035160364391', 'MB Way', '020000012'),
(010000013, 'Mr', 'Guilherme', 'Madeira Martins Barbosa', 'Guilherme.Madeira@yahoo.com', '0035125519951', 'Credit card', '020000013'),
(010000014, 'Mrs', 'Laura', 'Souza Oliveira Barbosa', 'Laura.Souza@hotmail.com', '0035152394685', 'Credit card', '020000014'),
(010000015, 'Mr', 'Guilherme', 'Gomes Ribeiro Oliveira', 'Guilherme.Gomes@gmail.com', '0035135399232', 'Paypal', '020000015'),
(010000016, 'Mr', 'Santiago', 'Gomes Castro Gomes', 'Santiago.Gomes@hotmail.com', '0035138737771', 'Credit card', '020000016'),
(010000017, 'Mrs', 'Madalena', 'Cruz Costa Gomes', 'Madalena.Cruz@yahoo.com', '0035170089489', 'Credit card', '020000017'),
(010000018, 'Mr', 'Salvador', 'Martins Santos Souza', 'Salvador.Martins@outlook.com', '0035134219740', 'MB Way', '020000018'),
(010000019, 'Mr', 'Afonso', 'Santos Silva Ribeiro', 'Afonso.Santos@hotmail.com', '0035145637935', 'Credit card', '020000019'),
(010000020, 'Mrs', 'Rita', 'Castro Castro Cruz', 'Rita.Castro@hotmail.com', '0035140206418', 'Credit card', '020000020'),
(010000021, 'Mrs', 'Rita', 'Cruz Carvalho Carvalho', 'Rita.Cruz@icloud.com', '0035133756613', 'Credit card', '020000021'),
(010000022, 'Mrs', 'Mariana', 'Madeira Santos Castro', 'Mariana.Madeira@outlook.com', '0035148300435', 'Credit card', '020000022'),
(010000023, 'Mr', 'João', 'Henriques Cruz Souza', 'João.Henriques@icloud.com', '0035151957454', 'MB Way', '020000023'),
(010000024, 'Mr', 'Afonso', 'Cruz Barbosa Gomes', 'Afonso.Cruz@outlook.com', '0035143094525', 'Credit card', '020000024'),
(010000025, 'Mr', 'Santiago', 'Cruz Costa Castro', 'Santiago.Cruz@icloud.com', '0035137014542', 'Paypal', '020000025'),
(010000026, 'Mrs', 'Laura', 'Ribeiro Barbosa Ribeiro', 'Laura.Ribeiro@gmail.com', '0035156451739', 'Paypal', '020000026'),
(010000027, 'Mrs', 'Inês', 'Silva Pedro Cabral', 'Inês.Silva@yahoo.com', '0035132466406', 'Credit card', '020000027'),
(010000028, 'Mr', 'João', 'Carvalho Gomes Mendes', 'João.Carvalho@hotmail.com', '0035189448577', 'Credit card', '020000028'),
(010000029, 'Mrs', 'Francisca', 'Martins Madeira Madeira', 'Francisca.Martins@icloud.com', '0035160473137', 'Paypal', '020000029'),
(010000030, 'Mr', 'Guilherme', 'Henriques Barbosa Cruz', 'Guilherme.Henriques@icloud.com', '0035193950769', 'MB Way', '020000030')
;

-- Address

INSERT INTO `final project`.`address` (`Customer_address_ID`, `Street_name`, `house_nr`, `floor_nr`, `Door`, `postal_code_zip_code`) 
VALUES 
(020000001, 'Rua Maria', '30', '3', 'Frt', '4625-099'),
(020000002, 'Avenida Liberdade', '58', '4', 'Drt', '4450-161'),
(020000003, 'Avenida Claudia', '38', '3', 'Esq', '4950-140'),
(020000004, 'Rua de Santa María', '74', '5', 'Drt', '2000-358'),
(020000005, 'Rua do Comércio', '10', '1', 'Drt', '4640-159'),
(020000006, 'Rua da Bombarda', '15', '1', 'Esq', '4430-445'),
(020000007, 'Rua Telheiro', '35', '2', 'Drt', '7160-053'),
(020000008, 'Rua Pombal', '20', '1', 'Drt', '4715-187'),
(020000009, 'R Amadeu S Cardoso', '100', '5', 'Esq', '2745-064'),
(020000010, 'Avenida João C Real', '69', '0', 'Drt', '2635-489'),
(020000011, 'R Tomé B Queirós', '19', '1', 'Drt', '4455-253'),
(020000012, 'R Doutor Alfredo Freitas', '22', '5', 'Esq', '4635-033'),
(020000013, 'Praça Teófilo Braga', '65', '5', 'Esq', '2435-087'),
(020000014, 'Avenida Júlio Dinis', '29', '0', 'Drt', '4860-149'),
(020000015, 'Rua Vale Formoso', '74', '3', 'Frt', '2435-204'),
(020000016, 'Zona Estação', '5', '4', 'Drt', '2835-149'),
(020000017, 'Avenida República', '4', '5', 'Drt', '2700-107'),
(020000018, 'Travessa Moura Sá', '25', '5', 'Frt', '2430-277'),
(020000019, 'Largo Prazeres', '47', '2', 'Frt', '2070-598'),
(020000020, 'R Cortinhas Fonte', '24', '4', 'Esq', '7050-632'),
(020000021, 'Avenida Boavista', '38', '0', 'Esq', '1700-176'),
(020000022, 'R Poço Lote', '63', '0', 'Esq', '2780-093'),
(020000023, 'Avenida Doutor Fernando Gomes', '32', '3', 'Drt', '4615-689'),
(020000024, 'Praceta Maria Lamas', '27', '3', 'Esq', '2615-073'),
(020000025, 'Avenida Lago', '46', '4', 'Esq', '2645-140'),
(020000026, 'R Direita-Igreja', '76', '5', 'Esq', '4535-008'),
(020000027, 'R Maria M Tavares', '17', '5', 'Esq', '2910-276'),
(020000028, 'Avendia Felix Segundo', '53', '2', 'Drt', '4610-226'),
(020000029, 'Rua Inês', '100', '4', 'Frt', '5470-222'),
(020000030, 'Largo Comandante Jannik', '48', '3', 'Esq', '4460-835')
;

-- Postal Code

INSERT INTO `final project`.`postal_code` (`ZIP_code`, `city_city_id`, `Postal_region_region_ID`) VALUES 
('4625-099', '140001734', '120000004'),
('4450-161', '140001751', '120000004'),
('4950-140', '140004500', '120000004'),
('2000-358', '140001367', '120000002'),
('4640-159', '140001009', '120000004'),
('4430-445', '140001188', '120000004'),
('7160-053', '140002372', '120000007'),
('4715-187', '140000478', '120000004'),
('2745-064', '140001044', '120000002'),
('2635-489', '140004649', '120000002'),
('4455-253', '140001752', '120000004'),
('4635-033', '140003525', '120000004'),
('2435-087', '140001700', '120000002'),
('4860-149', '140000495', '120000004'),
('2435-204', '140001706', '120000002'),
('2835-149', '140001512', '120000002'),
('2700-107', '140001095', '120000002'),
('2430-277', '140001980', '120000002'),
('2070-598', '140001147', '120000002'),
('7050-632', '140003079', '120000007'),
('1700-176', '140002011', '120000001'),
('2780-093', '140000408', '120000002'),
('4615-689', '140001025', '120000004'),
('2615-073', '140001089', '120000002'),
('2645-140', '140001963', '120000002'),
('4535-008', '140000231', '120000004'),
('2910-276', '140001411', '120000002'),
('4610-226', '140001017', '120000004'),
('5470-222', '140000763', '120000005'),
('4460-835', '140001755', '120000004')
;

-- City

INSERT INTO `final project`.`city` (`city_id`, `city_name`) VALUES 
(140001734, 'Favões'),
(140001751, 'Matosinhos'),
(140004500, 'Lapela'),
(140001367, 'Alcanhões'),
(140001009, 'Baião'),
(140001188, 'Vila Nova de Gaia'),
(140002372, 'Bencatel'),
(140000478, 'Braga'),
(140001044, 'Queluz'),
(140004649, 'Varge Mondar'),
(140001752, 'Lavra'),
(140003525, 'Banho e Carvalhosa'),
(140001700, 'Chã'),
(140000495, 'Refojos de Basto'),
(140001706, 'Casal da Fonte'),
(140001512, 'Baixa da Banheira'),
(140001095, 'Amadora'),
(140001980, 'Marinha Grande'),
(140001147, 'Vale da Pinta'),
(140003079, 'Alto da Mata'),
(140002011, 'Lisboa'),
(140000408, 'Oeiras'),
(140001025, 'Lixa'),
(140001089, 'Alverca do Ribatejo'),
(140001963, 'Alcoitão'),
(140000231, 'Lourosa'),
(140001411, 'Setúbal'),
(140001017, 'Felgueiras'),
(140000763, 'Montalegre'),
(140001755, 'Guifões')
;

-- Employee

INSERT INTO `final project`.`employee` (`Employee_ID`, `First_name`, `Last_name`, `profession_Profession_id`, `Phone_nr`, `postal_region_region_id`, `employee_rating`) VALUES 
(080000001, 'Beatriz', 'Pedro Ribeiro Madeira', '150000002', '0035118110275', 120000002, '4.2'),
(080000002, 'Laura', 'Ribeiro Carvalho Silva', '150000002', '0035179235125', 120000001, '0'),
(080000003, 'Rita', 'Ribeiro Cruz Henriques', '150000005', '0035126668592', 120000006, '0'),
(080000004, 'Lourenço', 'Castro Carvalho Martins', '150000002', '0035198329037', 120000005, '0'),
(080000005, 'Francisca', 'Cabral Costa Cabral', '150000005', '0035187718381', 120000002, '3.7'),
(080000006, 'Francisco', 'Martins Madeira Madeira', '150000004', '0035156012363', 120000004, '4.1'),
(080000007, 'Beatriz', 'Gomes Mendes Gomes', '150000003', '0035137428632', 120000007, '3.5'),
(080000008, 'João', 'Costa Henriques Silva', '150000006', '0035154674373', 120000006, '0'),
(080000009, 'Rita', 'Henriques Gomes Santos', '150000004', '0035161770752', 120000001, '5'),
(080000010, 'Salvador', 'Cabral Pedro Ribeiro', '150000006', '0035190690809', 120000003, '0'),
(080000011, 'Ricardo', 'Silva Castro Martins', '150000001', '0035145491961', 120000003, '0'),
(080000012, 'Francisco', 'Carvalho Silva Cabral', '150000004', '0035138489583', 120000004, '0'),
(080000013, 'Rodrigo', 'Martins Silva Cruz', '150000003', '0035190283542', 120000001, '4.6'),
(080000014, 'Madalena', 'Martins Henriques Cruz', '150000005', '0035171092961', 120000001, '3'),
(080000015, 'Guilherme', 'Cabral Oliveira Castro', '150000002', '0035188062194', 120000003, '0'),
(080000016, 'Guilherme', 'Henriques Carvalho Oliveira', '150000006', '0035130987550', 120000006, '0'),
(080000017, 'Pedro', 'Oliveira Henriques Mendes', '150000002', '0035112276066', 120000007, '3'),
(080000018, 'Inês', 'Martins Gomes Santos', '150000004', '0035121633472', 120000002, '3.8'),
(080000019, 'Pedro', 'Gomes Silva Oliveira', '150000001', '0035159491508', 120000006, '0'),
(080000020, 'Francisca', 'Santos Santos Carvalho', '150000002', '0035117938188', 120000001, '0'),
(080000021, 'Pedro', 'Cabral Costa Henriques', '150000001', '0035192081338', 120000004, '0'),
(080000022, 'Pedro', 'Santos Gomes Cruz', '150000006', '0035180702946', 120000002, '4.3'),
(080000023, 'Francisco', 'Costa Mendes Cabral', '150000003', '0035171682470', 120000001, '0'),
(080000024, 'Francisco', 'Costa Costa Cruz', '150000003', '0035130918968', 120000006, '0'),
(080000025, 'Santiago', 'Santos Henriques Ribeiro', '150000006', '0035157160826', 120000003, '0'),
(080000026, 'Rodrigo', 'Oliveira Henriques Castro', '150000003', '0035189677021', 120000007, '0'),
(080000027, 'Francisco', 'Madeira Costa Gomes', '150000005', '0035138881973', 120000008, '0'),
(080000028, 'Pedro', 'Costa Cruz Pedro', '150000006', '0035169946901', 120000005, '0'),
(080000029, 'Madalena', 'Mendes Martins Barbosa', '150000006', '0035185266302', 120000001, '0'),
(080000030, 'Francisco', 'Oliveira Madeira Henriques', '150000003', '0035128630196', 120000008, '0'),
(080000031, 'Rodrigo', 'Oliveira Gomes Cabral', '150000003', '0035139899455', 120000005, '3.5'),
(080000032, 'Madalena', 'Cabral Oliveira Castro', '150000006', '0035152181479', 120000007, '0'),
(080000033, 'Salvador', 'Costa Gomes Henriques', '150000005', '0035119671516', 120000001, '0'),
(080000034, 'Rita', 'Ribeiro Barbosa Souza', '150000004', '0035154883223', 120000005, '3'),
(080000035, 'Santiago', 'Ribeiro Carvalho Ribeiro', '150000003', '0035193669711', 120000001, '0'),
(080000036, 'Lourenço', 'Martins Oliveira Costa', '150000003', '0035152403722', 120000004, '4.1'),
(080000037, 'Cláudia', 'Santos Gomes Silva', '150000002', '0035196085323', 120000002, '0'),
(080000038, 'Beatriz', 'Oliveira Santos Madeira', '150000002', '0035117306716', 120000002, '0'),
(080000039, 'Madalena', 'Henriques Castro Pedro', '150000003', '0035122366227', 120000007, '0'),
(080000040, 'Rodrigo', 'Silva Barbosa Henriques', '150000001', '0035179035794', 120000006, '0'),
(080000041, 'Laura', 'Silva Madeira Martins', '150000002', '0035142870712', 120000001, '0'),
(080000042, 'Rita', 'Santos Castro Santos', '150000001', '0035156787075', 120000005, '0'),
(080000043, 'Santiago', 'Ribeiro Pedro Cruz', '150000003', '0035158047149', 120000006, '0'),
(080000044, 'Beatriz', 'Cabral Souza Costa', '150000001', '0035147156198', 120000002, '0'),
(080000045, 'Pedro', 'Mendes Santos Carvalho', '150000002', '0035159249944', 120000002, '0'),
(080000046, 'Francisco', 'Castro Pedro Costa', '150000003', '0035142529855', 120000002, '3.8'),
(080000047, 'Rita', 'Gomes Silva Pedro', '150000004', '0035150282908', 120000003, '0'),
(080000048, 'Inês', 'Pedro Carvalho Oliveira', '150000005', '0035147789013', 120000005, '5'),
(080000049, 'Cláudia', 'Silva Ribeiro Santos', '150000003', '0035163515098', 120000008, '0'),
(080000050, 'Francisco', 'Mendes Oliveira Silva', '150000005', '0035115724596', 120000006, '0'),
(080000051, 'João', 'Silva Costa Martins', '150000001', '0035177508092', 120000007, '0'),
(080000052, 'Madalena', 'Oliveira Costa Santos', '150000006', '0035155421261', 120000007, '0'),
(080000053, 'Rita', 'Costa Henriques Castro', '150000003', '0035166651002', 120000006, '0'),
(080000054, 'Ricardo', 'Barbosa Gomes Silva', '150000001', '0035175713431', 120000002, '0'),
(080000055, 'Laura', 'Souza Costa Henriques', '150000006', '0035172238232', 120000007, '0'),
(080000056, 'Lourenço', 'Silva Silva Cabral', '150000005', '0035125841302', 120000002, '0'),
(080000057, 'Laura', 'Ribeiro Mendes Carvalho', '150000006', '0035138199184', 120000005, '0'),
(080000058, 'Pedro', 'Barbosa Madeira Castro', '150000005', '0035198095229', 120000005, '0'),
(080000059, 'Pedro', 'Souza Cruz Souza', '150000005', '0035139596429', 120000007, '0'),
(080000060, 'Cláudia', 'Souza Silva Gomes', '150000005', '0035197245953', 120000006, '0'),
(080000061, 'Pedro', 'Cruz Gomes Pedro', '150000001', '0035124373368', 120000001, '0'),
(080000062, 'Pedro', 'Mendes Gomes Silva', '150000002', '0035181630333', 120000002, '0'),
(080000063, 'Francisca', 'Ribeiro Henriques Cruz', '150000006', '0035146326936', 120000004, '4.5'),
(080000064, 'Ricardo', 'Ribeiro Cruz Gomes', '150000001', '0035116889581', 120000004, '0'),
(080000065, 'Santiago', 'Gomes Pedro Silva', '150000005', '0035110391715', 120000006, '0'),
(080000066, 'João', 'Costa Pedro Ribeiro', '150000002', '0035164549514', 120000004, '4.6'),
(080000067, 'Rodrigo', 'Gomes Ribeiro Carvalho', '150000004', '0035194699129', 120000002, '0'),
(080000068, 'Lourenço', 'Cabral Costa Silva', '150000001', '0035197032118', 120000007, '0'),
(080000069, 'Inês', 'Martins Madeira Pedro', '150000006', '0035136809390', 120000007, '0'),
(080000070, 'Guilherme', 'Barbosa Souza Gomes', '150000006', '0035171570128', 120000008, '0'),
(080000071, 'Mariana', 'Pedro Martins Madeira', '150000006', '0035162645735', 120000007, '0'),
(080000072, 'Madalena', 'Castro Pedro Madeira', '150000003', '0035179559556', 120000003, '0'),
(080000073, 'Ricardo', 'Santos Pedro Castro', '150000003', '0035193232866', 120000002, '0'),
(080000074, 'Francisca', 'Henriques Santos Henriques', '150000004', '0035153849177', 120000005, '0'),
(080000075, 'Madalena', 'Souza Oliveira Barbosa', '150000004', '0035165123852', 120000001, '0'),
(080000076, 'Madalena', 'Carvalho Mendes Ribeiro', '150000006', '0035175816974', 120000005, '0'),
(080000077, 'Inês', 'Silva Pedro Cabral', '150000005', '0035137059177', 120000002, '0'),
(080000078, 'Pedro', 'Gomes Madeira Santos', '150000004', '0035180802869', 120000003, '0'),
(080000079, 'Salvador', 'Silva Castro Silva', '150000005', '0035147476483', 120000002, '0'),
(080000080, 'Santiago', 'Cabral Gomes Carvalho', '150000005', '0035152963055', 120000002, '0'),
(080000081, 'Mariana', 'Castro Cabral Costa', '150000001', '0035173511395', 120000002, '0'),
(080000082, 'Beatriz', 'Cruz Souza Henriques', '150000003', '0035167040786', 120000005, '0'),
(080000083, 'Madalena', 'Oliveira Gomes Pedro', '150000005', '0035131609893', 120000006, '0'),
(080000084, 'Guilherme', 'Castro Martins Costa', '150000001', '0035190985406', 120000007, '0'),
(080000085, 'Pedro', 'Cabral Carvalho Martins', '150000003', '0035188324542', 120000008, '0'),
(080000086, 'Guilherme', 'Mendes Pedro Carvalho', '150000006', '0035173774966', 120000001, '0'),
(080000087, 'Francisco', 'Castro Costa Costa', '150000001', '0035139130749', 120000006, '0'),
(080000088, 'Francisca', 'Santos Oliveira Costa', '150000006', '0035149839499', 120000005, '0'),
(080000089, 'Rita', 'Santos Cruz Cabral', '150000003', '0035179936544', 120000002, '0'),
(080000090, 'Salvador', 'Madeira Madeira Ribeiro', '150000005', '0035117561774', 120000005, '0'),
(080000091, 'Lourenço', 'Pedro Ribeiro Mendes', '150000002', '0035171526533', 120000007, '0'),
(080000092, 'Inês', 'Cabral Gomes Santos', '150000003', '0035185329957', 120000006, '0'),
(080000093, 'Lourenço', 'Henriques Cruz Martins', '150000004', '0035171273925', 120000006, '0'),
(080000094, 'Francisca', 'Costa Mendes Oliveira', '150000005', '0035150158628', 120000002, '0'),
(080000095, 'Beatriz', 'Santos Santos Pedro', '150000006', '0035120543346', 120000003, '0'),
(080000096, 'Cláudia', 'Costa Carvalho Cabral', '150000006', '0035159590573', 120000001, '0'),
(080000097, 'Madalena', 'Santos Santos Madeira', '150000001', '0035143763513', 120000001, '0'),
(080000098, 'Guilherme', 'Santos Santos Castro', '150000002', '0035157270434', 120000006, '0'),
(080000099, 'Madalena', 'Carvalho Mendes Barbosa', '150000002', '0035182550991', 120000006, '0'),
(080000100, 'Salvador', 'Mendes Pedro Henriques', '150000001', '0035157266649', 120000008, '0'),
(080000101, 'Pedro', 'Madeira Ribeiro Castro', '150000005', '0035176915551', 120000004, '4.3'),
(080000102, 'Francisca', 'Cabral Carvalho Madeira', '150000004', '0035130410118', 120000007, '2.5'),
(080000103, 'Laura', 'Martins Carvalho Oliveira', '150000004', '0035184130379', 120000007, '0'),
(080000104, 'Rita', 'Oliveira Oliveira Pedro', '150000005', '0035173150269', 120000004, '0'),
(080000105, 'Inês', 'Oliveira Cabral Cruz', '150000005', '0035130253069', 120000004, '0'),
(080000106, 'Salvador', 'Barbosa Carvalho Henriques', '150000005', '0035128788121', 120000004, '0')
;

-- Postal region

INSERT INTO `final project`.`postal_region` (`region_id`, `region`) VALUES 
( '120000001', 'Lisboa'),
( '120000002', 'Estremadura e Ribatejo'),
( '120000003', 'Beira Litoral'),
( '120000004', 'Minho e Douro Litoral'),
( '120000005', 'Trás-os-Montes e Alto Douro'),
( '120000006', 'Beira Interior'),
( '120000007', 'Alentejo'),
( '120000008', 'Algarve')
;

-- Profession

INSERT INTO `final project`.`profession` (`profession_id`, `Profession_name`) VALUES 
(150000001, 'Profession'),
(150000002, 'Electrician'),
(150000003, 'Plumber'),
(150000004, 'Carpenter'),
(150000005, 'Painter'),
(150000006, 'Gardener')
;

-- Service order

INSERT into `final project`.`service_order` (`service_order_id`, `date_of_booking`, `date_of_service`, `total_amount_eur`, `hours_of_work`, `customer_customer_id`, `service_service_id`, `fulfilled`, `transactions_transaction_id`, `Employee_confirmed`, `rating`,  `employee_Employee_id`) VALUES 
('040000001', '2020-01-04 11:26','2020-01-07 03:17', '585', '13', '010000003', '030000015', '1', '060000001', '1','5','080000006'),
('040000002', '2020-01-25 19:15','2020-02-06 09:56', '495', '11', '010000018', '030000015', '1', '060000002', '1','5','080000018'),
('040000003', '2020-02-12 14:39','2020-02-24 11:51', '45', '1', '010000028', '030000005', '1', '060000003', '1','5','080000101'),
('040000004', '2020-02-20 20:47','2020-03-05 13:43', '450', '9', '010000001', '030000014', '1', '060000004', '1','4','080000036'),
('040000005', '2020-02-22 00:15','2020-03-06 02:41', '1680', '14', '010000004', '030000007', '1', '060000005', '1','5','080000046'),
('040000006', '2020-02-28 09:19','2020-03-01 12:56', '540', '12', '010000006', '030000015', '1', '060000006', '1','5','080000006'),
('040000007', '2020-03-31 21:47','2020-04-04 19:32', '630', '14', '010000021', '030000005', '1', '060000007', '1','3','080000014'),
('040000008', '2020-04-08 09:53','2020-04-12 00:23', '720', '9', '010000002', '030000010', '1', '060000008', '1','5','080000006'),
('040000009', '2020-04-10 07:17','2020-04-15 20:20', '45', '1', '010000027', '030000015', '1', '060000009', '1','4','080000018'),
('040000010', '2020-04-14 11:34','2020-04-25 01:56', '250', '5', '010000021', '030000014', '1', '060000010', '1','5','080000013'),
('040000011', '2020-04-19 23:04','2020-04-21 14:01', '135', '3', '010000010', '030000005', '1', '060000011', '1','4','080000005'),
('040000012', '2020-04-26 15:46','2020-05-05 13:01', '585', '13', '010000014', '030000015', '1', '060000012', '1','3','080000006'),
('040000013', '2020-05-02 23:07','2020-05-14 22:34', '360', '6', '010000009', '030000009', '1', '060000013', '1','5','080000046'),
('040000014', '2020-05-04 10:55','2020-05-07 23:15', '480', '8', '010000014', '030000006', '1', '060000014', '1','3','080000066'),
('040000015', '2020-05-26 07:13','2020-06-05 02:10', '45', '1', '010000015', '030000015', '1', '060000015', '1','3','080000018'),
('040000016', '2020-05-31 22:30','2020-06-06 08:04', '200', '4', '010000019', '030000001', '1', '060000016', '1','3','080000046'),
('040000017', '2020-06-11 20:40','2020-06-21 03:20', '360', '8', '010000029', '030000005', '1', '060000017', '1','5','080000048'),
('040000018', '2020-06-23 05:24','2020-06-27 06:58', '180', '4', '010000024', '030000005', '1', '060000018', '1','4','080000005'),
('040000019', '2020-06-29 08:37','2020-07-08 08:18', '245', '7', '010000024', '030000002', '1', '060000019', '1','4','080000001'),
('040000020', '2020-07-24 17:54','2020-07-30 17:34', '880', '11', '010000003', '030000010', '1', '060000020', '1','4','080000006'),
('040000021', '2020-08-01 11:28','2020-08-08 11:42', '50', '1', '010000018', '030000001', '1', '060000021', '1','5','080000046'),
('040000022', '2020-08-01 14:40','2020-08-15 16:06', '960', '12', '010000016', '030000010', '1', '060000022', '1','3','080000018'),
('040000023', '2020-08-07 22:06','2020-08-12 06:22', '720', '6', '010000029', '030000007', '1', '060000023', '1','3','080000031'),
('040000024', '2020-08-20 09:25','2020-08-23 18:35', '450', '9', '010000021', '030000001', '1', '060000024', '1','4','080000013'),
('040000025', '2020-08-24 06:36','2020-09-05 00:15', '200', '5', '010000010', '030000013', '1', '060000025', '1','5','080000022'),
('040000026', '2020-08-27 05:24','2020-08-28 06:10', '240', '4', '010000011', '030000003', '1', '060000026', '1','5','080000036'),
('040000027', '2020-08-28 21:38','2020-09-01 19:56', '1400', '14', '010000003', '030000012', '1', '060000027', '1','5','080000036'),
('040000028', '2020-09-07 14:50','2020-09-14 18:52', '720', '6', '010000004', '030000011', '1', '060000028', '1','4','080000046'),
('040000029', '2020-09-13 14:03','2020-09-22 22:05', '630', '14', '010000003', '030000015', '1', '060000029', '1','4','080000006'),
('040000030', '2020-09-30 20:22','2020-10-04 16:29', '360', '6', '010000013', '030000006', '1', '060000030', '1','5','080000001'),
('040000031', '2020-10-18 15:56','2020-10-19 21:36', '720', '9', '010000007', '030000010', '1', '060000031', '1','4','080000102'),
('040000032', '2020-10-25 04:30','2020-11-03 19:17', '500', '10', '010000025', '030000001', '1', '060000032', '1','5','080000046'),
('040000033', '2020-11-08 05:21','2020-11-10 22:14', '200', '5', '010000008', '030000013', '1', '060000033', '1','4','080000063'),
('040000034', '2020-11-23 11:58','2020-11-25 17:35', '360', '8', '010000020', '030000015', '1', '060000034', '1','1','080000102'),
('040000035', '2020-11-29 23:52','2020-11-30 02:48', '1400', '14', '010000011', '030000008', '1', '060000035', '1','5','080000036'),
('040000036', '2020-12-11 16:27','2020-12-17 03:20', '840', '14', '010000003', '030000009', '1', '060000036', '1','4','080000036'),
('040000037', '2020-12-17 04:26','2020-12-22 00:56', '360', '6', '010000018', '030000003', '1', '060000037', '1','3','080000046'),
('040000038', '2021-01-04 17:03','2021-01-17 20:51', '600', '10', '010000023', '030000003', '1', '060000038', '1','3','080000036'),
('040000039', '2021-01-05 18:19','2021-01-11 06:18', '80', '2', '010000024', '030000013', '1', '060000039', '1','5','080000022'),
('040000040', '2021-01-15 14:13','2021-01-17 04:56', '1200', '10', '010000027', '030000007', '1', '060000040', '1','2','080000046'),
('040000041', '2021-01-16 00:04','2021-01-29 01:16', '200', '2', '010000020', '030000008', '1', '060000041', '1','4','080000007'),
('040000042', '2021-01-23 02:59','2021-02-02 08:47', '600', '10', '010000011', '030000009', '1', '060000042', '1','4','080000036'),
('040000043', '2021-01-30 17:54','2021-02-04 03:12', '660', '11', '010000005', '030000003', '1', '060000043', '1','4','080000036'),
('040000044', '2021-02-11 22:50','2021-02-13 17:13', '480', '8', '010000021', '030000009', '1', '060000044', '1','5','080000013'),
('040000045', '2021-03-09 06:12','2021-03-21 17:10', '720', '12', '010000013', '030000006', '1', '060000045', '1','3','080000001'),
('040000046', '2021-03-19 21:10','2021-03-31 04:13', '800', '10', '010000026', '030000010', '1', '060000046', '1','3','080000006'),
('040000047', '2021-03-23 05:46','2021-03-27 15:05', '50', '1', '010000002', '030000001', '1', '060000047', '1','4','080000036'),
('040000048', '2021-04-20 01:15','2021-05-01 07:48', '320', '4', '010000013', '030000010', '1', '060000048', '1','4','080000018'),
('040000049', '2021-04-21 19:46','2021-05-01 21:04', '360', '9', '010000025', '030000013', '1', '060000049', '1','3','080000022'),
('040000050', '2021-05-06 22:59','2021-05-14 19:22', '360', '9', '010000006', '030000013', '1', '060000050', '1','5','080000063'),
('040000051', '2021-06-06 15:49','2021-06-16 04:35', '500', '10', '010000024', '030000014', '1', '060000051', '1','4','080000046'),
('040000052', '2021-06-10 03:54','2021-06-22 10:41', '490', '14', '010000006', '030000004', '1', '060000052', '1','4','080000036'),
('040000053', '2021-06-15 14:43','2021-06-23 00:05', '540', '12', '010000024', '030000015', '1', '060000053', '1','3','080000018'),
('040000054', '2021-06-20 03:37','2021-07-01 18:36', '1100', '11', '010000002', '030000008', '1', '060000054', '1','5','080000036'),
('040000055', '2021-06-24 05:59','2021-07-02 22:44', '540', '9', '010000018', '030000006', '1', '060000055', '1','4','080000001'),
('040000056', '2021-07-18 20:05','2021-08-01 05:22', '360', '6', '010000028', '030000006', '1', '060000056', '1','5','080000066'),
('040000057', '2021-07-27 23:23','2021-07-31 12:09', '1440', '12', '010000025', '030000007', '1', '060000057', '1','4','080000046'),
('040000058', '2021-07-31 03:03','2021-08-04 02:51', '600', '12', '010000025', '030000014', '1', '060000058', '1','3','080000046'),
('040000059', '2021-08-01 11:19','2021-08-09 16:56', '450', '10', '010000011', '030000005', '1', '060000059', '1','4','080000101'),
('040000060', '2021-09-04 01:59','2021-09-05 14:23', '1440', '12', '010000012', '030000007', '1', '060000060', '1','3','080000036'),
('040000061', '2021-09-23 16:06','2021-10-04 23:16', '490', '14', '010000023', '030000002', '1', '060000061', '1','5','080000066'),
('040000062', '2021-11-14 15:21','2021-11-17 10:32', '300', '3', '010000023', '030000012', '1', '060000062', '1','3','080000036'),
('040000063', '2021-11-16 11:13','2021-11-21 14:15', '400', '8', '010000006', '030000014', '1', '060000063', '1','4','080000036'),
('040000064', '2021-11-23 01:31','2021-11-27 20:31', '225', '5', '010000027', '030000015', '1', '060000064', '1','5','080000018'),
('040000065', '2021-11-25 23:20','2021-11-28 20:01', '350', '10', '010000027', '030000004', '1', '060000065', '1','3','080000046'),
('040000066', '2021-12-25 17:07','2022-01-08 22:54', '400', '8', '010000008', '030000014', '1', '060000066', '1','5','080000036'),
('040000067', '2021-12-28 23:31','2022-01-02 01:32', '320', '4', '010000006', '030000010', '1', '060000067', '1','5','080000006'),
('040000068', '2021-12-31 02:17','2022-01-08 11:21', '840', '7', '010000002', '030000007', '1', '060000068', '1','4','080000036'),
('040000069', '2022-01-22 09:47','2022-01-28 04:57', '270', '6', '010000002', '030000005', '1', '060000069', '1','3','080000101'),
('040000070', '2022-02-08 10:32','2022-02-09 10:10', '495', '11', '010000013', '030000015', '1', '060000070', '1','3','080000018'),
('040000071', '2022-02-16 19:24','2022-02-26 05:21', '720', '6', '010000021', '030000011', '1', '060000071', '1','5','080000013'),
('040000072', '2022-03-03 17:42','2022-03-06 21:18', '320', '8', '010000013', '030000013', '1', '060000072', '1','4','080000022'),
('040000073', '2022-04-07 07:03','2022-04-17 15:08', '135', '3', '010000023', '030000015', '1', '060000073', '1','3','080000006'),
('040000074', '2022-04-07 06:07','2022-04-17 01:41', '240', '2', '010000023', '030000007', '1', '060000074', '1','4','080000036'),
('040000075', '2022-04-13 09:22','2022-04-27 01:24', '840', '7', '010000014', '030000011', '1', '060000075', '1','4','080000036'),
('040000076', '2022-04-15 15:19','2022-04-25 15:55', '105', '3', '010000020', '030000002', '1', '060000076', '1','3','080000017'),
('040000077', '2022-04-21 01:56','2022-04-24 11:11', '700', '14', '010000017', '030000001', '1', '060000077', '1','3','080000046'),
('040000078', '2022-04-22 02:55','2022-05-03 19:42', '600', '12', '010000004', '030000014', '1', '060000078', '1','3','080000046'),
('040000079', '2022-04-27 10:55','2022-04-29 22:46', '650', '13', '010000014', '030000001', '1', '060000079', '1','4','080000036'),
('040000080', '2022-04-28 03:17','2022-04-30 06:09', '500', '10', '010000020', '030000014', '1', '060000080', '1','3','080000007'),
('040000081', '2022-05-02 18:05','2022-05-03 08:04', '900', '9', '010000010', '030000008', '1', '060000081', '1','4','080000046'),
('040000082', '2022-05-02 20:22','2022-05-15 01:52', '650', '13', '010000029', '030000001', '1', '060000082', '1','4','080000031'),
('040000083', '2022-05-21 08:06','2022-05-26 06:13', '450', '10', '010000014', '030000015', '1', '060000083', '1','5','080000006'),
('040000084', '2022-06-07 14:39','2022-06-08 11:03', '1100', '11', '010000005', '030000008', '1', '060000084', '1','3','080000036'),
('040000085', '2022-06-18 12:39','2022-06-25 17:56', '45', '1', '010000021', '030000015', '1', '060000085', '1','5','080000009'),
('040000086', '2022-07-13 22:55','2022-07-24 01:49', '900', '9', '010000027', '030000012', '1', '060000086', '1','3','080000046'),
('040000087', '2022-07-14 09:39','2022-07-20 10:07', '90', '2', '010000025', '030000005', '1', '060000087', '1','3','080000005'),
('040000088', '2022-07-15 23:26','2022-07-27 08:50', '180', '4', '010000008', '030000005', '1', '060000088', '1','5','080000101'),
('040000089', '2022-07-22 13:17','2022-07-28 20:39', '720', '12', '010000009', '030000006', '1', '060000089', '1','5','080000001'),
('040000090', '2022-08-12 06:24','2022-08-17 05:06', '490', '14', '010000030', '030000002', '1', '060000090', '1','5','080000066'),
('040000091', '2022-08-17 10:36','2022-08-19 06:47', '240', '2', '010000021', '030000007', '1', '060000091', '1','4','080000013'),
('040000092', '2022-08-28 01:18','2022-09-05 02:03', '480', '4', '010000023', '030000011', '1', '060000092', '1','5','080000036'),
('040000093', '2022-08-31 08:35','2022-09-01 05:18', '385', '11', '010000004', '030000002', '1', '060000093', '1','4','080000001'),
('040000094', '2022-09-01 03:23','2022-09-06 02:40', '840', '14', '010000001', '030000009', '1', '060000094', '1','5','080000036'),
('040000095', '2022-09-03 03:05','2022-09-09 04:46', '35', '1', '010000002', '030000002', '1', '060000095', '1','5','080000066'),
('040000096', '2022-09-25 23:55','2022-10-06 20:36', '1100', '11', '010000014', '030000012', '1', '060000096', '1','3','080000036'),
('040000097', '2022-10-13 23:16','2022-10-22 09:36', '660', '11', '010000010', '030000003', '1', '060000097', '1','5','080000046'),
('040000098', '2022-11-07 21:45','2022-11-14 22:20', '180', '4', '010000011', '030000015', '1', '060000098', '1','3','080000006'),
('040000099', '2022-11-11 10:12','2022-11-21 23:01', '960', '12', '010000008', '030000010', '1', '060000099', '1','4','080000006'),
('040000100', '2022-11-18 02:06','2022-11-25 21:04', '495', '11', '010000029', '030000015', '1', '060000100', '1','3','080000034')
;

-- Services

INSERT INTO `final project`.`service` (`service_ID`, `service_type`, `price_per_hour`, `service_rating`, `profession_profession_id`) VALUES 
('030000001', 'Check and Clean Heating Systems', '50', '4', '150000003'),
('030000002', 'Test Smoke, Carbon Monoxide Detectors', '35', '4.3', '150000002'),
('030000003', 'Seal Windows and Doors', '60', '4', '150000003'),
('030000004', 'Drain Sprinkler Systems and Outdoor Water Features', '35', '3.5', '150000003'),
('030000005', 'Paint walls', '45', '4', '150000005'),
('030000006', 'Electrical rewiring', '60', '4.2', '150000002'),
('030000007', 'Asbestos removal', '120', '3.6', '150000003'),
('030000008', 'Mold removal', '100', '4.2', '150000003'),
('030000009', 'Major pumbling', '60', '4.6', '150000003'),
('030000010', 'Roofing', '80', '4', '150000004'),
('030000011', 'Pest infestation', '120', '4.5', '150000003'),
('030000012', 'Water damage', '100', '3.5', '150000003'),
('030000013', 'Gardening', '40', '4.3', '150000006'),
('030000014', 'Repair air condition', '50', '3.9', '150000003'),
('030000015', 'Repair furniture', '45', '3.8', '150000004')
;

-- Transaction

INSERT INTO `final project`.`transactions` (`transaction_id`, `date_of_issue`, `amount_in_eur`) VALUES 
(060000001, '2020-01-18', '135.6'),
(060000002, '2020-02-08', '50.85'),
(060000003, '2020-02-21', '791'),
(060000004, '2020-03-10', '711.9'),
(060000005, '2020-02-29', '118.65'),
(060000006, '2020-03-19', '1017'),
(060000007, '2020-04-05', '1762.8'),
(060000008, '2020-04-29', '565'),
(060000009, '2020-04-15', '1469'),
(060000010, '2020-04-30', '457.65'),
(060000011, '2020-05-03', '542.4'),
(060000012, '2020-05-19', '203.4'),
(060000013, '2020-05-18', '994.4'),
(060000014, '2020-05-18', '542.4'),
(060000015, '2020-05-31', '813.6'),
(060000016, '2020-06-17', '39.55'),
(060000017, '2020-06-19', '553.7'),
(060000018, '2020-07-07', '1356'),
(060000019, '2020-07-18', '452'),
(060000020, '2020-08-07', '118.65'),
(060000021, '2020-08-22', '542.4'),
(060000022, '2020-08-18', '508.5'),
(060000023, '2020-08-14', '452'),
(060000024, '2020-08-28', '813.6'),
(060000025, '2020-09-13', '1130'),
(060000026, '2020-09-13', '791'),
(060000027, '2020-09-19', '169.5'),
(060000028, '2020-09-30', '949.2'),
(060000029, '2020-10-10', '1084.8'),
(060000030, '2020-10-14', '553.7'),
(060000031, '2020-10-25', '355.95'),
(060000032, '2020-11-05', '678'),
(060000033, '2020-11-21', '395.5'),
(060000034, '2020-12-03', '276.85'),
(060000035, '2020-12-21', '361.6'),
(060000036, '2020-12-27', '135.6'),
(060000037, '2020-12-29', '949.2'),
(060000038, '2021-01-16', '1491.6'),
(060000039, '2021-01-18', '395.5'),
(060000040, '2021-01-25', '226'),
(060000041, '2021-01-31', '355.95'),
(060000042, '2021-02-12', '1243'),
(060000043, '2021-02-20', '1582'),
(060000044, '2021-03-03', '949.2'),
(060000045, '2021-03-13', '339'),
(060000046, '2021-04-07', '904'),
(060000047, '2021-04-16', '135.6'),
(060000048, '2021-05-16', '1130'),
(060000049, '2021-04-29', '745.8'),
(060000050, '2021-05-20', '610.2'),
(060000051, '2021-06-19', '203.4'),
(060000052, '2021-06-16', '152.55'),
(060000053, '2021-07-12', '203.4'),
(060000054, '2021-07-06', '881.4'),
(060000055, '2021-07-08', '734.5'),
(060000056, '2021-07-29', '678'),
(060000057, '2021-08-17', '339'),
(060000058, '2021-08-10', '1243'),
(060000059, '2021-08-14', '610.2'),
(060000060, '2021-09-29', '791'),
(060000061, '2021-10-08', '452'),
(060000062, '2021-11-26', '39.55'),
(060000063, '2021-12-03', '135.6'),
(060000064, '2021-12-07', '56.5'),
(060000065, '2021-12-12', '271.2'),
(060000066, '2022-01-09', '904'),
(060000067, '2022-01-07', '56.5'),
(060000068, '2022-01-24', '406.8'),
(060000069, '2022-02-03', '711.9'),
(060000070, '2022-02-14', '158.2'),
(060000071, '2022-03-09', '203.4'),
(060000072, '2022-03-19', '226'),
(060000073, '2022-04-09', '67.8'),
(060000074, '2022-04-14', '1356'),
(060000075, '2022-04-27', '271.2'),
(060000076, '2022-04-27', '474.6'),
(060000077, '2022-05-07', '678'),
(060000078, '2022-05-07', '1627.2'),
(060000079, '2022-05-15', '271.2'),
(060000080, '2022-05-02', '406.8'),
(060000081, '2022-05-12', '452'),
(060000082, '2022-05-25', '339'),
(060000083, '2022-06-05', '474.6'),
(060000084, '2022-06-15', '632.8'),
(060000085, '2022-07-04', '226'),
(060000086, '2022-07-18', '90.4'),
(060000087, '2022-08-09', '276.85'),
(060000088, '2022-08-09', '1175.2'),
(060000089, '2022-07-30', '79.1'),
(060000090, '2022-08-22', '316.4'),
(060000091, '2022-09-03', '791'),
(060000092, '2022-09-10', '508.5'),
(060000093, '2022-09-13', '395.5'),
(060000094, '2022-09-14', '203.4'),
(060000095, '2022-09-19', '1220.4'),
(060000096, '2022-10-09', '276.85'),
(060000097, '2022-10-16', '101.7'),
(060000098, '2022-11-28', '271.2'),
(060000099, '2022-11-28', '67.8'),
(060000100, '2022-12-03', '90.4')
;



-- -----------------------------------------------------
-- Triggers and Views ----------------------------------
-- -----------------------------------------------------

-- Views --

#### Creates the view for the invoice head and the totals
CREATE VIEW head_totals as
SELECT  
		# HEAD	
		so.service_order_id AS invoice_id, # Invoice number
		Date(so.date_of_service) AS issue_date, # date of issue
        # billed to:
        concat(cu.title, ' ', cu.first_name, ' ', cu.last_name) as customer_name,
        a.street_name AS street, 
        a.house_nr AS house_nr, 
        a.floor_nr AS floor, 
        a.door AS door, 
        pc.zip_code AS zip_code,
        c.city_name AS city,
		pr.region AS region,
        
        # company address
        '24FIXED' as company_name,
        'Avenida Muito Obrigado' as company_street_name,
        '987123467' as company_phone_nr,
        'support@24fixed.pt' as company_mail_address,
        
        # TOTALS
        so.hours_of_work * s.price_per_hour as subtotal, 
        '13%' as tax_rate,
        round(so.hours_of_work * s.price_per_hour * 0.13, 2) as tax, 
        round(so.hours_of_work * s.price_per_hour * 1.13, 2) as total,
        concat('Please pay invoice by: ', Date_add(date(so.date_of_service), interval 14 DAY)) as payment_terms
        
FROM 	customer AS cu
JOIN 	service_order so on cu.customer_id = so.customer_customer_id
join 	service s on s.service_id = so.service_service_id
JOIN 	address a on cu.address_customer_address_id = a.customer_address_id
JOIN 	postal_code pc on a.postal_code_zip_code = pc.zip_code
JOIN 	postal_region pr on pc.postal_region_region_id = pr.region_id
JOIN 	city c on pc.city_city_id = c.city_id;


#### Creates the view for the invoice details
CREATE VIEW invoice_details as
SELECT 	so.service_order_id as invoice_id,
		s.service_type as description,
        so.hours_of_work as working_hours, 
        s.price_per_hour as price_per_hour, 
        so.hours_of_work * s.price_per_hour as amount
FROM 	service_order AS so 
JOIN 	service AS s on so.service_service_id = s.service_id;




-- Triggers --


DELIMITER $$
create trigger tr1
after update
on service_order
FOR EACH ROW
BEGIN
	update service as s,
	(select count(s.service_id) as totalservices
	from service_order so 
	join service s on s.service_id = so.service_service_id
	group by so.service_service_id ) as selection
set s.service_rating = round(((selection.totalservices * s.service_rating) + NEW.rating) / (selection.totalservices + 1),1)
where s.service_id = NEW.service_service_id;

	update employee as e,
	(select count(e.employee_id) as totalemployees
	from service_order so 
	join employee e on e.employee_id = so.employee_employee_id
	group by so.employee_employee_id ) as selection
set e.employee_rating = round(((selection.totalemployees *  e.employee_rating ) + NEW.rating) / (selection.totalemployees + 1),1)
where e.employee_id = NEW.employee_employee_id;
end$$
DELIMITER ;



#### log table trigger - Create trigger for insert in customer
delimiter $$
CREATE TRIGGER log_table_trigger_insert
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
INSERT INTO log_table (log_message, log_values)
VALUES ('INSERT', concat(NEW.customer_id, ' ', NEW.Last_name));
END $$
delimiter ;

#### log table trigger - Create trigger for delete in customer
delimiter $$
CREATE TRIGGER log_table_trigger_delete
Before DELETE ON customer
FOR EACH ROW
BEGIN
INSERT INTO log_table (log_message, log_values)
VALUES ('DELETE', concat(OLD.customer_id, ' ', OLD.Last_name));
END $$
delimiter ;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
