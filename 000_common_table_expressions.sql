-- Common Table Expressions example

-- This odd looking SQL can be used to generate JSON output from normal tables

WITH RECURSIVE t(n) AS (
    VALUES (1)
    UNION ALL
      SELECT n+1 FROM t WHERE n < 100000
)
SELECT sum(n), min(n), max(n) FROM t;

-- All further examples use data from:
-- https://github.com/awksedgreep/pg_chinook