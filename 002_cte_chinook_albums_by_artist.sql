
-- Select all albums with tracks by artist

WITH tracks AS (
    SELECT album_id, track_id, name FROM track
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
)
SELECT artist_id, array_agg(row_to_json(albums)) AS album
FROM albums
GROUP BY artist_id;
