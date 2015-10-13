--	seq_id						自增ID
--	lang 						cn/kr/en
--	ciq_code   					海关编码		
--  item_id   					商品ID           
--  cate_id    					商品类别 
--  band_id    					品牌  
--  item_colors    				颜色 
--  item_size    				尺寸  
--  item_name  					商品名称
--	bar_code					商品条形码      
--  item_des     				商品详细信息    
--  merch_id   					供货商用户id       
--  store_area  				出库地    
--  src_area  					原产地  
--  up_date       				商品销售期限-开始日期   
--  down_date     				商品销售期限-结束日期    
--  item_amount   				库存数量 
--  item_price   				成本价     
--  item_sell_price   			销售价   
--	item_pic					代表商品图片		
--	item_prev_pics 				商品预览图片， json串
--	item_detail_pics 			详细商品图片，json串
--	item_feature  				商品属性信息  存json串
--  trans_user    				翻译人员ID
--	trans_date     				翻译日期,
--	trans_lang     				翻译语言,存储成为 kr->cn,en->cn
--	last_update_date    		最后更新日期,
--	last_update_user    		最后更新操作用户,
--	create_date     			创建日期,
--	item_status    				商品状态 'Y'--正常,'D'--到期商品,'N'--删除,'K'--售空
------商品库 -----------
CREATE TABLE items (	
	sid					bigserial   				not null,
   	item_id  			bigint 						not null,
	ciq_code  			bigint 						not null,
	lang 				CHARACTER (2) 				not null,
   	cate_id    			bigint 						not null,
   	band_id    			bigint 						not null,
   	item_nm  			VARCHAR (500) 	not null,
	item_color  		VARCHAR (100) 	not null,
	item_size  			VARCHAR (100) 	not null,
   	item_desc    		text,
	bar_code  			VARCHAR (500),
   	merch_id  			bigint,
   	store_area   		VARCHAR (50),
   	src_area  			VARCHAR (50),
   	sell_on_date     	timestamp (5) WITHOUT TIME ZONE,
   	sell_off_date     	timestamp (5) WITHOUT TIME ZONE,
   	item_amount   		integer,
   	item_src_price   	numeric (10, 2),
   	item_curr_price   	numeric (10, 2),
	item_pic			VARCHAR (500) 	not null,		
	item_prev_pics 		text,
	item_detail_pics 	text,
	item_features  		text,
	trans_user    		bigint,
	trans_date     		timestamp (5) WITHOUT TIME ZONE,
	trans_lang 			VARCHAR (20) 	not null,
	create_date     	timestamp (5) WITHOUT TIME ZONE,
	last_update_date    timestamp (5) WITHOUT TIME ZONE,
	last_update_user    bigint,
	items_status    	CHARACTER VARYING (5),
	constraint PK_items primary key (sid)
);
--	pid					主键
--	merch_id  			客户id
--	merch_nm  			客户名称
--	prod_id  			产品id,
--	lang 				语言cn/en/kr,
--	cate_id    			类别,
--	cate_nm    			类别,
--	band_id    			品牌id,
--	band_nm    			品牌名称,
--	prod_nm  			产品名称,
--	prod_color  		产品颜色,
--	prod_size  			产品尺寸,
--	prod_desc    		产品描述,
--	src_area  			源产地,
--	sell_on_date     	可售日期,
--	sell_off_date     	截止日期,
--	prod_amount   		数量,
--	prod_price   		价格,
--	recom_price			建议售价,
--	prod_pic			产品主图片,		
--	prod_prev_pics 		产品预览图片,json串
--	prod_detail_pics 	产品详细图片,json串
--	prod_features  		产品属性,
--	last_update_date    最后更新日期,
--	last_update_user    最后更新操作用户,
--	create_date     	创建日期,
--	prod_status    		商品状态 'Y'--正常,'D'--到期商品,'N'--删除,'K'--售空
------客户商品入库信息表 -----------
CREATE TABLE prods (	
	pid					bigserial   				not null,
	merch_id  			bigint						not null,
	merch_nm  			VARCHAR (100),
   	prod_id  			bigint 						not null,
	lang 				CHARACTER (2) 				not null,
   	cate_id    			bigint 						not null,
	band_nm    			VARCHAR (100) 				not null,
   	prod_nm  			VARCHAR (500) 				not null,
	prod_color  		VARCHAR (100) 				not null,
	prod_size  			VARCHAR (100) 				not null,
   	prod_desc    		text,
   	store_area   		VARCHAR (50),
   	src_area  			VARCHAR (50),
   	sell_on_date     	timestamp (5) WITHOUT TIME ZONE,
   	sell_off_date     	timestamp (5) WITHOUT TIME ZONE,
   	prod_amount   		integer,
   	prod_price   		numeric (10, 2),
	recom_price			numeric (10, 2),
	prod_pic			VARCHAR (500) 				not null,		
	prod_prev_pics 		text,
	prod_detail_pics 	text,
	prod_features  		text,
	last_update_date    timestamp (5) WITHOUT TIME ZONE,
	last_update_user    bigint,
	create_date     	timestamp (5) WITHOUT TIME ZONE,
	prod_status    		VARCHAR (5),
	constraint PK_prods primary key (pid)
);
--	 uid         		主键,
--   email			 	邮件,
--   tell				电话,
--   passwd				密码,
--   comfirm_key		邮件确认key,
--   unm   				用户名,
--   name				姓名,
--   role_nm			角色名,
--   pic_url         	logo,
--   create_date      	创建日期,
--   status				状态 'Active' 正常，'Lock' 锁住，'Destory' 注销
--   last_login_date  	,
--   last_login_ip   	,
--   login_times      	,
--   pw_erro_times    	,
--   pw_lock_status   	状态 'Y' 锁住 'N' 已解锁,null 未锁,
CREATE TABLE users (
   uid         		bigserial           not null,
   email			VARCHAR(200)		not null,
   tell				VARCHAR(50)			not null,
   passwd			VARCHAR(200)		not null,
   comfirm_key		VARCHAR(200)		,
   unm   			VARCHAR(200)		not null,
   name				VARCHAR(200)		not null,
   role_nm			VARCHAR(200)		not null,
   logo_url         VARCHAR(500)		null,
   create_date      timestamp (5) WITHOUT TIME ZONE,
   status			VARCHAR(5)			null,
   last_login_date  timestamp (5) WITHOUT TIME ZONE,
   last_login_ip    VARCHAR(100),
   login_times      integer,
   pw_erro_times    integer,
   pw_lock_status   VARCHAR(5),
   constraint PK_users primary key (uid)
);

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

CREATE TABLE cates (
   cate_id          bigserial           	not null,
   pcate_id   		bigint					null,
   cate_nm_cn     	VARCHAR(500)			null,
   cate_nm_en     	VARCHAR(500)			null,
   cate_nm_kr     	VARCHAR(500)			null,
   cate_desc     	VARCHAR(500)			null,
   constraint PK_cates primary key (cate_id)
);

