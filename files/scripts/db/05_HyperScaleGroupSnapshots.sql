/*
 *  $Copyright: Copyright (c) 2017 Veritas Technologies LLC.
 *  All rights reserved.
 */
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


--
-- Database: `HyperScale`
--

-- --------------------------------------------------------

USE `HyperScale`;

--
-- Table structure for table `hyperscale_group_snapshots`
--

CREATE TABLE IF NOT EXISTS `hyperscale_group_snapshots` (
  `id` varchar(36) NOT NULL UNIQUE,
  `group_id` varchar(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `progress` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
