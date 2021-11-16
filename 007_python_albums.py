#!/usr/bin/env python3

import json

with open('005_json_output.json') as f:
    data = json.load(f)

for album in data['album']:
    print("\n", album['title'], ": ")
    for track in album['album_tracks']:
        print("   - ", track['name'])

