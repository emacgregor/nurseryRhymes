# Brainy Rhymes iOS App

[Detailed App Design can be found at this link although some information is out of date.](https://docs.google.com/document/d/1xRam5eJiMkiYQgREFOsiDq2i2PLyu6ab0oSNIe0MQBE/edit#heading=h.5izxyaemfqe)

## Release Notes
### *v1.0*
### New features:
* Library of nursery rhymes complete with audio, word highlighting, and friendly imagery.
* Home experiences tied to certain rhymes in the Mother Goose and Father Goose collection.
* Quizzes in the Jerrold collection.
* Child-friendly user interface easy for navigating.
* Coins reward system.
* Metadata on student’s rhyme listening habits and quiz performance.
### Bug fixes:
* N/A
### Known bugs and defects:
* Word highlighting in Volland collection is broken and currently disabled.
* Crash when scrolling past the 73rd rhyme in "Father Goose Rhymes." This is consistent even if some previous rhymes are removed, it remains the 73rd. This issue also only shows itself on real devices, not simulators.

## Future Features
1.	Add analytics
2.	Fix word highlighting (this is currently disabled because it is broken)
3.	Sort rhymes by number (instructions on how is below)
4.	Add “More Rhymes”
5.	Combine multi-part rhymes into one entry.
6.	Autoplay one rhyme to the next.
7.	Add quiz audio for questions and answers.
8.	Fix "Father Goose Rhymes" crash
### Guide for sorting rhymes by number
1.	Navigate to nursery-rhymes\nursery-rhymes\rhyme_files . This contains the files for all the rhymes.
2.	Rename each file by prepending it’s collection number i.e. 001 - Old Mother GooseVolland.txt
3.	Tell the function that gets the name to ignore the first three numbers.


## Install Guide
### Download From App Store
#### Pre-requisites:
Must have an iOS device.
#### Instructions:
Search for “Brainy Rhymes” on the App Store and download “Brainy Rhymes”. Your iOS device will automatically download and install the application. You may run it by tapping on its application icon.

### Run Locally
Must have a Macintosh computer.
#### Instructions
1. Clone the Git Repository on your Macintosh using git clone https://gitlab.com/8343/nursery-rhymes.git on the command line
2. Download XCode on Macintosh
3. Open XCode
4. You should recieve the option to check out an existing project. Select this.
5. Navigate to nursery-rhymes\nursery-rhymes.xcodeproj and select it.
6. This should open the project in XCode. If you want to run it locally on a simulator, you may select the run button (play icon) in the top left.