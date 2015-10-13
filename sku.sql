--	seq_id	自增ID
--	lan 	zh/kr/en		
--  item_id   商品ID           
--  cate_id    商品类别 
--  band_id    品牌  
--  item_colors    颜色 
--  item_size    尺寸  
--  item_name  商品名称       
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
(	seq_id				bigserial   				not null,
   	lan 				CHARACTER (2) 				not null,	
   	item_id  			bigint 						not null,
   	cate_id    			bigint 						not null,
   	band_id    			bigint 						not null,
   	item_name  			CHARACTER VARYING (500) 	not null,
	item_colors  		CHARACTER VARYING (500) 	not null,
	item_size  			CHARACTER VARYING (500) 	not null,
   	item_des    		text,
   	merch_name  		CHARACTER VARYING (500),
   	store_area   		CHARACTER VARYING (500),
   	source_area  		CHARACTER VARYING (500),
   	sell_start_date     timestamp (5) WITHOUT TIME ZONE,
   	sell_end_date     	timestamp (5) WITHOUT TIME ZONE,
   	item_amount   		integer,
   	item_source_price   numeric (10, 2),
   	item_sell_price   	numeric (10, 2),
	item_pic			CHARACTER VARYING (500) 	not null,		
	item_prev_pics 		text,
	item_detail_pics 	text,
	item_feature  		text
);