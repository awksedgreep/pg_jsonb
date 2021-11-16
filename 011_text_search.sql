-- Text search against all elements
-- Find artist, album, or song title that contains '%One%'

SELECT * FROM artist_data WHERE artist_data.artist_data::text like '%Miles Davis%';

EXPLAIN ANALYZE SELECT * FROM artist_data WHERE artist_data.artist_data::text like '%Miles Davis%';
-- Runs in ~21ms

CREATE INDEX ft_artist_data ON artist_data USING GIN (artist_data);

-- Use INDEX
SELECT * FROM artist_data WHERE artist_data.artist_data @> '{"name": "Miles Davis"}';

-- check plan
EXPLAIN ANALYZE SELECT * FROM artist_data WHERE artist_data.artist_data @> '{"name": "Miles Davis"}';
-- Runs in ~.1 ms

-- How much faster is it?
SELECT round(21 / 0.1, 2) || 'x';
-- 210.00x faster on just 200 rows
