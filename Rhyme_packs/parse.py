import json
import os
from pprint import pprint
import shutil

"""for file in os.listdir('Mother Goose/Successes/'):
    print ('Mother Goose/Successes/' + file[9:])
    os.rename('Mother Goose/Successes/' + file, 'Mother Goose/Successes/' + file[9:])"""

with open('rhymeText.json', 'r', encoding='utf8') as data_file:
    parsed_json = json.load(data_file)

counter = 1
for folder in os.listdir('Mother Goose/Failures'):
    title = ""
    """if (len(os.listdir('Mother Goose/Failures/' + folder)) == 1):
        shutil.rmtree("Mother Goose/Failures/" + folder)
    else:"""
    for file in os.listdir('Mother Goose/Failures/' + folder):
        if (file[-5:] == "title"):
            title = file[:-6]
    print (title)
    for rhyme in parsed_json:
        if (rhyme["title"] == title and rhyme["collection"] == "Mother Goose Visit"):
            print ("I found one, I found one!")
            file = open("Mother Goose/Successes/" + title + "MGV.txt", "w")
            file.write(rhyme["text"])
            os.rename('Mother Goose/Failures/' + folder + "/Artwork.jpg", "Mother Goose/Successes/" + title + "MGV.jpg")
            os.rename('Mother Goose/Failures/' + folder + "/Audio.mp3", "Mother Goose/Successes/" + title + "MGV.mp3")
            os.rename('Mother Goose/Failures/' + folder + "/transcript.txt", "Mother Goose/Successes/" + title + "MGV.transcript")
            shutil.rmtree("Mother Goose/Failures/" + folder)