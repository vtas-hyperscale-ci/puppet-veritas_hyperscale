/*
 *  $Copyright: Copyright (c) 2017 Veritas Technologies LLC.
 *  All rights reserved.
 * 
 *  THIS SOFTWARE CONTAINS CONFIDENTIAL INFORMATION AND TRADE SECRETS OF
 *  VERITAS TECHNOLOGIES LLC.  USE, DISCLOSURE OR REPRODUCTION IS PROHIBITED
 *  WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF VERITAS TECHNOLOGIES LLC.
 * 
 *  The  Licensed  Software  and  Documentation  are  deemed  to be commercial
 *  computer  software  as  defined  in  FAR  12.212 and subject to restricted
 *  rights  as  defined in FAR Section 52.227-19 "Commercial Computer Software
 *  - Restricted  Rights"  and  DFARS 227.7202,  et seq.  "Commercial Computer
 *  Software  and  Commercial Computer Software Documentation," as applicable,
 *  and any successor regulations, whether delivered by Veritas as on premises
 *  or  hosted  services.  Any  use,  modification,  reproduction  release,
 *  performance,  display  or  disclosure  of  the  Licensed  Software  and
 *  Documentation by the U.S. Government shall be solely in accordance with
 *  the terms of this Agreement. IV49-6268-1575-44-15-5 $
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
