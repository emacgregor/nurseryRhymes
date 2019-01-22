#Credit to https://towardsdatascience.com/auto-transcribe-google-speech-api-time-offsets-in-python-7c24c4db3720

import argparse
import io
import os

#tqdm will let us watch progress
from tqdm import tqdm
from google.oauth2 import service_account


credentials = service_account.Credentials.from_service_account_file('api-key.json')

def transcribe_file_with_word_time_offsets(speech_file,language):
    #This outermost loop exists to handle multiple audio file rhymes, ones longer than 50 seconds
    files = sorted(os.listdir(speech_file))
    transcript = ''
    offset = 0
    for f in files:
        print("Start")

        from google.cloud import speech
        from google.cloud.speech import enums
        from google.cloud.speech import types

        print("checking credentials")

        client = speech.SpeechClient(credentials=credentials)

        print("Checked")
        print(f)
        with io.open(speech_file + "/" + f, 'rb') as audio_file:
            content = audio_file.read()

        print("audio file read")

        audio = types.RecognitionAudio(content=content)

        print("config start")
        config = types.RecognitionConfig(
                encoding=enums.RecognitionConfig.AudioEncoding.LINEAR16,
                language_code=language,
                enable_word_time_offsets=True)

        print("Recognizing:")
        response = client.recognize(config, audio)
        print("Recognized")

        for result in response.results:
            alternative = result.alternatives[0]
            print('Transcript: {}'.format(alternative.transcript))

            for word_info in alternative.words:
                word = word_info.word
                start_time = word_info.start_time
                end_time = word_info.end_time
                transcript += 'Word: {}, start_time: {}, end_time: {}'.format(
                    word,
                    start_time.seconds + start_time.nanos * 1e-9 + offset,
                    end_time.seconds + end_time.nanos * 1e-9 + offset)
                transcript += "\n"
        offset += 50
    print (transcript)
    #Name is modified to be a text file. 5 is length of 'wavs/'
    name = 'transcripts/' + speech_file[5:] + '.txt'
    with open(name, "w") as g:
        g.write(transcript)

print("Copying mp3s to wavs")
for filename in tqdm(os.listdir('mp3s/')):
    if (filename.endswith(".mp3")):
        print (filename)
        os.system('mkdir "wavs\\' + filename[0:-4] + '"')
        command = 'ffmpeg -i "mp3s/' + filename + '" -ac 1 -f segment -segment_time 50 "wavs/' + filename[0:-4] + '/' + filename[0:-4] + '%09d.wav" -y'
        os.system(command)

files = sorted(os.listdir('wavs/'))
for f in tqdm(files):
    print(f)
    name = "wavs/" + f
    transcribe_file_with_word_time_offsets(name, "en-US")