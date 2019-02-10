import os

for file in os.listdir('Jerrold Rhymes/'):
    print (file)
    name = 'Jerrold Rhymes/' + file
    print (name)
    name2 = name
    print (name2)
    os.rename(name, name2.split('.')[0] + 'Jerrold.' + name2.split('.')[1])