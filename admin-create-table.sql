CREATE TABLE admin.hp_content
(
   content_id       bigserial   not null,
   content_html     text,
   tmp_id           bigint,
   publish_date     timestamp (5) WITHOUT TIME ZONE,
   client_flag      CHARACTER (2) ,
   html_image_url   CHARACTER VARYING (500)
);
CREATE TABLE admin.hp_template
(
   tmp_id       bigserial   not null,
   tmp_html     text,
   is_default   CHARACTER (1)
);
CREATE TABLE admin.hp_title_roll
(
   roll_id     bigserial   not null,
   roll_sort   CHARACTER VARYING (20),
   image_url   CHARACTER VARYING (500),
   timeout     CHARACTER VARYING (20)
);
CREATE TABLE admin.user_info
(
   user_id           bigserial   not null,
   user_name         CHARACTER VARYING (200),
   email             CHARACTER VARYING (200),
   regist_date       timestamp (5) WITHOUT TIME ZONE,
   role_id           bigint,
   describe          CHARACTER VARYING (500),
   islock            char,
   passwd            CHARACTER VARYING (600),
   user_name_en      CHARACTER VARYING (200),
   last_login_date   timestamp (5) WITH TIME ZONE,
   salt              CHARACTER VARYING (600)
);
commit;

alter sequence admin.hp_content_content_id_seq       restart with 31001;
alter sequence admin.hp_template_tmp_id_seq         restart with 32001;
alter sequence admin.hp_title_roll_roll_id_seq         restart with 33001;
alter sequence admin.user_info_user_id_seq      restart with 34001;

alter sequence admin.hp_content_content_id_seq      increment  by 5;
alter sequence admin.hp_template_tmp_id_seq         increment  by 5;
alter sequence admin.hp_title_roll_roll_id_seq         increment  by 5;
alter sequence admin.user_info_user_id_seq      increment  by 5;