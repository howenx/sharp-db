------------------------------------商品表 --------------------------------------------
--	id														主键
--	lang 													cn/kr/en
--	ciq_code   												海关编码		
--  item_id   												商品ID           
--  cate_id    												类别ID 
--  band_id    												品牌ID
--  cate_nm    												类别名称 
--  band_nm    												品牌名称    
--  item_name  												商品名称
--  item_title  											商品标题
--	bar_code												商品条形码
--	bar_des      											商品条形码描述信息
--  item_des     											商品详细信息    
--  merch_uid   											供货商用户id       
--  src_area  												原产地
--	on_shelves_at											上架时间,
--	off_shelves_at											下架时间,    
--	item_img												代表商品图片		
--	item_preview_imgs 										商品预览图片， json串
--	item_detail_imgs 										详细商品图片，json串
--	item_feature  											商品属性信息  存json串
--	is_join_theme  											是否加入主题
--	theme_id  												主题ID
--	is_major_item  											是否为主宣传商品
--	state   												商品状态 'Y'--正常,'D'--到期商品,'N'--删除,'K'--售空
--	is_destory												删除标记
--	is_free_ship  											是否包邮,
--	has_invoice  											是否有发票	,
--	has_vat_invoice  										是否有增值税发票
--	delivery_area  											发货地区 海外直发｜保税区仓库直发,
--	delivery_time  											配送时间 预计多少工作日到达,
--	is_restrict_buy 										是否限购,
--	restrict_amount 										限购数量,
--	item_url 												商品详细页面url,
--	is_shopping_poll 										是否支持拼购,
--	is_share												是否支持分享,
--	share_key 												分享商品key,
--	share_img												分享商品图片
--	share_url 												分享商品url
--	share_count 											商品被分享次数
--	like_count 												商品被点赞次数
--	collect_count 											商品被收藏次数
--	browse_count 											商品被浏览次数
--	item_notice 											有关此商品的重要通告
--  trans_uid    											翻译人员ID
--	trans_at     											翻译日期,
--	trans_lang     											翻译语言,存储成为 kr->cn,en->cn
--	create_uid    											最后更新操作用户,
--	update_uid    											最后更新操作用户,
--	create_at     											创建日期,
--	update_at     											更新日期

--	id														商品ID
--	ciq_code  												海关编码,
--	lang 													语言,
--	cate_id    												类别ID,
--	brand_id    											品牌ID,
--	cate_nm    												类别名称,
--	brand_nm    											品牌名称,
--	item_nm  												商品名称,
--	item_title												商品标题,
--	item_desc    											商品描述,
--	bar_code  												条形码,
--	bar_des  												条码描述,
--	merch_uid  												供应商ID,
--	src_area  												源产地,
--	on_shelves_at											上架时间,
--	off_shelves_at											下架时间,
--	item_master_img											商品主图,		
--	item_preview_imgs 										预览图 json串
--	item_detail_imgs 										商品详细信息图片
--	item_features  											商品属性 json串 name value
--	is_join_theme  											是否加入主题
--	theme_id  												现在加入的主题ID
--	is_major_item  											是否是主题代表商品
--	state    												状态	'Y'--正常,'D'--到期商品,'N'--删除,'K'--售空
--	is_free_ship  											是否包邮
--	has_invoice  											是否提供发票
--	has_vat_invoice  										是否提供增值税发票
--	delivery_area  											发货地
--	delivery_time  											可发货时间
--	is_restrict_buy 										是否限购,
--	restrict_amount 										限购数量,
--	item_url												商品URL,
--	is_shopping_poll 										是否参加拼购,
--	is_share 												是否可以分享,
--	share_key 												分享token,
--	share_img 												分享至好友的商品图片,
--	share_url 												分享至好友的链接,
--	share_count 											被分享次数,
--	like_count 												被点赞次数,
--	collect_count 											被收藏次数,
--	browse_count 											被浏览次数,
--	item_notice 											商品重要布告,
--	trans_uid												翻译人员id,
--	trans_at     											翻译时间,
--	trans_lang     											翻译至何种语言,kr->cn
--	is_destory    											是否删除,
--	destory_uid   											删除操作用户ID,
--	destory_at												删除时间,
--	update_at    											更新时间
--	update_uid    											更新操作用户ID,
--	create_at     											创建时间,
--	create_uid    											创建操作用户ID,

CREATE TABLE items (	
	id							bigserial   				not null,
	ciq_code  					bigint 						not null,
	lang 						CHARACTER VARYING (255)		,
   	cate_id    					bigint						,
   	brand_id    					bigint						,
	cate_nm    					CHARACTER VARYING (255) 	,
	brand_nm    					CHARACTER VARYING (255) 	,
   	item_nm  					CHARACTER VARYING (255) 	not null,
	item_title					CHARACTER VARYING (255) 	,
   	item_desc    				text						,
	bar_code  					CHARACTER VARYING (255)  	DEFAULT ''::CHARACTER VARYING,
	bar_des  					CHARACTER VARYING (512)  	DEFAULT ''::CHARACTER VARYING,
   	merch_uid  					bigint						not null,
   	src_area  					CHARACTER VARYING (255)		,
   	on_shelves_at				timestamp (6) 				WITHOUT TIME ZONE,
	off_shelves_at				timestamp (6) 				WITHOUT TIME ZONE,
	item_master_img				CHARACTER VARYING (512) 	not null,		
	item_preview_imgs 			text						,
	item_detail_imgs 			text						,
	item_features  				text						,
	is_join_theme  				BOOLEAN						DEFAULT FALSE,
	theme_id  					bigint						,
	is_major_item  				BOOLEAN						DEFAULT FALSE,
	state    					CHARACTER VARYING (255)		,
	is_free_ship  				BOOLEAN						DEFAULT TRUE,
	has_invoice  				BOOLEAN						DEFAULT FALSE,
	has_vat_invoice  			BOOLEAN						DEFAULT FALSE,
	delivery_area  				CHARACTER VARYING (255)  	DEFAULT ''::CHARACTER VARYING,
	delivery_time  				CHARACTER VARYING (255)  	DEFAULT ''::CHARACTER VARYING,
	is_restrict_buy 			BOOLEAN						DEFAULT FALSE,
	restrict_amount 			INTEGER						,
	item_url					CHARACTER VARYING (255)  	,
	is_shopping_poll 			BOOLEAN						DEFAULT FALSE,
	is_share 					BOOLEAN						DEFAULT FALSE,
	share_key 					CHARACTER VARYING (255)		,
	share_img 					CHARACTER VARYING (255)		,
	share_url 					CHARACTER VARYING (255)		,
	share_count 				INTEGER						,
	like_count 					INTEGER						,
	collect_count 				INTEGER						,
	browse_count 				INTEGER						,
	item_notice 				CHARACTER VARYING (512)		,
	trans_uid					bigint						,
	trans_at     				timestamp (6) 				WITHOUT TIME ZONE,
	trans_lang     				CHARACTER VARYING (512)  	,
	is_destory    				BOOLEAN						DEFAULT FALSE,
	destory_uid   				bigint						,
	destory_at					timestamp (6) 				WITHOUT TIME ZONE,
	update_at    				timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    				bigint						,
	create_at     				timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    				bigint						,
	constraint PK_items primary key (id)
);

------------------------------------商品库存表 sku--------------------------------------------
--	id														主键
--  item_id   												商品ID           
--  item_colors    											颜色 
--  item_size    											尺寸  
--  amount   												库存数量 
--  item_src_price   										成本价     
--  item_curr_price   										销售价
--  sold_amount   											卖出数量
--  is_sold_out   											是否售空
--  rest_amount   											余量
--  inv_url  												sku链接
--	inv_img													sku主图
--  item_preview_imgs										预览图 json串   													   
CREATE TABLE inventories (
	id         												bigserial           		not null,
	item_id 												bigint						not null,
	item_color  											CHARACTER VARYING (255) 	,
	item_size  												CHARACTER VARYING (255) 	,
	amount   												INTEGER						DEFAULT 0,
	item_src_price   										numeric (10, 2)				,
   	item_curr_price   										numeric (10, 2)				,
	sold_amount   											INTEGER						DEFAULT 0,
	rest_amount   											INTEGER						DEFAULT 0,
	is_sold_out												BOOLEAN						DEFAULT FALSE,
	inv_url 												CHARACTER VARYING (255) 	,
	inv_img 												CHARACTER VARYING (255) 	,
	item_preview_imgs 										text						,
	constraint PK_inventories primary key (id)
);

------------------------------------主题表 --------------------------------------------
--	id														主键
--  mater_item_id   										主题主宣传商品ID
--  title    												标题 
--  theme_desc   											主题描述   
--  start_at    											主题开始时间  
--  end_at   												主题结束时间
--  item_price_top   										主题包含商品最高价格
--  item_price_low   										主题包含商品最低价格
--  theme_img   											主题图片
--  theme_url   											主题列表url
--  item_count   											主题包含商品数量
--  theme_tags												主题主图标签json串 name,angle,top,left
--  theme_tag_count   										主题图片标签数
--  sort_nu													排序编号
--	is_destory    											是否删除,
--	destory_uid   											删除操作用户id,
--	update_at    											更新时间,
--	update_uid    											更新操作用户id,
--	create_at     											创建时间
--	create_uid    											创建操作用户id, 													   
CREATE TABLE themes (
	id         												bigserial           		not null,
	mater_item_id 											bigint						not null,
	title  													CHARACTER VARYING (255) 	,
	theme_desc  											CHARACTER VARYING (255) 	,
	start_at     											timestamp (6) 				WITHOUT TIME ZONE,
	end_at     												timestamp (6) 				WITHOUT TIME ZONE,
	item_price_top   										numeric (10, 2)				,
   	item_price_low   										numeric (10, 2)				,
	theme_img												CHARACTER VARYING (255) 	,
	theme_url												CHARACTER VARYING (255) 	,
	theme_tags												CHARACTER VARYING (512) 	,
	item_count												integer						,
	theme_tag_count											integer						,
	sort_nu													integer 					,
	is_destory    											BOOLEAN						DEFAULT FALSE,
	destory_uid   											bigint						,
	destory_at												timestamp (6) 				WITHOUT TIME ZONE,
	update_at    											timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    											bigint						,
	create_at     											timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    											bigint						,
	constraint PK_themes primary key (id)
);

------------------------------------主题信息表 --------------------------------------------
--	id														主键
--  theme_id   												主题ID  
--  item_id   												商品ID 
--  item_img   												商品图片
--  item_url   												商品url
--  item_price   											商品价格
--  item_sold_amount   										商品销量
--  like_count   											商品点赞数
--  collect_count   										商品收藏数	
--  sort_nu   												商品排序
--	is_destory    											是否删除,
--	destory_uid   											删除操作用户id,
--	update_at    											更新时间,
--	update_uid    											更新操作用户id,
--	create_at     											创建时间
--	create_uid    											创建操作用户id															   
CREATE TABLE theme_item (
	id         												bigserial           		not null,
	theme_id 												bigint						not null,
	item_id  												bigint						not null,
	item_img  												CHARACTER VARYING (255) 	,
	item_url  												CHARACTER VARYING (255) 	,
	item_price  											numeric (10, 2)				,
	item_sold_amount  										integer 					,
	like_count												integer 					,
	collect_count											integer 					,
	sort_nu													integer 					,
	is_destory    											BOOLEAN						DEFAULT FALSE,
	destory_uid   											bigint						,
	destory_at												timestamp (6) 				WITHOUT TIME ZONE,
	update_at    											timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    											bigint						,
	create_at     											timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    											bigint						,
	constraint PK_theme_item primary key (id)
);

-------------------------------------客户入库商品信息表 --------------------------------------
--	id														主键
--	merch_uid  												客户id
--	merch_nm  												客户名称
--	prod_id  												产品id,
--	lang 													语言cn/en/kr,
--	cate_id    												类别,
--	cate_nm    												类别名称,
--	brand_id    											品牌id,
--	brand_nm    											品牌名称,
--	prod_nm  												产品名称,
--	prod_color  											产品颜色,
--	prod_size  												产品尺寸,
--	prod_desc    											产品描述,
--	src_area  												源产地,
--	sell_on_at     											可售日期,
--	sell_off_at     										截止日期,
--	prod_amount   											数量,
--	prod_price   											价格,
--	recom_price												建议售价,
--	prod_img												产品主图片,		
--	prod_preview_imgs 										产品预览图片,json串
--	prod_detail_imgs 										产品详细图片,json串
--	prod_features  											产品属性,
--	update_at    											最后更新日期,
--	update_uid    											最后更新操作用户,
--	create_at     											创建日期,
--	create_uid     											创建日期,
--	state    												商品状态 'Y'--正常,'D'--到期商品,'N'--删除,'K'--售空
--	is_destory												删除标记
--	destory_uid												删除用户

CREATE TABLE prods (	
	id							bigserial   				not null,
	merch_uid  					bigint						not null,
	merch_nm  					CHARACTER VARYING (255)  	DEFAULT ''::CHARACTER VARYING,
   	prod_id  					bigint 						not null,
	lang 						CHARACTER VARYING (255)		,
   	cate_id    					bigint 						not null,
	cate_nm    					CHARACTER VARYING (255)		not null,
	brand_id    				bigint 						not null,
	brand_nm    				CHARACTER VARYING (255)		not null,
   	prod_nm  					CHARACTER VARYING (512) 	not null,
	prod_color  				CHARACTER VARYING (128) 	not null,
	prod_size  					CHARACTER VARYING (128) 	not null,
   	prod_desc    				text						,
   	store_area   				CHARACTER VARYING (128)		,
   	src_area  					CHARACTER VARYING (128)		,
   	sell_on_at     				timestamp (6) 				WITHOUT TIME ZONE,
   	sell_off_at     			timestamp (6) 				WITHOUT TIME ZONE,
   	prod_amount   				integer						DEFAULT 0,
   	prod_price   				numeric (10, 2)				,
	recommend_price				numeric (10, 2)				,
	prod_master_img				CHARACTER VARYING (512) 	not null,		
	prod_preview_imgs 			text						,
	prod_detail_imgs 			text						,
	prod_features  				text						,
	state    					CHARACTER VARYING (512)		,
	is_destory    				BOOLEAN						DEFAULT FALSE,
	destory_uid   				bigint						,
	destory_at					timestamp (6) 				WITHOUT TIME ZONE,
	update_at    				timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    				bigint						,
	create_at     				timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    				bigint						,
	constraint PK_prods primary key (id)
);

------------------------------------客户入库库存表 --------------------------------------------
--	id														主键
--  prod_id   												商品ID           
--  prod_colors    											颜色 
--  prod_size    											尺寸  
--  amount   												库存数量 
--  prod_price   											价格   
--  recommend_price   										建议销售价
--  prod_preview_imgs										预览图 json串   													   
CREATE TABLE stock (
	id         												bigserial           		not null,
	prod_id 												bigint						not null,
	prod_colors  											CHARACTER VARYING (255) 	,
	prod_size  												CHARACTER VARYING (255) 	,
	amount   												INTEGER						DEFAULT 0,
	prod_price   											numeric (10, 2)				,
   	recommend_price   										numeric (10, 2)				,
	prod_preview_imgs 										text						,
	constraint PK_stock primary key (id)
);

-------------------------------------拼购表 --------------------------------------
--	id														主键,
--	item_id 												拼购商品id,
--	token			 										拼购分享key,
--	poll_img 												拼购商品图片
--	poll_url 												拼购商品url
--	poll_allow_count 										拼购允许的购买数量,
--	poll_allow_users_count 									拼购允许的用户数,
--	poll_break_price 										拼购减价,
--	poll_price 												拼购价,
--	poll_delivery_time 										拼购预计配送时间,
--	poll_start 												拼购开始时间,
--	poll_end 												拼购结束时间,

CREATE TABLE shopping_poll (	
	id         												bigserial           		not null,
	item_id 												bigint						not null,
	token 													CHARACTER VARYING (255)		,
	poll_img 												CHARACTER VARYING (512)		,
	poll_url 												CHARACTER VARYING (255)		,
	poll_allow_count 										integer						DEFAULT 0,
	poll_allow_users_count 									integer						DEFAULT 0,
	poll_break_price 										numeric (10, 2)				,
	poll_price 												numeric (10, 2)				,
	poll_delivery_time 										CHARACTER VARYING (255)  	,
	poll_on_at 												timestamp (6) 				WITHOUT TIME ZONE,
	poll_off_at 											timestamp (6) 				WITHOUT TIME ZONE,
	constraint PK_shopping_poll primary key (id)
);
-------------------------------------Admin用户表--------------------------------------
--	uid         								主键,
--	email										邮件,
--	tell										电话,
--	authentication_token         				用户token,
--	encrypted_password							密码,
--	uname   									用户名,
--	"name"										姓名,
--	role_nm										角色名,
--	face_img        							头像,
--	state										状态 'Active' 正常，'Lock' 锁住，'Destory' 注销,
--	confirmation_token           				邮箱确认token,
--	confirmed_at                 				用户确认时间,
--	confirmation_sent_at         				确认token邮件发送时间
--	sign_count      							登录次数,
--	failed_attempts              				尝试错误密码次数,
--	is_locked	   								是否锁住,
--	locked_at	   								锁住时间,
--	last_sign_at  								上次登录时间,
--	last_sign_ip    							上次登录ip
--	current_sign_at  							现在登录时间,
--	current_sign_ip    							现在登录IP
--	is_destory    								用户是否注销,
--	destory_uid   								注销操作用户id,
--	update_at    								更新时间,
--	update_uid    								更新操作用户id,
--	create_at     								创建时间
--	create_uid    								创建操作用户id,

CREATE TABLE users (
   	uid         								bigserial          			not null,
   	email										CHARACTER VARYING (255)  	not null,
   	tell										CHARACTER VARYING (255)		,
	authentication_token         				CHARACTER VARYING (255)		,
   	encrypted_password							CHARACTER VARYING (255)  	not null,
   	uname   									CHARACTER VARYING (255)  	not null,
  	"name"										CHARACTER VARYING (255)  	,
   	role_nm										CHARACTER VARYING (255)  	,
   	face_img        							CHARACTER VARYING (255)  	DEFAULT 'Active',
   	state										CHARACTER VARYING (255)  	,
	confirmation_token           				CHARACTER VARYING (255)		,
   	confirmed_at                 				timestamp (6) 				WITHOUT TIME ZONE,
   	confirmation_sent_at         				timestamp (6) 				WITHOUT TIME ZONE,
   	sign_count      							INTEGER						DEFAULT 0,
	failed_attempts              				INTEGER 					DEFAULT 0,
   	is_locked	   								BOOLEAN						DEFAULT FALSE,
   	locked_at	   								timestamp (6) 				WITHOUT TIME ZONE,
	last_sign_at  								timestamp (6) 				WITHOUT TIME ZONE,
   	last_sign_ip    							CHARACTER VARYING (255)  	,
	current_sign_at  							timestamp (6) 				WITHOUT TIME ZONE,
   	current_sign_ip    							CHARACTER VARYING (255)  	,
   	is_destory    								BOOLEAN						DEFAULT FALSE,
   	destory_uid   								bigint						,
	destory_at									timestamp (6) 				WITHOUT TIME ZONE,
	update_at    								timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    								bigint						,
	create_at     								timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    								bigint						,
   	constraint PK_users primary key (uid)
);

-------------------------------------用户表--------------------------------------
--	mid         								用户id,
--	email										邮箱,
--	tell										电话,
--	encrypted_password							加密密码,
--	encrypted_idcard							加密身份证号码,
--	authentication_token         				用户token,
--	mname   									用户名,
--	"name"										姓名,
--	face_img        							头像,
--	state										状态 'Active' 正常，'Lock' 锁住，'Destory' 注销,
--	sign_count      							登录次数,
--	failed_attempts              				尝试错误密码次数,
--	is_locked	   								是否锁住,
--	locked_at	   								锁住时间,
--	last_sign_at  								上一次登录时间,
--	last_sign_ip    							上一次用户登录ip,
--	current_sign_at  							现在用户登录时间,
--	current_sign_ip    							现在用户登录IP,
--	is_destory    								是否注销,
--	destory_uid   								注销操作用户id,
--	update_at    								更新时间,
--	update_uid    								更新操作用户ID,
--	create_at     								创建时间,
--	create_uid    								创建操作用户ID,

CREATE TABLE members (
   	mid         								bigserial           		not null,
   	email										CHARACTER VARYING (255)		,
   	tell										CHARACTER VARYING (255)  	,
   	encrypted_password							CHARACTER VARYING (255)  	not null,
	encrypted_idcard							CHARACTER VARYING (255)		,
	authentication_token         				CHARACTER VARYING (255)		,
   	mname   									CHARACTER VARYING (255)  	not null,
   	"name"										CHARACTER VARYING (255)		,
   	face_img        							CHARACTER VARYING (255)  	,
   	state										CHARACTER VARYING (255)  	DEFAULT 'Active',
   	sign_count      							INTEGER						DEFAULT 0,
	failed_attempts              				INTEGER 					DEFAULT 0,
   	is_locked	   								BOOLEAN						DEFAULT FALSE,
   	locked_at	   								timestamp (6) 				WITHOUT TIME ZONE,
	last_sign_at  								timestamp (6) 				WITHOUT TIME ZONE,
   	last_sign_ip    							CHARACTER VARYING (255)  	,
	current_sign_at  							timestamp (6) 				WITHOUT TIME ZONE,
   	current_sign_ip    							CHARACTER VARYING (255)  	,
   	is_destory    								BOOLEAN						DEFAULT FALSE,
   	destory_uid   								bigint						,
	destory_at									timestamp (6) 				WITHOUT TIME ZONE,
	update_at    								timestamp (6) 				WITHOUT TIME ZONE,
	update_uid    								bigint						,
	create_at     								timestamp (6) 				WITHOUT TIME ZONE,
	create_uid    								bigint						,
   	constraint PK_members primary key (mid)
);

-------------------------------------用户配送地址表--------------------------------------
--	id         									主键,
--	mid         								用户ID,
--	is_default         							是否默认地址,
--	tel											手机号码
--	name										收货人
--	delivery_city								配送省份，城市，区县
--	delivery_detail								配送详细地址
--	is_destory    								是否删除,
--	destory_mid   								删除操作用户id,
--	update_at    								更新时间,
--	update_mid    								更新操作用户ID,
--	create_at     								创建时间,
--	create_mid    								创建操作用户ID

CREATE TABLE address (
   id         									bigserial           		not null,
   mid   										bigint						,
   is_default   								BOOLEAN						DEFAULT FALSE,
   tel   										CHARACTER VARYING (255)  	,
   "name"         								CHARACTER VARYING (255)  	,
   delivery_city								CHARACTER VARYING (255)  	,
   delivery_detail								CHARACTER VARYING (512)  	,
   is_destory   								BOOLEAN						DEFAULT FALSE,
   destory_mid   								bigint						,
   destory_at									timestamp (6) 				WITHOUT TIME ZONE,
   update_at    								timestamp (6) 				WITHOUT TIME ZONE,
   update_mid    								bigint						,
   create_at     								timestamp (6) 				WITHOUT TIME ZONE,
   create_mid    								bigint						,
   constraint PK_address primary key (id)
);
-------------------------------------优惠券表-----------------------
--	id         									主键
--	mid         								用户ID
--	must_cost         							需要满足的面值
--	reduce_cost         						减少的金额

CREATE TABLE coupons (
   id         									bigserial           		not null,
   mid   										bigint						,
   must_cost 									numeric (10, 2)				,
   reduce_cost 									numeric (10, 2)				,
   is_destory   								BOOLEAN						DEFAULT FALSE,
   destory_mid   								bigint						,
   destory_at									timestamp (6) 				WITHOUT TIME ZONE,
   update_at    								timestamp (6) 				WITHOUT TIME ZONE,
   update_mid    								bigint						,
   create_at     								timestamp (6) 				WITHOUT TIME ZONE,
   create_mid    								bigint						,
   constraint PK_coupons primary key (id)
);
-------------------------------------订单表---------删除时进行物理删除，有相应的历史表，将删除的数据拷贝到历史表---------------
--	id         									主键,
--	mid         								用户ID,
--	address_id									收货地址
--	receive_time_code							收货时间 code
--	payment_code								支付方式 code
--	place_order_method							下单方式 code 1.手机，2.web，3，分享，4，拼购
--	coupons_id									优惠券id
--	state    									订单状态,code 1001未支付，1002已支付，1003待发货，1004待收货，1005已完成，1006已取消，1007已删除,1008,支付失败
--	submit_at									提交订单时间
--	payment_at									支付时间
--	deliver_at									发货时间
--	receive_at									收货时间
--	complete_at									已完成时间
--	cacel_at									已取消时间
--	delete_at									已删除时间
--	pay_error_at								支付失败时间
--	order_desc									备注
--	order_item_count							商品数量
--	order_amount								订单金额
--	charges_amount								邮费
--	share_amount								分享减价金额
--	polling_amount								拼购减价金额
--	discount_amount								总共优惠金额
--	paid_amount									实际付款金额
--	save_amount									已节省金额
--	is_destory    								是否删除
--	destory_mid   								删除操作用户id,
--	update_at    								更新时间,
--	update_mid    								更新操作用户ID,
--	create_at     								创建时间,
--	create_mid    								创建操作用户ID

CREATE TABLE orders (
   id         									bigserial           		not null,
   mid   										bigint						not null,
   address_id        							bigint						not null,
   receive_time_code							CHARACTER VARYING (255)  	,
   payment_code									CHARACTER VARYING (128)  	,
   place_order_method							CHARACTER VARYING (128)  	,
   coupons_id									bigint						,
   state										bigint						not null,
   submit_at									timestamp (6) 				WITHOUT TIME ZONE,
   payment_at									timestamp (6) 				WITHOUT TIME ZONE,
   deliver_at									timestamp (6) 				WITHOUT TIME ZONE,
   receive_at									timestamp (6) 				WITHOUT TIME ZONE,
   complete_at									timestamp (6) 				WITHOUT TIME ZONE,
   cacel_at										timestamp (6) 				WITHOUT TIME ZONE,
   delete_at									timestamp (6) 				WITHOUT TIME ZONE,
   pay_error_at									timestamp (6) 				WITHOUT TIME ZONE,
   order_desc									CHARACTER VARYING (512)  	,
   order_item_count								integer						not null,
   order_amount									numeric (10, 2)				not null,
   charges_amount								numeric (10, 2)				,
   share_amount									numeric (10, 2)				,
   polling_amount								numeric (10, 2)				,
   discount_amount								numeric (10, 2)				,
   paid_amount									numeric (10, 2)				not null,
   save_amount									numeric (10, 2)				not null,
   is_destory   								BOOLEAN						DEFAULT FALSE,
   destory_mid   								bigint						,
   destory_at									timestamp (6) 				WITHOUT TIME ZONE,
   update_at    								timestamp (6) 				WITHOUT TIME ZONE,
   update_mid    								bigint						,
   create_at     								timestamp (6) 				WITHOUT TIME ZONE,
   create_mid    								bigint						,
   constraint PK_orders primary key (id)
);

-------------------------------------订单信息表--------------------------------------
--	id         									主键,
--	oid         								订单ID,
--	mid         								用户ID,
--	item_id         							商品ID,
--	inv_id										库存ID
--	item_count									商品数量
--	price										商品价格
--	order_price									下单商品价格
--	is_destory    								是否删除
--	destory_mid   								删除操作用户id,
--	update_at    								更新时间,
--	update_mid    								更新操作用户ID,
--	create_at     								创建时间,
--	create_mid    								创建操作用户ID

CREATE TABLE order_item (
   id         									bigserial           		not null,
   oid   										bigint						not null,
   mid   										bigint						not null,
   item_id   									bigint						not null,
   inv_id   									bigint						not null,
   item_count									integer						not null,
   price										numeric (10, 2)				not null,
   order_price									numeric (10, 2)				not null,
   is_destory   								BOOLEAN						DEFAULT FALSE,
   destory_mid   								bigint						,
   destory_at									timestamp (6) 				WITHOUT TIME ZONE,
   update_at    								timestamp (6) 				WITHOUT TIME ZONE,
   update_mid    								bigint						,
   create_at     								timestamp (6) 				WITHOUT TIME ZONE,
   create_mid    								bigint						,
   constraint PK_order_item primary key (id)
);

-------------------------------------购物车表--------------------------------------
--	id         									主键,
--	mid         								用户ID,
--	item_id         							商品ID,
--	inv_id										库存ID
--	cart_count									购买数量
--	cart_price									购买价格
--	item_price									商品价格
--	inv_img										sku主图
--	item_url									商品url
--	cart_at										加入购物车时间
--	is_destory    								是否删除
--	destory_mid   								删除操作用户id,
--	destory_at   								删除时间,
--	update_at    								更新时间,
--	update_mid    								更新操作用户ID,
--	create_at     								创建时间,
--	create_mid    								创建操作用户ID

CREATE TABLE carts (
   id         									bigserial           		not null,
   mid   										bigint						not null,
   item_id   									bigint						not null,
   inv_id   									bigint						not null,
   cart_count									integer						not null,
   cart_price									numeric (10, 2)				not null,
   item_price									numeric (10, 2)				not null,
   inv_img										CHARACTER VARYING (512)  	,
   item_url										CHARACTER VARYING (512)  	,
   cart_at										timestamp (6) 				WITHOUT TIME ZONE,
   is_destory   								BOOLEAN						DEFAULT FALSE,
   destory_mid   								bigint						,
   destory_at									timestamp (6) 				WITHOUT TIME ZONE,
   update_at    								timestamp (6) 				WITHOUT TIME ZONE,
   update_mid    								bigint						,
   create_at     								timestamp (6) 				WITHOUT TIME ZONE,
   create_mid    								bigint						,
   constraint PK_carts primary key (id)
);
-------------------------------------品牌表--------------------------------------
CREATE TABLE brands (
   brand_id         bigserial           not null,
   desc_cn   		text				null,
   desc_en   		text				null,
   desc_kr   		text				null,
   logo_url         VARCHAR(500)		null,
   home_page        text				null,
   create_date      date				null,
   brand_nm_cn      VARCHAR(200)		null,
   brand_nm_en      VARCHAR(200)		null,
   brand_nm_kr      VARCHAR(200)		null,
   constraint PK_brands primary key (brand_id)
);

-------------------------------------类目表--------------------------------------
CREATE TABLE cates (
   cate_id          bigserial           	not null,
   pcate_id   		bigint					null,
   cate_nm_cn     	VARCHAR(500)			null,
   cate_nm_en     	VARCHAR(500)			null,
   cate_nm_kr     	VARCHAR(500)			null,
   cate_desc     	VARCHAR(500)			null,
   constraint PK_cates primary key (cate_id)
);

-------------------------------------码表------------------------------------
---------支付方式，收货时间，下单方式，订单状态---------
CREATE TABLE codes (
   cid          	bigserial           		not null,
   pcid  			bigint						,
   code  			CHARACTER VARYING (512)  	,
   value	     	CHARACTER VARYING (512)  	,
   value_cn     	CHARACTER VARYING (512)  	,
   value_en     	CHARACTER VARYING (512)  	,
   value_kr     	CHARACTER VARYING (512)  	,
   code_desc     	CHARACTER VARYING (512)  	,
   constraint PK_codes primary key (cid)
);
