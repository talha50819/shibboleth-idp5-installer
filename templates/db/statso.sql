-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: statso
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.3

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
-- Table structure for table `idpdetails`
--

DROP TABLE IF EXISTS `idpdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idpdetails` (
  `id` bigint NOT NULL,
  `idpname` varchar(80) NOT NULL,
  `entityid` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idpdetails`
--
LOCK TABLES `idpdetails` WRITE;
/*!40000 ALTER TABLE `idpdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `idpdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spdetails`
--

DROP TABLE IF EXISTS `spdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spdetails` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `spname` varchar(80) NOT NULL,
  `entityid` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spdetails`
--

LOCK TABLES `spdetails` WRITE;
/*!40000 ALTER TABLE `spdetails` DISABLE KEYS */;
INSERT INTO `spdetails` VALUES (1,'ACS Publications','https://pubs.acs.org/shibboleth'),(2,'Annual Reviews','https://www.annualreviews.org/shibboleth'),(3,'Association for Computing Machinery','https://dl.acm.org/shibboleth'),(4,'Association for Computing Machinery - Development','https://dldev.acm.org/shibboleth'),(5,'Cambridge Journals Online','https://shibboleth.cambridge.org/shibboleth-sp'),(6,'Emerald Insight','https://www.emeraldinsight.com/shibboleth'),(7,'HighWire Press','https://shibboleth2sp.tf.semcs.net/shibboleth'),(8,'IEEE - XploreUAT SP - Test','https://xploreuat.ieee.org/shibboleth-sp'),(9,'IEEE XploreDigital Library','https://ieeexplore.ieee.org/shibboleth-sp'),(10,'INFLIBNET SP','https://infonet.inflibnet.ac.in/shibboleth'),(11,'Wiley Online Library','https://sp.onlinelibrary.wiley.com/shibboleth'),(12,'Palgrave Connect','https://secure.palgraveconnect.com/shibboleth'),(13,'Nature Publishing Group','https://secure.nature.com/shibboleth'),(14,'Nature Publishing Group (platformdev)','https://platformdev-secure.nature.com/shibboleth'),(15,'Nature Publishing Group (staging)','https://staging-secure.nature.com/shibboleth'),(16,'Nature Publishing Group (test)','https://test-secure.nature.com/shibboleth'),(17,'Palgrave Journals (platformdev)','https://platformdev-secure.palgrave-journals.com/shibboleth'),(18,'Palgrave Macmillan- Stagging','https://staging-secure.palgraveconnect.com/shibboleth'),(19,'Palgrave Connect Test','https://test-secure.palgraveconnect.com/shibboleth'),(20,'Royal Society of Chemistry','https://shibdev.rsc.org/shibboleth'),(21,'Springer Nature','https://fsso.springer.com'),(22,'Taylor & Francis Online','https://www.tandfonline.com/shibboleth'),(23,'Thomson Reuters','https://sp.tshhosting.com/shibboleth'),(24,'JSTOR','https://shibboleth2sp.jstor.org/shibboleth'),(25,'Institute Of Physics','https://ticket.iop.org/shibboleth'),(26,'ebsco','http://shibboleth.ebscohost.com');
/*!40000 ALTER TABLE `spdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stateinfo`
--

DROP TABLE IF EXISTS `stateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stateinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(65) NOT NULL,
  `state` varchar(65) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stateinfo`
--

LOCK TABLES `stateinfo` WRITE;
/*!40000 ALTER TABLE `stateinfo` DISABLE KEYS */;
INSERT INTO `stateinfo` VALUES (1,'IN-AN','Andaman and Nicobar Islands'),(2,'IN-AP','Andhra Pradesh'),(3,'IN-AR','Arunachal Pradesh'),(4,'IN-AS','Assam'),(5,'IN-BR','Bihar'),(6,'IN-CH','Chandigarh'),(7,'IN-CT','Chhattisgarh'),(8,'IN-DD','Daman and Diu'),(9,'IN-DL','Delhi'),(10,'IN-DN','Dadra and Nagar Haveli'),(11,'IN-GA','Goa'),(12,'IN-GJ','Gujarat'),(13,'IN-HP','Himachal Pradesh'),(14,'IN-HR','Haryana'),(15,'IN-JH','Jharkhand'),(16,'IN-JK','Jammu and Kashmir'),(17,'IN-KA','Karnataka'),(18,'IN-KL','Kerala'),(19,'IN-LD','Lakshadweep'),(20,'IN-MH','Maharashtra'),(21,'IN-ML','Meghalaya'),(22,'IN-MN','Manipur'),(23,'IN-MP','Madhya Pradesh'),(24,'IN-MZ','Mizoram'),(25,'IN-NL','Nagaland'),(26,'IN-OR','Odisha'),(27,'IN-PB','Punjab'),(28,'IN-PY','Puducherry'),(29,'IN-RJ','Rajasthan'),(30,'IN-SK','Sikkim'),(31,'IN-TG','Telangana'),(32,'IN-TN','Tamil Nadu'),(33,'IN-TR','Tripura'),(34,'IN-UP','Uttar Pradesh'),(35,'IN-UT','Uttarakhand'),(36,'IN-WB','West Bengal');
/*!40000 ALTER TABLE `stateinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `logins` bigint NOT NULL,
  `rps` bigint NOT NULL,
  `uids` bigint NOT NULL,
  `ltime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,1,1,1,'2018-01-24 10:31:58'),(2,3,1,1,'2018-01-24 03:48:50');
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(65) NOT NULL,
  `username` varchar(65) NOT NULL,
  `email` varchar(65) NOT NULL,
  `designation` varchar(65) NOT NULL,
  `role` varchar(65) NOT NULL,
  `password` varchar(65) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'','admin','','','Admin','e6e061838856bf47e1de730719fb2609');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstats`
--

DROP TABLE IF EXISTS `userstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` varchar(250) NOT NULL,
  `log_date` varchar(50) NOT NULL,
  `user` varchar(80) NOT NULL,
  `sp` varchar(80) NOT NULL,
  `ip_address` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=580 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstats`
--

LOCK TABLES `userstats` WRITE;
/*!40000 ALTER TABLE `userstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `userstats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-02 11:05:40

