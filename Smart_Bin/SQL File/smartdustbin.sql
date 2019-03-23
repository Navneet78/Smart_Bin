-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2018 at 08:21 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartdustbin`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `cid` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `rec_credits` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`cid`, `name`, `rec_credits`, `address`, `city`, `state`) VALUES
(1, 'Coca Cola', '2.4500', 'Sadar Bazzar', 'Jabalpur', 'Madhya Pradesh');

-- --------------------------------------------------------

--
-- Table structure for table `dustbin`
--

CREATE TABLE `dustbin` (
  `did` int(11) NOT NULL,
  `met_weight` decimal(8,2) NOT NULL,
  `non_met_weight` decimal(8,2) NOT NULL,
  `loc_long` decimal(10,4) DEFAULT NULL,
  `loc_lat` decimal(10,4) DEFAULT NULL,
  `filled_met` decimal(5,2) NOT NULL,
  `filled_non_met` decimal(5,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dustbin`
--

INSERT INTO `dustbin` (`did`, `met_weight`, `non_met_weight`, `loc_long`, `loc_lat`, `filled_met`, `filled_non_met`) VALUES
(1, '10.00', '3.00', '79.9473', '23.1527', '20.00', '10.00');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `rid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `did` int(11) NOT NULL,
  `amount` decimal(10,4) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `duration` int(5) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`rid`, `cid`, `did`, `amount`, `timestamp`, `duration`) VALUES
(1, 1, 1, '48.0000', '2018-11-11 07:32:31', 7),
(2, 1, 1, '12.3200', '2018-11-14 12:50:25', 2),
(3, 1, 1, '65.0000', '2018-11-14 12:51:54', 6),
(4, 1, 1, '32.5600', '2018-11-14 12:52:35', 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `cid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`cid`, `username`, `password`) VALUES
(1, 'Coca Cola', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `dustbin`
--
ALTER TABLE `dustbin`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`rid`,`cid`,`did`),
  ADD KEY `cid` (`cid`),
  ADD KEY `did` (`did`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`cid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `dustbin`
--
ALTER TABLE `dustbin`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `company` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`did`) REFERENCES `dustbin` (`did`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
