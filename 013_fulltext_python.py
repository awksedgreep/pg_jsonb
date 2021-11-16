#!/usr/bin/env python3

import sys
import json
import psycopg2

if len(sys.argv) == 1:
    search_phrase = "one"
else:
    search_phrase = sys.argv[1]

conn = psycopg2.connect(dbname="chinook", user="example", 
  password="demo", host="127.0.0.1")

cr = conn.cursor()
cr.execute("SELECT * FROM artist_data WHERE to_tsvector('english', artist_data) @@ to_tsquery('{}')".format(search_phrase))
res = cr.fetchall()

for row in res:
    data = row[0]
    for album in data['album']:
        print("\n", album['title'], ": ")
        for track in album['album_tracks']:
            print("   - ", track['name'])
