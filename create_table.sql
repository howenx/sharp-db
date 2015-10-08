---创建表语句
CREATE TABLE brands(
   brand_id         bigserial           not null,
   cate_id          bigint				null,
   description_zh   text				null,
   description_en   text				null,
   description_ko   text				null,
   logo_url         VARCHAR(500)		null,
   home_page        text				null,
   create_date      date				null,
   brand_nm_zh      VARCHAR(200)		null,
   brand_nm_en      VARCHAR(200)		null,
   brand_nm_ko      VARCHAR(200)		null,
   constraint PK_brands primary key (brand_id)
);

CREATE TABLE cates
(
   cate_id          bigserial           	not null,
   parent_cate_id   bigint					null,
   cate_name_zh     VARCHAR(500)			null,
   cate_name_en     VARCHAR(500)			null,
   cate_name_ko     VARCHAR(500)			null,
   pic_url          text					null,
   constraint PK_cates primary key (cate_id)
);

CREATE TABLE item_props
(
   id             bigserial           		not null,
   props_id       bigint					null,
   prop_val_id    bigint					null,
   prod_id        bigint					null,
   sku_id         bigint					null,
   item_id        bigint					null,
   is_sale_prop   bigint					null,
   constraint PK_item_props primary key (id)
);

CREATE TABLE items
(
   item_id               bigserial           						not null,
   sku_id                bigint										null,
   prod_id               bigint										null,
   cate_id               bigint										null,
   band_id               bigint										null,
   item_name_zh          VARCHAR (500)								null,
   item_name_en          VARCHAR (500)								null,
   item_name_ko          VARCHAR (500)								null,
   item_des_zh           text										null,
   item_des_en           text										null,
   item_des_ko           text										null,
   item_feature_zh       text										null,
   item_feature_en       text										null,
   item_feature_ko       text										null,
   item_title_zh         text										null,
   item_title_en         text										null,
   item_title_ko         text										null,
   merch_id              VARCHAR (50)								null,
   bar_code              VARCHAR (50)								null,
   production_date       date										null,
   production_deadline   date										null,
   production_cmpy       VARCHAR (1000)								null,
   production_address    text										null,
   up_date               date										null,
   selling_date          date										null,
   down_date             date										null,
   item_amount           integer									null,
   item_price            numeric (10, 2)							null,
   constraint PK_items primary key (item_id)
);

CREATE TABLE price_changes
(
   id             bigserial           						not null,
   prod_id        VARCHAR (50)								null,
   sku_id         VARCHAR (50)								null,
   item_id        VARCHAR (50)								null,
   pre_price      numeric (10, 2)							null,
   cur_price      numeric (10, 2)							null,
   operator       VARCHAR (50)								null,
   operate_date   date										null,
   create_date    date										null,
   constraint PK_price_changes primary key (id)
);

CREATE TABLE prods
(
   prod_id         bigserial           				not null,
   prod_name_zh    VARCHAR (500)					null,
   prod_name_en    VARCHAR (500)					null,
   prod_name_ko    VARCHAR (500)					null,
   band_id         bigint							null,
   view_price      numeric (10, 2)					null,
   prod_des_zh     text								null,
   prod_des_en     text								null,
   prod_des_ko     text								null,
   prdo_intro_zh   text								null,
   prdo_intro_ko   text								null,
   prdo_intro_en   text								null,
   create_date     date								null,
   constraint PK_prods primary key (prod_id)
);

CREATE TABLE promotions
(
   id             	   bigserial           				not null,
   promot_id           integer							null,
   prod_id             VARCHAR (50)						null,
   item_id             VARCHAR (50)						null,
   sku_id              VARCHAR (50)						null,
   band_id             bigint							null,
   is_parent           boolean							null,
   cate_id             bigint							null,
   promot_nm_zh        VARCHAR (500)					null,
   promot_nm_ko        VARCHAR (500)					null,
   promot_nm_en        VARCHAR (500)					null,
   promot_start_date   date								null,
   promot_end_date     date								null,
   promot_type         VARCHAR (20)						null,
   coupons_id          bigint							null,
   pre_condition_id    bigint							null,
   restrict_amt        integer							null,
   create_date         date								null,
   constraint PK_promotions primary key (prom_id)
);

CREATE TABLE props
(
   prop_id       bigserial           				not null,
   prop_name     VARCHAR (500)						null,
   prop_val_id   bigint								null,
   cates_id      bigint								null,
   is_must       boolean							null,
   is_multi      boolean							null,
   create_date   date								null,
   constraint PK_props primary key (prop_id)
);

CREATE TABLE props_val
(
   prop_val_id        bigserial           				not null,
   prop_id            bigint							null,
   cate_id            bigint							null,
   prop_val_name_zh   VARCHAR (500)						null,
   prop_val_name_ko   VARCHAR (500)						null,
   prop_val_name_en   VARCHAR (500)						null,
   create_date        date								null,
   constraint PK_props_val primary key (prop_val_id)
);

CREATE TABLE resources
(
   res_id        bigserial           					not null,
   type          VARCHAR (200)							null,
   res_nm        VARCHAR (200)							null,
   res_url       VARCHAR (500)							null,
   create_date   date									null,
   suffix        VARCHAR (50)							null,
   constraint PK_resources primary key (res_id)
);

CREATE TABLE skus
(
   sku_id         bigserial           			not null,
   prod_id        bigint						null,
   sku_name_zh    VARCHAR (500)					null,
   sku_name_ko    VARCHAR (500)					null,
   sku_name_en    VARCHAR (500)					null,
   sku_title_zh   text							null,
   sku_title_ko   text							null,
   sku_title_en   text							null,
   sku_des_zh     text							null,
   sku_des_en     text							null,
   sku_des_ko     text							null,
   amount         integer						null,
   price          numeric (10, 2)				null,
   unit_id        VARCHAR (10)					null,
   hs_code        VARCHAR (20)					null,
   constraint PK_skus primary key (sku_id)
);

CREATE TABLE tag_prod
(
   id          bigserial           			not null,
   tag_id      bigint						null,
   prod_id     bigint						null,
   item_id     bigint						null,
   sku_id      bigint						null,
   cate_id     bigint						null,
   brand_ids   bigint						null,
   constraint PK_tag_prod primary key (id)
);

CREATE TABLE tags
(
   tag_id        bigserial           				not null,
   cate_id       bigint								null,
   tag_nm_zh     VARCHAR (200)						null,
   tag_nm_en     VARCHAR (200)						null,
   pic_url       text								null,
   tag_nm_ko     VARCHAR (200)						null,
   create_date   timestamp (6) WITHOUT TIME ZONE	null,
   constraint PK_tags primary key (tag_id)
);

CREATE TABLE theme_prod
(
   id          bigserial           					not null,
   thm_id      bigint								null,
   prod_id     bigint								null,
   item_id     bigint								null,
   sku_id      bigint								null,
   cate_id     bigint								null,
   brand_ids   bigint								null,
   constraint PK_theme_prod primary key (id)
);

CREATE TABLE themes
(
   thm_id        bigserial           						not null,
   thm_nm_zh     VARCHAR (200)								null,
   thm_nm_en     VARCHAR (200)								null,
   pic_url       text										null,
   thm_nm_ko     VARCHAR (200)								null,
   create_date   timestamp (6) WITHOUT TIME ZONE			null,
   up_date       timestamp (6) WITHOUT TIME ZONE			null,
   down_date     timestamp (6) WITHOUT TIME ZONE			null,
   constraint PK_themes primary key (thm_id)
);

CREATE TABLE unit
(
   unit_id        bigserial           						not null,
   unit_name_zh   VARCHAR (100)								null,
   unit_name_ko   VARCHAR (100)								null,
   unit_name_en   VARCHAR (100)								null,
   create_date    date										null,
   constraint PK_unit primary key (unit_id)
);

CREATE TABLE users
(
   id             bigserial           						not null,
   user_id        VARCHAR (50)								null,
   user_nm        VARCHAR (20)								null,
   user_tel       VARCHAR (20)								null,
   user_pwd       VARCHAR (10)								null,
   user_device    VARCHAR (50)								null,
   is_lock        boolean									null,
   is_close       boolean									null,
   regist_date    date										null,
   lock_times     integer									null,
   level          VARCHAR (10)								null,
   age            integer									null,
   id_card        VARCHAR (30)								null,
   address        text										null,
   personal_des   VARCHAR (500)								null,
   birthday       date										null,
   gender         character (1)								null,
   portrait_id    bigint									null,
   weixin_id      VARCHAR (50)								null,
   is_weixin      boolean									null,
   constraint PK_users primary key (users)
);

commit;