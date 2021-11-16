-- Some examples of how intelligent the implementation of
-- fulltext and jsonb really is . . . 

-- Keys are ignored by default for fulltext
-- when you pass it a jsonb column
SELECT 
 to_tsvector('english', '
   {
    "aa": "The Fat Rats",
    "b": "dog"
   }'::jsonb);

-- Filtering in jsonb is easy as you pull your vectors for
-- fulltext indexing
SELECT jsonb_to_tsvector('english', '{
    "a": "The Fat Rats", 
    "b": 123}'::jsonb, 
    '["string", "numeric"]');

-- Don't want to learn the json search nomenclature or 
-- simply want to add a webform for fulltext search?
SELECT websearch_to_tsquery('english', 
    '"fat rat" or cat dog');

-- You can find more here:
-- https://www.postgresql.org/docs/14/functions-textsearch.html

