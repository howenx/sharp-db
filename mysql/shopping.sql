-- phpMyAdmin SQL Dump
-- version 4.6.3deb1~xenial.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: 2016-08-11 17:07:35
-- 服务器版本： 5.6.32
-- PHP Version: 5.6.24-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopping`
--

-- --------------------------------------------------------

--
-- 表的结构 `order_split`
--

CREATE TABLE `order_split` (
  `split_id` bigint(20) UNSIGNED NOT NULL COMMENT '子订单ID',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `state` char(1) DEFAULT 'I' COMMENT '“I”初始化，"T"已经报关, “S”报关成功，"F"报关失败，”Y”支付报关成功受理，”N”支付报关受理失败',
  `cbe_code` varchar(16) DEFAULT NULL COMMENT '报关单位，shanghai，guangzhou，hangzhou',
  `insp_return_code` varchar(16) DEFAULT NULL COMMENT 'ERP报关国检部门返回code',
  `insp_return_msg` varchar(255) DEFAULT NULL COMMENT 'ERP报关国检部门返回消息',
  `customs_return_code` varchar(16) DEFAULT NULL COMMENT 'ERP报关海关返回code',
  `customs_return_msg` varchar(255) DEFAULT NULL COMMENT 'ERP报关海关返回消息',
  `total_fee` decimal(10,2) DEFAULT '0.00' COMMENT '商品费用',
  `total_pay_fee` decimal(10,2) DEFAULT '0.00' COMMENT '总支付费用',
  `total_amount` int(11) DEFAULT NULL COMMENT '总支付费用',
  `ship_fee` decimal(10,2) DEFAULT '0.00' COMMENT '邮费',
  `postal_fee` decimal(10,2) DEFAULT '0.00' COMMENT '行邮税',
  `express_num` varchar(255) DEFAULT '0' COMMENT '快递编号',
  `express_code` varchar(255) DEFAULT 'jd' COMMENT '快递编码',
  `express_nm` varchar(255) DEFAULT '京东快递' COMMENT '快递名称',
  `cbe_area` varchar(16) DEFAULT NULL COMMENT '海关发货区域',
  `pay_insp_return_code` varchar(16) DEFAULT NULL COMMENT '支付报关国检部门返回code',
  `pay_insp_return_msg` varchar(255) DEFAULT NULL COMMENT '支付报关国检部门返回消息',
  `pay_customs_return_code` varchar(16) DEFAULT NULL COMMENT '支付报关海关返回code',
  `pay_customs_return_msg` varchar(255) DEFAULT NULL COMMENT '支付报关海关返回消息',
  `sub_pg_trade_no` varchar(64) DEFAULT NULL COMMENT '子订单支付单号。主要用于子单海关报送时三单对碰，生成规则是：支付机构的交易号+3位序列号，需保证唯一性。',
  `pay_response_code` varchar(64) DEFAULT NULL COMMENT '支付报关返回消息码，响应编码',
  `pay_response_msg` varchar(255) DEFAULT NULL COMMENT '支付报关返回消息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子订单表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_cart`
--

CREATE TABLE `sp_cart` (
  `cart_id` bigint(20) UNSIGNED NOT NULL COMMENT '购物车ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品SKU ID',
  `item_id` bigint(20) DEFAULT NULL COMMENT '商品ID',
  `amount` int(11) DEFAULT '0' COMMENT '数量',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `destroy_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `status` char(1) DEFAULT 'I' COMMENT 'I:初始化，O：已下单，N：已删除，S:失效，G:勾选状态',
  `sku_title` varchar(255) DEFAULT 'title' COMMENT 'sku标题',
  `sku_img` varchar(255) DEFAULT 'url' COMMENT 'sku图片',
  `sku_type` varchar(64) DEFAULT NULL COMMENT 'SKU类型（item普通商品，pin拼购商品，vary多样化价格商品，customize自定义价格商品）',
  `sku_type_id` bigint(20) DEFAULT NULL COMMENT 'SKU 类型ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户购物车';

-- --------------------------------------------------------

--
-- 表的结构 `sp_collect`
--

CREATE TABLE `sp_collect` (
  `collect_id` bigint(20) UNSIGNED NOT NULL COMMENT '收藏ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品SKU ID',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sku_type` varchar(64) DEFAULT NULL COMMENT 'SKU类型（item普通商品，pin拼购商品，vary多样化价格商品，customize自定义价格商品）',
  `sku_type_id` bigint(20) DEFAULT NULL COMMENT 'SKU 类型ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_coupons`
--

CREATE TABLE `sp_coupons` (
  `coup_id` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏唯一键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `cate_id` bigint(20) DEFAULT '0' COMMENT '类别ID，("化妆品", 153)，("配饰", 172)，("服饰", 165)，("全场通用券","555")，(新人券","777")，("指定商品","211")，("邮费", 999)',
  `denomination` decimal(10,2) DEFAULT '0.00' COMMENT '面值',
  `start_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `state` char(1) DEFAULT 'N' COMMENT '"N"未使用，"Y"已经使用过，“S"自动失效，“F”免邮专用',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `use_at` timestamp NULL DEFAULT NULL COMMENT '使用时间',
  `limit_quota` decimal(10,2) DEFAULT '200.00' COMMENT '限额',
  `cate_nm` varchar(256) DEFAULT NULL COMMENT '类别名称，(153 化妆品类商品适用券，172 配饰类商品适用券, 165 服饰类商品适用券, 555 全场通用券, 777 新人优惠券, 211 指定商品适用券, 999 免邮券)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户优惠券表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_coupons_cate`
--

CREATE TABLE `sp_coupons_cate` (
  `cate_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '类别ID',
  `cate_nm` varchar(256) DEFAULT NULL COMMENT '类别名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券分类表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_feedback`
--

CREATE TABLE `sp_feedback` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `content` text COMMENT '反馈内容',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户反馈表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_msg`
--

CREATE TABLE `sp_msg` (
  `msg_id` bigint(20) UNSIGNED NOT NULL COMMENT '消息ID',
  `msg_title` varchar(128) DEFAULT NULL COMMENT '消息标题',
  `msg_content` text COMMENT '消息内容',
  `msg_type` varchar(64) DEFAULT NULL COMMENT '消息类型',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `end_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效时间',
  `msg_img` varchar(255) DEFAULT 'url' COMMENT '消息商品图片',
  `msg_url` varchar(255) DEFAULT NULL COMMENT '消息跳转的URL',
  `target_type` char(1) DEFAULT 'D' COMMENT 'T:主题，D:详细页面，P:拼购商品页，A:活动页面，U:一个促销活动的链接, C:优惠券'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户消息';

-- --------------------------------------------------------

--
-- 表的结构 `sp_msg_rec`
--

CREATE TABLE `sp_msg_rec` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '消息ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `msg_id` bigint(20) DEFAULT '0' COMMENT '收到消息的id,系统消息时有值',
  `msg_title` varchar(128) DEFAULT NULL COMMENT '普通消息标题',
  `msg_content` text COMMENT '普通消息内容',
  `msg_img` varchar(255) DEFAULT 'url' COMMENT '消息商品图片',
  `msg_url` varchar(255) DEFAULT NULL COMMENT '消息跳转的URL',
  `msg_type` varchar(64) DEFAULT NULL COMMENT '消息类型',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `read_status` int(11) DEFAULT '1' COMMENT '1-未读 2-已读',
  `target_type` char(1) DEFAULT 'D' COMMENT 'T:主题，D:详细页面，P:拼购商品页，A:活动页面，U:一个促销活动的链接',
  `del_status` int(11) DEFAULT '1' COMMENT '1-未删 2-已删',
  `msg_rec_type` int(11) DEFAULT '1' COMMENT '消息来源 1-普通消息 2-系统消息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户消息内容';

-- --------------------------------------------------------

--
-- 表的结构 `sp_order`
--

CREATE TABLE `sp_order` (
  `order_id` bigint(20) UNSIGNED NOT NULL COMMENT '订单ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `pay_total` decimal(10,2) NOT NULL COMMENT '这笔订单的实际需要支付的总费用',
  `pay_method` varchar(20) DEFAULT NULL COMMENT '支付渠道，默认京东支付 ,支付方式JD.京东 APAY.支付宝 WEIXIN.微信',
  `order_create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `order_ip` varchar(32) NOT NULL DEFAULT '127.0.0.1/32' COMMENT '用户下订单IP',
  `pg_trade_no` varchar(64) NOT NULL DEFAULT '0' COMMENT 'pg订单号',
  `order_status` varchar(16) NOT NULL DEFAULT 'I' COMMENT 'I:初始化即未支付状态，S:成功，C：取消， F:失败，R:已收货，D:已经发货，J:拒收，N已删除，T已退款，PI:拼购未支付状态，PS:拼购支付成功状态，PF:拼团失败还未成功退款',
  `error_str` varchar(64) NOT NULL DEFAULT '0' COMMENT '支付返回的错误信息',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠了多少钱',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单更新时间',
  `order_desc` varchar(64) DEFAULT NULL COMMENT '订单备注',
  `ship_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '邮费',
  `postal_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '行邮税',
  `confirm_receive_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用户收货确认时间',
  `total_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户购买商品的费用',
  `ship_time` int(11) NOT NULL DEFAULT '1' COMMENT '配送时间 1.工作日双休日与假期均可送货,2.只工作日送货,3.只双休日与假日送货',
  `client_type` int(11) NOT NULL DEFAULT '1' COMMENT '支付订单客户端类型 //1.android,2.ios,3.web',
  `order_type` int(11) DEFAULT '1' COMMENT '1:正常购买订单，2：拼购订单',
  `pin_active_id` bigint(20) DEFAULT NULL COMMENT '拼购活动ID',
  `pay_method_sub` varchar(20) DEFAULT 'JD' COMMENT '子支付方式，如微信JSAPI,NATIVE,APP',
  `or_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单删除标志'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_order_line`
--

CREATE TABLE `sp_order_line` (
  `line_id` bigint(20) UNSIGNED NOT NULL COMMENT '订单明细ID',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `sku_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'sku ID',
  `item_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `sku_title` varchar(512) NOT NULL DEFAULT 'title' COMMENT 'sku标题',
  `sku_img` varchar(512) NOT NULL DEFAULT 'img' COMMENT 'sku图片',
  `split_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '子订单ID',
  `sku_size` varchar(255) NOT NULL COMMENT 'sku尺寸',
  `sku_color` varchar(255) NOT NULL COMMENT 'sku颜色',
  `sku_type` varchar(64) DEFAULT NULL COMMENT '商品类型 1.vary,2.item,3.customize,4.pin',
  `sku_type_id` bigint(20) DEFAULT NULL COMMENT '类型ID，诸如多样化价格商品ID，主题自定义商品ID，拼购商品ID',
  `pin_tiered_price_id` bigint(20) DEFAULT NULL COMMENT '拼购价格ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单明细表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_order_ship`
--

CREATE TABLE `sp_order_ship` (
  `ship_id` bigint(20) UNSIGNED NOT NULL COMMENT '订单收货ID',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `delivery_name` varchar(256) NOT NULL COMMENT '配送用户姓名',
  `delivery_tel` varchar(256) NOT NULL DEFAULT '0' COMMENT '配送用户电话',
  `delivery_city` varchar(512) NOT NULL DEFAULT 'city' COMMENT '配送城市',
  `delivery_address` varchar(512) NOT NULL DEFAULT 'detail' COMMENT '配送地址',
  `delivery_card_num` varchar(64) NOT NULL DEFAULT '230119198704280317' COMMENT '用户身份证号码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单收货地址表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_refund`
--

CREATE TABLE `sp_refund` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '退款ID',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `pay_back_fee` decimal(10,2) NOT NULL COMMENT '退款金额',
  `reason` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `state` char(1) NOT NULL DEFAULT 'I' COMMENT 'I－初始化状态，A－同意退货申请，R－拒绝退货申请，Y－退款受理成功，N－退款受理失败',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `pg_trade_no` varchar(128) DEFAULT NULL COMMENT '退款成功后支付公司返回的交易号',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `pg_code` varchar(128) DEFAULT NULL COMMENT '支付公司退款返回信息码',
  `pg_message` varchar(128) DEFAULT NULL COMMENT '支付公司返回消息',
  `amount` int(11) DEFAULT '0' COMMENT '退货单品数量',
  `refund_img` varchar(512) DEFAULT NULL COMMENT '退货时上传的拍照[1.jpg,2.jpg]',
  `contact_name` varchar(16) DEFAULT NULL COMMENT '退货时上传的拍照[1.jpg,2.jpg]',
  `contact_tel` varchar(16) DEFAULT NULL COMMENT '联系人姓名',
  `express_company` varchar(128) DEFAULT NULL COMMENT '快递公司名称',
  `express_comp_code` varchar(20) DEFAULT NULL COMMENT '快递公司编码',
  `express_num` varchar(32) DEFAULT NULL COMMENT '快递编号',
  `reject_reason` varchar(128) DEFAULT NULL COMMENT '客服拒绝退货申请原因',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '库存ID',
  `split_order_id` bigint(20) DEFAULT NULL COMMENT '子订单ID',
  `refund_type` varchar(64) DEFAULT NULL COMMENT '退款类型，pin：拼购自动退款，receive：收货后申请退款，deliver：发货前退款',
  `sku_type` varchar(128) DEFAULT NULL COMMENT 'SKU类型（item普通商品，pin拼购商品，vary多样化价格商品，customize自定义价格商品）',
  `sku_type_id` bigint(20) DEFAULT NULL COMMENT 'SKU 类型ID',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新者ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款表';

-- --------------------------------------------------------

--
-- 表的结构 `sp_remark`
--

CREATE TABLE `sp_remark` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '评价ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `content` varchar(512) DEFAULT NULL COMMENT '评论内容',
  `picture` varchar(512) DEFAULT NULL COMMENT '上传的图片',
  `grade` int(11) DEFAULT '5' COMMENT '评论星级',
  `sku_type` varchar(128) DEFAULT NULL COMMENT 'SKU类型（item普通商品，pin拼购商品，vary多样化价格商品，customize自定义价格商品）',
  `sku_type_id` bigint(20) DEFAULT NULL COMMENT 'SKU 类型ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评价表';

-- --------------------------------------------------------

--
-- 表的结构 `supply_order`
--

CREATE TABLE `supply_order` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `update_time` timestamp NOT NULL COMMENT '更新时间',
  `update_user` bigint(20) NOT NULL COMMENT '更新者ID',
  `state` varchar(16) NOT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评价表';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `order_split`
--
ALTER TABLE `order_split`
  ADD PRIMARY KEY (`split_id`),
  ADD UNIQUE KEY `split_id` (`split_id`);

--
-- Indexes for table `sp_cart`
--
ALTER TABLE `sp_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `cart_id` (`cart_id`);

--
-- Indexes for table `sp_collect`
--
ALTER TABLE `sp_collect`
  ADD PRIMARY KEY (`collect_id`),
  ADD UNIQUE KEY `collect_id` (`collect_id`);

--
-- Indexes for table `sp_coupons`
--
ALTER TABLE `sp_coupons`
  ADD PRIMARY KEY (`coup_id`);

--
-- Indexes for table `sp_coupons_cate`
--
ALTER TABLE `sp_coupons_cate`
  ADD PRIMARY KEY (`cate_id`),
  ADD UNIQUE KEY `cate_id` (`cate_id`);

--
-- Indexes for table `sp_feedback`
--
ALTER TABLE `sp_feedback`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `sp_msg`
--
ALTER TABLE `sp_msg`
  ADD PRIMARY KEY (`msg_id`),
  ADD UNIQUE KEY `msg_id` (`msg_id`);

--
-- Indexes for table `sp_msg_rec`
--
ALTER TABLE `sp_msg_rec`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `sp_order`
--
ALTER TABLE `sp_order`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `sp_order_line`
--
ALTER TABLE `sp_order_line`
  ADD PRIMARY KEY (`line_id`),
  ADD UNIQUE KEY `line_id` (`line_id`);

--
-- Indexes for table `sp_order_ship`
--
ALTER TABLE `sp_order_ship`
  ADD PRIMARY KEY (`ship_id`),
  ADD UNIQUE KEY `ship_id` (`ship_id`);

--
-- Indexes for table `sp_refund`
--
ALTER TABLE `sp_refund`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `sp_remark`
--
ALTER TABLE `sp_remark`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `supply_order`
--
ALTER TABLE `supply_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `order_split`
--
ALTER TABLE `order_split`
  MODIFY `split_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '子订单ID', AUTO_INCREMENT=444222;
--
-- 使用表AUTO_INCREMENT `sp_cart`
--
ALTER TABLE `sp_cart`
  MODIFY `cart_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车ID', AUTO_INCREMENT=50122222;
--
-- 使用表AUTO_INCREMENT `sp_collect`
--
ALTER TABLE `sp_collect`
  MODIFY `collect_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '收藏ID', AUTO_INCREMENT=5321011;
--
-- 使用表AUTO_INCREMENT `sp_feedback`
--
ALTER TABLE `sp_feedback`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=700111;
--
-- 使用表AUTO_INCREMENT `sp_msg`
--
ALTER TABLE `sp_msg`
  MODIFY `msg_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID', AUTO_INCREMENT=800111;
--
-- 使用表AUTO_INCREMENT `sp_msg_rec`
--
ALTER TABLE `sp_msg_rec`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID', AUTO_INCREMENT=822555;
--
-- 使用表AUTO_INCREMENT `sp_order`
--
ALTER TABLE `sp_order`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID', AUTO_INCREMENT=53011203;
--
-- 使用表AUTO_INCREMENT `sp_order_line`
--
ALTER TABLE `sp_order_line`
  MODIFY `line_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单明细ID', AUTO_INCREMENT=2200121;
--
-- 使用表AUTO_INCREMENT `sp_order_ship`
--
ALTER TABLE `sp_order_ship`
  MODIFY `ship_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单收货ID';
--
-- 使用表AUTO_INCREMENT `sp_refund`
--
ALTER TABLE `sp_refund`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '退款ID', AUTO_INCREMENT=3300131;
--
-- 使用表AUTO_INCREMENT `sp_remark`
--
ALTER TABLE `sp_remark`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价ID', AUTO_INCREMENT=4400141;
--
-- 使用表AUTO_INCREMENT `supply_order`
--
ALTER TABLE `supply_order`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=5500151;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
