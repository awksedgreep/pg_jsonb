
-- Select all albums with tracks by artist

CREATE OR REPLACE VIEW v_json_artist_data AS
WITH tracks AS (
    SELECT album_id, track_id, name,
     media_type_id, milliseconds, unit_price
    FROM track
),
json_tracks AS (
    SELECT row_to_json(tracks) AS tracks FROM tracks
),
albums AS (
    SELECT a.artist_id, a.album_id, a.title,
     array_agg(t.tracks) AS album_tracks
    FROM album AS a
    INNER JOIN json_tracks AS t
     ON a.album_id = (t.tracks->>'album_id')::int
    GROUP BY a.artist_id, a.album_id, a.title
),
json_albums AS (
    SELECT artist_id, array_agg(row_to_json(albums)) AS album
    FROM albums
    GROUP BY artist_id
),
artists AS (
    SELECT a.artist_id, a.name, jsa.album
    FROM artist AS a
    INNER JOIN json_albums AS jsa
     ON a.artist_id = jsa.artist_id
)
SELECT (row_to_json(artists))::jsonb AS artist_data
FROM artists;
