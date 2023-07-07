-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2023 at 11:42 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mephx_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `visibility` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `image`, `visibility`) VALUES
(14, 'Nikifilni', '/assets/uploads/brand/54fdc19653273.62fceb26572d6.jpg', 1),
(15, 'EMP', '/assets/uploads/brand/Rockhand.png', 1),
(16, 'Crunchyroll', '/assets/uploads/brand/crunchyroll-logo-ED92B45335-seeklogo.com.png', 1),
(17, 'Mandarake', '/assets/uploads/brand/R.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_checked_out` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `created_at`, `modified_at`, `is_checked_out`, `user_id`) VALUES
(32, '2023-05-06 09:34:22', '2023-05-06 09:34:22', 0, 24);

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `item_total` decimal(10,2) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  `size` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `visibility` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `visibility`) VALUES
(15, 'Unisex', 'Designed to be suitable for both sexes.', 1),
(16, 'Men', 'For men.', 1),
(17, 'Women', 'For women.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `is_delivered` tinyint(1) NOT NULL DEFAULT 0,
  `order_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `color` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `size` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`images`)),
  `description` text DEFAULT NULL,
  `reviews` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `visibility` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `rating`, `color`, `size`, `quantity`, `images`, `description`, `reviews`, `brand_id`, `category_id`, `created_at`, `visibility`) VALUES
(45, 'Orochimaru hoodie', '15000.00', 1, '[\"Purple\", \"white\", \"black\", \"brown\"]', '[\"S\", \"M\", \"L\"]', 57, '[\"/assets/uploads/products/IMG_0515.JPG\", \"/assets/uploads/products/IMG_0516.JPG\"]', 'Introducing our exclusive Orochimaru hoodie, perfect for fans of the popular anime and manga series, Naruto! This black hoodie features a stunning print of Orochimaru, one of the most iconic and recognizable characters in the series. The high-quality print captures Orochimaru\'s distinctive snake-like features and imposing presence, making this hoodie a must-have for any Naruto enthusiast.\r\n\r\nMade from a soft and comfortable material, this hoodie is perfect for everyday wear or cosplay events. It features a classic fit with a drawstring hood, ribbed cuffs and hem, and a front pouch pocket, providing both comfort and functionality. The print itself is bold and vibrant, with intricate details that make it stand out from other Naruto merchandise.\r\n\r\nOur Orochimaru hoodie is available in a range of sizes to fit both men and women, and is designed to be long-lasting and durable. It is also machine washable for easy care and maintenance, ensuring that you can enjoy wearing it for years to come.\r\n\r\n', 930, 14, 15, '2023-05-06 10:02:11', 1),
(46, 'Orochimaru Jutsu hoodie', '11500.00', 0, '[\"Black\", \"Blue\", \"White\", \"Purple\"]', '[\"S\", \"M\", \"XL\"]', 32, '[\"/assets/uploads/products/IMG_0505.JPG\", \"/assets/uploads/products/IMG_0509.JPG\", \"/assets/uploads/products/IMG_0506.JPG\", \"/assets/uploads/products/IMG_0508.JPG\", \"/assets/uploads/products/IMG_0507.JPG\"]', 'Introducing our exclusive Orochimaru hoodie, perfect for fans of the popular anime and manga series, Naruto! This black hoodie features a stunning print of Orochimaru, one of the most iconic and recognizable characters in the series. The high-quality print captures Orochimaru\'s distinctive snake-like features and imposing presence, making this hoodie a must-have for any Naruto enthusiast.\r\n\r\nMade from a soft and comfortable material, this hoodie is perfect for everyday wear or cosplay events. It features a classic fit with a drawstring hood, ribbed cuffs and hem, and a front pouch pocket, providing both comfort and functionality. The print itself is bold and vibrant, with intricate details that make it stand out from other Naruto merchandise.\r\n\r\nOur Orochimaru hoodie is available in a range of sizes to fit both men and women, and is designed to be long-lasting and durable. It is also machine washable for easy care and maintenance, ensuring that you can enjoy wearing it for years to come.\r\n\r\n', 52, 14, 15, '2023-05-06 10:06:44', 1),
(47, 'Itsuki Tee', '8000.00', 2, '[\"White\"]', '[\"L\", \"XL\"]', 40, '[\"/assets/uploads/products/IMG_0510.JPG\", \"/assets/uploads/products/IMG_0511.JPG\", \"/assets/uploads/products/IMG_0512.JPG\", \"/assets/uploads/products/IMG_0513.JPG\"]', 'Introducing our latest addition to the anime-inspired collection - the Itsuki T-shirt! This stylish and comfortable tee features a vibrant print of Itsuki Nakano, one of the quintessential main characters from the popular manga and anime series \"The Quintessential Quintuplets\".\r\n\r\nCrafted from soft and breathable fabric, this tee is perfect for everyday wear, whether you\'re lounging at home or hitting the town. The graphic print of Itsuki Nakano adds a pop of color and personality to your wardrobe, showcasing your love for this beloved anime series.', 950, 14, 15, '2023-05-06 10:30:18', 1),
(48, 'Zenitsu Hoddie', '13000.00', 3, '[\"Black\", \"Blue\", \"White\"]', '[\"S\", \"L\", \"XL\"]', 55, '[\"/assets/uploads/products/IMG_0476.JPG\", \"/assets/uploads/products/IMG_0478.JPG\", \"/assets/uploads/products/IMG_0480.JPG\", \"/assets/uploads/products/IMG_0479.JPG\", \"/assets/uploads/products/IMG_0477.JPG\"]', 'Introducing our stylish hoodie featuring the popular anime character, Zenitsu Agatsuma! This cozy and comfortable hoodie is perfect for fans of the hit series, \"Demon Slayer: Kimetsu no Yaiba\".\r\n\r\nThe hoodie is made from a soft and breathable material that will keep you warm and comfortable in any season. The front of the hoodie features a high-quality print of Zenitsu, one of the most beloved characters from the series, in his iconic yellow and black uniform.\r\n\r\nThe design of the hoodie also incorporates various elements from the series, such as the Japanese kanji symbol for thunder, which is closely associated with Zenitsu and his abilities.\r\n\r\n', 609, 14, 15, '2023-05-06 10:23:47', 1),
(49, 'Bleach Summer Set', '15000.00', 2, '[\"White\", \"Black\", \"Gray\"]', '[\"S\", \"M\", \"L\"]', 47, '[\"/assets/uploads/products/IMG_0406.JPG\", \"/assets/uploads/products/IMG_0407.JPG\", \"/assets/uploads/products/IMG_0408.JPG\"]', 'Introducing our Bleach anime-inspired shorts and tee set, perfect for fans of the popular manga and anime series! This stylish and comfortable set is made from high-quality materials and features vibrant, full-color prints of some of your favorite Bleach characters.\r\n\r\nThe shorts are designed with a relaxed fit and an elastic waistband for maximum comfort, while the tee is made from soft and breathable cotton for a comfortable, all-day wear. Both pieces feature bold and eye-catching graphics, including iconic characters like Ichigo Kurosaki, Rukia Kuchiki, and Byakuya Kuchiki, as well as the iconic Bleach logo.', 192, 14, 16, '2023-05-06 10:37:26', 1),
(50, 'Bleach Winter Set', '18000.00', 2, '[\"White\", \"Black\"]', '[\"S\", \"M\"]', 20, '[\"/assets/uploads/products/IMG_0400.JPG\", \"/assets/uploads/products/IMG_0401.JPG\", \"/assets/uploads/products/IMG_0402.JPG\"]', 'Introducing our exclusive track and tee set featuring characters from the popular anime series Bleach! This stylish and comfortable set is perfect for fans of the series who want to show off their love for their favorite characters.\r\n\r\nThe set includes a pair of track pants and a matching t-shirt, both made from high-quality materials that are soft, breathable, and durable. The pants have an adjustable waistband and tapered leg for a comfortable and flattering fit, while the t-shirt features a classic crew neck design and short sleeves.\r\n\r\n', 310, 14, 17, '2023-05-06 10:43:14', 1),
(51, 'Bleach Over-Sized Tee', '15000.00', 4, '[\"Black\", \"White\", \"Brown\"]', '[\"2xl\"]', 30, '[\"/assets/uploads/products/IMG_0403.JPG\", \"/assets/uploads/products/IMG_0404.JPG\", \"/assets/uploads/products/IMG_0405.JPG\"]', 'Introducing our latest addition to our anime collection - an oversized tee featuring characters from the popular anime series, Bleach! This eye-catching tee is perfect for Bleach fans who want to show off their love for the series while staying comfortable and stylish.\r\n\r\nThe tee is made from high-quality cotton material that is soft to the touch and comfortable to wear. The oversized fit is designed to be loose and relaxed, making it the perfect choice for casual wear or lounging at home.\r\n\r\nThe Bleach anime print on the front of the tee showcases some of the most iconic characters from the series, including Ichigo Kurosaki, Rukia Kuchiki, and more. The print is bold and vivid, with intricate detailing that captures the essence of the characters and their unique personalities.', 894, 14, 15, '2023-05-06 10:47:36', 1),
(52, 'Death Note Hoodie', '13000.00', 1, '[\"Black\", \"Brown\", \"White\", \"Gray\"]', '[\"XS\", \"S\", \"M\"]', 23, '[\"/assets/uploads/products/IMG_0411.JPG\", \"/assets/uploads/products/IMG_0412.JPG\", \"/assets/uploads/products/IMG_0413.JPG\", \"/assets/uploads/products/IMG_0414.JPG\", \"/assets/uploads/products/IMG_0415.JPG\", \"/assets/uploads/products/IMG_0416.JPG\"]', 'Introducing our Death Note anime hoodie, the perfect addition to any anime fan\'s wardrobe! This comfortable and stylish hoodie is made from soft and cozy material that is perfect for cooler weather or just lounging around at home.\r\n\r\nFeaturing an eye-catching print of the iconic Death Note anime, this hoodie showcases a range of memorable characters such as Light Yagami, L, and Ryuk. The print is high-quality and durable, ensuring that it will last for many wears and washes to come.\r\n\r\nThe hoodie also includes a variety of design elements that add to its overall appeal. With a drawstring hood, ribbed cuffs, and a front pouch pocket, this hoodie is as functional as it is fashionable. It comes in a range of sizes to fit a variety of body types, ensuring that anyone can show off their love for Death Note with this hoodie.', 846, 14, 17, '2023-05-07 08:36:57', 1),
(53, 'Ichigo Hoodie', '14000.00', 3, '[\"Black\", \"White\", \"Blue\", \"Green\"]', '[\"M\", \"L\", \"XL\"]', 45, '[\"/assets/uploads/products/IMG_0441.JPG\", \"/assets/uploads/products/IMG_0442.JPG\", \"/assets/uploads/products/IMG_0443.JPG\", \"/assets/uploads/products/IMG_0444.JPG\", \"/assets/uploads/products/IMG_0445.JPG\", \"/assets/uploads/products/IMG_0446.JPG\"]', 'Introducing our stylish hoodie featuring Ichigo, the beloved protagonist from the popular anime and manga series \"Bleach\". This hoodie is the perfect addition to any anime fan\'s wardrobe, providing a comfortable and fashionable way to show off your love for the series.\r\n\r\nThe hoodie is made from a soft and cozy material, ensuring that you stay warm and comfortable while sporting your favorite anime character. The design features a high-quality print of Ichigo, showcasing his iconic black and orange attire and striking sword.\r\n\r\nThe hoodie is available in a variety of sizes, making it a great gift for yourself or any Bleach fan in your life. With its sleek and versatile design, it can be worn with anything from jeans to sweatpants.', 743, 14, 15, '2023-05-07 08:40:26', 1),
(54, 'Pikachu Rocks Sneakers High by Pokemon', '20000.00', 3, '[\"Black\"]', '[\"37\", \"38\", \"39\", \"40\"]', 50, '[\"/assets/uploads/products/asset 2.jpeg\", \"/assets/uploads/products/asset 3.jpeg\", \"/assets/uploads/products/asset 4.jpeg\", \"/assets/uploads/products/asset 5.jpeg\", \"/assets/uploads/products/asset 6.jpeg\", \"/assets/uploads/products/asset 7.jpeg\", \"/assets/uploads/products/asset 8.jpeg\"]', 'Introducing the Pikachu Rocks Sneakers by Pokemon! These high-top sneakers are a must-have for any fan of the iconic yellow electric-type Pokemon.\r\n\r\nFeaturing a vibrant and colorful design with a mix of bright yellow, black, and red tones, these sneakers showcase a fun and playful aesthetic that is sure to turn heads. The Pikachu character is prominently displayed on the side of the shoe, surrounded by lightning bolts and other graphic elements that evoke the high-energy and excitement of the PokÃÂÃÂ©mon world.\r\n\r\nCrafted from high-quality materials, these sneakers are both comfortable and durable, with a sturdy rubber sole that provides excellent traction and support. The lace-up design allows for a secure and adjustable fit, while the padded collar and tongue provide additional comfort and cushioning.', 27, 15, 17, '2023-05-07 08:57:17', 1),
(55, 'Pikachu Old School  Bomber Jacket black', '16000.00', 4, '[\"Black\", \"Blue\", \"Gray\", \"Blue\"]', '[\"M\", \"L\", \"XL\"]', 55, '[\"/assets/uploads/products/aksdjfbcxnakjhdfgbdns.jpeg\", \"/assets/uploads/products/dksjvadehbic bgv.jpeg\", \"/assets/uploads/products/pqalzkmxiwedjf.jpeg\", \"/assets/uploads/products/skjdbvajv.jpeg\", \"/assets/uploads/products/tyrueiwoqakmzncb.jpeg\"]', 'Introducing our \"Pikachu - Old School Style\" Bomber Jacket in black, perfect for fans of the classic Pokemon character and retro fashion. This bomber jacket features a unique design of Pikachu in an old school style, with a bright yellow and black color scheme that makes it stand out from other jackets.\r\n\r\nMade from high-quality materials, this jacket is comfortable and durable, perfect for everyday wear. The front zip closure and ribbed cuffs and hem ensure a snug fit, while the two side pockets provide ample space for storing your essentials.\r\n\r\nThe Pikachu - Old School Style Bomber Jacket is not just stylish, but also practical. It\'s perfect for layering over your favorite outfits during colder weather, or for adding a pop of color to your look. The black color of the jacket also makes it versatile, easy to pair with other clothing items.', 122, 15, 16, '2023-05-07 09:02:13', 1),
(56, 'Z - Vegeta Saiyan Pyjama', '8000.00', 2, '[\"Black\", \"Gray\", \"Blue\"]', '[\"S\", \"L\"]', 34, '[\"/assets/uploads/products/aasset3ssetasset33.jpeg\", \"/assets/uploads/products/asasset3setasset34.jpeg\", \"/assets/uploads/products/assetasset3asset35.jpeg\", \"/assets/uploads/products/assetasset22.jpeg\"]', 'Introducing our Z - Vegeta Saiyan Pyjama in black, the ultimate sleepwear for Dragon Ball Z fans! Made from high-quality materials, this pyjama set is comfortable and durable, ensuring a good night\'s sleep every time you wear it.\r\n\r\nThe top features an image of Vegeta, the proud Saiyan prince, in his signature fighting stance, with the iconic \"Z\" logo in the background. The top also has long sleeves and a crew neck for added warmth and comfort.\r\n\r\nThe matching black pyjama pants feature a subtle, all-over print of Vegeta\'s face and the \"Z\" logo, adding a touch of style to this classic sleepwear set. The pants also have an elastic waistband with a drawstring, ensuring a comfortable and secure fit.', 39, 15, 16, '2023-05-07 09:06:36', 1),
(57, 'Akatsuki Christmas jumper black by Naruto', '10000.00', 0, '[\"Red\", \"Black\"]', '[\"M\", \"L\", \"XL\"]', 56, '[\"/assets/uploads/products/asasset6et6.jpeg\", \"/assets/uploads/products/asasset6set3.jpeg\", \"/assets/uploads/products/assasset6etasset62.jpeg\", \"/assets/uploads/products/asseasset6asset6asset6t5.jpeg\", \"/assets/uploads/products/asset6asset6asset6.jpeg\"]', 'Introducing the \"Akatsuki\" Christmas jumper by Naruto, the perfect addition to your holiday wardrobe! This black jumper features the iconic red cloud symbol of the infamous Akatsuki organization, known for their villainous deeds in the popular anime and manga series.\r\n\r\nThe jumper is made from high-quality, soft material that will keep you warm and comfortable during the colder months. The design features a festive twist with snowflakes and a \"Merry Christmas\" message written in bold white letters, making it a great choice for any holiday gathering.\r\n\r\nThe \"Akatsuki\" Christmas jumper is available in a range of sizes to ensure the perfect fit for anyone, and the unisex design makes it a versatile option for all Naruto fans. It\'s a great gift idea for your friends or loved ones who are fans of the series, or even as a treat for yourself!\r\n\r\n', 269, 15, 16, '2023-05-07 09:11:11', 1),
(58, 'Demon Slayer Tanjiro & Nezuko T-Shirt', '7000.00', 4, '[\"White\", \"Green\", \"Blue\"]', '[\"S\", \"M\", \"L\"]', 44, '[\"/assets/uploads/products/13389604_av1.jpeg\", \"/assets/uploads/products/13389604_hi.jpeg\"]', 'Introducing our Demon Slayer Tanjiro & Nezuko Boyfriend Fit Girls T-Shirt! This stylish and comfortable t-shirt features two of the main characters from the hit anime and manga series, Tanjiro and Nezuko, in a unique and eye-catching design.\r\n\r\nMade from soft and breathable fabric, this t-shirt is designed for a comfortable and relaxed fit that\'s perfect for everyday wear. The boyfriend fit style is flattering and versatile, making it easy to pair with jeans, shorts, or leggings for a casual and effortless look.\r\n\r\nThe front of the t-shirt features an intricate graphic design of Tanjiro and Nezuko, surrounded by a beautiful floral motif. The bold and vibrant colors of the design make it stand out and are sure to catch the attention of fellow Demon Slayer fans.\r\n\r\n', 161, 15, 17, '2023-05-07 09:35:32', 1),
(59, 'Sailor Moon Wink T-Shirt', '9000.00', 4, '[\"Black\", \"Yellow\", \"Blue\"]', '[\"S\", \"M\"]', 66, '[\"/assets/uploads/products/18866543_av1.jpeg\", \"/assets/uploads/products/18866543_hi.jpeg\"]', 'Introducing the Sailor Moon Wink Boyfriend Fit Girls T-Shirt, the perfect addition to any Sailor Moon fan\'s wardrobe! This stylish and comfortable t-shirt features a classic black background with a fun and playful graphic design.\r\n\r\nThe front of the shirt showcases the iconic Sailor Moon winking and holding up her peace sign, surrounded by a bold and colorful geometric design. The vibrant pink, blue, and yellow colors are sure to turn heads and show off your love for the beloved anime series.\r\n\r\nThe shirt is made from high-quality, soft and breathable cotton, making it comfortable to wear all day long. The relaxed, boyfriend fit provides a casual and stylish look that is perfect for any occasion, from a day out with friends to a Sailor Moon cosplay event.', 399, 15, 17, '2023-05-07 09:38:37', 1),
(60, 'Copy Ninja Hoodie', '18000.00', 0, '[\"Black\", \"Gray\", \"Red\"]', '[\"M\", \"L\", \"XL\"]', 43, '[\"/assets/uploads/products/assetasdfsd1.jpeg\", \"/assets/uploads/products/assetssetasdfsd2.jpeg\", \"/assets/uploads/products/assssetasdfsd3.jpeg\", \"/assets/uploads/products/assssetasdfsdetssetasdfsd4.jpeg\", \"/assets/uploads/products/ssetasdfsdssetasdfsdssetasdfsd.jpeg\"]', 'Introducing our Copy Ninja Hoodie, inspired by the iconic character Kakashi Hatake from the popular anime and manga series, Naruto. This hoodie is perfect for fans of the series, as well as anyone who appreciates a cool and stylish piece of clothing.\r\n\r\nMade from high-quality materials, this hoodie is both soft and durable, providing maximum comfort and long-lasting wear. The design features a bold graphic of Kakashi Hatake\'s signature mask, with the words \"Copy Ninja\" emblazoned in Japanese kanji characters.', 471, 14, 16, '2023-05-07 09:45:19', 1),
(61, 'Hokage Hoodie', '12000.00', 0, '[\"Black\", \"Red\", \"Gray\"]', '[\"S\", \"M\", \"L\"]', 34, '[\"/assets/uploads/products/asdijbvkkczx.jpeg\", \"/assets/uploads/products/assetascdvdf2.jpeg\", \"/assets/uploads/products/dskjfv.jpeg\", \"/assets/uploads/products/ksdjahbv.jpeg\", \"/assets/uploads/products/tyrueiwsjdchbv.jpeg\"]', 'Introducing our exclusive Hokage Hoodie, the ultimate tribute to the iconic anime and manga series, Naruto. Made from a soft and comfortable cotton blend, this hoodie features a striking design that pays homage to the legendary Hokage of the Hidden Leaf Village.\r\n\r\nWith a bold and eye-catching print of the iconic Hokage emblem on the back, and the word \"Hokage\" emblazoned across the chest, this hoodie is the perfect way to show off your love for the series and its characters. The black color of the hoodie provides a sleek and stylish look, while the high-quality material ensures long-lasting comfort and durability.\r\n\r\nThe hoodie also features a spacious front pouch pocket, perfect for storing your phone, wallet, or other small items while on the go. And with its adjustable drawstring hood and ribbed cuffs and hem, this hoodie provides a comfortable and snug fit, making it the ideal choice for everyday wear or cosplay.\r\n\r\n', 623, 16, 16, '2023-05-07 10:27:10', 1),
(62, 'VINTAGE KQ BEIGE Hoodie', '12000.00', 0, '[\"Brown\", \"Black\", \"Gray\"]', '[\"S\", \"M\", \"L\", \"XL\"]', 12, '[\"/assets/uploads/products/asasdfd0tasdfd03.jpeg\", \"/assets/uploads/products/asdasdfd0fd0.jpeg\", \"/assets/uploads/products/asdfd0asdfd0asdfd0.jpeg\", \"/assets/uploads/products/asdfd0asdfd0asdfd0asdfd0.jpeg\", \"/assets/uploads/products/assetasvfdbvasdfd04.jpeg\"]', 'Introducing the Vintage KQ Beige Hoodie, a stylish and comfortable addition to your wardrobe that\'s perfect for casual wear or lounging at home. Made from high-quality materials, this hoodie is designed to last and features a classic vintage look that never goes out of style.\r\n\r\nThe beige color of this hoodie is warm and inviting, adding a touch of sophistication to any outfit. The vintage KQ logo on the front adds a nostalgic element, harkening back to the brand\'s roots and giving the hoodie a unique and distinctive look.\r\n\r\nThis hoodie is made from a soft and comfortable fabric that feels great against your skin. The material is also durable, so you can wear it for years to come. The ribbed cuffs and waistband provide a snug fit, while the drawstring hood adds an extra layer of warmth when you need it.', 376, 16, 16, '2023-05-07 10:33:51', 1),
(63, ' HYUGA TALES', '12000.00', 1, '[\"Purple\", \"White\", \"Blue\"]', '[\"L\", \"XL\"]', 34, '[\"/assets/uploads/products/advff0.jpeg\", \"/assets/uploads/products/advff0advff0.jpeg\", \"/assets/uploads/products/advff0advff0advff0.jpeg\"]', '\r\nIntroducing the Vintage KQ Beige Hoodie, a stylish and comfortable addition to your wardrobe that\'s perfect for casual wear or lounging at home. Made from high-quality materials, this hoodie is designed to last and features a classic vintage look that never goes out of style.\r\n\r\nThe beige color of this hoodie is warm and inviting, adding a touch of sophistication to any outfit. The vintage KQ logo on the front adds a nostalgic element, harkening back to the brand\'s roots and giving the hoodie a unique and distinctive look.\r\n\r\nThis hoodie is made from a soft and comfortable fabric that feels great against your skin. The material is also durable, so you can wear it for years to come. The ribbed cuffs and waistband provide a snug fit, while the drawstring hood adds an extra layer of warmth when you need it.', 709, 16, 17, '2023-05-07 17:14:11', 1),
(64, 'Base Hoodie', '12000.00', 2, '[\"Brown\", \"Pink\", \"Black\", \"Gray\"]', '[\"XL\"]', 33, '[\"/assets/uploads/products/aasdse04.jpeg\", \"/assets/uploads/products/adsfdsasdse0..jpeg\", \"/assets/uploads/products/asdse0.jpeg\", \"/assets/uploads/products/asdse0asdse0.jpeg\", \"/assets/uploads/products/assetdiscnfdj6.jpeg\", \"/assets/uploads/products/djkshvbaljhdsbd.jpeg\"]', '\r\nIntroducing the Vintage KQ Beige Hoodie, a stylish and comfortable addition to your wardrobe that\'s perfect for casual wear or lounging at home. Made from high-quality materials, this hoodie is designed to last and features a classic vintage look that never goes out of style.\r\n\r\nThe beige color of this hoodie is warm and inviting, adding a touch of sophistication to any outfit. The vintage KQ logo on the front adds a nostalgic element, harkening back to the brand\'s roots and giving the hoodie a unique and distinctive look.\r\n\r\nThis hoodie is made from a soft and comfortable fabric that feels great against your skin. The material is also durable, so you can wear it for years to come. The ribbed cuffs and waistband provide a snug fit, while the drawstring hood adds an extra layer of warmth when you need it.', 476, 16, 16, '2023-05-07 17:40:38', 1),
(65, 'Obito Hoodie', '12000.00', 2, '[\"Black\", \"Blue\"]', '[\"S\", \"L\"]', 45, '[\"/assets/uploads/products/ghtnhbgvfcd.webp\", \"/assets/uploads/products/jnyhbgvfd.webp\", \"/assets/uploads/products/poiuytre.jpeg\", \"/assets/uploads/products/sdfg.jpeg\", \"/assets/uploads/products/sdfggfd.webp\"]', '\r\nIntroducing the Vintage KQ Beige Hoodie, a stylish and comfortable addition to your wardrobe that\'s perfect for casual wear or lounging at home. Made from high-quality materials, this hoodie is designed to last and features a classic vintage look that never goes out of style.\r\n\r\nThe beige color of this hoodie is warm and inviting, adding a touch of sophistication to any outfit. The vintage KQ logo on the front adds a nostalgic element, harkening back to the brand\'s roots and giving the hoodie a unique and distinctive look.\r\n\r\nThis hoodie is made from a soft and comfortable fabric that feels great against your skin. The material is also durable, so you can wear it for years to come. The ribbed cuffs and waistband provide a snug fit, while the drawstring hood adds an extra layer of warmth when you need it.', 143, 17, 17, '2023-05-07 17:56:56', 1),
(66, 'Otaku UNIVERSITY BLC Hoodie', '12000.00', 2, '[\"Black\", \"Red\", \"Blue\"]', '[\"S\", \"XL\"]', 34, '[\"/assets/uploads/products/098sdvf.jpeg\", \"/assets/uploads/products/cvdfsgh.jpeg\", \"/assets/uploads/products/fdsc.jpeg\", \"/assets/uploads/products/oqakmziwdjcbuehf.jpeg\"]', '\r\nIntroducing the Vintage KQ Beige Hoodie, a stylish and comfortable addition to your wardrobe that\'s perfect for casual wear or lounging at home. Made from high-quality materials, this hoodie is designed to last and features a classic vintage look that never goes out of style.\r\n\r\nThe beige color of this hoodie is warm and inviting, adding a touch of sophistication to any outfit. The vintage KQ logo on the front adds a nostalgic element, harkening back to the brand\'s roots and giving the hoodie a unique and distinctive look.\r\n\r\nThis hoodie is made from a soft and comfortable fabric that feels great against your skin. The material is also durable, so you can wear it for years to come. The ribbed cuffs and waistband provide a snug fit, while the drawstring hood adds an extra layer of warmth when you need it.', 938, 17, 15, '2023-05-07 18:11:53', 1),
(67, 'SUIT CUSTOM / DEATHWISH 02', '18000.00', 2, '[\"Red\", \"Pink\"]', '[\"M\"]', 45, '[\"/assets/uploads/products/657483euhf.jpeg\", \"/assets/uploads/products/iwedhfdjs.jpeg\", \"/assets/uploads/products/jhscdjnkxdk.jpeg\", \"/assets/uploads/products/ljsdvba.jpeg\", \"/assets/uploads/products/yu4i32kqmncvbew.jpeg\"]', 'Oversized custom suit consisting of a T-shirt and shorts with cut-off edges dedicated to \"Darling in Franxx\" and \"Hellsing\". Made from 95% cotton and 5% lycra in dusty pink colors.\r\nOversized T-shirt has two decorative patches made by hand, prints are made with DTF printing technology.\r\nShorts contain three spacious pockets and an adjustable drawstring at the waist.\r\n\r\nThe fabric is dyed using acrylic paints, giving each item a unique look. The costume you receive may have slight differences from the samples shown in the photographs.', 703, 17, 17, '2023-05-07 18:22:18', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(35) NOT NULL,
  `last_name` varchar(35) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` enum('male','female','other') DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `profile_picture` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `phone` bigint(10) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `date_of_birth`, `sex`, `email`, `password`, `address`, `profile_picture`, `role`, `phone`, `is_active`) VALUES
(24, 'Admin', 'Admin', '1111-11-11', 'other', 'admin@admin.com', '$2a$12$qnjahsK4wlyE0sNabGyLMe7AZ9FNPfKxnXTmkGT1OAYnNduT1/RZC', 'Asgard', '/assets/uploads/wallpaperss.png', 'admin', 9999999999, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `product_ibfk_1` (`category_id`),
  ADD KEY `product_ibfk_2` (`brand_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
