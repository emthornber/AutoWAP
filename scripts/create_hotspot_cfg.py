# python program to create hotspot.cfg from hotspot-config-defn.json

import json

# Open JSON file
f = open('./config/hotspot-config-defn.json')

# returns JSON object as a dictionary
data = json.load(f)

# print(list(data.values()))

# Interating through the json list
for (k, v) in iter(data.items()):
    print(k, '="', v.get('current'), '"', sep='', end='\n')

# Close the file
f.close()
