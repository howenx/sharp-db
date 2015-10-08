CREATE TABLE hp_content
(
   id               bigserial           not null,
   content_html     text,
   tmp_id           bigint,
   publish_date     timestamp (5) WITHOUT TIME ZONE,
   client_flag      CHARACTER (2) DEFAULT '0'::bpchar,
   html_image_url   CHARACTER VARYING (500)
)