#!/usr/bin/env python3

import json
import psycopg2

# If you wish to grant permissions use the following,
# or you can modify the code to match your permissions
conn = psycopg2.connect(
  dbname="chinook", user="example", 
  password="demo", host="127.0.0.1"
  )

cr = conn.cursor()
cr.execute("SELECT * FROM v_json_artist_data WHERE artist_data->>'name' = 'Metallica'")
data = cr.fetchone()[0]
# NOTE: No parsing required.  
#       JSON data type is understood by python.

for album in data['album']:
    print("\n", album['title'], ": ")
    for track in album['album_tracks']:
        print("   - ", track['name'])

# runs in roughly 193ms