BEGIN;

--TABLES
DROP TABLE transaction.sales_tax CASCADE;
DROP TYPE transaction.t_sales_tax CASCADE;

\i schemas/transaction/tables/tax.sql
\i schemas/transaction/tables/order_tax.sql

--TYPES
\i schemas/transaction/types/t_tax.sql
\i schemas/transaction/types/t_order_tax.sql

--VIEWS
\i schemas/transaction/views/v_tax.sql
\i schemas/transaction/views/v_order_tax.sql

--FUNCTIONS
\i schemas/transaction/functions/get_tax.sql
\i schemas/transaction/functions/get_tax_by_postal_code.sql
\i schemas/transaction/functions/set_tax.sql
\i schemas/transaction/functions/get_order_tax.sql
\i schemas/transaction/functions/get_order_tax_by_order_id.sql
\i schemas/transaction/functions/set_order_tax.sql

COMMIT;