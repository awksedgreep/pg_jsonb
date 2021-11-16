-- Get record set from json data

SELECT *
FROM jsonb_to_recordset (
    (
        SELECT (artist_data->>'album')::jsonb
        FROM v_json_artist_data
        WHERE (artist_data->>'artist_id')::int = 50
    )
) AS x(album_id int, artist_id int, title text, album_tracks jsonb);
