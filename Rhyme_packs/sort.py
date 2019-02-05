import json
import os
from shutil import copyfile
from pprint import pprint

with open('rhymeText.json', encoding='utf8', errors = 'ignore') as data_file:
    parsed_json = json.load(data_file)

index = 1
folders = [x[0] for x in os.walk('Mother_Goose_Packs/Good Children/')]
print (folders)
print (len(folders))
print (len(parsed_json))
for i in range(1, len(folders)):
    rhyme = parsed_json[i + 172]
    print (i)
    print (folders[i])
    Vname = folders[i] + '/'
    Vtranscript = Vname + "transcript.txt"
    Vtext = rhyme["text"]
    Vmp3 = Vname + "Audio.mp3"
    Vjpg = Vname + "Artwork.jpg"
    title = rhyme["title"].replace(',','').replace('\n','').replace('?','')
    out = "Mother Goose Rhymes/"
    copyfile(Vtranscript, out + title + ".transcript")
    open(out + title + ".txt","w").write(Vtext)
    copyfile(Vmp3, out + title + ".mp3")
    copyfile(Vjpg, out + title + ".jpg")
    print (rhyme["title"])
'''for rhyme in parsed_json:
    if int(rhyme["id"]) < 109:
        Vname = 'Jerrold_Packs/J_' + str(index) + '/'
        Vtranscript = Vname + "transcript.txt"
        Vtext = Vname + "text.txt"
        Vmp3 = Vname + "Audio.mp3"
        Vjpg = Vname + "Artwork.jpg"
        title = rhyme["title"].replace(',','').replace('\n','').replace('?','')
        out = "Volland Rhymes/"
        copyfile(Vtranscript, out + title + ".transcript")
        copyfile(Vtext, out + title + ".txt")
        copyfile(Vmp3, out + title + ".mp3")
        copyfile(Vjpg, out + title + ".jpg")
        print (title)
        index += 1'''