import json
import os

# Get the absolute path to the user's home directory
home_dir = os.path.expanduser("~")

# Open the file: ~/Downloads/com.apple.windowserver.displays.json
with open(f"{home_dir}/Downloads/com.apple.windowserver.displays.json") as f:
    data = json.load(f)

for configs in data['DisplayAnyUserSets']['Configs']:
    DisplayConfig = configs['DisplayConfig']
    for DisplaySets in DisplayConfig:
        #check for key 'LinkDescription'
        if 'LinkDescription' in DisplaySets:
            #delete the key 'LinkDescription'
            del DisplaySets['LinkDescription']
        
        #add the key 'LinkDescription' with value
        ''' x = { "LinkDescription" : {
              "EOTF": 0,
              "BitDepth": 8,
              "PixelEncoding": 0,
              "Range": 1
            }
        }'''
        #append the key 'LinkDescription' with value
        DisplaySets.update({"LinkDescription" : {
                "EOTF": 0,
                "BitDepth": 8,
                "PixelEncoding": 0,
                "Range": 1
                }
            })

# Write the file: ~/Downloads/com.apple.windowserver.displays.json
with open(f"{home_dir}/Downloads/com.apple.windowserver.displays.json", 'w') as f:
    json.dump(data, f, indent=4)