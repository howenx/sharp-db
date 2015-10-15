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