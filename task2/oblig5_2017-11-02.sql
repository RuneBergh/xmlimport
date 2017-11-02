# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.5.5-10.1.26-MariaDB)
# Database: oblig5
# Generation Time: 2017-11-02 14:09:11 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table club
# ------------------------------------------------------------

CREATE TABLE `club` (
  `ID` varchar(60) CHARACTER SET latin1 NOT NULL,
  `city` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `xname` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `city` (`city`),
  CONSTRAINT `club_ibfk_1` FOREIGN KEY (`city`) REFERENCES `location` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table location
# ------------------------------------------------------------

CREATE TABLE `location` (
  `city` varchar(60) CHARACTER SET latin1 NOT NULL,
  `county` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table log
# ------------------------------------------------------------

CREATE TABLE `log` (
  `skierusername` varchar(60) CHARACTER SET latin1 NOT NULL,
  `seasonyear` int(11) NOT NULL,
  `totaldistance` int(11) DEFAULT NULL,
  PRIMARY KEY (`skierusername`,`seasonyear`),
  KEY `seasonyear` (`seasonyear`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`skierusername`) REFERENCES `skier` (`username`),
  CONSTRAINT `log_ibfk_2` FOREIGN KEY (`seasonyear`) REFERENCES `season` (`fallyear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table logentry
# ------------------------------------------------------------

CREATE TABLE `logentry` (
  `seasonyear` int(11) DEFAULT NULL,
  `skierusername` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `logdate` date DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `area` char(60) CHARACTER SET latin1 DEFAULT NULL,
  `entryID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`entryID`),
  KEY `skierusername` (`skierusername`,`seasonyear`),
  CONSTRAINT `logentry_ibfk_1` FOREIGN KEY (`skierusername`, `seasonyear`) REFERENCES `log` (`skierusername`, `seasonyear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table season
# ------------------------------------------------------------

CREATE TABLE `season` (
  `fallyear` int(11) NOT NULL,
  PRIMARY KEY (`fallyear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table seasonskiers
# ------------------------------------------------------------

CREATE TABLE `seasonskiers` (
  `clubid` varchar(60) CHARACTER SET latin1 DEFAULT NULL,
  `skierusername` varchar(60) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `seasonyear` int(11) NOT NULL,
  PRIMARY KEY (`skierusername`,`seasonyear`),
  KEY `clubid` (`clubid`),
  KEY `seasonyear` (`seasonyear`),
  CONSTRAINT `seasonskiers_ibfk_2` FOREIGN KEY (`clubid`) REFERENCES `club` (`ID`),
  CONSTRAINT `seasonskiers_ibfk_3` FOREIGN KEY (`skierusername`) REFERENCES `skier` (`username`),
  CONSTRAINT `seasonskiers_ibfk_4` FOREIGN KEY (`seasonyear`) REFERENCES `season` (`fallyear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table skier
# ------------------------------------------------------------

CREATE TABLE `skier` (
  `username` varchar(60) CHARACTER SET latin1 NOT NULL,
  `firstname` char(60) CHARACTER SET latin1 DEFAULT NULL,
  `lastname` char(60) CHARACTER SET latin1 DEFAULT NULL,
  `yearofbirth` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
