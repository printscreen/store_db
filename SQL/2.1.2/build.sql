BEGIN;

--TABLES
\i schemas/inventory/tables/sale_group_sale_item.sql
\i schemas/inventory/tables/sale_group_picture.sql
\i schemas/transaction/tables/paypal.sql

--TYPES
\i schemas/inventory/types/t_sale_group_sale_item.sql
\i schemas/inventory/types/t_sale_group_picture.sql
\i schemas/transaction/types/t_order.sql
\i schemas/transaction/types/t_paypal.sql

--VIEWS
\i schemas/inventory/views/v_sale_group_sale_item.sql
\i schemas/inventory/views/v_sale_group_picture.sql
\i schemas/transaction/views/v_order.sql
\i schemas/transaction/views/v_user_digital_item.sql
\i schemas/transaction/views/v_paypal.sql

--FUNCTIONS
\i schemas/inventory/functions/get_sale_group_sale_item.sql
\i schemas/inventory/functions/set_sale_group_sale_item.sql
\i schemas/inventory/functions/get_sale_group_picture.sql
\i schemas/inventory/functions/set_sale_group_picture.sql
\i schemas/transaction/functions/get_order_by_order_number.sql
\i schemas/transaction/functions/get_order_by_order_status_id.sql
\i schemas/transaction/functions/get_order_by_user_id.sql
\i schemas/transaction/functions/get_order_for_processing.sql
\i schemas/transaction/functions/get_order.sql
\i schemas/inventory/functions/get_available_sale_item.sql
\i schemas/transaction/functions/get_sale_item_ordered.sql
\i schemas/transaction/functions/get_paypal.sql
\i schemas/transaction/functions/set_paypal.sql
\i schemas/transaction/functions/delete_paypal.sql


COMMIT;