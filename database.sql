CREATE TABLE IF NOT EXISTS `player_garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) NOT NULL,
  `garage` int(11) NOT NULL,
  `interior` varchar(50) NOT NULL,
  `interior_index` int(11) NOT NULL,
  `decors` text DEFAULT NULL,
  `vehicles` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `last_updated` (`last_updated`)
);