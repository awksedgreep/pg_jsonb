-- Select tracks as JSON with the album id

WITH tracks AS
(
    SELECT album_id, track_id, name as track_name
    FROM track
)
SELECT row_to_json(tracks) AS tracks
FROM tracks;