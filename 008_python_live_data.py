#!/usr/bin/env python3

import json
import psycopg2

conn = psycopg2.connect(dbname="chinook", user="example", 
  password="demo", host="127.0.0.1")

cr = conn.cursor()
cr.execute("SELECT * FROM v_json_artist_data WHERE artist_data->>'name' = 'Metallica'")
res = cr.fetchone()
data = res[0]  # NOTE: No parsing required.  JSON data type is understood by python.

for album in data['album']:
    print("\n", album['title'], ": ")
    for track in album['album_tracks']:
        print("   - ", track['name'])

# runs in roughly 193ms