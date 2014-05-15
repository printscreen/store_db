ALTER TABLE application.news ADD COLUMN update_ts TIMESTAMPTZ NULL;
UPDATE application.news SET update_ts = insert_ts;