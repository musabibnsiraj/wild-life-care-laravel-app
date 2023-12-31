-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for wild-life-care-laravel-app
CREATE DATABASE IF NOT EXISTS `wild-life-care-laravel-app` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `wild-life-care-laravel-app`;

-- Dumping structure for table wild-life-care-laravel-app.attachments
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint(20) unsigned NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attachments_complaint_id_foreign` (`complaint_id`),
  CONSTRAINT `attachments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.attachments: ~0 rows (approximately)
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.complaints
CREATE TABLE IF NOT EXISTS `complaints` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `assigned_officer_id` bigint(20) unsigned DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('submitted','in_progress','resolved') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'submitted',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `complaints_user_id_foreign` (`user_id`),
  CONSTRAINT `complaints_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.complaints: ~0 rows (approximately)
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `address_2` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_user_id_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.customers: ~1 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `user_id`, `address`, `address_2`, `phone`, `status`, `created_at`, `updated_at`) VALUES
	(1, 8, 'Dubai main road', 'Dubai kurukku sandhu', '0755555555', 1, '2023-12-20 18:37:12', '2023-12-20 18:37:12');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.institutions
CREATE TABLE IF NOT EXISTS `institutions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `type` enum('forestry','environmental_crime','wildlife') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'wildlife',
  `address` text COLLATE utf8mb4_unicode_ci,
  `address_2` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `branch` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `institutions_user_id_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.institutions: ~3 rows (approximately)
/*!40000 ALTER TABLE `institutions` DISABLE KEYS */;
INSERT INTO `institutions` (`id`, `user_id`, `name`, `type`, `address`, `address_2`, `phone`, `branch`, `status`, `created_at`, `updated_at`) VALUES
	(1, 2, 'Wild Life Care Center', 'wildlife', 'Dubai main road', 'Dubai kurukku sandhu', '0755555555', 'puttalam', 1, '2023-12-20 18:37:11', '2023-12-20 18:37:11'),
	(2, 4, 'Forestry Dep', 'forestry', 'Dubai main road', 'Dubai kurukku sandhu', '0755555555', 'puttalam', 1, '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(3, 6, 'Environmental Care Center', 'environmental_crime', 'Cross Street galle', 'Dubai kurukku sandhu', '07999999', 'puttalam', 1, '2023-12-20 18:37:12', '2023-12-20 18:37:12');
/*!40000 ALTER TABLE `institutions` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.investigations
CREATE TABLE IF NOT EXISTS `investigations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `officer_id` bigint(20) NOT NULL,
  `complaint_id` bigint(20) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','in_progress','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.investigations: ~0 rows (approximately)
/*!40000 ALTER TABLE `investigations` DISABLE KEYS */;
/*!40000 ALTER TABLE `investigations` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint(20) unsigned NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locations_complaint_id_foreign` (`complaint_id`),
  CONSTRAINT `locations_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.locations: ~0 rows (approximately)
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.migrations: ~13 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2014_10_12_100000_create_password_resets_table', 1),
	(4, '2019_08_19_000000_create_failed_jobs_table', 1),
	(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(6, '2023_12_16_135606_create_permission_tables', 1),
	(7, '2023_12_18_121058_create_customers_table', 1),
	(8, '2023_12_18_121119_create_complaints_table', 1),
	(9, '2023_12_18_121130_create_investigations_table', 1),
	(10, '2023_12_18_121147_create_officers_table', 1),
	(11, '2023_12_18_123231_create_institutions_table', 1),
	(12, '2023_12_19_180110_create_locations_table', 1),
	(13, '2023_12_19_180123_create_attachments_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.model_has_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.model_has_roles: ~8 rows (approximately)
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(2, 'App\\Models\\User', 2),
	(3, 'App\\Models\\User', 3),
	(2, 'App\\Models\\User', 4),
	(3, 'App\\Models\\User', 5),
	(2, 'App\\Models\\User', 6),
	(3, 'App\\Models\\User', 7),
	(4, 'App\\Models\\User', 8);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.officers
CREATE TABLE IF NOT EXISTS `officers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `address_2` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `badge_number` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `officers_user_id_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.officers: ~3 rows (approximately)
/*!40000 ALTER TABLE `officers` DISABLE KEYS */;
INSERT INTO `officers` (`id`, `user_id`, `institution_id`, `address`, `address_2`, `phone`, `badge_number`, `status`, `created_at`, `updated_at`) VALUES
	(1, 3, 1, 'Main road colombo', 'Dubai kurukku sandhu', '0755555555', 'QWERTY', 1, '2023-12-20 18:37:11', '2023-12-20 18:37:11'),
	(2, 5, 2, 'Dubai main road', 'Dubai kurukku sandhu', '0755555555', 'QWERTY2', 1, '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(3, 7, 3, '1st Street Matara', 'Dubai kurukku sandhu', '07000000', 'QWERTY3', 1, '2023-12-20 18:37:12', '2023-12-20 18:37:12');
/*!40000 ALTER TABLE `officers` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.password_reset_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.permissions: ~20 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'edit-users', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(2, 'delete-users', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(3, 'view-users', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(4, 'create-users', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(5, 'edit-complaints', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(6, 'delete-complaints', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(7, 'view-complaints', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(8, 'create-complaints', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(9, 'edit-investigations', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(10, 'delete-investigations', 'web', '2023-12-20 18:37:08', '2023-12-20 18:37:08'),
	(11, 'view-investigations', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(12, 'create-investigations', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(13, 'edit-officers', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(14, 'delete-officers', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(15, 'view-officers', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(16, 'create-officers', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(17, 'edit-admins', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(18, 'delete-admins', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(19, 'view-admins', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(20, 'create-admins', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.personal_access_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'Super-Admin', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(2, 'Admin', 'web', '2023-12-20 18:37:09', '2023-12-20 18:37:09'),
	(3, 'Officer', 'web', '2023-12-20 18:37:10', '2023-12-20 18:37:10'),
	(4, 'User', 'web', '2023-12-20 18:37:10', '2023-12-20 18:37:10');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.role_has_permissions: ~36 rows (approximately)
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(5, 2),
	(7, 2),
	(9, 2),
	(10, 2),
	(11, 2),
	(12, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	(9, 3),
	(11, 3),
	(5, 4),
	(6, 4),
	(7, 4),
	(8, 4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;

-- Dumping structure for table wild-life-care-laravel-app.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table wild-life-care-laravel-app.users: ~8 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `google_id`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Super Admin', 'superadmin@example.com', '2023-12-20 18:37:11', '$2y$10$TByi1sKfxlIzOott99DouegJyvLyivzyGn8yEirz3jatFeyWOsLOG', NULL, 'nwjGXMoJIUMCIbgYH1Bu55dxWzW9cEHZGEwhLF9lttK6LkRhLNiG4rGl0D1K', '2023-12-20 18:37:11', '2023-12-20 18:37:11'),
	(2, 'Wildlife Admin', 'wildlife@example.com', '2023-12-20 18:37:11', '$2y$10$elNaHEzliBSoynv.Q/WQV.uUG3n/0wDeFpTvqEsPnIQUmHDuo3aDq', NULL, 'A4A8GfR4Dr', '2023-12-20 18:37:11', '2023-12-20 18:37:11'),
	(3, 'Mr.Been Officer ', 'officer@example.com', '2023-12-20 18:37:11', '$2y$10$.p0gQpYRW4o8KfNQbKDswOzhP0KwPnamNDY2tJQ3xsVkYMvRZC5fO', NULL, 'gjUpdeAFBL', '2023-12-20 18:37:11', '2023-12-20 18:37:11'),
	(4, 'Forestry Admin', 'forestry@example.com', '2023-12-20 18:37:12', '$2y$10$YxNCGGjLntDRourpXLHWjuqn10Z17xu9.I0sesIFO4G3MlyR6sXqG', NULL, 'yzkC64KUU7', '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(5, 'Bruce Lee Officer ', 'officer2@example.com', '2023-12-20 18:37:12', '$2y$10$ILY8cGxv/5AztTlnEluzE.AByA91osMb06riDIkCErohq2A9tU9ja', NULL, 'cMIJmnutiG', '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(6, 'Environmental crime Admin', 'environmental@example.com', '2023-12-20 18:37:12', '$2y$10$UNzR11jlbIg8jucVetWaEuejDaVCqyq7louVngiUoVH82d/j26zNe', NULL, 'UuBycYLsub', '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(7, 'Bruce Officer ', 'officer3@example.com', '2023-12-20 18:37:12', '$2y$10$nxbFOtGSh2H2WKR6khkqheqpJa8IQFMGBJN4fX26trtnjSXfYAycu', NULL, 'OFj3cNuNYV', '2023-12-20 18:37:12', '2023-12-20 18:37:12'),
	(8, 'Public User', 'user@example.com', '2023-12-20 18:37:12', '$2y$10$zrQ2QCP1S7Rbpnmkvj7Gx.XATWxLn8AOQLs2UpRVVrbggSemzrLAm', NULL, '0tJsjJkDDy', '2023-12-20 18:37:12', '2023-12-20 18:37:12');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
