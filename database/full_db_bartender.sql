-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 12. Jan 2017 um 22:03
-- Server Version: 5.6.20
-- PHP-Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `bartender`
--
CREATE DATABASE IF NOT EXISTS `bartender` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bartender`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cocktails`
--

CREATE TABLE IF NOT EXISTS `cocktails` (
  `name` varchar(150) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `cocktails`
--

INSERT INTO `cocktails` (`name`, `description`) VALUES
('Kotzer', 'der ist eklig!!!!'),
('Mojito', 'Der authentische kubanische Mojito: Das ist Energie und Leidenschaft, die direkt aus Havanna zu dir kommt. Drei Regeln für maximalen Genuss:\r\n\r\nHavana Club Añejo 3 Años, in Kuba hergestellt und gealtert, für authentischen kubanischen Geschmack\r\nFrische und natürliche Minze und Limetten\r\nWeißer Rohrzucker\r\nBereite ihn mit Liebe und Sorgfalt zu, um um eine echte kubanische Erfahrung reicher zu werden!');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ingredients`
--

CREATE TABLE IF NOT EXISTS `ingredients` (
  `cocktail_name` varchar(150) NOT NULL DEFAULT '',
  `spirit_name` varchar(150) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `ingredients`
--

INSERT INTO `ingredients` (`cocktail_name`, `spirit_name`, `quantity`) VALUES
('Kotzer', 'Pfeffi', 5),
('Kotzer', 'Waldi', 3),
('Mojito', 'Weißer Rum', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pumps`
--

CREATE TABLE IF NOT EXISTS `pumps` (
  `name` varchar(10) NOT NULL,
  `pin1` int(11) NOT NULL,
  `pin2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `pumps`
--

INSERT INTO `pumps` (`name`, `pin1`, `pin2`) VALUES
('Crowley', 1, 2),
('Lilith', 3, 4),
('Ruby', 5, 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `spirits`
--

CREATE TABLE IF NOT EXISTS `spirits` (
  `name` varchar(50) NOT NULL,
  `description` text,
  `in_stock` tinyint(1) NOT NULL DEFAULT '0',
  `pump` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `spirits`
--

INSERT INTO `spirits` (`name`, `description`, `in_stock`, `pump`) VALUES
('Pfeffi', 'Leckerer Pfefferminzschnaps.', 1, 'Lilith'),
('Waldi', 'Leckerer Waldmeisterschnaps', 1, 'Crowley'),
('Weißer Rum', 'Lecker', 0, 'Ruby');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cocktails`
--
ALTER TABLE `cocktails`
 ADD PRIMARY KEY (`name`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
 ADD PRIMARY KEY (`cocktail_name`,`spirit_name`), ADD KEY `spirits___fk` (`spirit_name`);

--
-- Indexes for table `pumps`
--
ALTER TABLE `pumps`
 ADD PRIMARY KEY (`name`);

--
-- Indexes for table `spirits`
--
ALTER TABLE `spirits`
 ADD PRIMARY KEY (`name`), ADD KEY `spirits_pumps_name_fk` (`pump`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `ingredients`
--
ALTER TABLE `ingredients`
ADD CONSTRAINT `cocktails___fk` FOREIGN KEY (`cocktail_name`) REFERENCES `cocktails` (`name`),
ADD CONSTRAINT `spirits___fk` FOREIGN KEY (`spirit_name`) REFERENCES `spirits` (`name`);

--
-- Constraints der Tabelle `spirits`
--
ALTER TABLE `spirits`
ADD CONSTRAINT `spirits_pumps_name_fk` FOREIGN KEY (`pump`) REFERENCES `pumps` (`name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
