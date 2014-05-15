DROP VIEW IF EXISTS transaction.v_kickstarter_pledge;
CREATE OR REPLACE VIEW transaction.v_kickstarter_pledge AS
SELECT
      kp.kickstarter_pledge_id AS kickstarter_pledge_id
     ,kp.kickstarter_id AS kickstarter_id
     ,kp.amount AS amount
     ,kp.transaction_id AS transaction_id
     ,kp.pledge_source_id AS pledge_source_id
     ,ps.name AS pledge_source_name
FROM transaction.kickstarter_pledge kp
    INNER JOIN transaction.pledge_source ps ON kp.pledge_source_id = ps.pledge_source_id;
ALTER VIEW transaction.v_kickstarter_pledge OWNER TO store_db_su;