-- Common Table Expressions example

-- This odd looking SQL can be used to generate JSON output from normal tables

WITH RECURSIVE gwbasic AS (
  SELECT '10 PRINT "HELLO WORLD!"'
  UNION ALL
  SELECT '20 GOTO 10'
  UNION ALL
  SELECT 'RUN'
)
SELECT * FROM gwbasic;

WITH gwbasic1 AS (
  SELECT '10 PRINT "HELLO WORLD!"'
),
gwbasic2 AS (
  SELECT '20 GOTO 10'
),
gwbasic3 AS (
  SELECT 'RUN'
)
SELECT * FROM gwbasic1
UNION ALL
SELECT * FROM gwbasic2
UNION ALL
SELECT * FROM gwbasic3;

SET statement_timeout = '1s';

-- RUN ONLY WITH STATEMENT TIMEOUT (No results shown)
WITH RECURSIVE gwbasic AS (
  SELECT 'HELLO WORLD!'
  UNION ALL
  SELECT * FROM gwbasic
)
SELECT * FROM gwbasic;

RESET statement_timeout;

-- Let's try that with a counter instead
WITH RECURSIVE gwbasic (counter) AS (
  -- Seed value
  SELECT 1
  UNION ALL
  SELECT counter + 1 FROM gwbasic WHERE counter < 10
)
SELECT * FROM gwbasic;

WITH RECURSIVE t(n) AS (
    VALUES (1)
    UNION ALL
      SELECT n+1 FROM t WHERE n < 100000
)
SELECT sum(n), min(n), max(n) FROM t;

-- All further examples use data from:
-- https://github.com/awksedgreep/pg_chinook

-- Can we shove the output into an array?  Surely
WITH artists AS (
  SELECT artist_id, name FROM artist
),
albums AS (
  SELECT artist_id, title FROM album
)
SELECT artists.name, array_agg(albums.title) 
FROM artists JOIN albums 
 ON artists.artist_id = albums.artist_id
GROUP BY artists.name;