CREATE TABLE IF NOT EXISTS `killingstreak` (  	
  `entry` int(11) NOT NULL AUTO_INCREMENT,  	
  `areaId` int(11) NOT NULL DEFAULT '0',  	
  `numberOfKill` int(11) NOT NULL DEFAULT '0',  	
  `ItemEntryWin` int(11) NOT NULL DEFAULT '0',  	
  `quantity` tinyint(4) NOT NULL DEFAULT '0',  	
  `ArenaPointWin` tinyint(4) NOT NULL DEFAULT '0',  	
  `HonorPointWin` tinyint(4) NOT NULL DEFAULT '0',  	
  `notificationType` tinyint(4) NOT NULL DEFAULT '1',  	
  `notification` longtext NOT NULL DEFAULT '',  	
  PRIMARY KEY (`entry`)  	
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;