DROP TABLE IF EXISTS inventory.sale_group_sale_item CASCADE;
CREATE TABLE inventory.sale_group_sale_item (
    sale_group_sale_item_id BIGSERIAL       PRIMARY KEY
  , sale_group_id           BIGINT          NOT NULL REFERENCES inventory.sale_group (sale_group_id)
  , sale_item_id            BIGINT          NOT NULL REFERENCES inventory.sale_item (sale_item_id)
);
ALTER TABLE inventory.sale_group_sale_item OWNER TO store_db_su;
CREATE UNIQUE INDEX uc_sale_group_id_sale_item_id ON inventory.sale_group_sale_item (sale_group_id,sale_item_id);