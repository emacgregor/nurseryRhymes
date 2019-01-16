#Credit to https://towardsdatascience.com/auto-transcribe-google-speech-api-time-offsets-in-python-7c24c4db3720

import argparse
import io
import os

from tqdm import tqdm
from google.oauth2 import service_account


credentials = service_account.Credentials.from_service_account_file('api-key.json')


def transcribe_file_with_word_time_offsets(speech_file,language):
    """Transcribe the given audio file synchronously and output the word time
    offsets."""
    print("Start")

    from google.cloud import speech
    from google.cloud.speech import enums
    from google.cloud.speech import types

    print("checking credentials")

    client = speech.SpeechClient(credentials=credentials)

    print("Checked")
    with io.open(speech_file, 'rb') as audio_file:
        content = audio_file.read()

    print("audio file read")

    audio = types.RecognitionAudio(content=content)

    print("config start")
    config = types.RecognitionConfig(
            encoding=enums.RecognitionConfig.AudioEncoding.FLAC,
            language_code=language,
            enable_word_time_offsets=True)

    print("Recognizing:")
    response = client.recognize(config, audio)
    print("Recognized")

    transcript = ''
    for result in response.results:
        alternative = result.alternatives[0]
        print('Transcript: {}'.format(alternative.transcript))

        for word_info in alternative.words:
            word = word_info.word
            start_time = word_info.start_time
            end_time = word_info.end_time
            transcript += 'Word: {}, start_time: {}, end_time: {}'.format(
                word,
                start_time.seconds + start_time.nanos * 1e-9,
                end_time.seconds + end_time.nanos * 1e-9)
            transcript += "\n"
            #print('Word: {}, start_time: {}, end_time: {}'.format(
            #    word,
            #    start_time.seconds + start_time.nanos * 1e-9,
            #    end_time.seconds + end_time.nanos * 1e-9))
        print (transcript)
        #Name is modified to be a text file. 6 is length of 'flacs/' and -4 is 'flac'
        name = 'transcripts/' + speech_file[6:-4] + 'txt'
        with open(name, "w") as f:
            f.write(transcript)

files = sorted(os.listdir('flacs/'))
for f in tqdm(files):
    name = "flacs/" + f
    transcribe_file_with_word_time_offsets(name, "en-US")