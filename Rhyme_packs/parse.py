import json
import os
from pprint import pprint
import shutil

"""for file in os.listdir('Jerrold/Successes/'):
    print ('Jerrold/Successes/' + file[9:])
    os.rename('Jerrold/Successes/' + file, 'Jerrold/Successes/' + file[9:])"""

with open('rhymeText.json', 'r', encoding='utf8') as data_file:
    parsed_json = json.load(data_file)

counter = 1
for folder in os.listdir('Jerrold/Failures'):
    title = ""
    """if (len(os.listdir('Jerrold/Failures/' + folder)) == 1):
        shutil.rmtree("Jerrold/Failures/" + folder)
    else:"""
    for file in os.listdir('Jerrold/Failures/' + folder):
        if (file[-5:] == "title"):
            title = file[:-6]
    print (title)
    for rhyme in parsed_json:
        if (rhyme["title"] == title and rhyme["collection"] == "Jerrold"):
            print ("I found one, I found one!")
            file = open("Jerrold/Successes/" + title + "Jerrold.txt", "w")
            file.write(rhyme["text"])
            os.rename('Jerrold/Failures/' + folder + "/Artwork.jpg", "Jerrold/Successes/" + title + "Jerrold.jpg")
            os.rename('Jerrold/Failures/' + folder + "/Audio.mp3", "Jerrold/Successes/" + title + "Jerrold.mp3")
            os.rename('Jerrold/Failures/' + folder + "/transcript.txt", "Jerrold/Successes/" + title + "Jerrold.transcript")
            shutil.rmtree("Jerrold/Failures/" + folder)