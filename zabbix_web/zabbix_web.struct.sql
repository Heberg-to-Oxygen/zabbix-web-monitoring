/*
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/29/2023
# Modification Date : 08/08/2023
###########################
*/

/* Create a zabbix_web table */
CREATE DATABASE IF NOT EXISTS `zabbix_web`;

USE `zabbix_web`;


/* Create a server table */
DROP TABLE IF EXISTS `server`;

CREATE TABLE `server` (
  `server_id` varchar(64) NOT NULL,
  `server_name` varchar(255) NOT NULL,
  `server_support` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`server_id`),
  UNIQUE KEY `server_name` (`server_name`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


/* Create a web table */
DROP TABLE IF EXISTS `web`;

CREATE TABLE `web` (
  `web_id` int(11) NOT NULL AUTO_INCREMENT,
  `web_domain` varchar(255) NOT NULL,
  `web_url` varchar(255) NOT NULL,
  `web_php_version` varchar(16) DEFAULT NULL,
  `web_env` varchar(16) NOT NULL,
  `web_support` varchar(40) NOT NULL,
  `web_status` BOOLEAN DEFAULT 1,
  `web_server` varchar(64) NOT NULL,
  `web_created` datetime NOT NULL,
  `web_update` datetime DEFAULT NULL,
  PRIMARY KEY (`web_id`),
  UNIQUE KEY `web_domain` (`web_domain`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
