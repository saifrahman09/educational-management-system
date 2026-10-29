-- Educational Management System database
-- WARNING: Importing this file drops and recreates the six application tables.

CREATE DATABASE IF NOT EXISTS `education`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `education`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `tblnotice`;
DROP TABLE IF EXISTS `tblpublicnotice`;
DROP TABLE IF EXISTS `tblstudent`;
DROP TABLE IF EXISTS `tblclass`;
DROP TABLE IF EXISTS `tblpage`;
DROP TABLE IF EXISTS `tbladmin`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `tbladmin` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `AdminName` varchar(200) NOT NULL,
  `UserName` varchar(200) NOT NULL,
  `MobileNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Password` varchar(255) NOT NULL,
  `AdminRegdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uq_tbladmin_username` (`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblclass` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(100) NOT NULL,
  `Section` varchar(100) NOT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_tblclass_name_section` (`ClassName`, `Section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblstudent` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `StudentName` varchar(200) DEFAULT NULL,
  `StudentEmail` varchar(200) DEFAULT NULL,
  `StudentClass` varchar(100) DEFAULT NULL,
  `Gender` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `StuID` varchar(200) DEFAULT NULL,
  `FatherName` mediumtext DEFAULT NULL,
  `MotherName` mediumtext DEFAULT NULL,
  `ContactNumber` bigint(10) DEFAULT NULL,
  `AltenateNumber` bigint(10) DEFAULT NULL,
  `Address` mediumtext DEFAULT NULL,
  `UserName` varchar(200) DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  `Image` varchar(200) DEFAULT NULL,
  `DateofAdmission` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uq_tblstudent_stuid` (`StuID`),
  UNIQUE KEY `uq_tblstudent_username` (`UserName`),
  KEY `idx_tblstudent_class` (`StudentClass`),
  KEY `idx_tblstudent_admission` (`DateofAdmission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblnotice` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NoticeTitle` varchar(200) NOT NULL,
  `ClassId` int(10) DEFAULT NULL,
  `NoticeMsg` mediumtext DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_tblnotice_class` (`ClassId`),
  KEY `idx_tblnotice_creation` (`CreationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblpublicnotice` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NoticeTitle` varchar(200) NOT NULL,
  `NoticeMessage` mediumtext DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_tblpublicnotice_creation` (`CreationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblpage` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `PageType` varchar(100) NOT NULL,
  `PageTitle` varchar(200) DEFAULT NULL,
  `PageDescription` mediumtext DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `MobileNumber` varchar(20) DEFAULT NULL,
  `UpdationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uq_tblpage_pagetype` (`PageType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tbladmin`
  (`ID`, `AdminName`, `UserName`, `MobileNumber`, `Email`, `Password`)
VALUES
  (1, 'System Administrator', 'admin', '9000000000', 'admin@example.com',
   '482c811da5d5b4bc6d497ffa98491e38');

INSERT INTO `tblclass` (`ID`, `ClassName`, `Section`) VALUES
  (1, '10th', 'A'),
  (2, '11th', 'Science'),
  (3, '12th', 'Science');

INSERT INTO `tblstudent`
  (`ID`, `StudentName`, `StudentEmail`, `StudentClass`, `Gender`, `DOB`,
   `StuID`, `FatherName`, `MotherName`, `ContactNumber`, `AltenateNumber`,
   `Address`, `UserName`, `Password`, `Image`, `DateofAdmission`)
VALUES
  (1, 'Aarav Sharma', 'aarav@example.com', '1', 'Male', '2010-05-14',
   'EMS-1001', 'Rajesh Sharma', 'Sunita Sharma', '9000000001', '9000000002',
   'Nashik, Maharashtra', 'aarav@example.com',
   '5f4dcc3b5aa765d61d8327deb882cf99', NULL, '2025-06-10 09:00:00'),
  (2, 'Meera Patel', 'meera@example.com', '2', 'Female', '2009-11-02',
   'EMS-1101', 'Kiran Patel', 'Nisha Patel', '9000000003', '9000000004',
   'Pune, Maharashtra', 'meera@example.com',
   '5f4dcc3b5aa765d61d8327deb882cf99', NULL, '2025-06-12 10:30:00');

INSERT INTO `tblnotice` (`ID`, `NoticeTitle`, `ClassId`, `NoticeMsg`) VALUES
  (1, 'Science Exhibition', 2, 'The annual science exhibition will be held on Friday.');

INSERT INTO `tblpublicnotice` (`ID`, `NoticeTitle`, `NoticeMessage`) VALUES
  (1, 'Welcome to the New Academic Year', 'Welcome students and families to the new academic year.');

INSERT INTO `tblpage`
  (`ID`, `PageType`, `PageTitle`, `PageDescription`, `Email`, `MobileNumber`)
VALUES
  (1, 'aboutus', 'About Our School',
   'Our school supports students through a welcoming learning environment and a broad academic program.',
   NULL, NULL),
  (2, 'contactus', 'Contact Us',
   'Contact the school office for admissions and general enquiries.',
   'office@example.com', '9000000000');

ALTER TABLE `tbladmin` AUTO_INCREMENT = 2;
ALTER TABLE `tblclass` AUTO_INCREMENT = 4;
ALTER TABLE `tblstudent` AUTO_INCREMENT = 3;
ALTER TABLE `tblnotice` AUTO_INCREMENT = 2;
ALTER TABLE `tblpublicnotice` AUTO_INCREMENT = 2;
ALTER TABLE `tblpage` AUTO_INCREMENT = 3;
