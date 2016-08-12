-- phpMyAdmin SQL Dump
-- version 4.6.3deb1~xenial.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: 2016-08-11 17:07:27
-- 服务器版本： 5.6.32
-- PHP Version: 5.6.24-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `record`
--

-- --------------------------------------------------------

--
-- 表的结构 `data_log`
--

CREATE TABLE `data_log` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键ID',
  `operate_user` varchar(20) NOT NULL COMMENT '操作人员',
  `operate_ip` varchar(32) NOT NULL COMMENT '操作IP',
  `operate_type` varchar(512) NOT NULL DEFAULT '修改商品' COMMENT '操作类型（修改商品，新增主题....）',
  `log_content` varchar(512) NOT NULL DEFAULT '修改商品ID888000' COMMENT '日志内容（摘要）',
  `origin_data` text NOT NULL COMMENT '原数据',
  `new_data` text NOT NULL COMMENT '新数据',
  `operate_time` timestamp NOT NULL COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- --------------------------------------------------------

--
-- 表的结构 `item_statis`
--

CREATE TABLE `item_statis` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `sku_id` bigint(20) NOT NULL COMMENT 'sku id',
  `create_date` varchar(20) NOT NULL DEFAULT '20160101' COMMENT '创建时间标识',
  `color` varchar(512) DEFAULT NULL COMMENT '颜色',
  `size` varchar(512) DEFAULT NULL COMMENT '尺寸'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品统计表';

-- --------------------------------------------------------

--
-- 表的结构 `user_log`
--

CREATE TABLE `user_log` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键ID',
  `operate_user` varchar(20) NOT NULL COMMENT '操作人',
  `operate_ip` varchar(32) NOT NULL COMMENT '操作IP',
  `operate_type` varchar(20) NOT NULL COMMENT '操作类型 （POST， GET）',
  `content` text NOT NULL COMMENT '操作内容',
  `operate_time` timestamp NOT NULL COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户行为日志';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_log`
--
ALTER TABLE `data_log`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `item_statis`
--
ALTER TABLE `item_statis`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD UNIQUE KEY `id` (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `data_log`
--
ALTER TABLE `data_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID', AUTO_INCREMENT=201120;
--
-- 使用表AUTO_INCREMENT `item_statis`
--
ALTER TABLE `item_statis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键';
--
-- 使用表AUTO_INCREMENT `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
