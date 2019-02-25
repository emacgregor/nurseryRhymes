import json
import os
from pprint import pprint

with open('rhymeText2.json', 'r', encoding='utf8') as data_file:
    parsed_json = json.load(data_file)
pprint(parsed_json)

id = 109
for item in os.listdir('rhyme_files'):
    if (item[-3:] == 'txt' and item[-11:-4] != "Volland"):
        name = item.replace('Jerrold.txt','').replace('MGV.txt','').replace('FGV.txt','')
        collection = ''
        if ('Jerrold.txt' in item):
            collection = 'Jerrold'
        elif ('FGV.txt' in item):
            collection = 'FGV'
        elif ('MGV.txt' in item):
            collection = 'MGV'
        text = open("rhyme_files/" + item, 'r').read()
        print (name)
        print (collection)
        print (text)
        print (id)
        print ()
        parsed_json.append({
            'id': str(id),
            'title': name,
            'collection': collection,
            'text': text
            })
        id += 1
pprint(parsed_json)
with open('test.json', 'w', encoding='utf8') as out:
    json.dump(parsed_json, out, indent=4)