import json
from pprint import pprint

with open('rhymeText.json', encoding='utf8', errors = 'ignore') as data_file:
    parsed_json = json.load(data_file)

counter = 1
for rhyme in parsed_json['rhymes']:
    while (counter < 239):
        counter += 1
        if (counter % 10 == 1):
            counter += 1
        address = str(counter) + "r"
        print (rhyme[address]['title'])
        if (rhyme[address]["collection"] == "Volland"):
            print ("Sorting into Volland")


            name = 'Volland_Packs/V_' + str(rhyme[address]["id"]) + '/text.txt'
            with open(name, "w") as g:
                g.write(rhyme[address]["text"])
            name = 'Volland_Packs/V_' + str(rhyme[address]["id"]) + '/title.txt'
            with open(name, "w") as g:
                g.write(rhyme[address]["title"])