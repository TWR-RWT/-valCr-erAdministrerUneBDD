-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: digitalCampusLive
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `digitalCampusLive`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `digitalCampusLive` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `digitalCampusLive`;

--
-- Table structure for table `Cinema`
--

DROP TABLE IF EXISTS `Cinema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cinema` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `tel` tinytext NOT NULL,
  `address` tinytext NOT NULL,
  `email` varchar(50) NOT NULL,
  `idCompany` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_id` (`idCompany`),
  CONSTRAINT `fk_company_id` FOREIGN KEY (`idCompany`) REFERENCES `Company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cinema`
--

LOCK TABLES `Cinema` WRITE;
/*!40000 ALTER TABLE `Cinema` DISABLE KEYS */;
INSERT INTO `Cinema` VALUES (1,'Le Grand Cinema','0215478475','3 rue de l’hermitage Paris','gaumontparis@contacte.fr',1),(2,'Gaumont du grand ouest','0235598922','35 boulevard Anne de bretagne Nantes','gaumontnantes@contacte.fr',1),(3,'Le Gaumont du soleil','0213515426','13 rue de la pétanque Marseille','gaumontmarseille@contacte.fr',1);
/*!40000 ALTER TABLE `Cinema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Company` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Company`
--

LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` VALUES (1,'Gaumont','gaumont@contact.fr'),(2,'Pathé','cinemapathe@communication.fr');
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Film`
--

DROP TABLE IF EXISTS `Film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Film` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `ageMin` smallint NOT NULL,
  `dateDebutDiff` date NOT NULL,
  `dateFinDiff` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Film`
--

LOCK TABLES `Film` WRITE;
/*!40000 ALTER TABLE `Film` DISABLE KEYS */;
INSERT INTO `Film` VALUES (1,'KILL BILL',16,'2021-12-01','2021-12-31'),(2,'AVATAR',12,'2021-12-01','2021-12-31'),(3,'LE ROI LION',0,'2021-12-01','2021-12-31'),(4,'VERY BAD TRIP',12,'2021-12-01','2021-12-31');
/*!40000 ALTER TABLE `Film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salle`
--

DROP TABLE IF EXISTS `Salle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Salle` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `capacité` smallint NOT NULL,
  `idCinema` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`capacité`,`idCinema`),
  KEY `fk_cinema_id` (`idCinema`),
  CONSTRAINT `fk_cinema_id` FOREIGN KEY (`idCinema`) REFERENCES `Cinema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salle`
--

LOCK TABLES `Salle` WRITE;
/*!40000 ALTER TABLE `Salle` DISABLE KEYS */;
INSERT INTO `Salle` VALUES (1,'La grande salle',550,1),(2,'La petite salle',200,1),(3,'La salle parisienne',450,1),(4,'La rigolette',450,2),(5,'Les machines de l’ile',425,2),(6,'Le Velodrome',550,3),(7,'L’apero',375,3),(8,'Le vieux port',425,3);
/*!40000 ALTER TABLE `Salle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Seance`
--

DROP TABLE IF EXISTS `Seance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Seance` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `horaires` datetime NOT NULL,
  `idfilm` smallint unsigned NOT NULL,
  `filmName` varchar(40) NOT NULL,
  `idsalle` smallint unsigned NOT NULL,
  `idcinema` smallint unsigned NOT NULL,
  `nbPlaces` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`filmName`,`horaires`),
  KEY `fk_salle_to_seance` (`idsalle`,`nbPlaces`,`idcinema`),
  KEY `fk_film_to_seance` (`idfilm`,`filmName`),
  CONSTRAINT `fk_film_to_seance` FOREIGN KEY (`idfilm`, `filmName`) REFERENCES `Film` (`id`, `name`),
  CONSTRAINT `fk_salle_to_seance` FOREIGN KEY (`idsalle`, `nbPlaces`, `idcinema`) REFERENCES `Salle` (`id`, `capacité`, `idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seance`
--

LOCK TABLES `Seance` WRITE;
/*!40000 ALTER TABLE `Seance` DISABLE KEYS */;
INSERT INTO `Seance` VALUES (13,'2021-12-05 18:00:00',1,'KILL BILL',1,1,550),(14,'2021-12-05 17:30:00',2,'AVATAR',2,1,200),(15,'2021-12-06 14:00:00',3,'LE ROI LION',3,1,450),(16,'2021-12-06 16:00:00',4,'VERY BAD TRIP',2,1,200),(17,'2021-12-05 20:00:00',1,'KILL BILL',5,2,425),(18,'2021-12-05 21:00:00',2,'AVATAR',4,2,450),(19,'2021-12-06 15:30:00',3,'LE ROI LION',4,2,450),(20,'2021-12-06 18:00:00',4,'VERY BAD TRIP',5,2,425),(21,'2021-12-05 14:30:00',1,'KILL BILL',6,3,550),(22,'2021-12-05 17:45:00',2,'AVATAR',7,3,375),(23,'2021-12-06 12:30:00',3,'LE ROI LION',8,3,425),(24,'2021-12-06 13:30:00',4,'VERY BAD TRIP',6,3,550);
/*!40000 ALTER TABLE `Seance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tarif`
--

DROP TABLE IF EXISTS `Tarif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tarif` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `critere` varchar(50) NOT NULL,
  `montant` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`montant`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tarif`
--

LOCK TABLES `Tarif` WRITE;
/*!40000 ALTER TABLE `Tarif` DISABLE KEYS */;
INSERT INTO `Tarif` VALUES (4,'Plein tarif',9.2),(5,'Etudiant',7.6),(6,'Moins de 14 ans',5.9);
/*!40000 ALTER TABLE `Tarif` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ticket` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `idTarif` smallint unsigned NOT NULL,
  `price` float NOT NULL,
  `idSeance` smallint unsigned NOT NULL,
  `filmSeance` varchar(40) NOT NULL,
  `horaireSeance` datetime NOT NULL,
  `idUser` smallint unsigned NOT NULL,
  `nameUser` varchar(40) NOT NULL,
  `dateNaissanceUser` date NOT NULL,
  `etudiantUser` char(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seance_to_ticket` (`idSeance`,`filmSeance`,`horaireSeance`),
  KEY `fk_user_to_ticket` (`idUser`,`nameUser`,`dateNaissanceUser`,`etudiantUser`),
  KEY `fk_tarif_to_ticket` (`idTarif`,`price`),
  CONSTRAINT `fk_seance_to_ticket` FOREIGN KEY (`idSeance`, `filmSeance`, `horaireSeance`) REFERENCES `Seance` (`id`, `filmName`, `horaires`),
  CONSTRAINT `fk_tarif_to_ticket` FOREIGN KEY (`idTarif`, `price`) REFERENCES `Tarif` (`id`, `montant`),
  CONSTRAINT `fk_user_to_ticket` FOREIGN KEY (`idUser`, `nameUser`, `dateNaissanceUser`, `etudiantUser`) REFERENCES `User` (`id`, `name`, `dateNaissance`, `etudiant`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ticket`
--

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
INSERT INTO `Ticket` VALUES (1,4,9.2,13,'KILL BILL','2021-12-05 18:00:00',1,'Paul','1982-03-15',NULL),(2,5,7.6,17,'KILL BILL','2021-12-05 20:00:00',2,'Jeanne','2003-08-21','1'),(3,4,9.2,13,'KILL BILL','2021-12-05 18:00:00',3,'Administrateur','1980-05-01',NULL),(4,6,5.9,23,'LE ROI LION','2021-12-06 12:30:00',4,'Jonathan','2010-07-05',NULL),(5,4,9.2,14,'AVATAR','2021-12-05 17:30:00',5,'AdministrateurParis','1984-01-02',NULL),(6,4,9.2,20,'VERY BAD TRIP','2021-12-06 18:00:00',6,'AdministrateurNantes','1989-11-22',NULL),(7,4,9.2,22,'AVATAR','2021-12-05 17:45:00',7,'AdministrateurMarseille','1990-10-10',NULL);
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `password` char(40) NOT NULL,
  `dateNaissance` date NOT NULL,
  `etudiant` char(5) DEFAULT NULL,
  `role` tinyint DEFAULT NULL,
  `complexe` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`name`,`dateNaissance`,`etudiant`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Paul','password','1982-03-15',NULL,NULL,NULL),(2,'Jeanne','Jeannette45','2003-08-21','1',NULL,NULL),(3,'Administrateur','ThisIsMySecretPassword2021','1980-05-01',NULL,1,NULL),(4,'Jonathan','FortniteProGamer','2010-07-05',NULL,NULL,NULL),(5,'AdministrateurParis','ThisIsParisSecretPassword2021','1984-01-02',NULL,2,1),(6,'AdministrateurNantes','FarWestPassword2021','1989-11-22',NULL,2,2),(7,'AdministrateurMarseille','ViveLOMPassword2021','1990-10-10',NULL,2,3);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-14 22:05:09
