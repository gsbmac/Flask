-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Apr 09, 2015 at 11:47 PM
-- Server version: 5.5.39
-- PHP Version: 5.4.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pr_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_category`
--

CREATE TABLE IF NOT EXISTS `tb_category` (
`id` bigint(6) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  `icon` longtext NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tb_category`
--

INSERT INTO `tb_category` (`id`, `name`, `description`, `icon`) VALUES
(1, 'T-Shirt', 'Includes T-shirts, V-necks and Turtle-neck shirts', 'icons/shirt.png'),
(2, 'Polo', 'Formal or Smart Casual', 'icons/polo.png'),
(3, 'Polo Shirt', 'Normal work outfit', 'icons/poloshirt.png'),
(4, 'Pants', 'Semi-formal jeans used usually for work', 'icons/pants.png');

-- --------------------------------------------------------

--
-- Table structure for table `tb_item`
--

CREATE TABLE IF NOT EXISTS `tb_item` (
`id` bigint(6) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  `tags` varchar(50) NOT NULL,
  `category` bigint(6) DEFAULT NULL,
  `image` longtext
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tb_item`
--

INSERT INTO `tb_item` (`id`, `name`, `description`, `tags`, `category`, `image`) VALUES
(1, 'Blue Polo Shirt', 'Image from the internet', 'blue, polo, shirt, work', 3, 'uploads/426C756520506F6C6F205368697274496D6167652066726F6D2074686520696E7465726E6574626C75652C20706F6C6F2C2073686972742C20776F726B33626C75655F706F6C6F2E6A7067.jpg'),
(2, 'Kaki Pants', 'Image from the internet', 'kaki, pants, work', 4, 'uploads/4B616B692050616E7473496D6167652066726F6D2074686520696E7465726E65746B616B692C2070616E74732C20776F726B3470616E74735F332E6A7067.jpg'),
(3, 'Red Shirt', 'Image from the internet', 'red, shirt, indoor', 1, 'uploads/526564205368697274496D6167652066726F6D2074686520696E7465726E65747265642C2073686972742C20696E646F6F72317265642E706E67.png'),
(4, 'Brown Pants', 'Image from the internet', 'bro', 4, 'uploads/42726F776E2050616E7473496D6167652066726F6D2074686520696E7465726E657462726F3470616E74735F322E6A7067.jpg'),
(5, 'Green Shirt', 'Image from the internet', 'green, shirt, indoor', 1, 'uploads/477265656E205368697274496D6167652066726F6D2074686520696E7465726E6574677265656E2C2073686972742C20696E646F6F7231677265656E2E6A7067.jpg'),
(6, 'Orange Shirt', 'Image from the internet', 'orange, shirt, outdoor', 1, 'uploads/4F72616E6765205368697274496D6167652066726F6D2074686520696E7465726E65746F72616E67652C2073686972742C206F7574646F6F72316F72616E67652E6A7067.jpg'),
(7, 'Polo Stripes', 'Corporate Stripe Long Sleeves', 'polo, stripes, blue, formal, work', 2, 'uploads/506F6C6F2053747269706573436F72706F7261746520537472697065204C6F6E6720536C6565766573706F6C6F2C20737472697065732C20626C75652C20666F726D616C2C20776F726B32737472697065706F6C6F2E6A706567.jpeg'),
(8, 'Blue Polo', 'Corporate Blue Polo', 'blue, polo, work, formal', 2, 'uploads/426C756520506F6C6F436F72706F7261746520426C756520506F6C6F626C75652C20706F6C6F2C20776F726B2C20666F726D616C32626C7565706F6C6F2E6A7067.jpg'),
(9, 'Blue Jeans', 'Formal Blue Semi-fit Jeans', 'blue, pants, work, formal', 4, 'uploads/426C7565204A65616E73466F726D616C20426C75652053656D692D666974204A65616E73626C75652C2070616E74732C20776F726B2C20666F726D616C3470616E74735F312E6A7067.jpg'),
(10, 'Sky Blue Polo Shirt', 'Usual Polo Short used for work', 'blue, polo, shirt, work', 3, 'uploads/536B7920426C756520506F6C6F205368697274557375616C20506F6C6F2053686F7274207573656420666F7220776F726B626C75652C20706F6C6F2C2073686972742C20776F726B33736B79626C7565706F6C6F2E6A7067.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE IF NOT EXISTS `tb_user` (
`id` bigint(6) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'user'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id`, `username`, `password`, `role`) VALUES
(1, 'mac', '140c1f12feeb2c52dfbeb2da6066a73a', 'user'),
(3, 'yeah', '29814d7ba6b9db8d5ab57fd57ceb9c1a', 'user'),
(4, 'amber', '59548977279905234b7ed3b1710837f2', 'user'),
(5, 'alexis', '059bf68f71c80fce55214b411dd2280c', 'user'),
(6, 'axel', 'a7c15c415c37626de8fa648127ba1ae5', 'user'),
(7, 'aliyah', '22f1dffdbf5d57f369c3fb8d3053128d', 'user'),
(8, 'bey', 'bfa99df33b137bc8fb5f5407d7e58da8', 'user'),
(9, 'jovie', '2240ef71392026698809c0df09c4c694', 'user'),
(10, 'xhan', 'a5c04aec666f39aadce682eaae975cfc', 'user'),
(11, 'claud', '81eaa8c3e06ae27f7dddc9c03f4d4675', 'user'),
(20, 'kath', '6095c9e151f8d59cf6b2ee83a386e0bb', 'user'),
(21, 'hey', '6057f13c496ecf7fd777ceb9e79ae285', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_category`
--
ALTER TABLE `tb_category`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_item`
--
ALTER TABLE `tb_item`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_category` (`category`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_category`
--
ALTER TABLE `tb_category`
MODIFY `id` bigint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tb_item`
--
ALTER TABLE `tb_item`
MODIFY `id` bigint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
MODIFY `id` bigint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_item`
--
ALTER TABLE `tb_item`
ADD CONSTRAINT `fk_category` FOREIGN KEY (`category`) REFERENCES `tb_category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
