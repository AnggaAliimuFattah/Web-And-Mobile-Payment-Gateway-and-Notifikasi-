-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 19, 2025 at 09:05 PM
-- Server version: 10.6.22-MariaDB-cll-lve
-- PHP Version: 8.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tesg1162_payment`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `data_siswa`
--

CREATE TABLE `data_siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `nis` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `kelas` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_telp` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(255) NOT NULL,
  `agama` varchar(255) NOT NULL,
  `tempat_lahir` varchar(255) NOT NULL,
  `tahun` varchar(250) NOT NULL DEFAULT '2025',
  `tanggal_lahir` date NOT NULL,
  `nama_ayah` varchar(255) NOT NULL,
  `pekerjaan_ayah` varchar(255) NOT NULL,
  `nama_ibu` varchar(255) NOT NULL,
  `pekerjaan_ibu` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `status2` varchar(250) DEFAULT NULL,
  `status3` varchar(250) DEFAULT 'Register',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_siswa`
--

INSERT INTO `data_siswa` (`id`, `uuid`, `nis`, `nama`, `kelas`, `alamat`, `no_telp`, `jenis_kelamin`, `agama`, `tempat_lahir`, `tahun`, `tanggal_lahir`, `nama_ayah`, `pekerjaan_ayah`, `nama_ibu`, `pekerjaan_ibu`, `status`, `status2`, `status3`, `username`, `password`, `foto`, `created_at`, `updated_at`) VALUES
(43, '2e6c96ff-8223-48a9-92eb-dc9163945346', '2554', 'Kasni', 'X', 'aaaaaaaaaaaaaaaaaaaa', '082153198306', 'Laki-laki', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaaaaaaa', 'aaaaaaaa', 'aaaaaa', 'aaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '2554', '$2y$12$ro0VC8PkeF2Rh9v718vSyuZwk0GYAofcNnkpxtnvlJaD5SK/EhVwa', '/private/1755524495.jpg', '2025-08-18 06:41:35', '2025-08-18 06:41:35'),
(44, 'bd9e76f6-91f2-48d2-a441-dba23c7ac3d1', '2814', 'Fibri', 'X', 'aaaaaaaaaaaaaaaaaaaa', '087781350108', 'Perempuan', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaaaa', 'aaaaaaaa', 'aaaaaaa', 'aaaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '2814', '$2y$12$nsTnQcVslDSaDIU3nVMTOexe0B9EwTqYCjy6P47XNA9bRipw3Yl3a', '/private/1755524597.jpg', '2025-08-18 06:43:17', '2025-08-18 06:43:17'),
(45, 'ab84316d-1ef7-4990-b671-0e688f678913', '2704', 'nila', 'X', 'aaaaaaaaaaaaa', '081225899623', 'Perempuan', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaaaaaa', 'aaaaaa', 'aaaaaa', 'aaaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '2704', '$2y$12$Y0I7Z1LaGI9r.blufb6hbenjN2IHz.UPBl0C8R0AVZP9Gi1LFJAo.', '/private/1755524713.jpg', '2025-08-18 06:45:14', '2025-08-18 06:45:14'),
(46, '6c452bc5-6697-4b10-a339-99b2997ea69a', '9809', 'Agni', 'X', 'aaaaa', '085386423795', 'Laki-laki', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaa', 'aaaaa', 'aaaaaaaaaa', 'aaaaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '9809', '$2y$12$WPmd8zq5roHiyu3OdK4sdO5sL6CXfdmzk8AIawzvxSJMf8L0GBC6a', '/private/1755524825.jpg', '2025-08-18 06:47:06', '2025-08-18 06:47:06'),
(47, 'b3bee296-295e-437d-94a4-d0639bc49058', '9942', 'Huda', 'X', 'aaaaaaaaaaaaaa', '085695036401', 'Laki-laki', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaaaaaa', 'aaaaaaaaaa', 'aaaaaaaaaa', 'aaaaaaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '9942', '$2y$12$tBYEq2Z0k9UxW49RxEEnB.lFCtF56yg.xBkhtm3HplX2wN0I/Raxy', '/private/1755524969.jpg', '2025-08-18 06:49:29', '2025-08-18 06:49:29'),
(48, '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', '6447', 'angga', 'X', 'aaaaaaaaaaaa', '087846731585', 'Laki-laki', 'Islam', 'Balikpapan', '2025', '2025-08-18', 'aaaaaaaaa', 'aaaaaaaaaaaa', 'aaaaaaaaaaaaaa', 'aaaaaaaaaaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '6447', '$2y$12$/2Zeh7rPV0pKG0Ia2m.rkONtHNfaUAYfw1GSyGiBuc41XoQL2BbfO', '/private/1755526829.jpg', '2025-08-18 07:20:30', '2025-08-18 07:20:30'),
(51, 'a784bd4c-1771-4d37-92dd-3f33d9a4d14a', '7898', 'Hadi', 'X', 'aaaa', '085811976890', 'Laki-laki', 'Islam', 'balikpapan', '2025', '2025-08-19', 'aaaa', 'aaaa', 'aaa', 'aaaa', 'Pendaftaran', 'Pendaftar Baru', 'Terdaftar', '7898', '$2y$12$botPx7Tt.5Iw6fEmj0nPHeXDGwoNR8/ouJhncbaiojOkFGyWZcGZu', '/private/1755570864.jpg', '2025-08-18 19:34:25', '2025-08-18 19:34:25');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pembayaran`
--

CREATE TABLE `jenis_pembayaran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `jenis` varchar(255) NOT NULL,
  `nominal` varchar(255) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_pembayaran`
--

INSERT INTO `jenis_pembayaran` (`id`, `uuid`, `jenis`, `nominal`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 'f4f39c45-1561-4784-b418-d9e34978eb87', 'PENDAFTARAN', '500000', NULL, '2025-06-24 07:18:27', '2025-06-24 07:18:27'),
(2, '53d3977b-d36f-4fe2-8e94-ee6ebdab7bd8', 'SPP', '100000', NULL, '2025-06-24 07:18:35', '2025-07-20 06:21:10'),
(3, 'ebb10044-bb18-4288-9dc4-d69f857beed4', 'UAS', '370000', NULL, '2025-06-24 07:18:45', '2025-07-19 23:40:35'),
(4, 'xcz72044-bb18-4288-9dc4-d69f857beed4', 'UTS', '350000', NULL, '2025-06-24 07:18:45', '2025-06-24 07:18:45');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_06_14_043708_data_siswa', 1),
(5, '2025_06_14_230230_jenis_pembayaran', 1),
(6, '2025_06_16_021238_pembayaran_spp', 1),
(7, '2025_06_24_151044_pembayaran_uas', 1),
(8, '2025_06_24_151109_pembayaran_uts', 1),
(9, '2025_06_24_151634_pembayaran_pendaftaran', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notif_wa`
--

CREATE TABLE `notif_wa` (
  `id` bigint(20) NOT NULL,
  `pesan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(250) NOT NULL,
  `uuid_siswa` varchar(250) NOT NULL,
  `status` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `notif_wa`
--

INSERT INTO `notif_wa` (`id`, `pesan`, `no_telp`, `uuid_siswa`, `status`, `created_at`, `updated_at`) VALUES
(143, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: angga\nKelas: X\nUsername: 9363\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '087846731585', 'bc17e91b-fa11-4307-bf01-289f7cf51bf9', 'success! message in queue', '2025-08-18 06:39:33', '2025-08-18 06:39:33'),
(144, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: Kasni\nKelas: X\nUsername: 2554\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '082153198306', '2e6c96ff-8223-48a9-92eb-dc9163945346', 'success! message in queue', '2025-08-18 06:41:52', '2025-08-18 06:41:52'),
(145, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: Fibri\nKelas: X\nUsername: 2814\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '087781350108', 'bd9e76f6-91f2-48d2-a441-dba23c7ac3d1', 'success! message in queue', '2025-08-18 06:43:29', '2025-08-18 06:43:29'),
(146, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: nila\nKelas: X\nUsername: 2704\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '081225899623', 'ab84316d-1ef7-4990-b671-0e688f678913', 'success! message in queue', '2025-08-18 06:45:18', '2025-08-18 06:45:18'),
(147, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: Agni\nKelas: X\nUsername: 9809\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '085386423795', '6c452bc5-6697-4b10-a339-99b2997ea69a', 'success! message in queue', '2025-08-18 06:47:11', '2025-08-18 06:47:11'),
(148, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: Huda\nKelas: X\nUsername: 9942\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '085695036401', 'b3bee296-295e-437d-94a4-d0639bc49058', 'success! message in queue', '2025-08-18 06:49:32', '2025-08-18 06:49:32'),
(149, '\r\n         \r\n📚 YPI SCHOOL\r\n🧾 Konfirmasi Pembayaran pendaftaran\r\n\r\nAssalamu’alaikum/Salam sejahtera,\r\nKepada Yth. Orang tua / Wali murid dari angga – XI,\r\n\r\nTerima kasih, kami telah menerima pembayaran Pendaftaran sekolah sebesar Rp 50000.00\r\n\r\n📌 Rincian Pembayaran:\r\n• Nama Siswa: angga\r\n• Kelas: XI\r\n• Jumlah: Rp 50000.00\r\n• Tanggal Pembayaran: 18 August 2025\r\n\r\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\r\nBerikut adalah detail akun Anda:\r\n\r\nNama Siswa: angga\r\nKelas: XI\r\nUsername: 2508189791\r\nPassword: 2025-08-18\r\n\r\nBukti pembayaran telah dicatat oleh pihak administrasi sekolah.\r\n\r\nTerima kasih atas kerja sama dan partisipasinya. 🙏\r\n         ', '087846731585', 'bc17e91b-fa11-4307-bf01-289f7cf51bf9', 'success! message in queue', '2025-08-18 07:17:12', '2025-08-18 07:17:12'),
(150, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: angga\nKelas: X\nUsername: 6447\nPassword: 2025-08-18\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:20:35', '2025-08-18 07:20:35'),
(151, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(152, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Huda\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '085695036401', 'b3bee296-295e-437d-94a4-d0639bc49058', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(153, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Agni\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '085386423795', '6c452bc5-6697-4b10-a339-99b2997ea69a', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(154, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: nila\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '081225899623', 'ab84316d-1ef7-4990-b671-0e688f678913', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(155, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Fibri\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '087781350108', 'bd9e76f6-91f2-48d2-a441-dba23c7ac3d1', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(156, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Kasni\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '082153198306', '2e6c96ff-8223-48a9-92eb-dc9163945346', 'success! message in queue', '2025-08-18 07:28:04', '2025-08-18 07:28:04'),
(157, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Agustus\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 â€“ 14.00 WIB\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:30:07', '2025-08-18 07:30:07'),
(158, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Agustus\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:31:04', '2025-08-18 07:31:04'),
(159, '\nðŸ“¢ YPI SCHOOL\nAssalamuâ€™alaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\nðŸ“Œ UTS Kelas X\nJumlah: Rp 350.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamuâ€™alaikum Wr. Wb.\nðŸ“ž Admin Keuangan\nðŸ•˜ Jam kerja: 08.00 â€“ 14.00 WIB\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:33:50', '2025-08-18 07:33:50'),
(160, '\nðŸ“¢ YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat\ntunggakan pembayaran UAS Kelas X\nJumlah: Rp 370.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WIB\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:34:00', '2025-08-18 07:34:00'),
(161, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Januari\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:41:33', '2025-08-18 07:41:33'),
(162, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Agustus\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:42:05', '2025-08-18 07:42:05'),
(163, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Agustus\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:43:54', '2025-08-18 07:43:54'),
(164, '\nYPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan\npembayaran Spp bulan X Kelas Agustus\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\nAdmin Keuangan\nJam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 07:45:28', '2025-08-18 07:45:28'),
(165, '\nKepada Yth.\nOrang Tua/Wali Murid & Siswa\ndi Tempat\n\nDengan hormat,\nBersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.\n\nBerikut adalah detail akun Anda:\n\nNama Siswa: Hadi\nKelas: X\nUsername: 7898\nPassword: 2025-08-19\n\nSilakan login melalui aplikasi YPI School.\nUnduh aplikasinya melalui tautan berikut:  \n👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk\n\nDan Tutorialnya Berikut:\n👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf\n\nCatatan Penting:\nSimpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.\nJika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.\n\nDemikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nHormat kami,\nAdmin YPI School\n       \n       ', '085811976890', 'a784bd4c-1771-4d37-92dd-3f33d9a4d14a', 'success! message in queue', '2025-08-18 19:35:59', '2025-08-18 19:35:59'),
(166, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Hadi\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '085811976890', 'a784bd4c-1771-4d37-92dd-3f33d9a4d14a', 'success! message in queue', '2025-08-18 19:36:16', '2025-08-18 19:36:16'),
(167, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: angga\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 19:36:16', '2025-08-18 19:36:16'),
(168, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Huda\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '085695036401', 'b3bee296-295e-437d-94a4-d0639bc49058', 'success! message in queue', '2025-08-18 19:36:17', '2025-08-18 19:36:17'),
(169, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Agni\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '085386423795', '6c452bc5-6697-4b10-a339-99b2997ea69a', 'success! message in queue', '2025-08-18 19:36:17', '2025-08-18 19:36:17'),
(170, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: nila\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '081225899623', 'ab84316d-1ef7-4990-b671-0e688f678913', 'success! message in queue', '2025-08-18 19:36:17', '2025-08-18 19:36:17'),
(171, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Fibri\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '087781350108', 'bd9e76f6-91f2-48d2-a441-dba23c7ac3d1', 'success! message in queue', '2025-08-18 19:36:17', '2025-08-18 19:36:17'),
(172, '\n📢 YPI SCHOOL\nAssalamualaikum Wr. Wb.\nYth. Bapak/Ibu Orang Tua/Wali Murid\nNama Siswa: Kasni\nKelas: X\n\nKami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:\n📌 Pendaftaran SPP Bulan Agustus Kelas X\nJumlah: Rp 100.000\n\nKami mohon Bapak/Ibu dapat segera melakukan pelunasan SPP yang sebagai salah satu syarat ikut UTS dan UAS\ndan juga bisa menghubungi bagian administrasi untuk konfirmasi.\n\nAtas perhatian dan kerjasamanya, kami ucapkan terima kasih.\n\nWassalamualaikum Wr. Wb.\n📞  Admin Keuangan\n🕘 Jam kerja: 08.00 - 14.00 WITA\n        \n        ', '082153198306', '2e6c96ff-8223-48a9-92eb-dc9163945346', 'success! message in queue', '2025-08-18 19:36:17', '2025-08-18 19:36:17'),
(173, 'tess', '085811976890', 'a784bd4c-1771-4d37-92dd-3f33d9a4d14a', 'success! message in queue', '2025-08-18 19:36:40', '2025-08-18 19:36:40'),
(174, 'tess', '087846731585', '9e6a3fbf-0ced-41b5-84f9-f6dc31bf8791', 'success! message in queue', '2025-08-18 19:36:40', '2025-08-18 19:36:40'),
(175, 'tess', '085695036401', 'b3bee296-295e-437d-94a4-d0639bc49058', 'success! message in queue', '2025-08-18 19:36:40', '2025-08-18 19:36:40'),
(176, 'tess', '085386423795', '6c452bc5-6697-4b10-a339-99b2997ea69a', 'success! message in queue', '2025-08-18 19:36:41', '2025-08-18 19:36:41'),
(177, 'tess', '081225899623', 'ab84316d-1ef7-4990-b671-0e688f678913', 'success! message in queue', '2025-08-18 19:36:41', '2025-08-18 19:36:41'),
(178, 'tess', '087781350108', 'bd9e76f6-91f2-48d2-a441-dba23c7ac3d1', 'success! message in queue', '2025-08-18 19:36:41', '2025-08-18 19:36:41'),
(179, 'tess', '082153198306', '2e6c96ff-8223-48a9-92eb-dc9163945346', 'success! message in queue', '2025-08-18 19:36:41', '2025-08-18 19:36:41');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_pendaftaran`
--

CREATE TABLE `pembayaran_pendaftaran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `siswa_uuid` char(36) NOT NULL,
  `status` varchar(255) NOT NULL,
  `kelas` varchar(11) DEFAULT NULL,
  `tahun` varchar(11) DEFAULT NULL,
  `kondisi` varchar(225) NOT NULL,
  `nominal` varchar(255) NOT NULL,
  `sisa` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_spp`
--

CREATE TABLE `pembayaran_spp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `siswa_uuid` char(36) NOT NULL,
  `bulan` varchar(11) NOT NULL,
  `tahun` varchar(11) DEFAULT NULL,
  `kelas` varchar(11) NOT NULL,
  `nominal` varchar(255) NOT NULL,
  `sisa` varchar(250) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `periode` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `kondisi` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_uas`
--

CREATE TABLE `pembayaran_uas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `siswa_uuid` char(36) NOT NULL,
  `kelas` varchar(11) NOT NULL,
  `tahun` varchar(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `nominal` varchar(255) NOT NULL,
  `sisa` varchar(250) DEFAULT NULL,
  `kondisi` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_uts`
--

CREATE TABLE `pembayaran_uts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `siswa_uuid` char(36) NOT NULL,
  `kelas` varchar(11) NOT NULL,
  `tahun` varchar(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `nominal` varchar(255) NOT NULL,
  `sisa` varchar(250) DEFAULT NULL,
  `kondisi` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('17PtZxpIFr6VT9KrAPkukakoRCvRPqNNkXFcrDGF', NULL, '54.162.190.164', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMEFlQjhSNmNQTXFMandrUVlDMndRT3dqa1VQZENmZXVQTkNBWE84RCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxMzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2FwcHJvdmFsLXNpc3dhL2E3ODRiZDRjLTE3NzEtNGQzNy05MmRkLTNmMzNkOWE0ZDE0YT9fdG9rZW49RnlGb3VFNDV4UFdrOFJhekxxWEhMdFpEbjJBeG1IckRqUUFLcFI3diI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755571103),
('2P6qnPd43mNZKFaDD3sWi1LJDD3yecfCkfh8Gboc', NULL, '43.135.182.43', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR09HT2Q5MDhnRDVKbkI5SG8zSXJ5WHVIMExaWGpoZ0tMcVJ5eUVtayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755540436),
('2S6X3sFuingjkgNyfDz3gANYXHgC5dYIr3EwyO1z', NULL, '54.162.83.71', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia3RDcEcyT3Zud2xRR0dMMjdjazBFUnFlQ3p2OWF0SDFubzBQYXo4YyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXNwcC85ZTZhM2ZiZi0wY2VkLTQxYjUtODRmOS1mNmRjMzFiZjg3OTEvWC9BZ3VzdHVzP190b2tlbj1FQm9qWkJYMUM2Uk43d0FHZVJwRjNHNUtQWlRNVEhSSXhZbjRUZ1JsIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2xvZ2luLWFkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755528044),
('2Wk70LGgEolPN28IWW2q9wGRqNdPPt8tYJ0FCbOJ', NULL, '43.130.57.46', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGFXZDYxd29aSmdKc1hxWnhURWEwUWltY3dTenJJRnEyNlV2REtTayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755529943),
('5CoFbSz5gZFCIDhD8yw01asBINMtcepLiOgXj74F', NULL, '54.159.43.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTd4M2Zoc2w4R1JMc3NmeHdSZGdEb1BuWW9vbEZFeXhLbFJucXRLQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755576204),
('5guzMVyPz84lXcWbOxTbB6cjgOtXotW7hdPoLgvg', NULL, '54.226.190.218', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidlA5YWZJOTA4WUVNZ0xyem1oYm80VkRTN0hQZ2dpdTBSekh1anFKMCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1MzoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvZGF0YS1iYXlhci1zcHAiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo1MDoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvbG9naW4tYWRtaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755527459),
('6CDENhZbNjo7A5Ce1AttISLUHE0QrJnhePMCIIHl', NULL, '43.128.149.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUE9OM3BldFNLMnRXdEp1bWtpeVBTM3Rxam1XOTBJZkRodlhxTkRrNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755562557),
('6JSPWgv3g04xZSa4mR4kTYPpvVPuKsOcgrxgn1CU', NULL, '43.154.140.188', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnk5N3NwUkxkNm9xRTNxTnIxV2gxaERUMDBBYjhtUTZWVFdMUHNPZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755557326),
('8GRVlk85i7f0N24hDyh50n2KHuAEkYr5MZXc01qZ', NULL, '57.141.2.15', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2ZINVNURHdGTHdJS1pkaXdHOUl1T0ZaR29ub1VSc3JqQ2FwUUtCSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755527256),
('9fcEPT8k5jVbxE3NgYJsqaht1oNRPbnLzGkV1w8K', NULL, '223.15.245.170', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTkR4aU02em5FTUkzSUR3QnhOUmtua0xDM0t5T205dHdoQm9jT3BGTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755545831),
('A7Ed79TPGpcEEvgkEA6I3iMhmsejVyToNzmNSvH6', NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkRXbFhQbWdZSGNKcTRYSnRZV3hiWDZGUlRYUXBSN285UWxtb25hVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755530303),
('AU1000IJyXCyCMGvEX6ocg0w0yyB2k8K5HWMBZEP', 1, '182.8.178.27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVHV2YjRxR2lWR2phaUg0UFI1c3FUWTYyTEVvSHVZTHFzYUl0TEszNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL3BlbmRhZnRhcmFuLXNpc3dhIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1755532395),
('c6pMEg3YB1ykbNO6dWiqsv4cpE6pN4spfmkjRJSb', NULL, '209.38.67.171', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmoxdEtQSmc3dE9TODhsQ09lVGhURDhHUUFqVGI4cXl6Yks2S3hZUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755589966),
('CvujRcTSs9whXrAQGNEQR4Ir4nJ4slo5opzkByxY', NULL, '3.81.5.78', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiM3Rtb0M4R2FRaVVRSm5rOFhNRFdFczZqUjdPc3RWQTM2cVNtakNzMyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTY6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXBlbmRhZnRhcmFuLzllNmEzZmJmLTBjZWQtNDFiNS04NGY5LWY2ZGMzMWJmODc5MT9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755527293),
('CxWbnrGSqCWvLI3swFlOcAaX9bMHrY8IkA3z9G4U', NULL, '123.187.240.242', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkFjYWRQZnVueHFiTDV5Y3JhOFpYdXNTOFltNGJLVEl5ZmludkxUbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755601481),
('dF8HBf50g2iQ7Mno8v8LdVM23tGdyBWbbdjXzF61', NULL, '58.49.233.126', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmRjR0VRSE9EbFFLM3dlR3hoSjdzNmdTaUpiQU1vQW16RzZ1b2xtZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755556666),
('dNfwdqJd8UkCydnHpXKxsKVWwtCBiXW3nAg6BoRq', NULL, '43.159.140.236', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGJNZ21PWFdVZzhCbDJTY0J2WEppQTVQd09vV3dHMFdjUWtOSWw2WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755540573),
('EP3anYmkcIqzIJBDnO0f6S82SDfiXZerKlofcmC5', NULL, '140.213.133.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYU9CVm1NY0VZRDdLS1U5Mm1QN3pzUlRhWklLdk5RRnI2bmQ0NkNTZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755585381),
('FJT3MsVJYW29taC9IT9f53YKnAKjZXKjlcuG27S1', NULL, '34.105.38.126', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjdBbFhEWXhzRzF4OFdiU0NNekx3OVJDYXhDU1dweXhLd2N4RTNXaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755526985),
('fxLMz15Xx682YSP1zrgsoayVV2DeL447bQIy0wm9', NULL, '98.87.152.101', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVUJyRGs2M1pORjVMSG5vRzVIYnVmUm9zcEY2UzNyUk5id2ZKcFJjTSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNDE6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2RlbGV0ZS1kYXRhLXNpc3dhL2JjMTdlOTFiLWZhMTEtNDMwNy1iZjAxLTI4OWY3Y2Y1MWJmOT9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755527056),
('gaU38KH5lAWJ2U2UThzOPoaF2Eo4mP9RPI0diLEs', NULL, '13.218.211.184', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVFM3V1N2QUZuZjhrQUFYcUhoN3lZcVUzNndMZmJZaGFqdGZqN1dUNSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxMzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2FwcHJvdmFsLXNpc3dhLzllNmEzZmJmLTBjZWQtNDFiNS04NGY5LWY2ZGMzMWJmODc5MT9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755527330),
('GGuX3jp9Cew7hJdsPigNIQZyt9JiYz9Sd0dP04gj', 1, '140.213.67.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRnlGb3VFNDV4UFdrOFJhekxxWEhMdFpEbjJBeG1IckRqUUFLcFI3diI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2kiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1755571008),
('GOZPDnvSpwgCTv6hOjK3giAyHVau1l59P6PxgG4J', NULL, '13.217.51.172', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2pNY1lrTFNySmRkTEFjWXl3T3g3bEtGeUw2eEI5bGVER05lQzlVUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755571147),
('gQVz8HoF8Bo3HRWP5oYUJuxO6Axgt94z2d4djYmA', NULL, '43.155.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWtza3Nwa0FudWkwc1FxVWxuQ21kbjZiZXVqVjdxY2Y5RHZYN1A3TCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755579346),
('gUdgAeRBmBuIkCic2W4J6uXVSnsaBaAxdtVNytBu', NULL, '107.22.62.11', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicndDRVF5a01LY25ZaDEzUWVmdHVSbGljZXA4T3VFOER0VjZWZFplZCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTY6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXBlbmRhZnRhcmFuLzllNmEzZmJmLTBjZWQtNDFiNS04NGY5LWY2ZGMzMWJmODc5MT9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755527781),
('HNumpnFyRiSm2A0hrQN0gjix8DaThHydsto2S7Ic', 1, '140.213.133.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZTQ4MlVidnlrUlBtRE1aZzZNOXk4TUQ3OTE2Y0lqcExkQThYZVpncCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2RhdGEtYmF5YXItcGVuZGFmdGFyYW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1755585469),
('hqdBIthMyuuMpaY4espRg1T80JkIEAU3dtm9fvep', NULL, '43.155.188.157', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTRocEFRbzh5WW5ERFBaN3BzTkV3QWs2eUx1MFBRZzRzOGl2RDQzOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755529653),
('hYkp0O22QWVOM6uYJvTG3ty8cKbW9w8ZRo8YZjgY', NULL, '129.226.93.214', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWGcxOGYxY2pHMDVOMkZFTGtzQVRVSFp6TTRPWE4ybkc1SFVzRWU3bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755530229),
('J9KtMCbDbJpHdo7xZhrrXJGjuSvbzV0aorXlMcjI', NULL, '170.106.82.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVFVkUHNtQmEzcGRpMExrUlBIYXVCYzI3NlpEMEdMUUpwUVVLS21FMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755581492),
('JhmiYsd7BY0I3XgLQUSLjJkDfAhGLutaE83dAF9D', NULL, '182.8.178.27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:141.0) Gecko/20100101 Firefox/141.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblM2VTNJTEloZm9Pa2ZndWZXZGJUWkhzQkp1TmdLYU9BS1hDWjA3ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL3JlZ2lzdHJhc2kiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755531604),
('joScYgVlA1p0Eum8VbtbSbMUfEu2ApB77VrReB9I', 1, '140.213.133.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaGo4UzBuTkhoZkhTTEpDZXJqTk9KeHd3VnFEZ2NWMVlzVGtJZTh5VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2RhdGEtYmF5YXItcGVuZGFmdGFyYW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1755532657),
('JUVwQD2fKW6sTCcdaSUsaxKf7VhuDc0K80RsAg16', NULL, '3.84.132.48', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNFpaVjU1QlpsQnR0UVdkUHZMb2dHOFRSbTdwRVpRR1ZOaEJYZnpJRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0OToiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvbm90aWZpa2FzaSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755525489),
('jVRrzrkyHSN1Cy37OFFtpdDwUlQ2SHHakwzXwTwk', NULL, '49.232.151.112', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0dNaVhGUVMxNXl0dEg1QnlnU3d2c2V2RTNUelBQeU1nTzJwUlVoRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755534778),
('K8cKJeq8A2KubON3mNyl4ED5dd4mQVXYljDh70XO', NULL, '43.159.139.164', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVjJadHZ6MlRnd2kxRE8ySkxRbnE3Vlp3YmZiNzVlTkFGdnJZdkhYMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755562339),
('kfrOyvkfN53VHVna3xfjf7NpPkzxrhWCPjfVzx07', NULL, '43.166.247.82', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWk4NzhWVVRFc1F0SDhVUzc4Q1A3REt5YWl0Z09WbEEwelRDWnRZUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755597740),
('KQZcBbsFTRrClmTvyXWpDOEGYOlRiBiSHJp6e6CQ', NULL, '209.97.155.214', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEEwSUdsaW9zZXRFem5wYU1DbnBtc1RkbDJsMjhYVnVEZnJadDh2VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755595093),
('kwDgdPicCfab8YTyrwHO68GAr0Xu5Sxcvvo4f1T4', NULL, '170.106.187.106', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEgydkpoVUhBY05KMndmdERKNElzOEdDR3hiWjlGMkt6aGxqM3B3eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL3JlZ2lzdHJhc2kiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755560326),
('LihuELAvQRmp6dVQaCJcKpIuo0IZqvAwcqS7I4z2', NULL, '3.94.6.245', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUUJpRUFVN2NCVjRpYklLUE9yU0lmcXcyM3g3Ymx6dzFjRnIwV2FQeiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXNwcC85ZTZhM2ZiZi0wY2VkLTQxYjUtODRmOS1mNmRjMzFiZjg3OTEvWC9KYW51YXJpP190b2tlbj1FQm9qWkJYMUM2Uk43d0FHZVJwRjNHNUtQWlRNVEhSSXhZbjRUZ1JsIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2xvZ2luLWFkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755528416),
('m0lVg0iH7f8BnkGIrryljyBMsyKGoSMchS2Saa45', NULL, '20.171.207.209', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia215NWR5b200eWpGQnZYcENESld1Q2FlUzRWQ1hSYktQUjlETjNINSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755567634),
('MjxigS1ay2HpxzBtz9aqAymaC88RygsTquFNeKco', NULL, '14.215.163.132', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTkFiWVE2dlN5cEE0ZTNyOVBVN1N4RDJVV01vczFDMHpkT2tpNG5vRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755589966),
('mSMA24aN9BfLSFQa9JxZ484XZznxWjcYUO0Q0nua', NULL, '20.171.207.211', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHpVT1g4cTR1SnZIcWZhZ1ZBeFNycmljeXlQa0NBZHhINmlFaHRtcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vbWFpbC50ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755557284),
('mUybnNLfkO2B54w9poaYhSJaXjetqLhCKAyL1o9Q', NULL, '43.159.136.201', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidzZDcmNhbjBqZmtENkE2cnZnamRWTDVhUUllS2R5d1pYNVZSWWpSayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755569212),
('N07ecdoGdtYbQ5CuCD3Xn4ubMmh4oM3Sl3kx0Tc3', NULL, '49.51.180.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRlduWTB6ZGtYUmhOcUJCczBLR21QdTNyd1lIZFFZenRIT05XOGQxdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755569334),
('NcBv3dSFLHmJiMDRVxzRrZFhT0cUL1ljkfcd694x', NULL, '170.106.163.48', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDJld2tXMXFuTVc3Ulc4OXVGTmZKYzdJUW5SOWVScjlWQTd4amFGRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755559380),
('nTLiYJq18CsmboB6lgtzN490qn84JcvfRxK8IfHq', NULL, '18.234.121.171', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZlFRdXZUc3dSNFlXRDZaTnNXWEtkWE8xbVdiZjBXMlJDSG9BeURmUCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxMzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2FwcHJvdmFsLXNpc3dhL2IzYmVlMjk2LTI5NWUtNDM3ZC05NGE0LWQwNjM5YmM0OTA1OD9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755525146),
('owj43swhWnCpyvwsTlZcCu5oBjvulPCEofdTaX77', NULL, '54.80.41.65', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY0dnSzdPc1VxNEU5a2hOUjBnenNBakt2MXBsMlE3RTVNMTVZTXdEaSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0ODoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvZGFzaGJvYXJkIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2xvZ2luLWFkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755571321),
('p20Es9exVSxwYLKvcDSTBMsGWQHzEmr3lIYgS2ME', NULL, '170.106.152.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0JMc3l3cURyYWlyeEF6TlE5QWJhZm5rRk9HU1Y3RWtMdXBtMzQ1aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755599307),
('PwkhyZiR0rWWeQO71K3fzjqFcPXyN1OSDlBjHAGe', NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFloUUZhV2JvQTZGbm16RUN4aDRqMDBwQWM1U3B5Wm5RdzhsNGxhTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755530302),
('qhpxfNulSJBssWUOKgyuv9XYm0qMLEAbKvuA55GC', NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0hVeUpSV3VhOEFRWkxDcEMxQjRSaFZEaTdkTTNlQ2hzUExYVTZUUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755530301),
('rgDg8VcTY0AX4b0MziuV09Dp4bfSWdc9p4RuPvCj', NULL, '20.229.51.198', 'curl/8.6.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkdhSlQzSHBYVE9KUnVab09vaWxxcU1sRTk5ZEZqUFBVYk5ETnFUZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755578661),
('RWG93ThsnJZKyOPXoD6mLF1zIYtTinhXLz2TOFzg', NULL, '54.83.81.224', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGJwNXhSSVNmakUzSndGTUZVZU5tQzN4S0hKOGtzWkVtSTRoM3hmWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755570987),
('tPPlk1dBdt8tjtlt0Qma7B2JJKI4Y0AZLiltZqRm', NULL, '54.162.120.196', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTkIxcXpHUzJwc3VNcjBGZEFRRnE3azJldGRJeDFQMGE4ZGRjanFNdSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTg6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXNwcC85ZTZhM2ZiZi0wY2VkLTQxYjUtODRmOS1mNmRjMzFiZjg3OTEvWC9BZ3VzdHVzP190b2tlbj1FQm9qWkJYMUM2Uk43d0FHZVJwRjNHNUtQWlRNVEhSSXhZbjRUZ1JsIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2xvZ2luLWFkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755527662),
('VmbOcYfyyQRJrxokOV1eXnp0qthOLRcz71S60cYl', NULL, '140.213.182.25', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOXRJSTVFU25UbGdPWXFXalV2Q3ZwM2xOejU1NTJtQ3Z2eVhKeWk1TyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755606607),
('vqBG63mLUGZ5mj7a05A6FOXlIk38s7xN4yvRaiEV', NULL, '182.42.105.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkZGcXUzalVpMEZRZTMwSmRDOGZaTEhES3dwc01xMFFIbzcweTBYRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755567382),
('WufU0O6qffW1jtL97EMh1SNBMqZzEUs1zApd4fi3', NULL, '52.90.10.49', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU0FwVlM2ZVNzMjRXRnpwNnExS3JrT1hrRkEwUEtZTUJpdjJrZ1lhUiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0ODoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvZGFzaGJvYXJkIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL2xvZ2luLWFkbWluIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755532774),
('xlOVeAH8nxmi2G4KHaQcA9lYKIeGQx4MzADnGVwM', NULL, '3.87.31.42', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieGZINGRQVGFHNFppWHk3TUhGeHBEMTFTa2VZY2pYODlwYmpqd2xHRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNTA6Imh0dHBzOi8vdGVzdGVyLXlpcGlzY2hvb2wtYWRtaW4ub25saW5lL25vdGlmaWthc2ktdHVuZ2dha2FuLXV0cy85ZTZhM2ZiZi0wY2VkLTQxYjUtODRmOS1mNmRjMzFiZjg3OTEvWD9fdG9rZW49RUJvalpCWDFDNlJON3dBR2VScEYzRzVLUFpUTVRIUkl4WW40VGdSbCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjUwOiJodHRwczovL3Rlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZS9sb2dpbi1hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755527853),
('ytujeTi5uAgmo4K2kyXTRjU3dd2GziCDlP6x1OSG', NULL, '170.106.35.137', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNFg0aFJXMEEwRmY4VFZTM1BEYlNGVWNwWjZacmtDQ1drV0NpV2tTQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vd3d3LnRlc3Rlci15aXBpc2Nob29sLWFkbWluLm9ubGluZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1755528545),
('ZLq41xe6YEyXpYu8NSRLz1ujqLjlNtrlpcyn5iHd', NULL, '3.84.144.99', 'Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUlRhblBJZkZiZm1rVkg0Zkd6REs1a3pxTFNJYzJISEJBNFl6RFpZayI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1MzoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvZGF0YS1iYXlhci11dHMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo1MDoiaHR0cHM6Ly90ZXN0ZXIteWlwaXNjaG9vbC1hZG1pbi5vbmxpbmUvbG9naW4tYWRtaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1755527857);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'tester@gmail.com', NULL, '$2y$12$U2yYFcii11ldMLvLfCe7OOQWLBswTgFksAFooOfBmYhy1tqalf1xy', NULL, NULL, '2025-06-24 07:18:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `data_siswa`
--
ALTER TABLE `data_siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_siswa_uuid_unique` (`uuid`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jenis_pembayaran`
--
ALTER TABLE `jenis_pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jenis_pembayaran_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notif_wa`
--
ALTER TABLE `notif_wa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pembayaran_pendaftaran`
--
ALTER TABLE `pembayaran_pendaftaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pembayaran_pendaftaran_uuid_unique` (`uuid`),
  ADD KEY `pembayaran_pendaftaran_siswa_uuid_foreign` (`siswa_uuid`);

--
-- Indexes for table `pembayaran_spp`
--
ALTER TABLE `pembayaran_spp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pembayaran_spp_uuid_unique` (`uuid`),
  ADD KEY `pembayaran_spp_siswa_uuid_foreign` (`siswa_uuid`);

--
-- Indexes for table `pembayaran_uas`
--
ALTER TABLE `pembayaran_uas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pembayaran_uas_uuid_unique` (`uuid`),
  ADD KEY `pembayaran_uas_siswa_uuid_foreign` (`siswa_uuid`);

--
-- Indexes for table `pembayaran_uts`
--
ALTER TABLE `pembayaran_uts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pembayaran_uts_uuid_unique` (`uuid`),
  ADD KEY `pembayaran_uts_siswa_uuid_foreign` (`siswa_uuid`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_siswa`
--
ALTER TABLE `data_siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_pembayaran`
--
ALTER TABLE `jenis_pembayaran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notif_wa`
--
ALTER TABLE `notif_wa`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT for table `pembayaran_pendaftaran`
--
ALTER TABLE `pembayaran_pendaftaran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `pembayaran_spp`
--
ALTER TABLE `pembayaran_spp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pembayaran_uas`
--
ALTER TABLE `pembayaran_uas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembayaran_uts`
--
ALTER TABLE `pembayaran_uts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembayaran_pendaftaran`
--
ALTER TABLE `pembayaran_pendaftaran`
  ADD CONSTRAINT `pembayaran_pendaftaran_siswa_uuid_foreign` FOREIGN KEY (`siswa_uuid`) REFERENCES `data_siswa` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran_spp`
--
ALTER TABLE `pembayaran_spp`
  ADD CONSTRAINT `pembayaran_spp_siswa_uuid_foreign` FOREIGN KEY (`siswa_uuid`) REFERENCES `data_siswa` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran_uas`
--
ALTER TABLE `pembayaran_uas`
  ADD CONSTRAINT `pembayaran_uas_siswa_uuid_foreign` FOREIGN KEY (`siswa_uuid`) REFERENCES `data_siswa` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `pembayaran_uts`
--
ALTER TABLE `pembayaran_uts`
  ADD CONSTRAINT `pembayaran_uts_siswa_uuid_foreign` FOREIGN KEY (`siswa_uuid`) REFERENCES `data_siswa` (`uuid`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
