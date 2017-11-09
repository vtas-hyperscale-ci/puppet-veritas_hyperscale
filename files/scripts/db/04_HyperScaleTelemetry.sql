/*
 *  $Copyright: Copyright (c) 2017 Veritas Technologies LLC.
 *  All rights reserved.
 */
SET time_zone = "+00:00";

--
-- Database: `HyperScale`
--

-- --------------------------------------------------------

USE `HyperScale`;

--
-- Table structure for table `hyperscale_feature_track`
--

CREATE TABLE IF NOT EXISTS `hyperscale_feature_track` (
  `feature` varchar(255) NOT NULL,
  `year` int,
  `week` int,
  `cnt` int,
  PRIMARY KEY (`feature`, `year`, `week`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `hyperscale_feature_lastused`
--

CREATE TABLE IF NOT EXISTS `hyperscale_feature_lastused` (
  `feature` varchar(255) NOT NULL,
  `lastused` datetime,
  PRIMARY KEY (`feature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
