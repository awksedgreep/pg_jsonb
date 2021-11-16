SELECT jsonb_pretty(artist_data) 
FROM v_json_artist_data 
WHERE artist_data->>'name' = 'Miles Davis';
