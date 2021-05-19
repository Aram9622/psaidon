-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 18, 2021 at 02:57 PM
-- Server version: 5.7.31
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `imath`
--

-- --------------------------------------------------------

--
-- Table structure for table `imas_assessments`
--

DROP TABLE IF EXISTS `imas_assessments`;
CREATE TABLE IF NOT EXISTS `imas_assessments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(254) NOT NULL,
  `summary` text NOT NULL,
  `intro` mediumtext NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `enddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `reviewdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `timelimit` int(10) NOT NULL DEFAULT '0',
  `displaymethod` varchar(20) NOT NULL,
  `defpoints` smallint(4) UNSIGNED NOT NULL DEFAULT '10',
  `defattempts` smallint(4) UNSIGNED NOT NULL DEFAULT '1',
  `deffeedback` varchar(20) NOT NULL,
  `defpenalty` varchar(6) NOT NULL DEFAULT '0',
  `deffeedbacktext` varchar(512) NOT NULL DEFAULT '',
  `itemorder` text NOT NULL,
  `shuffle` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `gbcategory` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `password` varchar(254) NOT NULL,
  `cntingb` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `minscore` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `showcat` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `showhints` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `showtips` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `isgroup` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `groupsetid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `reqscoreaid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `reqscore` smallint(4) NOT NULL DEFAULT '0',
  `reqscoretype` tinyint(1) NOT NULL DEFAULT '0',
  `noprint` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `groupmax` tinyint(1) UNSIGNED NOT NULL DEFAULT '6',
  `allowlate` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `eqnhelper` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `exceptionpenalty` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `posttoforum` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `msgtoinstr` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `istutorial` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `defoutcome` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ltisecret` varchar(10) NOT NULL,
  `endmsg` text NOT NULL,
  `viddata` text NOT NULL,
  `caltag` varchar(254) NOT NULL DEFAULT '?',
  `calrtag` varchar(254) NOT NULL DEFAULT 'R',
  `tutoredit` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `ancestors` text NOT NULL,
  `ptsposs` smallint(1) NOT NULL DEFAULT '-1',
  `date_by_lti` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `LPcutoff` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `extrefs` text NOT NULL,
  `submitby` enum('by_question','by_assessment') NOT NULL DEFAULT 'by_question',
  `keepscore` enum('last','best','average') NOT NULL DEFAULT 'best',
  `showscores` enum('during','at_end','total','none') NOT NULL DEFAULT 'during',
  `showans` enum('never','after_lastattempt','jump_to_answer','after_take','with_score','after_1','after_2','after_3','after_4','after_5','after_6','after_7','after_8','after_9') NOT NULL DEFAULT 'after_take',
  `viewingb` enum('immediately','after_take','after_due','never') NOT NULL DEFAULT 'after_take',
  `scoresingb` enum('immediately','after_take','after_due','never') NOT NULL DEFAULT 'immediately',
  `ansingb` enum('after_take','after_due','never') NOT NULL DEFAULT 'after_due',
  `scorebypart` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `defregens` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `defregenpenalty` varchar(6) NOT NULL DEFAULT '0',
  `overtime_grace` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `overtime_penalty` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ver` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `showwork` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `autoexcuse` text,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`),
  KEY `cntingb` (`cntingb`),
  KEY `reviewdate` (`reviewdate`),
  KEY `avail` (`avail`),
  KEY `ancestors` (`ancestors`(10)),
  KEY `gbcategory` (`gbcategory`),
  KEY `groupsetid` (`groupsetid`),
  KEY `date_by_lti` (`date_by_lti`),
  KEY `submitby` (`submitby`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Assessment info' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_assessments`
--

INSERT INTO `imas_assessments` (`id`, `courseid`, `name`, `summary`, `intro`, `startdate`, `enddate`, `reviewdate`, `timelimit`, `displaymethod`, `defpoints`, `defattempts`, `deffeedback`, `defpenalty`, `deffeedbacktext`, `itemorder`, `shuffle`, `gbcategory`, `password`, `cntingb`, `minscore`, `showcat`, `showhints`, `showtips`, `isgroup`, `groupsetid`, `reqscoreaid`, `reqscore`, `reqscoretype`, `noprint`, `avail`, `groupmax`, `allowlate`, `eqnhelper`, `exceptionpenalty`, `posttoforum`, `msgtoinstr`, `istutorial`, `defoutcome`, `ltisecret`, `endmsg`, `viddata`, `caltag`, `calrtag`, `tutoredit`, `ancestors`, `ptsposs`, `date_by_lti`, `LPcutoff`, `extrefs`, `submitby`, `keepscore`, `showscores`, `showans`, `viewingb`, `scoresingb`, `ansingb`, `scorebypart`, `defregens`, `defregenpenalty`, `overtime_grace`, `overtime_penalty`, `ver`, `showwork`, `autoexcuse`) VALUES
(1, 1, 'design1', '<p>asdasdasdasdasd</p>', '<p>asdasdasdsa</p>', 1619589600, 1620194400, 0, 0, 'full', 10, 3, '', '0', '', '', 0, 0, '', 1, 0, 0, 3, 2, 0, 0, 0, 0, 0, 0, 1, 6, 11, 2, 0, 0, 0, 0, 0, '', '', '', '?', 'R', 0, '', 0, 0, 0, '[]', 'by_question', 'best', 'during', 'after_lastattempt', 'immediately', 'immediately', 'after_due', 1, 20, '0', 0, 0, 2, 0, NULL),
(2, 3, 'w', '<p>hjvjh</p>', '<p>,jhgj,hvgj</p>', 1619589600, 1620194400, 0, 0, 'skip', 10, 3, '', '0', '', '', 0, 0, '', 1, 0, 0, 3, 2, 0, 0, 0, 0, 0, 0, 1, 6, 11, 2, 0, 0, 0, 0, 0, '', '', '', '?', 'R', 0, '', 0, 0, 0, '[]', 'by_question', 'best', 'during', 'after_lastattempt', 'immediately', 'immediately', 'after_due', 1, 20, '0', 0, 0, 2, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `imas_assessment_records`
--

DROP TABLE IF EXISTS `imas_assessment_records`;
CREATE TABLE IF NOT EXISTS `imas_assessment_records` (
  `assessmentid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  `agroupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lti_sourcedid` text NOT NULL,
  `ver` tinyint(1) UNSIGNED NOT NULL DEFAULT '2',
  `timeontask` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `starttime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastchange` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `score` decimal(9,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `timelimitexp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `scoreddata` mediumblob NOT NULL,
  `practicedata` mediumblob NOT NULL,
  PRIMARY KEY (`assessmentid`,`userid`),
  KEY `userid` (`userid`),
  KEY `agroupid` (`agroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_assessment_records`
--

INSERT INTO `imas_assessment_records` (`assessmentid`, `userid`, `agroupid`, `lti_sourcedid`, `ver`, `timeontask`, `starttime`, `lastchange`, `score`, `status`, `timelimitexp`, `scoreddata`, `practicedata`) VALUES
(1, 3, 0, '', 2, 0, 1619608434, 0, '0.00', 2, 0, 0x1f8b080000000000000a6d4fcb0a833010fc973de760a886d65f29a5a4bad4800fcc6cf420fe7ba3514aa1b7d961667666218457e70037f4a0f2fe5064830cb0131f27aac173fd9cd86f1a2ab3a8001838a94db710c47a11d73195dae89bc9aef92557d45a48d5d8fecdbb33aa2420c12d77476360c83728f17d685b45decec7adff3639adbf5d4657a717cc111485318ac4bbb4688d9b66274d1db363885e23b37e0072b2db3f07010000, '');

-- --------------------------------------------------------

--
-- Table structure for table `imas_assessment_sessions`
--

DROP TABLE IF EXISTS `imas_assessment_sessions`;
CREATE TABLE IF NOT EXISTS `imas_assessment_sessions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `assessmentid` int(10) UNSIGNED NOT NULL,
  `agroupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lti_sourcedid` text NOT NULL,
  `questions` text NOT NULL,
  `seeds` text NOT NULL,
  `scores` text NOT NULL,
  `attempts` text NOT NULL,
  `lastanswers` mediumtext NOT NULL,
  `reattempting` varchar(255) NOT NULL,
  `starttime` int(10) NOT NULL,
  `endtime` int(10) NOT NULL,
  `timeontask` text NOT NULL,
  `bestseeds` text NOT NULL,
  `bestscores` text NOT NULL,
  `bestattempts` text NOT NULL,
  `bestlastanswers` mediumtext NOT NULL,
  `reviewseeds` text NOT NULL,
  `reviewscores` text NOT NULL,
  `reviewattempts` text NOT NULL,
  `reviewlastanswers` mediumtext NOT NULL,
  `reviewreattempting` varchar(255) NOT NULL,
  `feedback` text NOT NULL,
  `ver` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_2` (`userid`,`assessmentid`),
  KEY `userid` (`userid`),
  KEY `assessmentid` (`assessmentid`),
  KEY `agroupid` (`agroupid`),
  KEY `endtime` (`endtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Assessment Sessions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_badgerecords`
--

DROP TABLE IF EXISTS `imas_badgerecords`;
CREATE TABLE IF NOT EXISTS `imas_badgerecords` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `badgeid` int(10) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `badgeid` (`badgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_badgesettings`
--

DROP TABLE IF EXISTS `imas_badgesettings`;
CREATE TABLE IF NOT EXISTS `imas_badgesettings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `badgetext` varchar(254) NOT NULL,
  `description` varchar(128) NOT NULL,
  `longdescription` text NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `requirements` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_bookmarks`
--

DROP TABLE IF EXISTS `imas_bookmarks`;
CREATE TABLE IF NOT EXISTS `imas_bookmarks` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `userid` (`userid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_calitems`
--

DROP TABLE IF EXISTS `imas_calitems`;
CREATE TABLE IF NOT EXISTS `imas_calitems` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `date` int(10) UNSIGNED NOT NULL,
  `title` varchar(254) NOT NULL,
  `tag` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Calendar Items' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_content_track`
--

DROP TABLE IF EXISTS `imas_content_track`;
CREATE TABLE IF NOT EXISTS `imas_content_track` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `type` varchar(254) NOT NULL,
  `typeid` int(10) UNSIGNED NOT NULL,
  `viewtime` int(10) UNSIGNED NOT NULL,
  `info` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `userid` (`userid`),
  KEY `typeid` (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_content_track`
--

INSERT INTO `imas_content_track` (`id`, `userid`, `courseid`, `type`, `typeid`, `viewtime`, `info`) VALUES
(1, 3, 1, 'assess', 1, 1619608434, ''),
(2, 3, 1, 'assess', 1, 1619613109, '');

-- --------------------------------------------------------

--
-- Table structure for table `imas_courses`
--

DROP TABLE IF EXISTS `imas_courses`;
CREATE TABLE IF NOT EXISTS `imas_courses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ownerid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(254) NOT NULL,
  `enrollkey` varchar(100) NOT NULL,
  `itemorder` mediumtext NOT NULL,
  `allowunenroll` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `copyrights` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `blockcnt` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `msgset` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `toolset` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `showlatepass` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `lockaid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `theme` varchar(32) NOT NULL DEFAULT 'default.css',
  `latepasshrs` smallint(4) UNSIGNED NOT NULL DEFAULT '24',
  `newflag` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `istemplate` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deflatepass` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `deftime` int(10) UNSIGNED NOT NULL DEFAULT '600',
  `termsurl` varchar(254) NOT NULL DEFAULT '',
  `outcomes` text NOT NULL,
  `ancestors` text NOT NULL,
  `ltisecret` varchar(10) NOT NULL,
  `jsondata` mediumtext NOT NULL,
  `dates_by_lti` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `startdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `enddate` int(10) UNSIGNED NOT NULL DEFAULT '2000000000',
  `cleanupdate` int(10) NOT NULL DEFAULT '0',
  `UIver` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `level` varchar(254) NOT NULL DEFAULT '',
  `ltisendzeros` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  KEY `name` (`name`),
  KEY `available` (`available`),
  KEY `istemplate` (`istemplate`),
  KEY `enddate` (`enddate`),
  KEY `cleanupdate` (`cleanupdate`),
  KEY `startdate` (`startdate`),
  KEY `ltisendzeros` (`ltisendzeros`),
  KEY `UIver` (`UIver`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Course list' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_courses`
--

INSERT INTO `imas_courses` (`id`, `ownerid`, `name`, `enrollkey`, `itemorder`, `allowunenroll`, `copyrights`, `blockcnt`, `msgset`, `toolset`, `showlatepass`, `available`, `lockaid`, `theme`, `latepasshrs`, `newflag`, `istemplate`, `deflatepass`, `deftime`, `termsurl`, `outcomes`, `ancestors`, `ltisecret`, `jsondata`, `dates_by_lti`, `startdate`, `enddate`, `cleanupdate`, `UIver`, `level`, `ltisendzeros`) VALUES
(1, 1, 'Css', 'css', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 0, 0, 1, 0, 4, 0, 0, 0, 'modern.css', 24, 0, 0, 0, 106000600, '', '', '', 'b8Nxrby4', '', 0, 0, 2000000000, 0, 2, '', 0),
(2, 1, 'design', 'design1', 'a:0:{}', 0, 0, 1, 0, 4, 0, 0, 0, 'modern.css', 24, 0, 0, 0, 106000600, '', '', '', 'u3rADbvD', '', 0, 0, 2000000000, 0, 2, '', 0),
(3, 1, 'fizkult', 'fizkult', 'a:1:{i:0;s:1:\"3\";}', 0, 0, 1, 0, 4, 0, 0, 0, 'modern.css', 24, 0, 0, 0, 106000600, '', '', '', '2qCpfJvu', '', 0, 0, 2000000000, 0, 2, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `imas_dbschema`
--

DROP TABLE IF EXISTS `imas_dbschema`;
CREATE TABLE IF NOT EXISTS `imas_dbschema` (
  `id` int(10) UNSIGNED NOT NULL,
  `ver` int(10) UNSIGNED NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_dbschema`
--

INSERT INTO `imas_dbschema` (`id`, `ver`, `details`) VALUES
(1, 156, ''),
(2, 0, ''),
(157, 1619519125, '157_expand_namefields.php'),
(158, 1619519126, '158_expand_assesspw.php'),
(159, 1619519126, '159_add_excused.php'),
(160, 1619519126, '160_add_forum_autoscore.php'),
(161, 1619519126, '161_add_indices_7.php'),
(162, 1619519126, '162_add_mfa.php'),
(20190225, 1619519126, '20190225_add_assess2_columns.php'),
(20190226, 1619519126, '20190226_add_assess2_columns2.php'),
(20190301, 1619519126, '20190301_add_assess_records.php'),
(20190422, 1619519126, '20190422_add_assess2_columns4.php'),
(20190724, 1619519126, '20190724_add_courselevel.php'),
(20190830, 1619519126, '20190830_fix_question_tries.php'),
(20190922, 1619519126, '20190922_fix_assess2_settings.php'),
(20200124, 1619519126, '20200124_add_linked_files.php'),
(20200128, 1619519126, '20200128_add_email_index.php'),
(20200316, 1619519127, '20200316_add_assess_showwork.php'),
(20200401, 1619519127, '20200401_avgscore_fields.php'),
(20200411, 1619519127, '20200411_better_msgs_index.php'),
(20200414, 1619519127, '20200414_descrip_fulltext_index.php'),
(20200416, 1619519127, '20200416_refactor_msg_isread.php'),
(20200417, 1619519127, '20200417_delete_old_isread.php'),
(20200516, 1619519127, '20200516_add_teacher_audit_log.php'),
(20200527, 1619519127, '20200527_extend_teacher_audit_log.php'),
(20200530, 1619519128, '20200530_add_ipeds.php'),
(20200610, 1619519128, '20200610_add_email_throttle.php'),
(20200623, 1619519128, '20200623_add_lti13_tables.php'),
(20200630, 1619519128, '20200630_add_lti13_tables2.php'),
(20200724, 1619519128, '20200724_extend_teacher_audit_log2.php'),
(20200803, 1619519128, '20200803_add_lti13_columns.php'),
(20200808, 1619519129, '20200808_add_autoexcuse.php'),
(20200825, 1619519129, '20200825_add_lti13_columns2.php'),
(20201014, 1619519129, '20201014_add_timelimit_ext.php'),
(20201104, 1619519129, '20201104_add_attempt_ext.php'),
(20210303, 1619519129, '20210303_add_lti13_columns3.php');

-- --------------------------------------------------------

--
-- Table structure for table `imas_diags`
--

DROP TABLE IF EXISTS `imas_diags`;
CREATE TABLE IF NOT EXISTS `imas_diags` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ownerid` int(10) UNSIGNED NOT NULL,
  `name` varchar(254) NOT NULL,
  `term` varchar(10) NOT NULL,
  `public` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `cid` int(10) UNSIGNED NOT NULL,
  `idprompt` varchar(254) NOT NULL,
  `ips` text NOT NULL,
  `pws` text NOT NULL,
  `sel1name` varchar(254) NOT NULL,
  `sel1list` text NOT NULL,
  `aidlist` text NOT NULL,
  `sel2name` varchar(254) NOT NULL,
  `sel2list` text NOT NULL,
  `entryformat` char(3) NOT NULL DEFAULT 'C0',
  `forceregen` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `reentrytime` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  KEY `public` (`public`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_diag_onetime`
--

DROP TABLE IF EXISTS `imas_diag_onetime`;
CREATE TABLE IF NOT EXISTS `imas_diag_onetime` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diag` int(10) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `code` varchar(9) NOT NULL,
  `goodfor` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `diag` (`diag`),
  KEY `time` (`time`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_drillassess`
--

DROP TABLE IF EXISTS `imas_drillassess`;
CREATE TABLE IF NOT EXISTS `imas_drillassess` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `summary` text NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `caltag` varchar(254) NOT NULL DEFAULT 'D',
  `itemdescr` text NOT NULL,
  `itemids` text NOT NULL,
  `scoretype` char(3) NOT NULL,
  `showtype` tinyint(1) UNSIGNED NOT NULL,
  `n` smallint(5) UNSIGNED NOT NULL,
  `classbests` text NOT NULL,
  `showtostu` tinyint(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `avail` (`avail`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_drillassess_sessions`
--

DROP TABLE IF EXISTS `imas_drillassess_sessions`;
CREATE TABLE IF NOT EXISTS `imas_drillassess_sessions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `drillassessid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  `curitem` tinyint(3) NOT NULL,
  `seed` smallint(5) UNSIGNED NOT NULL,
  `curscores` text NOT NULL,
  `starttime` int(10) UNSIGNED NOT NULL,
  `scorerec` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `drillassessid` (`drillassessid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_exceptions`
--

DROP TABLE IF EXISTS `imas_exceptions`;
CREATE TABLE IF NOT EXISTS `imas_exceptions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `itemtype` char(1) NOT NULL DEFAULT 'A',
  `assessmentid` int(10) UNSIGNED NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `islatepass` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `waivereqscore` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `exceptionpenalty` tinyint(1) UNSIGNED DEFAULT NULL,
  `is_lti` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `timeext` smallint(6) DEFAULT '0',
  `attemptext` tinyint(3) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `assessmentid` (`assessmentid`),
  KEY `itemtype` (`itemtype`),
  KEY `enddate` (`enddate`),
  KEY `is_lti` (`is_lti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Per student exceptions to assessment start/end date' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_excused`
--

DROP TABLE IF EXISTS `imas_excused`;
CREATE TABLE IF NOT EXISTS `imas_excused` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `type` char(1) NOT NULL,
  `typeid` int(10) UNSIGNED NOT NULL,
  `dateset` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_2` (`userid`,`type`,`typeid`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`),
  KEY `type` (`type`,`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_external_tools`
--

DROP TABLE IF EXISTS `imas_external_tools`;
CREATE TABLE IF NOT EXISTS `imas_external_tools` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `ltikey` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `custom` varchar(255) NOT NULL,
  `privacy` tinyint(1) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `groupid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `courseid` (`courseid`),
  KEY `groupid` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LTI external tools' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_federation_peers`
--

DROP TABLE IF EXISTS `imas_federation_peers`;
CREATE TABLE IF NOT EXISTS `imas_federation_peers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `peername` varchar(32) NOT NULL,
  `peerdescription` varchar(254) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `url` varchar(254) NOT NULL,
  `lastpull` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_federation_pulls`
--

DROP TABLE IF EXISTS `imas_federation_pulls`;
CREATE TABLE IF NOT EXISTS `imas_federation_pulls` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `peerid` int(10) UNSIGNED NOT NULL,
  `pulltime` int(10) UNSIGNED NOT NULL,
  `step` tinyint(2) NOT NULL,
  `fileurl` varchar(254) NOT NULL,
  `record` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pulltime` (`pulltime`),
  KEY `step` (`step`),
  KEY `peerid` (`peerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_firstscores`
--

DROP TABLE IF EXISTS `imas_firstscores`;
CREATE TABLE IF NOT EXISTS `imas_firstscores` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `qsetid` int(10) UNSIGNED NOT NULL,
  `score` tinyint(3) UNSIGNED NOT NULL,
  `scoredet` text NOT NULL,
  `timespent` smallint(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `qsetid` (`qsetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forums`
--

DROP TABLE IF EXISTS `imas_forums`;
CREATE TABLE IF NOT EXISTS `imas_forums` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `description` text NOT NULL,
  `postinstr` text NOT NULL,
  `replyinstr` text NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `settings` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `sortby` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `defdisplay` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `replyby` int(10) UNSIGNED NOT NULL DEFAULT '2000000000',
  `postby` int(10) UNSIGNED NOT NULL DEFAULT '2000000000',
  `grpaid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `groupsetid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `points` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `cntingb` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `gbcategory` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tutoredit` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `rubric` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `caltag` varchar(254) NOT NULL DEFAULT 'FP--FR',
  `forumtype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `allowlate` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `taglist` text NOT NULL,
  `outcomes` text NOT NULL,
  `autoscore` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `points` (`points`),
  KEY `grpaid` (`grpaid`),
  KEY `avail` (`avail`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`),
  KEY `replyby` (`replyby`),
  KEY `postby` (`postby`),
  KEY `gbcategory` (`gbcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forums' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forum_likes`
--

DROP TABLE IF EXISTS `imas_forum_likes`;
CREATE TABLE IF NOT EXISTS `imas_forum_likes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `threadid` int(10) UNSIGNED NOT NULL,
  `postid` int(10) UNSIGNED NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `threadid` (`threadid`),
  KEY `postid` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forum_posts`
--

DROP TABLE IF EXISTS `imas_forum_posts`;
CREATE TABLE IF NOT EXISTS `imas_forum_posts` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `forumid` int(10) UNSIGNED NOT NULL,
  `threadid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  `postdate` int(10) UNSIGNED NOT NULL,
  `views` int(10) UNSIGNED NOT NULL,
  `parent` int(10) UNSIGNED NOT NULL,
  `posttype` tinyint(1) UNSIGNED NOT NULL,
  `subject` varchar(254) NOT NULL,
  `message` text NOT NULL,
  `files` text NOT NULL,
  `tag` varchar(254) NOT NULL,
  `isanon` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `replyby` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forumid` (`forumid`),
  KEY `threadid` (`threadid`),
  KEY `userid` (`userid`),
  KEY `postdate` (`postdate`),
  KEY `tag` (`tag`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forum Postings' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forum_subscriptions`
--

DROP TABLE IF EXISTS `imas_forum_subscriptions`;
CREATE TABLE IF NOT EXISTS `imas_forum_subscriptions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `forumid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forumid` (`forumid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forum subscriptions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forum_threads`
--

DROP TABLE IF EXISTS `imas_forum_threads`;
CREATE TABLE IF NOT EXISTS `imas_forum_threads` (
  `id` int(10) UNSIGNED NOT NULL,
  `forumid` int(10) UNSIGNED NOT NULL,
  `stugroupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastposttime` int(10) UNSIGNED NOT NULL,
  `lastpostuser` int(10) UNSIGNED NOT NULL,
  `views` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forumid` (`forumid`),
  KEY `lastposttime` (`lastposttime`),
  KEY `stugroupid` (`stugroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forum threads' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_forum_views`
--

DROP TABLE IF EXISTS `imas_forum_views`;
CREATE TABLE IF NOT EXISTS `imas_forum_views` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `threadid` int(10) UNSIGNED NOT NULL,
  `lastview` int(10) UNSIGNED NOT NULL,
  `tagged` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `threadid` (`threadid`),
  KEY `lastview` (`lastview`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forum last viewings' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_gbcats`
--

DROP TABLE IF EXISTS `imas_gbcats`;
CREATE TABLE IF NOT EXISTS `imas_gbcats` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `calctype` tinyint(1) NOT NULL DEFAULT '0',
  `scale` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `scaletype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `chop` decimal(3,2) UNSIGNED NOT NULL DEFAULT '1.00',
  `dropn` tinyint(2) NOT NULL DEFAULT '0',
  `weight` smallint(4) NOT NULL DEFAULT '-1',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gradebook Categories' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_gbitems`
--

DROP TABLE IF EXISTS `imas_gbitems`;
CREATE TABLE IF NOT EXISTS `imas_gbitems` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `name` varchar(254) NOT NULL,
  `points` smallint(4) NOT NULL DEFAULT '0',
  `showdate` int(10) UNSIGNED NOT NULL,
  `gbcategory` int(10) UNSIGNED NOT NULL,
  `rubric` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `cntingb` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `tutoredit` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `outcomes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `showdate` (`showdate`),
  KEY `gbcategory` (`gbcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gradebook offline items' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_gbscheme`
--

DROP TABLE IF EXISTS `imas_gbscheme`;
CREATE TABLE IF NOT EXISTS `imas_gbscheme` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `useweights` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `orderby` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `defaultcat` varchar(254) NOT NULL DEFAULT '0,0,1,0,-1,0',
  `defgbmode` int(10) UNSIGNED NOT NULL DEFAULT '21',
  `stugbmode` tinyint(2) UNSIGNED NOT NULL DEFAULT '7',
  `usersort` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `colorize` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Gradebook scheme' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_gbscheme`
--

INSERT INTO `imas_gbscheme` (`id`, `courseid`, `useweights`, `orderby`, `defaultcat`, `defgbmode`, `stugbmode`, `usersort`, `colorize`) VALUES
(1, 1, 0, 0, '0,0,1,0,-1,0', 21, 7, 0, ''),
(2, 2, 0, 0, '0,0,1,0,-1,0', 21, 7, 0, ''),
(3, 3, 0, 0, '0,0,1,0,-1,0', 21, 7, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `imas_grades`
--

DROP TABLE IF EXISTS `imas_grades`;
CREATE TABLE IF NOT EXISTS `imas_grades` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gradetype` varchar(15) NOT NULL DEFAULT 'offline',
  `gradetypeid` int(10) UNSIGNED NOT NULL,
  `refid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `userid` int(10) UNSIGNED NOT NULL,
  `score` decimal(6,1) UNSIGNED DEFAULT '0.0',
  `feedback` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ensureuniq` (`gradetype`,`userid`,`gradetypeid`,`refid`),
  KEY `userid` (`userid`),
  KEY `gradetype` (`gradetype`),
  KEY `gradetypeid` (`gradetypeid`),
  KEY `refid` (`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Offline grades' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_groups`
--

DROP TABLE IF EXISTS `imas_groups`;
CREATE TABLE IF NOT EXISTS `imas_groups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `grouptype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_inlinetext`
--

DROP TABLE IF EXISTS `imas_inlinetext`;
CREATE TABLE IF NOT EXISTS `imas_inlinetext` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `title` varchar(254) NOT NULL,
  `text` text NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `fileorder` text NOT NULL,
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `oncal` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `caltag` varchar(254) NOT NULL DEFAULT '!',
  `isplaylist` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `outcomes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `oncal` (`oncal`),
  KEY `avail` (`avail`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Inline text items' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_instr_acct_reqs`
--

DROP TABLE IF EXISTS `imas_instr_acct_reqs`;
CREATE TABLE IF NOT EXISTS `imas_instr_acct_reqs` (
  `userid` int(10) UNSIGNED NOT NULL,
  `status` tinyint(2) NOT NULL,
  `reqdate` int(10) UNSIGNED NOT NULL,
  `reqdata` text NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_instr_files`
--

DROP TABLE IF EXISTS `imas_instr_files`;
CREATE TABLE IF NOT EXISTS `imas_instr_files` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(254) NOT NULL,
  `filename` varchar(254) NOT NULL DEFAULT '',
  `itemid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itemid` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Inline text file attachments' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_ipeds`
--

DROP TABLE IF EXISTS `imas_ipeds`;
CREATE TABLE IF NOT EXISTS `imas_ipeds` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` char(1) NOT NULL,
  `ipedsid` varchar(32) NOT NULL,
  `school` varchar(255) NOT NULL DEFAULT '',
  `agency` varchar(255) NOT NULL DEFAULT '',
  `country` char(2) NOT NULL DEFAULT 'US',
  `state` char(2) NOT NULL DEFAULT '',
  `zip` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`ipedsid`),
  KEY `zip` (`zip`),
  KEY `loc` (`country`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_ipeds_group`
--

DROP TABLE IF EXISTS `imas_ipeds_group`;
CREATE TABLE IF NOT EXISTS `imas_ipeds_group` (
  `type` char(1) NOT NULL,
  `ipedsid` varchar(32) NOT NULL,
  `groupid` int(10) NOT NULL,
  PRIMARY KEY (`type`,`ipedsid`,`groupid`),
  KEY `groupid` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_items`
--

DROP TABLE IF EXISTS `imas_items`;
CREATE TABLE IF NOT EXISTS `imas_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `itemtype` varchar(20) NOT NULL,
  `typeid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `typeid` (`typeid`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Items within a course' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_items`
--

INSERT INTO `imas_items` (`id`, `courseid`, `itemtype`, `typeid`) VALUES
(1, 1, 'Calendar', 0),
(2, 1, 'Assessment', 1),
(3, 3, 'Assessment', 2);

-- --------------------------------------------------------

--
-- Table structure for table `imas_libraries`
--

DROP TABLE IF EXISTS `imas_libraries`;
CREATE TABLE IF NOT EXISTS `imas_libraries` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uniqueid` bigint(16) UNSIGNED NOT NULL DEFAULT '0',
  `adddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastmoddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(254) NOT NULL,
  `ownerid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `userights` tinyint(1) UNSIGNED NOT NULL DEFAULT '8',
  `sortorder` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `groupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `federationlevel` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  KEY `userights` (`userights`),
  KEY `deleted` (`deleted`),
  KEY `lastmoddate` (`lastmoddate`),
  KEY `uniqueid` (`uniqueid`),
  KEY `groupid` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='QuestionSet Libraries' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_library_items`
--

DROP TABLE IF EXISTS `imas_library_items`;
CREATE TABLE IF NOT EXISTS `imas_library_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `libid` int(10) UNSIGNED NOT NULL,
  `qsetid` int(10) UNSIGNED NOT NULL,
  `ownerid` int(10) UNSIGNED NOT NULL,
  `junkflag` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `lastmoddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `libid` (`libid`),
  KEY `qsetid` (`qsetid`),
  KEY `deleted` (`deleted`),
  KEY `lastmoddate` (`lastmoddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Library assignments' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_linkedtext`
--

DROP TABLE IF EXISTS `imas_linkedtext`;
CREATE TABLE IF NOT EXISTS `imas_linkedtext` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `title` varchar(254) NOT NULL,
  `summary` text NOT NULL,
  `text` text NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `oncal` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `target` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `caltag` varchar(254) NOT NULL DEFAULT '!',
  `points` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `outcomes` text NOT NULL,
  `fileid` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `oncal` (`oncal`),
  KEY `avail` (`avail`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`),
  KEY `text_pfx` (`text`(2)),
  KEY `fileid` (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Linked Text Items' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_linked_files`
--

DROP TABLE IF EXISTS `imas_linked_files`;
CREATE TABLE IF NOT EXISTS `imas_linked_files` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_livepoll_status`
--

DROP TABLE IF EXISTS `imas_livepoll_status`;
CREATE TABLE IF NOT EXISTS `imas_livepoll_status` (
  `assessmentid` int(10) UNSIGNED NOT NULL,
  `curquestion` tinyint(2) UNSIGNED NOT NULL,
  `curstate` tinyint(1) UNSIGNED NOT NULL,
  `seed` int(10) UNSIGNED NOT NULL,
  `startt` bigint(13) UNSIGNED NOT NULL,
  PRIMARY KEY (`assessmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_log`
--

DROP TABLE IF EXISTS `imas_log`;
CREATE TABLE IF NOT EXISTS `imas_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` int(10) UNSIGNED NOT NULL,
  `log` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_login_log`
--

DROP TABLE IF EXISTS `imas_login_log`;
CREATE TABLE IF NOT EXISTS `imas_login_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `logintime` int(10) UNSIGNED NOT NULL,
  `lastaction` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`),
  KEY `logintime` (`logintime`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_login_log`
--

INSERT INTO `imas_login_log` (`id`, `userid`, `courseid`, `logintime`, `lastaction`) VALUES
(1, 3, 1, 1619608294, 0);

-- --------------------------------------------------------

--
-- Table structure for table `imas_ltinonces`
--

DROP TABLE IF EXISTS `imas_ltinonces`;
CREATE TABLE IF NOT EXISTS `imas_ltinonces` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nonce` text NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_ltiqueue`
--

DROP TABLE IF EXISTS `imas_ltiqueue`;
CREATE TABLE IF NOT EXISTS `imas_ltiqueue` (
  `hash` char(32) NOT NULL,
  `sourcedid` text NOT NULL,
  `grade` float UNSIGNED NOT NULL,
  `failures` tinyint(1) UNSIGNED NOT NULL,
  `sendon` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`hash`),
  KEY `sendon` (`sendon`),
  KEY `failures` (`failures`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_ltiusers`
--

DROP TABLE IF EXISTS `imas_ltiusers`;
CREATE TABLE IF NOT EXISTS `imas_ltiusers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org` varchar(255) NOT NULL,
  `ltiuserid` varchar(255) NOT NULL,
  `userid` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ltiuserid` (`ltiuserid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_courses`
--

DROP TABLE IF EXISTS `imas_lti_courses`;
CREATE TABLE IF NOT EXISTS `imas_lti_courses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org` varchar(255) NOT NULL,
  `contextid` varchar(255) NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `copiedfrom` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `contextlabel` varchar(254) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `org` (`org`,`contextid`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_deployments`
--

DROP TABLE IF EXISTS `imas_lti_deployments`;
CREATE TABLE IF NOT EXISTS `imas_lti_deployments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `platform` int(10) UNSIGNED NOT NULL,
  `deployment` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `platdep` (`platform`,`deployment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_groupassoc`
--

DROP TABLE IF EXISTS `imas_lti_groupassoc`;
CREATE TABLE IF NOT EXISTS `imas_lti_groupassoc` (
  `deploymentid` int(10) NOT NULL,
  `groupid` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`deploymentid`,`groupid`),
  KEY `groupid` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_keys`
--

DROP TABLE IF EXISTS `imas_lti_keys`;
CREATE TABLE IF NOT EXISTS `imas_lti_keys` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `key_set_url` varchar(2000) NOT NULL,
  `kid` varchar(254) NOT NULL,
  `alg` varchar(254) NOT NULL,
  `publickey` text NOT NULL,
  `privatekey` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `keyinf` (`key_set_url`(100),`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_lineitems`
--

DROP TABLE IF EXISTS `imas_lti_lineitems`;
CREATE TABLE IF NOT EXISTS `imas_lti_lineitems` (
  `itemtype` tinyint(1) UNSIGNED NOT NULL,
  `typeid` int(10) UNSIGNED NOT NULL,
  `lticourseid` int(10) UNSIGNED NOT NULL,
  `lineitem` varchar(2000) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`itemtype`,`typeid`,`lticourseid`),
  KEY `lticourseid` (`lticourseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_placements`
--

DROP TABLE IF EXISTS `imas_lti_placements`;
CREATE TABLE IF NOT EXISTS `imas_lti_placements` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org` varchar(255) NOT NULL,
  `contextid` varchar(255) NOT NULL,
  `linkid` varchar(255) NOT NULL,
  `typeid` int(10) UNSIGNED NOT NULL,
  `placementtype` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org` (`org`,`contextid`,`linkid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_platforms`
--

DROP TABLE IF EXISTS `imas_lti_platforms`;
CREATE TABLE IF NOT EXISTS `imas_lti_platforms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(254) NOT NULL,
  `issuer` varchar(254) NOT NULL,
  `auth_login_url` varchar(2000) NOT NULL,
  `auth_token_url` varchar(2000) NOT NULL,
  `key_set_url` varchar(2000) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uniqid` char(13) DEFAULT NULL,
  `created_by` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `isscli` (`issuer`,`client_id`),
  KEY `uniqid` (`uniqid`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_lti_tokens`
--

DROP TABLE IF EXISTS `imas_lti_tokens`;
CREATE TABLE IF NOT EXISTS `imas_lti_tokens` (
  `platformid` int(10) UNSIGNED NOT NULL,
  `scopes` varchar(254) NOT NULL,
  `token` text NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`platformid`,`scopes`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_msgs`
--

DROP TABLE IF EXISTS `imas_msgs`;
CREATE TABLE IF NOT EXISTS `imas_msgs` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `title` varchar(254) NOT NULL,
  `message` text NOT NULL,
  `msgto` int(10) UNSIGNED NOT NULL,
  `msgfrom` int(10) UNSIGNED NOT NULL,
  `senddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `replied` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `baseid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tagged` tinyint(1) NOT NULL DEFAULT '0',
  `viewed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `baseid` (`baseid`),
  KEY `courseid` (`courseid`),
  KEY `msgto` (`msgto`,`courseid`),
  KEY `tocombo` (`msgto`,`viewed`,`courseid`),
  KEY `fromcombo` (`msgfrom`,`deleted`,`courseid`),
  KEY `tagged` (`tagged`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Internal messages' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_msgs`
--

INSERT INTO `imas_msgs` (`id`, `courseid`, `title`, `message`, `msgto`, `msgfrom`, `senddate`, `replied`, `parent`, `baseid`, `deleted`, `tagged`, `viewed`) VALUES
(1, 2, 'Send Email', '<p>hjghhhhjjgfj</p>', 1, 1, 1619603213, 0, 0, 0, 0, 0, 1),
(2, 1, 'Send Email', '<p>hello world!</p>', 1, 3, 1619608580, 1, 0, 0, 0, 0, 1),
(3, 1, 'Re: Send Email', '<p>&nbsp;</p>\r\n<hr />\r\n<p>In reply to:</p>\r\n<p>hello world!</p>\r\n<p>werewrwerewrew</p>', 3, 1, 1619608613, 0, 2, 2, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `imas_outcomes`
--

DROP TABLE IF EXISTS `imas_outcomes`;
CREATE TABLE IF NOT EXISTS `imas_outcomes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `ancestors` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_qimages`
--

DROP TABLE IF EXISTS `imas_qimages`;
CREATE TABLE IF NOT EXISTS `imas_qimages` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `qsetid` int(10) UNSIGNED NOT NULL,
  `var` varchar(50) NOT NULL,
  `filename` varchar(254) NOT NULL DEFAULT '',
  `alttext` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `qsetid` (`qsetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Static image ref for questionset' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_questions`
--

DROP TABLE IF EXISTS `imas_questions`;
CREATE TABLE IF NOT EXISTS `imas_questions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `assessmentid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `questionsetid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `points` smallint(4) UNSIGNED NOT NULL DEFAULT '9999',
  `attempts` smallint(4) UNSIGNED NOT NULL DEFAULT '9999',
  `penalty` varchar(6) NOT NULL DEFAULT '9999',
  `category` varchar(254) NOT NULL DEFAULT '0',
  `rubric` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `regen` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `showans` char(1) NOT NULL DEFAULT '0',
  `showhints` tinyint(1) NOT NULL DEFAULT '0',
  `extracredit` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `withdrawn` char(1) NOT NULL DEFAULT '0',
  `fixedseeds` text,
  `showwork` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `assessmentid` (`assessmentid`),
  KEY `questionsetid` (`questionsetid`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Questions in an assessment' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_questionset`
--

DROP TABLE IF EXISTS `imas_questionset`;
CREATE TABLE IF NOT EXISTS `imas_questionset` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uniqueid` bigint(16) UNSIGNED NOT NULL DEFAULT '0',
  `adddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastmoddate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ownerid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `author` text NOT NULL,
  `userights` tinyint(1) UNSIGNED NOT NULL DEFAULT '2',
  `license` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `description` varchar(254) DEFAULT '',
  `qtype` varchar(20) NOT NULL DEFAULT '',
  `control` text NOT NULL,
  `qcontrol` text NOT NULL,
  `qtext` text NOT NULL,
  `answer` text NOT NULL,
  `solution` text NOT NULL,
  `extref` text NOT NULL,
  `hasimg` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `avgtime` varchar(254) NOT NULL DEFAULT '0',
  `ancestors` text NOT NULL,
  `ancestorauthors` text NOT NULL,
  `otherattribution` text NOT NULL,
  `importuid` varchar(254) DEFAULT '',
  `replaceby` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `broken` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `solutionopts` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `sourceinstall` varchar(32) NOT NULL DEFAULT '',
  `meantimen` int(10) NOT NULL DEFAULT '0',
  `meantime` double NOT NULL DEFAULT '0',
  `vartime` double NOT NULL DEFAULT '0',
  `meanscoren` int(10) NOT NULL DEFAULT '0',
  `meanscore` double NOT NULL DEFAULT '0',
  `varscore` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  KEY `userights` (`userights`),
  KEY `deleted` (`deleted`),
  KEY `replaceby` (`replaceby`),
  KEY `lastmoddate` (`lastmoddate`),
  KEY `broken` (`broken`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Actual set of questions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_rubrics`
--

DROP TABLE IF EXISTS `imas_rubrics`;
CREATE TABLE IF NOT EXISTS `imas_rubrics` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ownerid` int(10) UNSIGNED NOT NULL,
  `groupid` int(10) NOT NULL DEFAULT '-1',
  `name` varchar(254) NOT NULL,
  `rubrictype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `rubric` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`),
  KEY `groupid` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rubrics' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_students`
--

DROP TABLE IF EXISTS `imas_students`;
CREATE TABLE IF NOT EXISTS `imas_students` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `courseid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `section` varchar(40) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `gbcomment` text NOT NULL,
  `gbinstrcomment` text NOT NULL,
  `latepass` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `lastaccess` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `locked` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hidefromcourselist` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `timelimitmult` decimal(3,2) UNSIGNED NOT NULL DEFAULT '1.00',
  `stutype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `custominfo` text NOT NULL,
  `lticourseid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`),
  KEY `code` (`code`),
  KEY `section` (`section`),
  KEY `locked` (`locked`),
  KEY `lastaccess` (`lastaccess`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Which courses each student is enrolled in' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_students`
--

INSERT INTO `imas_students` (`id`, `userid`, `courseid`, `section`, `code`, `gbcomment`, `gbinstrcomment`, `latepass`, `lastaccess`, `locked`, `hidefromcourselist`, `timelimitmult`, `stutype`, `custominfo`, `lticourseid`) VALUES
(1, 3, 1, NULL, NULL, '', '', 0, 1619608294, 0, 0, '1.00', 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `imas_stugroupmembers`
--

DROP TABLE IF EXISTS `imas_stugroupmembers`;
CREATE TABLE IF NOT EXISTS `imas_stugroupmembers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stugroupid` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stugroupid` (`stugroupid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Student Group Members' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_stugroups`
--

DROP TABLE IF EXISTS `imas_stugroups`;
CREATE TABLE IF NOT EXISTS `imas_stugroups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupsetid` int(10) UNSIGNED NOT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `groupsetid` (`groupsetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Student Groups' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_stugroupset`
--

DROP TABLE IF EXISTS `imas_stugroupset`;
CREATE TABLE IF NOT EXISTS `imas_stugroupset` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseid` int(10) UNSIGNED NOT NULL,
  `name` varchar(254) NOT NULL,
  `delempty` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Student Group Sets' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_teachers`
--

DROP TABLE IF EXISTS `imas_teachers`;
CREATE TABLE IF NOT EXISTS `imas_teachers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `courseid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hidefromcourselist` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Which courses each teacher is teaching' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_teachers`
--

INSERT INTO `imas_teachers` (`id`, `userid`, `courseid`, `hidefromcourselist`) VALUES
(1, 1, 1, 0),
(2, 1, 2, 0),
(3, 1, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `imas_teacher_audit_log`
--

DROP TABLE IF EXISTS `imas_teacher_audit_log`;
CREATE TABLE IF NOT EXISTS `imas_teacher_audit_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `action` enum('Assessment Settings Change','Mass Assessment Settings Change','Mass Date Change','Question Settings Change','Clear Attempts','Clear Scores','Delete Item','Unenroll','Change Grades','Course Settings Change','Inlinetext Settings Change','Link Settings Change','Forum Settings Change','Mass Forum Settings Change','Block Settings Change','Mass Block Settings Change','Wiki Settings Change','Drill Settings Change','Gradebook Settings Change','Roster Action','Exception Change','Delete Post','Offline Grade Settings Change','Change Offline Grades','Change Forum Grades','Change External Tool Grades','Custom1 Settings Change','Mass Custom1 Settings Change','Custom2 Settings Change','Mass Custom2 Settings Change','Custom3 Settings Change','Mass Custom3 Settings Change') DEFAULT NULL,
  `itemid` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `metadata` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseuser` (`courseid`,`userid`),
  KEY `actionid` (`action`,`itemid`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_tutors`
--

DROP TABLE IF EXISTS `imas_tutors`;
CREATE TABLE IF NOT EXISTS `imas_tutors` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `section` varchar(40) NOT NULL,
  `hidefromcourselist` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='course tutors' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_users`
--

DROP TABLE IF EXISTS `imas_users`;
CREATE TABLE IF NOT EXISTS `imas_users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SID` varchar(50) NOT NULL,
  `password` varchar(254) NOT NULL,
  `rights` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lastaccess` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `groupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `msgnotify` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `qrightsdef` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deflib` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `usedeflib` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `homelayout` varchar(32) NOT NULL DEFAULT '|0,1,2||0,1',
  `hasuserimg` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `remoteaccess` varchar(10) NOT NULL DEFAULT '',
  `theme` varchar(32) NOT NULL DEFAULT '',
  `listperpage` tinyint(3) UNSIGNED NOT NULL DEFAULT '20',
  `hideonpostswidget` text NOT NULL,
  `specialrights` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `FCMtoken` varchar(512) NOT NULL DEFAULT '',
  `jsondata` mediumtext NOT NULL,
  `forcepwreset` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `mfa` text NOT NULL,
  `lastemail` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SID` (`SID`),
  KEY `lastaccess` (`lastaccess`),
  KEY `rights` (`rights`),
  KEY `groupid` (`groupid`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='User Information' ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `imas_users`
--

INSERT INTO `imas_users` (`id`, `SID`, `password`, `rights`, `FirstName`, `LastName`, `email`, `lastaccess`, `groupid`, `msgnotify`, `qrightsdef`, `deflib`, `usedeflib`, `homelayout`, `hasuserimg`, `remoteaccess`, `theme`, `listperpage`, `hideonpostswidget`, `specialrights`, `FCMtoken`, `jsondata`, `forcepwreset`, `mfa`, `lastemail`) VALUES
(1, 'root', '$2y$10$sMJxF6O5AxXjz/lFyJajWewSuGzv8Y3HpI22eo14fo.gatZSsQvai', 100, 'imath', 'imathtest', 'ilovecoding777@gmail.com', 1621349192, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, 'yQ3SKFAcBy', '', 20, '', 112, '', '', 0, '', 1621337957),
(2, 'aaa111', '$2y$10$YQHFjIeJY61eWddiCVjUteaJA3aDGrzTg5x1dr.uj5OUFjRy5Ib9a', 10, 'AAA', 'MMM', 'aaaammm@gmail.com', 0, 0, 1, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(3, 'user1', '$2y$10$.IJkogDEctomta9jNjNFx.TGGQl98kGr1Izrb55xzS74KcQPggH4i', 10, 'User1', 'User2', 'liketodev2@gmail.com', 1619608204, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '', 0, '', 0),
(4, 'a2299', '$2y$10$8FAy6BeMaaDj9inzc335TeSDqVF3FUNt.kIdF8rF94pymDMDHHxJO', 10, 'Aram', 'Mirzoyan', 'admin@gmail.com', 0, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(5, 'a999999', '$2y$10$DqIo6LrBXiAe9l1BTgNuqu3XAP8bhRMMSVxVuotjA6J1Eil0qkV/G', 10, 'Vzgo', 'LLLL', 'llvzgo@gmail.com', 0, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(6, 'kkkkk123', '$2y$10$X57MrdGIcdy22kMJwbT73erZNlJV9cLrxUKFcLEbBCSGUxcmCLuqy', 10, 'hhhh', 'gggggg', 'jjj@gmail.com', 1621335472, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '5XRK1LbdzJ', '', 20, '', 0, '', '[]', 0, '', 1621324027),
(7, 'ff22', '$2y$10$yAKNq4z25fAsEsSVKkkmE.t8uOmy5SCr7I4kE27u9P.N/pitcEb0G', 10, 'ss', 'dd', 'ff@gmail.com', 0, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(8, 'ww44', '$2y$10$vgcjrflRQe4YHMkT4LPhiuRQbUegcXmoG5Wvw8R6M7gqk4onqZ4B.', 10, 'ww', 'ee', 'wwee@gmail.com', 0, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(9, 'john', '$2y$10$0gxauciPZuSWrwxzamcigeOmvlL2WGz/1SsFel3IW9JtX0ujH2UHG', 10, 'John', 'William', 'john@gmail.com', 1621338349, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0),
(10, 'admin', '$2y$10$2c53Fd92XN4bGyKeG5Yg7uPXw.OZw70gL.Phgvy5zUzYexqGPPJ3S', 10, 'admin', 'admin', 'testadmin@gmail.com', 1621338507, 0, 0, 0, 0, 0, '|0,1,2||0,1', 0, '', '', 20, '', 0, '', '[]', 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `imas_user_prefs`
--

DROP TABLE IF EXISTS `imas_user_prefs`;
CREATE TABLE IF NOT EXISTS `imas_user_prefs` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item` varchar(31) NOT NULL,
  `value` varchar(31) NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_wikis`
--

DROP TABLE IF EXISTS `imas_wikis`;
CREATE TABLE IF NOT EXISTS `imas_wikis` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `description` text NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `startdate` int(10) UNSIGNED NOT NULL,
  `editbydate` int(10) UNSIGNED NOT NULL,
  `enddate` int(10) UNSIGNED NOT NULL,
  `settings` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `groupsetid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `avail` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `avail` (`avail`),
  KEY `startdate` (`startdate`),
  KEY `enddate` (`enddate`),
  KEY `editbydate` (`editbydate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wikis' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_wiki_revisions`
--

DROP TABLE IF EXISTS `imas_wiki_revisions`;
CREATE TABLE IF NOT EXISTS `imas_wiki_revisions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wikiid` int(10) UNSIGNED NOT NULL,
  `stugroupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `userid` int(10) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `revision` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wikiid` (`wikiid`),
  KEY `stugroupid` (`stugroupid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wiki revisions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imas_wiki_views`
--

DROP TABLE IF EXISTS `imas_wiki_views`;
CREATE TABLE IF NOT EXISTS `imas_wiki_views` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `wikiid` int(10) UNSIGNED NOT NULL,
  `lastview` int(10) UNSIGNED NOT NULL,
  `stugroupid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `wikiid` (`wikiid`),
  KEY `stugroupid` (`stugroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wiki last viewings' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `mc_msgs`
--

DROP TABLE IF EXISTS `mc_msgs`;
CREATE TABLE IF NOT EXISTS `mc_msgs` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `msg` text NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `mc_sessions`
--

DROP TABLE IF EXISTS `mc_sessions`;
CREATE TABLE IF NOT EXISTS `mc_sessions` (
  `userid` int(10) NOT NULL AUTO_INCREMENT,
  `sessionid` varchar(32) NOT NULL,
  `name` varchar(254) NOT NULL,
  `room` int(10) NOT NULL,
  `lastping` int(10) UNSIGNED NOT NULL,
  `mathdisp` tinyint(1) NOT NULL,
  `graphdisp` tinyint(1) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `sessionid` (`sessionid`),
  KEY `room` (`room`),
  KEY `lastping` (`lastping`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `php_sessions`
--

DROP TABLE IF EXISTS `php_sessions`;
CREATE TABLE IF NOT EXISTS `php_sessions` (
  `id` varchar(32) NOT NULL,
  `access` int(10) UNSIGNED DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `access` (`access`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `php_sessions`
--

INSERT INTO `php_sessions` (`id`, `access`, `data`) VALUES
('0gnpuj1o5d3b6ujq8f11b2nad0', 1621334571, 'challenge|s:36:\"MC43NDk4NTYwMCAxNjIxMzM0NTcxMjI2Nw==\";'),
('2p5a94jmnt21t99asdn3f0knbj', 1621335472, 'secsalt|s:10:\"PVJxCX5373\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"6\";time|i:1621335472;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('2uvbk09qk9r7mvuor3ovblgoav', 1621349097, 'secsalt|s:10:\"vGWjNuG9ZP\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"1\";time|i:1621349096;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('34nioj2p3050vmp32pejpgrncv', 1621335016, 'challenge|s:36:\"MC44MjMyMDAwMCAxNjIxMzM1MDE2NzE0OA==\";'),
('52q7m7619ed8iltapa1qs7b9r6', 1621334900, 'challenge|s:36:\"MC45OTIzOTIwMCAxNjIxMzM0OTAwNzM0Mw==\";'),
('72odjl26v3p13u4bg1op4lfojo', 1621349097, 'challenge|s:32:\"MC4wNDAwNDQwMCAxNjIxMzQ5MDk3ODk5\";'),
('75oefb5n97d8bondg4meq0edij', 1621349147, 'challenge|s:36:\"MC45MTcwODUwMCAxNjIxMzQ5MTQ3ODAyMA==\";'),
('77vp6el4g80b1cpif0skqkc7m8', 1621334927, 'challenge|s:36:\"MC41MDU5MTYwMCAxNjIxMzM0OTI3NzMwNw==\";'),
('7d5fuh4tc6530ohm7hvuhr85nc', 1621349085, 'challenge|s:36:\"MC40NDkxMjMwMCAxNjIxMzQ5MDg1ODg4Nw==\";'),
('890fg6nbvv0f6vle9ig8gnjok4', 1619613288, 'challenge|s:36:\"MC44NTI2NzYwMCAxNjE5NjEzMjg4NTE4NQ==\";'),
('9mff4ufca9iioolck940c1acmc', 1621335393, 'challenge|s:36:\"MC40ODI5NzgwMCAxNjIxMzM1MzkzNjE1Mw==\";'),
('9vlt0hav1o3fc3kqca1c3r2m26', 1621334874, 'challenge|s:36:\"MC43MDAyODUwMCAxNjIxMzM0ODc0MjY2NQ==\";'),
('cbevb1s109hpu71b6he90ne1b5', 1621334600, 'challenge|s:36:\"MC45MzE5MTkwMCAxNjIxMzM0NjAwMzA3OA==\";'),
('chsp5e9pdeda8t8h1td6kvsju9', 1621334347, 'challenge|s:32:\"MC45NjE3OTIwMCAxNjIxMzM0MzQ3MjA=\";'),
('cpjtj9rmhgk9s45b1r0bhrk0qt', 1621334850, 'challenge|s:36:\"MC42OTI5ODUwMCAxNjIxMzM0ODUwMTQ0Mw==\";'),
('e2sm51cgbjbjcsef4p1bbml6tp', 1621349802, 'challenge|s:36:\"MC4yNDQ0OTEwMCAxNjIxMzQ5ODAyNjAwMQ==\";'),
('el1fk9dlnr55ilsajhkt1lngfa', 1621333774, 'challenge|s:36:\"MC40NTQ1NjMwMCAxNjIxMzMzNzc0MjMyMw==\";'),
('g1eo7pgma3g4u51sb4iulf583a', 1621335462, 'challenge|s:36:\"MC40NTMxNjEwMCAxNjIxMzM1NDYyMjIxMw==\";'),
('gj9uod1guhntdh4e9plsfkc11c', 1621334828, 'challenge|s:36:\"MC4zNDM5MzQwMCAxNjIxMzM0ODI4NzkyOQ==\";'),
('gkhptbmluholiprm4974t42ehr', 1621335439, 'challenge|s:32:\"MC41OTcwMDAwMCAxNjIxMzM1NDM5MzA5\";'),
('gvem4vok05blu0aoklpn72q9d2', 1621335400, 'secsalt|s:10:\"3JzeMh1Lg7\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"1\";time|i:1621335400;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('hgbnlpa6ogql1g7ufm2bv1gjih', 1621333809, 'challenge|s:32:\"MC44MzQ3NzUwMCAxNjIxMzMzODA5NDA1\";'),
('hgds464q2ljelai543i62olvfh', 1621334779, 'challenge|s:36:\"MC40ODg4NzIwMCAxNjIxMzM0Nzc5NzUwMw==\";'),
('hi12k78dlqkvnst9vj997r487q', 1621326263, 'challenge|s:32:\"MC4wMTEzNjgwMCAxNjIxMzI2MjYzNjg4\";'),
('i7c7ernllp2cumjf719nf2nv7s', 1619519493, 'challenge|s:36:\"MC41NDAyOTgwMCAxNjE5NTE5MTY1ODk2MQ==\";'),
('i9f39jjhgqvivq5aou62q4uded', 1619613078, 'secsalt|s:10:\"vqTf8RghHq\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"3\";time|i:1619608204;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";lastaccess1|i:1619608294;loginlog1|s:1:\"1\";folder1|s:1:\"0\";assess2-1|b:0;'),
('i9viigfi71pnanuhumrdj988a3', 1621335439, 'secsalt|s:10:\"allthJur2H\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"1\";time|i:1621335439;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('iue3qa48gloeou8nc3qpr556q5', 1621335429, 'challenge|s:36:\"MC43ODk2NTMwMCAxNjIxMzM1NDI5NDA5Ng==\";'),
('j403jvuenbfdefjsrf1flipeg6', 1621334320, 'challenge|s:36:\"MC43OTA4NjEwMCAxNjIxMzM0MzIwMTk5Mw==\";'),
('j7uv8vnab38uaarvugrq5fbupa', 1621334742, 'challenge|s:36:\"MC45NzIzNTEwMCAxNjIxMzM0NzQyODY1OA==\";'),
('l2bemq020p2crdbhg43bp5dg03', 1621335400, 'challenge|s:36:\"MC40NTQxNjcwMCAxNjIxMzM1NDAwNTAyNg==\";'),
('ljpbb5vuitjugh5slpv3fgoufk', 1621335249, 'challenge|s:36:\"MC4zNjg2NzYwMCAxNjIxMzM1MjQ5OTY1NA==\";'),
('nlm6ohakvvre28ur7k6glc1h5t', 1621349147, 'secsalt|s:10:\"61bRXDhUA2\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"1\";time|i:1621349147;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('o8cug2pg1h8ok5m1spita8hok7', 1621334894, 'challenge|s:36:\"MC45MTA3NjAwMCAxNjIxMzM0ODk0OTE3Mg==\";'),
('ojb8v1j5r13toop2v814lripod', 1621334925, 'challenge|s:36:\"MC44NDE0MjUwMCAxNjIxMzM0OTI1Njc5Mg==\";'),
('onkvbsdj5p8kn45ghl8nvlgoj2', 1621334873, 'challenge|s:36:\"MC40NDM3MDEwMCAxNjIxMzM0ODczMjkyOQ==\";'),
('os1ruobcapvqnrg8ncvuk708fi', 1621326264, 'challenge|s:36:\"MC4zNjIwOTYwMCAxNjIxMzI2MjY0NTgyMw==\";'),
('puqhrfn7m4j2co5jbogluj37q7', 1621335127, 'challenge|s:36:\"MC40NTM5NzcwMCAxNjIxMzM1MTI3MzEzMw==\";'),
('qb14fpr68jedpe4cnr09ugkjp8', 1621335230, 'challenge|s:36:\"MC4zNTI0MzUwMCAxNjIxMzM1MjMwOTI1OQ==\";'),
('qlbqrmf9s3oelh907dn1ttv325', 1621349131, 'challenge|s:36:\"MC41MjEzMDQwMCAxNjIxMzQ5MTMxMjY0Mg==\";'),
('r42j969ik2426l3ku429l68fgg', 1621330949, 'challenge|s:32:\"MC4xODA0ODYwMCAxNjIxMzMwOTQ5OTIz\";'),
('rmptvdjjkskn22ehuf2sa1531k', 1621334844, 'challenge|s:36:\"MC4yMjUwMzMwMCAxNjIxMzM0ODQ0MTgzOQ==\";'),
('ru1898ips6relej43oh5osklcl', 1621334640, 'challenge|s:36:\"MC4xMTUxOTAwMCAxNjIxMzM0NjQwMjY2OQ==\";'),
('s9a5460lum62jsdnuhjpps74as', 1621334825, 'challenge|s:36:\"MC40Nzc0MDYwMCAxNjIxMzM0ODI1NzI0NA==\";'),
('t3oi1g1351okl9cpnb90i8sfit', 1621333964, 'challenge|s:32:\"MC4xMjU4MDcwMCAxNjIxMzMzOTY0MTEy\";'),
('ukldb2g5isl8elo46f40ghg9qa', 1621349192, 'secsalt|s:10:\"J4heRkW2WQ\";logintzname|s:12:\"Asia/Yerevan\";userprefs|a:6:{s:8:\"mathdisp\";i:1;s:9:\"graphdisp\";i:1;s:9:\"drawentry\";i:1;s:5:\"useed\";i:1;s:7:\"useeqed\";i:1;s:11:\"livepreview\";i:1;}graphdisp|i:1;mathdisp|i:1;useed|i:1;userid|s:1:\"1\";time|i:1621349192;tzoffset|s:4:\"-240\";tzname|s:12:\"Asia/Yerevan\";'),
('uvckegffm0sq0v3vbl9uan4dot', 1621335472, 'challenge|s:36:\"MC45OTMzNTAwMCAxNjIxMzM1NDcyNDMyNA==\";'),
('vdcehlqhm1pre4akqjudl6k3c0', 1621334893, 'challenge|s:36:\"MC43NTg0NzEwMCAxNjIxMzM0ODkzNDU4MA==\";'),
('vlp0q8anh3ioggoudoj2slf01l', 1621334912, 'challenge|s:36:\"MC44OTE5OTQwMCAxNjIxMzM0OTEyMjA3NA==\";');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `imas_ipeds`
--
ALTER TABLE `imas_ipeds` ADD FULLTEXT KEY `school` (`school`);
ALTER TABLE `imas_ipeds` ADD FULLTEXT KEY `agency` (`agency`);

--
-- Indexes for table `imas_questionset`
--
ALTER TABLE `imas_questionset` ADD FULLTEXT KEY `descidx` (`description`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
