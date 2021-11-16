-- Note:  the type of the data coming from the view is already jsonb NOT json
-- chinook=# select pg_typeof(artist_data) from v_json_artist_data limit 1;
--  pg_typeof
-----------
--  jsonb
-- (1 row)

-- Therefore all we have to do to create a proper jsonb table is
DROP TABLE IF EXISTS artist_data;
CREATE TABLE artist_data AS SELECT * FROM v_json_artist_data;

-- That's all well and good, but can we index it?
-- Absolutely

-- Query before index
SELECT * FROM artist_data WHERE (artist_data->'artist_id')::int = 68;

-- Check the plan
EXPLAIN ANALYZE SELECT * FROM artist_data WHERE (artist_data->'artist_id')::int = 68;

-- BTREE example
DROP INDEX IF EXISTS pk_artist_id;
CREATE UNIQUE INDEX pk_artist_id ON artist_data USING BTREE (((artist_data->'artist_id')::int));

-- Query after index
SELECT * FROM artist_data WHERE (artist_data->'artist_id')::int = 68;

-- Check the plan
EXPLAIN ANALYZE SELECT * FROM artist_data WHERE (artist_data->'artist_id')::int = 68;

-- How much faster are we
SELECT round(2.241 / 0.060, 2) || 'x';
-- 37.35x faster on just 200 rows