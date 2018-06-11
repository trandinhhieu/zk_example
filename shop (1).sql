-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2018 at 08:34 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Pizza'),
(2, 'Mỳ Ý'),
(3, 'Cơm'),
(4, 'Thức Uống');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`order_id`, `product_id`, `quantity`, `price`) VALUES
(4, 5, 1, 50000),
(4, 6, 1, 40000),
(5, 1, 1, 99000),
(5, 4, 1, 79000),
(5, 5, 1, 50000),
(5, 6, 1, 40000),
(6, 6, 1, 40000),
(6, 7, 1, 85000),
(6, 13, 1, 25000),
(7, 5, 1, 50000),
(7, 6, 1, 40000),
(7, 7, 1, 85000),
(7, 8, 1, 65000),
(7, 9, 1, 80000),
(13, 3, 1, 80000),
(13, 4, 1, 79000),
(13, 6, 1, 40000),
(13, 7, 1, 85000),
(14, 1, 1, 99000),
(14, 7, 1, 85000),
(15, 1, 1, 99000),
(15, 4, 1, 79000),
(15, 5, 1, 50000),
(15, 6, 1, 40000);

--
-- Triggers `item`
--
DELIMITER $$
CREATE TRIGGER `tr_XoaCTHD` AFTER DELETE ON `item` FOR EACH ROW BEGIN
  Update product Set product.quantity = product.quantity - OLD.quantity
  Where product.id = OLD.product_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(500) NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `name`, `phone`, `address`, `note`, `created`, `status`, `user_id`) VALUES
(4, 'Trần Đình Hiếu', '01202401092', 'Đà Nẵng', 'Mua hàng online', '2018-04-22 14:08:35', 0, 1),
(5, 'Trần Đình Hiếu', '01673086935', 'HCM', 'Mua hàng online', '2018-04-22 14:15:14', 0, 4),
(6, 'Trần Văn Minh', '0985104821', 'Hà Nội', 'Mua hàng online', '2018-04-22 16:01:47', 0, 3),
(7, 'Trần Văn Minh', '0985104821', 'Hà Nội', 'Mua hàng online', '2018-04-22 16:08:51', 0, 3),
(13, 'Trần Đình Hiếu', '01673086935', 'Đà Nẵng', 'Mua hàng online', '2018-04-22 16:13:22', 0, 3),
(14, 'Trần Đình Hiếu', '01202401092', 'Đà Nẵng', 'không', '2018-04-22 20:32:59', 0, 1),
(15, 'Trần Văn Minh', '01673086935', 'Đà Nẵng', 'không có', '2018-04-25 00:44:08', 0, 1);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `before_product_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN

DECLARE productid_ INT(10);
DECLARE quantity_ INT(11);

SELECT DISTINCTROW
  i.product_id
INTO
  productid_
FROM
  item AS i
WHERE
  i.order_id = NEW.id;

SELECT DISTINCTROW
  i.quantity
INTO
  quantity_
FROM
  item AS i
WHERE
  i.order_id = NEW.id;

IF NEW.status=1 THEN
    update product 
            set product.quantity=product.quantity-quantity_ 
            where product.id=productid_;
END IF;
IF NEW.status=0 THEN
    update product 
            set product.quantity=product.quantity+quantity_ 
            where product.id=productid_;
END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(500) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `quantity` tinyint(3) NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `image`, `price`, `quantity`, `category_id`) VALUES
(1, 'Pizza thập cẩm cao cấp111', 'Pizza Thập Cẩm Cao Cấp với 9 loại nhân phủ: xúc xích, thịt nguội, thịt bò, xúc xích gà, thơm, nấm, hành tây, ớt chuông và ô liu', 'itm008270.jpg', 99000, 1, 1),
(3, 'Pizza Cơn Lốc Hải Sản', 'Pizza Cơn Lốc Hải Sản với mực, nghêu, thanh cua, thơm, ớt chuông xanh, hành tây trên nền sốt Thousand Islands và phô mai Mozzarella thượng hạng.', 'itm008270.jpg', 80000, 100, 1),
(4, 'Pizza Thập Cẩm', 'Pizza Thập Cẩm mang hương vị truyền thống với thịt bò, xúc xích, ớt chuông, nấm rơm và hành tây, phủ phô mai Mozzarella trứ danh', 'itm008270.jpg', 79000, 99, 1),
(5, 'Mỳ Ý Hải Sản Sốt Tiêu Đen', 'Mỳ Ý Hải Sản Sốt Tiêu Đen', 'FA21.png', 50000, 100, 2),
(6, 'Mỳ Ý Thịt Nguội Sốt Kem', 'Mỳ Ý Thịt Nguội Sốt Kem', 'FA23.png', 40000, 100, 2),
(7, 'Pizza Hải Sản Sốt Tiêu Đen', 'Pizza Hải Sản Sốt Tiêu Đen nổi tiếng với tôm, mực, thanh cua, hành tây phủ sốt tiêu đen thơm nồng và phô mai Mozzarella', '04.png', 85000, 100, 1),
(8, 'Pizza Thịt và Xúc Xích', 'Pizza Thịt và Xúc Xích thơm ngon và giàu protein với thịt muối, thịt bò, thịt nguội và xúc xích', '03.png', 65000, 100, 1),
(9, 'Pizza Cá Ngừ', 'Pizza Cá Ngừ mang hương vị biển cả nhẹ nhàng với cá ngừ, thanh cua, hành tây, thơm trên nền sốt Thousand Islands', '09.png', 80000, 100, 1),
(10, 'Pizza Gà Sốt Tiêu Đen', 'Thịt gà, Xúc Xích Gà, Nấm, Hành, Ớt Xanh, Phô mai Mozzarella', '07.png', 67000, 100, 1),
(11, 'Mỳ Ý Thịt Viên Trộn Sốt Cà Chua', 'Mỳ Ý Thịt Viên Trộn Sốt Cà Chua', 'FA22.png', 30000, 100, 2),
(12, 'Mỳ Ý Sốt Thịt Cà Chua', 'Mỳ Ý Sốt Thịt Cà Chua', 'FA17.png', 25000, 99, 1),
(13, 'Cơm Chiên Tỏi Và Cánh Gà Nướng', 'Cơm Chiên Tỏi Và Cánh Gà Nướng', 'GA09.png', 25000, 100, 3),
(14, 'Cơm Chiên Hải Sản', 'Cơm Chiên Hải Sản', 'GA08.png', 35000, 100, 3),
(15, 'Coca-Cola 330ml', 'Coca-Cola 330ml', 'NC27.png', 10000, 100, 4),
(16, 'Sprite 330ml', 'Sprite 330ml', 'NC29.png', 10000, 100, 4),
(17, 'Sprite 330ml', 'Sprite 330ml', 'NC29.png', 10000, 100, 4),
(18, 'Sprite 330ml', 'Sprite 330ml', 'NC29.png', 10000, 100, 4),
(19, 'Mỳ Ý Hải Sản Sốt Tiêu Đen', 'Mỳ Ý Hải Sản Sốt Tiêu Đen', 'FA21.png', 50000, 100, 2),
(20, 'Pizza Cơn Lốc Hải Sản', 'Pizza Cơn Lốc Hải Sản với mực, nghêu, thanh cua, thơm, ớt chuông xanh, hành tây trên nền sốt Thousand Islands và phô mai Mozzarella thượng hạng.', 'itm008270.jpg', 80000, 100, 1);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_CUSTOMER'),
(3, 'ROLE_MOD');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`) VALUES
(1, 'Trần Đình Hiếu', 'admin', '$2a$10$8U9yUNDlICcE5mElr608w.edv9F2yVQW0Yf2bmhisowGcLbGoJEaS'),
(3, 'Văn Minh', 'vanminh', '$2a$10$8U9yUNDlICcE5mElr608w.edv9F2yVQW0Yf2bmhisowGcLbGoJEaS'),
(4, 'Trần Minh Quang', 'minhquang', '$2a$10$8U9yUNDlICcE5mElr608w.edv9F2yVQW0Yf2bmhisowGcLbGoJEaS');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(1, 1),
(3, 2),
(4, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
