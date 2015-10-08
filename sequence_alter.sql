alter sequence prods_prod_id_seq increment  by 157;
alter sequence prods_prod_id_seq restart with 56575859;

alter sequence skus_sku_id_seq increment  by 177;
alter sequence skus_sku_id_seq restart with 343536373;

alter sequence items_item_id_seq restart with 646566676;
alter sequence items_item_id_seq increment  by 169;


alter sequence brands_brand_id_seq       restart with 11001;
alter sequence cates_cate_id_seq         restart with 12001;
alter sequence item_props_id_seq         restart with 14001;
alter sequence price_changes_id_seq      restart with 15001;
alter sequence promotions_id_seq         restart with 17001;
alter sequence props_prop_id_seq         restart with 18001;
alter sequence props_val_prop_val_id_seq restart with 19001;
alter sequence resources_res_id_seq      restart with 20001;
alter sequence tag_prod_id_seq           restart with 22001;
alter sequence tags_tag_id_seq           restart with 23001;
alter sequence theme_prod_id_seq         restart with 24001;
alter sequence themes_thm_id_seq         restart with 25001;
alter sequence unit_unit_id_seq          restart with 26001;
alter sequence user_id_seq               restart with 27001;

alter sequence brands_brand_id_seq       increment  by 3;
alter sequence cates_cate_id_seq         increment  by 3;
alter sequence item_props_id_seq         increment  by 3;
alter sequence price_changes_id_seq      increment  by 3;
alter sequence promotions_id_seq         increment  by 3;
alter sequence props_prop_id_seq         increment  by 3;
alter sequence props_val_prop_val_id_seq increment  by 3;
alter sequence resources_res_id_seq      increment  by 3;
alter sequence tag_prod_id_seq           increment  by 3;
alter sequence tags_tag_id_seq           increment  by 3;
alter sequence theme_prod_id_seq         increment  by 3;
alter sequence themes_thm_id_seq         increment  by 3;
alter sequence unit_unit_id_seq          increment  by 3;
alter sequence user_id_seq               increment  by 3;


---table alter
---www.postgresql.org/docs/9.3/interactive/sql-altertable.html

alter table brands ADD primary key (brand_id);
ALTER TABLE brands ALTER COLUMN brand_id SET NOT NULL;




