---
title: How to Start and Manage Files
description: 
---
Chapter 1:	How to start
=====
**To open Rezonator, double click on the Rezonator icon on your desktop or select the icon from the Start menu. The Open screen will be displayed:**

![unnamed](https://user-images.githubusercontent.com/77072787/133002427-7aa061ac-c1ed-4c3f-8037-d204a75bd726.png)

**The main options are:**
- Open: allows you to open a REZ file
- Import: different formats are supported and described in depth later on.
- Help: opens the portal to our help resources

### 1.1	Select a user interface language

Rezonator supports multiple user interface languages. You can change the user interface language at any time. Upon opening Rezonator, you can select the language code on the upper right corner and change the language.

![unnamed-1](https://user-images.githubusercontent.com/77072787/133002587-7f9a2670-6d4e-4a82-9566-9797a402347d.png)

You can also change language from the Menu bar selecting Settings > Language. At present, Rezonator supports Chinese, Hebrew, Italian, Japanese, Spanish, Vietnamese, Kazakh, Russian, Gujarati, and Armenian. New languages can be easily added: if you would like to contribute to the translation in a different language, please contact the Rezonator team.

You can also immediately incorporate a new translation on your locale. Under the directory Localization found in the directory where Rezonator has been installed, you will find a set of files named “locale_” followed by the two-letter code identifying the language of the localization (e.g. “locale_en” for English). You can use any of these files as the basis for the translation. The files are organized in a JSON dictionary, and you will need to translate only the values in order to ensure the correct functioning of the code. Modify the first value of the file to reflect the two-letter code referring to the new target language and save the file following the naming convention. Insert the new file in the Localization folder. Close and reopen Rezonator.

### 1.2	Opening a REZ File

Rezonator is distributed with a set of native REZ files which allow users to start working directly on the Santa Barbara Corpus of Spoken American English. In order to open a REZ file, select the option **Open** from the Opening screen. You will then be prompted to open a REZ file of your choice.

### 1.3	Importing a New File

The **Import** button on the **Opening Screen** allows users to open linguistic data and start a new Rezonator session.
At any point, you can import new data by selecting from the **Menu Bar** in the top left corner of Rezonator the option **File** > **Import**. You will be prompted to the import screen, which allows for selection of the type of data to be imported.
At any point during the working session, selecting the **Exit** option will exit the current Rezonator session and bring the user back to the Opening Screen.

### 1.3.1	Data types supported by Rezonator

Rezonator supports TXT and CSV. There are seven different **Import** functions, each of which has been set up to deal with data organized in different ways that reflect a variety of linguistic analysis. What follows is a description of the data types that are supported so that you can select the most convenient schema for your data.

### 1.3.2	Song & Verse

![unnamed-2](https://user-images.githubusercontent.com/77072787/133002833-e6937f7a-4281-4a33-8249-f62c28365eb3.png)


Song & verse data consists of short lines of text in which line breaks are meaningful. Within this schema, there is no word wrap and words are split on whitespace. The accepted file type is plain text (.TXT). Examples include songs and poems. 

### 1.3.3	Prose

![unnamed-3](https://user-images.githubusercontent.com/77072787/133002842-3c94632d-efc5-45dc-9451-4acca83754c1.png)


Prose data consists of long paragraphs of text. Within this schema, data is organized with a hard return at the end of the paragraph. Words are also split on whitespace. The accepted file type is plain text (.TXT). Examples include news articles, blogs, Wikipedia pages, and novels.  

### 1.3.4	One Word Per Line (OWPL)

![unnamed-4](https://user-images.githubusercontent.com/77072787/133002847-1c71724e-8aa3-4c46-b64c-5f2795a09d50.png)


One Word Per Line (OWPL) data consists of columns and rows of text in which the text columns read vertically. Each row represents 1 word (token), while each column displays a word feature. The accepted file type is a spreadsheet (.CSV). An example shown above is a Santa Barbara Corpus .CSV file. 

### 1.3.5	CoNLL-U

![unnamed-5](https://user-images.githubusercontent.com/77072787/133002857-4d6df24d-6032-4ab5-88b1-b6a53fa9aede.png)


CoNLL-U data consists of columns and rows of text in which the text columns read vertically. Each row represents 1 word (token) while each column displays a word feature. Hashtag lines mark unit features. The accepted file type is a spreadsheet (.TXT). An example shown above is the Universal Dependencies corpus. 

### 1.3.6	Transcription

![unnamed-6](https://user-images.githubusercontent.com/77072787/133002876-27e0fdf1-047a-46af-9612-8a1c04ff5a7b.png)


Transcription data consists of one unit per line in which the text reads horizontally. There is a tab for speaker labels and an optional tab for timestamps. Within this schema, words are split on whitespace. The accepted file type is tab-delimited text (.TXT, .CSV). An example shown above is the Santa Barbara Corpus .TXT file. 

### 1.3.7	Elan (tab-delimited export)

![unnamed-7](https://user-images.githubusercontent.com/77072787/133002899-bf5bf758-948d-42c3-b98f-63939b647558.png)


Elan data consists of one unit per block in which each block has 1 or more lines. Within this schema, the text reads horizontally. There is a tab for speaker labels and a tab for timestamps with words split on whitespace. Once imported the file is sorted based on timestamps, defined by the unit-start and unit-end fields declared on import. The accepted file type is tab-delimited text (.TXT). An example shown above is the Santa Barbara Corpus .TXT file.

### 1.3.8	Interlinear Glossed Text (IGT)

![unnamed-8](https://user-images.githubusercontent.com/77072787/133002909-ee814a05-d148-4ecc-9a1b-0cf0a05be501.png)


Interlinear Glossed Text (IGT) consists of one unit per block in which each block has 2 or more lines. The blocks are separated by a blank line and the schema splits tokens on hyphens and whitespace. The accepted file type is plain text (.TXT). An example shown above is a conversation Nuu-chah-nulth. 

### 1.4	Import Screen  

Once a file has been imported, it may require more advanced input to interpret the file’s data. This can be done with the Import Screen, which will be presented for all import types except for Song & Verse and Prose.
The Import Screen is divided into four windows: **File Overview**, **Example**, **Import Fields**, and **Field Info**.

![unnamed-9](https://user-images.githubusercontent.com/77072787/133003024-c734506e-668e-4049-af42-4c61a80afeba.png)

The **File Overview** window will give you basic information about the file imported, such as the file’s name and how many lines were in it. This window also allows the user to save and load **Schemas**, which are useful files that contain preset import settings.

The **Examples** window displays the text data that Rezonator extracted from the imported file. It shows a single field of data at a time, and that field can be changed in the **Import Fields** window.

The **Import Fields** window is the section that requires the most user attention on the Import Screen, as it is the only window on the screen that allows for input. Each field is displayed as a row in this window, with clickable cells that allow users to adjust how the field will be interpreted. Clicking in the **Level** column of a cell will allow a selection between **Token, Word, Unit, Doc,** or **Unknown**. The method that Rezonator will use to split and distribute these levels will depend on the chosen import type, but here is a basic breakdown of the five possible field levels.

* **Token:** The smallest form of language data that the source file offers, usually at the word or morpheme level. Rezonator always requires at least one token level field.
* **Word (Interlinear Glossed Text only):** Groupings of tokens into words, only available in Interlinear Glossed Text for files that have tokens at morpheme level
* **Unit:** Language data at the utterance/intonation unit level
* **Doc:** Data that applies to the entire imported file
* **Unknown:** Data that should not be imported to Rezonator

The **Key** column of the **Import Fields** window allows the user to specify which field(s) should be used to delimit other fields of the same level. Rezonator will always require the **Key** column to specify the **Display Token**, which is the token level field that will be displayed immediately once the file has been interpreted. For the **One Word Per Line** and **CONLL-U** imports, the **Key** column will also require a **Unit** field to be specified as the **Unit Delimiter**. For the **Elan** import, the **Key** column allows **Unit** fields to be marked as **Unit Start** and **Unit End**, meaning that the data will be sorted by the timestamps in those fields.

The **Special** column allows for fields to be used in certain special features in Rezonator, such as Participant and Translation.

Finally, the **Field Info** window contains a breakdown of the imported fields on a technical level. It is a read-only window displaying how many tokens were found in each field, how consistently that field was marked in the file, and whether or not it contains any spaces.

**Next page:** <u><a href="{{site.baseurl}}/Chapter2">Chapter 2: Overview of Main Screen</a></u>
