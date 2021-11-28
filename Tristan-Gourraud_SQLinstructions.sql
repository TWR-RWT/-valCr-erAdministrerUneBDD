-- Tristan Gourraud
-- Evaluation d`entrainement: créer et administrer une base de données

--connexion à mysql:
--mysql -u [UserName] -p		

--voir les bdd existantes:
--SHOW DATABASES;		

CREATE DATABASE `digitalCampusLive` CHARACTER SET `utf8`; 	--creation de la bdd digitalCampusLive

USE `digitalCampusLive`;		--connexion à la bdd digitalCampusLive


--creation de la table User
CREATE TABLE IF NOT EXISTS `User` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,
	`password` CHAR(40) NOT NULL,	            --CHAR(40) pour un hash SHA-1		
	`dateNaissance` DATE NOT NULL,
	`etudiant` CHAR(5),
	`role` TINYINT,
    `complexe` smallint unsigned,
	INDEX(`id`, `name`, `dateNaissance`, `etudiant`),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 					

--Voir les tables existantes
--SHOW TABLES;		

--Voir la configuration de la table User
--DESCRIBE User;

--creation de la table Company
CREATE TABLE IF NOT EXISTS `Company` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--creation de la table Cinema avec Clé étrangère sur Company
CREATE TABLE IF NOT EXISTS `Cinema` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,
	`tel` TINYTEXT NOT NULL,
	`address` TINYTEXT NOT NULL,
	`email` VARCHAR(50) NOT NULL,
	`idCompany` SMALLINT UNSIGNED NOT NULL,		
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_company_id` FOREIGN KEY (`idCompany`) REFERENCES `Company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;				 

--creation de la table Salle avec Clé étrangère sur Cinema
CREATE TABLE IF NOT EXISTS `Salle` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,
	`capacité` SMALLINT NOT NULL,
	`idCinema` SMALLINT UNSIGNED NOT NULL,		
	PRIMARY KEY (`id`),
	INDEX(`id`, `capacité`, `idCinema`),
	CONSTRAINT `fk_cinema_id` FOREIGN KEY (`idCinema`) REFERENCES `Cinema` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;					

--creation de la table Film
CREATE TABLE IF NOT EXISTS `Film` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,
	`ageMin` SMALLINT NOT NULL,
	`dateDebutDiff` DATE NOT NULL,
	`dateFinDiff` DATE NOT NULL,
	INDEX(`id`, `name`),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--creation de la table Tarif
CREATE TABLE IF NOT EXISTS `Tarif` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`critere` VARCHAR(50) NOT NULL,
	`montant` FLOAT NOT NULL,
	INDEX( `id`, `montant`),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--creation de la table Seance
CREATE TABLE IF NOT EXISTS `Seance` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`horaires` DATETIME NOT NULL,
	`idfilm` SMALLINT UNSIGNED NOT NULL,
	`filmName` VARCHAR(40) NOT NULL,
	`idsalle` SMALLINT UNSIGNED NOT NULL,
	`idcinema` SMALLINT UNSIGNED NOT NULL,
	`nbPlaces` SMALLINT NOT NULL,
	PRIMARY KEY (`id`),
	INDEX( `id`, `filmName`, `horaires`),
	CONSTRAINT `fk_salle_to_seance` FOREIGN KEY (`idsalle`, `nbPlaces`, `idcinema`) REFERENCES `Salle` (`id`, `capacité`, `idCinema`),
	CONSTRAINT `fk_film_to_seance` FOREIGN KEY (`idfilm`, `filmName`) REFERENCES `Film` (`id`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--creation de la table Ticket
CREATE TABLE IF NOT EXISTS `Ticket` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`idTarif` SMALLINT UNSIGNED NOT NULL,
	`price` FLOAT NOT NULL,
	`idSeance` SMALLINT UNSIGNED NOT NULL,
	`filmSeance` VARCHAR(40) NOT NULL,
	`horaireSeance` DATETIME NOT NULL,
	`idUser` SMALLINT UNSIGNED NOT NULL,
	`nameUser` VARCHAR(40) NOT NULL,
	`dateNaissanceUser` DATE NOT NULL,
	`etudiantUser` CHAR(5),
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_seance_to_ticket` FOREIGN KEY (`idSeance`, `filmSeance`, `horaireSeance`) REFERENCES `Seance`(`id`, `filmName`, `horaires`),
	CONSTRAINT `fk_tarif_to_ticket` FOREIGN KEY (`idTarif`, `price`) REFERENCES `Tarif` (`id`, `montant`),
	CONSTRAINT `fk_user_to_ticket` FOREIGN KEY (`idUser`, `nameUser`, `dateNaissanceUser`, `etudiantUser`) REFERENCES `User` (`id`, `name`, `dateNaissance`, `etudiant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--remplissage des tables

INSERT INTO `User` ( `name`, `password`, `dateNaissance`) VALUES (`Paul`, `password`, `1982-03-15`);
INSERT INTO `User` ( `name`, `password`, `dateNaissance`, `etudiant`) VALUES (`Jeanne`, `Jeannette45`, `2003-08-21`, True);
INSERT INTO `User` ( `name`, `password`, `dateNaissance`, `role`) VALUES (`Administrateur`, `ThisIsMySecretPassword2021`, `1980-05-01`, 1);
INSERT INTO `User` (`name`, `password`, `dateNaissance`) VALUES (`Jonathan`, `FortniteProGamer`, `2010-07-05`);
INSERT INTO `User` ( `name`, `password`, `dateNaissance`, `role`, `complexe`) VALUES (`AdministrateurParis`, `ThisIsParisSecretPassword2021`, `1984-01-02`, 2, 1),
(`AdministrateurNantes`, `FarWestPassword2021`, `1989-11-22`, 2, 2),
(`AdministrateurMarseille`, `ViveLOMPassword2021`, `1990-10-10`, 2, 3);

INSERT INTO `Tarif` (`critere`, `montant`) VALUES (`Plein tarif`, 9.2);
INSERT INTO `Tarif` (`critere`, `montant`) VALUES (`Etudiant`, 7.6);
INSERT INTO `Tarif` (`critere`, `montant`) VALUES (`Moins de 14 ans`, 5.9);

INSERT INTO `Film` (`name`, `ageMin`, `dateDebutDiff`, `dateFinDiff`) VALUES (`KILL BILL`, 16, `2021-12-01`, `2021-12-31`);
INSERT INTO `Film` (`name`, `ageMin`, `dateDebutDiff`, `dateFinDiff`) VALUES (`AVATAR`, 12, `2021-12-01`, `2021-12-31`);
INSERT INTO `Film` (`name`, `ageMin`, `dateDebutDiff`, `dateFinDiff`) VALUES (`LE ROI LION`, 0, `2021-12-01`, `2021-12-31`);
INSERT INTO `Film` (`name`, `ageMin`, `dateDebutDiff`, `dateFinDiff`) VALUES (`VERY BAD TRIP`, 12, `2021-12-01`, `2021-12-31`);

INSERT INTO `Company` (`name`, `email`) VALUES (`Gaumont`, `gaumont@contact.fr`), (`Pathé`, `cinemapathe@communication.fr`);

INSERT INTO `Cinema` (`name`, `tel`, `address`, `email`, `idCompany`) VALUES (`Le Grand Cinema`, `0215478475`, `3 rue de l’hermitage Paris`, `gaumontparis@contacte.fr`, 1), (`Gaumont du grand ouest`, `0235598922`, `35 boulevard Anne de bretagne Nantes`, `gaumontnantes@contacte.fr`, 1), (`Le Gaumont du soleil`, `0213515426`, `13 rue de la pétanque Marseille`, `gaumontmarseille@contacte.fr`, 1);

INSERT INTO `Salle` (`name`, `capacité`, `idCinema`) VALUES (`La grande salle`, 550, 1), (`La petite salle`, 200, 1), (`La salle parisienne`, 450, 1), (`La rigolette`, 450, 2), (`Les machines de l’ile`, 425, 2), (`Le Velodrome`, 550, 3), (`L’apero`, 375, 3), (`Le vieux port`, 425, 3);

INSERT INTO `Seance` (`horaires`, `idfilm`, `filmName`, `idsalle`, `idcinema`, `nbPlaces`) VALUES (`2021-12-05 18:00:00`, 1, `KILL BILL`, 1, 1, 550), (`2021-12-05 17:30:00`, 2, `AVATAR`, 2, 1, 200), (`2021-12-06 14:00:00`, 3, `LE ROI LION`, 3, 1, 450), (`2021-12-06 16:00:00`, 4, `VERY BAD TRIP`, 2, 1, 200), (`2021-12-05 20:00:00`, 1, `KILL BILL`, 5, 2, 425), (`2021-12-05 21:00:00`, 2, `AVATAR`, 4, 2, 450), (`2021-12-06 15:30:00`, 3, `LE ROI LION`, 4, 2, 450), (`2021-12-06 18:00:00`, 4, `VERY BAD TRIP`, 5, 2, 425), (`2021-12-05 14:30:00`, 1, `KILL BILL`, 6, 3, 550), (`2021-12-05 17:45:00`, 2, `AVATAR`, 7, 3, 375), (`2021-12-06 12:30:00`, 3, `LE ROI LION`, 8, 3, 425), (`2021-12-06 13:30:00`, 4, `VERY BAD TRIP`, 6, 3, 550);

INSERT INTO `Ticket` (`idTarif`, `price`, `idSeance`, `filmSeance`, `horaireSeance`, `idUser`, `nameUser`, `dateNaissanceUser`, `etudiantUser`) VALUES (4, 9.2, 13, `KILL BILL`, `2021-12-05 18:00:00`, 1, `Paul`, `1982-03-15`, NULL), (5, 7.6, 17, `KILL BILL`, `2021-12-05 20:00:00`, 2, `Jeanne`, `2003-08-21`, True), (4, 9.2, 13, `KILL BILL`, `2021-12-05 18:00:00`, 3, `Administrateur`, `1980-05-01`, NULL), (6, 5.9, 23, `LE ROI LION`, `2021-12-06 12:30:00`, 4, `Jonathan`, `2010-07-05`, NULL);
INSERT INTO `Ticket` (`idTarif`, `price`, `idSeance`, `filmSeance`, `horaireSeance`, `idUser`, `nameUser`, `dateNaissanceUser`, `etudiantUser`) VALUES (4, 9.2, 14, `AVATAR`, `2021-12-05 17:30:00`, 5, `AdministrateurParis`, `1984-01-02`, NULL), (4, 9.2, 20, `VERY BAD TRIP`, `2021-12-06 18:00:00`, 6, `AdministrateurNantes`, `1989-11-22`, NULL), (4, 9.2, 22, `AVATAR`, `2021-12-05 17:45:00`, 7, `AdministrateurMarseille`, `1990-10-10`, NULL);

--Pour faire une sauvegarde de la base
--En ligne de commandes
/*sudo mysqldump --databases --result-file=digitalCampusLive_Save.sql digitalCampusLive -u [UserName] -p; */

--Dans Mysql
/*SOURCE digitalCampusLive_Save.sql; */