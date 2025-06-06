-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: waf_rules
-- ------------------------------------------------------
-- Server version	5.5.68-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admin_Users`
--

DROP TABLE IF EXISTS `Admin_Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin_Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `userPwd` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin_Users`
--

LOCK TABLES `Admin_Users` WRITE;
/*!40000 ALTER TABLE `Admin_Users` DISABLE KEYS */;
INSERT INTO `Admin_Users` VALUES (1,'admin','123.com');
/*!40000 ALTER TABLE `Admin_Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Black_List`
--

DROP TABLE IF EXISTS `Black_List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Black_List` (
  `attackIp` varchar(255) NOT NULL,
  `attackNum` int(18) DEFAULT NULL,
  `isBanned` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`attackIp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Black_List`
--

LOCK TABLES `Black_List` WRITE;
/*!40000 ALTER TABLE `Black_List` DISABLE KEYS */;
/*!40000 ALTER TABLE `Black_List` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_Logs`
--

DROP TABLE IF EXISTS `File_Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_Logs` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `date` varchar(255) DEFAULT NULL,
  `source_ip` varchar(255) DEFAULT NULL,
  `target_url` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_Logs`
--

LOCK TABLES `File_Logs` WRITE;
/*!40000 ALTER TABLE `File_Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `File_Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_Sensitive`
--

DROP TABLE IF EXISTS `File_Sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_Sensitive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_Sensitive`
--

LOCK TABLES `File_Sensitive` WRITE;
/*!40000 ALTER TABLE `File_Sensitive` DISABLE KEYS */;
INSERT INTO `File_Sensitive` VALUES (1,'=.*\\.{2}/'),(2,'.*php://filter.*'),(3,'.*php://input.*'),(4,'.*zip://.*'),(5,'.*file://.*'),(6,'.*compress.bzip2://.*'),(7,'.*compress.zlib://.*'),(8,'.*data://.*'),(9,'=\\s*\\.{2}\\\\'),(10,'=\\s*[a-z]:/'),(11,'.*url:file://.*'),(12,'.*phar://.*'),(13,'.*http://.*'),(14,'.*https://.*'),(15,'.*expect://.*'),(16,'.*rar://.*');
/*!40000 ALTER TABLE `File_Sensitive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SQL_Logs`
--

DROP TABLE IF EXISTS `SQL_Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SQL_Logs` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `date` varchar(255) DEFAULT NULL,
  `source_ip` varchar(255) DEFAULT NULL,
  `target_url` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SQL_Logs`
--

LOCK TABLES `SQL_Logs` WRITE;
/*!40000 ALTER TABLE `SQL_Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `SQL_Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SQL_Sensitive`
--

DROP TABLE IF EXISTS `SQL_Sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SQL_Sensitive` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SQL_Sensitive`
--

LOCK TABLES `SQL_Sensitive` WRITE;
/*!40000 ALTER TABLE `SQL_Sensitive` DISABLE KEYS */;
INSERT INTO `SQL_Sensitive` VALUES (1,'\\bsleep\\s*\\( *(\\d+) *\\)'),(2,'\\blength\\s*\\(.*\\)'),(3,'\\bdatabase\\s*\\(.*\\)'),(4,'\\bcount\\s*\\(.*\\)'),(5,'\\bvalue\\s*\\(.*\\)'),(6,'\\bupdatexml\\s*\\(.*\\)'),(7,'\\bconcat\\s*\\(.*\\)'),(8,'\\bif\\s*\\(.*\\)'),(9,'\\bversion\\s*\\(.*\\)'),(10,'\\bload_file\\s*\\(.*\\)'),(11,'\\butl_inaddr.get_host_address\\s*\\(.*\\)'),(12,'union\\s+select'),(13,'select.*from'),(14,'\\butl_file_fopen\\s*\\(.*\\)'),(15,'\\butl_file.get_line\\s*\\(.*\\)'),(16,'\\bdbms_output.put_line\\s*\\(.*\\)'),(17,'\\butl_file.fclose\\s*\\(.*\\)'),(18,'dbms_lock\\.sleep\\s*\\(.*\\)'),(19,'\\bfrom_base64\\s*\\(.*\\)'),(20,'into\\s+dumpfile'),(21,'\\bbenchmark\\s*\\(.*\\)');
/*!40000 ALTER TABLE `SQL_Sensitive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Traffic_Statistics`
--

DROP TABLE IF EXISTS `Traffic_Statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Traffic_Statistics` (
  `normal` int(255) DEFAULT NULL,
  `malice` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Traffic_Statistics`
--

LOCK TABLES `Traffic_Statistics` WRITE;
/*!40000 ALTER TABLE `Traffic_Statistics` DISABLE KEYS */;
INSERT INTO `Traffic_Statistics` VALUES (0,0);
/*!40000 ALTER TABLE `Traffic_Statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `XSS_Logs`
--

DROP TABLE IF EXISTS `XSS_Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XSS_Logs` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `date` varchar(255) DEFAULT NULL,
  `source_ip` varchar(255) DEFAULT NULL,
  `target_url` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XSS_Logs`
--

LOCK TABLES `XSS_Logs` WRITE;
/*!40000 ALTER TABLE `XSS_Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `XSS_Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `XSS_Sensitive`
--

DROP TABLE IF EXISTS `XSS_Sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XSS_Sensitive` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XSS_Sensitive`
--

LOCK TABLES `XSS_Sensitive` WRITE;
/*!40000 ALTER TABLE `XSS_Sensitive` DISABLE KEYS */;
INSERT INTO `XSS_Sensitive` VALUES (1,'\\<script.*\\>'),(2,'\\<img.*\\>'),(3,'\\bfunction\\s*\\(.*\\)'),(4,'\\<link.*\\>'),(5,'\\<svg.*\\>'),(6,'\\<p.*\\>'),(7,'\\balert\\s*\\(.*\\)'),(8,'\\<a.*\\>'),(9,'\\<style.*\\>'),(10,'\\<video.*\\>'),(11,'\\<source.*\\>'),(12,'this\\s*\\[.*\\]\\s*\\(.*\\)'),(13,'globalThis\\s*\\[.*\\]\\s*\\(.*\\)'),(14,'framess*\\[.*\\]\\s*\\(.*\\)'),(15,'parent\\s*\\[.*\\]\\s*\\(.*\\)'),(16,'top\\s*\\[.*\\]\\s*\\(.*\\)'),(17,'self\\s*\\[.*\\]\\s*\\(.*\\)'),(18,'window\\s*\\[.*\\]\\s*\\(.*\\)'),(19,'\\<meta.*\\>'),(20,'\\<object.*data.*\\=.*\\>'),(21,'.*\\&Tab\\;.*');
/*!40000 ALTER TABLE `XSS_Sensitive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `XXE_Logs`
--

DROP TABLE IF EXISTS `XXE_Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XXE_Logs` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `date` varchar(255) DEFAULT NULL,
  `source_ip` varchar(255) DEFAULT NULL,
  `target_url` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XXE_Logs`
--

LOCK TABLES `XXE_Logs` WRITE;
/*!40000 ALTER TABLE `XXE_Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `XXE_Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `XXE_Sensitive`
--

DROP TABLE IF EXISTS `XXE_Sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XXE_Sensitive` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XXE_Sensitive`
--

LOCK TABLES `XXE_Sensitive` WRITE;
/*!40000 ALTER TABLE `XXE_Sensitive` DISABLE KEYS */;
INSERT INTO `XXE_Sensitive` VALUES (1,'.*<\\?xml\\s*version=.*\\?>.*'),(2,'.*<\\!ENTITY\\s*\\%.*>.*'),(3,'.*<\\!DOCTYPE.*>.*'),(4,'.*<foo.*>.*'),(5,'.*<\\s*soap:Body\\s*>.*'),(6,'.*<\\s*svg.*>.*');
/*!40000 ALTER TABLE `XXE_Sensitive` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-30 10:13:37
