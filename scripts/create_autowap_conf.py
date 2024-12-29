# Create autowap.conf from autowap-config-defn.json current values
#
#   28 December, 2024 - E M Thornber
#   Created
#

import json
import sys

# Read JSON data and return JSON object as a dictionary
data = json.load(sys.stdin)

# Interate through the json list and output to sys.stdout
for (k, v) in iter(data.items()):
    print(k, '="', v.get('current'), '"', sep='', end='\n')
