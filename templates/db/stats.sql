

DROP TABLE IF EXISTS `univspdetails`;

CREATE TABLE `univspdetails` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spname` varchar(200) NOT NULL,
  `entityid` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(65) NOT NULL,
  `username` varchar(65) NOT NULL,
  `email` varchar(65) NOT NULL,
  `designation` varchar(65) NOT NULL,
  `role` varchar(65) NOT NULL,
  `password` varchar(65) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


INSERT INTO `users` VALUES (1,'','admin','','','Admin','e6e061838856bf47e1de730719fb2609');

DROP TABLE IF EXISTS `userstats`;

CREATE TABLE `userstats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(250) NOT NULL,
  `log_date` varchar(50) NOT NULL,
  `user` varchar(80) NOT NULL,
  `sp` varchar(400) NOT NULL,
  `ip_address` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5220 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `wayfless`;

CREATE TABLE `wayfless` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `link` varchar(5000) DEFAULT NULL,
  `category` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

