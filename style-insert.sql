insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'place_order_method','001','','','','安卓');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'place_order_method','002','','','','IOS');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'place_order_method','003','','','','WEB');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'place_order_method','004','','','','分享');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'place_order_method','005','','','','拼购');

insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'receive_at','1001','','','','工作日双休日均可送货');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'receive_at','1002','','','','只工作日送货');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'receive_at','1003','','','','只双休日送货');

insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'payment','2001','','','','网银在线');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'payment','2002','','','','支付宝');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'payment','2003','','','','京东钱包');
insert INTO codes ("cid", pcid, code, value, value_cn, value_en, value_kr, code_desc) 
values (nextval('codes_cid_seq'),null,'payment','2004','','','','微信钱包');
commit;


insert into items (id, ciq_code, lang, cate_id, brand_id, cate_nm, brand_nm, item_nm, item_title, item_desc, bar_code, bar_des, merch_uid, src_area, on_shelves_at, off_shelves_at, item_master_img, item_preview_imgs, item_detail_imgs, item_features, is_join_theme, theme_id, is_major_item, state, is_free_ship, has_invoice, has_vat_invoice, delivery_area, delivery_time, is_restrict_buy, restrict_amount, item_url, is_shopping_poll, is_share, share_key, share_img, share_url, share_count, like_count, collect_count, browse_count, item_notice, trans_uid, trans_at, trans_lang, is_destory, destory_uid, destory_at, update_at, update_uid, create_at, create_uid) 
values (nextval('items_id_seq'),90011,'zh',12011,100072,'','','护手霜','德国原产 SENSITIVE温和防敏无香型滋润护手霜100ml','','','',);

insert into brands (brand_id, desc_cn, desc_en, desc_kr, logo_url, home_page, create_date, brand_nm_cn, brand_nm_en, brand_nm_kr) 
values (nextval('brands_brand_id_seq'),'德国手霜在手霜界一向以富含洋甘菊及价廉物美著称,康蜜儿家里最广为人知的产品绿色的滋润护手霜。KAMILL品牌创建于1956年，产品出了手霜外还有沐浴润肤系列','','','/uploads/minify/9c328614734d49f1a98d7bad0070291b1445392570251.jpg','www.kamillchina.com',CURRENT_TIMESTAMP(0),'康蜜儿','KAMILL','');
commit;

