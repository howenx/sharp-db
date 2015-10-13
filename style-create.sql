--	seq_id	自增ID
--	lang 	zh/kr/en
--	ciq_code   海关编码		
--  item_id   商品ID           
--  cate_id    商品类别 
--  band_id    品牌  
--  item_colors    颜色 
--  item_size    尺寸  
--  item_name  商品名称
--	bar_code	商品条形码      
--  item_des     商品详细信息    
--  merch_name   供货商        
--  store_area  出库地    
--  source_area  原产地  
--  up_date       商品销售期限-开始日期   
--  down_date     商品销售期限-结束日期    
--  item_amount   库存数量 
--  item_price   成本价     
--  item_sell_price   销售价   
--	item_pic	代表商品图片		
--	item_prev_pics 商品预览图片 |||
--	item_detail_pics 详细商品图片 |||
--	item_feature  商品属性信息  存json串
CREATE TABLE items
(	sid					bigserial   				not null,
   	item_id  			bigint 						not null,
	ciq_code  			bigint 						not null,
	lang 				CHARACTER (2) 				not null,
   	cate_id    			bigint 						not null,
   	band_id    			bigint 						not null,
   	item_nm  			CHARACTER VARYING (500) 	not null,
	item_color  		CHARACTER VARYING (500) 	not null,
	item_size  			CHARACTER VARYING (500) 	not null,
   	item_desc    		text,
	bar_code  			CHARACTER VARYING (500),
   	merch_nm  			CHARACTER VARYING (500),
   	store_area   		CHARACTER VARYING (500),
   	source_area  		CHARACTER VARYING (500),
   	sell_on_date     	timestamp (5) WITHOUT TIME ZONE,
   	sell_off_date     	timestamp (5) WITHOUT TIME ZONE,
   	item_amount   		integer,
   	item_src_price   	numeric (10, 2),
   	item_curr_price   	numeric (10, 2),
	item_pic			CHARACTER VARYING (500) 	not null,		
	item_prev_pics 		text,
	item_detail_pics 	text,
	item_features  		text,
	constraint PK_items primary key (sid)
);

CREATE TABLE brands(
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

CREATE TABLE cates
(
   cate_id          bigserial           	not null,
   pcate_id   		bigint					null,
   cate_nm_cn     	VARCHAR(500)			null,
   cate_nm_en     	VARCHAR(500)			null,
   cate_nm_kr     	VARCHAR(500)			null,
   cate_desc     	VARCHAR(500)			null,
   constraint PK_cates primary key (cate_id)
);

