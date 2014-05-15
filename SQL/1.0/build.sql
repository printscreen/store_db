\i create_db.sql

BEGIN;

\i create_users.sql

--BUILD SCHEMAS
\i schemas/users/schemas/users.sql
\i schemas/application/schemas/application.sql
\i schemas/transaction/schemas/transaction.sql
\i schemas/inventory/schemas/inventory.sql

--BUILD TABLES
\i schemas/transaction/tables/order_status.sql
\i schemas/application/tables/resource.sql
\i schemas/inventory/tables/item.sql
\i schemas/inventory/tables/item_price.sql
\i schemas/inventory/tables/item_quantity.sql
\i schemas/users/tables/user_type.sql
\i schemas/users/tables/user.sql
\i schemas/users/tables/user_type_resource.sql
\i schemas/transaction/tables/country.sql
\i schemas/transaction/tables/address.sql
\i schemas/transaction/tables/carrier.sql
\i schemas/transaction/tables/order.sql
\i schemas/transaction/tables/item_ordered.sql
\i schemas/transaction/tables/sales_tax.sql
\i schemas/transaction/tables/order_billing.sql
\i schemas/transaction/tables/order_shipping.sql
\i schemas/application/tables/menu.sql
\i schemas/application/tables/submenu.sql
\i schemas/users/tables/user_type_menu.sql
\i schemas/users/tables/user_type_submenu.sql
\i schemas/transaction/tables/order_history_type.sql
\i schemas/transaction/tables/order_history.sql
\i schemas/application/tables/record_lock.sql
\i schemas/transaction/tables/postage_service_type.sql
\i schemas/transaction/tables/postage_package_type.sql
\i schemas/transaction/tables/order_postage.sql
\i schemas/transaction/tables/carrier_addon.sql
\i schemas/transaction/tables/order_postage_addon.sql
\i schemas/inventory/tables/attribute.sql
\i schemas/inventory/tables/item_attribute.sql
\i schemas/inventory/tables/kickstarter_tier.sql
\i schemas/inventory/tables/kickstarter_item.sql
\i schemas/inventory/tables/kickstarter_tier_item.sql
\i schemas/users/tables/kickstarter.sql
\i schemas/transaction/tables/pledge_source.sql
\i schemas/transaction/tables/kickstarter_pledge.sql
\i schemas/application/tables/game.sql
\i schemas/application/tables/game_type.sql
\i schemas/application/tables/game_type_association.sql
\i schemas/application/tables/game_image.sql
\i schemas/application/tables/news.sql

--INDEXES
\i schemas/users/indexes/i_username.sql
\i schemas/transaction/indexes/i_postal_code.sql
\i schemas/application/indexes/i_module.sql
\i schemas/transaction/indexes/i_order_history_user_id.sql
\i schemas/inventory/indexes/i_inventory_attribute_parent_id.sql
\i schemas/inventory/indexes/i_inventory_item_attribute_attribute_id.sql
\i schemas/inventory/indexes/i_inventory_item_item_id.sql
\i schemas/users/indexes/i_users_kickstarter_email.sql


--BUILD TYPES
\i schemas/application/types/t_resource.sql
\i schemas/inventory/types/t_item.sql
\i schemas/transaction/types/t_address.sql
\i schemas/transaction/types/t_carrier.sql
\i schemas/transaction/types/t_country.sql
\i schemas/transaction/types/t_item_ordered.sql
\i schemas/transaction/types/t_order_billing.sql
\i schemas/transaction/types/t_order_shipping.sql
\i schemas/transaction/types/t_order.sql
\i schemas/transaction/types/t_sales_tax.sql
\i schemas/users/types/t_user_type.sql
\i schemas/users/types/t_user.sql
\i schemas/users/types/t_user_type_resource.sql
\i schemas/application/types/t_menu.sql
\i schemas/users/types/t_user_type_menu.sql
\i schemas/users/types/t_user_type_submenu.sql
\i schemas/transaction/types/t_order_status.sql
\i schemas/transaction/types/t_order_history.sql
\i schemas/application/types/t_record_lock.sql
\i schemas/transaction/types/t_order_postage.sql
\i schemas/transaction/types/t_order_history_type.sql
\i schemas/transaction/types/t_postage_service_type.sql
\i schemas/transaction/types/t_postage_package_type.sql
\i schemas/transaction/types/t_carrier_addon.sql
\i schemas/transaction/types/t_order_postage_addon.sql
\i schemas/inventory/types/t_attribute.sql
\i schemas/inventory/types/t_item_attribute.sql
\i schemas/users/types/t_kickstarter.sql
\i schemas/transaction/types/t_pledge_source.sql
\i schemas/transaction/types/t_kickstarter_pledge.sql
\i schemas/inventory/types/t_kickstarter_tier.sql
\i schemas/inventory/types/t_kickstarter_item.sql
\i schemas/inventory/types/t_kickstarter_tier_item.sql
\i schemas/application/types/t_game.sql
\i schemas/application/types/t_game_image.sql
\i schemas/application/types/t_game_type.sql
\i schemas/application/types/t_news.sql


--BUILD VIEWS
\i schemas/application/views/v_resource.sql
\i schemas/inventory/views/v_item.sql
\i schemas/transaction/views/v_address.sql
\i schemas/transaction/views/v_carrier.sql
\i schemas/transaction/views/v_country.sql
\i schemas/transaction/views/v_item_ordered.sql
\i schemas/transaction/views/v_order_billing.sql
\i schemas/transaction/views/v_order_shipping.sql
\i schemas/transaction/views/v_order.sql
\i schemas/transaction/views/v_sales_tax.sql
\i schemas/users/views/v_user_type.sql
\i schemas/users/views/v_user.sql
\i schemas/users/views/v_user_type_resource.sql
\i schemas/application/views/v_menu.sql
\i schemas/application/views/v_submenu.sql
\i schemas/users/views/v_user_type_menu.sql
\i schemas/users/views/v_user_type_submenu.sql
\i schemas/transaction/views/v_order_status.sql
\i schemas/application/views/v_record_lock.sql
\i schemas/transaction/views/v_order_postage.sql
\i schemas/transaction/views/v_order_history_type.sql
\i schemas/transaction/views/v_order_history.sql
\i schemas/transaction/views/v_postage_service_type.sql
\i schemas/transaction/views/v_postage_package_type.sql
\i schemas/transaction/views/v_carrier_addon.sql
\i schemas/transaction/views/v_order_postage_addon.sql
\i schemas/inventory/views/v_attribute.sql
\i schemas/inventory/views/v_item_attribute.sql
\i schemas/users/views/v_kickstarter.sql
\i schemas/transaction/views/v_kickstarter_pledge.sql
\i schemas/transaction/views/v_pledge_source.sql
\i schemas/inventory/views/v_kickstarter_tier.sql
\i schemas/inventory/views/v_kickstarter_item.sql
\i schemas/inventory/views/v_kickstarter_tier_item.sql
\i schemas/application/views/v_game.sql
\i schemas/application/views/v_game_by_type.sql
\i schemas/application/views/v_game_image.sql
\i schemas/application/views/v_game_type.sql
\i schemas/application/views/v_news.sql

--BUILD FUNCTIONS
\i schemas/inventory/functions/get_item.sql
\i schemas/inventory/functions/set_item.sql
\i schemas/transaction/functions/get_address.sql
\i schemas/transaction/functions/get_carrier.sql
\i schemas/transaction/functions/get_country.sql
\i schemas/transaction/functions/get_item_ordered_by_order_id.sql
\i schemas/transaction/functions/get_item_ordered.sql
\i schemas/transaction/functions/get_order_billing.sql
\i schemas/transaction/functions/get_order_by_user_id.sql
\i schemas/transaction/functions/get_order_shipping.sql
\i schemas/transaction/functions/get_order.sql
\i schemas/transaction/functions/get_order_by_order_number.sql
\i schemas/transaction/functions/get_sales_tax_by_postal_code.sql
\i schemas/transaction/functions/get_sales_tax.sql
\i schemas/transaction/functions/set_address.sql
\i schemas/transaction/functions/set_carrier.sql
\i schemas/transaction/functions/set_country.sql
\i schemas/transaction/functions/set_item_ordered.sql
\i schemas/transaction/functions/set_order_billing.sql
\i schemas/transaction/functions/set_order_shipping.sql
\i schemas/transaction/functions/set_order.sql
\i schemas/users/functions/authenticate.sql
\i schemas/users/functions/get_user_by_email.sql
\i schemas/users/functions/list_user_types.sql
\i schemas/users/functions/get_user.sql
\i schemas/users/functions/set_user.sql
\i schemas/users/functions/get_user_type_resources.sql
\i schemas/users/functions/get_user_menu.sql
\i schemas/users/functions/get_user_submenu.sql
\i schemas/transaction/functions/list_order_status.sql
\i schemas/transaction/functions/get_order_by_order_status_id.sql
\i schemas/application/functions/get_record_lock.sql
\i schemas/application/functions/set_record_lock.sql
\i schemas/application/functions/delete_record_lock.sql
\i schemas/application/functions/clear_record_lock.sql
\i schemas/transaction/functions/get_order_postage.sql
\i schemas/transaction/functions/set_order_postage.sql
\i schemas/transaction/functions/get_order_for_processing.sql
\i schemas/transaction/functions/delete_order_postage.sql
\i schemas/transaction/functions/get_order_history.sql
\i schemas/transaction/functions/set_order_history.sql
\i schemas/transaction/functions/get_order_history_type.sql
\i schemas/transaction/functions/set_order_history_type.sql
\i schemas/transaction/functions/get_postage_service_type.sql
\i schemas/transaction/functions/set_postage_service_type.sql
\i schemas/transaction/functions/get_postage_package_type.sql
\i schemas/transaction/functions/set_postage_package_type.sql
\i schemas/transaction/functions/get_order_postage_addon.sql
\i schemas/transaction/functions/set_order_postage_addon.sql
\i schemas/transaction/functions/get_carrier_addon.sql
\i schemas/transaction/functions/set_carrier_addon.sql
\i schemas/inventory/functions/set_attribute.sql
\i schemas/inventory/functions/get_attribute.sql
\i schemas/inventory/functions/set_item_attribute.sql
\i schemas/users/functions/generate_hash_from_email.sql
\i schemas/users/functions/assign_new_kickstarter_hash.sql
\i schemas/users/functions/set_kickstarter.sql
\i schemas/transaction/functions/set_kickstarter_pledge.sql
\i schemas/users/functions/get_kickstarter.sql
\i schemas/users/functions/hash_password.sql
\i schemas/transaction/functions/get_kickstarter_pledge.sql
\i schemas/transaction/functions/get_kickstarter_pledge_amount.sql
\i schemas/transaction/functions/get_pledge_source.sql
\i schemas/transaction/functions/set_pledge_source.sql
\i schemas/inventory/functions/set_kickstarter_tier.sql
\i schemas/inventory/functions/set_kickstarter_item.sql
\i schemas/inventory/functions/get_kickstarter_tier.sql
\i schemas/inventory/functions/get_kickstarter_item.sql
\i schemas/inventory/functions/get_kickstarter_tier_item.sql
\i schemas/application/functions/get_game.sql
\i schemas/application/functions/set_game.sql
\i schemas/application/functions/get_game_by_game_type.sql
\i schemas/application/functions/get_game_image.sql
\i schemas/application/functions/set_game_image.sql
\i schemas/application/functions/get_game_type.sql
\i schemas/application/functions/set_game_type.sql
\i schemas/application/functions/get_news.sql
\i schemas/application/functions/set_news.sql
\i schemas/users/functions/is_prefered_email_available.sql

COMMIT;
