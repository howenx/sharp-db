-- phpMyAdmin SQL Dump
-- version 4.6.3deb1~xenial.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: 2016-08-11 17:08:46
-- 服务器版本： 5.6.32
-- PHP Version: 5.6.24-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `statistics`
--

-- --------------------------------------------------------

--
-- 表的结构 `s_id`
--

CREATE TABLE `s_id` (
  `s_date` varchar(8) NOT NULL COMMENT '日期',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `reg_ip` varchar(32) NOT NULL COMMENT '注册IP',
  `reg_dt` timestamp NOT NULL COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Style用户统计表';

-- --------------------------------------------------------

--
-- 表的结构 `s_order`
--

CREATE TABLE `s_order` (
  `s_date` varchar(8) NOT NULL COMMENT '日期',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `pay_total` decimal(10,2) NOT NULL COMMENT '订单支付总费用',
  `pay_method` varchar(20) NOT NULL COMMENT '支付渠道',
  `order_create_at` timestamp NOT NULL COMMENT '订单创建时间',
  `order_ip` varchar(32) NOT NULL COMMENT '订单IP',
  `total_fee` decimal(10,2) NOT NULL COMMENT '购买商品的费用',
  `client_type` int(11) NOT NULL COMMENT '支付订单客户端类型',
  `pg_trade_no` varchar(64) NOT NULL COMMENT 'pg订单号',
  `order_status` varchar(64) NOT NULL COMMENT 'I:初始化即未支付状态，S:成功，C：取消， F:失败，R:已收货，D:已经发货，J:拒收，N已删除，T已退款，PI:拼购未支付状态，PS:拼购支付成功状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单统计表';

-- --------------------------------------------------------

--
-- 表的结构 `s_order_line`
--

CREATE TABLE `s_order_line` (
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `sku_id` bigint(20) NOT NULL COMMENT 'SKU ID',
  `item_id` bigint(20) NOT NULL COMMENT '商品ID',
  `amount` int(11) NOT NULL COMMENT '购买数量',
  `price` decimal(10,2) NOT NULL COMMENT '购买价格',
  `sku_title` varchar(512) NOT NULL COMMENT 'SKU 标题',
  `sku_color` varchar(255) NOT NULL COMMENT '商品颜色',
  `sku_size` varchar(255) NOT NULL COMMENT '商品尺码',
  `sku_type` varchar(64) NOT NULL DEFAULT 'item' COMMENT '商品类型 1.vary,2.item,3.customize,4.pin',
  `sku_type_id` bigint(20) NOT NULL DEFAULT '888366' COMMENT '类型ID，诸如多样化价格商品ID，主题自定义商品ID，拼购商品ID',
  `s_order_date` varchar(8) NOT NULL DEFAULT '20160101' COMMENT '订单日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品统计表';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
