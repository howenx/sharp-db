-- phpMyAdmin SQL Dump
-- version 4.6.3deb1~xenial.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: 2016-08-11 17:08:56
-- 服务器版本： 5.6.32
-- PHP Version: 5.6.24-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `style`
--

-- --------------------------------------------------------

--
-- 表的结构 `brands`
--

CREATE TABLE `brands` (
  `brand_id` bigint(20) UNSIGNED NOT NULL COMMENT '品牌ID',
  `brand_desc` text COMMENT '品牌描述中文',
  `logo` varchar(512) DEFAULT NULL COMMENT '品牌logo地址',
  `create_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `brand_nm` varchar(256) NOT NULL COMMENT '品牌名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品品牌表';

--
-- 转存表中的数据 `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_desc`, `logo`, `create_date`, `brand_nm`) VALUES
(112000, '', NULL, '2016-08-03 11:39:53', 'SNP'),
(112005, '', NULL, '2016-08-03 11:40:09', 'W.Dressroom'),
(112010, '', NULL, '2016-08-03 11:40:17', 'Swagger'),
(112015, '', NULL, '2016-08-03 11:40:34', 'Fascy'),
(112020, '', NULL, '2016-08-03 11:40:56', 'Skin1004'),
(112025, '', NULL, '2016-08-03 11:41:03', 'H1'),
(112030, '', NULL, '2016-08-03 11:43:39', 'Velieve');

-- --------------------------------------------------------

--
-- 表的结构 `carriage`
--

CREATE TABLE `carriage` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `first_num` int(11) NOT NULL DEFAULT '1000' COMMENT '首重（单位：毫克）',
  `first_fee` decimal(10,2) NOT NULL DEFAULT '10.00' COMMENT '首费（单位：元）',
  `add_num` int(11) NOT NULL DEFAULT '1000' COMMENT '续重（单位：毫克）',
  `add_fee` decimal(10,2) NOT NULL DEFAULT '5.00' COMMENT '续费 （单位：元）',
  `model_name` varchar(256) NOT NULL COMMENT '运费模板名称',
  `city_code` varchar(256) NOT NULL DEFAULT 'ALL' COMMENT '配送地:省份',
  `model_code` varchar(64) NOT NULL COMMENT '模板code',
  `delivery_code` varchar(16) NOT NULL DEFAULT 'JD' COMMENT '快递公司编码',
  `delivery_name` varchar(255) NOT NULL DEFAULT '京东物流' COMMENT '快递公司名称',
  `store_area` varchar(16) NOT NULL DEFAULT 'H' COMMENT '始发地：上海备货仓 S，上海直邮仓SZ，杭州备货仓H，杭州直邮仓HZ，广州备货仓G， 广州直邮仓GZ，韩国（直邮）K '
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运费设置';

-- --------------------------------------------------------

--
-- 表的结构 `cates`
--

CREATE TABLE `cates` (
  `cate_id` bigint(20) UNSIGNED NOT NULL COMMENT '类别ID',
  `pcate_id` bigint(20) DEFAULT NULL COMMENT '父类ID',
  `cate_nm` varchar(256) DEFAULT NULL COMMENT '类别名',
  `cate_desc` varchar(512) DEFAULT NULL COMMENT '类别描述',
  `cate_code` varchar(16) DEFAULT NULL COMMENT '类别Code，("化妆品", 153)，("配饰", 172)，("服饰", 165)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类别表';

--
-- 转存表中的数据 `cates`
--

INSERT INTO `cates` (`cate_id`, `pcate_id`, `cate_nm`, `cate_desc`, `cate_code`) VALUES
(120550, NULL, '面膜/眼膜', '', ''),
(120558, NULL, '面部护理', '', ''),
(120566, NULL, '防晒', '', ''),
(120574, NULL, '身体护肤', '', ''),
(120582, NULL, '洁面', '', ''),
(120590, NULL, '洗发护发', '', ''),
(120598, NULL, '香水彩妆', '', ''),
(120606, NULL, '男士护肤', '', ''),
(120614, NULL, '气质香氛', '', ''),
(120622, NULL, '香薰/蜡烛', '', ''),
(120630, 120550, '面膜/眼膜', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `item_id` bigint(20) NOT NULL COMMENT '商品ID',
  `item_color` varchar(512) NOT NULL DEFAULT '' COMMENT '颜色',
  `item_size` varchar(512) NOT NULL DEFAULT '均码' COMMENT '尺寸',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '库存总量',
  `item_src_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用于计算折扣的显示的原价',
  `item_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '现价',
  `item_cost_price` decimal(10,2) DEFAULT '0.00' COMMENT '（未使用）成本价',
  `item_discount` decimal(10,1) NOT NULL DEFAULT '0.0' COMMENT '折扣',
  `sold_amount` int(11) NOT NULL DEFAULT '0' COMMENT '卖出数量总计，每卖出一笔就＋1',
  `rest_amount` int(11) NOT NULL DEFAULT '0' COMMENT '当前剩余库存量',
  `inv_img` text NOT NULL COMMENT 'sku主图',
  `item_preview_imgs` text NOT NULL COMMENT 'sku预览图',
  `or_destroy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `or_master_inv` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为主sku，用于详情页一进去是否显示为默认的主商品',
  `state` char(1) NOT NULL DEFAULT 'Y' COMMENT '单个sku状态  ''Y''--正常,''D''--下架,''N''--删除,''K''--售空，''P''--预售',
  `inv_area` char(2) NOT NULL DEFAULT 'Z' COMMENT '库存区域区分：''S'' 上海保税仓备货，''G''广州保税仓备货，''H''杭州保税仓备货，''SZ''上海保税区直邮，''GZ''广州保税仓直邮，''HZ''杭州保税仓直邮，''K'' 海外直邮，’NK'' 国内仓直邮，SELF'' 自营商品',
  `restrict_amount` int(11) NOT NULL DEFAULT '0' COMMENT '限购数量（0表示不限购）',
  `inv_title` varchar(512) NOT NULL COMMENT '商品标题',
  `inv_customs` varchar(16) NOT NULL DEFAULT 'shanghai' COMMENT '库存对应的报关单位, 现有报关单位',
  `postal_tax_code` varchar(16) DEFAULT NULL COMMENT '未使用）行邮税编号，如果是按照标准关税来，那么填入行邮税编号，否则填入税率',
  `inv_weight` int(11) DEFAULT '0' COMMENT '重量，单位毫克',
  `postal_tax_rate` varchar(16) NOT NULL DEFAULT '0' COMMENT '行邮税税率，单位百分比，例如填入3，表示3%',
  `carriage_model_code` varchar(256) NOT NULL DEFAULT '' COMMENT '邮费模版code',
  `record_code` varchar(512) DEFAULT NULL COMMENT '备案号，包含杭州，广州，上海三个地区',
  `or_vary_price` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否存在多样化价格',
  `start_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上架时间',
  `end_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下架时间',
  `share_url` varchar(512) DEFAULT NULL COMMENT '用于分享的链接',
  `share_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '分享次数',
  `collect_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `browse_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `theme_id` varchar(512) DEFAULT NULL COMMENT '主题id（可多个）',
  `inv_code` varchar(16) NOT NULL DEFAULT 'SH8809335931803' COMMENT '规格编号',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `destroy_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';

--
-- 转存表中的数据 `inventories`
--

INSERT INTO `inventories` (`id`, `item_id`, `item_color`, `item_size`, `amount`, `item_src_price`, `item_price`, `item_cost_price`, `item_discount`, `sold_amount`, `rest_amount`, `inv_img`, `item_preview_imgs`, `or_destroy`, `or_master_inv`, `state`, `inv_area`, `restrict_amount`, `inv_title`, `inv_customs`, `postal_tax_code`, `inv_weight`, `postal_tax_rate`, `carriage_model_code`, `record_code`, `or_vary_price`, `start_at`, `end_at`, `share_url`, `share_count`, `collect_count`, `browse_count`, `theme_id`, `inv_code`, `update_at`, `destroy_at`, `create_at`) VALUES
(111000, 888000, '', '默认', 10, '212.00', '212.00', NULL, '10.0', 3, 10, '{"url":"item/photo/20160803/6c91d4e63f984cdb8c509286ed96de211470205081067.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a850aae0db504ad8a2f8cb99be7f3eec1470205088920.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f561272113c740db875370132b5110c51470205089017.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/4341219ca3084065b816f8e905931ac41470205089021.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/60a3d7a19a444254b79f14e8be25f6241470205089019.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 去角质护理套装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:14:25', '2017-02-03 14:14:25', NULL, 0, 0, 0, '', '8809339905220', '2016-08-06 15:23:43', NULL, '2016-08-03 14:20:26'),
(111002, 888003, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 2, 9, '{"url":"item/photo/20160803/28f140daf2554db8980c91ef82f8c64c1470205056100.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/ed76bd8ec7fd4ff88038de4d26b928d91470205086200.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/3de4c76eaaff451f8124fd627551e2301470205086229.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/7e6e504fe9464df1be9baa1c7d08dadf1470205086299.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/81dcd94bf35e4e0ebf08e9107c59d8a41470205086251.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b48d9aaa7fd14067909be00ccaca53b61470205086256.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP黄金胶原蛋白 改善皱纹补充营养弹力面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:15:11', '2017-02-03 14:15:11', NULL, 0, 0, 0, '444007', '8809237825262 ', '2016-08-10 14:44:55', NULL, '2016-08-03 14:20:29'),
(111004, 888006, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 1, 9, '{"url":"item/photo/20160803/f007a7d57cb54be9a603b7a93e84a4da1470205481730.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/fdf97a67650a4da0aedcd85be7d7aa011470205476561.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/3611bcb18a384f9dae075101e40de4df1470205476583.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d040e5e5a1db45848857cd2e5b2ef2f31470205476622.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/97681d09e09044358eb39ebc56b364151470205476636.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/88f31a1103df435891083148df4a5ff41470205476672.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 钻石水库 提亮肤色面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:23:55', '2017-02-03 14:23:55', NULL, 0, 0, 0, '', '8809237825279 ', '2016-08-06 14:43:47', NULL, '2016-08-03 14:25:59'),
(111006, 888009, '', '默认', 10, '129.00', '129.00', NULL, '10.0', 2, 9, '{"url":"item/photo/20160803/6f884327a08a4c5eab05a37f09b776bc1470205405275.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/60596847bfc5456cb40e90e51a356bfe1470205414160.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/cdce3047e3b24bbca9b07c4ec527e0c21470205414590.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/5e20c9a43449470490647f12cdfa331a1470205414624.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 燕窝海洋补水眼膜眼贴', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:22:22', '2017-02-03 14:22:22', NULL, 0, 0, 0, '444000', '8809239802766', '2016-08-10 14:45:19', NULL, '2016-08-03 14:26:16'),
(111008, 888012, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 1, 10, '{"url":"item/photo/20160803/d2d7ca136d974dd6811bbf3c728135dd1470205684249.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/13c39356b42e4ba8956ee213f6201a7b1470205696693.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/ba7ccf1aaf5140558495ae236482702f1470205696730.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/4c432885c6664928b516d13ce13b1f451470205696774.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/1a387a61a5c941da9a14f51db4d39c1d1470205696787.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP海洋燕窝保湿补水面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:27:06', '2017-02-03 14:27:06', NULL, 0, 0, 0, '', '8809237825286 ', '2016-08-08 11:59:58', NULL, '2016-08-03 14:28:30'),
(111010, 888015, '', '镇静猛男款', 10, '139.00', '139.00', NULL, '10.0', 1, 10, '{"url":"item/photo/20160803/bd5a8f6fcfde4c1cb76b8f6b14ea6f3d1470205412766.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/78bbf496714541a59347da042651dc8f1470205420760.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fab263135b4d4a6aa1c0b7d3f49b39661470205420962.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/556898a7416540c5af0e0e92ff84ca3a1470205421070.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/43691ee062fc459ca7d3adf5e823b3071470205421072.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d9afa16091c24b0c8e9b88efe4519e761470205421099.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/85e61e18025e4ca5b0b239ba4e7ef2391470205421087.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM&SNP面膜贴欧巴面膜补水美白 10片/盒', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:22:15', '2017-02-03 14:22:15', NULL, 0, 0, 0, NULL, 'SH8805301000061', '2016-08-10 17:21:17', NULL, '2016-08-03 14:29:40'),
(111012, 888015, '', '亮白美丽款', 10, '139.00', '139.00', NULL, '10.0', 1, 10, '{"url":"item/photo/20160803/f80c8f9fbb9d433abda1f14b4a9be2f41470205473644.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/ef459dba907c4fd8b6bdc29a1a0c98911470205485361.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b3e7dee1ca624077b21288f3251cbcc41470205485336.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/35239dbcdd49449eaeee8caa05d432ce1470205485364.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b9dd0b5d03cd45548adaa1d2b96893f31470205485330.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/0554e39c2a4e4fb9a4f528aa408d5ec41470205485320.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM&SNP面膜贴欧巴面膜补水美白 10片/盒', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:22:15', '2017-02-03 14:22:15', NULL, 0, 0, 0, NULL, 'SH8805301000078', '2016-08-10 17:21:17', NULL, '2016-08-03 14:29:40'),
(111014, 888015, '', '补水海盗款', 10, '139.00', '139.00', NULL, '10.0', 1, 9, '{"url":"item/photo/20160803/6b33fd757e1249dda6e95534c23fd7f81470205552914.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/62a8484ec7ef4e8985ff95ffa439b9e81470205559830.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e61c02f05f4549e4ad77efeeacde270e1470205559846.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/904f425a45ec442fbcbac619dbc2a34b1470205559872.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a9f4914a15dd40dabb7aa1200696c37c1470205559477.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c6573dfb767c4a74987fd98dcbf6dad41470205559808.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8f7107cfe8274f5599b9e6287f3d51b81470205559719.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM&SNP面膜贴欧巴面膜补水美白 10片/盒', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:25:03', '2017-02-03 14:25:03', NULL, 0, 0, 0, NULL, 'SH8805301000085', '2016-08-10 17:21:17', NULL, '2016-08-03 14:29:40'),
(111016, 888015, '', '绅士抗皱款', 10, '139.00', '139.00', NULL, '10.0', 4, 7, '{"url":"item/photo/20160803/67fc4f2775fe41f9934acb86298ffa721470205658872.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/45c197ec64ff4e0299d15c8de786cf3e1470205665313.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/30f9dec9e9ad4b2c987f31bddafc77291470205665298.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8234be7f05a547d898851e802b952e151470205665330.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e6fe7b492e4343329061e3d3eb14ae6f1470205665218.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/09c1e6dcfa23488c8f7502660053c33c1470205664925.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/11a6511e75a44fc29cadeeb4c948f06f1470205665287.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'W.DRESSROOM&SNP面膜贴欧巴面膜补水美白 10片/盒', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:26:37', '2017-02-03 14:26:37', NULL, 0, 0, 0, NULL, 'SH8805301000092 ', '2016-08-10 17:21:17', NULL, '2016-08-03 14:29:40'),
(111018, 888018, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/94627c61d3f84336a6664e5755ddbe2d1470205857249.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6c904d6a50a94fbf8e8e22e72cfdc5221470205867597.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/624031cc638b44d2b5a8464c60fb110d1470205867656.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/980dea7f1cee40fd82fa70158e66b7951470205867593.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2cc0b65215de425aa8d87af2bde9921b1470205867673.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/08617363ade647529972f3527af418c71470205867722.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/ddaf01b89fe642379e04e089db3d7b971470205867695.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP竹炭黑炭 清洁毛孔面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:30:30', '2017-02-03 14:30:30', NULL, 0, 0, 0, '444014', '8809237828140 ', NULL, NULL, '2016-08-03 14:31:18'),
(111020, 888021, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/8645e13e196b4dc6abd6103b623f57aa1470205990566.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/8288324e0da34eaa849171d07a9e516d1470205998165.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/ddb24ed7c3b24ac1991fdc27d9e8230b1470205998227.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/822fe85ec14c4588a2be099beb254c0d1470205998242.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f513e59b454e469d8d26acba717c5a9e1470205998254.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP黑珍珠 提高皮肤活力提亮肤色面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:32:35', '2017-02-03 14:32:35', NULL, 0, 0, 0, NULL, '8809237828027 ', NULL, NULL, '2016-08-03 14:33:28'),
(111022, 888024, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 3, 8, '{"url":"item/photo/20160803/e1ba60e8b4e04aac9a2c4f52d0efbcd41470206117936.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/c1525f3a045842a79923fd5bc618debe1470206125334.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e1150d7f91ab41fd85987cf0fce9f7c81470206125473.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/4912c33898924a77beda9c9b648c7a981470206125451.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d6fa90ca3f0849a897396ad436f54f7f1470206125454.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 皮肤紧致老虎面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:34:49', '2017-02-03 14:34:49', NULL, 0, 0, 0, '444014', '8809237828348 ', '2016-08-10 18:03:23', NULL, '2016-08-03 14:35:32'),
(111024, 888027, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/3a55cd1c24f94e6ebd4abed19859f5a71470206265167.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/eb32e3d5667c4443995e88c2f6914e8a1470206273900.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/1a3597f0465749aaa75613c27c2ebc191470206273990.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fc204a680aee4746a59c8292d694985f1470206273964.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fae71e9f078040f288444e6a0ac75fb01470206274003.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9774b4a0612e403b8b0225fd63a7b1ce1470206274014.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 提亮肤色保湿熊猫 面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:37:01', '2017-02-03 14:37:01', NULL, 0, 0, 0, '444014', '8809237828362 ', NULL, NULL, '2016-08-03 14:38:06'),
(111026, 888030, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/38be902832bb43df8093dd497836559d1470206381419.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/f8e0bc0c955a48eaa14b73eebd74b2831470206390301.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c19d0adb469f4190a85f1acae415952e1470206390412.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/1d54270de15a4bdd823d816c746139ca1470206390371.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/843d030eaf4c4f05af84e68ac5f3ced51470206390373.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c4aa3a87987a421da32c9daeb72c95f81470206390399.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 保湿补水海狮面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:39:15', '2017-02-03 14:39:15', NULL, 0, 0, 0, NULL, '8809237828386 ', NULL, NULL, '2016-08-03 14:39:57'),
(111028, 888033, '', '默认', 10, '88.00', '88.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/8f7cf3bc49bb465781e69eeb837f8b621470206366740.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/0d94bf720a444925803181d1ca609aa61470206373272.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8d401a3b23714b1e9f38ba5da31e86be1470206373389.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b93747aced3d4df8ba838fdcc25ae7781470206373404.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fbbb6734ddbc4974884ad7dc444516cb1470206373444.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'the H one 水透保湿蒸汽霜（干性皮肤适用）100ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:39:00', '2017-02-03 14:39:00', NULL, 0, 0, 0, NULL, '8809406895430', NULL, NULL, '2016-08-03 14:40:43'),
(111030, 888036, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/96a5e5c68849445eb22361a90a715e591470206492673.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a29dbb94bdfb4e74807e09105efaed2a1470206500899.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/de00d260af584ec59d72df29a248079f1470206500993.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2e9a497c2ad54dd5a6e394b3f3a63a821470206501012.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/61c9557473324bc184ec70505fb5903c1470206501014.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/429b1517c6e5495a87494d56b03342281470206501049.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 镇定舒缓神龙面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:41:08', '2017-02-03 14:41:08', NULL, 0, 0, 0, NULL, '8809237828409 ', NULL, NULL, '2016-08-03 14:41:46'),
(111032, 888039, '', '默认', 10, '58.00', '58.00', NULL, '10.0', 1, 10, '{"url":"item/photo/20160803/1b7bb6c10fe74a4bb5af6f3cd461fb951470206354984.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/f7f2a398435a4237930eda9261243cc21470206365621.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e8de1879721643589ff7a8cce8f6dd9c1470206365907.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/79e51dec3ed8452c90ba13044ddf17f11470206365971.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 90%补水保湿凝胶 仙人掌凝胶', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:33:53', '2017-02-03 14:33:53', NULL, 0, 0, 0, '444014', '8803348027294', '2016-08-11 11:30:56', NULL, '2016-08-03 14:42:45'),
(111034, 888042, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d6158881160c4dd988f20514af1ca6b01470206610059.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bc09f755f84c4950a59bf1b9f844fe011470206605067.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/afc94716166e42c5b8aafc402c1a21021470206605182.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/6dfc692014604bf2b7ca6a561ab533241470206605152.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2ece87f54f644bdc8c4ebab85cb501c11470206605199.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/14ea85aac3fa470d94b5792cab22d3391470206605163.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP京剧面膜 保湿补水水库京剧脸谱面膜 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:43:13', '2017-02-03 14:43:13', NULL, 0, 0, 0, NULL, '8809237828935 ', NULL, NULL, '2016-08-03 14:44:06'),
(111036, 888045, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d6158881160c4dd988f20514af1ca6b01470206610059.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bc09f755f84c4950a59bf1b9f844fe011470206605067.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/afc94716166e42c5b8aafc402c1a21021470206605182.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/6dfc692014604bf2b7ca6a561ab533241470206605152.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2ece87f54f644bdc8c4ebab85cb501c11470206605199.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/14ea85aac3fa470d94b5792cab22d3391470206605163.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP京剧面膜 保湿补水水库京剧脸谱面膜 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:43:13', '2017-02-03 14:43:13', NULL, 0, 0, 0, NULL, '8809237828935 ', NULL, NULL, '2016-08-03 14:44:48'),
(111038, 888048, '', '均码', 10, '88.00', '88.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d8afc58f3ebf44fe880c34e06101c1521470206649663.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/5c5cf74ac2ea42d481333677877242cf1470206660759.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e52ab72603d447db91ddae6baf3cee601470206660883.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/a3c8178de3904a19912682c30e96fd981470206660885.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'the H one清新保湿蒸汽霜（油性皮肤适用）100ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:43:22', '2017-02-03 14:43:22', NULL, 0, 0, 0, NULL, '8809406895423 ', NULL, NULL, '2016-08-03 14:44:58'),
(111040, 888051, '', '默认', 10, '58.00', '58.00', NULL, '10.0', 9, 3, '{"url":"item/photo/20160803/fab234c292dc4d14ab6d20f74bb3b2a31470206715762.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/7ded638cf2b04a32857ef83ce447c0881470206722427.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/95d1f949796f4ce9a376040bbc97b8a81470206722583.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/500105cff4e547e88c089604c693c5231470206722633.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d298ccd0a45d4312a5b9210694f773f11470206722652.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 90%补水保湿凝胶 燕窝凝胶', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:44:14', '2017-02-03 14:44:14', NULL, 0, 0, 0, '444014', '8803348027300 ', '2016-08-10 14:46:44', NULL, '2016-08-03 14:46:14'),
(111042, 888054, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 2, 10, '{"url":"item/photo/20160803/a99f8e37f66a458d87ebb25452a9820e1470206802152.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/29ec6d0d5d804eb6889e67bcea40fe8f1470206808957.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/5f9d2123e0ec42689700e34aa2716e6b1470206808916.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f14b2b7fae70425e9ea472eb9bc2d1481470206809088.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP京剧面膜 提亮肤色京剧脸谱面膜 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:46:17', '2017-02-03 14:46:17', NULL, 0, 0, 0, '444014', '8809237829376 ', '2016-08-11 11:02:00', NULL, '2016-08-03 14:46:57'),
(111044, 888057, '', '默认', 10, '88.00', '88.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/93f6989428a543ed940b6a7695a008b41470206864592.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/fb4df5a52c1b4633abacbed92d8d16d61470206874843.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/0a5aafa242664bf0bbed268abcdfb3761470206874985.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/9ef0ab2fdd2549a08fdbd5af3f67abf61470206874999.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'the H one 恒润保湿蒸汽霜（中性皮肤适用）100ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:47:04', '2017-02-03 14:47:04', NULL, 0, 0, 0, NULL, '8809406895447 ', NULL, NULL, '2016-08-03 14:48:22'),
(111046, 888060, '', '默认', 10, '95.00', '95.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/71dd01fe58d04afba082f0b41c082f381470206938224.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/419cf2aebf934a23af13e2fa29c09afa1470206944120.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/174c0a79c8f640fc948917d1b08380a11470206944365.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽身体乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:48:08', '2017-02-03 14:48:08', NULL, 0, 0, 0, NULL, '8809458840341 ', NULL, NULL, '2016-08-03 14:49:15'),
(111048, 888063, '', '爽肤水 180ml', 10, '112.00', '112.00', NULL, '10.0', 10, 20, '{"url":"item/photo/20160803/adc7a0097c50486c902ea8a865e5f7a21470206653555.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/7c8ba5fd898748b19b6fb13c02a29fd51470206658061.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/37259e93a5a64aa8992b28a2736c694f1470206658280.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/671f5faf40e6455489fbe3ec6a872a9c1470206658333.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP 控油祛痘系列', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:35:12', '2017-02-03 14:35:12', NULL, 0, 0, 0, '444014', '8809458840037', '2016-08-11 10:55:51', NULL, '2016-08-03 14:49:26'),
(111050, 888063, '', '乳液 180ml', 10, '112.00', '112.00', NULL, '10.0', 1, 10, '{"url":"item/photo/20160803/67b500717dee46df9ca83711f7c101fe1470206711372.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/d5e2fb8057be404b93d2b6df25c2d0d51470206715468.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b834790df2df4181b4757729595de5f91470206715473.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9cd1b9a54cbc4ff897b330c69b6c48de1470206715447.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP 控油祛痘系列', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:44:24', '2017-02-03 14:44:24', NULL, 0, 0, 0, '444014', '8809458840020', '2016-08-10 14:38:33', NULL, '2016-08-03 14:49:26'),
(111052, 888063, '', '精华液 50ml', 10, '125.00', '125.00', NULL, '10.0', 10, 20, '{"url":"item/photo/20160803/5bf510ceefd84fed93f620b52af9f6441470206784042.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6c01fcdef5e14253ac70aa8541bdb9281470206788784.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/3a84ed73da6d4e928268f593204470411470206788984.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d1fcd21f5c0647198485e683bf27222b1470206789025.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP 控油祛痘系列', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:45:20', '2017-02-03 14:45:20', NULL, 0, 0, 0, NULL, '8809458840051', '2016-08-08 11:59:58', NULL, '2016-08-03 14:49:26'),
(111054, 888063, '', '洗面奶 150ml', 10, '78.00', '78.00', NULL, '10.0', 10, 20, '{"url":"item/photo/20160803/2320bfe0d8964be5a562f9223dd242e01470206843758.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/8e0422b385c741cdb30ac299755c61451470206848435.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8392cb4994cc40e38480878a456c881d1470206848522.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b8936389752c42889dfd45eb38e3b4a01470206848454.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP 控油祛痘系列', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:46:34', '2017-02-03 14:46:34', NULL, 0, 0, 0, NULL, '8809458840044', '2016-08-06 17:24:59', NULL, '2016-08-03 14:49:26'),
(111056, 888063, '', '爽肤水 乳液 洗面奶 三件套装 ', 10, '225.00', '225.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/9a80074dbf0b407db4014e8fd33a71711470206904283.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/2b46e171617b4b70859d3690ecba1b3e1470378038841.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/5761e11badc447a787aa72783a7af41d1470378038736.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/b4448987ac3e49c988fe1647e122a84e1470378038744.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/8cb70e6d5090497e9a44bedf556380cf1470378038755.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 控油祛痘系列', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:47:33', '2017-02-03 14:47:33', NULL, 0, 0, 0, NULL, '8809458840068 ', '2016-08-05 14:20:46', NULL, '2016-08-03 14:49:26'),
(111058, 888066, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/34bb3319c08f4bb2bf75e1b7f72022e51470206994282.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/adb24d0fb2dd495e980470e2fd9c0aa31470207001886.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/97442e68c5a24d1f854a6460498186571470207001996.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c48564bcb07843ff96333961b1e43e491470207001966.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP京剧面膜 保湿补水京剧脸谱面膜 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:48:57', '2017-02-03 14:48:57', NULL, 0, 0, 0, NULL, '8809237829352 ', NULL, NULL, '2016-08-03 14:50:09'),
(111060, 888069, '', '均码', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/086f9116b5a94bc69ee3d60a13e0cdd31470207106422.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/790a4e395fa14ffdabb328463ecb1bc71470207120111.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9379f251703248029d8191cbacc06bd01470207120180.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/09c640f0a29143c580bfbf48a5fd45ba1470207120250.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/08b35b77ed21450295ccf173b7e56df31470207120223.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f0545a82ad274cd49b075733a4b1b8af1470207120226.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9c85679c4cff449f98de7567e57ccd701470207120296.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 提亮肤色兔子面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:51:24', '2017-02-03 14:51:24', NULL, 0, 0, 0, '444014', '8809237829161 ', NULL, NULL, '2016-08-03 14:52:08'),
(111062, 888072, '', '默认', 10, '95.00', '95.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/271c3debbfd1474e8f5fb03d7f4b6cd71470207199886.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/ddead2aaa43b42af941fce361bd84e5b1470207204837.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a30341af40ac412ea87cc1f62649b96b1470207205083.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽沐浴露', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:51:44', '2017-02-03 14:51:44', NULL, 0, 0, 0, NULL, '8809458840334 ', NULL, NULL, '2016-08-03 14:53:38'),
(111064, 888075, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/221e4c46b21f4c9da9299d4f667fbc1c1470207249125.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/d5a3fbabd1a74597ac6a2a638b1f95191470207256584.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/219545581f624527981e7d3574bc405e1470207256759.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f3c82270b72946e8b2ba10bb906fcc9d1470207256762.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9e12ecc0621b45fc9e5a46fd15190d9f1470207256769.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/64693389056c4a73b2eabae766d832a71470207256733.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 保湿补水松鼠面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:53:42', '2017-02-03 14:53:42', NULL, 0, 0, 0, NULL, '8809237829185 ', NULL, NULL, '2016-08-03 14:54:26'),
(111066, 888078, '', '均码', 10, '95.00', '95.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d469692948ee4484adf474c74401de891470207320264.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/f2bb9cfb2a5243c586226d2e9f0e75671470207325803.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fa95685d21ee4e37835a483d8b0e0d661470207326138.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 青柠身体乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:54:42', '2017-02-03 14:54:42', NULL, 0, 0, 0, NULL, '8809458840372 ', NULL, NULL, '2016-08-03 14:55:35'),
(111068, 888081, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/9ae2cab48e1048e5a8d1a791c16c56df1470207359092.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/dacd5f6ea07f452390fa80d7a50f74571470207364924.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/37077b77fe53467098a3d9f468da66911470207364966.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/64c3f0dcf183460d93883627d617fe8c1470207365009.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP动物面膜 皮肤紧致猫咪面膜贴 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:55:34', '2017-02-03 14:55:34', NULL, 0, 0, 0, NULL, '8809237829147 ', NULL, NULL, '2016-08-03 14:56:14'),
(111070, 888084, '', '默认', 10, '89.00', '89.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/afac14265a4e4d699dd64a5886d82d441470207504415.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/46434545f90740be886662fa742f10801470207509288.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP毛孔清洁洁面泡沫(细致毛孔,平滑肌肤,吸净黑头,深层清洁)', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:57:23', '2017-02-03 14:57:23', NULL, 0, 0, 0, NULL, '8809136717149 ', NULL, NULL, '2016-08-03 14:58:35'),
(111072, 888087, '', '默认', 10, '95.00', '95.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/aa3755cbe4d542a6a6e6b25b411a322b1470207531671.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/1301ca61773b4ad9ad9b210d8461aecd1470207537505.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/abe8162a562b46b5bd45e87494a9c7491470207537812.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 青柠沐浴露', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:57:56', '2017-02-03 14:57:56', NULL, 0, 0, 0, NULL, '8809458840365 ', NULL, NULL, '2016-08-03 14:59:09'),
(111074, 888090, '', '默认', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/a59d935b33564433b57b410d80e356da1470207664953.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/43c09de8ae7b486582f26a2f65cf61121470207672147.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2f36e69025104f4ea4335c0653d0300a1470207672252.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a80cada0d51c4d65b26bfc8c76893feb1470207672226.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP控油收毛孔整理肌肤纹理面膜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:00:24', '2017-02-03 15:00:24', NULL, 0, 0, 0, NULL, '8809298736118 ', NULL, NULL, '2016-08-03 15:01:18'),
(111076, 888093, '', '默认', 10, '75.00', '75.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/652cfaf3aae44c1ca1ca95162bafc3a21470207675218.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/abc39590b59a48a69a22e5b96a134eca1470207680298.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c16b8e817d154ad4a447a1fc4637c32f1470207680603.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 青柠身体喷雾', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:00:25', '2017-02-03 15:00:25', NULL, 0, 0, 0, NULL, '8809458840389 ', NULL, NULL, '2016-08-03 15:01:41'),
(111078, 888096, '', '默认', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/93ccc1e85a6e473d87ba02f5c9a87ff11470207807092.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/75043d5aae0b4b88a90fbf3cbadf4e621470207818546.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9952c27b380846ce9bb624ccb1a72abe1470207818574.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/baebfef4de4540bf996e6824339f60381470207818597.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP补水保湿舒缓睡眠面膜 平衡肌肤 祛痘控油 夜间修复镇静', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:02:39', '2017-02-03 15:02:39', NULL, 0, 0, 0, NULL, '8809298736101 ', NULL, NULL, '2016-08-03 15:03:46'),
(111080, 888099, '', '默认', 10, '75.00', '75.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/528b62eed9e24413b4113c3aa1e30cca1470377972586.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/dbd1956dd58a4548a981d96dc9b59cbe1470207873229.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e3e1f1c1fe22465aaa8c74f4831bd6641470207873325.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽身体喷雾', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:03:00', '2017-02-03 15:03:00', NULL, 0, 0, 0, NULL, '8809458840358 ', '2016-08-05 14:19:37', NULL, '2016-08-03 15:04:52'),
(111082, 888102, '', '默认', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/75789fcaadbd44c99550f52aa5d47e3b1470207937916.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/8fe282f101e1451aa21679a0ba71fe8b1470207945563.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2b72e826da6c4c3aaeaf86b1b71b04111470207945706.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/bd48287e8a1c4f02978702035b662ab01470207945717.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP水漾回弹热感睡眠面膜 改善皱纹 改善粗糙皮肤', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:04:55', '2017-02-03 15:04:55', NULL, 0, 0, 0, NULL, '8809298736095 ', NULL, NULL, '2016-08-03 15:05:51'),
(111084, 888105, '', '椰子补水面膜', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7ef76400098f48c4a86e19b87e6ef81e1470207235039.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/e617903fc2b64e29b22c2a380cb81ecc1470207239758.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/083556a6411844c89042bfd5be3395eb1470207240023.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8e4a4a079b8549be8987a6bfeb62d1bb1470207240064.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:51:56', '2017-02-03 14:51:56', NULL, 0, 0, 0, NULL, '8809458841003', NULL, NULL, '2016-08-03 15:07:10'),
(111086, 888105, '', '葡萄柚美白面膜', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/96d35d15c3cb45439632cb5ef285c5751470207306307.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/2f34b76947ad48efaf06e0238e58a6ba1470207311586.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2f58ef81ca5848aebddb18ce74fbc39c1470207311868.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/23d8c048b20842c2aebd60bcaa2659601470207311881.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:54:14', '2017-02-03 14:54:14', NULL, 0, 0, 0, NULL, '8809458840969', NULL, NULL, '2016-08-03 15:07:10'),
(111088, 888105, '', '石榴弹力面膜', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5425a16af1d44ac0b497849d74897bc11470207353184.jpg","width":"662","height":"662"}', '[{"url": "item/photo/20160803/464a1e7631dc4cee8da687b499ad08151470207358451.jpg", "width": "662", "height": "662"}, {"url": "item/photo/20160803/280e3c86a3a44657b8f8e6bec84c1dca1470207358453.jpg", "width": "597", "height": "597"}, {"url": "item/photo/20160803/33fa815bea8e413a98a1d4502cd705cf1470207358438.jpg", "width": "546", "height": "546"}]', 0, 0, 'Y', 'SZ', 0, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 14:55:16', '2017-02-03 14:55:16', NULL, 0, 0, 0, NULL, '8809458840945', NULL, NULL, '2016-08-03 15:07:10'),
(111090, 888105, '', '牛油果营养滋润面膜', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/b6f8325d118143b788c096b59316e6101470207898375.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/2823b55be62b411791c0d873465c82bd1470207921988.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2cb5df043ffa48a5a1c4db139e5694c41470207925531.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:04:24', '2017-02-03 15:04:24', NULL, 0, 0, 0, NULL, '8809458840983', NULL, NULL, '2016-08-03 15:07:10'),
(111092, 888105, '', '鸭梨镇定皮肤面膜', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/ef06a13b130e4013a858c3377d3220751470207978819.jpg","width":"543","height":"543"}', '[{"url": "item/photo/20160803/26a73f3470a4432996ed87915c1daac61470207984887.jpg", "width": "543", "height": "543"}, {"url": "item/photo/20160803/cf8d3829c5cd4f7888e33c2917b6d4051470207984864.jpg", "width": "614", "height": "614"}, {"url": "item/photo/20160803/bb55421534ed40d08d5e310b314711a91470207985085.jpg", "width": "496", "height": "496"}]', 0, 1, 'Y', 'SZ', 0, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:05:40', '2017-02-03 15:05:40', NULL, 0, 0, 0, NULL, '8809458841027', NULL, NULL, '2016-08-03 15:07:10'),
(111094, 888108, '', '均码', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/3e6ece2254c1411d82de4b9cc2c52fc61470208013929.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/73df9bb66c584b7a997335c75eafab161470208020063.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/17ac07831a6d4a9f89151778f5fac2891470208020322.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡洗发护发系列 洗发精', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:06:16', '2017-02-03 15:06:16', NULL, 0, 0, 0, NULL, '8809458840297 ', NULL, NULL, '2016-08-03 15:07:16'),
(111096, 888111, '', '默认', 10, '68.00', '68.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/2a8d12e3f32d4f0e906fcd15c0648da41470208110273.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/aa1d9df5f68f408dabe4329a1d0c2e2c1470208116984.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8cb0d0bad6064f59924bc8217a3948701470208117029.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP98%天然保湿 晒后修复芦荟胶', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:07:51', '2017-02-03 15:07:51', NULL, 0, 0, 0, NULL, '8809237825033 ', NULL, NULL, '2016-08-03 15:08:43'),
(111098, 888114, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/eb14a6a3b5394d01a09908be86d6e19e1470208198833.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/07f654326f314eedb8a9ddcbe0c8c0751470208205578.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/483857ce0a294e1daa808ff7837c31c11470208205784.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 夜光睡眠面膜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:09:32', '2017-02-03 15:09:32', NULL, 0, 0, 0, NULL, '8809147220850', NULL, NULL, '2016-08-03 15:11:08'),
(111100, 888117, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/b325e0b402ce406d90f1223b95d88bfa1470208166865.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/cc606783b1c348c58653fffd0b0dc3821470208175075.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/528714c9f0714ca48179471f7a1ab7331470208175399.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡洗发护发系列 护发素', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:08:35', '2017-02-03 15:08:35', NULL, 0, 0, 0, NULL, '8809458840303 ', NULL, NULL, '2016-08-03 15:11:11'),
(111102, 888120, '', '默认', 10, '68.00', '68.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/88abd985f1fd4b38a41f32886836181a1470208315788.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/e5b45b7567804e89a83fd690f33daaca1470208324577.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/ae187b3cedd0431b9e6e7ecc777c64881470208324675.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c0dc5ee950aa4c908015b672ef33d4d11470208324688.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP马油改善皱纹滋润皮肤护手霜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:10:35', '2017-02-03 15:10:35', NULL, 0, 0, 0, NULL, '8809248459579 ', NULL, NULL, '2016-08-03 15:12:16'),
(111104, 888123, '', '默认', 10, '109.00', '109.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/e2e729b053b1497a9ec4ae1af0ddacc01470208409876.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/dfb32c14d9ac42f884d3afa7e38133901470208414660.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/309660da0c474c12a7aab04cf5a333481470208414938.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡洗发护发系列 护发精油', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:12:22', '2017-02-03 15:12:22', NULL, 0, 0, 0, NULL, '8809458840310 ', NULL, NULL, '2016-08-03 15:13:43'),
(111106, 888126, '', '默认', 10, '88.00', '88.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/817a721f88f24673920625329d5fb5661470208496123.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6f1804d593474e0a8ca0615316f424f71470208502881.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b193fae0a93a4911b9ac299a7d9205141470208502994.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP可爱香气颗粒沐浴露', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:14:04', '2017-02-03 15:14:04', NULL, 0, 0, 0, NULL, '"8809248459395 "', NULL, NULL, '2016-08-03 15:15:09'),
(111108, 888129, '', '均码', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/b4fa2bddf6cc4d3eb97d5b71e1c7b0631470208494188.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/49c81043560b4f65b4033483c2e76c1f1470208498978.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 贪心少女高效防晒霜 50ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:14:26', '2017-02-03 15:14:26', NULL, 0, 0, 0, NULL, '8809147220522', NULL, NULL, '2016-08-03 15:15:10'),
(111110, 888132, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d1edf4c237644dcba1025da171abac401470208701342.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/905b32579b1b4256bda0c38a9a2759611470208708315.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/66deda75eca4409d82256ed3d9faf7911470208708319.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP可爱花香保湿润肤身体乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:17:44', '2017-02-03 15:17:44', NULL, 0, 0, 0, NULL, '8809248459418', '2016-08-05 14:21:22', NULL, '2016-08-03 15:19:00'),
(111112, 888135, '', '默认', 10, '67.00', '67.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/1e388d1dacb94ef5ab490c27455e8d301470208613200.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bbd4e731f4c84ba19f57cf3b8caab9c91470208618638.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/adf478b5a51d427e8e5bf2d94a2eb3931470208618853.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP首尔咖啡洗发护发系列 护发喷雾', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:14:53', '2017-02-03 15:14:53', NULL, 0, 0, 0, NULL, '8809458840327 ', NULL, NULL, '2016-08-03 15:20:13'),
(111114, 888138, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/64c8b38547514e9a97f803d6014443511470208849293.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/9e00d50c1e3447d0907299fcbcea75e61470208855808.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/aaf584dd4e10413988b36abef4bbab4a1470208855903.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP可爱婴儿香保湿润肤身体乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:20:27', '2017-02-03 15:20:27', NULL, 0, 0, 0, NULL, '8809248459425 ', NULL, NULL, '2016-08-03 15:21:05'),
(111116, 888141, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/50494dc5844447929369876a12c6b73c1470208967448.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a31ecce5ac384fef8e4532dd6e17673b1470208974119.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/27224d9ffb844264a2fff869d5e337fe1470208974221.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP可爱棉花香保湿润肤身体乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:22:11', '2017-02-03 15:22:11', NULL, 0, 0, 0, NULL, '8809248459432 ', NULL, NULL, '2016-08-03 15:23:04'),
(111118, 888144, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/94095fb4e5a14cf3b47c946de63d16e51470209043806.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/891498826ff9437990872f7517bfea281470209048419.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 贪心少女DD霜 SPF40 PA++', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:23:42', '2017-02-03 15:23:42', NULL, 0, 0, 0, NULL, '8809147220508', NULL, NULL, '2016-08-03 15:24:32'),
(111120, 888147, '', '默认', 10, '67.00', '67.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/1fa120ef212f4b67b984358b408345be1470209070072.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/3a7adbb870c9479a86068789084d88b71470209076047.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, ' SNP 马油滋润身体护肤乳', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:23:38', '2017-02-03 15:23:38', NULL, 0, 0, 0, NULL, '8809458840563 ', NULL, NULL, '2016-08-03 15:25:21'),
(111122, 888150, '', '默认', 10, '45.00', '45.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/e0386ffc61484ef797ff3c6f8d23c8b31470209152133.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/5f97bf6e3a8d4bc5bb389ce97ec559af1470209159013.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b75ccd79177c4963b98f9759b35b60bb1470209159126.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/1e0c55825c6743b697e4282df89536501470209159141.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 97%天然保湿芦荟胶300g 免洗睡眠面膜 晒后修复霜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:24:47', '2017-02-03 15:24:47', NULL, 0, 0, 0, NULL, '8809237825187 ', NULL, NULL, '2016-08-03 15:26:08'),
(111124, 888153, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/2919f7e3765449d9a13d6df4190be9271470209261332.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/d10eccf6b2a64ec39a098a765f8449201470209266712.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 贪心少女牛奶洁白乳霜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:26:57', '2017-02-03 15:26:57', NULL, 0, 0, 0, NULL, '8809147220270', NULL, NULL, '2016-08-03 15:28:01'),
(111126, 888156, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/08bdb5c7977248b9a845685758844ee81470209300800.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/dca3978b3b67482badddf744c7e096b11470209309281.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c2e73a6b79744692a2b55881ee569e8f1470209309395.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/7bde1191d0fc49a0b20480b794ea59381470209309373.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP黑头清洁套装三步曲6片 去黑头鼻贴男女收缩毛孔', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:27:43', '2017-02-03 15:27:43', NULL, 0, 0, 0, NULL, '8809162798891 ', NULL, NULL, '2016-08-03 15:28:39');
INSERT INTO `inventories` (`id`, `item_id`, `item_color`, `item_size`, `amount`, `item_src_price`, `item_price`, `item_cost_price`, `item_discount`, `sold_amount`, `rest_amount`, `inv_img`, `item_preview_imgs`, `or_destroy`, `or_master_inv`, `state`, `inv_area`, `restrict_amount`, `inv_title`, `inv_customs`, `postal_tax_code`, `inv_weight`, `postal_tax_rate`, `carriage_model_code`, `record_code`, `or_vary_price`, `start_at`, `end_at`, `share_url`, `share_count`, `collect_count`, `browse_count`, `theme_id`, `inv_code`, `update_at`, `destroy_at`, `create_at`) VALUES
(111128, 888159, '', '默认', 10, '216.00', '216.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/65249b847d854137aeb1b933ddce5f711470209309449.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bc5e3492fe4e4086a3dd1125c8d23f3b1470209314743.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e498347f4dcc45ce8217e577a020c8101470209315176.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP燕窝精华亮白面霜补水保湿滋润水油平衡', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:27:41', '2017-02-03 15:27:41', NULL, 0, 0, 0, NULL, '8809458841225 ', NULL, NULL, '2016-08-03 15:30:00'),
(111130, 888162, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/32fb56ba8b0c47c7bbe38e8caea62b641470209423730.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/a55405a0a16843529b5157c963196cf21470209429009.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 贪心少女油脂控制水珠保湿霜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:29:56', '2017-02-03 15:29:56', NULL, 0, 0, 0, NULL, '8809147220843', NULL, NULL, '2016-08-03 15:30:41'),
(111132, 888165, '', '默认', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/f8865f568f794035beee98fcc9c58f551470209455564.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bd3d3c1e6c3547d89fb0ebe9d7c4d6c81470209460073.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 补水滋润睡眠面膜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:30:19', '2017-02-03 15:30:19', NULL, 0, 0, 0, NULL, '8809390123557 ', NULL, NULL, '2016-08-03 15:31:06'),
(111134, 888168, '', '默认', 10, '139.00', '139.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5f30c2bd71c14a089f27d1b6e4cc4e521470209529477.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/b7b1f125f86245a480a1aca2379e6cd41470209537088.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b1e74a79267e42d3a2a6da15af73331c1470209537377.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP三部曲螺旋纹紧致面膜贴 黄金蚕丝款 ', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:31:25', '2017-02-03 15:31:25', NULL, 0, 0, 0, NULL, '8809458841669 ', NULL, NULL, '2016-08-03 15:32:24'),
(111136, 888171, '', '默认', 10, '198.00', '198.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/4956448ddd60497aaea7bb47540ffa9b1470209583277.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/0957213190ed485e94be2dd0ccc058b81470209591063.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f9f647a1028e4ca287fccee6943b4bab1470209591127.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/3a3b368c65684af792a7a63f2651a5541470209591104.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e945c2baecd049268f2ea88b065f6ab91470209591117.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e2f5d49987eb496e859608b3e8d463e21470209591122.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP济州岛发酵马油霜 滋润皮肤 改善皱纹 修复皮肤', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:32:17', '2017-02-03 15:32:17', NULL, 0, 0, 0, NULL, '8809390123564 ', NULL, NULL, '2016-08-03 15:33:20'),
(111138, 888174, '', '默认', 10, '80.00', '80.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/b161fe9a58c44894b7ac6941f2c97b641470209640947.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/28f67c9e7312459d9f8d7ab7254b13dd1470209645190.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 玫瑰精华洁面泡沫', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:33:19', '2017-02-03 15:33:19', NULL, 0, 0, 0, NULL, '8809147220652', NULL, NULL, '2016-08-03 15:34:12'),
(111140, 888177, '', '默认', 10, '139.00', '139.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/83133cfa2e444f21b8c7c008126f60441470209686097.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a91fc3ee2c2a4e6b80a2b694c7a497fc1470209692410.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a783c6da8ad64894b037e226f7d530f31470209692773.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e4fe7639072d4ad8b0a8bf707a1d53311470209692756.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP三部曲螺旋纹紧致面膜贴 海洋燕窝款', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:33:48', '2017-02-03 15:33:48', NULL, 0, 0, 0, NULL, '8809458841683 ', NULL, NULL, '2016-08-03 15:35:01'),
(111142, 888180, '', '紧肤款', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/f3f874a36d8646418756df90d6d1c9931470208130228.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/f5e84107b33d497ab4a10591f9318b3e1470208139493.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/dc80b4bf1ea2436785890371d338f62c1470208139818.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/94d495c75ce04409b65477847ec4e6941470208139793.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP维他命果冻调理面膜补水保湿提亮肤色润颜滋养 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:07:45', '2017-02-03 15:07:45', NULL, 0, 0, 0, NULL, '8809458841515', NULL, NULL, '2016-08-03 15:35:23'),
(111144, 888180, '', '镇静款', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/29061209d5fe4d2d98a47a7cfd9c173f1470208207925.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/7cbf3ad0d0334ed3955704914455f5411470208213107.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/cb7d26d1e3ed4bc587576325d96e81451470208213457.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d3e112b160ff494c88fc9e67dc6d52c61470208213435.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP维他命果冻调理面膜补水保湿提亮肤色润颜滋养 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:09:04', '2017-02-03 15:09:04', NULL, 0, 0, 0, NULL, '8809458841539', NULL, NULL, '2016-08-03 15:35:23'),
(111146, 888180, '', '提亮款', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/9d23e71a1d264ab8917bbd6d6e768cbe1470208266554.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6d0a31cdece14408893d41e48f938da41470208272334.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c5ddf6f0edfd4d7a81022d7c29363ae11470208272585.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2328554cc36844448ce34e1b024263521470208272561.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a3f854e9ee04450a8229a8342ddaa2ca1470208272754.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP维他命果冻调理面膜补水保湿提亮肤色润颜滋养 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:10:19', '2017-02-03 15:10:19', NULL, 0, 0, 0, NULL, '8809458841522', NULL, NULL, '2016-08-03 15:35:23'),
(111148, 888180, '', '保湿款', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/ea862c0c3c7e49a1944140ae2ab3926b1470209517469.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bf02acf1cf1746b2a87f17061095786b1470209522864.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/feec6e95a0e84302bbf73f8cec4ef84c1470209523199.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b7ae5ccc99e94464bd258d8816ea7f7b1470209523101.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP维他命果冻调理面膜补水保湿提亮肤色润颜滋养 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:31:02', '2017-02-03 15:31:02', NULL, 0, 0, 0, NULL, '8809458841546', NULL, NULL, '2016-08-03 15:35:23'),
(111150, 888183, '', '默认', 10, '98.00', '98.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/a856ee12f61546cda5aeb9b11c0dcf651470209714735.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/72bf2cef9cce49f38d062344e7055ac81470209723041.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d48fd4e0222246b2929196f55227af861470209723185.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/1a1f2aedb8384c22990edcb56252c35e1470209723150.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/4db9c994e9fb4f319576df1c25f2e8081470209723164.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP马油精华面膜 改善皱纹 滋润皮肤 保湿补水 10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:34:39', '2017-02-03 15:34:39', NULL, 0, 0, 0, NULL, '8809458840419', NULL, NULL, '2016-08-03 15:35:39'),
(111152, 888186, '', '默认', 10, '69.00', '69.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/23754b3b27d940d88b99592f541e95821470209830345.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/7fa503273a884983a0496ae2ea831adf1470209836064.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Velieve 薇丽肤 竹汁液护理BB霜 SPF25/PA++', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:36:24', '2017-02-03 15:36:24', NULL, 0, 0, 0, NULL, '8809147220676', NULL, NULL, '2016-08-03 15:37:28'),
(111154, 888189, '', '默认', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7bd40cceceb8446dbe60078e3e2c01d21470209935303.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/fd2b75c00b0846eba6036d256520e5561470209944944.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/2c0cbefcc21a45929a3b745275661ea81470209945283.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d95d65836120495a9c4b33a7f56a69961470209945324.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 水果清凉保湿补水霜 葡萄柚', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:38:12', '2017-02-03 15:38:12', NULL, 0, 0, 0, NULL, '8809458841690 ', NULL, NULL, '2016-08-03 15:39:20'),
(111156, 888192, '', '默认', 10, '89.00', '89.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/723ccc3a3005491db74c71479041a06c1470210035419.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/7a175fe224754e6682416101be5471431470210044273.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/aabeae4a835e48978ba5aac2a052a2ae1470210044417.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/635f9468920040d7a0906e2e0ccacbef1470210044449.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/9bb359b461374a27894b399951340d0e1470210044431.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 泡沫蒂娜 木炭洗面奶150ml& 野蛮蒂娜 水分面膜26g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:39:59', '2017-02-03 15:39:59', NULL, 0, 0, 0, NULL, '8809392415223', NULL, NULL, '2016-08-03 15:40:57'),
(111158, 888195, '', '默认', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d39fbe26b8624cc597d8591403e599c21470210061473.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/97f37008a91b4320b10ee159c0ff805f1470210067524.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8eb5936363b54467b42f2f7b6ee0959f1470210067938.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/7df62ef431ea4d828816c8011d49b4ca1470210068000.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP 水果清凉保湿补水霜 芒果', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:40:24', '2017-02-03 15:40:24', NULL, 0, 0, 0, NULL, '8809458841706 ', NULL, NULL, '2016-08-03 15:41:14'),
(111160, 888198, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5eb8229331724accb5577292c6b93fb71470210129314.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/7ab7a32231214997a1ca07c222b112da1470210134282.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SKIN1004钻石僵尸面膜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:41:21', '2017-02-03 15:41:21', NULL, 0, 0, 0, NULL, '8809205633943 ', NULL, NULL, '2016-08-03 15:42:20'),
(111162, 888201, '', '保湿补水款', 10, '139.00', '139.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/16e20bec647e49209320ecca31e3a6541470209896787.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/463d0ef34fac491a851386d77d2ea5bf1470209903275.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/df88bec1af8a4768a6bbb6d14548a1041470209903546.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/a69674bbc3aa4e829d9bd1e2128f22ba1470209903627.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/191647c462054416af14971f3d448c3d1470209903646.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP奶油霜面膜5片装 补水深层保湿清洁收毛孔控油', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:36:20', '2017-02-03 15:36:20', NULL, 0, 0, 0, NULL, '8809458841492', NULL, NULL, '2016-08-03 15:44:08'),
(111164, 888201, '', '提亮肤色款', 10, '139.00', '139.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/ebc2ceb722af48f1835317ef3271eb031470209968226.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/2151051a92894c3a90bb5181bd935a081470209973416.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/07e5d6f01aab480597074556854474551470209973775.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/cc9d0b534adb4050910baf1169d35dad1470209973741.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/4d6b860b8ba4427ea395e57d86126c451470209973771.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'SNP奶油霜面膜5片装 补水深层保湿清洁收毛孔控油', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:38:29', '2017-02-03 15:38:29', NULL, 0, 0, 0, NULL, '8809458841485', NULL, NULL, '2016-08-03 15:44:08'),
(111166, 888201, '', '修复款', 10, '139.00', '139.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/0c882f11b50b400fbe34440cc752c0d41470210020342.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/15daedd112284efb9a030721808ce5921470210025345.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/8f422b16b4c24683a91dcfae3e3edeb61470210025167.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/fa6dcf4fe2d84bc9b6611d18705976e31470210025276.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'SNP奶油霜面膜5片装 补水深层保湿清洁收毛孔控油', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:39:37', '2017-02-03 15:39:37', NULL, 0, 0, 0, NULL, '8809458841508', NULL, NULL, '2016-08-03 15:44:08'),
(111168, 888204, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/3307d627d1e74bf7820272aa4e942f921470210271664.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/c28d32ffcdf54187a5b335599c4ef7551470210278866.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/30e206cd16864f8087457b6e25ed822e1470210278988.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'skin1004 修复面霜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:44:06', '2017-02-03 15:44:06', NULL, 0, 0, 0, NULL, '8809205632663 ', NULL, NULL, '2016-08-03 15:44:59'),
(111170, 888207, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/f167595c9af44a6ebbc7d4d858af47061470210321596.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/262139508e8044bcaebc381f19eedade1470210328804.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/bb84ca2e57504711951686ee54bf69021470210328973.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/3340816a857d4b33b195c653a3ecf57b1470210328954.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/7b83c36fee6f46c087c209b0c6b1c8761470210328977.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/e9d7d7ec33634816804a7d19eef6b58b1470210328980.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 眨眼睛蒂娜 蚕丝 护发精华80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:43:46', '2017-02-03 15:43:46', NULL, 0, 0, 0, NULL, '8809392413663', NULL, NULL, '2016-08-03 15:46:00'),
(111172, 888210, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/43561a7078754a9aa2a648f24adf496a1470210411038.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/db2e53098765462dbe19f4ae01f5ddfe1470210417175.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'skin1004 僵尸鼻贴三部曲 7g*10', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:46:18', '2017-02-03 15:46:18', NULL, 0, 0, 0, NULL, '8809375620736 ', NULL, NULL, '2016-08-03 15:47:06'),
(111174, 888213, '', '默认', 10, '86.00', '86.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/67734a6a02a5444db0e9560e2b7825d31470210716201.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/f87b7d17fdee4d3999ac6fc9242e7a801470210727092.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/979804b03801412184c36fa56ffad7581470210727235.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/696ed7212d1b4974be57bce7fb35155a1470210727170.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/458be7d30c2a4dd4838e7496fe56a7841470210727213.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 太阳镜蒂娜 防晒霜80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:51:21', '2017-02-03 15:51:21', NULL, 0, 0, 0, NULL, '8809392413632', NULL, NULL, '2016-08-03 15:52:43'),
(111176, 888216, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d08fdb33960345e8b0c48ee96849f36c1470210755148.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6a5317844e7c4381a3c8171f6c7a39861470210762630.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'skin1004 积雪草精华液', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:51:54', '2017-02-03 15:51:54', NULL, 0, 0, 0, NULL, '8809313000170 ', NULL, NULL, '2016-08-03 15:52:50'),
(111178, 888219, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/fd97ae12214f4a2aa206156e2793be941470211659855.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/0e33f3a6b1b542fdb5031a29589cab7a1470211671578.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/731824f2f97a40bea0db4112418d301d1470211671668.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/b4f68be51e3d4c9880d635b609184b911470211671678.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/7c1ba9901ffe418eb1e19fcd653bf25f1470211671747.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 野蛮蒂娜 水分 香气气垫粉15g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:07:20', '2017-02-03 16:07:20', NULL, 0, 0, 0, NULL, '8809392413670', NULL, NULL, '2016-08-03 16:08:02'),
(111180, 888222, '', '默认', 10, '79.00', '79.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/dedbd324c2e340f8a781119c329a93041470211713785.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/cad3153ccc724c0c972b21522b914d4b1470211720651.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/c92ffd8420b246599cb293377eada3261470211720720.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/471238365cbb4ffca77c85df8f3046fb1470211720722.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'skin1004 蚕丝洁面皂 ', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:08:06', '2017-02-03 16:08:06', NULL, 0, 0, 0, NULL, '8809077980558 ', NULL, NULL, '2016-08-03 16:08:49'),
(111182, 888225, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d7a4d6f39629451e974dd44f69ce715b1470211812481.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/4cd624b84b844c0284db71feccadb0d21470211831369.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/5dd749dd46d145459070235940ba672c1470211831475.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/1fae848879004681a2aba5589bea11b61470211831473.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/3f70ce4383cb440c8a623ab4cb1e0b9d1470211831450.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 撕拉唇彩 套装（15g*3） & 护唇膏（4g*1）', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:09:54', '2017-02-03 16:09:54', NULL, 0, 0, 0, NULL, '8809392413687', NULL, NULL, '2016-08-03 16:10:42'),
(111184, 888228, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/761c928c277f46638c6a10462fc3fa4b1470211891744.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/22b417e9a0d844d5a54fd0f63a197b6b1470211896411.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'skin1004 僵尸面膜', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:10:49', '2017-02-03 16:10:49', NULL, 0, 0, 0, NULL, '8809320244093 ', NULL, NULL, '2016-08-03 16:11:42'),
(111186, 888231, '', '默认', 10, '58.00', '58.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/1d59360626a2455baa8cb0aeb77388d61470212016113.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/79c5f7c89f734a80992483ecd3a5827b1470212020913.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 滋润型唇膏（滋润）', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:12:56', '2017-02-03 16:12:56', NULL, 0, 0, 0, NULL, '8809392415650 ', NULL, NULL, '2016-08-03 16:13:48'),
(111188, 888234, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5f6e3db1da1f4896bf9e613435bb521d1470212008071.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/0b196d65fb0e4f92a8661cc1be8eff5b1470212040806.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/cf7705b44a7c4aca877fc8420cf2e75a1470212040793.jpg", "width": "0", "height": "0"}, {"url": "item/photo/20160803/48c5a7bf23814acca7c63cb6b73e7e531470212040841.jpg", "width": "0", "height": "0"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 泡泡蒂娜 遮瑕BB霜50ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:12:15', '2017-02-03 16:12:15', NULL, 0, 0, 0, NULL, '8809392415216', NULL, NULL, '2016-08-03 16:14:11'),
(111190, 888237, '', 'No.14柠檬酸橙 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d6216acd63a24bec86611c542402f89d1470210725626.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/3eb43071a6864c6a88f99701dfafd4481470210729210.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:51:09', '2017-02-03 15:51:09', NULL, 0, 0, 0, NULL, '8805301150148', NULL, NULL, '2016-08-03 16:14:31'),
(111192, 888237, '', 'No.45晨雨 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/d00402392cdd4169b71e22c99f94eff91470210769623.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/17555d190acb463db825ecef9e2e70b11470210773601.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:52:15', '2017-02-03 15:52:15', NULL, 0, 0, 0, NULL, '8805301150452', NULL, NULL, '2016-08-03 16:14:31'),
(111194, 888237, '', 'No.46清纯百合 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5f50eedc138f489791014c99152f1a841470211607237.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/4361898889c74a2bb5c872d6e7d1d71c1470211611312.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:05:48', '2017-02-03 16:05:48', NULL, 0, 0, 0, NULL, '8805301150469', NULL, NULL, '2016-08-03 16:14:31'),
(111196, 888237, '', 'No.49桃花 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7584395fc87849898ea3504122c9d5f21470211645593.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a3101c0709a3461890acf2312342ddd31470211648673.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:06:55', '2017-02-03 16:06:55', NULL, 0, 0, 0, NULL, '8805301150490', NULL, NULL, '2016-08-03 16:14:31'),
(111198, 888237, '', 'No.51葡萄柚 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/5b4490782c564143852acb4f40731aea1470211683623.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/3497b63b580b4e22bcd8af9e6a948afc1470211687521.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:07:32', '2017-02-03 16:07:32', NULL, 0, 0, 0, NULL, '8805301150513', NULL, NULL, '2016-08-03 16:14:31'),
(111200, 888237, '', 'No.64可爱玫瑰 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/133be645c6904f47900ba6a2dbeb77ca1470211736860.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/e2fe31eb190245618e93a4e70211f9541470211742474.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:08:12', '2017-02-03 16:08:12', NULL, 0, 0, 0, NULL, '8805301150643', NULL, NULL, '2016-08-03 16:14:31'),
(111202, 888237, '', 'No.97四月棉花 150ml', 10, '118.00', '118.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/a4c2971311044e1dbba1d70f22d6eeb91470211794244.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/97f4088a743f435eb5aec5ec1b65f3f31470211798042.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:09:06', '2017-02-03 16:09:06', NULL, 0, 0, 0, NULL, '8805301150971', NULL, NULL, '2016-08-03 16:14:31'),
(111204, 888237, '', 'No.14柠檬酸橙 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/be41cf41efb74da8af9156bbadae8b891470211840246.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a020752dbd3e480983e7a9c9e1d426991470211843091.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:10:02', '2017-02-03 16:10:02', NULL, 0, 0, 0, NULL, '8805301070149', NULL, NULL, '2016-08-03 16:14:31'),
(111206, 888237, '', 'No.45晨雨 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/0c4bb2172d1247fba109453a1ec57a411470211875547.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a15b38a790604e94abc9af747b255e281470211878383.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:10:47', '2017-02-03 16:10:47', NULL, 0, 0, 0, NULL, '8805301070453', NULL, NULL, '2016-08-03 16:14:31'),
(111208, 888237, '', 'No.46清纯百合 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/33ff3fa872124f57bb7bda508a52af671470211908458.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/936d199d9e7a44cab5e5d05607633c141470211911140.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:11:27', '2017-02-03 16:11:27', NULL, 0, 0, 0, NULL, '8805301070460', NULL, NULL, '2016-08-03 16:14:31'),
(111210, 888237, '', 'No.49桃花 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/ed9cff26c7f440ec9b13c729c52501561470211944251.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/3ea9919b2d8c46ba87bb52e1e810cc721470211946790.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:11:55', '2017-02-03 16:11:55', NULL, 0, 0, 0, NULL, '8805301070491', NULL, NULL, '2016-08-03 16:14:31'),
(111212, 888237, '', 'No.51葡萄柚 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/b28f1521d78d426796439d2aeff1dd2f1470211979372.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/2686a58f5ec7468c97a2551a0aca55561470211982164.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:12:36', '2017-02-03 16:12:36', NULL, 0, 0, 0, NULL, '8805301070514', NULL, NULL, '2016-08-03 16:14:31'),
(111214, 888237, '', 'No.64可爱玫瑰 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/2c3ca1c2d3df4ead80ab20196e05eecd1470212021733.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/4ec888e5ed3546a6970ed286378ed3bb1470212025759.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:13:06', '2017-02-03 16:13:06', NULL, 0, 0, 0, NULL, '8805301070644', NULL, NULL, '2016-08-03 16:14:31'),
(111216, 888237, '', 'No.97四月棉花 70ml', 10, '53.00', '53.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7cb97ab502b74414a74608294ac9681f1470212060185.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/cdc0833ade7a431cb60f8fb361dda7731470212063493.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:13:50', '2017-02-03 16:13:50', NULL, 0, 0, 0, NULL, '8805301070972', NULL, NULL, '2016-08-03 16:14:31'),
(111218, 888240, '', '默认', 10, '58.00', '58.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/6c40a114a23641c1baf978ec180e8a551470212188507.jpg","width":"0","height":"0"}', '[{"url": "item/photo/20160803/fba2d542ef244dd4a549faf9d925ec011470212194292.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 滋润型唇膏（橙色）', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:15:57', '2017-02-03 16:15:57', NULL, 0, 0, 0, NULL, '8809392415674 ', NULL, NULL, '2016-08-03 16:16:43'),
(111220, 888243, '', '默认', 10, '88.00', '88.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/21e2aad06c45459c83c370b658caab0f1470210333875.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/65d9a8cf2179416fa77026eb3bc9fc431470210321639.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/26ce7852098840a583c90273ac7b240c1470210322020.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d29caeec05dc41b98904cb79d8e2f89c1470210322048.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士尊享塑型发蜡50g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 15:43:13', '2017-02-03 15:43:13', NULL, 0, 0, 0, NULL, '8809349810323', NULL, NULL, '2016-08-03 16:17:33'),
(111222, 888246, '', '默认', 10, '127.00', '127.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/e2e863842f8d41148269b192446f21101470212409916.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/9ca21eae86324b3f81d0aa55053a266d1470212417154.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士清爽焕肤洁面保湿棉 清洁护肤一体 35片', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:19:22', '2017-02-03 16:19:22', NULL, 0, 0, 0, NULL, '8809349810613', NULL, NULL, '2016-08-03 16:20:25'),
(111224, 888249, '', 'No.13时尚白', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/498caf2a18a74668befbc495f57b4f141470212357350.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/e56c6b7fd8504570b8d7d1ede77392e61470212361220.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:18:24', '2017-02-03 16:18:24', NULL, 0, 0, 0, NULL, '8805301071139', NULL, NULL, '2016-08-03 16:22:20'),
(111226, 888249, '', 'No.46清纯百合', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/43e2ad404249443fb3b7c3ddda7be8bf1470212404633.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/8040d7f8fbe04466aa1ad2b64da4b25e1470212408429.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:19:26', '2017-02-03 16:19:26', NULL, 0, 0, 0, NULL, '8805301071467', NULL, NULL, '2016-08-03 16:22:20'),
(111228, 888249, '', 'No.49桃花', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/ecace8d6bdd64861a45bb7d99ae2c8061470212441116.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/f1343f6532a046eea18879b062a4bd441470212446198.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:20:12', '2017-02-03 16:20:12', NULL, 0, 0, 0, NULL, '8805301071498', NULL, NULL, '2016-08-03 16:22:20'),
(111230, 888249, '', 'No.79薰衣草', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/533fa0d6683045ce9b1eb2f6931bcbfa1470212481673.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/bc50a7f8a35b4bddab947d3cacca679c1470212484765.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:20:52', '2017-02-03 16:20:52', NULL, 0, 0, 0, NULL, '8805301071795', NULL, NULL, '2016-08-03 16:22:20'),
(111232, 888249, '', 'No.11cold n gold', 10, '156.00', '156.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/2920340315ec431f86f6e0acbc8f5adb1470212520692.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/d49eaf69334845f79325821572dcec401470212524972.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:21:29', '2017-02-03 16:21:29', NULL, 0, 0, 0, NULL, '8805301071115', NULL, NULL, '2016-08-03 16:22:20'),
(111234, 888252, '', '默认', 10, '89.00', '89.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/e4c3474a82ce4322b0f58e24921d06131470212537348.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/119fd68ba26a45e68cdbebfc90c77cfd1470212544892.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/da9914519bd848789b35fb9e321f52aa1470212544871.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/568b3f3b649743fd934dc9c7575303651470212544921.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士高保湿战士洁面乳 100ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:21:38', '2017-02-03 16:21:38', NULL, 0, 0, 0, NULL, '8809349810675', NULL, NULL, '2016-08-03 16:22:32'),
(111236, 888255, '', '默认', 10, '198.00', '198.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/6784d9f093af4161ba9b5910f70cdcc91470212649682.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/5cd7038cc6204aea90da4fd3fb83e5f01470212655411.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/9724594c97dd4a278bf04a23d23c706c1470212655592.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/6e90c32aa7ab41b3bb21ba4cf6ce10481470212655569.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士高保湿清爽补水面霜 50ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:23:39', '2017-02-03 16:23:39', NULL, 0, 0, 0, NULL, '8809349810651', NULL, NULL, '2016-08-03 16:24:22'),
(111238, 888258, '', '默认', 10, '168.00', '168.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7ee2832b4dd24f4eb051ff315e636adb1470212789279.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/740e2217558644d99201c1dd7f0b334c1470212795329.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f079c0e8454d467c904e2f28b72652571470212795514.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/73d8eaf8d6df4cee962f75f99ce4e5b71470212795531.jpg", "width": "800", "height": "889"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士防晒控油遮瑕保湿隔离BB霜40ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:25:48', '2017-02-03 16:25:48', NULL, 0, 0, 0, NULL, '8809349811641', NULL, NULL, '2016-08-03 16:26:46'),
(111240, 888261, '', '默认', 10, '168.00', '168.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/285160bc36764267b5d167e7dd2c1d1d1470212660333.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/04ac1acc53bd422ca2e5d43581bf48c81470212665946.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/68293107a7ad4422b5ca3f818b1520691470212666200.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/aa9dc73cd1a7423eb6b9afb23c6586981470212666310.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/b6176ece7e9f488688e351fc3c87a0f01470212666256.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士专用润发油110g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:23:38', '2017-02-03 16:23:38', NULL, 0, 0, 0, NULL, '8809349810330', NULL, NULL, '2016-08-03 16:27:16'),
(111242, 888264, '', ' No.272玫瑰花香', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/093b1f85ebb049ed840f30147e2f221f1470212822959.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/0f678388b7a34a4dab16a2b90792e6b11470212826606.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/13a45dec9a0a47b6abd6532378caeff91470378160270.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:26:24', '2017-02-03 16:26:24', NULL, 0, 0, 0, NULL, '8805301802726', '2016-08-05 14:22:46', NULL, '2016-08-03 16:30:06'),
(111244, 888264, '', 'No.476茉莉花香', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/bcc16f20dc6f4216ae109a1a425b72111470212869413.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/d2028adae30b434e8ebf4f0e79f4f32f1470212874005.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/3d74f15f8a214feb8a6c44044b615b2a1470212874030.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/96e1c109c7e94a1b938638d288a9a0521470212874087.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:27:10', '2017-02-03 16:27:10', NULL, 0, 0, 0, NULL, '8805301804768', '2016-08-05 14:22:46', NULL, '2016-08-03 16:30:06'),
(111246, 888264, '', 'No.512樱桃', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/93e527221a054389be45d68074543d351470212918305.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/a39ef699aaec42cd98e2904522a4fb6c1470212922309.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/e5a61bbd05614a9ba4d30122caebd0591470212922312.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/5ae40b348a264cdb89ccb74749d9c5a41470212922328.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:27:59', '2017-02-03 16:27:59', NULL, 0, 0, 0, NULL, '8805301805123', '2016-08-05 14:22:46', NULL, '2016-08-03 16:30:06'),
(111248, 888264, '', 'No.735柠檬酸橙', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/a432e11a9b0240f682e86fdffbba29bb1470212952277.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/e10229ad6647409e8320030bc53edb7c1470212957295.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/ed812a9838f346a2ba7c3dd1f25f71c01470212957285.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/d18bf533ce794b0c9f3afb717ec11c9f1470212957319.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:28:46', '2017-02-03 16:28:46', NULL, 0, 0, 0, NULL, '8805301807356', '2016-08-05 14:22:46', NULL, '2016-08-03 16:30:06'),
(111250, 888264, '', 'No.819黑白', 10, '119.00', '119.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/6339bf9f28ea4511a0c95d60c43938d71470212994939.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/735caeb697b748d29cefd8a21fe44a731470212999524.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/7db6d19afa4c4f22b38433e1e4b48fc21470212999521.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/30f0c72165b24eb0b7bfeb8e7b8817f51470212999529.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:29:22', '2017-02-03 16:29:22', NULL, 0, 0, 0, NULL, '8805301808193', '2016-08-05 14:22:46', NULL, '2016-08-03 16:30:06'),
(111252, 888267, '', '默认', 10, '99.00', '99.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/7d4d8bb7ae6140819c1b518659d9e5c71470213301915.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/4c79d08f81e144d4aedc1bebbdf231f21470213307314.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f7eaf209e4b94999ac4992b28935faa31470213307477.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/80fdee4ee37240179d9a3c4b07f3d5311470213307577.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士定型发用喷雾200ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:32:59', '2017-02-03 16:32:59', NULL, 0, 0, 0, NULL, '8809349810347', NULL, NULL, '2016-08-03 16:35:50'),
(111254, 888270, '', '默认', 10, '178.00', '178.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160803/3b9b4d6eb80d43e6b00049423c80ffc71470213470027.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160803/6cafdea8cc984a328eb11448ad1afef21470213475974.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f3e4a345c8814e1da3832f12d0fe86441470213476274.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160803/f4dde379e8564b2ba3d2a2247e0732c81470213476245.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士一步到位All in one面部调理乳120ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-03 16:37:06', '2017-02-03 16:37:06', NULL, 0, 0, 0, NULL, '8809349810668', NULL, NULL, '2016-08-03 16:38:05'),
(111256, 888273, '', 'No.49桃花', 10, '59.00', '59.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/596ac0170b114a56a4eda596f062d7df1470280843452.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/9b97243ad9804a2ebefbd14305bb6c3b1470280846416.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛护手霜 100g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:20:12', '2017-02-04 11:20:12', NULL, 0, 0, 0, NULL, '8805301101492', NULL, NULL, '2016-08-04 11:24:04'),
(111258, 888273, '', 'No.51葡萄柚', 10, '59.00', '59.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/e81ac378aa6b4b9ca5b5c3730bb1059e1470280875650.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/081c63d831f046abb7e93ace814ec7541470280879180.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛护手霜 100g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:20:53', '2017-02-04 11:20:53', NULL, 0, 0, 0, NULL, '8805301101515', NULL, NULL, '2016-08-04 11:24:04'),
(111260, 888273, '', 'No.97四月棉花 ', 10, '59.00', '59.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/4a7e1ece066346cb8306c588aa53f65f1470281033318.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/76d6ef3f26f74f3da307f2dbc9056c671470281036389.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛护手霜 100g', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:21:26', '2017-02-04 11:21:26', NULL, 0, 0, 0, NULL, '8805301101973', NULL, NULL, '2016-08-04 11:24:04'),
(111262, 888276, '', 'No.49桃花', 10, '85.00', '85.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/3669122b82474ae5955b58cb1fb7a3911470281252628.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/83a8b6188c0643cab932288961ac44f61470281256786.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/a70fda56a6f348078c6dfc955c829d701470281257133.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/ac6ae19c6523498aaa06572b30fd63481470281257120.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛洗手液 250ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:27:08', '2017-02-04 11:27:08', NULL, 0, 0, 0, NULL, '8805301251494', NULL, NULL, '2016-08-04 11:34:07'),
(111264, 888276, '', 'No.51葡萄柚', 10, '85.00', '85.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/46c3d3aa68ec4423bc6416b00739c3ff1470281299625.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/c1414f4d78a04b62966a9aa9e6c15a0e1470281304302.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/0bfdea3a15f248768147084f3991a3c51470281304085.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/5f4d563a8ac743bdbcb6f7ab50e452981470281304097.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛洗手液 250ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:27:44', '2017-02-04 11:27:44', NULL, 0, 0, 0, NULL, '8805301251517', NULL, NULL, '2016-08-04 11:34:07'),
(111266, 888276, '', 'No.97四月棉花', 10, '85.00', '85.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/94d89cce9d354bc4ac63044fee6e16f01470281336840.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/81616e44399540f98024c939e621ae9a1470281340857.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/721877c8a79b46338da33c3e9d39bd5c1470281340815.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/bb754e9abb3a4243867919d51185a86a1470281340875.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, '韩国 W.Dressroom多丽斯浪漫香氛洗手液 250ML', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 11:28:32', '2017-02-04 11:28:32', NULL, 0, 0, 0, NULL, '8805301251975', NULL, NULL, '2016-08-04 11:34:07'),
(111268, 888279, '', '酷爽香体型', 10, '149.00', '149.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/07fb2d820b7841d5abd96a43129dbd7e1470291753175.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/6a5c85bf78bf4f7fb578d2ef486f4ca61470291760480.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/75c559cffc61438b8fbba869b93fc81c1470291760742.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/6921afa547844d8ba801ebfc1b285f1e1470291760670.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'Swagger 施雅格男士沐浴露270ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:21:28', '2017-02-04 14:21:28', NULL, 0, 0, 0, NULL, '8809349810040', NULL, NULL, '2016-08-04 14:30:25'),
(111270, 888279, '', '净爽香体型', 10, '149.00', '149.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/3b91392fb54f4e99a44aa90c3dbd48df1470291805418.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/0bd7c498404145afbec2623e81910fdf1470291813842.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/6939c0b55b84410dba8c3f4ab078233e1470291813703.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/cadc142c1d92466fa61a9e6fe6ffcc651470291813598.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'Swagger 施雅格男士沐浴露270ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:22:48', '2017-02-04 14:22:48', NULL, 0, 0, 0, NULL, '8809349810019', NULL, NULL, '2016-08-04 14:30:25'),
(111272, 888279, '', '劲能香体型', 10, '149.00', '149.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/6a70058e7ae5445882e423d0af9ef6321470291851715.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/ece1bbe325f5456cbd06cba5e35d7ed91470291857314.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/bc316ec618b647e3b882d9a3450130811470291857052.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/070e9188675a43e49607e6a767eb2f331470291856999.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'Swagger 施雅格男士沐浴露270ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:23:42', '2017-02-04 14:23:42', NULL, 0, 0, 0, NULL, '8809349810026', NULL, NULL, '2016-08-04 14:30:25'),
(111274, 888279, '', '卓越香体型', 10, '149.00', '149.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/b1b8e0184ee747379a866085790bca911470291892740.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/546ca22e815f418b89e424b48bc41d7e1470291898405.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/dab939c1906547a1868986993115ebdb1470291898148.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/6920963c578e4fe78bd1d3230cd9d63e1470291898137.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士沐浴露270ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:24:24', '2017-02-04 14:24:24', NULL, 0, 0, 0, NULL, '8809349810033', NULL, NULL, '2016-08-04 14:30:25'),
(111276, 888282, '', '净爽香型', 10, '127.00', '127.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/ca36161d07ce4c4e94a7556e7c7e7ea61470292329121.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/71e89d065494499db0820003a02721dc1470292339027.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/844051a2771a49958dd6e036afa2c94f1470292339148.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/4a9249f269f94bfab623a7e84dd789611470292339233.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'Swagger 施雅格男士身体喷雾 150ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:31:27', '2017-02-04 14:31:27', NULL, 0, 0, 0, NULL, '8809349810088', NULL, NULL, '2016-08-04 14:40:00');
INSERT INTO `inventories` (`id`, `item_id`, `item_color`, `item_size`, `amount`, `item_src_price`, `item_price`, `item_cost_price`, `item_discount`, `sold_amount`, `rest_amount`, `inv_img`, `item_preview_imgs`, `or_destroy`, `or_master_inv`, `state`, `inv_area`, `restrict_amount`, `inv_title`, `inv_customs`, `postal_tax_code`, `inv_weight`, `postal_tax_rate`, `carriage_model_code`, `record_code`, `or_vary_price`, `start_at`, `end_at`, `share_url`, `share_count`, `collect_count`, `browse_count`, `theme_id`, `inv_code`, `update_at`, `destroy_at`, `create_at`) VALUES
(111278, 888282, '', '劲能香型', 10, '127.00', '127.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/1850ad0c53d14e3085fbcb2f988408fa1470292393937.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/f9a586048d194e4ebd58e6c0fcdf20291470292399314.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/1dccd229ba1f48c09a6c375f62c170381470292399291.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/fd4d104c55de406fb9a2587b9d0343061470292399267.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'Swagger 施雅格男士身体喷雾 150ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:32:26', '2017-02-04 14:32:26', NULL, 0, 0, 0, NULL, '8809349810071', NULL, NULL, '2016-08-04 14:40:00'),
(111280, 888282, '', '卓越香型', 10, '127.00', '127.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/b1483e06472b4f4cbcdbbbfc49e5bc351470292628385.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/1ad1869d0e6243ed98a673eb00c37cb51470292632702.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/d106d83c6a7945289a2c17c01b8605481470292632774.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/26a2b92939a848009f91eef225178a3c1470292632888.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'Swagger 施雅格男士身体喷雾 150ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:36:13', '2017-02-04 14:36:13', NULL, 0, 0, 0, NULL, '8809349810064', NULL, NULL, '2016-08-04 14:40:00'),
(111282, 888285, '', '芒果味', 10, '49.00', '49.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160804/089a3c549e354fff99f35d15b92866901470292900177.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160804/3e25d5c5ac4245b099fd1e8cbd61ba921470292909210.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/4ca0b76eaa1c4e09aee311240e5319c91470292909427.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/10c45451dcf443c4b5d172772ce9f47a1470292909497.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/787f8ce77a00431d8ed7ed3b5a2c660b1470292909514.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160804/464544f1fc0e4b6c822fc013ce795bf61470292909441.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希 水分炸弹 护手霜80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:40:49', '2017-02-04 14:40:49', NULL, 0, 0, 0, NULL, '8809392413779', '2016-08-05 10:04:54', NULL, '2016-08-04 14:45:58'),
(111284, 888285, '', '牛奶味', 10, '49.00', '49.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/565f8983043c43679cbb33f86dbfd3a61470362632120.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/2723f16f8b914df191a4f97e0a07a45c1470362639080.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/1a676118737846b5bdb3787e12f361081470362639157.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/fa41753447eb4f1f8bd0e0da2c85cc7c1470362639248.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/8c903a02237942b1972f6b29e39b85db1470362639219.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/8a6e938a42714fefa191d244f497a7a31470362639298.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希 水分炸弹 护手霜80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:41:58', '2017-02-04 14:41:58', NULL, 0, 0, 0, NULL, '8809102554044', '2016-08-05 10:04:54', NULL, '2016-08-04 14:45:58'),
(111286, 888285, '', '蜜桃味', 10, '49.00', '49.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/ecc43df141834f94bec4887dae6c8b0b1470362656482.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/1dc8aca8dbc74cfd9ab3c740d49fc8541470362663384.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/4afefbaedd7f4697b5141c8eb2cc690c1470362663462.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/c81d1216b411446ea516503e0a7bddc81470362663465.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希 水分炸弹 护手霜80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:43:45', '2017-02-04 14:43:45', NULL, 0, 0, 0, NULL, '8809102554037', '2016-08-05 10:04:54', NULL, '2016-08-04 14:45:58'),
(111288, 888285, '', '西柚味', 10, '49.00', '49.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/9337f4d0a52b4cf5b83fbd92d7d4539c1470362681914.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/5b40af639b684f38ba0cdca2fe1306d41470362687568.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/21a196c3e720427999f14497e4ecc3671470362687571.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/6485f5585e8d4687b1b67a1f06caa7181470362687588.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/9c4927c31a49468696189b3deda72a8c1470362687616.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希 水分炸弹 护手霜80ml', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:44:48', '2017-02-04 14:44:48', NULL, 0, 0, 0, NULL, '8809392413786', '2016-08-05 10:04:54', NULL, '2016-08-04 14:45:58'),
(111290, 888288, '', '野蛮蒂娜水分面膜', 10, '79.00', '79.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/26d3a6ab85424c5c94355630cc6768431470362786827.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/5994a645cf8a49c9adc7289011379d4d1470362793109.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/d046acdd3b094a82b3560b2130f05ed41470362793271.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/3534feaf72f4410396a0256aa10e6b8a1470362793249.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希面膜10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:57:39', '2017-02-04 14:57:39', NULL, 0, 0, 0, NULL, '8809392413588', '2016-08-05 10:08:23', NULL, '2016-08-04 15:02:25'),
(111292, 888288, '', '卷发蒂娜AC面膜', 10, '79.00', '79.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/0d30c4123b774e2db74d0d939c6f2c5a1470362808702.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/623a3bb049d44cb0bb96ee1e93e0d93e1470362814753.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/83e1f7a364e84a358dcf3a05d97bf9db1470362814787.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/e8a3add333254ab49132a54a8d854a1e1470362814770.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希面膜10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 14:59:09', '2017-02-04 14:59:09', NULL, 0, 0, 0, NULL, '8809392413557', '2016-08-05 10:08:23', NULL, '2016-08-04 15:02:25'),
(111294, 888288, '', '太阳镜蒂娜美白面膜', 10, '79.00', '79.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/0bcdf0bd7daa47118fd68c43a46b32421470362834573.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/f723536b34824956aaf8419454086ff91470362841271.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/ffc51c2574a34a52a8209bdab65cf0541470362841287.jpg", "width": "800", "height": "800"}]', 0, 0, 'Y', 'SZ', 0, 'FASCY发希面膜10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 15:00:07', '2017-02-04 15:00:07', NULL, 0, 0, 0, NULL, '8809392413571', '2016-08-05 10:08:23', NULL, '2016-08-04 15:02:25'),
(111296, 888288, '', '泡泡蒂娜胶原蛋白面膜', 10, '79.00', '79.00', NULL, '10.0', 0, 10, '{"url":"item/photo/20160805/67e890a8c2f54e298485d251acc112351470362871269.jpg","width":"800","height":"800"}', '[{"url": "item/photo/20160805/652f4652f2c441d4be2d63dae185b5c91470362881541.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/839ae851c43c4727bb9bef597f2ca6b51470362881550.jpg", "width": "800", "height": "800"}, {"url": "item/photo/20160805/3cb3d7ba7be4492681bc40a1b36ef8e11470362881715.jpg", "width": "800", "height": "800"}]', 0, 1, 'Y', 'SZ', 0, 'FASCY发希面膜10片装', 'shanghai', NULL, 0, '0', '', '0', 0, '2016-08-04 15:01:00', '2017-02-04 15:01:00', NULL, 0, 0, 0, NULL, '8809392413564', '2016-08-05 10:08:23', NULL, '2016-08-04 15:02:25');

-- --------------------------------------------------------

--
-- 表的结构 `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '商品ID',
  `cate_id` bigint(20) DEFAULT NULL COMMENT '类别ID',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌ID',
  `item_title` varchar(512) NOT NULL COMMENT '商品标题',
  `supply_merch` varchar(255) DEFAULT NULL COMMENT '供应商code',
  `on_shelves_at` timestamp NULL DEFAULT NULL COMMENT '（未使用）上架时间',
  `off_shelves_at` timestamp NULL DEFAULT NULL COMMENT '（未使用）下架时间',
  `item_master_img` varchar(512) DEFAULT NULL COMMENT '（未使用）用于作为主题中主商品时候的宣传图，除此之外都一律使用sku主图',
  `item_detail_imgs` text COMMENT '详细图片',
  `item_features` text NOT NULL COMMENT '商品参数',
  `theme_id` bigint(20) DEFAULT NULL COMMENT '（未使用）主题ID',
  `state` char(1) DEFAULT NULL COMMENT '（未使用）商品状态 ''Y''--正常,''D''--下架,''N''--删除,''K''--售空',
  `share_url` varchar(512) DEFAULT NULL COMMENT '（未使用）用于分享的链接',
  `share_count` bigint(20) DEFAULT NULL COMMENT '（未使用）分享次数',
  `collect_count` bigint(20) DEFAULT NULL COMMENT '（未使用）收藏数',
  `browse_count` bigint(20) DEFAULT NULL COMMENT '（未使用）浏览次数',
  `item_notice` varchar(512) DEFAULT NULL COMMENT '商品重要通告',
  `or_destroy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `destroy_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `master_inv_id` bigint(20) DEFAULT NULL COMMENT '（未使用）主sku ID',
  `publicity` text COMMENT '优惠区域显示信息（包括发货区域，多久后发货）',
  `item_detail` text COMMENT '详情页HTML'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息';

--
-- 转存表中的数据 `items`
--

INSERT INTO `items` (`id`, `cate_id`, `brand_id`, `item_title`, `supply_merch`, `on_shelves_at`, `off_shelves_at`, `item_master_img`, `item_detail_imgs`, `item_features`, `theme_id`, `state`, `share_url`, `share_count`, `collect_count`, `browse_count`, `item_notice`, `or_destroy`, `destroy_at`, `update_at`, `create_at`, `master_inv_id`, `publicity`, `item_detail`) VALUES
(888000, 120558, 112000, 'SNP 去角质护理套装', '', NULL, NULL, NULL, '[["item/photo/20160803/89d0eb8540314c15a4ebdaf63f9fb44c1470205127126.png", "item/photo/20160803/97aff13cf6014fb0a02e89d3f42bc9eb1470205127126.png", "item/photo/20160803/f8936f02217b4d539a1154ded5bd25f41470205127126.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:20:26', NULL, NULL, NULL),
(888003, 120558, 112000, 'SNP黄金胶原蛋白 改善皱纹补充营养弹力面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/957811c73d6d42e09e6e4107e629024a1470205120675.png", "item/photo/20160803/81f940bd268b4363a4731ca959165ab51470205120675.png", "item/photo/20160803/83b4d3d6976642de8dfd0ac6df9189fc1470205120675.png"]]', '{"试用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:20:29', NULL, NULL, NULL),
(888006, 120630, 112000, 'SNP 钻石水库 提亮肤色面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/bc755dd3f2c541e4ac93540f74f64dad1470205308226.png", "item/photo/20160803/409a41bf7fd547d1882576fe5e3b5ca41470205308226.png", "item/photo/20160803/41dfbf79ff384da582dea5b326c7806c1470205308226.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:25:59', NULL, NULL, NULL),
(888009, 120630, 112000, 'SNP 燕窝海洋补水眼膜眼贴', '', NULL, NULL, NULL, '[["item/photo/20160803/5db46e3f77a94115a949cf0fd97168ea1470205336060.png", "item/photo/20160803/777635345acd469e821a528d2bd308501470205336060.png", "item/photo/20160803/89ac6b002bca43cca3bf424e92598b021470205336060.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:26:16', NULL, NULL, NULL),
(888012, 120630, 112000, 'SNP海洋燕窝保湿补水面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/4851e2212c6a43889d374202facb92b01470205619674.png", "item/photo/20160803/ad3efbcfaf6f4f2aa9f2abd580a9d2c91470205619674.png", "item/photo/20160803/9214b40a6b664072a844513a4510fea51470205619674.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:28:30', NULL, NULL, NULL),
(888015, 120630, 112005, 'W.DRESSROOM&SNP面膜贴欧巴面膜补水美白 10片/盒', '', NULL, NULL, NULL, '[["item/photo/20160803/18986881d40a46aebbb607b5d9ed87631470205771796.jpg", "item/photo/20160803/fcfa0d6d5d73443ca573d103f1de2f771470205771796.jpg", "item/photo/20160803/a290de7a8db04c678c8d7d0a60d0b7791470205771796.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-10 17:21:17', '2016-08-03 14:29:40', NULL, NULL, NULL),
(888018, 120630, 112000, 'SNP竹炭黑炭 清洁毛孔面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/dcd135ca3fa94c76a682cc7b6f5fcf161470205813536.png", "item/photo/20160803/2748072483d344fbbd64ca83fabc8b051470205813536.png", "item/photo/20160803/7c6a02eb29364c4aa64b650240a576871470205813536.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:31:18', NULL, NULL, NULL),
(888021, 120630, 112000, 'SNP黑珍珠 提高皮肤活力提亮肤色面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/2eb1e3f54e9d4edcaa266da6d8602a151470205948836.png", "item/photo/20160803/adc7aab118e84b13b65340f10ed897211470205948836.png", "item/photo/20160803/b4a32d6f96114fb48fffb8000a7f07841470205948836.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:33:28', NULL, NULL, NULL),
(888024, 120630, 112000, 'SNP动物面膜 皮肤紧致老虎面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/b4f21e7c0058467ba83bb0c5a5f9dccd1470206076182.png", "item/photo/20160803/5cc48d90ca674059b3c3bf85563126a41470206076182.png", "item/photo/20160803/b31a7aea5ca94fc897079b13e77b634e1470206076182.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:35:32', NULL, NULL, NULL),
(888027, 120630, 112000, 'SNP动物面膜 提亮肤色保湿熊猫 面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/978648f230654ec4b4726350f2a434281470206216940.png", "item/photo/20160803/5d6009c3ddf24ef6b8d9b9df2688e6b91470206216940.png", "item/photo/20160803/a12cbf7d47094c248faeda06e961728b1470206216940.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:38:06', NULL, NULL, NULL),
(888030, 120630, 112000, 'SNP动物面膜 保湿补水海狮面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/5d4123fe6e7b4c1f95a432c8ecde6cb51470206348476.png", "item/photo/20160803/3546612d30f243ad9f6330001d2f41671470206348476.png", "item/photo/20160803/506f3b530a824cc0a02ebabe0c05d5181470206348476.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:39:57', NULL, NULL, NULL),
(888033, 120598, 112025, 'the H one 水透保湿蒸汽霜（干性皮肤适用）100ml', '', NULL, NULL, NULL, '[["item/photo/20160803/86ff16e678df40e8995145e074450caf1470206052005.png", "item/photo/20160803/dc32d8dc41654f0e960f4478f80759d51470206052005.png", "item/photo/20160803/b196b9f3854949c89a9ffd2964631db31470206052005.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:40:43', NULL, NULL, NULL),
(888036, 120630, 112000, 'SNP动物面膜 镇定舒缓神龙面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/cff86a95e545429d9ac1da270727e8f01470206461670.png", "item/photo/20160803/a1ecaad8af3245d49b0d153b53fb2e061470206461670.png", "item/photo/20160803/735fb7aa019449059af3c228a433e2781470206461670.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:41:46', NULL, NULL, NULL),
(888039, 120558, 112000, 'SNP 90%补水保湿凝胶 仙人掌凝胶', '', NULL, NULL, NULL, '[["item/photo/20160803/5cb89bcd35ce4739a1b903645c16e0ea1470206441625.jpg", "item/photo/20160803/d99635ee521e4760be52b845a1cfa3fd1470206441625.jpg", "item/photo/20160803/dd0ff8fcab3443bf979f9b4cf567809d1470206441625.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:42:45', NULL, NULL, NULL),
(888042, 120630, 112000, 'SNP京剧面膜 保湿补水水库京剧脸谱面膜 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/baca9d4504ac4a7e95eefe8d149afe281470206566587.png", "item/photo/20160803/b6fe5ca553f74cfab0569ffb23aa9fe21470206566587.png", "item/photo/20160803/60a6e67d9a37451bbd653c13284284341470206566587.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:44:06', NULL, NULL, NULL),
(888045, 120630, 112000, 'SNP京剧面膜 保湿补水水库京剧脸谱面膜 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/baca9d4504ac4a7e95eefe8d149afe281470206566587.png", "item/photo/20160803/b6fe5ca553f74cfab0569ffb23aa9fe21470206566587.png", "item/photo/20160803/60a6e67d9a37451bbd653c13284284341470206566587.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:44:48', NULL, NULL, NULL),
(888048, 120598, 112025, 'the H one清新保湿蒸汽霜（油性皮肤适用）100ml', '', NULL, NULL, NULL, '[["item/photo/20160803/0da58dd06471495bbba7d88494a6a4ee1470206570481.png", "item/photo/20160803/90eaf21b93214f25bbbc34205b258e131470206570481.png", "item/photo/20160803/b76d800053904a11b1f12134a1b8ed4f1470206570481.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:44:58', NULL, NULL, NULL),
(888051, 120558, 112000, 'SNP 90%补水保湿凝胶 燕窝凝胶', '', NULL, NULL, NULL, '[["item/photo/20160803/7394b2b37ba74a26afc0d917ef1b84ab1470206645223.jpg", "item/photo/20160803/a48345d51e434f94b6d05abe7cd0d6021470206645223.jpg", "item/photo/20160803/5479394af4a143af80b20e7770044c081470206645223.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:46:14', NULL, NULL, NULL),
(888054, 120630, 112000, 'SNP京剧面膜 提亮肤色京剧脸谱面膜 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/67f247b9dfdb43ef9d1491d67318750d1470206766164.png", "item/photo/20160803/58432bf5a88f4287bfc99895a2f196771470206766164.png", "item/photo/20160803/28d5961654334134b36b7db307af8a181470206766165.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:46:57', NULL, NULL, NULL),
(888057, 120598, 112025, 'the H one 恒润保湿蒸汽霜（中性皮肤适用）100ml', '', NULL, NULL, NULL, '[["item/photo/20160803/ed13c4891a7f4861838444aae4ec3b091470206801798.png", "item/photo/20160803/37029418b00d47818ca56651ee6a84811470206801798.png", "item/photo/20160803/17e597b8158b48d8a092a6c47ef76b6c1470206801798.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:48:22', NULL, NULL, NULL),
(888060, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽身体乳', '', NULL, NULL, NULL, '[["item/photo/20160803/c8191918cb614aa5ac574e231e0143a31470206881212.jpg", "item/photo/20160803/ec8db39e1fbb4ab9843f37446b0534041470206881212.jpg", "item/photo/20160803/1d09e94a028449b192bbb605d527e7e51470206881212.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:49:15', NULL, NULL, NULL),
(888063, 120558, 112000, 'SNP 控油祛痘系列', '', NULL, NULL, NULL, '[["item/photo/20160803/a8ccfbd4c3124fd0ae78f7ede1dc9c611470206934248.png", "item/photo/20160803/41844da37da0455a9e75f2abc1a593151470206934248.png", "item/photo/20160803/fb2919e96d734ea3a6140d5503e138bd1470206934248.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 14:20:46', '2016-08-03 14:49:26', NULL, NULL, NULL),
(888066, 120630, 112000, 'SNP京剧面膜 保湿补水京剧脸谱面膜 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/2c7b54cba10e4573a6602a05052244791470206931025.png", "item/photo/20160803/7b1620eec575430fb492bfa76d7b95901470206931025.png", "item/photo/20160803/c20d69ba40654f16a0d3123b300bfa131470206931025.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:50:09', NULL, NULL, NULL),
(888069, 120630, 112000, 'SNP动物面膜 提亮肤色兔子面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/5adf01ee39844a2b962e9160c223e15f1470207082118.png", "item/photo/20160803/c4995ffadad64bd5b9031fab637cf91a1470207082118.png", "item/photo/20160803/c636137a978c47c58911d0db6f12e8841470207082118.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:52:07', NULL, NULL, NULL),
(888072, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽沐浴露', '', NULL, NULL, NULL, '[["item/photo/20160803/bcc22ad1dd074e49ab95f7665b4a50881470207100242.jpg", "item/photo/20160803/8538411b01274ef2a5b3634756b1e7521470207100242.jpg", "item/photo/20160803/059fffbcf9b74da3954919dee962d0691470207100242.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:53:38', NULL, NULL, NULL),
(888075, 120630, 112000, 'SNP动物面膜 保湿补水松鼠面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/e8e5050c82744346960175cead9507191470207214338.png", "item/photo/20160803/e2c6ede57e2943769e4034c4089c80f51470207214338.png", "item/photo/20160803/c1e73a3e2f204d109a6dc40813e26c641470207214338.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:54:26', NULL, NULL, NULL),
(888078, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 青柠身体乳', '', NULL, NULL, NULL, '[["item/photo/20160803/cfdb3576c293453daa3f8a3e71c559f61470207280930.jpg", "item/photo/20160803/7719eeef027b4c06a1189223bc46f8441470207280930.jpg", "item/photo/20160803/b927850ed66c4a7d9807ddcb97960f261470207280930.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:55:35', NULL, NULL, NULL),
(888081, 120630, 112000, 'SNP动物面膜 皮肤紧致猫咪面膜贴 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/87e275d956524308a0dee4c434d18ff61470207326931.png", "item/photo/20160803/1c42d6c666d34d70b2b77457fa0f91d41470207326931.png", "item/photo/20160803/9f19e4ecb07a448082aa620d93e7d24f1470207326931.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:56:14', NULL, NULL, NULL),
(888084, 120582, 112000, 'SNP毛孔清洁洁面泡沫(细致毛孔,平滑肌肤,吸净黑头,深层清洁)', '', NULL, NULL, NULL, '[["item/photo/20160803/6a4d260a6bfe4c48b97506c37473283b1470207439396.png", "item/photo/20160803/dc9c38d7427a423d9866895d15f720f51470207439396.png", "item/photo/20160803/f48b1cf95c964dd49b2361beaf481f8b1470207439396.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:58:35', NULL, NULL, NULL),
(888087, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 青柠沐浴露', '', NULL, NULL, NULL, '[["item/photo/20160803/7f551691535149ce8e4a943946df34e71470207473641.jpg", "item/photo/20160803/1114299dab184a07883ba31507a52ef81470207473641.jpg", "item/photo/20160803/1b49c254bea54958878830c691d78d1d1470207473641.jpg"]]', '{"适用人群": "默认"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 14:59:09', NULL, NULL, NULL),
(888090, 120630, 112000, 'SNP控油收毛孔整理肌肤纹理面膜', '', NULL, NULL, NULL, '[["item/photo/20160803/811a48b54fab43e49154669cbef86fc31470207614694.png", "item/photo/20160803/9ff322c9be044ca2ae9a79bf5ff9d9fb1470207614694.png", "item/photo/20160803/7b476e4fb8cc465cbcff5643093166cf1470207614695.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:01:18', NULL, NULL, NULL),
(888093, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 青柠身体喷雾', '', NULL, NULL, NULL, '[["item/photo/20160803/7cd4f6e5f066410f8cdc8a11d99ea8321470207618331.jpg", "item/photo/20160803/3c2775eb212344a7995bbbc15db04f881470207618331.jpg", "item/photo/20160803/2b8f8fdc6490469e87dfc5874b6682a61470207618331.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:01:41', NULL, NULL, NULL),
(888096, 120630, 112000, 'SNP补水保湿舒缓睡眠面膜 平衡肌肤 祛痘控油 夜间修复镇静', '', NULL, NULL, NULL, '[["item/photo/20160803/700a419766d54dbfa8bffbee0f99ce761470207742093.png", "item/photo/20160803/4a58896f64ed4fb6b3a37026c175adb51470207742093.png", "item/photo/20160803/e752aaf3c9814facbe95f3d4b745ca081470207742093.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:03:46', NULL, NULL, NULL),
(888099, 120574, 112000, 'SNP首尔咖啡沐浴露身体乳系列 辣木籽身体喷雾', '', NULL, NULL, NULL, '[["item/photo/20160803/7734aa3fda9a4e1dba07a1560385aa531470207777719.jpg", "item/photo/20160803/209ecda1da1a48c3bee3bd8d281505e11470207777719.jpg", "item/photo/20160803/50f43dd27f7b4c8d8bcade7ac6cb58ba1470207777719.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 14:19:37', '2016-08-03 15:04:52', NULL, NULL, NULL),
(888102, 120630, 112000, 'SNP水漾回弹热感睡眠面膜 改善皱纹 改善粗糙皮肤', '', NULL, NULL, NULL, '[["item/photo/20160803/04dc8438c39e451a94eb0cb3ad24af591470207880944.png", "item/photo/20160803/71f25c3e138b448d81105e44f93d55941470207880944.png", "item/photo/20160803/f402cf32a8a040ae8a7abf131f7025911470207880944.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:05:51', NULL, NULL, NULL),
(888105, 120630, 112000, 'SNP Fruits Gelato水果冰淇淋营养面膜 25ml /片 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/2f3ef21a0fde49efb1a8ad89f22d0b1b1470208021775.png", "item/photo/20160803/db03d0b4022442d881afb5562e90de221470208021775.png", "item/photo/20160803/ef14f1382fa04f318b440199d20d1bd71470208021775.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:07:09', NULL, NULL, NULL),
(888108, 120590, 112000, 'SNP首尔咖啡洗发护发系列 洗发精', '', NULL, NULL, NULL, '[["item/photo/20160803/dd3e9bc1084b4cca8f140f67c8704a651470207974238.jpg", "item/photo/20160803/1d5c3537f09444e0a2dad9abdc1649c91470207974238.jpg", "item/photo/20160803/7314a5b608fd4be8af242db2e859122a1470207974238.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:07:16', NULL, NULL, NULL),
(888111, 120558, 112000, 'SNP98%天然保湿 晒后修复芦荟胶', '', NULL, NULL, NULL, '[["item/photo/20160803/bd9e9972c64d4dc88ec08b02207d985d1470208058361.png", "item/photo/20160803/ed1827558d8c435c887aa3d64f5b69741470208058361.png", "item/photo/20160803/c8093b33cb2946d2be7bd6d6cea248271470208058361.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:08:43', NULL, NULL, NULL),
(888114, 120630, 112030, 'Velieve 薇丽肤 夜光睡眠面膜', '', NULL, NULL, NULL, '[["item/photo/20160803/9acb65ca5978496483acb8ff5e3158261470208012277.png", "item/photo/20160803/1dbda75612f0469b91067aeda2143f061470208012277.png", "item/photo/20160803/7cfb968691734900b7391357416d885e1470208012277.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:11:08', NULL, NULL, NULL),
(888117, 120590, 112000, 'SNP首尔咖啡洗发护发系列 护发素', '', NULL, NULL, NULL, '[["item/photo/20160803/ece2b30140534f589be5479b340e236b1470208107607.jpg", "item/photo/20160803/dbf944e58c71400d8430abeed091afff1470208107607.jpg", "item/photo/20160803/4057ed6eb1f8494eace367327a9ca69b1470208107607.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:11:11', NULL, NULL, NULL),
(888120, 120574, 112000, 'SNP马油改善皱纹滋润皮肤护手霜', '', NULL, NULL, NULL, '[["item/photo/20160803/05b81faddd714eb781ea8b5ac2b823e41470208229644.png", "item/photo/20160803/0e77458622064b2fbec80c7e608063b91470208229644.png", "item/photo/20160803/8c967068f0bf4e3fb573aa5d338fb22e1470208229644.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:12:16', NULL, NULL, NULL),
(888123, 120590, 112000, 'SNP首尔咖啡洗发护发系列 护发精油', '', NULL, NULL, NULL, '[["item/photo/20160803/27f39fa33547435baa589ec765d70c661470208325548.jpg", "item/photo/20160803/24a87da0a0b94efc9b366a3895caee031470208325548.jpg", "item/photo/20160803/4b5d2daf21ab43eab87850a67151b3cf1470208325548.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:13:43', NULL, NULL, NULL),
(888126, 120574, 112000, 'SNP可爱香气颗粒沐浴露', '', NULL, NULL, NULL, '[["item/photo/20160803/515043a653594084913f4426ab4d13c61470208432624.png", "item/photo/20160803/1fb88657e0de4ee8a386e18efbdf94a91470208432624.png", "item/photo/20160803/1a68f4eecce44948ada5b6cb329acd3c1470208432624.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:15:09', NULL, NULL, NULL),
(888129, 120566, 112030, 'Velieve 薇丽肤 贪心少女高效防晒霜 50ml', '', NULL, NULL, NULL, '[["item/photo/20160803/d428a60bbe2f45be96e595eb020c057f1470208442483.png", "item/photo/20160803/e692336936ff4a35901c1ccffed0dc0b1470208442483.png", "item/photo/20160803/dfa88e5b097e42c0b3b8e35c4947c67f1470208442483.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:15:10', NULL, NULL, NULL),
(888132, 120574, 112000, 'SNP可爱花香保湿润肤身体乳', '', NULL, NULL, NULL, '[["item/photo/20160803/620c71e1fa3d48789c6c332a511a8f991470208730289.png", "item/photo/20160803/724358cbeba84c69bf8b3c0cdb6328a11470208730289.png", "item/photo/20160803/cef4f8e8fb9a4fe78e209a6cd1f69a8a1470208730289.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 14:21:22', '2016-08-03 15:19:00', NULL, NULL, NULL),
(888135, 120590, 112000, 'SNP首尔咖啡洗发护发系列 护发喷雾', '', NULL, NULL, NULL, '[["item/photo/20160803/58fc3798bef04262aed356e991ec6aa01470208489786.jpg", "item/photo/20160803/404cfe8986664494824a6be183e531991470208489786.jpg", "item/photo/20160803/cff1ee2a1cf346109692f90ddcd2e4d41470208489786.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:20:13', NULL, NULL, NULL),
(888138, 120574, 112000, 'SNP可爱婴儿香保湿润肤身体乳', '', NULL, NULL, NULL, '[["item/photo/20160803/2f54986aae0041c0879b4cac5f7c987f1470208822210.png", "item/photo/20160803/03c669b4f5e345bdb6a02013af7ee0281470208822210.png", "item/photo/20160803/c51de087309f4b9782447643880386cb1470208822210.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:21:05', NULL, NULL, NULL),
(888141, 120574, 112000, 'SNP可爱棉花香保湿润肤身体乳', '', NULL, NULL, NULL, '[["item/photo/20160803/3953a46aa9e847d0a233f3a2d81d4d321470208924061.png", "item/photo/20160803/097814c6b32d46c2877f69c9295eb6631470208924061.png", "item/photo/20160803/ee258eac136e4290a96c151854dd722e1470208924061.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:23:04', NULL, NULL, NULL),
(888144, 120598, 112030, 'Velieve 薇丽肤 贪心少女DD霜 SPF40 PA++', '', NULL, NULL, NULL, '[["item/photo/20160803/2d64252945fe4e5db141c7544324ca391470208999817.png", "item/photo/20160803/a85e63e3ceff4295a04a4414415b89581470208999817.png", "item/photo/20160803/55d02dbe477645cdb387fe80a7468c971470208999817.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:24:32', NULL, NULL, NULL),
(888147, 120574, 112000, ' SNP 马油滋润身体护肤乳', '', NULL, NULL, NULL, '[["item/photo/20160803/20e5f3ab178147b6b9cd26bbbf97b80b1470209013954.jpg", "item/photo/20160803/57128b58419544efa7f15ce8761a893a1470209013955.jpg", "item/photo/20160803/a1c05b554f624876baf18a699f9c4b741470209013955.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:25:21', NULL, NULL, NULL),
(888150, 120630, 112000, 'SNP 97%天然保湿芦荟胶300g 免洗睡眠面膜 晒后修复霜', '', NULL, NULL, NULL, '[["item/photo/20160803/83e5795338f64a5c94d9684a8b9ca0421470209078859.png", "item/photo/20160803/b45ee0b3e21541a896bb54156af21bf11470209078860.png", "item/photo/20160803/1b027c415ed3486d92bc3b349ba3a0471470209078860.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:26:08', NULL, NULL, NULL),
(888153, 120582, 112030, 'Velieve 薇丽肤 贪心少女牛奶洁白乳霜', '', NULL, NULL, NULL, '[["item/photo/20160803/ed3305ba159c46ba86649907636c984a1470209168520.png", "item/photo/20160803/b7573032db864ca1b9290a70e23716831470209168520.png", "item/photo/20160803/c2f3164733f84f559aefcd6ffe00ca3e1470209168520.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:28:01', NULL, NULL, NULL),
(888156, 120558, 112000, 'SNP黑头清洁套装三步曲6片 去黑头鼻贴男女收缩毛孔', '', NULL, NULL, NULL, '[["item/photo/20160803/472cbe7db4314e46ac74fa7239f3da171470209259420.png", "item/photo/20160803/df4ab5c85ef54d91999306aa12c48d8f1470209259420.png", "item/photo/20160803/8a28bc03a4cf4b7ebec928d8c89dfe691470209259420.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:28:39', NULL, NULL, NULL),
(888159, 120558, 112000, 'SNP燕窝精华亮白面霜补水保湿滋润水油平衡', '', NULL, NULL, NULL, '[["item/photo/20160803/582b8376e70d4c089406e3edcea2a8d61470209258102.png", "item/photo/20160803/6ddf4d9b98e8422ca77923b24faec5ef1470209258102.png", "item/photo/20160803/c4764ce897234cd0a6645acd4515a4601470209258102.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:30:00', NULL, NULL, NULL),
(888162, 120558, 112030, 'Velieve 薇丽肤 贪心少女油脂控制水珠保湿霜', '', NULL, NULL, NULL, '[["item/photo/20160803/185b2f47ddb74bc4bba5933ef619fe191470209373310.png", "item/photo/20160803/d12b45f1cd884f429a80ed4d6d2490ae1470209373310.png", "item/photo/20160803/c3af0ecc99b04c988ac6ec54229408201470209373310.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:30:41', NULL, NULL, NULL),
(888165, 120630, 112000, 'SNP 补水滋润睡眠面膜', '', NULL, NULL, NULL, '[["item/photo/20160803/3359fdd98f954bbfa5d0741308c6fd481470209416181.jpg", "item/photo/20160803/31f343711fff460b8be14ac5764c57091470209416181.jpg", "item/photo/20160803/7c0ce27eba3d4ee6a258288649f5edc61470209416181.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:31:06', NULL, NULL, NULL),
(888168, 120630, 112000, 'SNP三部曲螺旋纹紧致面膜贴 黄金蚕丝款 ', '', NULL, NULL, NULL, '[["item/photo/20160803/20920e5b73a24afbbe6f7d4ce19851361470209484374.jpg", "item/photo/20160803/0773037458494698ba57a9f862b6646c1470209484374.jpg", "item/photo/20160803/886de1b5feef4ce9bba9064da39d1c191470209484374.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:32:24', NULL, NULL, NULL),
(888171, 120558, 112000, 'SNP济州岛发酵马油霜 滋润皮肤 改善皱纹 修复皮肤', '', NULL, NULL, NULL, '[["item/photo/20160803/1f1823974086488a912b8fdcc81ec7e31470209532691.png", "item/photo/20160803/8782cb44c5a54c29b46c7e4a50bd7f901470209532691.png", "item/photo/20160803/3b83179489eb41228dbaee50f0a010861470209532691.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:33:20', NULL, NULL, NULL),
(888174, 120582, 112030, 'Velieve 薇丽肤 玫瑰精华洁面泡沫', '', NULL, NULL, NULL, '[["item/photo/20160803/b2fc00e1309b45b681716b50c9992c1f1470209577642.png", "item/photo/20160803/534032bd9c75487f9ae394c1da98508b1470209577642.png", "item/photo/20160803/1d3658cf5fc446dea1d24301668ab8fe1470209577642.png"]]', '{"使用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:34:12', NULL, NULL, NULL),
(888177, 120630, 112000, 'SNP三部曲螺旋纹紧致面膜贴 海洋燕窝款', '', NULL, NULL, NULL, '[["item/photo/20160803/1a16c24ddc0f4cd9aeb5fb3c897ed41e1470209625609.jpg", "item/photo/20160803/31c05d2d4861485e8855197ca10b842e1470209625609.jpg", "item/photo/20160803/6f30c4557f144de3b5ebea360ff339a91470209625609.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:35:01', NULL, NULL, NULL),
(888180, 120630, 112000, 'SNP维他命果冻调理面膜补水保湿提亮肤色润颜滋养 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/6ad41ac6dc234745ad1ee9920264398c1470209688185.png", "item/photo/20160803/ee2f807994084db082bbe4e36ade1e9e1470209688185.png", "item/photo/20160803/de529827a0b74360a0b0300e888e46341470209688185.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:35:23', NULL, NULL, NULL),
(888183, 120630, 112000, 'SNP马油精华面膜 改善皱纹 滋润皮肤 保湿补水 10片装', '', NULL, NULL, NULL, '[["item/photo/20160803/8e86f74e8f30454da31dbeffcfdec3661470209666170.png", "item/photo/20160803/22d147a94d564b92bb4a04f48382299f1470209666170.png", "item/photo/20160803/43e42b09203046eaadd21bdce87008f51470209666170.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:35:39', NULL, NULL, NULL),
(888186, 120598, 112030, 'Velieve 薇丽肤 竹汁液护理BB霜 SPF25/PA++', '', NULL, NULL, NULL, '[["item/photo/20160803/58e69ca66a3c42be96440725e91c1b9e1470209764073.png", "item/photo/20160803/1f655f82c963431ea6cf6da4aed803881470209764073.png", "item/photo/20160803/0cdfbcadb0fe42d0aef5c81b7b8151761470209764073.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:37:28', NULL, NULL, NULL),
(888189, 120630, 112000, 'SNP 水果清凉保湿补水霜 葡萄柚', '', NULL, NULL, NULL, '[["item/photo/20160803/b3a9d86c1b2a4773aff197433852077a1470209864086.jpg", "item/photo/20160803/f1ac28d257fe4321b1cb62acb7fb88251470209864086.jpg", "item/photo/20160803/1f8298d49d9543c59eae0daa38d878de1470209864086.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:39:20', NULL, NULL, NULL),
(888192, 120582, 112015, 'FASCY发希 泡沫蒂娜 木炭洗面奶150ml& 野蛮蒂娜 水分面膜26g', '', NULL, NULL, NULL, '[["item/photo/20160803/0c31e5c5b77f4b338c8e3547e35ece311470209977145.png", "item/photo/20160803/294daf75a32c4d049771af468247fd081470209977145.png", "item/photo/20160803/011f1eebaee24cb49661c64a4e4f6e8c1470209977145.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:40:57', NULL, NULL, NULL),
(888195, 120558, 112000, 'SNP 水果清凉保湿补水霜 芒果', '', NULL, NULL, NULL, '[["item/photo/20160803/29fc6ceb2f384b1d90a617d3da969c8f1470210023392.jpg", "item/photo/20160803/af3f275487ef4a859c994f8c3f2d63ec1470210023392.jpg", "item/photo/20160803/fb60c0671edc4bc3bd2244e97acb03681470210023392.jpg"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:41:14', NULL, NULL, NULL),
(888198, 120630, 112020, 'SKIN1004钻石僵尸面膜', '', NULL, NULL, NULL, '[["item/photo/20160803/4f5d0261c9724381bc773e2b86e1bfa01470210068367.png", "item/photo/20160803/c29f749de1a94ca19b5aeb13afc51b611470210068367.png", "item/photo/20160803/dce194c03acf43c6948540a82c5600c11470210068367.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:42:20', NULL, NULL, NULL),
(888201, 120630, 112000, 'SNP奶油霜面膜5片装 补水深层保湿清洁收毛孔控油', '', NULL, NULL, NULL, '[["item/photo/20160803/932cff0796d0404194082407450e43cb1470210183272.png", "item/photo/20160803/f0e7b2b53885428bb20791c42a1bf0f41470210183272.png", "item/photo/20160803/0d96b837f8864388b177a3217cdb6c161470210183272.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:44:08', NULL, NULL, NULL),
(888204, 120558, 112020, 'skin1004 修复面霜', '', NULL, NULL, NULL, '[["item/photo/20160803/c07a5c589f7042baaada1f200d73e8a61470210236789.png", "item/photo/20160803/5d7a4edc9fdb4bcaa54c6481c551dee81470210236789.png", "item/photo/20160803/9471db3df905490190b89c8dd405a3831470210236789.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:44:59', NULL, NULL, NULL),
(888207, 120590, 112015, 'FASCY发希 眨眼睛蒂娜 蚕丝 护发精华80ml', '', NULL, NULL, NULL, '[["item/photo/20160803/292a1ce9babf4a4d8cf3047987c3da631470210200989.png", "item/photo/20160803/85a2daa15f9847d990abe2f8b6800eaf1470210200989.png", "item/photo/20160803/61fba662094d4325b8229a008ad2a0fe1470210200989.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:46:00', NULL, NULL, NULL),
(888210, 120558, 112020, 'skin1004 僵尸鼻贴三部曲 7g*10', '', NULL, NULL, NULL, '[["item/photo/20160803/e63b4b24600746e689289523caf409d21470210368134.png", "item/photo/20160803/d0f65d88d2544670a9cf2d782ccd10b71470210368134.png", "item/photo/20160803/28cb2e575b3b45cdb9de65e2348493bc1470210368134.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:47:06', NULL, NULL, NULL),
(888213, 120566, 112015, 'FASCY发希 太阳镜蒂娜 防晒霜80ml', '', NULL, NULL, NULL, '[["item/photo/20160803/798a6b32b7754474838f185b797739ce1470210659927.png", "item/photo/20160803/494c88caf7d747c99eb0c66a20bfb16d1470210659927.png", "item/photo/20160803/cd8d601bfec8444c978a0b71bfe331f31470210659927.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:52:43', NULL, NULL, NULL),
(888216, 120558, 112020, 'skin1004 积雪草精华液', '', NULL, NULL, NULL, '[["item/photo/20160803/d56f386da6f24a4a81d57471ac450c4c1470210703996.png", "item/photo/20160803/263841f1b27642cba8b2dd1659608b631470210703996.png", "item/photo/20160803/dd99858dd4424cad86cc219939e68ea01470210703996.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 15:52:50', NULL, NULL, NULL),
(888219, 120598, 112015, 'FASCY发希 野蛮蒂娜 水分 香气气垫粉15g', '', NULL, NULL, NULL, '[["item/photo/20160803/439e21e53ef14df6af9b4d1243bd50e81470211618743.png", "item/photo/20160803/be22d0ea90d44ebc9172bf47364487521470211618743.png", "item/photo/20160803/988efc34c272431abb8ab8601f601fce1470211618743.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:08:02', NULL, NULL, NULL),
(888222, 120582, 112020, 'skin1004 蚕丝洁面皂 ', '', NULL, NULL, NULL, '[["item/photo/20160803/76a67be8d3554b5f9e74968e945d9a3e1470211678195.png", "item/photo/20160803/98685abc6fb64436bf9e458bd484c2011470211678195.png", "item/photo/20160803/819b0b9099fd4d86b5908e72662570181470211678195.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:08:49', NULL, NULL, NULL),
(888225, 120598, 112015, 'FASCY发希 撕拉唇彩 套装（15g*3） & 护唇膏（4g*1）', '', NULL, NULL, NULL, '[["item/photo/20160803/ee6890f4c8e14fadb45242316ffc40401470211769796.png", "item/photo/20160803/ef34a5b3e7cc45de84ac793966c8e2081470211769796.png", "item/photo/20160803/24e4914705124dbba0518846536e290c1470211769796.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:10:42', NULL, NULL, NULL),
(888228, 120630, 112020, 'skin1004 僵尸面膜', '', NULL, NULL, NULL, '[["item/photo/20160803/81412cceb7764572ba945d2fb86a3fe11470211839079.png", "item/photo/20160803/8bb348cec627421f9872a3e00fc5cf431470211839079.png", "item/photo/20160803/f3c3665242ec4bbbb828bd8b5108a8b61470211839079.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:11:42', NULL, NULL, NULL),
(888231, 120598, 112015, 'FASCY发希 滋润型唇膏（滋润）', '', NULL, NULL, NULL, '[["item/photo/20160803/b1ea15c52eb946f7843f905409bee8d91470211969437.png", "item/photo/20160803/133292cb45204b63bcf9c625e70e47c31470211969437.png", "item/photo/20160803/67b08c7bb45f462584b337259e76e8821470211969437.png"]]', '{"适用人群": "女性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:13:48', NULL, NULL, NULL),
(888234, 120598, 112015, 'FASCY发希 泡泡蒂娜 遮瑕BB霜50ml', '', NULL, NULL, NULL, '[["item/photo/20160803/f55046f80a6d4051bcba505f3fbdeb4e1470211912183.png", "item/photo/20160803/dae98d4f20a545c9901ac9f3b67c9eaa1470211912183.png", "item/photo/20160803/9e962683e2e24e03b3b4490678de506f1470211912183.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:14:11', NULL, NULL, NULL),
(888237, 120614, 112005, '韩国 W.Dressroom多丽斯浪漫香水喷雾家居香氛喷雾持久香味', '', NULL, NULL, NULL, '[["item/photo/20160803/df09e671f67b4142b636d69c958ef7ea1470210560026.png", "item/photo/20160803/266c8b80c9604bf3b654579a049745a21470210560026.png", "item/photo/20160803/241fe8ef123949fba615602411771b211470210560026.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:14:31', NULL, NULL, NULL),
(888240, 120598, 112015, 'FASCY发希 滋润型唇膏（橙色）', '', NULL, NULL, NULL, '[["item/photo/20160803/ed6e7aa2c54d493aa0be4c79beddf71b1470212134968.png", "item/photo/20160803/ea7db0ca8d2a4d999b8aefa889cfbade1470212134968.png", "item/photo/20160803/a13424eeb3724718a2de23610d0a62611470212134968.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:16:43', NULL, NULL, NULL),
(888243, 120590, 112010, 'Swagger 施雅格男士尊享塑型发蜡50g', '', NULL, NULL, NULL, '[["item/photo/20160803/b058be28a18643a2863f95d30aa75db91470210187867.jpg", "item/photo/20160803/fe87a926efe2459d92153b048575c1421470210187867.jpg", "item/photo/20160803/7ee36d2c46b849c3a1484c881cb3cd101470210187867.jpg"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:17:33', NULL, NULL, NULL),
(888246, 120606, 112010, 'Swagger 施雅格男士清爽焕肤洁面保湿棉 清洁护肤一体 35片', '', NULL, NULL, NULL, '[["item/photo/20160803/9f81da56cc364abfb07e64a5b105953c1470212355401.png", "item/photo/20160803/0ea83aec85b744f49ff361507971a8951470212355401.png", "item/photo/20160803/9b99e885465d4d8c8b91c2e755ca86b11470212355401.png"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:20:25', NULL, NULL, NULL),
(888249, 120622, 112005, 'W.DRESSROOM多丽斯 藤条无烟香薰精油散香器 空气净化 70ML', '', NULL, NULL, NULL, '[["item/photo/20160803/22ef9c4b94154fc48b6a069aed99d50e1470212299678.png", "item/photo/20160803/c71442832eb847268c0012748e9bd73c1470212299678.png", "item/photo/20160803/8fc21286e3cf48dc846a45a2f0feb5c41470212299678.png"]]', '{"适用场景": "室内"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:22:20', NULL, NULL, NULL),
(888252, 120582, 112010, 'Swagger 施雅格男士高保湿战士洁面乳 100ml', '', NULL, NULL, NULL, '[["item/photo/20160803/db35868fc00b426aae523221c7795a391470212490889.png", "item/photo/20160803/2f9d3e5463044c65b8213308897164ca1470212490889.png", "item/photo/20160803/23f7b163bd7a4dc8a80c3ced5bcc7bb41470212490889.png"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:22:32', NULL, NULL, NULL),
(888255, 120558, 112010, 'Swagger 施雅格男士高保湿清爽补水面霜 50ml', '', NULL, NULL, NULL, '[["item/photo/20160803/3d7a605fdebf44529f6fdf9b4a75f5031470212613202.png", "item/photo/20160803/3cc32769a42f4ab484888b29c41c258c1470212613202.png", "item/photo/20160803/640af4d4aa504ee98f5952679b8e53f61470212613202.png"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:24:22', NULL, NULL, NULL),
(888258, 120606, 112010, 'Swagger 施雅格男士防晒控油遮瑕保湿隔离BB霜40ML', '', NULL, NULL, NULL, '[["item/photo/20160803/ea7cab222b5d4e198804c7292076c31e1470212736628.png", "item/photo/20160803/1f8d3be4eb3344df926eb609d759849e1470212736628.png", "item/photo/20160803/f5f14e152eb048a0acdec530cb45d5791470212736628.png"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:26:46', NULL, NULL, NULL),
(888261, 120590, 112010, 'Swagger 施雅格男士专用润发油110g', '', NULL, NULL, NULL, '[["item/photo/20160803/55467a7f64f04cda8eee339a9f4393cc1470212455843.png", "item/photo/20160803/fe76ef78dccb4b2b87ef844b9d0adbfe1470212455843.png", "item/photo/20160803/fc50c7549eb9481d81bc360b54bc9b9c1470212455843.png"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:27:16', NULL, NULL, NULL),
(888264, 120622, 112005, 'W.DRESSROOM多丽斯室蜡烛 室内香氛 清新缓解压力 200g', '', NULL, NULL, NULL, '[["item/photo/20160803/f2e9ade9a0a64565ad4b7d6e5e5e483b1470212722991.png", "item/photo/20160803/a7ed2fe786334f5790775b561f47b0d91470212722991.png", "item/photo/20160803/87c97013d11e472fb102851db82717de1470212722991.png"]]', '{"适用场景": "室内"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 14:22:46', '2016-08-03 16:30:06', NULL, NULL, NULL),
(888267, 120590, 112010, 'Swagger 施雅格男士定型发用喷雾200ml', '', NULL, NULL, NULL, '[[null]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:35:50', NULL, NULL, NULL),
(888270, 120558, 112010, 'Swagger 施雅格男士一步到位All in one面部调理乳120ml', '', NULL, NULL, NULL, '[["item/photo/20160803/c40087c597b1455fa9bb28c0f5a217261470213411808.jpg", "item/photo/20160803/c625d341981d4b6294063d462706ffcf1470213411808.jpg", "item/photo/20160803/4af94a2ae53f4d1b81175d531f08a4c51470213411808.jpg"]]', '{"适用人群": "男性"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-03 16:38:05', NULL, NULL, NULL),
(888273, 120574, 112005, '韩国 W.Dressroom多丽斯浪漫香氛护手霜 100g', '', NULL, NULL, NULL, '[["item/photo/20160804/48e71fa5049b4f18aa15319c73f109781470280800735.png", "item/photo/20160804/31fb1bedd98b49ad9118d93a2569df381470280800735.png", "item/photo/20160804/b4d216deb3074bee806623dcb6228dda1470280800735.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-04 11:24:04', NULL, NULL, NULL),
(888276, 120574, 112005, '韩国 W.Dressroom多丽斯浪漫香氛洗手液 250ML', '', NULL, NULL, NULL, '[["item/photo/20160804/a8cc9a7f73214674a5a95b4437e946c11470281552638.png", "item/photo/20160804/e1e186ad95bb4df0801306da6343a4f61470281552638.png", "item/photo/20160804/480b84df6edf492cbfc97ca7bf1816881470281552638.png"]]', '{"适用人群": "通用"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-04 11:34:07', NULL, NULL, NULL),
(888279, 120606, 112010, 'Swagger 施雅格男士沐浴露270ml', '', NULL, NULL, NULL, '[["item/photo/20160804/fe178dedaacd416c83d0ed53f1f87deb1470292216978.png", "item/photo/20160804/54a520555c49484e8ffc1eca1db2f4d61470292216978.png", "item/photo/20160804/f4d7a051b8d044ff99ab077fadbfa2df1470292216978.png"]]', '{"适用人群": "男"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-04 14:30:25', NULL, NULL, NULL),
(888282, 120606, 112010, 'Swagger 施雅格男士身体喷雾 150ml', '', NULL, NULL, NULL, '[["item/photo/20160804/3a7c40d4ebfc4fa1b4671b9e27af642e1470292791306.png", "item/photo/20160804/c540a7652804499b977fdfb13b5484021470292791306.png", "item/photo/20160804/78f9441dc3844b4eadb139b0166cfa5f1470292791306.png"]]', '{"适用人群": "男"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, NULL, '2016-08-04 14:40:00', NULL, NULL, NULL),
(888285, 120574, 112015, 'FASCY发希 水分炸弹 护手霜80ml', '', NULL, NULL, NULL, '[["item/photo/20160804/3bac8240b39d42cc9cd28bb24bd536ff1470293015454.png", "item/photo/20160804/d301fdf6d8c3459a84f90a93a618dbec1470293015454.png", "item/photo/20160804/e5f4db3b349f4e3d868a5410704afd491470293015454.png"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 10:04:54', '2016-08-04 14:45:58', NULL, NULL, NULL),
(888288, 120630, 112015, 'FASCY发希面膜10片装', '', NULL, NULL, NULL, '[["item/photo/20160805/0abd1ec2cbfc455d84c05e831f8504241470362899840.jpg", "item/photo/20160805/7c8828d5f36c4234abe7af38cff43fab1470362899840.jpg", "item/photo/20160805/8054bf9482c14ceea4c669f0f00306751470362899840.jpg"]]', '{"适用人群": "女"}', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '2016-08-05 10:08:23', '2016-08-04 15:02:25', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `slider`
--

CREATE TABLE `slider` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `img` varchar(512) NOT NULL COMMENT '滚动图URL',
  `sort_nu` int(11) NOT NULL COMMENT '排序',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `item_target` varchar(256) DEFAULT NULL COMMENT '目标商品地址',
  `target_type` varchar(20) DEFAULT 'T' COMMENT 'T:主题，D:详细页面，P:拼购商品页，U:一个促销活动的链接（h5主题）',
  `or_nav` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是导航图（true导航图，false滚动图）',
  `nav_text` varchar(16) DEFAULT NULL COMMENT '导航文字显示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='滚动条';

--
-- 转存表中的数据 `slider`
--

INSERT INTO `slider` (`id`, `img`, `sort_nu`, `create_at`, `update_at`, `item_target`, `target_type`, `or_nav`, `nav_text`) VALUES
(140, '{"url":"slider/pic/20160805/088ac4ccc23040f7a37fec474b6c4fbb1470376165454.png","width":"604","height":"290"}', 1, '2016-08-05 13:49:28', '2016-08-10 14:22:24', '/topic/list/444000', 'T', 0, NULL),
(145, '{"url":"slider/pic/20160808/22733972482d492d8b8243cd42a0d3ed1470625394763.jpg","width":"1000","height":"400"}', 2, '2016-08-08 11:05:38', '2016-08-10 14:22:24', '/topic/list/444014', 'T', 0, NULL),
(150, '{"url":"slider/pic/20160808/d52e94f64a2f471bb5fb08b57c8ce65d1470625401596.jpg","width":"1000","height":"400"}', 3, '2016-08-08 11:05:38', '2016-08-10 14:22:24', '/topic/list/444021', 'T', 0, NULL),
(155, '{"url":"slider/pic/20160808/fc5dd23f5b184d2d9337fc25dbd105271470625427926.jpg","width":"1920","height":"500"}', 4, '2016-08-08 11:05:38', '2016-08-10 14:22:24', '/comm/detail/item/888000/111000', 'D', 0, NULL),
(160, '{"url":"slider/pic/20160808/bee2e6a6d1834dd3bb290b6e508a42111470625484232.jpg","width":"1920","height":"500"}', 5, '2016-08-08 11:05:39', '2016-08-10 14:22:25', '/comm/detail/item/888003/111002', 'D', 0, NULL),
(165, '{"url":"slider/pic/20160808/025b464adf8c40d7b728086c71d530ee1470625495293.jpg","width":"1920","height":"500"}', 6, '2016-08-08 11:05:39', '2016-08-10 14:22:25', '/comm/detail/pin/888015/111300', 'P', 0, NULL),
(170, '{"url":"slider/pic/20160808/d536fb1b4f524e99a4a77487549f9f6d1470625507940.jpg","width":"1920","height":"500"}', 7, '2016-08-08 11:05:39', '2016-08-10 14:22:25', '/comm/detail/item/888015/111010', 'D', 0, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `subject_price`
--

CREATE TABLE `subject_price` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `theme_id` bigint(20) NOT NULL COMMENT '主题ID',
  `inv_id` bigint(20) NOT NULL COMMENT '商品库存ID',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `discount` decimal(10,2) NOT NULL COMMENT '折扣率',
  `create_at` timestamp NOT NULL COMMENT '创建时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `state` char(1) NOT NULL DEFAULT 'Y' COMMENT 'Y--正常,D--下架,N--删除,K--售空，P--预售'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题价格';

-- --------------------------------------------------------

--
-- 表的结构 `sys_parameter`
--

CREATE TABLE `sys_parameter` (
  `sys_id` bigint(20) NOT NULL COMMENT '主键',
  `parameter_nm` varchar(255) NOT NULL COMMENT '参数名',
  `parameter_val` varchar(255) NOT NULL COMMENT '参数值',
  `parameter_code` varchar(255) NOT NULL DEFAULT 'D' COMMENT '参数代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统参数';

--
-- 转存表中的数据 `sys_parameter`
--

INSERT INTO `sys_parameter` (`sys_id`, `parameter_nm`, `parameter_val`, `parameter_code`) VALUES
(500102, '行邮税收税标准', '50', 'POSTAL_STANDARD'),
(500110, '海关规定购买单笔订单金额限制', '2000', 'POSTAL_LIMIT'),
(500113, '达到多少免除邮费', '5000', 'FREE_SHIP'),
(500169, '用户发起拼购的有效期24小时', '24', 'PIN_TIMES'),
(500174, '是否允许用户对同一商品既参团又创建团', 'Y', 'PIN_SHOPPING_CONCURRENT'),
(500179, '用户发起拼购的有效期24小时', '24', 'PIN_TIMES');

-- --------------------------------------------------------

--
-- 表的结构 `tax_code`
--

CREATE TABLE `tax_code` (
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `price` varchar(32) DEFAULT NULL,
  `rate` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='税率表';

--
-- 转存表中的数据 `tax_code`
--

INSERT INTO `tax_code` (`code`, `name`, `unit`, `price`, `rate`) VALUES
('01010120', '干鲍鱼', '千克', '5000', '10'),
('01010130', '干海参', '千克', '1500', '10'),
('01010140', '干瑶柱', '千克', '700', '10'),
('01010150', '干海马、干海龙', '千克', '1500', '10'),
('01010190', '其他水产品', '千克', NULL, '10'),
('01010210', '燕盏', '千克', '30000', '10'),
('01010220', '燕饼（燕丝、燕条）', '千克', '15000', '10'),
('01010230', '燕碎', '千克', '5000', '10'),
('01010290', '其他燕窝制品', '千克', NULL, '10'),
('01010300', '冬虫夏草', '千克', '100000', '10'),
('01010400', '参', '千克', '1500', '10'),
('01010500', '鹿茸', '千克', '2000', '10'),
('01010600', '阿胶', '千克', '250', '10'),
('01010700', '奶粉', '千克', '200', '10'),
('01010800', '调味品', '千克', '200', '10'),
('01019900', '其他食品', '千克', NULL, '10'),
('01020100', '茶叶', '千克', '200', '10'),
('01020200', '咖啡', '千克', '200', '10'),
('01029900', '其他饮料', '千克', NULL, '10'),
('02010100', '12度以下（不含12度）', '瓶（不超过750毫升）', '5', '50'),
('02010200', '12度至22度（不含22度）', '瓶（不超过750毫升）', '10', '50'),
('02020000', '葡萄酒', NULL, NULL, NULL),
('02020100', '12度以下（不含12度）', '瓶（不超过750毫升）', '100', '50'),
('02020200', '12度至22度（不含22度）', '瓶（不超过750毫升）', '200', '50'),
('02030000', '清酒', NULL, NULL, NULL),
('02030100', '12度以下（不含12度）', '瓶（不超过750毫升）', '30', '50'),
('02030200', '12度至22度（不含22度）', '瓶（不超过750毫升）', '50', '50'),
('02030300', '22度及以上', '瓶（不超过750毫升）', '80', '50'),
('02040000', '白兰地', '瓶（不超过750毫升）', '500', '50'),
('02050000', '威士忌', '瓶（不超过750毫升）', '300', '50'),
('02060000', '伏特加', '瓶（不超过750毫升）', '100', '50'),
('02070000', '白酒', '瓶（不超过750毫升）', '300', '50'),
('02080000', '药酒', '瓶（不超过750毫升）', '200', '50'),
('02990000', '其他酒', '瓶（不超过750毫升）', NULL, '50'),
('03000000', '烟草', NULL, NULL, NULL),
('03010000', '卷烟', '支', '0.5', '50'),
('03020000', '雪茄烟', '支', '10', '50'),
('03030000', '烟丝', '克', '0.5', '50'),
('03990000', '其他烟', '克、支', NULL, '50'),
('04000000', '纺织品及其制成品', NULL, NULL, NULL),
('04010000', '衣着', NULL, NULL, NULL),
('04010100', '外衣', '件', '300', '20'),
('04010200', '外裤', '条', '200', '20'),
('04010300', '内衣裤', '条/件', '100', '20'),
('04010400', '衬衫/T恤衫', '件', '200', '20'),
('04019900', '其他衣着', '件', NULL, '20'),
('04020000', '配饰', NULL, NULL, NULL),
('04020100', '帽子', '件', '100', '20'),
('04020200', '丝巾、头巾、围巾', '条', '100', '20'),
('04020300', '领带', '条', '100', '20'),
('04020400', '腰带', '条', '100', '20'),
('04020500', '手套', '双', '100', '20'),
('04029900', '其他配饰', '件', NULL, '20'),
('04030000', '家纺用品', NULL, NULL, NULL),
('04030100', '毛毯、被子、床罩、睡袋', '床、件', '400', '20'),
('04030200', '枕头、床单、毛巾被、被套', '条、件', '100', '20'),
('04030300', '地毯', '平方米', '200', '20'),
('04030400', '窗帘', '千克', '100', '20'),
('04039900', '其他家纺用品', '件', NULL, '20'),
('04990000', '其他纺织品及其制成品', '件', NULL, '20'),
('05000000', '皮革服装及配饰', NULL, NULL, NULL),
('05010000', '皮革服装', NULL, NULL, NULL),
('05010100', '裘皮衣', '件', NULL, '10'),
('05010200', '皮大衣', '件', '2000', '10'),
('05010300', '皮上衣', '件', '1500', '10'),
('05010400', '皮背心', '件', '1000', '10'),
('05010500', '皮裤', '件', '1000', '10'),
('05010600', '皮裙', '件', '1000', '10'),
('05019900', '其他皮革服装', '件', NULL, '10'),
('05020000', '皮革配饰', NULL, NULL, NULL),
('05020100', '皮帽', '件', '200', '10'),
('05020200', '皮带', '条', '100', '10'),
('05020300', '皮手套', '双', '100', '10'),
('05029900', '其他皮革配饰', '件', NULL, '10'),
('05990000', '其他皮革制品（箱包和鞋靴除外）', '件', NULL, '10'),
('06000000', '箱包和鞋靴', NULL, NULL, NULL),
('06010000', '箱包', NULL, NULL, NULL),
('06010100', '箱', '个', '500', '10'),
('06010200', '挎包、背包、提包', '个', '200', '10'),
('06010300', '钱包、钥匙包', '个', '100', '10'),
('06019900', '其他箱包', '个', NULL, '10'),
('06020000', '鞋靴', NULL, NULL, NULL),
('06020100', '皮鞋', '双', '300', '10'),
('06020200', '皮靴', '双', '400', '10'),
('06020300', '运动鞋', '双', '200', '10'),
('06029900', '其他鞋靴', '双', NULL, '10'),
('07000000', '表、钟及其配件、附件', NULL, NULL, NULL),
('07010000', '表', NULL, NULL, NULL),
('07010100', '高档手表（审定价格在人民币10000元及以上）', '块', NULL, '30'),
('07010200', '其他表', NULL, NULL, NULL),
('07010210', '石英表（电子表）', '块', '200', '20'),
('07010220', '机械表', '块', '500', '20'),
('07010290', '其他表', '块', NULL, '20'),
('07020000', '钟', NULL, NULL, NULL),
('07020100', '座钟、挂钟、台钟', '个、台', '200', '20'),
('07020200', '落地钟', '台', '600', '20'),
('07029900', '其他钟', '台', NULL, '20'),
('07030000', '钟表配件、附件', '件', NULL, '20'),
('08000000', '金、银、珠宝及其制品、艺术品、收藏品', NULL, NULL, NULL),
('08010000', '金、银及其制品', '件', NULL, '10'),
('08020000', '珠、宝及其制品', '件', NULL, '10'),
('08030000', '艺术品、收藏品', '件', NULL, '10'),
('09000000', '化妆品', NULL, NULL, NULL),
('09010000', '芳香类化妆品', NULL, NULL, NULL),
('09010100', '香水', '瓶', '300', '50'),
('09019900', '其他芳香类化妆品', '件', NULL, '50'),
('09020000', '清洁/护理类化妆品', NULL, NULL, NULL),
('09020100', '洗面奶/洁面霜', '支、瓶', '100', '50'),
('09020200', '眼霜', '支、瓶', '200', '50'),
('09020300', '面霜及乳液', '支、瓶', '200', '50'),
('09020400', '精华液/素', '支、瓶', '300', '50'),
('09020500', '润唇膏', '支', '20', '50'),
('09020600', '面膜', '张、瓶', '20', '50'),
('01010110', '干鱼翅', '千克', '3000', '10'),
('01010160', '鱼肚（花胶）', '千克', '1500', '10'),
('09020800', '护手霜', '支、瓶', '50', '50'),
('09020900', '防晒霜（露、乳液）', '支', '150', '50'),
('09029900', '其他清洁/护理类化妆品', '支', NULL, '50'),
('09030000', '美容/修饰类化妆品', NULL, NULL, NULL),
('09030100', '粉底及粉底液', '盒、支', '200', '50'),
('09030200', '睫毛液（膏）', '支、瓶', '100', '50'),
('09030300', '指甲油', '瓶', '20', '50'),
('09030400', '唇膏', '支', '150', '50'),
('09039900', '其他美容/修饰类化妆品', '件', NULL, '50'),
('09040000', '特殊功能类化妆品', '件', NULL, '50'),
('10000000', '家用医疗、保健及美容器材', NULL, NULL, NULL),
('10010000', '家用医疗器材', NULL, NULL, NULL),
('10010100', '血糖计', '个', '500', '10'),
('10010200', '血糖试纸', '张', '5', '10'),
('10010300', '红外线耳探热针', '个', '200', '10'),
('10010400', '家用雾化机', '台', '2000', '10'),
('10010500', '血压计', '个', '500', '10'),
('10019900', '其他家用医疗器材', '件', NULL, '10'),
('10020000', '家用保健器材', NULL, NULL, NULL),
('10020100', '按摩床', '张', '10000', '10'),
('10020200', '按摩椅', '张', '5000', '10'),
('10029900', '其他家用保健器材', '件', NULL, '10'),
('10030000', '家用美容器材', NULL, NULL, NULL),
('10030100', '蒸汽仪', '台', '200', '10'),
('10030200', '喷雾器', '台', '400', '10'),
('10039900', '其他家用美容器材', '台', NULL, '10'),
('11000000', '厨卫用具及小家电', NULL, NULL, NULL),
('11010000', '厨房用具', NULL, NULL, NULL),
('11010100', '餐具/刀具', '个、把', '20', '10'),
('11010200', '炊具', '件', '100', '10'),
('11010300', '灶具', '件', '1000', '10'),
('11010400', '净水器（含过滤芯）', '个', '500', '10'),
('11010500', '净水器过滤芯', '个', '200', '10'),
('11011100', '电饭煲', '个', '500', '20'),
('11011200', '微波炉', '台', '600', '20'),
('11011300', '电磁炉', '台', '800', '20'),
('11011400', '抽油烟机', '台', '1000', '20'),
('11011500', '家用洗碗机', '台', '1500', '20'),
('11011600', '电动榨汁机', '台', '100', '20'),
('11011700', '咖啡机', '台', '4000', '20'),
('11019900', '其他厨房用具', NULL, NULL, NULL),
('11019910', '其他厨房非电动用具', '件、个', NULL, '10'),
('11019990', '其他厨房小电器', '台', NULL, '20'),
('11020000', '卫生用具、洁具', NULL, NULL, NULL),
('11020100', '卫生间非电动用具', '件', NULL, '10'),
('11021100', '卫生间小电器', NULL, NULL, NULL),
('11021110', '电热水器', '台', '1000', '20'),
('11021120', '电吹风机', '个', '200', '20'),
('11021130', '电动剃须刀', '个', '200', '20'),
('11021140', '电动牙刷', '个', '200', '20'),
('11021190', '其他卫生间小电器', '台', NULL, '20'),
('11030000', '小家电', NULL, NULL, NULL),
('11030100', '电话机', NULL, NULL, NULL),
('11030110', '普通电话机', '台', '200', '10'),
('11030120', '手持移动电话机', '台', NULL, NULL),
('11030121', '键盘式手持移动电话机', '台', '1000', '10'),
('11030122', '触屏式手持移动电话机', '台', NULL, '10'),
('11030130', '电话传真机', '台', '1000', '10'),
('11030140', '可视电话机', '台', '1000', '10'),
('11030150', '电话机配件、附件', '件', NULL, '10'),
('11030190', '其他电话机', '台', NULL, '10'),
('11030200', '游戏机', NULL, NULL, NULL),
('11030210', '便携式游戏机', '台', '1000', '10'),
('1103022', '游戏机配件、附件', NULL, NULL, NULL),
('11030221', '游戏碟、盘、卡', '张、个', '60', '10'),
('11030222', '游戏机遥控器、控制器', '个', '200', '10'),
('11030229', '其他游戏机配件、附件', '件', NULL, '10'),
('11030290', '其他游戏机', '台', NULL, '10'),
('11030300', '手动缝纫机、编织机', '台', '400', '10'),
('11031100', '便携式复印机', '台', '1500', '20'),
('11031200', '电风扇', '台', '400', '20'),
('11031300', '电熨斗', '台', '200', '20'),
('11031400', '电暖器', '台', '400', '20'),
('11031500', '增/除湿机、增除湿一体机', '台', '1500', '20'),
('11031600', '空气清新机', '台', '1000', '20'),
('11031700', '吸尘器', '台', '500', '20'),
('11031800', '地板打蜡机', '台', '500', '20'),
('11031900', '电动剪草机', '台', '2000', '20'),
('11032000', '电动缝纫机、编织机', '台', '2000', '20'),
('11032100', '灯具', '台、件', NULL, '20'),
('11039900', '其他家庭用具、小家电', NULL, NULL, NULL),
('11039910', '其他家庭用具', '件、个', NULL, '10'),
('11039990', '其他小家电', '台', NULL, '20'),
('12000000', '家具', NULL, NULL, NULL),
('12010000', '实木家具', '件', NULL, '10'),
('12020000', '皮质家具', '件', '1000', '10'),
('12030000', '藤、竹质家具', '件', '600', '10'),
('12990000', '其他家具', '件', NULL, '10'),
('13000000', '空调及其配件、附件', NULL, NULL, NULL),
('13010000', '空调', NULL, NULL, NULL),
('13010100', '1匹及以下', '台', '2000', '20'),
('13010200', '1匹以上2匹以下（含2匹）', '台', '4000', '20'),
('13010300', '2匹以上3匹以下（含3匹）', '台', '6000', '20'),
('13010400', '3匹以上', '台', NULL, '20'),
('13020000', '空调配件、附件', '个', NULL, '20'),
('13990000', '其他空调', '台', NULL, '20'),
('14000000', '电冰箱及其配件、附件', NULL, NULL, NULL),
('14010000', '电冰箱、冰柜', NULL, NULL, NULL),
('14010100', '100公升及以下', '台', '1000', '20'),
('14010200', '101200公升', '台', '2000', '20'),
('14010300', '201250公升', '台', '3000', '20'),
('14010400', '251300公升', '台', '5000', '20'),
('14010500', '301400公升', '台', '10000', '20'),
('14010600', '401500公升', '台', '15000', '20'),
('14010700', '501公升及以上', '台', NULL, '20'),
('14020000', '红酒柜', NULL, NULL, NULL),
('14020100', '12瓶及以下', '台', '1000', '20'),
('14020200', '1318瓶', '台', '2000', '20'),
('14020300', '1945瓶', '台', '3000', '20'),
('14020400', '4675瓶', '台', '4000', '20'),
('14020500', '76120瓶', '台', '5000', '20'),
('14020600', '121瓶及以上', '台', NULL, '20'),
('14030000', '电冰箱配件、附件', '件', NULL, '20'),
('14990000', '其他电冰箱', '台', NULL, '20'),
('15000000', '洗衣设备及其配件、附件', NULL, NULL, NULL),
('15010000', '洗衣机', NULL, NULL, NULL),
('15010100', '波轮式', '台', '1000', '20'),
('15010200', '滚筒式', '台', '3000', '20'),
('15020000', '干衣机/烘干机', '台', '2000', '20'),
('15030000', '洗衣设备配件、附件', '件', NULL, '20'),
('15990000', '其他洗衣设备', '台', NULL, '20'),
('16000000', '电视机及其配件、附件', NULL, NULL, NULL),
('16010000', '电视机', NULL, NULL, NULL),
('16010100', '22英寸及以下', '台', '1000', '20'),
('16010200', '23英寸至32英寸', '台', '2000', '20'),
('16010300', '33英寸至39英寸', '台', '4000', '20'),
('16010400', '40英寸至42英寸', '台', '6000', '20'),
('16010500', '43英寸至45英寸', '台', '8000', '20'),
('16010600', '46英寸至49英寸', '台', '10000', '20'),
('16010700', '50英寸至54英寸', '台', '20000', '20'),
('16010800', '55英寸至59英寸', '台', '30000', '20'),
('16010900', '60英寸至64英寸', '台', '35000', '20'),
('16011000', '65英寸以上', '台', NULL, '20'),
('16020000', '电视机配件、附件', '件、个', NULL, '20'),
('16990000', '其他电视机', '台', NULL, '20'),
('17000000', '摄影（像）设备及其配件、附件', NULL, NULL, NULL),
('17010000', '照相机', NULL, NULL, NULL),
('17010100', '数码照相机', NULL, NULL, NULL),
('17010110', '一体式数码照相机', '台', '2000', '10'),
('17010120', '镜头可拆卸式数码照相机', NULL, NULL, NULL),
('17010121', '可拆卸式数码照相机机身', '台', '5000', '10'),
('17010122', '可拆卸式数码照相机镜头', '个', '2000', '10'),
('17019900', '其他照相机', '台', NULL, '10'),
('17020000', '摄像机', NULL, NULL, NULL),
('17020100', '便捷式摄录一体机', '台', '4000', '10'),
('17020200', '电视摄像机', '台', NULL, '20'),
('17030000', '摄影（像）设备配件、附件', NULL, NULL, NULL),
('17030100', '数码存储卡', NULL, NULL, NULL),
('17030110', '存储容量8G及以下', '个', '50', '10'),
('17030120', '存储容量8G以上', '个', '200', '10'),
('17030200', '闪光灯', '个', '500', '10'),
('17030300', '支架', '个', '300', '10'),
('17030400', '胶卷', '个', '20', '10'),
('17030500', '数码相框', '台', '500', '10'),
('17039900', '其他摄影（像）设备配件、附件', '件', NULL, '10'),
('17990000', '其他摄影（像）设备', '台、件', NULL, '10'),
('18000000', '影音设备及其配件、附件', NULL, NULL, NULL),
('18010000', '便携式影音设备', NULL, NULL, NULL),
('18010100', '录音笔', '台', '200', '20'),
('18010200', '录音机', '台', '200', '20'),
('18010300', '收音机', '台', '200', '20'),
('18010400', 'MP3播放器（音频多媒体播放器）', '台', '100', '20'),
('18010500', 'MP4播放器（视频多媒体播放器）', '台', '500', '20'),
('18019900', '其他便携式影音设备', '台', NULL, '20'),
('18020000', '音响设备', NULL, NULL, NULL),
('18020100', '电唱机', '台', '500', '20'),
('18020100', '（含便携式激光唱机）', '台', '500', '20'),
('18020200', '放像机', '台', '500', '20'),
('18020300', '录像机', '台', '800', '20'),
('18020400', '激光视盘机（LD、VCD、DVD等）', '台', '500', '20'),
('18020500', '（单）功能座', '台', '1000', '20'),
('18020500', '（功放、调谐、均衡等）', '台', '1000', '20'),
('18020600', '音箱', '个', '1000', '20'),
('18020700', '便携式收音、录音、激光唱盘一体机', '台', '1000', '20'),
('18029900', '其他音响设备', '件', NULL, '20'),
('18030000', '影音设备配件、附件', NULL, NULL, NULL),
('18030100', '唱片', '张', '50', '20'),
('18030200', '录音带（非教育专用）', '盘', '10', '20'),
('18030300', '录像带（非教育专用）', '盘', '30', '20'),
('18030400', '激光唱盘（CD）', '张', '30', '20'),
('18030500', '激光视盘', '张', '50', '20'),
('18030500', '（LD、VCD、DVD等）', '张', '50', '20'),
('18039900', '其他影音设备配件、附件', '个、件', NULL, '20'),
('18990000', '其他影音设备', '个、台', NULL, '20'),
('19000000', '计算机及其外围设备', NULL, NULL, NULL),
('19010000', '计算机', NULL, NULL, NULL),
('19010100', '台式个人计算机主机', '台', '2000', '10'),
('19010200', '主机、显示器一体机', '台', '3000', '10'),
('19010300', '笔记本电脑（含平板电脑、掌上电脑、上网本等）', '台', NULL, NULL),
('19010310', '键盘式笔记本电脑', '台', '2000', '10'),
('19010320', '触屏式笔记本电脑', '台', NULL, '10'),
('19010400', '计算机配件', NULL, NULL, NULL),
('19010410', '主板', '块', '500', '10'),
('19010420', '中央处理器（CPU）', '个', '500', '10'),
('19010430', '内存条', NULL, NULL, NULL),
('19010431', '4G及以下', '条', '200', '10'),
('19010432', '4G以上', '条', '300', '10'),
('19010440', '功能卡', '块', '300', '10'),
('19010490', '其他计算机配件', '块、个', NULL, '10'),
('19019900', '其他计算机', '台', NULL, '10'),
('19020000', '计算机外围设备', NULL, NULL, NULL),
('19020100', '鼠标', '个', '50', '10'),
('19020200', '键盘', '个', '80', '10'),
('19020300', '音箱', '个', '50', '10'),
('19020400', '显示器', NULL, NULL, NULL),
('19020410', '液晶显示器', NULL, NULL, NULL),
('19020411', '19英寸及以下', '台', '800', '10'),
('19020412', '19英寸以上，24英寸及以下', '台', '1200', '10'),
('19020413', '24英寸以上', '台', NULL, '10'),
('19020420', '显像管（CRT）显示器', NULL, NULL, NULL),
('19020421', '17英寸及以下', '台', '300', '10'),
('19020422', '17英寸以上', '台', '500', '10'),
('19020490', '其他显示器', '台', NULL, '10'),
('19020500', '打印机', NULL, NULL, NULL),
('19020510', '激光打印机', NULL, NULL, NULL),
('19020511', '黑白激光打印机', '台', '1000', '10'),
('19020512', '彩色激光打印机', '台', '3000', '10'),
('19020520', '喷墨打印机', '台', '500', '10'),
('19020530', '针式打印机', '台', '1000', '10'),
('19020540', '多功能一体打印机', NULL, NULL, NULL),
('19020541', '喷墨多功能一体打印机', '台', '600', '10'),
('19020542', '激光多功能一体打印机', '台', '1500', '10'),
('19020590', '其他打印机', '台', NULL, '10'),
('19020600', '扫描仪', '台', '1000', '10'),
('19020700', '视频投影仪', '台', '5000', '10'),
('19020800', '驱动器', NULL, NULL, NULL),
('19020810', 'CD', '台', '100', '10'),
('19020820', 'DVD', '台', '200', '10'),
('19020890', '其他驱动器', '台', NULL, '10'),
('19020900', '存储器', NULL, NULL, NULL),
('19020910', '硬盘/移动硬盘', NULL, NULL, NULL),
('19020911', '1T及以下', '个', '300', '10'),
('19020912', '1T以上2T以下（含2T）', '个', '500', '10'),
('19020913', '2T以上', '个', NULL, '10'),
('19020920', 'U盘', '个', '50', '10'),
('19020990', '其他存储器', '个、盒', NULL, '10'),
('19029900', '其他计算机外围设备', '台', NULL, '10'),
('20000000', '书报、刊物及其他各类印刷品', NULL, NULL, '10'),
('21000000', '教育专用的电影片、幻灯片、原版录音带、录像带', NULL, NULL, NULL),
('21010000', '幻灯片', '片', '10', '10'),
('21020000', '录音带', '盘', '10', '10'),
('21030000', '录像带', '盘', '50', '10'),
('21990000', '其他教育专用影片、录音、录像带', '件', NULL, '10'),
('22000000', '文具用品、玩具', NULL, NULL, NULL),
('22010000', '文具用品', NULL, NULL, NULL),
('22010100', '电子计算器', '个', '200', '10'),
('22010200', '电子字典/记事簿', '个', '300', '10'),
('22010300', '电子(纸)书', '台', '800', '10'),
('22010400', '笔', '支', '50', '10'),
('22019900', '其他文具用品', '件', NULL, '10'),
('22020000', '玩具', '件', NULL, '10'),
('23000000', '邮票', NULL, NULL, NULL),
('23010000', '中国邮票、小型张、纪念封', '张', NULL, '10'),
('23020000', '港澳台、外国邮票', '张', '5', '10'),
('23030000', '港澳台、外国小型张、纪念封', '张', '10', '10'),
('24000000', '乐器', NULL, NULL, NULL),
('24010000', '钢琴', NULL, NULL, NULL),
('24010100', '三角钢琴', '架', '90000', '10'),
('24010200', '立式钢琴', '架', '15000', '10'),
('24010300', '电子钢琴', '架', '5000', '10'),
('24019900', '其他钢琴', '架', NULL, '10'),
('24020000', '电子琴', NULL, NULL, NULL),
('24020100', '49键以下', '台', '800', '10'),
('24020200', '49键及以上', '台', '3000', '10'),
('24030000', '萨克斯', '把', '10000', '10'),
('24040000', '电子吉他', '把', '2000', '10'),
('24050000', '数码小提琴', '把', '5000', '10'),
('24060000', '长、短笛', '支', '5000', '10'),
('24070000', '单簧管', '支', '4000', '10'),
('24080000', '双簧管', '支', '10000', '10'),
('24090000', '古筝', '架', '2000', '10'),
('24990000', '其他乐器', '件', NULL, '10'),
('25000000', '体育用品', NULL, NULL, NULL),
('25010000', '高尔夫球及球具', NULL, NULL, NULL),
('25010100', '球杆', '根', '1000', '30'),
('25010200', '球', '个', '20', '30'),
('25019900', '其他高尔夫球具', '件', NULL, '30'),
('25020000', '运动器具', NULL, NULL, NULL),
('25020200', '羽毛球拍', '个', '300', '10'),
('25029900', '其他运动器具', '件', NULL, '10'),
('25030000', '多功能健身器具', NULL, NULL, NULL),
('25030100', '跑步机', '件', '2000', '10'),
('25030200', '健身车', '件', '1000', '10'),
('25030300', '综合训练器', '件', '3000', '10'),
('25039900', '其他多功能健身器具', '件', NULL, '10'),
('25990000', '其他体育用品', '件', NULL, '10'),
('26000000', '自行车、三轮车、童车及其配件、附件', NULL, NULL, NULL),
('26010000', '自行车', '辆', '500', '20'),
('26020000', '三轮车', '辆', '500', '20'),
('26030000', '童车', '辆', '200', '20'),
('26040000', '自行车、三轮车、童车配件、附件', '件', NULL, '20'),
('27000000', '其他物品', '件', NULL, '10'),
('09020700', '爽肤水', '支、瓶', '150', '50'),
('25020100', '网球拍', '个', '500', '10');

-- --------------------------------------------------------

--
-- 表的结构 `themes`
--

CREATE TABLE `themes` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `master_item_id` bigint(20) DEFAULT NULL COMMENT '（未使用）',
  `title` varchar(512) DEFAULT NULL COMMENT '每个主题会有宣传标题',
  `start_at` timestamp NOT NULL COMMENT '开始时间',
  `end_at` timestamp NOT NULL COMMENT '结束时间',
  `theme_img` varchar(512) NOT NULL COMMENT '模板生成后的主题图片，APP首页显示用',
  `sort_nu` int(11) NOT NULL COMMENT '排序',
  `or_destroy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `destroy_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `theme_src_img` varchar(255) DEFAULT NULL COMMENT '未使用）主题原背景图',
  `theme_config_info` varchar(255) DEFAULT NULL COMMENT '主题描述信息',
  `theme_item` varchar(512) DEFAULT '' COMMENT '主题所包含商品',
  `master_item_tag` varchar(512) DEFAULT NULL COMMENT '主题主宣传图上的标签',
  `theme_master_img` varchar(255) DEFAULT NULL COMMENT '每个主题进去后的主宣传图',
  `type` varchar(32) NOT NULL DEFAULT 'ordinary' COMMENT '主题类型：	普通主题（ordinary），HTML5（h5），普通商品主题（detail），拼购商品主题（pin）',
  `h5_link` varchar(512) DEFAULT NULL COMMENT 'H5链接，如果是详情页类型的主题时的跳转地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题表';

--
-- 转存表中的数据 `themes`
--

INSERT INTO `themes` (`id`, `master_item_id`, `title`, `start_at`, `end_at`, `theme_img`, `sort_nu`, `or_destroy`, `destroy_at`, `update_at`, `create_at`, `theme_src_img`, `theme_config_info`, `theme_item`, `master_item_tag`, `theme_master_img`, `type`, `h5_link`) VALUES
(444000, NULL, '普通主题测试', '2016-08-05 13:46:10', '2016-09-13 14:46:13', '{"url":"templates/photo/20160805/4e6e22b2ac21485aa1ed385cce06ba471470376029834.png","width":"776","height":"373"}', 13, 0, '2016-08-06 14:46:13', '2016-08-08 10:40:31', '2016-08-05 13:49:12', NULL, '普通主题测试', '[{"id": "111006", "type": "item"}, {"id": "111298", "type": "pin"}]', '[{"top": 0.12, "url": {"id": "111288", "type": "item"}, "left": 0.27, "name": "biu", "angle": 180}]', '{"url":"themes/photo/themeImg/20160805/5d3202786911408886c16c634b81658e1470376144429.png","width":"604","height":"290"}', 'ordinary', NULL),
(444007, NULL, '单一商品测试', '2016-08-05 15:31:52', '2016-09-22 15:31:54', '{"url":"templates/photo/20160805/7ea9d4589dd2473eafa52429ac02f42a1470382440863.png","width":"1136","height":"545"}', 14, 0, '2016-08-06 15:31:54', '2016-08-08 13:05:02', '2016-08-05 15:34:45', NULL, '单一商品测试', '[{"id": "111002", "type": "item"}]', NULL, NULL, 'detail', '/comm/detail/item/888003/111002'),
(444014, NULL, '没有主题里的主图测试', '2016-08-05 15:34:58', '2016-09-30 15:35:01', '{"url":"templates/photo/20160805/1e2de300cd5641c797afee9415ea459e1470382512431.jpg","width":"1136","height":"544"}', 15, 0, '2016-08-06 15:35:01', '2016-08-08 10:41:10', '2016-08-05 15:35:41', NULL, '没有主题里的主图测试', '[{"id": "111060", "type": "item"}, {"id": "111050", "type": "item"}, {"id": "111048", "type": "item"}, {"id": "111042", "type": "item"}, {"id": "111040", "type": "item"}, {"id": "111032", "type": "item"}, {"id": "111024", "type": "item"}, {"id": "111022", "type": "item"}, {"id": "111018", "type": "item"}]', NULL, NULL, 'ordinary', NULL),
(444021, NULL, '只有主题主图测试', '2016-08-05 15:39:03', '2016-08-31 15:39:06', '{"url":"templates/photo/20160805/d4ffd33b133d44958affe7eb06be72b01470382753140.jpg","width":"1136","height":"544"}', 16, 0, '2016-08-06 15:39:06', '2016-08-08 10:41:26', '2016-08-05 15:40:40', NULL, '只有主题主图测试', NULL, '[{"top": 0.09, "url": {"id": "111022", "type": "item"}, "left": 0.45, "name": "明白", "angle": 180}, {"top": 0.26, "url": {"id": "111022", "type": "item"}, "left": 0.78, "name": "天天天", "angle": 180}]', '{"url":"themes/photo/themeImg/20160805/1c7c8230178749b195c1a40d758dd5f41470382772312.jpg","width":"750","height":"2666"}', 'ordinary', NULL),
(444028, NULL, '拼购测试', '2016-08-05 15:45:50', '2016-08-28 15:45:53', '{"url":"templates/photo/20160805/4e6e22b2ac21485aa1ed385cce06ba471470376029834.png","width":"1136","height":"545"}', 17, 0, '2016-08-07 15:45:53', '2016-08-08 13:04:07', '2016-08-05 15:46:18', NULL, '拼购测试', '[{"id": "111298", "type": "pin"}]', NULL, NULL, 'pin', '/comm/detail/pin/888051/111298'),
(444035, NULL, '专用测试真实发货商品', '2016-08-10 13:01:24', '2016-10-19 13:01:26', '{"url":"templates/photo/20160810/9cafa1cab12f47da8551b83946ab87571470805325785.jpg","width":"1144","height":"547"}', 18, 0, NULL, NULL, '2016-08-10 13:03:05', NULL, '专用测试真实发货商品（给自己发一个减80的券）', '[{"id": "111016", "type": "item"}, {"id": "111014", "type": "item"}, {"id": "111012", "type": "item"}, {"id": "111010", "type": "item"}]', NULL, NULL, 'ordinary', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `theme_templates`
--

CREATE TABLE `theme_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `navigator_html` text,
  `content_html` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题模板表';

--
-- 转存表中的数据 `theme_templates`
--

INSERT INTO `theme_templates` (`id`, `url`, `navigator_html`, `content_html`) VALUES
(300300, '', '<div class="temp-img" style="height: 100%;"><div class="bg-img" onmousedown="righthit(this.childNodes)"><img src="http://img.hanmimei.com/templates/photo/20160805/4e6e22b2ac21485aa1ed385cce06ba471470376029834.png"></div></div>', '<div class="temp-img" style="height: 102%;"><div class="bg-img" onmousedown="righthit(this.childNodes)"><img src="http://img.hanmimei.com/templates/photo/20160805/4e6e22b2ac21485aa1ed385cce06ba471470376029834.png"><input id="4e6e22b2ac21485aa1ed385cce06ba471470376029834" type="hidden" name="4e6e22b2ac21485aa1ed385cce06ba471470376029834.png" value="/uploads/minify/4e6e22b2ac21485aa1ed385cce06ba471470376029834.png"></div></div>');

-- --------------------------------------------------------

--
-- 表的结构 `vary_price`
--

CREATE TABLE `vary_price` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',
  `inv_id` bigint(20) NOT NULL COMMENT '库存ID',
  `sold_amount` int(11) NOT NULL DEFAULT '0' COMMENT '卖出数量',
  `limit_amount` int(11) NOT NULL DEFAULT '999999' COMMENT '限制卖出总量',
  `status` char(1) NOT NULL DEFAULT 'Y' COMMENT '''Y''--正常,''D''--下架,''N''--删除,''K''--售空，''P''--预售',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `theme_id` varchar(512) DEFAULT NULL COMMENT '主题id（可多个）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多样化价格';

-- --------------------------------------------------------

--
-- 表的结构 `versioning`
--

CREATE TABLE `versioning` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `release_name` varchar(255) NOT NULL DEFAULT 'v0.0.1' COMMENT '版本名称',
  `product_type` varchar(16) NOT NULL DEFAULT 'A' COMMENT '版本类型',
  `download_link` varchar(512) NOT NULL COMMENT '下载链接',
  `admin_user_id` bigint(20) NOT NULL COMMENT '版本发布用户ID',
  `release_desc` varchar(512) NOT NULL COMMENT '版本描述',
  `release_at` timestamp NOT NULL COMMENT '版本发布时间',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `current_version` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否是最新版本',
  `update_req_xml` varchar(512) NOT NULL COMMENT '配置文件',
  `app_store_download_link` varchar(512) DEFAULT NULL COMMENT 'App store 下载链接',
  `release_number` int(11) DEFAULT '1' COMMENT '版本号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='版本';

--
-- 转存表中的数据 `versioning`
--

INSERT INTO `versioning` (`id`, `release_name`, `product_type`, `download_link`, `admin_user_id`, `release_desc`, `release_at`, `file_name`, `current_version`, `update_req_xml`, `app_store_download_link`, `release_number`) VALUES
(512364, '0.1.1', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.1.zip', 418, '更改支付回调', '2016-08-05 12:32:48', 'style-pay-0.1.1.zip', 0, '101010', NULL, 11),
(512377, '0.1.2', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.2.zip', 418, '修改日志通知', '2016-08-05 13:37:04', 'style-pay-0.1.2.zip', 0, '101010', NULL, 12),
(512390, '0.2.3', 'promotion', '/home/deploy/zip/style-promotion/style-promotion-0.2.3.zip', 418, '初始化', '2016-08-05 14:00:00', 'style-promotion-0.2.3.zip', 1, '101010', NULL, 23),
(512403, '0.4.3', 'web', '/home/deploy/zip/style-web/style-web-0.4.3.zip', 256, 'http', '2016-08-05 14:00:05', 'style-web-0.4.3.zip', 0, '101010', NULL, 43),
(512416, '0.3.3', 'services', '/home/deploy/zip/style-services/style-services-0.3.3.zip', 256, 'http', '2016-08-05 14:03:59', 'style-services-0.3.3.zip', 0, '101010', NULL, 33),
(512429, '0.4.4', 'web', '/home/deploy/zip/style-web/style-web-0.4.4.zip', 256, '优惠信息', '2016-08-05 14:14:40', 'style-web-0.4.4.zip', 0, '101010', NULL, 44),
(512442, '2.0.1', 'message', '/home/deploy/zip/style-message/style-message-2.0.1.zip', 418, '初始化版本', '2016-08-05 14:16:12', 'style-message-2.0.1.zip', 0, '101010', NULL, 201),
(512455, '0.3.1', 'id', '/home/deploy/zip/style-id/style-id-0.3.1.zip', 418, '初始化', '2016-08-05 14:19:44', 'style-id-0.3.1.zip', 0, '101010', NULL, 31),
(512468, '0.4.5', 'web', '/home/deploy/zip/style-web/style-web-0.4.5.zip', 256, 'http', '2016-08-05 14:21:36', 'style-web-0.4.5.zip', 0, '101010', NULL, 45),
(512481, '0.4.1', 'shopping', '/home/deploy/zip/style-shopping/style-shopping-0.4.1.zip', 418, '初始化', '2016-08-05 14:35:06', 'style-shopping-0.4.1.zip', 0, '101010', NULL, 41),
(512494, '0.4.2', 'shopping', '/home/deploy/zip/style-shopping/style-shopping-0.4.2.zip', 418, '初始化', '2016-08-05 14:47:27', 'style-shopping-0.4.2.zip', 0, '101010', NULL, 42),
(512507, '0.4.3', 'shopping', '/home/deploy/zip/style-shopping/style-shopping-0.4.3.zip', 256, '43', '2016-08-05 16:12:34', 'style-shopping-0.4.3.zip', 0, '101010', NULL, 43),
(512520, '0.4.6', 'web', '/home/deploy/zip/style-web/style-web-0.4.6.zip', 256, 'web', '2016-08-05 17:21:03', 'style-web-0.4.6.zip', 0, '101010', NULL, 46),
(512533, '1.5.2', 'admin', '/home/deploy/zip/style-admin/style-admin-1.5.2.zip', 418, '商品，主题bug fix', '2016-08-08 10:37:47', 'style-admin-1.5.2.zip', 0, '101010', NULL, 152),
(512546, '0.4.7', 'web', '/home/deploy/zip/style-web/style-web-0.4.7.zip', 256, 'buy', '2016-08-08 11:54:21', 'style-web-0.4.7.zip', 0, '101010', NULL, 47),
(512559, '0.1.3', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.3.zip', 256, '支付只留JD', '2016-08-08 15:16:41', 'style-pay-0.1.3.zip', 0, '101010', NULL, 13),
(512572, '0.3.2', 'id', '/home/deploy/zip/style-id/style-id-0.3.2.zip', 418, '更换短信商', '2016-08-08 15:23:48', 'style-id-0.3.2.zip', 0, '101010', NULL, 32),
(512585, '0.4.4', 'shopping', '/home/deploy/zip/style-shopping/style-shopping-0.4.4.zip', 256, '极光推送参数', '2016-08-08 16:21:43', 'style-shopping-0.4.4.zip', 0, '101010', NULL, 44),
(512598, '0.4.5', 'shopping', '/home/deploy/zip/style-shopping/style-shopping-0.4.5.zip', 256, '推送', '2016-08-08 18:14:31', 'style-shopping-0.4.5.zip', 1, '101010', NULL, 45),
(512611, '0.4.8', 'web', '/home/deploy/zip/style-web/style-web-0.4.8.zip', 256, 'web', '2016-08-08 18:41:17', 'style-web-0.4.8.zip', 0, '101010', NULL, 48),
(512624, '0.3.4', 'id', '/home/deploy/zip/style-id/style-id-0.3.4.zip', 418, '发送短信', '2016-08-09 10:27:39', 'style-id-0.3.4.zip', 0, '101010', NULL, 34),
(512637, '0.4.4', 'pay', '/home/deploy/zip/style-pay/style-pay-0.4.4.zip', 256, '支付菜单', '2016-08-09 11:16:02', 'style-pay-0.4.4.zip', 0, '101010', NULL, 44),
(512650, '0.1.5', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.5.zip', 256, '微信支付参数', '2016-08-09 11:37:06', 'style-pay-0.1.5.zip', 0, '101010', NULL, 15),
(512663, '0.4.9', 'web', '/home/deploy/zip/style-web/style-web-0.4.9.zip', 256, 'web', '2016-08-09 14:39:00', 'style-web-0.4.9.zip', 0, '101010', NULL, 49),
(512676, '0.3.5', 'id', '/home/deploy/zip/style-id/style-id-0.3.5.zip', 418, '修改发送短信', '2016-08-09 15:13:40', 'style-id-0.3.5.zip', 0, '101010', NULL, 35),
(512689, '1.0.0', 'android', 'http://img.hanmimei.com/android/HMM-1.0.0.apk', 265, '【新功能】拼购活动惊喜上线【新视线】全新的主题界面', '2016-08-09 15:46:16', 'HMM-1.0.0.apk', 0, 'http://img.hanmimei.com/android/hmm.xml', NULL, 1),
(512702, '0.1.6', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.6.zip', 256, '菜单', '2016-08-09 16:28:26', 'style-pay-0.1.6.zip', 0, '101010', NULL, 16),
(512715, '1.5.3', 'admin', '/home/deploy/zip/style-admin/style-admin-1.5.3.zip', 418, '修改hmm.xml', '2016-08-09 16:38:03', 'style-admin-1.5.3.zip', 0, '101010', NULL, 153),
(512728, 'v1.0.0-beta', 'android', 'http://img.hanmimei.com/android/KakaoGift-V1.0.0-BETA.apk', 265, '【新功能】   拼购活动惊喜上线【新视线】  全新的主题界面，全新的用户体验', '2016-08-09 16:43:26', 'KakaoGift-V1.0.0-BETA.apk', 0, 'http://img.hanmimei.com/android/kakogift.xml', NULL, 1),
(512741, '1.5.4', 'admin', '/home/deploy/zip/style-admin/style-admin-1.5.4.zip', 418, 'kakaogift', '2016-08-09 17:11:03', 'style-admin-1.5.4.zip', 1, '101010', NULL, 154),
(512754, 'v1.0.0-beta', 'android', 'http://img.hanmimei.com/android/KakaoGift-V1.0.0-BETA.apk', 265, '【新功能】 拼购活动惊喜上线 【新视线】 全新的主题界面，全新的用户体验', '2016-08-09 17:17:58', 'KakaoGift-V1.0.0-BETA.apk', 1, 'http://img.hanmimei.com/android/kakaogift.xml', NULL, 1),
(512767, '0.4.10', 'web', '/home/deploy/zip/style-web/style-web-0.4.10.zip', 256, 'web', '2016-08-09 17:31:25', 'style-web-0.4.10.zip', 0, '101010', NULL, 410),
(512780, '0.4.11', 'web', '/home/deploy/zip/style-web/style-web-0.4.11.zip', 256, '按钮颜色', '2016-08-10 09:46:54', 'style-web-0.4.11.zip', 0, '101010', NULL, 411),
(512793, '0.4.12', 'web', '/home/deploy/zip/style-web/style-web-0.4.12.zip', 256, '微信秘钥', '2016-08-10 09:55:31', 'style-web-0.4.12.zip', 1, '101010', NULL, 412),
(512806, '0.3.6', 'id', '/home/deploy/zip/style-id/style-id-0.3.6.zip', 418, '用户名前缀修改', '2016-08-10 10:10:06', 'style-id-0.3.6.zip', 1, '101010', NULL, 36),
(512819, '0.1.7', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.7.zip', 256, 'jd', '2016-08-10 14:13:37', 'style-pay-0.1.7.zip', 0, '101010', NULL, 17),
(512832, '0.3.3', 'services', '/home/deploy/zip/style-services/style-services-0.3.3.zip', 418, '0.3.3', '2016-08-10 15:00:02', 'style-services-0.3.3.zip', 1, '101010', NULL, 33),
(512845, '0.1.8', 'pay', '/home/deploy/zip/style-pay/style-pay-0.1.8.zip', 418, '0.1.8', '2016-08-10 17:22:47', 'style-pay-0.1.8.zip', 1, '101010', NULL, 18),
(512858, '2.0.2', 'message', '/home/deploy/zip/style-message/style-message-2.0.2.zip', 418, 'ERP订单状态查询', '2016-08-10 17:42:14', 'style-message-2.0.2.zip', 1, '101010', NULL, 202);

-- --------------------------------------------------------

--
-- 表的结构 `weisheng`
--

CREATE TABLE `weisheng` (
  `tracking_id` varchar(128) NOT NULL COMMENT '威盛快递单号',
  `express_no` varchar(128) NOT NULL COMMENT '国内快递单号',
  `or_use` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用过'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='威盛物流单号表';

--
-- 转存表中的数据 `weisheng`
--

INSERT INTO `weisheng` (`tracking_id`, `express_no`, `or_use`) VALUES
('WSE1012507773', '806843734566', 0),
('WSE1012507784', '806843734575', 0),
('WSE1012507795', '806843734585', 0),
('WSE1012507806', '806843734593', 0),
('WSE1012507832', '806843734629', 0),
('WSE1012507843', '806843734633', 0),
('WSE1012507854', '806843734642', 0),
('WSE1012507865', '806843734658', 0),
('WSE1012507876', '806843734664', 0),
('WSE1012507880', '806843734674', 0),
('WSE1012507891', '806843734685', 0),
('WSE1012507902', '806843734696', 0),
('WSE1012509394', '806843734705', 0),
('WSE1012509405', '806843734713', 0),
('WSE1012509416', '806843734722', 0),
('WSE1012509420', '806843734730', 0),
('WSE1012509431', '806843734743', 0),
('WSE1012509442', '806843734758', 0),
('WSE1012509453', '806843734764', 0),
('WSE1012509464', '806843734773', 0),
('WSE1012509475', '806843734787', 0),
('WSE1012509486', '806843734792', 0),
('WSE1012509490', '806843734806', 0),
('WSE1012509501', '806843734816', 0),
('WSE1012509512', '806843734829', 0),
('WSE1012509523', '806843734834', 0),
('WSE1012509534', '806843734844', 0),
('WSE1012509545', '806843734857', 0),
('WSE1012509556', '806843734862', 0),
('WSE1012509560', '806843734872', 0),
('WSE1012509571', '806843734882', 0),
('WSE1012509582', '806843734891', 0),
('WSE1012509593', '806843734909', 0),
('WSE1012509604', '806843734918', 0),
('WSE1012509615', '806843734929', 0),
('WSE1012509626', '806843734931', 0),
('WSE1012509630', '806843734943', 0),
('WSE1012509641', '806843734955', 0),
('WSE1012509652', '806843734966', 0),
('WSE1012509663', '806843734979', 0),
('WSE1012509674', '806843734981', 0),
('WSE1012509685', '806843734990', 0),
('WSE1012509696', '806843735007', 0),
('WSE1012509700', '806843735019', 0),
('WSE1012509711', '806843735022', 0),
('WSE1012509722', '806843735036', 0),
('WSE1012509733', '806843735040', 0),
('WSE1012509744', '806843735052', 0),
('WSE1012509755', '806843735069', 0),
('WSE1012509766', '806843735077', 0),
('WSE1012509770', '806843735080', 0),
('WSE1012509781', '806843735097', 0),
('WSE1012509792', '806843735101', 0),
('WSE1012509803', '806843735112', 0),
('WSE1012509814', '806843735123', 0),
('WSE1012509825', '806843735133', 0),
('WSE1012509836', '806843735147', 0),
('WSE1012509840', '806843735158', 0),
('WSE1012509851', '806843735168', 0),
('WSE1012509862', '806843735178', 0),
('WSE1012509873', '806843735180', 0),
('WSE1012509884', '806843735193', 0),
('WSE1012509895', '806843735201', 0),
('WSE1012509906', '806843735211', 0),
('WSE1012509910', '806843735227', 0),
('WSE1012509921', '806843735233', 0),
('WSE1012509932', '806843735248', 0),
('WSE1012509943', '806843735251', 0),
('WSE1012509954', '806843735268', 0),
('WSE1012509965', '806843735273', 0),
('WSE1012509976', '806843735284', 0),
('WSE1012509980', '806843735298', 0),
('WSE1012509991', '806843735304', 0),
('WSE1012510002', '806843735310', 0),
('WSE1012510013', '806843735326', 0),
('WSE1012510024', '806843735337', 0),
('WSE1012510035', '806843735348', 0),
('WSE1012510046', '806843735354', 0),
('WSE1012510050', '806843735369', 0),
('WSE1012510061', '806843735372', 0),
('WSE1012510072', '806843735386', 0),
('WSE1012510083', '806843735398', 0),
('WSE1012510094', '806843735400', 0),
('WSE1012510105', '806843735414', 0),
('WSE1012510116', '806843735422', 0),
('WSE1012510120', '806843735437', 0),
('WSE1012510131', '806843735443', 0),
('WSE1012510142', '806843735453', 0),
('WSE1012510153', '806843735467', 0),
('WSE1012510164', '806843735473', 0),
('WSE1012510175', '806843735484', 0),
('WSE1012510186', '806843735494', 0),
('WSE1012510190', '806843735506', 0),
('WSE1012510201', '806843735510', 0),
('WSE1012510212', '806843735520', 0),
('WSE1012510223', '806843735538', 0),
('WSE1012510234', '806843735549', 0),
('WSE1012510245', '806843735557', 0),
('WSE1012510256', '806843735560', 0),
('WSE1012510260', '806843735571', 0),
('WSE1012510271', '806843735585', 0),
('WSE1012510282', '806843735591', 0),
('WSE1012510293', '806843735609', 0),
('WSE1012510304', '806843735618', 0),
('WSE1012510315', '806843735628', 0),
('WSE1012510326', '806843735630', 0),
('WSE1012510330', '806843735640', 0),
('WSE1012510341', '806843735659', 0),
('WSE1012510352', '806843735660', 0),
('WSE1012510363', '806843735676', 0),
('WSE1012510374', '806843735680', 0),
('WSE1012510385', '806843735697', 0),
('WSE1012510396', '806843735703', 0),
('WSE1012510400', '806843735711', 0),
('WSE1012510411', '806843735725', 0),
('WSE1012510422', '806843735730', 0),
('WSE1012510433', '806843735747', 0),
('WSE1012510444', '806843735769', 0),
('WSE1012510455', '806843731172', 0),
('WSE1012510466', '806843731185', 0),
('WSE1012510470', '806843731193', 0),
('WSE1012510481', '806843731201', 0),
('WSE1012510492', '806843731213', 0),
('WSE1012510503', '806843731223', 0),
('WSE1012510514', '806843731238', 0),
('WSE1012510525', '806843731248', 0),
('WSE1012510536', '806843731253', 0),
('WSE1012510540', '806843731268', 0),
('WSE1012510551', '806843731278', 0),
('WSE1012507736', '806843734525', 0),
('WSE1012507740', '806843734538', 0),
('WSE1012510562', '806843731281', 0),
('WSE1012507821', '806843734614', 0),
('WSE1012510584', '806843731309', 0),
('WSE1012507762', '806843734556', 1),
('WSE1012510621', '806843731349', 0),
('WSE1012510665', '806843731380', 0),
('WSE1012510702', '806843731426', 0),
('WSE1012510746', '806843731466', 0),
('WSE1012510783', '806843731508', 0),
('WSE1012510820', '806843731545', 0),
('WSE1012507913', '806843731585', 0),
('WSE1012507950', '806843731620', 0),
('WSE1012507994', '806843731667', 0),
('WSE1012508031', '806843731700', 0),
('WSE1012508075', '806843731747', 0),
('WSE1012508112', '806843731788', 0),
('WSE1012508156', '806843731829', 0),
('WSE1012508193', '806843731865', 0),
('WSE1012508230', '806843731904', 0),
('WSE1012508274', '806843731948', 0),
('WSE1012508311', '806843731983', 0),
('WSE1012508355', '806843732025', 0),
('WSE1012508392', '806843732061', 0),
('WSE1012508436', '806843732109', 0),
('WSE1012508473', '806843732141', 0),
('WSE1012508510', '806843732185', 0),
('WSE1012508554', '806843732220', 0),
('WSE1012508591', '806843732265', 0),
('WSE1012508635', '806843732308', 0),
('WSE1012508672', '806843732346', 0),
('WSE1012508716', '806843732381', 0),
('WSE1012508753', '806843732422', 0),
('WSE1012508790', '806843732466', 0),
('WSE1012508834', '806843732505', 0),
('WSE1012508871', '806843732545', 0),
('WSE1012508915', '806843732580', 0),
('WSE1012508952', '806843732621', 0),
('WSE1012508996', '806843732663', 0),
('WSE1012509033', '806843732703', 0),
('WSE1012509070', '806843732744', 0),
('WSE1012509114', '806843732784', 0),
('WSE1012509151', '806843732822', 0),
('WSE1012509195', '806843732863', 0),
('WSE1012509232', '806843732906', 0),
('WSE1012509276', '806843732945', 0),
('WSE1012509313', '806843732980', 0),
('WSE1012510606', '806843731329', 0),
('WSE1012510643', '806843731367', 0),
('WSE1012510680', '806843731401', 0),
('WSE1012510724', '806843731444', 0),
('WSE1012510761', '806843731485', 0),
('WSE1012510805', '806843731528', 0),
('WSE1012510842', '806843731568', 0),
('WSE1012507935', '806843731608', 0),
('WSE1012507972', '806843731644', 0),
('WSE1012508016', '806843731684', 0),
('WSE1012508053', '806843731723', 0),
('WSE1012508090', '806843731763', 0),
('WSE1012508134', '806843731801', 0),
('WSE1012508171', '806843731846', 0),
('WSE1012508215', '806843731883', 0),
('WSE1012508252', '806843731923', 0),
('WSE1012508296', '806843731965', 0),
('WSE1012508333', '806843732007', 0),
('WSE1012508370', '806843732044', 0),
('WSE1012508414', '806843732089', 0),
('WSE1012508451', '806843732125', 0),
('WSE1012508495', '806843732167', 0),
('WSE1012508532', '806843732205', 0),
('WSE1012508576', '806843732247', 0),
('WSE1012508613', '806843732287', 0),
('WSE1012508650', '806843732327', 0),
('WSE1012508694', '806843732366', 0),
('WSE1012508731', '806843732405', 0),
('WSE1012508775', '806843732440', 0),
('WSE1012508812', '806843732483', 0),
('WSE1012508856', '806843732526', 0),
('WSE1012508893', '806843732565', 0),
('WSE1012508930', '806843732601', 0),
('WSE1012508974', '806843732640', 0),
('WSE1012509011', '806843732681', 0),
('WSE1012509055', '806843732729', 0),
('WSE1012509092', '806843732761', 0),
('WSE1012509136', '806843732806', 0),
('WSE1012509173', '806843732847', 0),
('WSE1012509210', '806843732880', 0),
('WSE1012509254', '806843732926', 0),
('WSE1012509291', '806843732966', 0),
('WSE1012509291', '806843732966', 0),
('WSE1012509313', '806843732980', 0),
('WSE1012509335', '806843733009', 0),
('WSE1012509350', '806843733025', 0),
('WSE1012509372', '806843733044', 0),
('WSE1012511170', '806843733069', 0),
('WSE1012511192', '806843733084', 0),
('WSE1012511214', '806843733108', 0),
('WSE1012511236', '806843733128', 0),
('WSE1012511251', '806843733147', 0),
('WSE1012511273', '806843733162', 0),
('WSE1012511295', '806843733189', 0),
('WSE1012511310', '806843733205', 0),
('WSE1012511332', '806843733220', 0),
('WSE1012511354', '806843733242', 0),
('WSE1012511376', '806843733266', 0),
('WSE1012511391', '806843733286', 0),
('WSE1012511413', '806843733301', 0),
('WSE1012511435', '806843733323', 0),
('WSE1012511450', '806843733340', 0),
('WSE1012511472', '806843733360', 0),
('WSE1012511494', '806843733387', 0),
('WSE1012511516', '806843733404', 0),
('WSE1012511531', '806843733421', 0),
('WSE1012511553', '806843733448', 0),
('WSE1012511575', '806843733460', 0),
('WSE1012511590', '806843733483', 0),
('WSE1012511612', '806843733507', 0),
('WSE1012511634', '806843733520', 0),
('WSE1012511656', '806843733549', 0),
('WSE1012511671', '806843733569', 0),
('WSE1012511693', '806843733585', 0),
('WSE1012511715', '806843733603', 0),
('WSE1012511730', '806843733624', 0),
('WSE1012511752', '806843733642', 0),
('WSE1012511774', '806843733663', 0),
('WSE1012511796', '806843733689', 0),
('WSE1012511811', '806843733703', 0),
('WSE1012511833', '806843733729', 0),
('WSE1012511855', '806843733748', 0),
('WSE1012511870', '806843733763', 0),
('WSE1012511892', '806843733783', 0),
('WSE1012511914', '806843733809', 0),
('WSE1012511936', '806843733827', 0),
('WSE1012511951', '806843733847', 0),
('WSE1012511973', '806843733868', 0),
('WSE1012511995', '806843733881', 0),
('WSE1012512010', '806843733901', 0),
('WSE1012512032', '806843733928', 0),
('WSE1012512054', '806843733944', 0),
('WSE1012512076', '806843733968', 0),
('WSE1012512091', '806843733982', 0),
('WSE1012510573', '806843731295', 0),
('WSE1012510595', '806843731314', 0),
('WSE1012510610', '806843731333', 0),
('WSE1012510632', '806843731359', 0),
('WSE1012510654', '806843731375', 0),
('WSE1012510676', '806843731390', 0),
('WSE1012510691', '806843731416', 0),
('WSE1012510713', '806843731434', 0),
('WSE1012510735', '806843731459', 0),
('WSE1012510750', '806843731472', 0),
('WSE1012510772', '806843731492', 0),
('WSE1012510794', '806843731512', 0),
('WSE1012510816', '806843731538', 0),
('WSE1012510831', '806843731551', 0),
('WSE1012510853', '806843731570', 0),
('WSE1012507924', '806843731596', 0),
('WSE1012507946', '806843731615', 0),
('WSE1012507961', '806843731634', 0),
('WSE1012507983', '806843731654', 0),
('WSE1012508005', '806843731675', 0),
('WSE1012508020', '806843731690', 0),
('WSE1012508042', '806843731710', 0),
('WSE1012508064', '806843731737', 0),
('WSE1012508086', '806843731755', 0),
('WSE1012508101', '806843731771', 0),
('WSE1012508123', '806843731796', 0),
('WSE1012508145', '806843731819', 0),
('WSE1012508160', '806843731839', 0),
('WSE1012508182', '806843731852', 0),
('WSE1012508204', '806843731873', 0),
('WSE1012508226', '806843731891', 0),
('WSE1012508241', '806843731910', 0),
('WSE1012508263', '806843731937', 0),
('WSE1012508285', '806843731958', 0),
('WSE1012508300', '806843731978', 0),
('WSE1012508322', '806843731991', 0),
('WSE1012508344', '806843732013', 0),
('WSE1012508366', '806843732038', 0),
('WSE1012508381', '806843732058', 0),
('WSE1012508403', '806843732078', 0),
('WSE1012508425', '806843732096', 0),
('WSE1012508440', '806843732118', 0),
('WSE1012508462', '806843732136', 0),
('WSE1012508506', '806843732170', 0),
('WSE1012508543', '806843732215', 0),
('WSE1012508580', '806843732251', 0),
('WSE1012508624', '806843732290', 0),
('WSE1012508661', '806843732331', 0),
('WSE1012508705', '806843732379', 0),
('WSE1012508742', '806843732416', 0),
('WSE1012508786', '806843732450', 0),
('WSE1012508823', '806843732499', 0),
('WSE1012508860', '806843732538', 0),
('WSE1012508904', '806843732575', 0),
('WSE1012508941', '806843732616', 0),
('WSE1012508985', '806843732653', 0),
('WSE1012509022', '806843732699', 0),
('WSE1012509066', '806843732735', 0),
('WSE1012509103', '806843732774', 0),
('WSE1012509140', '806843732813', 0),
('WSE1012509184', '806843732855', 0),
('WSE1012509221', '806843732896', 0),
('WSE1012509265', '806843732939', 0),
('WSE1012509302', '806843732974', 0),
('WSE1012509346', '806843733017', 0),
('WSE1012509383', '806843733058', 0),
('WSE1012511203', '806843733094', 0),
('WSE1012511240', '806843733139', 0),
('WSE1012511284', '806843733172', 0),
('WSE1012511321', '806843733213', 0),
('WSE1012511365', '806843733254', 0),
('WSE1012511402', '806843733299', 0),
('WSE1012511446', '806843733339', 0),
('WSE1012511483', '806843733376', 0),
('WSE1012511520', '806843733419', 0),
('WSE1012511564', '806843733453', 0),
('WSE1012511601', '806843733497', 0),
('WSE1012511645', '806843733535', 0),
('WSE1012511682', '806843733579', 0),
('WSE1012511726', '806843733612', 0),
('WSE1012511763', '806843733658', 0),
('WSE1012511800', '806843733698', 0),
('WSE1012511844', '806843733734', 0),
('WSE1012511881', '806843733771', 0),
('WSE1012511925', '806843733810', 0),
('WSE1012511962', '806843733851', 0),
('WSE1012512006', '806843733891', 0),
('WSE1012512043', '806843733936', 0),
('WSE1012512080', '806843733972', 0),
('WSE1012512113', '806843734007', 0),
('WSE1012512150', '806843734046', 0),
('WSE1012512194', '806843734084', 0),
('WSE1012512231', '806843734129', 0),
('WSE1012512275', '806843734164', 0),
('WSE1012512312', '806843734207', 0),
('WSE1012512356', '806843734248', 0),
('WSE1012512393', '806843734282', 0),
('WSE1012512430', '806843734329', 0),
('WSE1012512474', '806843734364', 0),
('WSE1012512511', '806843734401', 0),
('WSE1012512555', '806843734444', 0),
('WSE1012512592', '806843734489', 0),
('WSE1012512636', '806843730775', 0),
('WSE1012510886', '806843730819', 0),
('WSE1012510923', '806843730851', 0),
('WSE1012510960', '806843730890', 0),
('WSE1012511004', '806843730933', 0),
('WSE1012511041', '806843730971', 0),
('WSE1012511085', '806843731011', 0),
('WSE1012511122', '806843731050', 0),
('WSE1012511166', '806843731091', 0),
('WSE1012512684', '806843731135', 0),
('WSE1012512124', '806843734011', 0),
('WSE1012512161', '806843734056', 0),
('WSE1012512205', '806843734099', 0),
('WSE1012512242', '806843734138', 0),
('WSE1012512286', '806843734176', 0),
('WSE1012512323', '806843734215', 0),
('WSE1012512360', '806843734255', 0),
('WSE1012512404', '806843734292', 0),
('WSE1012512441', '806843734333', 0),
('WSE1012512485', '806843734370', 0),
('WSE1012512522', '806843734418', 0),
('WSE1012512566', '806843734457', 0),
('WSE1012512603', '806843734492', 0),
('WSE1012512640', '806843730784', 0),
('WSE1012510890', '806843730827', 0),
('WSE1012510934', '806843730867', 0),
('WSE1012510971', '806843730902', 0),
('WSE1012511015', '806843730943', 0),
('WSE1012511052', '806843730981', 0),
('WSE1012511096', '806843731022', 0),
('WSE1012511133', '806843731067', 0),
('WSE1012512651', '806843731107', 0),
('WSE1012512695', '806843731144', 0),
('WSE1012507725', '806843734516', 0),
('WSE1012508484', '806843732153', 0),
('WSE1012508521', '806843732195', 0),
('WSE1012508565', '806843732236', 0),
('WSE1012508602', '806843732277', 0),
('WSE1012508646', '806843732311', 0),
('WSE1012508683', '806843732352', 0),
('WSE1012508720', '806843732395', 0),
('WSE1012508764', '806843732437', 0),
('WSE1012508801', '806843732474', 0),
('WSE1012508845', '806843732514', 0),
('WSE1012508882', '806843732558', 0),
('WSE1012508926', '806843732599', 0),
('WSE1012508963', '806843732634', 0),
('WSE1012509000', '806843732672', 0),
('WSE1012509044', '806843732712', 0),
('WSE1012509081', '806843732750', 0),
('WSE1012509125', '806843732793', 0),
('WSE1012509162', '806843732833', 0),
('WSE1012509206', '806843732870', 0),
('WSE1012509243', '806843732912', 0),
('WSE1012509280', '806843732955', 0),
('WSE1012509324', '806843732990', 0),
('WSE1012509361', '806843733032', 0),
('WSE1012511181', '806843733078', 0),
('WSE1012511225', '806843733114', 0),
('WSE1012511262', '806843733151', 0),
('WSE1012511306', '806843733195', 0),
('WSE1012511343', '806843733238', 0),
('WSE1012511380', '806843733279', 0),
('WSE1012511424', '806843733311', 0),
('WSE1012511461', '806843733354', 0),
('WSE1012511505', '806843733392', 0),
('WSE1012511542', '806843733436', 0),
('WSE1012511586', '806843733477', 0),
('WSE1012511623', '806843733514', 0),
('WSE1012511660', '806843733556', 0),
('WSE1012511704', '806843733594', 0),
('WSE1012511741', '806843733635', 0),
('WSE1012511785', '806843733675', 0),
('WSE1012511822', '806843733714', 0),
('WSE1012511866', '806843733755', 0),
('WSE1012511903', '806843733793', 0),
('WSE1012511940', '806843733830', 0),
('WSE1012511984', '806843733873', 0),
('WSE1012512021', '806843733916', 0),
('WSE1012512065', '806843733953', 0),
('WSE1012512102', '806843733995', 0),
('WSE1012512135', '806843734020', 0),
('WSE1012512172', '806843734064', 0),
('WSE1012512216', '806843734104', 0),
('WSE1012512253', '806843734149', 0),
('WSE1012512290', '806843734188', 0),
('WSE1012512334', '806843734227', 0),
('WSE1012512371', '806843734261', 0),
('WSE1012512415', '806843734302', 0),
('WSE1012512452', '806843734343', 0),
('WSE1012512496', '806843734384', 0),
('WSE1012512533', '806843734427', 0),
('WSE1012512570', '806843734464', 0),
('WSE1012512614', '806843734505', 0),
('WSE1012510864', '806843730790', 0),
('WSE1012510901', '806843730837', 0),
('WSE1012510945', '806843730877', 0),
('WSE1012510982', '806843730913', 0),
('WSE1012511026', '806843730950', 0),
('WSE1012511063', '806843730993', 0),
('WSE1012511100', '806843731034', 0),
('WSE1012511144', '806843731075', 0),
('WSE1012512662', '806843731110', 0),
('WSE1012512706', '806843731157', 0),
('WSE1012512146', '806843734035', 0),
('WSE1012512183', '806843734073', 0),
('WSE1012512220', '806843734118', 0),
('WSE1012512264', '806843734159', 0),
('WSE1012512301', '806843734191', 0),
('WSE1012512345', '806843734234', 0),
('WSE1012512382', '806843734273', 0),
('WSE1012512426', '806843734311', 0),
('WSE1012512463', '806843734355', 0),
('WSE1012512500', '806843734392', 0),
('WSE1012512544', '806843734439', 0),
('WSE1012512581', '806843734478', 0),
('WSE1012512625', '806843730763', 0),
('WSE1012510875', '806843730800', 0),
('WSE1012510912', '806843730846', 0),
('WSE1012510956', '806843730883', 0),
('WSE1012510993', '806843730924', 0),
('WSE1012511030', '806843730964', 0),
('WSE1012511074', '806843731009', 0),
('WSE1012511111', '806843731044', 0),
('WSE1012511155', '806843731080', 0),
('WSE1012512673', '806843731123', 0),
('WSE1012507751', '806843734543', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_id` (`brand_id`);

--
-- Indexes for table `carriage`
--
ALTER TABLE `carriage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `cates`
--
ALTER TABLE `cates`
  ADD PRIMARY KEY (`cate_id`),
  ADD UNIQUE KEY `cate_id` (`cate_id`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `subject_price`
--
ALTER TABLE `subject_price`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `sys_parameter`
--
ALTER TABLE `sys_parameter`
  ADD PRIMARY KEY (`sys_id`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `theme_templates`
--
ALTER TABLE `theme_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `vary_price`
--
ALTER TABLE `vary_price`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `versioning`
--
ALTER TABLE `versioning`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '品牌ID', AUTO_INCREMENT=112031;
--
-- 使用表AUTO_INCREMENT `carriage`
--
ALTER TABLE `carriage`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=523022;
--
-- 使用表AUTO_INCREMENT `cates`
--
ALTER TABLE `cates`
  MODIFY `cate_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '类别ID', AUTO_INCREMENT=130101;
--
-- 使用表AUTO_INCREMENT `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=109100232;
--
-- 使用表AUTO_INCREMENT `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品ID', AUTO_INCREMENT=888289;
--
-- 使用表AUTO_INCREMENT `slider`
--
ALTER TABLE `slider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=20010;
--
-- 使用表AUTO_INCREMENT `subject_price`
--
ALTER TABLE `subject_price`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=31109099;
--
-- 使用表AUTO_INCREMENT `sys_parameter`
--
ALTER TABLE `sys_parameter`
  MODIFY `sys_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=500180;
--
-- 使用表AUTO_INCREMENT `themes`
--
ALTER TABLE `themes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=601012;
--
-- 使用表AUTO_INCREMENT `theme_templates`
--
ALTER TABLE `theme_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300301;
--
-- 使用表AUTO_INCREMENT `vary_price`
--
ALTER TABLE `vary_price`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=61110111;
--
-- 使用表AUTO_INCREMENT `versioning`
--
ALTER TABLE `versioning`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=512859;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
