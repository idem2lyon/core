-- MySQL Script generated by MySQL Workbench
-- 12/29/14 09:06:10
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema jeedom
-- -----------------------------------------------------

ALTER DATABASE CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `object` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `father_id` INT(11) NULL DEFAULT NULL,
  `isVisible` TINYINT(1) NULL,
  `position` INT NULL,
  `configuration` TEXT NULL,
  `display` TEXT NULL,
  `image` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_object_object1_idx1` (`father_id` ASC),
  INDEX `position` (`position` ASC),
  CONSTRAINT `fk_object_object1`
    FOREIGN KEY (`father_id`)
    REFERENCES `object` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eqReal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eqReal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logicalId` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NOT NULL,
  `configuration` TEXT NULL,
  `cat` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `logicalId` (`logicalId` ASC),
  INDEX `type` (`type` ASC),
  INDEX `logicalId_Type` (`logicalId` ASC, `type` ASC),
  INDEX `name` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eqLogic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eqLogic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NOT NULL,
  `logicalId` VARCHAR(127) NULL,
  `object_id` INT NULL,
  `eqType_name` VARCHAR(127) NOT NULL,
  `specificCapatibilities` MEDIUMTEXT NULL,
  `configuration` TEXT NULL,
  `isVisible` TINYINT(1) NULL,
  `eqReal_id` INT NULL,
  `isEnable` TINYINT(1) NULL,
  `status` TEXT NULL,
  `timeout` INT NULL,
  `category` TEXT NULL DEFAULT NULL,
  `display` TEXT NULL,
  `order` INT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique` (`name` ASC, `object_id` ASC),
  INDEX `eqTypeName` (`eqType_name` ASC),
  INDEX `name` (`name` ASC),
  INDEX `logical_id` (`logicalId` ASC),
  INDEX `logica_id_eqTypeName` (`logicalId` ASC, `eqType_name` ASC),
  INDEX `object_id` (`object_id` ASC),
  INDEX `timeout` (`timeout` ASC),
  INDEX `eqReal_id` (`eqReal_id` ASC),
  CONSTRAINT `fk_eqLogic_jeenode1`
    FOREIGN KEY (`eqReal_id`)
    REFERENCES `eqReal` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_eqLogic_object1`
    FOREIGN KEY (`object_id`)
    REFERENCES `object` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cmd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cmd` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `eqLogic_id` INT NOT NULL,
  `eqType` VARCHAR(127) NULL,
  `logicalId` VARCHAR(127) NULL,
  `order` INT NULL,
  `name` VARCHAR(45) NULL,
  `configuration` TEXT BINARY NULL,
  `template` TEXT NULL,
  `isHistorized` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `subType` VARCHAR(45) NULL,
  `cache` TEXT NULL DEFAULT NULL,
  `unite` VARCHAR(45) NULL,
  `eventOnly` TINYINT(1) NULL DEFAULT 0,
  `display` TEXT NULL,
  `isVisible` INT NULL DEFAULT 1,
  `value` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique` (`eqLogic_id` ASC, `name` ASC),
  INDEX `isHistorized` (`isHistorized` ASC),
  INDEX `type` (`type` ASC),
  INDEX `eventOnly` (`eventOnly` ASC),
  INDEX `name` (`name` ASC),
  INDEX `subtype` (`subType` ASC),
  INDEX `eqLogic_id` (`eqLogic_id` ASC),
  INDEX `value` (`value` ASC),
  INDEX `order` (`order` ASC),
  INDEX `logicalID` (`logicalId` ASC),
  INDEX `logicalId_eqLogicID` (`eqLogic_id` ASC, `logicalId` ASC),
  INDEX `type_eventOnly` (`type` ASC, `eventOnly` ASC),
  CONSTRAINT `fk_cmd_eqLogic1`
    FOREIGN KEY (`eqLogic_id`)
    REFERENCES `eqLogic` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NULL,
  `password` VARCHAR(255) NULL,
  `options` TEXT NULL,
  `hash` VARCHAR(255) NULL,
  `rights` TEXT NULL,
  `enable` INT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `config` (
  `plugin` VARCHAR(127) NOT NULL DEFAULT 'core',
  `key` VARCHAR(255) NOT NULL,
  `value` VARCHAR(255) NULL,
  PRIMARY KEY (`key`, `plugin`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rights` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `entity` VARCHAR(127) NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  `right` INT(11) NULL DEFAULT NULL,
  `options` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rights_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `entityUser` (`entity` ASC, `user_id` ASC),
  CONSTRAINT `fk_rights_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `scenario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scenario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NULL,
  `group` VARCHAR(127) NULL,
  `state` VARCHAR(127) NULL,
  `isActive` TINYINT(1) NULL DEFAULT 1,
  `lastLaunch` DATETIME NULL DEFAULT NULL,
  `mode` VARCHAR(127) NULL,
  `schedule` TEXT NULL DEFAULT NULL,
  `pid` INT NULL,
  `scenarioElement` TEXT NULL,
  `trigger` VARCHAR(255) NULL DEFAULT NULL,
  `timeout` INT(11) NULL DEFAULT NULL,
  `isVisible` TINYINT(1) NULL DEFAULT '1',
  `object_id` INT(11) NULL DEFAULT NULL,
  `display` TEXT NULL,
  `description` TEXT NULL,
  `configuration` TEXT NULL,
  `type` VARCHAR(127) NULL DEFAULT 'expert',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`group` ASC, `object_id` ASC, `name` ASC),
  INDEX `group` (`group` ASC),
  INDEX `fk_scenario_object1_idx` (`object_id` ASC),
  INDEX `trigger` (`trigger` ASC),
  INDEX `mode` (`mode` ASC),
  INDEX `modeTriger` (`mode` ASC, `trigger` ASC),
  CONSTRAINT `fk_scenario_object1`
    FOREIGN KEY (`object_id`)
    REFERENCES `object` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `history` (
  `cmd_id` INT NOT NULL,
  `datetime` DATETIME NOT NULL,
  `value` FLOAT NULL,
  INDEX `fk_history5min_commands1_idx` (`cmd_id` ASC),
  UNIQUE INDEX `unique` (`datetime` ASC, `cmd_id` ASC),
  CONSTRAINT `fk_history_cmd1`
    FOREIGN KEY (`cmd_id`)
    REFERENCES `cmd` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historyArch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historyArch` (
  `cmd_id` INT NOT NULL,
  `datetime` DATETIME NOT NULL,
  `value` FLOAT NULL,
  INDEX `cmd_id_index` (`cmd_id` ASC),
  UNIQUE INDEX `unique` (`cmd_id` ASC, `datetime` ASC),
  CONSTRAINT `fk_historyArch_cmd1`
    FOREIGN KEY (`cmd_id`)
    REFERENCES `cmd` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `logicalId` VARCHAR(127) NULL,
  `plugin` VARCHAR(127) NOT NULL,
  `message` TEXT NULL,
  `action` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `plugin_logicalID` (`plugin` ASC, `logicalId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cron`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cron` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `priority` INT NULL,
  `server` VARCHAR(127) NULL,
  `pid` INT NULL,
  `enable` INT NULL,
  `class` VARCHAR(127) NULL,
  `function` VARCHAR(127) NOT NULL,
  `lastrun` DATETIME NULL,
  `duration` VARCHAR(127) NULL,
  `state` VARCHAR(127) NULL,
  `schedule` VARCHAR(127) NULL DEFAULT NULL,
  `timeout` INT NULL,
  `deamon` INT NULL DEFAULT 0,
  `deamonSleepTime` INT NULL,
  `option` VARCHAR(255) NULL DEFAULT NULL,
  `once` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `class_function` (`class` ASC, `function` ASC, `option` ASC),
  INDEX `type` (`class` ASC),
  INDEX `logicalId_Type` (`class` ASC),
  INDEX `deamon` (`deamon` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `view` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
COMMENT = '<double-click to overwrite multiple objects>';


-- -----------------------------------------------------
-- Table `viewZone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viewZone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `view_id` INT NOT NULL,
  `type` VARCHAR(127) NULL,
  `name` VARCHAR(127) NULL,
  `position` INT NULL,
  `configuration` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_zone_view1` (`view_id` ASC),
  CONSTRAINT `fk_zone_view1`
    FOREIGN KEY (`view_id`)
    REFERENCES `view` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '<double-click to overwrite multiple objects>';


-- -----------------------------------------------------
-- Table `viewData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viewData` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order` INT NULL,
  `viewZone_id` INT NOT NULL,
  `type` VARCHAR(127) NULL,
  `link_id` INT NOT NULL,
  `configuration` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_data_zone1_idx` (`viewZone_id` ASC),
  UNIQUE INDEX `unique` (`viewZone_id` ASC, `link_id` ASC, `type` ASC),
  INDEX `order` (`order` ASC, `viewZone_id` ASC),
  CONSTRAINT `fk_data_zone1`
    FOREIGN KEY (`viewZone_id`)
    REFERENCES `viewZone` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '<double-click to overwrite multiple objects>';


-- -----------------------------------------------------
-- Table `dataStore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataStore` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(127) NOT NULL,
  `link_id` INT NOT NULL,
  `key` VARCHAR(127) NOT NULL,
  `value` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UNIQUE` (`type` ASC, `link_id` ASC, `key` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interactDef`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interactDef` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `enable` INT NULL DEFAULT 1,
  `query` TEXT NULL,
  `reply` TEXT NULL,
  `link_type` VARCHAR(127) NULL,
  `link_id` VARCHAR(255) NULL,
  `person` VARCHAR(255) NULL,
  `options` TEXT NULL,
  `filtres` TEXT NULL,
  `position` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interactQuery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interactQuery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `interactDef_id` INT NOT NULL,
  `enable` INT NULL DEFAULT 1,
  `query` TEXT NULL,
  `link_type` VARCHAR(127) NULL,
  `link_id` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sarahQuery_sarahDef1_idx` (`interactDef_id` ASC),
  FULLTEXT INDEX `query` (`query` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `calendar_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar_event` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `eqLogic_id` INT(11) NOT NULL,
  `cmd_param` TEXT NULL DEFAULT NULL,
  `value` VARCHAR(127) NULL DEFAULT NULL,
  `startDate` DATETIME NULL DEFAULT NULL,
  `endDate` DATETIME NULL DEFAULT NULL,
  `until` DATETIME NULL DEFAULT NULL,
  `repeat` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `scenarioElement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scenarioElement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order` INT NOT NULL,
  `type` VARCHAR(127) NULL,
  `name` VARCHAR(127) NULL,
  `options` TEXT NULL,
  `log` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scenarioSubElement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scenarioSubElement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order` INT NULL,
  `scenarioElement_id` INT NOT NULL,
  `type` VARCHAR(127) NULL,
  `subtype` VARCHAR(127) NULL,
  `name` VARCHAR(127) NULL,
  `options` TEXT NULL,
  `log` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_scenarioSubElement_scenarioElement1_idx` (`scenarioElement_id` ASC),
  INDEX `type` (`scenarioElement_id` ASC, `type` ASC),
  CONSTRAINT `fk_scenarioSubElement_scenarioElement1`
    FOREIGN KEY (`scenarioElement_id`)
    REFERENCES `scenarioElement` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scenarioExpression`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scenarioExpression` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order` INT NULL,
  `scenarioSubElement_id` INT NOT NULL,
  `type` VARCHAR(127) NULL,
  `subtype` VARCHAR(127) NULL,
  `expression` TEXT NULL,
  `options` TEXT NULL,
  `log` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_scenarioExpression_scenarioSubElement1_idx` (`scenarioSubElement_id` ASC),
  CONSTRAINT `fk_scenarioExpression_scenarioSubElement1`
    FOREIGN KEY (`scenarioSubElement_id`)
    REFERENCES `scenarioSubElement` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cache`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cache` (
  `key` VARCHAR(127) NOT NULL,
  `datetime` DATETIME NULL,
  `lifetime` VARCHAR(127) NOT NULL,
  `value` MEDIUMTEXT NULL,
  `options` MEDIUMTEXT NULL,
  PRIMARY KEY (`key`),
  INDEX `lifetime` (`lifetime` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `update`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `update` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(127) NULL,
  `name` VARCHAR(127) NULL,
  `logicalId` VARCHAR(127) NULL DEFAULT NULL,
  `localVersion` VARCHAR(127) NULL DEFAULT NULL,
  `remoteVersion` VARCHAR(127) NULL DEFAULT NULL,
  `status` VARCHAR(127) NULL,
  `configuration` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `status` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(127) NULL,
  `failure` INT NULL,
  `localisation` VARCHAR(511) NULL,
  `datetime` DATETIME NULL,
  `username` VARCHAR(127) NULL,
  `status` VARCHAR(127) NULL,
  `options` VARCHAR(2048) NULL,
  `informations` VARCHAR(2048) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ip_UNIQUE` (`ip` ASC),
  INDEX `datetime` (`datetime` ASC),
  INDEX `status_datetime` (`status` ASC, `datetime` ASC))
ENGINE = MEMORY;


-- -----------------------------------------------------
-- Table `listener`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `listener` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `class` VARCHAR(127) NULL,
  `function` VARCHAR(127) NULL,
  `event` VARCHAR(255) NULL,
  `option` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `event` (`event` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planHeader` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NULL,
  `image` MEDIUMTEXT NULL,
  `configuration` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `planHeader_id` INT NOT NULL,
  `link_type` VARCHAR(127) NULL,
  `link_id` INT NULL,
  `position` TEXT NULL,
  `display` TEXT NULL,
  `css` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `unique` (`link_type` ASC, `link_id` ASC),
  INDEX `fk_plan_planHeader1_idx` (`planHeader_id` ASC),
  CONSTRAINT `fk_plan_planHeader1`
    FOREIGN KEY (`planHeader_id`)
    REFERENCES `planHeader` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jeeNetwork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jeeNetwork` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(127) NULL,
  `apikey` VARCHAR(255) NULL,
  `plugin` TEXT NULL,
  `configuration` TEXT NULL,
  `name` VARCHAR(127) NULL,
  `status` VARCHAR(127) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ip_UNIQUE` (`ip` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
