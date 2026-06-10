-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2026 at 01:43 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_keluhan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `respon`
--

CREATE TABLE `respon` (
  `id_respon` int(11) NOT NULL,
  `id_tiket` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `isi_respon` text NOT NULL,
  `peran` varchar(20) DEFAULT 'Admin',
  `visibility` varchar(20) DEFAULT 'Public',
  `tgl_respon` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `respon`
--

INSERT INTO `respon` (`id_respon`, `id_tiket`, `id_user`, `isi_respon`, `peran`, `visibility`, `tgl_respon`) VALUES
(5, 18, NULL, 'kkk', 'Admin', 'Public', '2026-04-29 08:19:06'),
(6, 18, NULL, 'apalahhh', 'Customer', 'Public', '2026-04-29 08:34:43'),
(7, 18, NULL, 'ajjhahh', 'Admin', 'Public', '2026-04-29 08:35:04'),
(10, 18, NULL, 'ppppp', 'Admin', 'Public', '2026-04-29 12:58:24'),
(11, 21, NULL, 'tolonggg yaa kakkk segeraaaa', 'Customer', 'Public', '2026-05-06 06:54:52'),
(12, 21, NULL, 'ditunggu', 'Customer', 'Public', '2026-05-06 06:55:41'),
(13, 21, NULL, 'kkk', 'Customer', 'Public', '2026-05-06 07:20:09'),
(14, 21, NULL, 'siapp done', 'Admin', 'Public', '2026-05-06 07:26:46'),
(15, 25, NULL, 'tunggi', 'Admin', 'Public', '2026-05-06 07:51:48'),
(16, 26, NULL, 'kenapaaa', 'Admin', 'Public', '2026-05-06 08:43:50'),
(17, 27, NULL, 'jdncbsbc', 'Customer', 'Public', '2026-05-06 08:47:52'),
(18, 29, NULL, 'jerep', 'Admin', 'Public', '2026-05-20 08:36:39'),
(19, 29, NULL, 'ditunggu', 'Admin', 'Public', '2026-05-20 08:36:51'),
(20, 29, NULL, 'siap', 'Customer', 'Public', '2026-05-20 08:37:17'),
(21, 29, NULL, 'segera', 'Customer', 'Public', '2026-05-20 08:38:42'),
(22, 29, NULL, 'kak', 'Customer', 'Public', '2026-05-20 08:42:48'),
(23, 28, NULL, 'u', 'Admin', 'Public', '2026-05-20 09:17:26'),
(24, 30, NULL, 'segara', 'Customer', 'Public', '2026-05-20 09:35:20'),
(25, 30, NULL, 'iya tunggu', 'Admin', 'Public', '2026-05-20 09:35:57'),
(26, 32, NULL, 'tlong segera di tindak lanjuti', 'Pelanggan', 'Public', '2026-06-09 22:17:17'),
(27, 32, NULL, 'mohon ditunggu', 'Admin', 'Public', '2026-06-09 22:46:18');

-- --------------------------------------------------------

--
-- Table structure for table `status_sla`
--

CREATE TABLE `status_sla` (
  `id_sla` int(11) NOT NULL,
  `id_tiket` int(11) NOT NULL,
  `waktu_maksimal` datetime NOT NULL,
  `waktu_respon_pertama` datetime DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `status_sla` varchar(20) DEFAULT 'Belum selesai',
  `dibuat` datetime DEFAULT current_timestamp(),
  `diubah` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_sla`
--

INSERT INTO `status_sla` (`id_sla`, `id_tiket`, `waktu_maksimal`, `waktu_respon_pertama`, `waktu_selesai`, `status_sla`, `dibuat`, `diubah`) VALUES
(5, 18, '2026-04-30 08:11:49', '2026-04-29 08:19:06', NULL, 'Belum selesai', '2026-04-29 08:11:49', '2026-04-29 08:19:06'),
(8, 21, '2026-05-07 06:53:55', '2026-05-06 07:26:46', NULL, 'Belum selesai', '2026-05-06 06:53:55', '2026-05-06 07:26:46'),
(9, 22, '2026-05-08 07:27:38', NULL, NULL, 'Belum selesai', '2026-05-06 07:27:38', NULL),
(11, 24, '2026-05-08 07:46:20', NULL, NULL, 'Belum selesai', '2026-05-06 07:46:20', NULL),
(12, 25, '2026-05-08 07:51:19', '2026-05-06 07:51:48', NULL, 'Belum selesai', '2026-05-06 07:51:19', '2026-05-06 07:51:48'),
(13, 26, '2026-05-08 08:37:44', '2026-05-06 08:43:50', NULL, 'Belum selesai', '2026-05-06 08:37:44', '2026-05-06 08:43:50'),
(14, 27, '2026-05-08 08:45:06', NULL, NULL, 'Belum selesai', '2026-05-06 08:45:06', NULL),
(15, 28, '2026-05-21 06:36:31', NULL, NULL, 'Belum selesai', '2026-05-20 06:36:31', NULL),
(16, 29, '2026-05-22 07:07:00', NULL, NULL, 'Belum selesai', '2026-05-20 07:07:00', NULL),
(17, 30, '2026-05-21 09:34:55', NULL, NULL, 'Belum selesai', '2026-05-20 09:34:55', NULL),
(18, 31, '2026-06-10 20:53:26', NULL, NULL, 'Belum selesai', '2026-06-09 20:53:26', NULL),
(19, 32, '2026-06-10 22:16:13', NULL, NULL, 'Belum selesai', '2026-06-09 22:16:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tiket_keluhan`
--

CREATE TABLE `tiket_keluhan` (
  `id_tiket` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `kategori` varchar(50) NOT NULL,
  `prioritas` varchar(20) DEFAULT 'Medium',
  `deskripsi` text NOT NULL,
  `status` varchar(20) DEFAULT 'Baru',
  `rating_kepuasan` tinyint(4) DEFAULT NULL,
  `tgl_keluhan` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tiket_keluhan`
--

INSERT INTO `tiket_keluhan` (`id_tiket`, `nama_pelanggan`, `email`, `no_hp`, `kategori`, `prioritas`, `deskripsi`, `status`, `rating_kepuasan`, `tgl_keluhan`) VALUES
(11, 'yaya', 'yaya@keluhan.com', NULL, 'Layanan', 'Low', 'aapapp', 'Selesai', 5, '2026-04-29 07:30:00'),
(18, 'yaya', 'yaya@keluhan.com', NULL, 'Billing', 'Medium', 'aapapp', 'Selesai', NULL, '2026-04-29 08:11:49'),
(21, 'yaya', 'yaya@keluhan.com', NULL, 'Billing', 'Medium', 'kurangg apaaa', 'Selesai', 5, '2026-05-06 06:53:55'),
(22, 'yaya', 'yaya@keluhan.com', NULL, 'Teknis', 'Low', 'eroor', 'Diproses', NULL, '2026-05-06 07:27:38'),
(24, 'naya', 'naya@keluhan.com', NULL, 'Teknis', 'Low', 'kurangg apaaa', 'Baru', NULL, '2026-05-06 07:46:20'),
(25, 'naya', 'naya@keluhan.com', NULL, 'Layanan', 'Low', 'kurangg apaaa', 'Baru', NULL, '2026-05-06 07:51:19'),
(26, 'yaya', 'yaya@keluhan.com', NULL, 'Produk', 'Low', 'pusingg kakak', 'Baru', NULL, '2026-05-06 08:37:44'),
(27, 'yaya', 'yaya@keluhan.com', NULL, 'Teknis', 'Low', 'eroor', 'Diproses', NULL, '2026-05-06 08:45:06'),
(28, 'bian', 'bian@gmail.com', NULL, 'Layanan', 'Medium', 'pusingg kakak', 'Baru', NULL, '2026-05-20 06:36:31'),
(29, 'bian', 'bian@gmail.com', NULL, 'Teknis', 'Low', 'eroor', 'Diproses', NULL, '2026-05-20 07:07:00'),
(30, 'bian', 'bian@gmail.com', NULL, 'Teknis', 'Medium', 'eroor', 'Menunggu', NULL, '2026-05-20 09:34:55'),
(31, 'vara', 'vara@gmail.com', NULL, 'Billing', 'Medium', 'tidak menerima struk', 'Baru', NULL, '2026-06-09 20:53:26'),
(32, 'celsi', 'celsi@gmail.com', NULL, 'Produk', 'Medium', 'Produk A kemarin banyak yang tidak sesuai', 'Selesai', NULL, '2026-06-09 22:16:13');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'CS',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'naya', 'naya@gmail.com', '$2b$10$B249ZQqZWyYgoFptdR25y.0I.g39zfDj/CoP3TVHkSMO6vQwppuGK', 'Admin', '2026-04-26 15:33:26'),
(2, 'admin', 'admin@keluhan.com', '$2b$10$LAWzh5iyE3JWLwSX5HmTwuS2YtLzX880osWLbGI76ifRoYdepco3K', 'Admin', '2026-04-26 18:00:37'),
(3, 'naya', 'naya@keluhan.com', '$2b$10$xGgAc/VEhW2GWDY/GKSTQ.3D7N90r/pHCx/avSWzTMaACmk/c9xvK', 'Pelanggan', '2026-04-26 20:50:03'),
(4, 'yaya', 'yaya@keluhan.com', '$2b$10$z/CslNScehcejEhZCR9KdejPyjRkDtWweKpvEPNPe7nXkz5uPO3tm', 'Pelanggan', '2026-04-29 07:22:49'),
(5, 'bian', 'bian@gmail.com', '$2b$10$3Y2KwLMCtP6o1s7V1bB3Mu7Eu4RogyLSaERMXVHNBecsQJPR8kG6K', 'Pelanggan', '2026-05-20 06:36:09'),
(6, 'vara', 'vara@gmail.com', '$2b$10$zmnKgxVQE3hw2CXaSOijwuRj2TR1XIRccgC91ng5berA2AYGFl6im', 'Pelanggan', '2026-06-09 20:47:37'),
(7, 'celsi', 'celsi@celsi.com', '$2b$10$9V6PfFHoAxM7UnC90sB0AusznvnMLEQtYx7TFhIlDzOrcd/UnU7LO', 'Pelanggan', '2026-06-09 22:04:39'),
(8, 'celsi', 'celsi@gmail.com', '$2b$10$3S6zPpmFkVBo7x650iCg1u3IfpbPQM7q43UHQP.3qHEQOCPtYevbG', 'Pelanggan', '2026-06-09 22:07:09'),
(9, 'nina', 'nina@gmail.com', '$2b$10$7uett57p4uppov1RGSRV4eWWT7BU1hE.z8rj90a0MdruCVhFjLAbq', 'Pelanggan', '2026-06-09 22:37:55'),
(10, 'celsi', 'celsi@gmailcom', '$2b$10$9ul6SbO4DorrNYRZUWNgHOe2cpQq1Zu1lpUiCr2atekq1Ue8qoZ6a', 'Pelanggan', '2026-06-10 00:24:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `respon`
--
ALTER TABLE `respon`
  ADD PRIMARY KEY (`id_respon`),
  ADD KEY `id_tiket` (`id_tiket`);

--
-- Indexes for table `status_sla`
--
ALTER TABLE `status_sla`
  ADD PRIMARY KEY (`id_sla`),
  ADD UNIQUE KEY `id_tiket` (`id_tiket`);

--
-- Indexes for table `tiket_keluhan`
--
ALTER TABLE `tiket_keluhan`
  ADD PRIMARY KEY (`id_tiket`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `respon`
--
ALTER TABLE `respon`
  MODIFY `id_respon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `status_sla`
--
ALTER TABLE `status_sla`
  MODIFY `id_sla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tiket_keluhan`
--
ALTER TABLE `tiket_keluhan`
  MODIFY `id_tiket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `respon`
--
ALTER TABLE `respon`
  ADD CONSTRAINT `respon_ibfk_1` FOREIGN KEY (`id_tiket`) REFERENCES `tiket_keluhan` (`id_tiket`) ON DELETE CASCADE;

--
-- Constraints for table `status_sla`
--
ALTER TABLE `status_sla`
  ADD CONSTRAINT `status_sla_ibfk_1` FOREIGN KEY (`id_tiket`) REFERENCES `tiket_keluhan` (`id_tiket`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
