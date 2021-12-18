---
title: Navigating Main Screen
description: 
---
**Previous page:** <u><a href="{{site.baseurl}}/Chapter1">Chapter 1: How to start and manage files</a></u>

2	Navigating the Main Screen
=====
The main screen of Rezonator is our visual representation of the text imported delineated into tokens and units. 

![image45](https://user-images.githubusercontent.com/34769184/132994278-f4c43f7d-36f2-4c4b-a626-cf16ab463f9e.png)

The main screen consists of four major sections:
* The Workspace where the document is displayed and edited
* The Tool Pane is the vertical section on the right
* The Navigation Window is above both of those
* Finally the Menu Bar is at the top of the screen

## 2.1 Workspace 

The Workspace is a malleable area where the user can view token and unit level fields. This is also the actionable space where most data annotation will occur. The workspace can be scrolled using the scroll bar or by using other quick navigation hotkeys linked to the arrow keys. The workspace can be used to show different sections of the document based on what the user is trying to filter on.

### 2.1.1 Word Editing

**Word Editing** allows you to modify the words or tokens on the Main Screen, allowing for more annotation options. Use cases of Word Editing include splitting compound words to annotate the pieces separately, and inserting placeholder or implicit words like the Zero morpheme.

To begin Word Editing, **Right Mouse Click** on a word/token in the Main Screen. This will open a dropdown menu containing the options **New Token,  Delete Token,** and **Tag**. 
 - **Note:** When the selected word is in a Chain, this dropdown will have an additional option called **Delete Link**. This does not pertain to Word Editing.

- The **New Word** option allows you to insert a new word into the discourse. Selecting this option will activate another dropdown with the options < 0 >, < ZERO >, < PRO >, and **Custom**.
  - < 0 >, < ZERO >, and < PRO > are all default new words. Selecting one of these defaults will insert that word as a new token. 
  - The **Custom** option will prompt you with a input box to add your own text. clicking the **OK** button will insert the New Word before the selected word. Toggling the **Insert Before** button will have the New Word inserted after the selected word.
- The **Delete Token** option will delete the selected token.
- The **Tag** option will allow you to tag the **token** or the chain the token is associated with on both the **entry** and **chain** level.

 Tags can be further managed in the **Tag** pane on the Navigation window.

### 2.1.2 Text Direction

 Two forms of text direction are currently supported in Rezonator, **Right-To-Left** and **Left-To-Right**. The text direction of the text is chosen by default based on the type of characters imported. If they require Right-To-Left then it will be enabled by default. This option can always be toggled by using the “L” key, or using the view drop down.

## 2.2 Tool Pane

 The Tool pane consist of 7 sections

### 2.2.1 Tools  
 
 * **Resonance**: The Resonance tool is used to add words to a chain that will try to align to the furthest display column.
 * **Track**: The Track tool is used to add words to a chain that will not try to align.
 * **Tag**: The Tag tool allows the user to add tags to existing fields where applicable

### 2.2.2 Filter

Displays whether a filter is actively being viewed and can be used to toggle the filter on and off.

### 2.2.3 Context

  * **Context Above**: While in a filter, enabling this option shows all units prior to the first unit gathered in the filter.
  * **Context Between**: While in a filter, enabling this option shows all units between the first and last unit gathered in the filter.
  * **Context Below**: While in a filter, enabling this option shows all units after the last unit gathered in the filter.

### 2.2.4 Justify

  * **Left Prose**: This option spaces out by word length and is left justified.
  * **Left Grid**: This option spaces out by set grid distances and is left justified.
  * **Right Prose**: This option spaces out by word length and is right justified.
  * **Right Grid**: This option spaces out by set grid distances and is right justified.

### 2.2.5 One to Many & One to One

  * **One to Many**: Enabling this option switches the navigation window to One to many mode.
  * **One to One**: Enabling this option switches the navigation window to One to one mode.

### 2.2.6 Audio

 The Audio button here toggles the audio pane where playback can be managed.

### 2.2.7 Help

 Help, opens the window that describes the useful hotkeys for navigation.

## 2.3	Navigation Window 

### 2.3.1 Unit

![unit-Tab](https://user-images.githubusercontent.com/46977535/146622375-ed6a648c-60f8-4aa9-8849-80b38d52c4c5.png)

 **Left Pane**: 
 Displays a list of all the units within the current file. Units can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One**: Shows unit tags in relation to the unit on the same row, based on the selected fields in the column headers.
  * **One-To-Many**: Shows token tags in relation to the unit that is selected in the left pane, based on the selected fields in the column headers.

### 2.3.2 Chunk

![Chunk-Tab](https://user-images.githubusercontent.com/46977535/146622383-2579e6e4-b2a3-472e-acda-c51039f8f5e4.png)

 **Left Pane**: 
 Displays the list of all the chunks within the current file. Chunks can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One**: Shows chunk tags in relation to the chunk on the same row, based on the selected fields in the column headers.
  * **One-To-Many**: Shows tags for the tokens contained within the chunk that is selected in the left pane, based on the selected fields in the column headers.

### 2.3.3 Translate

![Translation-Tab](https://user-images.githubusercontent.com/46977535/146622620-4b8ab122-c08b-4ad7-a4a4-7622bdedfd73.png)

 **Left Pane**: 
 Displays the list of all the units within the current file.

 **Right Pane**: 
  * **One-To-One / One-To-Many**: Shows the unit tag that the user selects as their current translation.
 
 - **Note:** This tab is only present if a unit field has been selected as to be a trnslation field.

### 2.3.4 Stack

![stack-Tab](https://user-images.githubusercontent.com/46977535/146622633-8fa0b3c3-b371-4adf-a21e-e5288af06937.png)

 **Left Pane**: 
 Displays the list of all the stacks within the current file. Stacks can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One**: Shows chain tags in relation to the stack on the same row, based on the selected fields in the column headers.
  * **One-To-Many**: Shows chain entry tags in relation to the stack that is selected in the left pane, based on the selected fields in the column headers.

### 2.3.5 Track

 ![Track-Tab](https://user-images.githubusercontent.com/46977535/146622636-b6efa4f2-dfd6-472d-826c-2f2c659a2fde.png)

 **Left Pane**: 
 Displays the list of all the trails within the current file. Trails can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One**: Shows chain tags in relation to the trail on the same row, based on the selected fields in the column headers.
  * **One-To-Many**: Shows chain entry tags in relation to the trail that is selected in the left pane, based on the selected fields in the column headers.

### 2.3.7 Clique

![Clique-Tab](https://user-images.githubusercontent.com/46977535/146622652-edf122a0-9ab2-49f8-a9de-922a37eb3dd1.png)

 **Left Pane**: 
 Displays the list of all the cliques within the current file. Cliques can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One / One-To-Many**: Displays all of the chains within the clique selected in the left pane. Each chain shows it's pushing order for alignment. 

### 2.3.8 Tree

![tree-Tab](https://user-images.githubusercontent.com/46977535/146622660-25eeba0f-4bc8-41e8-b5a9-bb2bb5082588.png)

 **Left Pane**: 
 Displays the list of all the trees within the current file. Trees can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One / One-To-Many**: The selected tree is shown broken out into leaves that can be linked together and annotated into a tree.

### 2.3.9 Show

![Show TAB](https://user-images.githubusercontent.com/46977535/146622667-77f5c0c7-9e06-43ac-bc5c-6560dd89623f.png)

 **Left Pane**: 
 Displays the list of all the shows within the current file. Shows can be selected here for further analysis in the right pane.

 **Right Pane**: 
  * **One-To-One / One-To-Many**: Shows the user the list of stacks within the selected show. Here the user can add more stacks to the show, or start/stop the show.

### 2.3.10 Tag

![TAG TAB NEW](https://user-images.githubusercontent.com/46977535/146622677-b9519aef-774c-4300-bd6f-aa2118e6e6e0.png)

 **Left Pane**: 
 Displays the list of all the fields within the current file. Fields can be selected here to edit their tag set in the right pane.

 **Right Pane**: 
 Has a selection box that allows the user to change which type of tags they are viewing

 **Doc**
  - **One-To-One**: Allows the user to edit **Unit** level tags
  - **One-To-Many**: Allows the user to edit **Token** level tags 
 
 **Chain**
  - **One-To-One**: Allows the user to edit **Chain** level tags
  - **One-To-Many**: Allows the user to edit **Entry** level tags
 
 **Chunk**
  - **One-To-One / One-To-Many**: Allows the user to edit **Chunk** level tags
 
 **Link**
  - **One-To-One / One-To-Many**: Allows the user to edit **Link** level tags

### 2.3.11 Search

![Search TAB](https://user-images.githubusercontent.com/46977535/146622686-57b7ad7d-05ca-4c9a-8bd1-b9071fdd9995.png)

 **Left Pane**: Displays the list of all the searches within the current file. Searches can be selected here for further analysis in the right pane.
 
 **Right Pane**: 
  * **One-To-One / One-To-Many**: Shows the user all the found instances of the selected searched words, along with prior and post context to the found words.

## 2.4	Menu Bar 

### 2.4.1 File Dropdown

 - The **Save** option will save the current **Rez File**, and all of the changes that have been made since last saving or opening. This option will overwrite the Rez File’s current location.
 - The **Save As** option functions identically to the **Save** button, except that the Save As button does not overwrite the current Rez File. This option will have the user choose a file location and a file name.
 - The **Media** option will have the user choose an **Audio File** (.OGG) to open up with the current Rezonator session.
 - The **Export** option will export the current Rez File as a collection of CSV files. The user will be prompted to provide a file location and file name.
 - The **Import** option exits the current file to allow the user to import a new file.
 - The **Exit** option from the File dropdown will exit the current Rezonator session and bring the user back to the Opening Screen.
 
### 2.4.2 Edit Dropdown

  - The **Delete All** option will open another dropdown:
    - **Trail Chains** allows the user to delete all Trail Chains in the Rez file.
    - **Rez Chains** allows the user to delete all Rez Chains in the Rez file.
    - **Stacks** allows the user to delete all Stacks in the Rez file.
    - **Chains** allows the user to delete all Chains in the Rez file.
  - The **Go To Line** option opens a text input box. The user can input a line number, and their **Main Screen** will scroll to that location.
  - The **Go To Time** option opens a text input box. The user can input a time in seconds, and their **Main Screen** will scroll to that location.

### 2.4.3 View Dropdown

- The **Window** option will open another dropdown:  
  - The **Nav** option will open another dropdown:  
   - **Left** will open/close the **List Window**  
   - **Right** will open/close the **Contents Window**  
   - **Nav** will open/close the **List Window** and the **Contents Window** 
   - **Tools** will open/close the **Tools Pane**  
   - **All** will open/close the **List and Contents window, and the Tools Pane.**   
  - **Grid** will send the user to the **Grid Screen**. 
- The **Justify** option will open another dropdown:  
  - **Left** will justify the **Tokens** to the left side of the screen.  
  - **Right** will justify the **Tokens** to the right side of the screen. 
  - **Center** will justify the **Tokens** to the center of the screen. 
 
- **Prose** option will open another dropdown:  
  - **Prose** will set the Tokens in a prose structure.  
  - **Grid** will set the Tokens in a grid structure. 
- The **Hide** option will open another dropdown:  
  - **Trail** will toggle the visibility of all Trail chains in the Rez file.
  - **Rez** will toggle the visibility of all Rez chains in the Rez file.
  - **Stack** will toggle the visibility of all Stack in the Rez file.

### 2.4.4 Filter Dropdown
       
 - The **Filter** option will toggle on/off the **Filter Screen** (if any chains are **Picked** to be in the filter).
 - The **Pick** option will open another dropdown:
   - **Rez** will **Pick** all Rez chains to be in the Filter
   - **Trail** will **Pick** all Trail chains to be in the Filter
   - **Stack** will **Pick** all Stacks to be in the Filter
 - The **Context** option will open another dropdown:
   - **Above** will toggle the display of the Lines before the Picked Lines in the Filter Screen.
   - **Between** will toggle the display of the Lines in between the Picked Lines in the Filter Screen.
   - **Below** will toggle the display of the Lines after the Picked Lines in the Filter Screen.
 - The **Clear** option will unpick all **Picked Chains**, clearing the Filter Screen, and sending the user back to the **Main Screen** if the Filter Screen was open.

## 2.4.5 Tools Dropdown

 - The **Search** option will open another dropdown:
  - **Keyword** will open a dialogue box for Rezonator’s **Search by Keyword** function
  - **Clear** will turn off the highlighting for the **Actively Searched Keywords** that occurs on the Main Screen (if a Search has been done in the Rezonator session).
 - The **Track** option will set the current **Mode** to **Track Mode**
 - The **Resonance** option will set the current **Mode** to **Resonance Mode**
 - The **Stack** option will open another dropdown:
   - The **Stacker** option will open another dropdown:
    - The **Turn** option will create a series of **Stacks** in the document using the **Unit** field marked as **Turn Delimiter**
    - The **Random** option will create a series of **Stacks** across the entire document
    - The **Sentence** option will create a series of **Stacks** using the **Unit** field makred as the **Participant**
   - The **Clip all stacks** option will create a folder to save a series of **Clip** files for each **Stack** in the document

### 2.4.6 Settings Dropdown

 - The **User** option allows the user to set a **Username** for the current chain creator.

 - The **Zoom** option will open another dropdown: 
   - **Zoom-in** will increase the **Font Size, Line Height, and Column Width**.
   - **Zoom-out** will decrease the **Font Size, Line Height, and Column Width**.
   - **Wide** will increase **Column Width**.
   - **Narrow** will decrease **Column Width**.
   - **Tall** will increase the **Line Height**.
   - **Short** will decrease the **Line Height**.
 - The **Theme** option will toggle the current **Display Theme** between **Light** and **Dark**.
 - The **Language** option will open another dropdown, allowing the user to set their **User language**
 - The **Autosave** option will open another dropdown, allowing the user to set the timing intervals at which Rezonator will **Autosave** the current Rezonator session, or to disable Autosaving.
 - The **Advanced** option will open another dropdown:
   - The **Developer** option will toggle the visibility of developer variables in the **Main Screen**

### 2.4.7 Help Dropdown

 - The **Help** option will toggle the display of the **Help Menu** on the right side of the **Main Screen**.
 - The **Guide** option will link the user to the Rezonator website’s “Documentation” page in their default web browser.
 - The **About** option will link the user to the Rezonator website’s “About” page in their default web browser.
 
**Next page:** <u><a href="{{site.baseurl}}/Chapter3">Chapter 3: Annotation Tools</a></u>
