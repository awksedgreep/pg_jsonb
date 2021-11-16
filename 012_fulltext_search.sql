
-- Basic query
SELECT * FROM artist_data WHERE artist_data.artist_data::text like '%One%';

EXPLAIN ANALYZE SELECT * FROM artist_data WHERE artist_data.artist_data::text like '%One%';
-- Runs in ~25ms

DROP INDEX IF EXISTS fts_artist_data;
CREATE INDEX fts_artist_data ON artist_data USING GIN (jsonb_to_tsvector('english', artist_data, '["all"]'));

-- Now use the INDEX
SELECT * FROM artist_data WHERE to_tsvector('english', artist_data) @@ to_tsquery('one');

EXPLAIN ANALYZE SELECT * FROM artist_data WHERE jsonb_to_tsvector('english', artist_data, '["all"]') @@ to_tsquery('one');
-- Runs in 0.176ms

-- Speedup query
SELECT round(25 / 0.176, 2) || 'x';
--  142.05x faster on just 200 rows
