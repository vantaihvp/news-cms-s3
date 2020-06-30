-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 30, 2020 lúc 10:09 AM
-- Phiên bản máy phục vụ: 10.3.15-MariaDB
-- Phiên bản PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `blog`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ads_banner`
--

CREATE TABLE `ads_banner` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','expired','draft','review','on-hold') COLLATE utf8mb4_unicode_ci DEFAULT 'review',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '#',
  `target` enum('_blank','_self','_parent','_top') COLLATE utf8mb4_unicode_ci DEFAULT '_blank',
  `enable_stats` tinyint(1) DEFAULT 0,
  `align` enum('left','center','right') COLLATE utf8mb4_unicode_ci DEFAULT 'center',
  `width` int(10) UNSIGNED DEFAULT 300,
  `height` int(10) UNSIGNED DEFAULT 300,
  `banner_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `ads_banner`
--

INSERT INTO `ads_banner` (`id`, `title`, `status`, `url`, `target`, `enable_stats`, `align`, `width`, `height`, `banner_content`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'test', 'draft', '#', '_blank', 0, 'left', 300, 300, '<div class=\"_ning_elmt\"><img src=\"https://billboardvn.vn/wp-content/uploads/2020/02/tuyen-dung-300x250-1.jpg\" /></div>', 1, '2020-06-08 03:20:05', '2020-06-08 04:03:42', '2020-06-08 04:03:42'),
(2, 'Banner FB 2', 'review', '#', '_blank', 0, 'center', 300, 250, '<img src=\"https://billboardvn.vn/wp-content/uploads/2019/07/banner-billboard-fb-5.jpg\" />', 1, '2020-06-08 03:38:58', '2020-06-08 03:56:15', NULL),
(3, 'ad', 'expired', '#', '_blank', 0, 'left', 300, 300, '<div class=\"_ning_elmt\"><img src=\"https://billboardvn.vn/wp-content/uploads/2019/07/banner-billboard-fb-5.jpg\" /></div>', 1, '2020-06-08 04:04:01', '2020-06-08 04:04:01', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ads_zone`
--

CREATE TABLE `ads_zone` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','draft','on-hold') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  `width` int(10) UNSIGNED DEFAULT 300,
  `height` int(10) UNSIGNED DEFAULT 300,
  `banner_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `random` tinyint(1) DEFAULT 0,
  `campaigns_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `ads_zone`
--

INSERT INTO `ads_zone` (`id`, `title`, `description`, `status`, `width`, `height`, `banner_id`, `random`, `campaigns_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'tessssssssst', 'ad', 'on-hold', 300, 300, '[2]', 1, NULL, 1, '2020-06-08 22:07:57', '2020-06-09 01:13:36', NULL),
(2, 'ad2213', 'adf', 'on-hold', 400, 300, '[2]', 0, NULL, 1, '2020-06-09 01:18:53', '2020-06-09 01:18:53', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_id` int(10) UNSIGNED DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `taxonomy` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'category',
  `seo_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `title`, `slug`, `description`, `thumbnail_id`, `parent_id`, `taxonomy`, `seo_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'Tin tức', 'tin-tuc', 'Mô tả tin tức', NULL, 0, 'category', NULL, 1, '2020-04-27 00:34:38', '2020-04-27 00:34:38', NULL),
(3, 'KPop', 'k-pop', 'chuyên mục Kpop', NULL, 2, 'category', NULL, 1, '2020-04-27 01:27:58', '2020-05-07 02:45:01', '2020-05-07 02:45:01'),
(4, 'VPOP', 'vpop', 'Mô tả chuyên mục VPOP', NULL, 2, 'category', NULL, 1, '2020-04-27 02:20:42', '2020-05-07 02:21:15', NULL),
(5, 'Phỏng vấn độc quyền', 'phong-van-doc-quyen', 'tag phỏng vấn độc quyền', NULL, 0, 'tag', NULL, 1, '2020-05-06 01:44:51', '2020-05-06 03:05:35', NULL),
(6, 'Video', 'video', 'tag video', NULL, 0, 'tag', NULL, 1, '2020-05-06 03:07:27', '2020-05-06 03:07:41', NULL),
(7, 'Snacks2', 'snacks', 'ad', NULL, 0, 'tag', NULL, 1, '2020-05-06 03:18:51', '2020-05-06 03:45:55', '2020-05-06 03:45:55'),
(8, 'Masthead', 'masthead', NULL, NULL, 0, 'tag', NULL, 1, '2020-05-06 03:18:57', '2020-05-06 03:18:57', NULL),
(9, 'Dance', 'dance', 'ad', NULL, 2, 'category', NULL, 1, '2020-05-07 02:49:36', '2020-05-07 02:49:36', NULL),
(10, 'Test', 'test', 'test', NULL, 2, 'category', NULL, 1, '2020-05-07 02:50:22', '2020-05-07 02:50:35', NULL),
(11, 'Banner popup', 'banner-popup', 'ad', NULL, 10, 'category', 13, 1, '2020-06-01 21:08:33', '2020-06-15 04:45:27', '2020-06-15 04:45:27'),
(12, 'videoadl', 'videoadl', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 20:59:32', '2020-06-09 20:59:32', NULL),
(13, 'videoadl', 'videoadl', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:01:50', '2020-06-09 21:02:19', '2020-06-09 21:02:19'),
(14, 'tag moi', 'tag-moi', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:01:50', '2020-06-09 21:01:50', NULL),
(15, 'tag 1', 'tag-1', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:03:07', '2020-06-09 21:03:07', NULL),
(16, 'tag3', 'tag3', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:03:35', '2020-06-09 21:03:35', NULL),
(17, 'tag4', 'tag4', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:03:35', '2020-06-09 21:04:37', '2020-06-09 21:04:37'),
(18, 'tag3', 'tag3', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:04:23', '2020-06-09 21:04:33', '2020-06-09 21:04:33'),
(19, 'tag4', 'tag4', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:04:23', '2020-06-09 21:04:35', '2020-06-09 21:04:35'),
(20, 'tag5', 'tag5', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:26:48', '2020-06-09 21:26:48', NULL),
(21, 'tag323', 'tag323', NULL, NULL, 0, 'tag', NULL, 1, '2020-06-09 21:31:27', '2020-06-09 21:31:27', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menu_detail`
--

CREATE TABLE `menu_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '#',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'custom',
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `position` int(10) UNSIGNED DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_04_06_105437_create_posts_table', 2),
(6, '2020_04_08_065029_create_permission_tables', 3),
(7, '2020_04_08_065421_add_colums_to_permissions', 4),
(8, '2020_04_13_045630_create_slider_table', 5),
(9, '2020_04_13_103720_add_columns_avatar_phone_nickname_to_users', 6),
(10, '2016_06_01_000001_create_oauth_auth_codes_table', 7),
(11, '2016_06_01_000002_create_oauth_access_tokens_table', 7),
(12, '2016_06_01_000003_create_oauth_refresh_tokens_table', 7),
(13, '2016_06_01_000004_create_oauth_clients_table', 7),
(14, '2016_06_01_000005_create_oauth_personal_access_clients_table', 7),
(15, '2020_04_24_110158_create_categories_table', 8),
(16, '2020_04_27_042903_add_type_to_categories_table', 9),
(17, '2020_05_11_101811_add_columns_to_posts_table', 10),
(18, '2020_05_12_045855_create_photos_table', 11),
(19, '2020_05_13_035653_add_category_tag_url_role_to_posts_table', 12),
(21, '2020_05_18_065539_create_seo_table', 13),
(22, '2020_06_02_100236_add_column_thumbnail_highlight_to_posts_table', 14),
(23, '2020_06_08_032527_create_ads_banner_table', 15),
(25, '2020_06_08_032546_create_ads_zone_table', 16),
(26, '2020_06_15_154405_add_column_popular_to_posts_table', 17),
(27, '2020_06_16_161754_create_menu_tables', 18),
(29, '2020_06_17_111803_create_menu_detail_table', 19);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 39),
(19, 'App\\Models\\User', 41),
(19, 'App\\Models\\User', 42),
(19, 'App\\Models\\User', 45);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('31bea2897023fd5e7de56cbfe290a22f7f7adb8b4ae7c8cb995914f123ba1e22d61eb8741a112203', 1, 1, 'MyApp', '[]', 0, '2020-04-16 02:24:46', '2020-04-16 02:24:46', '2021-04-16 09:24:46'),
('71bb8d4f4bf0722f059400df9ef2bb80220a2d7593573afcccbf65f26d078743db8d31f648dc3a7e', 1, 1, 'MyApp', '[]', 0, '2020-04-16 00:37:17', '2020-04-16 00:37:17', '2021-04-16 07:37:17'),
('7341ad46b66db48a3c279e40f2342410610953ed7bf524f424bf6450d597b39dd24892027919e779', 1, 1, 'MyApp', '[]', 0, '2020-04-16 00:35:56', '2020-04-16 00:35:56', '2021-04-16 07:35:56'),
('9e6b84076f059c5738af80c7f8435d938c6caa9574dd057ed17aedec1956b8637d725498d78c300b', 1, 1, 'MyApp', '[]', 0, '2020-04-19 20:25:26', '2020-04-19 20:25:26', '2021-04-20 03:25:26');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'Vjj3KlVbZLmbGFNsqta3tT5Pkd24MoEJIIIBrvny', 'http://localhost', 1, 0, 0, '2020-04-16 00:34:21', '2020-04-16 00:34:21'),
(2, NULL, 'Laravel Password Grant Client', 'NZKJhls7cnwKx0foYnKYVdb2oLmLqRbAI5TqZRFN', 'http://localhost', 0, 1, 0, '2020-04-16 00:34:21', '2020-04-16 00:34:21');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-04-16 00:34:21', '2020-04-16 00:34:21');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_slug` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `group_name`, `group_slug`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'role-list', 'List', 'Roles', 'roles', 'api', '2020-04-13 17:00:00', '2020-04-06 17:00:00'),
(2, 'role-create', 'Create', 'Roles', 'roles', 'api', '2020-04-07 17:00:00', '2020-04-20 17:00:00'),
(3, 'role-edit', 'Edit', 'Roles', 'roles', 'api', '2020-04-20 17:00:00', '2020-04-20 17:00:00'),
(4, 'role-delete', 'Delete', 'Roles', 'roles', 'api', '2020-04-20 17:00:00', '2020-04-20 17:00:00'),
(5, 'user-list', 'List', 'User', 'user', 'api', '2020-04-19 17:00:00', '2020-04-19 17:00:00'),
(6, 'user-create', 'Create', 'User', 'user', 'api', '2020-04-20 17:00:00', '2020-04-20 17:00:00'),
(7, 'user-edit', 'Edit', 'User', 'user', 'api', '2020-04-21 17:00:00', '2020-04-21 17:00:00'),
(8, 'user-delete', 'Delete', 'User', 'user', 'api', '2020-04-21 17:00:00', '2020-04-21 17:00:00'),
(9, 'category-list', 'List', 'Category', 'category', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(10, 'category-create', 'Create', 'Category', 'category', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(11, 'category-edit', 'Edit', 'Category', 'category', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(12, 'category-delete', 'Delete', 'Category', 'category', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(13, 'tag-list', 'List', 'Tag', 'tag', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(14, 'tag-create', 'Create', 'Tag', 'tag', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(15, 'tag-edit', 'Edit', 'Tag', 'tag', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(16, 'tag-delete', 'Delete', 'Tag', 'tag', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(17, 'post-list', 'List', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(18, 'post-create', 'Create', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(19, 'post-edit', 'Edit', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(20, 'post-delete', 'Delete', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(21, 'photo-list', 'List', 'Photo', 'photo', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(22, 'photo-create', 'Create', 'Photo', 'photo', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(23, 'photo-edit', 'Edit', 'Photo', 'photo', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(24, 'photo-delete', 'Delete', 'Photo', 'photo', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(25, 'other-post-list', 'List', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(26, 'other-post-edit', 'Edit', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(27, 'other-post-delete', 'Delete', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(28, 'publish-post', 'Publish', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(29, 'publish-post-edit', 'Delete Publish', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(30, 'publish-post-delete', 'Delete Publish', 'Post', 'post', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(31, 'ads-banner-list', 'Ads Banner List', 'Ads Banner', 'ads-banner', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(32, 'ads-banner-create', 'Ads Banner Create', 'Ads Banner', 'ads-banner', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(33, 'ads-banner-edit', 'Ads Banner Edit', 'Ads Banner', 'ads-banner', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(34, 'ads-banner-delete', 'Ads Banner Delete', 'Ads Banner', 'ads-banner', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(35, 'ads-zone-list', 'Ads Zone List', 'Ads Zone', 'ads-zone', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(36, 'ads-zone-create', 'Ads Zone Create', 'Ads Zone', 'ads-zone', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(37, 'ads-zone-edit', 'Ads Zone Edit', 'Ads Zone', 'ads-zone', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00'),
(38, 'ads-zone-delete', 'Ads Zone Delete', 'Ads Zone', 'ads-zone', 'api', '2020-04-26 17:00:00', '2020-04-26 17:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `photos`
--

CREATE TABLE `photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `caption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `size` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `photos`
--

INSERT INTO `photos` (`id`, `name`, `alt`, `title`, `caption`, `description`, `url`, `user_id`, `size`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bakary.png', NULL, NULL, NULL, NULL, '/frontend/post/placeholder.png', 1, NULL, NULL, NULL, NULL),
(3, '1589277094.png', NULL, NULL, NULL, NULL, '/frontend/post/1589277094.png', 1, NULL, '2020-05-12 02:51:34', '2020-05-27 21:42:59', '2020-05-27 21:42:59'),
(4, '1589277198.png', NULL, NULL, NULL, NULL, '/frontend/post/1589277198.png', 1, NULL, '2020-05-12 02:53:18', '2020-05-12 02:53:18', NULL),
(5, '1589277249.png', NULL, NULL, NULL, NULL, '/frontend/post/1589277249.png', 1, NULL, '2020-05-12 02:54:09', '2020-05-12 02:54:09', NULL),
(6, '1589277381.png', NULL, NULL, NULL, NULL, '/frontend/post/1589277381.png', 1, NULL, '2020-05-12 02:56:21', '2020-05-12 02:56:21', NULL),
(7, '1589277623.png', NULL, NULL, NULL, NULL, '/frontend/post/1589277623.png', 1, NULL, '2020-05-12 03:00:23', '2020-05-12 03:00:23', NULL),
(8, '1589279307.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1589279307.jpg', 1, NULL, '2020-05-12 03:28:27', '2020-05-12 03:28:27', NULL),
(9, '1589356092.png', 'b1', 'a', 'c', 'd', '/frontend/post/1589356092.png', 1, NULL, '2020-05-13 00:48:12', '2020-05-27 04:06:29', NULL),
(10, '1589356276.png', NULL, NULL, NULL, NULL, '/frontend/post/1589356276.png', 1, NULL, '2020-05-13 00:51:16', '2020-05-13 00:51:16', NULL),
(11, '1589356356.png', NULL, NULL, NULL, NULL, '/frontend/post/1589356356.png', 1, NULL, '2020-05-13 00:52:36', '2020-05-13 00:52:36', NULL),
(12, '1589356467.png', NULL, NULL, NULL, NULL, '/frontend/post/1589356467.png', 1, NULL, '2020-05-13 00:54:27', '2020-05-13 00:54:27', NULL),
(13, '1589356494.png', NULL, NULL, NULL, NULL, '/frontend/post/1589356494.png', 1, NULL, '2020-05-13 00:54:54', '2020-05-13 00:54:54', NULL),
(14, '1589356603.png', NULL, NULL, NULL, NULL, '/frontend/post/1589356603.png', 1, NULL, '2020-05-13 00:56:43', '2020-05-13 00:56:43', NULL),
(15, '1589358793.png', NULL, NULL, NULL, NULL, '/frontend/post/1589358793.png', 1, NULL, '2020-05-13 01:33:13', '2020-05-13 01:33:13', NULL),
(16, '1589439993.png', NULL, NULL, NULL, NULL, '/frontend/post/1589439993.png', 1, NULL, '2020-05-14 00:06:33', '2020-05-14 00:06:33', NULL),
(17, '1589440003.png', 'Masthead desktop', 'Masthead desktop', 'Masthead desktop', 'Masthead desktop', '/frontend/post/1589440003.png', 1, NULL, '2020-05-14 00:06:43', '2020-05-27 04:09:04', NULL),
(18, '1589777085.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1589777085.jpg', 1, NULL, '2020-05-17 21:44:45', '2020-05-17 21:44:45', NULL),
(19, '1589777265.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1589777265.jpg', 1, NULL, '2020-05-17 21:47:45', '2020-05-17 21:47:45', NULL),
(20, '1590569461.png', NULL, NULL, NULL, NULL, '/frontend/post/1590569461.png', 1, NULL, '2020-05-27 01:51:01', '2020-05-27 21:44:06', '2020-05-27 21:44:06'),
(21, '1590641207.png', NULL, NULL, NULL, NULL, '/frontend/post/1590641207.png', 1, NULL, '2020-05-27 21:46:47', '2020-05-27 21:47:25', '2020-05-27 21:47:25'),
(22, '1590641218.png', NULL, NULL, NULL, NULL, '/frontend/post/1590641218.png', 1, NULL, '2020-05-27 21:46:58', '2020-05-27 21:48:05', '2020-05-27 21:48:05'),
(23, '1590641453.png', NULL, NULL, NULL, NULL, '/frontend/post/1590641453.png', 1, NULL, '2020-05-27 21:50:53', '2020-05-27 21:53:44', '2020-05-27 21:53:44'),
(24, '1590641497.PNG', NULL, NULL, NULL, NULL, '/frontend/post/1590641497.PNG', 1, NULL, '2020-05-27 21:51:37', '2020-05-27 21:52:35', '2020-05-27 21:52:35'),
(25, '1590641562.png', NULL, NULL, NULL, NULL, '/frontend/post/1590641562.png', 1, NULL, '2020-05-27 21:52:42', '2020-05-27 21:52:47', '2020-05-27 21:52:47'),
(26, '1590641694.PNG', NULL, NULL, NULL, NULL, '/frontend/post/1590641694.PNG', 1, NULL, '2020-05-27 21:54:54', '2020-05-27 21:55:00', '2020-05-27 21:55:00'),
(27, '1590641914.PNG', NULL, NULL, NULL, NULL, '/frontend/post/1590641914.PNG', 1, NULL, '2020-05-27 21:58:34', '2020-05-27 21:58:41', '2020-05-27 21:58:41'),
(28, '1590641971.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1590641971.jpg', 1, NULL, '2020-05-27 21:59:31', '2020-05-27 21:59:35', '2020-05-27 21:59:35'),
(29, '1590997514.PNG', NULL, NULL, NULL, NULL, '/frontend/post/1590997514.PNG', 1, NULL, '2020-06-01 00:45:14', '2020-06-01 00:45:14', NULL),
(30, '1590997998.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1590997998.jpg', 1, NULL, '2020-06-01 00:53:18', '2020-06-01 00:53:18', NULL),
(31, '1590998125.png', NULL, NULL, '213', NULL, '/frontend/post/1590998125.png', 1, NULL, '2020-06-01 00:55:25', '2020-06-18 03:09:57', NULL),
(32, '1590998324.png', NULL, NULL, NULL, NULL, '/frontend/post/1590998324.png', 1, NULL, '2020-06-01 00:58:44', '2020-06-01 00:58:44', NULL),
(33, '1590998355.png', NULL, NULL, 'fdsafds', NULL, '/frontend/post/1590998355.png', 1, NULL, '2020-06-01 00:59:15', '2020-06-18 03:11:00', NULL),
(34, '1590998399.png', 'snack', 'snack', 'snack', 'snack', '/frontend/post/1590998399.png', 1, NULL, '2020-06-01 00:59:59', '2020-06-04 02:22:16', NULL),
(35, '1590998449.png', NULL, NULL, NULL, NULL, '/frontend/post/1590998449.png', 1, NULL, '2020-06-01 01:00:49', '2020-06-01 01:00:49', NULL),
(36, '1590999438.png', NULL, NULL, NULL, NULL, '/frontend/post/1590999438.png', 1, NULL, '2020-06-01 01:17:18', '2020-06-01 01:17:18', NULL),
(37, '1590999807.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1590999807.jpg', 1, NULL, '2020-06-01 01:23:27', '2020-06-01 01:23:27', NULL),
(38, '1591262665.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1591262665.jpg', 1, NULL, '2020-06-04 02:24:25', '2020-06-04 02:25:35', '2020-06-04 02:25:35'),
(39, '1591262753.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1591262753.jpg', 1, NULL, '2020-06-04 02:25:54', '2020-06-04 02:26:00', '2020-06-04 02:26:00'),
(40, '1591262822.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1591262822.jpg', 1, NULL, '2020-06-04 02:27:02', '2020-06-04 02:27:12', '2020-06-04 02:27:12'),
(41, '1591262878.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1591262878.jpg', 1, NULL, '2020-06-04 02:27:58', '2020-06-04 02:29:42', '2020-06-04 02:29:42'),
(42, '1592449910.jpg', NULL, NULL, 'ádf21321', NULL, '/frontend/post/1592449910.jpg', 1, NULL, '2020-06-18 03:11:50', '2020-06-18 03:11:55', NULL),
(43, '1592797493.png', NULL, NULL, NULL, NULL, '/frontend/post/1592797493.png', 1, NULL, '2020-06-22 03:44:53', '2020-06-22 03:44:53', NULL),
(44, '1592797542.png', NULL, NULL, NULL, NULL, '/frontend/post/1592797542.png', 1, NULL, '2020-06-22 03:45:42', '2020-06-22 03:45:42', NULL),
(45, '1592797659.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1592797659.jpg', 1, NULL, '2020-06-22 03:47:39', '2020-06-22 03:47:39', NULL),
(46, '1592809874.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1592809874.jpg', 1, NULL, '2020-06-22 07:11:14', '2020-06-22 07:11:14', NULL),
(47, '1592814445.png', NULL, NULL, NULL, NULL, '/frontend/post/1592814445.png', 1, NULL, '2020-06-22 08:27:25', '2020-06-22 08:27:25', NULL),
(48, '1592814459.jpg', NULL, NULL, NULL, NULL, '/frontend/post/1592814459.jpg', 1, NULL, '2020-06-22 08:27:39', '2020-06-22 08:27:39', NULL),
(49, '1592814957.png', NULL, NULL, NULL, NULL, '/frontend/post/1592814957.png', 1, NULL, '2020-06-22 08:35:57', '2020-06-22 08:35:57', NULL),
(50, '1592820261.png', NULL, NULL, NULL, NULL, '/frontend/post/1592820261.png', 1, NULL, '2020-06-22 10:04:21', '2020-06-22 10:04:21', NULL),
(51, '1592820272.PNG', NULL, NULL, NULL, NULL, '/frontend/post/1592820272.PNG', 1, NULL, '2020-06-22 10:04:32', '2020-06-22 10:04:32', NULL),
(52, 'ECSRex1CM87UV0eTVzsB6Cj4UtLU8WrYayfC3oQC.jpeg', NULL, NULL, NULL, NULL, 'https://s3-ap-southeast-1.amazonaws.comimages/20206/ECSRex1CM87UV0eTVzsB6Cj4UtLU8WrYayfC3oQC.jpeg', 1, NULL, '2020-06-30 07:19:04', '2020-06-30 07:19:04', NULL),
(53, 'WTIszujJk1QHFM6sLGe0usJplGUNw2lBCDxevlSC.jpeg', NULL, NULL, NULL, NULL, 'https://news-cmss3-ap-southeast-1.amazonaws.com/', 1, NULL, '2020-06-30 07:21:45', '2020-06-30 07:21:45', NULL),
(54, 'jz5g2IAPnjL2ZLptqTCR0Z5QYimmAbdv4iGZNwRe.png', NULL, NULL, NULL, NULL, 'https://news-cms.s3-ap-southeast-1.amazonaws.com/images/2020/6/jz5g2IAPnjL2ZLptqTCR0Z5QYimmAbdv4iGZNwRe.png', 1, NULL, '2020-06-30 07:23:00', '2020-06-30 07:23:00', NULL),
(55, 'Zcqp4XewJeqfczzpGqN1Qpv7LaN8mCzPwTFRVnHj.jpeg', NULL, NULL, NULL, NULL, 'images/2020/6/Zcqp4XewJeqfczzpGqN1Qpv7LaN8mCzPwTFRVnHj.jpeg', 1, NULL, '2020-06-30 07:50:40', '2020-06-30 07:50:40', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `popular` tinyint(1) DEFAULT 0,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `format` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `thumbnail_id` int(10) UNSIGNED DEFAULT 1,
  `thumbnail_highlight` int(10) UNSIGNED DEFAULT 1,
  `author_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `design_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_posts` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categories_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `tags_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `seo_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 1,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `excerpt`, `is_featured`, `popular`, `status`, `format`, `thumbnail_id`, `thumbnail_highlight`, `author_name`, `design_name`, `layout_name`, `related_posts`, `date`, `description`, `url_video`, `categories_id`, `tags_id`, `seo_id`, `user_id`, `role_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'tieu de  2', 'slug', 'tom tat', 0, 0, 'draft', 'video', 12, 1, 'tac gia', 'desgin', NULL, NULL, '2020-05-15 08:22:19', 'noi dung', NULL, NULL, NULL, NULL, 3, 21, NULL, '2020-05-15 01:34:41', '2020-05-15 01:34:41'),
(4, 'tieu de moi', 'slug', 'tom tăt', 0, 0, 'draft', 'video', 13, 1, 'ta', 'c', NULL, NULL, '2020-05-15 08:40:58', 'noi dungta', 'adf', '[2,10]', '[{\"id\":6,\"title\":\"Video\",\"slug\":\"video\",\"description\":\"tag video\",\"thumbnail_id\":null,\"parent_id\":0,\"taxonomy\":\"tag\",\"seo_id\":null,\"user_id\":1,\"created_at\":\"2020-05-06T10:07:27.000000Z\",\"updated_at\":\"2020-05-06T10:07:41.000000Z\",\"deleted_at\":null}]', NULL, 1, 22, NULL, '2020-05-15 01:43:51', '2020-05-15 01:43:51'),
(6, 'Không chỉ là cột mốc mới trong sự nghiệp, ca khúc \"Blank Space\" còn là nỗi khổ tâm của Taylor Swift', 'khong-chi-la-cot-moc-moi-trong-su-nghiep-ca-khuc-blank-space-con-la-noi-kho-tam-cua-taylor-swift', NULL, 0, 0, 'draft', 'default', 18, 1, NULL, NULL, NULL, 'null', '2020-05-18 04:34:44', '<p style=\"text-align: justify;\"><strong>\"Blank Space\" là ca khúc nằm trong album phòng thu thứ 5 mang tên \"1989\" của Taylor Swift. Trong số bảy ca khúc của \"1989\", \"Blank Space\" được xem như một trong những bản hit góp phần khẳng định tên tuổi cho nữ ca sĩ. Sau hơn 5 năm phát hành, ca khúc thu về hơn 2,5 tỷ lượt xem trên kênh chính thức.</strong></p>\n&nbsp;\n<p style=\"text-align: justify;\">Taylor Swift là một trong những ca sĩ thường xuyên biến các câu chuyện có thật xoay quanh cuộc sống thành nguồn cảm hứng cho các sản phẩm âm nhạc. Dường như trong các ca khúc của cô nàng, người xem luôn cảm nhận được một điều gì đó quen thuộc và có liên quan đến những sự kiện trong cuộc đời của chính nữ ca sĩ. \"Blank Space\" là một trong những minh chứng tiêu biểu nhất cho nhận định trên.</p>\n&nbsp;\n<p style=\"text-align: justify;\"><strong>\"Blank Space\" như một lời thách thức tới anti-fan của Taylor Swift</strong></p>\n&nbsp;\n\n[caption id=\"attachment_70931\" align=\"aligncenter\" width=\"700\"]<img class=\"size-full wp-image-70931\" src=\"https://billboardvn.vn/wp-content/uploads/2020/05/taylor-swift-1a.jpg\" alt=\"\" width=\"700\" height=\"450\" /> \"Blank Space\" là đĩa đơn nằm trong album \"1989\" được Taylor Swift phát hành năm 2014.[/caption]\n<p style=\"text-align: justify;\">Trở thành người nổi tiếng, cuộc sống có phần mệt mỏi và khó chịu hơn khi bị nhiều người soi mói đời tư, để ý hành động và chỉ trích phát ngôn của mình. Điều đó đã khiến giọng ca sinh năm 1989 biến cơn giận của mình thành nguồn cảm hứng để hợp sức cùng Max Martin và Shellback viết ra \"Blank Space\". Mặc dù là ca khúc về tình yêu, nhưng khán giả có thể ngay lập tức hiểu rõ ý nghĩa thật sự của nữ ca sĩ với phần lời <em>\"Tin đồn cứ đồn thổi về em/ Và em đã biết anh nghe về em như thế nào\". </em></p>\n&nbsp;\n<p style=\"text-align: justify;\">Nữ ca sĩ cũng thẳng thắn đề cập với đạo diễn Joseph Kahn về ý tưởng mà cô nàng muốn phát triển trong MV. Qua video của \"Blank Space\", Taylor Swift muốn bày tỏ quan điểm cá nhân trước sự bàn tán của dư luận xoay quanh chuyện tình cảm của cô. Giọng ca \"Shake It Off\" còn thẳng thắn tuyên bố: càng nhiều người đồn thổi và bàn tán, cô càng muốn làm những điều mình thích và sống theo cách mình muốn. Với thông điệp mang tính cá nhân mạnh mẽ này, \"Blank Space\" nhận được rất nhiều sự yêu thích và ủng hộ nhiệt tình từ phía người hâm mộ.</p>\n&nbsp;\n<p style=\"text-align: justify;\"><strong>Phát hành trước thời gian dự kiến nhưng không ngờ đem về thành tích \"khủng\"</strong></p>\n&nbsp;\n\n[caption id=\"attachment_70936\" align=\"aligncenter\" width=\"700\"]<img class=\"size-full wp-image-70936\" src=\"https://billboardvn.vn/wp-content/uploads/2020/05/taylor-swift-a-1.jpg\" alt=\"\" width=\"700\" height=\"450\" /> \"Blank Space\" là một trong những ca khúc được yêu thích trong album phòng thu thứ 5 của Taylor Swift. Ca khúc cũng mang về nhiều thành tích ấn tượng cho nữ ca sĩ.[/caption]\n<p style=\"text-align: justify;\">Thực tế, chính Taylor Swift và cả đạo diễn Joseph Kahn cũng thừa nhận rằng thời gian dự kiến ra mắt \"Blank Space\" không phải là ngày 10/11/2014. Tuy nhiên, do video vô tình bị rò rỉ nên bắt buộc cô phải \"thả neo\" ca khúc sớm hơn dự kiến. Người xưa vẫn nói \"trong cái rủi có cái may\" và câu nói này hoàn toàn ứng với trường hợp của Taylor Swift. Mặc dù ra mắt ở vị trí thứ 18 trong bảng xếp hạng Billboard Hot 100 vào tuần đầu tiên, nhưng \"Blank Space\" đã nhanh chóng leo lên vị trí đầu bảng ngay trong tuần thứ ba và đoạt ngôi vương từ... chính mình với ca khúc quán quân trước đó là \"Shake It Off\". Nhờ vị trí No.1 đến từ \"Blank Space\", Taylor Swift đã thực sự làm nên kì tích khi có hẳn ba ca khúc trong cùng album \"1989\" đứng nhất tại bảng xếp hạng Billboard Hot 100 bao gồm \"Bad Blood\", \"Shake It Off\" và \"Blank Space\".</p>\n&nbsp;\n<p style=\"text-align: justify;\">Không dừng lại ở đó, \"Blank Space\" cũng đạt được vị trí quán quân trên bảng xếp hạng Hot Digital Songs với doanh số 155.000 đơn vị được tiêu thụ trong tuần đầu tiên. Đây cũng là ca khúc thứ chín của giọng ca sinh năm 1989 đạt thứ hạng No.1 trong bảng xếp hạng âm nhạc này. Với thành tích kể trên, Taylor Swift trở thành nghệ sĩ xếp hạng ba, đồng hạng với Eminem trong số những nghệ sĩ có nhiều ca khúc đứng đầu bảng xếp hạng Hot Digital Songs nhất.</p>\n&nbsp;\n<p style=\"text-align: justify;\"><strong>\"Blank Space\" - Bước ngoặt đánh dấu sự thay đổi trong phong cách âm nhạc của \"công chúa nhạc đồng quê\"</strong></p>\n&nbsp;\n<p style=\"text-align: justify;\">Cùng album \"1989\", ca khúc \"Blank Space\" được xem là bước tiến mới trong hành trình âm nhạc của Taylor Swift để thoát khỏi danh xưng \"công chúa nhạc đồng quê\". Không còn hình ảnh nhẹ nhàng, thanh thoát cùng những giai điệu ngọt ngào mà thay vào đó là hình ảnh mới đầy táo bạo và có phần điên cuồng.</p>\n&nbsp;\n<p style=\"text-align: justify;\">\"Blank Space\" thuộc thể loại Electropop, mang âm hưởng Minimal Pop mạnh mẽ dựa theo cảm hứng từ dòng nhạc Pop vào cuối thập niên 1980. Với bước chuyển mình trong phong cách âm nhạc, hiển nhiên nữ ca sĩ không tránh khỏi những lời khen chê khác nhau. Dù vậy, chẳng ai dám lên tiếng phủ nhận về sự cuốn hút cũng như thành công mà ca khúc lẫn album mang lại. Kết quả ấn tượng của \"Blank Space\" và album \"1989\" góp phần quan trọng trong việc giúp Taylor Swift được vinh danh là \"Nghệ sĩ của thập niên\" tại Lễ trao giải âm nhạc Mỹ (AMAs). Đồng thời, nữ ca sĩ cũng được xướng tên đầu tiên trong danh sách \"Nữ ca sĩ thành công nhất trong thập kỷ\" của Billboard.</p>\n&nbsp;\n<p style=\"text-align: justify;\"><strong>\"Blank Space\": Nỗi khổ tâm của chính Taylor Swift trong chuyện tình yêu</strong></p>\n&nbsp;\n\n[caption id=\"attachment_70945\" align=\"aligncenter\" width=\"700\"]<img class=\"size-full wp-image-70945\" src=\"https://billboardvn.vn/wp-content/uploads/2020/05/taylor-swift-1b.jpg\" alt=\"\" width=\"700\" height=\"450\" /> Ngoài việc đánh dấu bước chuyển mình trong âm nhạc của \"công chúa nhạc đồng quê\", \"Blank Space\" còn là ca khúc thể hiện nỗi khổ tâm của Taylor Swift.[/caption]\n<p style=\"text-align: justify;\">Có thể nói, \"Blank Space\" chính là lời thách thức, mỉa mai giới truyền thông hay anti-fan từ cô ca sĩ sinh năm 1989. Nhưng đồng thời ca khúc cũng thể hiện rõ nỗi niềm, sự khổ tâm của Taylor Swift trong câu chuyện tình cảm của chính mình. Mỗi người trong cuộc đời đều được xem là một mảnh ghép chưa hoàn chỉnh, đó là lý do mà ai cũng phải tất tả, ngược xuôi để kiếm tìm mảnh ghép còn lại của cuộc đời.</p>\n&nbsp;\n<p style=\"text-align: justify;\">Làm thế nào để biết được đâu là \"chân ái\" của mình, bạn chẳng thể làm gì khác ngoài những phép thử. Phải tạo nên một câu chuyện tình, đắm chìm trong mối quan hệ đó mới có thể đưa ra kết luận chính xác. Taylor Swift cũng vậy, cô nàng chỉ là đang trên đường tìm kiếm tình yêu đích thực của mình mà thôi. Vậy cớ gì mọi người lại bàn tán, phán xét cho rằng cô nàng là người hẹn hò vô tội vạ.</p>\n&nbsp;\n<p style=\"text-align: justify;\"><em>\"Tin đồn cứ đồn thổi về em thế nên chúng ta hãy là bạn bè đi đã/ Em đang chết dần để xem chuyện này như thế nào/ Tình yêu này sẽ là mãi mãi hoặc sẽ sớm lụi tàn/ Em có cả danh sách dài các anh người yêu cũ/ Họ sẽ rỉ tai với anh rằng em điên lắm\"</em> là những gì Taylor Swift muốn bày tỏ. Câu từ trong ca khúc có chút mỉa mai, nhưng cũng có phần chua xót. Chính vì những lời đồn thổi mà Taylor Swift trong MV chẳng thể thoải mái hạnh phúc với tình yêu của mình. Cảm giác lo lắng, nỗi lo sợ về sự đổ vỡ, lừa dối, phản bội khiến cô nàng như phát điên và biến thành một con người hoàn toàn khác so với lúc ban đầu. <em>\"Tại sao tôi chẳng thể tự do sống với tình yêu của mình?\"</em> dường như là câu hỏi ngụ ý mà Taylor Swift muốn thổ lộ qua \"Blank Space\".</p>\n&nbsp;\n<p style=\"text-align: center;\"><iframe src=\"https://www.youtube.com/embed/e-ORhEE9VVg\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>\n<p style=\"text-align: center;\"><em>MV \"Blank Space\" - Taylor Swift</em></p>', NULL, '[2,9]', '[6]', NULL, 1, 0, NULL, '2020-05-17 21:44:54', '2020-05-17 21:44:54'),
(7, 'Ấm áp và dịu dàng như thế này thì chỉ có thể là... Taylor Swift', 'am-ap-va-diu-dang-nhu-the-nay-thi-chi-co-the-la-taylor-swift', 'Mới đây, các Swifties lại được một phen bất ngờ từ thần tượng của mình. Cụ thể, Taylor Swift gửi thư cảm ơn và dành lời khen cho một fan nhí vì cô bé đã cổ vũ tinh thần cũng như động viên các nhân viên bưu chính trong suốt mùa dịch', 0, 0, 'draft', 'default', 19, 1, NULL, NULL, NULL, 'null', '2020-05-18 04:58:59', '<p style=\"text-align: justify;\"><span style=\"font-weight: 400;\">Câu chuyện bắt đầu bằng việc Emerson Weber - một học sinh 11 tuổi đến từ Sioux Falls đã viết một lá thư để cảm ơn những nhân viên bưu chính luôn giúp gửi những lá thư của cô bé trong suốt mùa dịch. Ngay sau khi bức thư của Emerson Weber được chia sẻ trong một bản tin Dịch vụ bưu chính nội bộ của Mỹ, mọi người bắt đầu thực hiện và gửi nhau những lá thư nhằm tỏ lòng biết ơn các \"anh hùng thầm lặng\". Bên cạnh đó, các bức thư của Emerson Weber và bạn bè cũng đề cập đến tình yêu chung mà họ dành cho âm nhạc của Taylor Swift. </span></p>', NULL, '[2,9]', '[]', NULL, 1, 0, NULL, '2020-05-17 21:59:56', '2020-05-17 21:59:56'),
(8, 'Ấm áp và dịu dàng như thế này thì chỉ có thể là... Taylor Swift', 'am-ap-va-diu-dang-nhu-the-nay-thi-chi-co-the-la-taylor-swift', 'Mới đây, các Swifties lại được một phen bất ngờ từ thần tượng của mình. Cụ thể, Taylor Swift gửi thư cảm ơn và dành lời khen cho một fan nhí vì cô bé đã cổ vũ tinh thần cũng như động viên các nhân viên bưu chính trong suốt mùa dịch', 0, 0, 'draft', 'default', 19, 1, NULL, NULL, NULL, 'null', '2020-05-18 04:58:59', '<p style=\"text-align: justify;\"><span style=\"font-weight: 400;\">Câu chuyện bắt đầu bằng việc Emerson Weber - một học sinh 11 tuổi đến từ Sioux Falls đã viết một lá thư để cảm ơn những nhân viên bưu chính luôn giúp gửi những lá thư của cô bé trong suốt mùa dịch. Ngay sau khi bức thư của Emerson Weber được chia sẻ trong một bản tin Dịch vụ bưu chính nội bộ của Mỹ, mọi người bắt đầu thực hiện và gửi nhau những lá thư nhằm tỏ lòng biết ơn các \"anh hùng thầm lặng\". Bên cạnh đó, các bức thư của Emerson Weber và bạn bè cũng đề cập đến tình yêu chung mà họ dành cho âm nhạc của Taylor Swift. </span></p>', NULL, '[2,9]', '[]', NULL, 1, 0, NULL, '2020-05-17 22:03:30', '2020-05-17 22:03:30'),
(9, 'Vô tình trở thành hàng xóm, Adele kết thân với Katy Perry nhờ tiếng gõ cửa \"Hello! It\'s me\"', 'vo-tinh-tro-thanh-hang-xom-adele-ket-than-voi-katy-perry-nho-tieng-go-cua-hello-its-me', 'Mặc dù không hợp tác với Taylor Swift ở hiện tại nhưng tương lai xa lại là điều Katy Perry mong chờ. Bên cạnh đó, Katy cũng bật mí về mối duyên hàng xóm đặc biệt cùng Adele. Chính \"họa mi nước Anh\" đã bước qua gõ cửa và nói câu: \"Hello! It\'s me\" mới khiến chủ nhân \"Daisies\" nhận ra mặt người quen', 0, 0, 'draft', 'default', 17, 1, NULL, NULL, NULL, '[5]', '2020-05-18 05:03:48', '<p style=\"text-align: justify;\">Theo như thông báo đã xác nhận trước đó, album phòng thu thứ sáu \"KP5\" của Katy Perry sẽ chính thức lên kệ vào ngày 14/8 tới đây. Bên cạnh loạt thông tin về \"KP5\" thì câu hỏi được đặt ra nhiều nhất lúc này chính là xác suất hợp tác giữa Katy và Taylor trong tương lai. Mặc dù biết rằng sự thật sẽ khiến các Katycats lẫn Sweetest tiếc nuối nhưng Katy vẫn phải lên tiếng đính chính: <em>\"Không, tôi và Taylor không hợp tác trong album tới đây\"</em>.</p>', NULL, '[2,9]', '[6]', NULL, 1, 0, NULL, '2020-05-17 22:05:07', '2020-05-17 22:05:07'),
(10, 'Dua Lipa hết lời khen ngợi nhóm nhảy đến từ Việt Nam qua màn thể hiện vũ đạo cho album \"Future Nostalgia\"', 'dua-lipa-het-loi-khen-ngoi-nhom-nhay-den-tu-viet-nam-qua-man-the-hien-vu-dao-cho-album-future-nostalgia', 'Các video \"reaction\" đã không còn quá xa lạ với người dùng các nền tảng video, đặc biệt là Youtube. Thông thường, người hâm mộ sẽ xem và ghi lại những cảm nhận đầu tiên của mình đối với sản phẩm mới của nghệ sĩ. Nhưng vừa qua, chính Dua Lipa đã ngồi lại và thể hiện sự thích thú của mình đối với Hanoi XGirls - một nhóm nhảy đến từ Việt Nam', 0, 0, 'draft', 'default', 16, 1, NULL, NULL, NULL, '[8]', '2020-05-18 09:35:24', '<p style=\"text-align: justify;\">Vào cuối tuần qua, bản Dance Mashup các ca khúc trong album \"Future Nostalgia\" do nhóm Hanoi XGirls thể hiện đã được chính Dua Lipa thưởng thức. Không những thế, nữ ca sĩ đã không ngại dành cho nhóm nhảy đến từ Việt Nam những lời \"có cánh\" về màn trình diễn của họ. Việc này không chỉ khiến các thành viên của Hanoi XGirls hết sức vui mừng mà còn làm người hâm mộ của Dua Lipa tại Việt Nam vừa bất ngờ, vừa phấn khích.</p>', NULL, '[2,10]', '[6]', NULL, 1, 0, NULL, '2020-05-18 02:37:10', '2020-05-18 02:37:10'),
(11, 'Dua Lipa hết lời khen ngợi nhóm nhảy đến từ Việt Nam qua màn thể hiện vũ đạo cho album \"Future Nostalgia\"', 'dua-lipa-het-loi-khen-ngoi-nhom-nhay-den-tu-viet-nam-qua-man-the-hien-vu-dao-cho-album-future-nostalgia', 'Các video \"reaction\" đã không còn quá xa lạ với người dùng các nền tảng video, đặc biệt là Youtube. Thông thường, người hâm mộ sẽ xem và ghi lại những cảm nhận đầu tiên của mình đối với sản phẩm mới của nghệ sĩ. Nhưng vừa qua, chính Dua Lipa đã ngồi lại và thể hiện sự thích thú của mình đối với Hanoi XGirls - một nhóm nhảy đến từ Việt Nam', 0, 0, 'draft', 'default', 16, 1, NULL, NULL, NULL, '[8]', '2020-05-18 09:42:02', '<p style=\"text-align: justify;\">Vào cuối tuần qua, bản Dance Mashup các ca khúc trong album \"Future Nostalgia\" do nhóm Hanoi XGirls thể hiện đã được chính Dua Lipa thưởng thức. Không những thế, nữ ca sĩ đã không ngại dành cho nhóm nhảy đến từ Việt Nam những lời \"có cánh\" về màn trình diễn của họ. Việc này không chỉ khiến các thành viên của Hanoi XGirls hết sức vui mừng mà còn làm người hâm mộ của Dua Lipa tại Việt Nam vừa bất ngờ, vừa phấn khích.</p>', NULL, '[2,10]', '[6]', NULL, 1, 0, NULL, '2020-05-18 02:43:21', '2020-05-18 02:43:21'),
(12, 'tieu de', 'tieu-de', 'tom tat', 0, 0, 'pending', 'default', 13, 1, NULL, NULL, '3', '[7,8]', '2020-05-18 11:17:53', 'noi dung', NULL, '[2,10]', '[6]', NULL, 1, 20, NULL, '2020-05-18 04:18:44', '2020-05-18 04:18:44'),
(13, 'Lee Min Ho đùa giỡn với bạn diễn', 'lee-min-ho-dua-gion-voi-ban-dien', 'Quân vương bất diệt hiện phát sóng 10 trong tổng số 16 tập, kém thu hút người xem vì diễn biến chậm, tình tiết khó hiểu. Tác phẩm xoay quanh sự tồn tại song song giữa Đại Hàn đế quốc - thời quân chủ lập hiến và Đại Hàn dân quốc - Hàn Quốc hiện đại. Mỗi người ở thời quân chủ sẽ có một phiên bản tương tự thời hiện đại.', 0, 0, 'publish', 'video', 14, 1, 'Hiểu Nhân', 'video: SBS', '1', '[8,6]', '2020-05-19 04:42:25', '<p><em>Qu&acirc;n vương bất diệt</em>&nbsp;hiện ph&aacute;t s&oacute;ng 10 trong tổng số 16 tập,&nbsp;k&eacute;m thu h&uacute;t&nbsp;người xem v&igrave; diễn biến chậm, t&igrave;nh tiết kh&oacute; hiểu. T&aacute;c phẩm xoay quanh sự tồn tại song song giữa Đại H&agrave;n đế quốc - thời qu&acirc;n chủ lập hiến v&agrave; Đại H&agrave;n d&acirc;n quốc - H&agrave;n Quốc hiện đại. Mỗi người ở thời qu&acirc;n chủ sẽ c&oacute; một phi&ecirc;n bản tương tự thời hiện đại. Ho&agrave;ng đế Lee Gon (Lee Min Ho) từ Đại H&agrave;n đế quốc, bước qua c&aacute;nh cửa thần kỳ sang H&agrave;n Quốc năm 2019. Tại đ&acirc;y, anh gặp v&agrave; y&ecirc;u Jung Tae Eul (<strong>Kim Go Eun&nbsp;đ&oacute;ng</strong>) - nữ cảnh s&aacute;t - giống &acirc;n nh&acirc;n cứu mạng anh 25 năm trước. Kh&aacute;n giả nhận x&eacute;t Lee Min Ho v&agrave; Kim Go Eun&nbsp;thiếu tương t&aacute;c, kh&ocirc;ng tạo được cảm x&uacute;c khi v&agrave;o vai cặp t&igrave;nh nh&acirc;n.</p>', 'https://www.youtube.com/watch?v=sE1qLDIetwI', '[2,9]', '[6]', 1, 1, 19, NULL, '2020-05-18 21:43:40', '2020-05-18 21:43:40'),
(14, 'Banner popup 14', 'banner-popup', 'ád', 1, 0, 'publish', 'default', 14, 18, '21', '21', '3', '[8,6]', '2020-05-17 21:38:22', '<p>ads</p>', 'https://www.youtube.com/watch?v=gtAQmqC6mAA&list=RDgtAQmqC6mAA&index=1', '[2,10]', '[6]', 3, 1, 0, NULL, '2020-05-19 01:38:59', '2020-06-03 20:15:48'),
(15, 'Snacks', 'snacks', 'adf', 0, 0, 'private', 'default', 13, 1, 'Hiểu Nhân', 'ad', '2', '[8]', '2020-05-20 20:18:50', '<p>adfaf</p>\n<p>&nbsp;</p>\n<p><img src=\"http://127.0.0.1:8000/images/frontend/post/1589440003.png\" /></p>\n<p class=\"wp-caption-text\">Masthead desktop</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>', NULL, '[2,10,4]', '[6]', 4, 1, 0, NULL, '2020-05-21 03:19:29', '2020-06-22 03:10:55'),
(16, '‘Sách về Chủ tịch Hồ Chí Minh luôn thu hút độc giả’', 'sach-ve-chu-tich-ho-chi-minh-luon-thu-hut-doc-gia', 'Tư tưởng của Hồ Chí Minh đến hôm nay vẫn là ngọn đuốc soi đường trong sự nghiệp phát triển đất nước, vì thế luôn cần thêm nữa những cuốn sách, công trình về Người.', 0, 0, 'pending', 'default', 13, 1, 'Hiểu Nhân', 'ad', '2', '[15]', '2020-05-19 16:30:15', '<p><strong>Tối 10/6, MV &ldquo;Bao La Việt Nam&rdquo; qua phần thể hiện của 12 nghệ sĩ: Minh Hằng, nh&oacute;m X2X, V&otilde; Ho&agrave;ng Yến, Hương Ly, LyLy, Han Sara, B&ugrave;i C&ocirc;ng Nam, Li&ecirc;n Bỉnh Ph&aacute;t, Phan Ng&acirc;n, Anna (SGO48), Vinh Trần, L&ecirc; Ngọc Trinh&hellip; đ&atilde; được ch&iacute;nh thức ph&aacute;t h&agrave;nh tr&ecirc;n k&ecirc;nh YouTube của X2X.</strong></p>\n<p>&nbsp;</p>\n<p>Được biết, Facebook Việt Nam đ&atilde; kết hợp c&ugrave;ng Bộ Kế hoạch Đầu tư v&agrave; c&aacute;c doanh nghiệp ph&aacute;t động chương tr&igrave;nh &ldquo;Tự h&agrave;o Việt Nam&rdquo; ra mắt MV &ldquo;Bao La Việt Nam&rdquo;. Sản phẩm được ra mắt với mục đ&iacute;ch th&uacute;c đẩy sự quan t&acirc;m mạnh mẽ của cộng đồng trong nước cũng như quốc tế v&agrave;o lĩnh vực đầu tư kinh doanh v&agrave; ph&aacute;t triển du lịch.</p>\n<p><img src=\"http://127.0.0.1:8000/images/frontend/post/1592797542.png\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p>Trước đ&oacute;, teaser của MV đ&atilde; được ph&aacute;t h&agrave;nh v&agrave;o ng&agrave;y 8/6 v&agrave; thu h&uacute;t được sự ch&uacute; &yacute; của đ&ocirc;ng đảo kh&aacute;n giả. Nhờ th&ocirc;ng điệp &yacute; nghĩa v&agrave; lời ca bắt tai, MV đ&atilde; nhanh ch&oacute;ng tan tỏa tr&ecirc;n mạng x&atilde; hội. Ca kh&uacute;c &ldquo;Bao La Việt Nam&rdquo; do nh&oacute;m X2X kết hợp Mili-K s&aacute;ng t&aacute;c, với ca từ n&oacute;i về niềm tự h&agrave;o Việt Nam v&agrave; giai điệu vui tươi. Theo đ&oacute;, X2X hy vọng sản phẩm của m&igrave;nh sẽ chạm đến tr&aacute;i tim của tất cả những con người Việt Nam y&ecirc;u c&aacute;i đẹp của thi&ecirc;n nhi&ecirc;n, đất nước v&agrave; con người Việt Nam.</p>\n<p>&nbsp;</p>\n<figure id=\"attachment_74466\" class=\"wp-caption alignnone\" aria-describedby=\"caption-attachment-74466\"><img class=\"wp-image-74466 size-full td-animation-stack-type1-2\" src=\"https://billboardvn.vn/wp-content/uploads/2020/06/Ph%C3%A1t-H%E1%BB%93_X2X-scaled.jpg\" sizes=\"(max-width: 1707px) 100vw, 1707px\" srcset=\"https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-scaled.jpg 1707w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-150x225.jpg 150w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-384x576.jpg 384w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-768x1152.jpg 768w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-1024x1536.jpg 1024w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-1365x2048.jpg 1365w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-696x1044.jpg 696w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-1068x1602.jpg 1068w, https://billboardvn.vn/wp-content/uploads/2020/06/Ph&aacute;t-Hồ_X2X-280x420.jpg 280w\" alt=\"\" width=\"1707\" height=\"2560\" />\n<figcaption id=\"caption-attachment-74466\" class=\"wp-caption-text\">Th&agrave;nh vi&ecirc;n Ph&aacute;t Hồ nh&oacute;m X2X.</figcaption>\n</figure>\n<p>Ngo&agrave;i ra, kh&ocirc;ng thể kh&ocirc;ng kể đến sự g&oacute;p mặt của d&agrave;n sao trong dự &aacute;n n&agrave;y cũng l&agrave; một trong những điểm g&acirc;y ấn tượng với kh&aacute;n giả. Lồng gh&eacute;p những h&igrave;nh ảnh Việt Nam tươi đẹp từ Bắc tới Nam, ekip c&ugrave;ng c&aacute;c nghệ sĩ đ&atilde; c&ugrave;ng thực hiện chuyến đi 10 ng&agrave;y r&ograve;ng r&atilde; để c&oacute; để đưa v&agrave;o tất cả những danh lam thắng cảnh nổi tiếng của mảnh đất h&igrave;nh chữ S.</p>\n<p>&nbsp;</p>\n<p><img src=\"../../../images/frontend/post/1589356603.png\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p><img src=\"../../../images/frontend/post/1592797493.png\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p><br /><br /></p>', NULL, '[2,4]', '[6]', 5, 1, 0, NULL, '2020-05-21 03:31:24', '2020-06-22 03:45:57'),
(18, 'Có thumbnail', 'co-thumbnail', 'Có thumbnail', 0, 0, 'draft', 'default', 15, 1, 'Có thumbnail', 'Có thumbnail', '0', '[]', '2020-05-20 20:35:44', '<p>C&oacute; thumbnail</p>', NULL, '[]', '[]', 7, 1, 0, NULL, '2020-05-21 03:35:57', '2020-05-21 21:46:39'),
(20, 'chưa có thumbnail', 'chua-co-thumbnail', 'chưa có thumbnail', 1, 0, 'draft', 'default', 34, 1, NULL, NULL, '0', '[]', '2020-05-21 06:00:50', '<p class=\"ql-align-center\">true</p><p>ấdfsadf</p><p></p><p></p><p>adsf</p><p>adf</p><p>ad</p><p class=\"ql-align-center\"><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/87jLWXE2hn4\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen=\"\"></iframe></p><p><br></p><p></p><p></p><p></p><p></p>', NULL, '[]', '[]', 9, 1, 0, NULL, '2020-05-21 20:00:58', '2020-06-22 03:11:11'),
(21, 'Zalo 0909878369', 'teaata', 'ad', 0, 0, 'draft', 'default', 11, 1, NULL, NULL, '0', '[]', '2020-05-19 20:11:18', '<p>ad</p>\n<p>3</p>\n<p>&nbsp;</p>\n<p><img src=\"http://127.0.0.1:8000/images/frontend/post/1589439993.png\" /></p>', NULL, '[]', '[]', 11, 1, 0, NULL, '2020-05-25 02:12:02', '2020-05-27 03:10:15'),
(22, 'test tinycme', 'test-tinycme2', 'tom tat', 1, 0, 'draft', 'default', 13, 15, NULL, NULL, '0', '[]', '2020-05-22 10:52:34', '<p>NỘi dung mới</p>\n<p>&nbsp;</p>\n<p>akjflakjdlf</p>\n<p><img src=\"http://127.0.0.1:8000/images/frontend/post/1590998399.png\" /></p>\n<p class=\"wp-caption-text\">snack</p>\n<p>&nbsp;</p>\n<p>adsfasjlf</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>c&oacute; video</p>\n<p>&nbsp;</p>\n<p><iframe src=\"//www.youtube.com/embed/fl-uDtLQZno\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>\n<p>&nbsp;</p>\n<p>C&oacute; h&igrave;nh ảnh</p>\n<p><img src=\"../../../images//frontend/post/1589440003.png\" /></p>\n<p>kadkl</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>', NULL, '[2,10]', '[]', 12, 1, 0, NULL, '2020-05-27 02:56:59', '2020-06-24 09:29:57'),
(23, 'teaat2', 'teaat', 'adsf', 1, 1, 'publish', 'default', 18, 17, NULL, NULL, '0', '[15]', '2020-06-15 23:48:57', '<p>adf</p>\n<p><img src=\"../../../images/frontend/post/1590998399.png\" /></p>\n<p>&nbsp;</p>\n<p><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>', NULL, '[2,10]', '[6,16,20]', 14, 1, 0, NULL, '2020-06-03 00:38:53', '2020-06-22 03:00:32'),
(24, 'trestadf', 'trestadf-2', 'dà', 0, 1, 'publish', 'default', 19, NULL, NULL, NULL, '0', '[]', '2020-06-12 16:17:55', '<p><img src=\"http://127.0.0.1:8000/images/frontend/post/1589440003.png\" /></p>\n<p class=\"wp-caption-text\">Masthead desktop</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><img src=\"http://127.0.0.1:8000/images/frontend/post/1592797659.jpg\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><img src=\"http://127.0.0.1:8000/images/frontend/post/1589777265.jpg\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><img src=\"http://127.0.0.1:8000/images/frontend/post/1590997514.PNG\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><iframe src=\"//www.youtube.com/embed/syioRug9Mic\" width=\"560\" height=\"315\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe></p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><img src=\"http://127.0.0.1:8000/images/frontend/post/1590998449.png\" /></p>\n<p class=\"wp-caption-text\">null</p>\n<p class=\"wp-caption-text\">&nbsp;</p>\n<p class=\"wp-caption-text\"><img src=\"http://127.0.0.1:8000/images/frontend/post/1592797659.jpg\" /></p>\n<p class=\"wp-caption-text\">null</p>', NULL, '[2,10]', '[]', 17, 1, 0, NULL, '2020-06-09 21:31:27', '2020-06-24 09:34:15'),
(25, 'teaat', 'teaat-2', 'ad', 0, 0, 'draft', 'default', 36, NULL, NULL, NULL, '0', '[]', '2020-06-24 09:34:58', '<p>adf</p>', NULL, '[]', '[]', 22, 1, 0, NULL, '2020-06-24 09:37:56', '2020-06-24 09:37:56');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'api', '2020-04-08 03:26:21', '2020-04-08 03:26:21'),
(2, 'Tác giả', 'api', '2020-04-08 03:32:42', '2020-05-21 01:29:25'),
(19, 'supper_admin', 'api', '2020-04-22 00:44:28', '2020-04-22 00:44:28'),
(23, 'Biên tập viên', 'api', '2020-05-21 01:32:19', '2020-05-21 01:32:19'),
(24, 'Cộng tác viên', 'api', '2020-05-21 01:34:20', '2020-05-21 01:34:20');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 19),
(2, 1),
(2, 19),
(3, 1),
(3, 19),
(4, 1),
(4, 19),
(5, 1),
(5, 19),
(6, 1),
(6, 19),
(7, 1),
(7, 19),
(8, 1),
(8, 19),
(9, 1),
(9, 2),
(9, 19),
(9, 23),
(9, 24),
(10, 1),
(10, 19),
(11, 1),
(11, 19),
(12, 1),
(12, 19),
(13, 1),
(13, 2),
(13, 19),
(13, 23),
(13, 24),
(14, 1),
(14, 2),
(14, 19),
(14, 23),
(14, 24),
(15, 1),
(15, 19),
(16, 1),
(16, 19),
(17, 1),
(17, 2),
(17, 19),
(17, 23),
(17, 24),
(18, 1),
(18, 2),
(18, 19),
(18, 23),
(18, 24),
(19, 1),
(19, 2),
(19, 19),
(19, 23),
(19, 24),
(20, 1),
(20, 2),
(20, 19),
(20, 23),
(21, 1),
(21, 2),
(21, 19),
(21, 23),
(21, 24),
(22, 1),
(22, 2),
(22, 19),
(22, 23),
(22, 24),
(23, 1),
(23, 2),
(23, 19),
(23, 23),
(23, 24),
(24, 1),
(24, 2),
(24, 19),
(24, 23),
(24, 24),
(25, 1),
(25, 2),
(25, 19),
(25, 23),
(26, 1),
(26, 19),
(26, 23),
(27, 1),
(27, 19),
(27, 23),
(28, 1),
(28, 19),
(28, 23),
(29, 1),
(29, 19),
(30, 1),
(30, 19),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `seo`
--

CREATE TABLE `seo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keywork` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `seo`
--

INSERT INTO `seo` (`id`, `title`, `description`, `keywork`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Lee Min Ho đùa giỡn với bạn diễn seo', 'Quân vương bất diệt hiện phát sóng 10 trong tổng số 16 tập, kém thu hút người xem vì diễn biến chậm, tình tiết khó hiểu. Tác phẩm xoay quanh sự tồn tại song song giữa Đại Hàn đế quốc - thời quân chủ lập hiến và Đại Hàn dân quốc - Hàn Quốc hiện đại. Mỗi người ở thời quân chủ sẽ có một phiên bản tương tự thời hiện đại.', NULL, '2020-05-18 21:43:40', '2020-05-18 21:43:40', NULL),
(2, 'adf', 'a3', NULL, '2020-05-19 01:38:47', '2020-05-19 01:38:47', NULL),
(3, 'adf123', 'a3a', NULL, '2020-05-19 01:38:59', '2020-05-19 21:27:41', NULL),
(4, 'ad', 'ad', NULL, '2020-05-21 03:19:29', '2020-05-21 03:19:29', NULL),
(5, '‘Sách về Chủ tịch Hồ Chí Minh luôn thu hút độc giả’', 'Tư tưởng của Hồ Chí Minh đến hôm nay vẫn là ngọn đuốc soi đường trong sự nghiệp phát triển đất nước, vì thế luôn cần thêm nữa những cuốn sách, công trình về Người.', NULL, '2020-05-21 03:31:24', '2020-05-21 03:31:24', NULL),
(6, 'Thiếu thumbnail2', 'Thiếu thumbnail 1', NULL, '2020-05-21 03:35:15', '2020-05-21 03:35:15', NULL),
(7, 'Có thumbnail', 'Có thumbnail', NULL, '2020-05-21 03:35:57', '2020-05-21 03:35:57', NULL),
(8, 'khong chon thumbnail', 'khong chon thumbnail', NULL, '2020-05-21 19:58:15', '2020-05-21 19:58:15', NULL),
(9, 'chưa có thumbnail', 'chưa có thumbnail', NULL, '2020-05-21 20:00:58', '2020-05-21 20:00:58', NULL),
(10, NULL, NULL, NULL, '2020-05-25 02:11:54', '2020-05-25 02:11:54', NULL),
(11, 'Zalo 0909878369', 'ad', NULL, '2020-05-25 02:12:01', '2020-05-25 02:12:01', NULL),
(12, 'test tinycme', 'tom tat', NULL, '2020-05-27 02:56:59', '2020-05-27 02:56:59', NULL),
(13, 'Banner popup2', 'ad2', NULL, '2020-06-01 21:08:33', '2020-06-01 21:29:34', NULL),
(14, 'teaat', 'adsf', NULL, '2020-06-03 00:38:53', '2020-06-03 00:38:53', NULL),
(15, 'tead12', 'adf', NULL, '2020-06-09 21:29:36', '2020-06-09 21:29:36', NULL),
(16, 'tead12', 'adf', NULL, '2020-06-09 21:30:06', '2020-06-09 21:30:06', NULL),
(17, 'trestadf', 'dà', NULL, '2020-06-09 21:31:27', '2020-06-09 21:31:27', NULL),
(18, 'teaat', 'ad', NULL, '2020-06-24 09:35:12', '2020-06-24 09:35:12', NULL),
(19, 'teaat', 'ad', NULL, '2020-06-24 09:35:23', '2020-06-24 09:35:23', NULL),
(20, 'teaat', 'ad', NULL, '2020-06-24 09:36:35', '2020-06-24 09:36:35', NULL),
(21, 'teaat', 'ad', NULL, '2020-06-24 09:37:42', '2020-06-24 09:37:42', NULL),
(22, 'teaat', 'ad', NULL, '2020-06-24 09:37:55', '2020-06-24 09:37:55', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `slider`
--

CREATE TABLE `slider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_id` int(10) UNSIGNED DEFAULT NULL,
  `slider_category_id` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pseudonym` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_id` int(10) UNSIGNED DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_supperadmin` tinyint(1) DEFAULT 0,
  `banned` tinyint(1) DEFAULT 0,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `pseudonym`, `phone_number`, `photo_id`, `description`, `is_supperadmin`, `banned`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Nguyễn Văn Tài', NULL, '12', NULL, NULL, 0, 0, 'vantai.itc@gmail.com', NULL, '$2y$10$2VKg8aap.S18ilpY.F14Ou433/Qp0MEmbc1I8cG/mUltq9crYx6Ri', NULL, '2020-04-06 03:28:49', '2020-04-21 21:28:38'),
(3, 'manager', NULL, NULL, NULL, NULL, 0, 0, 'manager@billboardvn.vn', NULL, '$2y$10$8AWQ4cQNtDgB.zWxRW7yjuGDlHJCXz00RBEZhhsi/Uu47MNeqcMG2', NULL, '2020-04-07 03:39:58', '2020-04-07 03:39:58'),
(4, 'VanTaiNguyen', NULL, NULL, NULL, NULL, 0, 0, 'admin@gmail.com', NULL, '$2y$10$2VKg8aap.S18ilpY.F14Ou433/Qp0MEmbc1I8cG/mUltq9crYx6Ri', NULL, '2020-04-08 03:26:21', '2020-04-08 03:26:21'),
(9, 'Nguyễn Văn Tài 2', NULL, NULL, NULL, NULL, 0, 0, 'vantai.itc111@gmail.com', NULL, '$2y$10$WA.tvO406sdhI4x.Dat87Omxdyqws6qPHSPSG1Z6olfyxfpZPoQoe', NULL, '2020-04-17 02:11:50', '2020-04-17 02:11:50'),
(16, 'ad1', NULL, NULL, NULL, NULL, 0, 0, 'jladsf@gmail.com', NULL, '$2y$10$jX14HLRSlmgK44.2l9TS2e3yjBZnZ4i62DdhwYX3rn5bulzU24NJa', NULL, '2020-04-17 02:41:10', '2020-04-17 02:41:10'),
(39, '69', '69', '1', NULL, NULL, 0, 0, 'a69@gmail.com', NULL, '$2y$10$R9Urkw15BBm1KDrYCgJNuuqX40F8.bFUi3bjV.jf/JsEuhK.AdED.', NULL, '2020-04-21 02:45:18', '2020-04-21 03:55:13'),
(41, 'Nguyễn Văn 41', 'ad41', '123', NULL, 'ad', 0, 0, 'a71@gmail.com', NULL, '$2y$10$59SeuoL7RjSQA6QPR7Femeiw9Ye1zyfnkof1kqvVPUfCCmyb.FVIy', NULL, '2020-04-21 03:03:45', '2020-04-21 20:16:42'),
(42, 'T.A', 'Ta', '0123456789', NULL, 'ad', 0, 0, 'ta@bbvn.vn', NULL, '$2y$10$bDkRw6GkRF/GFHerzPBEkekTuhhBHXqWI4lXwpRCssfxd7DagASX.', NULL, '2020-04-22 01:51:41', '2020-06-03 19:26:43'),
(45, 'test', NULL, '123456', NULL, 'a', 0, 0, 'test@gmail.com', NULL, '$2y$10$0XCJBr4e4F3bU02JO1H3z.Q7LkIIzoev8MxHJpqmdybGF5NIlxzei', NULL, '2020-04-24 00:32:06', '2020-04-24 00:32:06');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `ads_banner`
--
ALTER TABLE `ads_banner`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `ads_zone`
--
ALTER TABLE `ads_zone`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `menu_detail`
--
ALTER TABLE `menu_detail`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Chỉ mục cho bảng `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Chỉ mục cho bảng `seo`
--
ALTER TABLE `seo`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `ads_banner`
--
ALTER TABLE `ads_banner`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `ads_zone`
--
ALTER TABLE `ads_zone`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `menu_detail`
--
ALTER TABLE `menu_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT cho bảng `photos`
--
ALTER TABLE `photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT cho bảng `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `seo`
--
ALTER TABLE `seo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `slider`
--
ALTER TABLE `slider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
