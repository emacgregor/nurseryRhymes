import json
import os
from pprint import pprint
import shutil

"""for file in os.listdir('Father Goose/Successes/'):
    print ('Father Goose/Successes/' + file[9:])
    os.rename('Father Goose/Successes/' + file, 'Father Goose/Successes/' + file[9:])"""

with open('rhymeText.json', 'r', encoding='utf8') as data_file:
    parsed_json = json.load(data_file)

counter = 1
for folder in os.listdir('Father Goose/Failures'):
    title = ""
    """if (len(os.listdir('Father Goose/Failures/' + folder)) == 1):
        shutil.rmtree("Father Goose/Failures/" + folder)
    else:"""
    for file in os.listdir('Father Goose/Failures/' + folder):
        if (file[-5:] == "title"):
            title = file[:-6]
    print (title)
    for rhyme in parsed_json:
        if (rhyme["title"] == title and rhyme["collection"] == "Father Goose Visit"):
            print ("I found one, I found one!")
            file = open("Father Goose/Successes/" + title + "FGV.txt", "w")
            file.write(rhyme["text"])
            os.rename('Father Goose/Failures/' + folder + "/Artwork.jpg", "Father Goose/Successes/" + title + "FGV.jpg")
            os.rename('Father Goose/Failures/' + folder + "/Audio.mp3", "Father Goose/Successes/" + title + "FGV.mp3")
            os.rename('Father Goose/Failures/' + folder + "/transcript.txt", "Father Goose/Successes/" + title + "FGV.transcript")
            shutil.rmtree("Father Goose/Failures/" + folder)