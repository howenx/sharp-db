alter sequence prods_prod_id_seq increment  by 157;
alter sequence prods_prod_id_seq restart with 56575859;

alter sequence skus_sku_id_seq increment  by 177;
alter sequence skus_sku_id_seq restart with 343536373;

alter sequence items_item_id_seq restart with 646566676;
alter sequence items_item_id_seq increment  by 169;


alter sequence  address_id_seq       restart with 100000;
alter sequence  brands_brand_id_seq  restart with 100000;
alter sequence  carts_id_seq         restart with 100000;
alter sequence  cates_cate_id_seq    restart with 100000;
alter sequence  codes_cid_seq        restart with 100000;
alter sequence  coupons_id_seq       restart with 100000;
alter sequence  inventories_id_seq   restart with 100000;
alter sequence  items_id_seq         restart with 100000;
alter sequence  members_mid_seq      restart with 100000;
alter sequence  order_item_id_seq    restart with 100000;
alter sequence  orders_id_seq        restart with 100000;
alter sequence  prods_id_seq         restart with 100000;
alter sequence  shopping_poll_id_seq restart with 100000;
alter sequence  stock_id_seq         restart with 100000;
alter sequence  theme_item_id_seq    restart with 100000;
alter sequence  themes_id_seq        restart with 100000;
alter sequence  users_uid_seq        restart with 100000;

alter sequence  address_id_seq       increment  by 3;
alter sequence  brands_brand_id_seq  increment  by 3;
alter sequence  carts_id_seq         increment  by 3;
alter sequence  cates_cate_id_seq    increment  by 3;
alter sequence  codes_cid_seq        increment  by 3;
alter sequence  coupons_id_seq       increment  by 3;
alter sequence  inventories_id_seq   increment  by 3;
alter sequence  items_id_seq         increment  by 3;
alter sequence  members_mid_seq      increment  by 3;
alter sequence  order_item_id_seq    increment  by 3;
alter sequence  orders_id_seq        increment  by 3;
alter sequence  prods_id_seq         increment  by 3;
alter sequence  shopping_poll_id_seq increment  by 3;
alter sequence  stock_id_seq         increment  by 3;
alter sequence  theme_item_id_seq    increment  by 3;
alter sequence  themes_id_seq        increment  by 3;
alter sequence  users_uid_seq        increment  by 3;


---table alter
---www.postgresql.org/docs/9.3/interactive/sql-altertable.html

alter table brands ADD primary key (brand_id);
ALTER TABLE brands ALTER COLUMN brand_id SET NOT NULL;




