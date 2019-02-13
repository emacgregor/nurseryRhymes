import os
import re
from shutil import copyfile

for filename in os.listdir('Home Experiences'):
    name = filename
    filename = filename.replace('_', ' ')
    label = re.sub("([A-Z])"," \g<0>",filename).replace('  ', ' ')
    filename = label
    name1 = filename[1:-6] + "MGV" + filename[-4:]
    name2 = filename[1:-6] + "FGV" + filename[-4:]
    name1 = name1.lower()
    name2 = name2.lower()
    lowerDir = []
    for file in os.listdir('rhyme_files'):
        lowerDir.append(file.lower())
    if name1 in lowerDir:
        copyfile('Home Experiences/' + name, 'rhyme_files/' + os.listdir('rhyme_files')[lowerDir.index(name1)][:-4] + "HE" + filename[-5:])
    if name2 in lowerDir:
        copyfile('Home Experiences/' + name, 'rhyme_files/' + os.listdir('rhyme_files')[lowerDir.index(name2)][:-4] + "HE" + filename[-5:])
    if name1 not in lowerDir and name2 not in lowerDir:
        copyfile('Home Experiences/' + name, 'BADHEs/' + name)