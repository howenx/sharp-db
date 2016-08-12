-- phpMyAdmin SQL Dump
-- version 4.6.3deb1~xenial.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: 2016-08-11 17:07:16
-- 服务器版本： 5.6.32
-- PHP Version: 5.6.24-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `promotion`
--

-- --------------------------------------------------------

--
-- 表的结构 `pin_activity`
--

CREATE TABLE `pin_activity` (
  `pin_active_id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `pin_id` bigint(20) NOT NULL COMMENT '拼购商品ID',
  `master_user_id` bigint(20) NOT NULL COMMENT '团长用户ID',
  `person_num` int(11) NOT NULL COMMENT '拼购人数',
  `pin_price` decimal(10,2) NOT NULL COMMENT '拼购价格',
  `join_persons` int(11) NOT NULL DEFAULT '0' COMMENT '已经参加活动人数',
  `create_at` timestamp NOT NULL COMMENT '发起时间',
  `status` char(1) NOT NULL COMMENT '状态 Y-正常 N－取消 C－完成',
  `end_at` timestamp NOT NULL COMMENT '截止时间',
  `pin_url` varchar(255) DEFAULT NULL COMMENT '此团的分享短链接',
  `pin_tiered_id` bigint(20) DEFAULT NULL COMMENT '阶梯价格ID',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户发起的拼购活动';

-- --------------------------------------------------------

--
-- 表的结构 `pin_coupon`
--

CREATE TABLE `pin_coupon` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `master_coupon` int(11) DEFAULT '0' COMMENT '主键',
  `master_coupon_class` varchar(64) DEFAULT NULL COMMENT '团长返券额度',
  `master_coupon_start_at` timestamp NULL DEFAULT NULL COMMENT '团长返券类别',
  `master_coupon_end_at` timestamp(6) NULL DEFAULT NULL COMMENT '团长优惠券开始时间',
  `master_coupon_quota` int(11) DEFAULT '0' COMMENT '团长优惠券结束时间',
  `member_coupon` int(11) DEFAULT '0' COMMENT '团长优惠券限额',
  `member_coupon_class` varchar(64) DEFAULT NULL COMMENT '团员返券额度',
  `member_coupon_start_at` timestamp NULL DEFAULT NULL COMMENT '团员返券类别',
  `member_coupon_end_at` timestamp NULL DEFAULT NULL COMMENT '团员优惠券开始时间',
  `member_coupon_quota` int(11) DEFAULT NULL COMMENT '团员优惠券限额',
  `pin_active_id` bigint(20) DEFAULT NULL COMMENT '拼购活动ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼购返券表';

-- --------------------------------------------------------

--
-- 表的结构 `pin_sku`
--

CREATE TABLE `pin_sku` (
  `pin_id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `pin_title` varchar(255) DEFAULT NULL COMMENT '此拼购商品标题',
  `start_at` timestamp NOT NULL COMMENT '开始时间',
  `end_at` timestamp NOT NULL COMMENT '结束时间',
  `restrict_amount` int(11) DEFAULT NULL COMMENT '每ID限购数量',
  `floor_price` varchar(512) NOT NULL COMMENT '拼购最低价，人数{"min_person_num":3,"price":10.00}',
  `inv_id` bigint(20) NOT NULL COMMENT '库存ID',
  `pin_discount` decimal(10,1) NOT NULL COMMENT '拼购最低折扣',
  `pin_img` varchar(255) NOT NULL COMMENT '生成后列表图',
  `share_url` varchar(255) DEFAULT NULL COMMENT '分享短链接',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '状态  ''Y''--正常,''D''--下架,''N''--删除,''K''--售空，''P''--预售',
  `create_at` timestamp NOT NULL COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `theme_id` varchar(512) DEFAULT NULL COMMENT '主题ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼购商品表';

--
-- 转存表中的数据 `pin_sku`
--

INSERT INTO `pin_sku` (`pin_id`, `pin_title`, `start_at`, `end_at`, `restrict_amount`, `floor_price`, `inv_id`, `pin_discount`, `pin_img`, `share_url`, `status`, `create_at`, `update_at`, `theme_id`) VALUES
(111298, 'SNP 90%补水保湿凝胶 燕窝凝胶', '2016-08-05 15:40:55', '2016-09-14 15:40:57', 99, '{"person_num":5,"price":7}', 111040, '1.2', '{"url":"templates/photo/20160805/c6cfb86e76f547e4b6368c35bf99a59d1470383063573.png","width":1136,"height":545}', NULL, 'Y', '2016-08-05 15:45:17', '2016-08-08 10:44:19', ',444000,444028'),
(111300, '【快来拼啦】欧巴面膜', '2016-08-08 10:57:57', '2016-08-30 10:57:58', 1, '{"person_num":2,"price":22}', 111010, '1.6', '{"url":"templates/photo/20160808/5e084ce666cc43ad955133e92024f29f1470625224524.jpg","width":1033,"height":1033}', NULL, 'Y', '2016-08-08 11:08:04', NULL, '');

-- --------------------------------------------------------

--
-- 表的结构 `pin_tiered_price`
--

CREATE TABLE `pin_tiered_price` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '阶梯价格ID',
  `pin_id` bigint(20) NOT NULL COMMENT 'pin库存的ID',
  `people_num` int(11) NOT NULL COMMENT '人数',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `master_min_price` decimal(10,2) DEFAULT NULL COMMENT '团长减价',
  `member_min_price` decimal(10,2) DEFAULT NULL COMMENT '团员减价',
  `master_coupon` int(11) DEFAULT NULL COMMENT '团长返券额度',
  `master_coupon_class` varchar(64) DEFAULT NULL COMMENT '团长返券类别',
  `master_coupon_start_at` timestamp NULL DEFAULT NULL COMMENT '团长优惠券开始时间',
  `master_coupon_end_at` timestamp NULL DEFAULT NULL COMMENT '团长优惠券结束时间',
  `master_coupon_quota` int(11) DEFAULT NULL COMMENT '团长优惠券限额',
  `member_coupon` int(11) DEFAULT NULL COMMENT '团员优惠券额度',
  `member_coupon_class` varchar(64) DEFAULT NULL COMMENT '团员返券类别',
  `member_coupon_start_at` timestamp NULL DEFAULT NULL COMMENT '团员优惠券开始时间',
  `member_coupon_end_at` timestamp NULL DEFAULT NULL COMMENT '团员优惠券结束时间',
  `member_coupon_quota` int(11) DEFAULT NULL COMMENT '团员优惠券限额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼购阶梯价格表';

-- --------------------------------------------------------

--
-- 表的结构 `pin_user`
--

CREATE TABLE `pin_user` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `or_master` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是团长',
  `pin_active_id` bigint(20) NOT NULL COMMENT '拼购活动ID',
  `user_ip` varchar(32) NOT NULL COMMENT '用户IP',
  `or_robot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是机器人',
  `user_img` varchar(255) NOT NULL DEFAULT 'users/photo/default.png' COMMENT '用户头像',
  `join_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '参团时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团用户表';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pin_activity`
--
ALTER TABLE `pin_activity`
  ADD PRIMARY KEY (`pin_active_id`),
  ADD UNIQUE KEY `pin_active_id` (`pin_active_id`);

--
-- Indexes for table `pin_coupon`
--
ALTER TABLE `pin_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `pin_sku`
--
ALTER TABLE `pin_sku`
  ADD PRIMARY KEY (`pin_id`),
  ADD UNIQUE KEY `pin_id` (`pin_id`);

--
-- Indexes for table `pin_tiered_price`
--
ALTER TABLE `pin_tiered_price`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `pin_user`
--
ALTER TABLE `pin_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `pin_activity`
--
ALTER TABLE `pin_activity`
  MODIFY `pin_active_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=102121;
--
-- 使用表AUTO_INCREMENT `pin_coupon`
--
ALTER TABLE `pin_coupon`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200911;
--
-- 使用表AUTO_INCREMENT `pin_sku`
--
ALTER TABLE `pin_sku`
  MODIFY `pin_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=10010010;
--
-- 使用表AUTO_INCREMENT `pin_tiered_price`
--
ALTER TABLE `pin_tiered_price`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '阶梯价格ID', AUTO_INCREMENT=301103;
--
-- 使用表AUTO_INCREMENT `pin_user`
--
ALTER TABLE `pin_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=409011;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
