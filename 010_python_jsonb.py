#!/usr/bin/env python3

import json
import psycopg2

conn = psycopg2.connect(dbname="chinook", user="example", 
  password="demo", host="127.0.0.1")

cr = conn.cursor()
cr.execute("SELECT * FROM artist_data WHERE artist_data->>'name' = 'Metallica'")
data = cr.fetchone()[0]

for album in data['album']:
    print("\n", album['title'], ": ")
    for track in album['album_tracks']:
        print("   - ", track['name'])

# runs in roughly 7.2ms or 26.81x faster on just 200 rows