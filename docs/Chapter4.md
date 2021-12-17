---
title: Functionalities of Rezonator
description: 
---

**Previous page:** <u><a href="{{site.baseurl}}/Chapter3">Chapter 3: Annotation Tools</a></u>

## 4.1 Navigation

Rezonator has a variety of functionalities that support and enhance data analysis.


### 4.1.1 Layout of Workspace

The workspace covers the bottom 2/3rds of the screen, and is the main display for your data in Rezonator. There’s multiple ways to navigate in the workspace. You can use either the **Mousewheel or Trackpad** to scroll slowly through the units shown in the workspace.

The **up/down Arrow Keys** on your keyboard can scroll one line at a time for more careful navigation. Also, the right and left arrow keys can be used to navigate right or left while in **Column View**. Holding down the up/down arrow keys allows for faster scrolling. Another option for scrolling is  the Scroll Bar. The **Scroll Bar** can be clicked into and dragged with the mouse in order to quickly navigate through lines.

The keyboard keys **Page Up** and **Page Down** will also navigate you quickly through the lines, one page full of lines at a time. Using the **Home** key will scroll the workspace horizontally to reveal the beginning of the unit, and using the **End** key will scroll the workspace horizontally to reveal the end of the unit. Finally, you can use **Ctrl and Up Arrow** to jump up to the first line on the Main Screen, and use **Ctrl and Down Arrow** to go immediately to the last line. Note that Mac users should use Command instead of Control.

### 4.1.2 Layout of the List Window

The List Window is the top-left window, and provides a secondary display of the Main Screen information. The List Window works identically to the Main Screen, with one main difference: You can focus rows in the List Window by clicking on them with your Mouse, and focused rows will display their contents in the **Contents Window**. We’ll get more into these contents in the next section, for now let’s talk navigating in the Line Window.

The **Mousewheel, Trackpad, and Up/Down arrow keys** work as they do in the Main Screen, and they also change the currently focused line. The **Scrollbar, Page Up/Down keys, and Ctrl + Up/Down Arrow keys** all work exactly as they do in the Main Screen. Also, when selected on the Unit tab, you can **Double Mouse Click** on a unit in the List Window, and the **Main Screen** will jump to this unit.

### 4.1.3	Layout of the Contents Window
The Contents Window, which is the top-right window, displays the contents of the currently focused row in the **List Window**. The data presented in the Contents Window is relative to the tab and row selected. The **Scroll Bar** can be used to navigate through the data in the Contents Window. Also, when selected on the Unit tab, you can **Double Mouse Click** on a row in the Contents Window, and the **Main Screen** will jump to the respective unit.

## 4.2 Search

**Search** in Rezonator allows you to find specific words or tokens within the discourse, and interact with the search results in useful ways.

### 4.2.1 Activating the Search Window

1. To activate the **Search Window**, **Left Mouse Click** on the “Search -> Keyword” option within the “Tools” dropdown.

2. Another way to activate the Search Window is by pressing the “F” key on the keyboard.

3. Both of these methods will show the Search Window.

![Screen Shot 2021-12-17 at 12 11 25 PM (2)](https://user-images.githubusercontent.com/36257165/146602359-bb0d42ea-0287-4aa4-afe3-abbfe1f192d0.png)
  
### 4.2.2 Functionality of the Search Window

The Search Window has 3 main components: the **Text Input Line**, the **Option selections**, and the **Confirmation Buttons**.
* The Text Input Line is where you type in text you want to find in the discourse.
* The option selections will activate different settings for the current Search
- **Field:** Refers to the token field that search will be lookin at.
- **Range:** Refers to the area in the dialogue to be lookin in.
- **Regular Expression:** When toggled, will allow for searching based on Regular Expression Format.
- **Case Sensitive:** When toggled, will limit matches to the input text to only those matching the capitalization of the input text.
* The Confirmation Buttons allow you to begin the Search, or cancel the Search.

Once the input text is typed and the Search is confirmed, Rezonator will scan through the discourse to find matches. If any matches are found, the search results will be shown on the Search Screen.
When a word or token has been marked as a match to the current Search, it will be highlighted in blue, both in the Search Screen and in the Main Screen
The search is also saved and can be toggled through the **Search Tab**.


### 4.2.3 Functionality of the Seach Tab

![Search - happy sbc035](https://user-images.githubusercontent.com/36257165/146602454-5f2052f8-ace3-477b-ae9d-54702b7e7569.gif)

The **Search tab** is used to keep a record of each search that has been made. On the left pane of the Search tab, there will be a list of every term that has been searched in the current file. This window also contains another button to create a new search.

Clicking on a search item in the left pane will activate that search, filtering the Main Screen so that only units containing the searched term are displayed. When a search is selected in the left pane, the right pane will show a list of appearances for the searched term with a preview of its context within the document. Clicking on a term in the right pane will jump the Main Screen to that corresponding unit.

To toggle whether the selected search should filter the Main Screen, click the **Enabled/Disabled** button in the top right corner of the right pane. To progress the Main Screen through the searched terms, use the **Find previous** and **Find next** buttons. To add a group of searched terms to a chain, use the checkboxes to select multiple searched terms and then click the **Add to Chain** button.

## 4.3 Filter

The **Filter Screen** is a modified version of the Main Screen, showing only Chains that have been **Picked** for the Filter. Resonance Chains, Trails, and Stacks can all be Picked and displayed in the Filter Screen.
* Here is an example of a single Chain in the Filter Screen:

![Screen Shot 2021-12-17 at 12 20 11 PM (2)](https://user-images.githubusercontent.com/36257165/146603274-e40e358b-ca3e-4fff-9308-5d29866ff60c.png)

### 4.3.1 Activating the Filter Screen

In order for the Filter Screen to be activated, at least one Chain must be Picked for the Filter. An example of a picked Chain is shown below:
<img width="534" alt="Screen Shot 2021-12-17 at 12 26 12 PM" src="https://user-images.githubusercontent.com/36257165/146603932-6ae6870e-2199-4574-ab00-c27920bd1913.png">

There are 2 ways to activate the Filter Screen: 
* Click on the **Filter Button in the Tool Pane**.

![Screen Shot 2021-12-17 at 12 24 27 PM (2)](https://user-images.githubusercontent.com/36257165/146603689-179f5111-62fc-447b-88d5-2e08ff967f46.png)
* Or you can press **CTRL** and **P** on the keyboard. (**Command** and **P** for Mac)

### 4.3.2 Functionality of the Filter Screen

The Filter Screen allows you to view the Picked Chains in different **Contexts**. These are activated by the **Context Button**. Select the Context Button in the right hand toolbar and then click on Above, Between, or Below.
* The **Context Above** button will add all the lines above the Picked Chains to the Filter Screen.
![Screen Shot 2021-12-17 at 3 03 22 PM (2) 3](https://user-images.githubusercontent.com/36257165/146617693-7d4ad93d-a340-47f0-bc3e-bc169b8f660e.png)

* The **Context Between** button will add the lines in between the lines within the Picked Chains.
![Screen Shot 2021-12-17 at 3 03 22 PM (2) 2](https://user-images.githubusercontent.com/36257165/146617737-e9c60edd-f4d4-4dd3-b90b-98eb38c714cf.png)

* The **Context Below** button will add all the lines below the Picked Chains to the Filter Screen.
![Screen Shot 2021-12-17 at 3 03 22 PM (2)](https://user-images.githubusercontent.com/36257165/146617745-67b3a8bf-6bc3-437c-8209-ac2205e8fec8.png)

All of the Contexts can be activated at the same time, or any combination of the three options.

## 4.4 Unique Nav Window Tabs

### 4.4.1 Show Tab

<img width="1015" alt="Screen Shot 2021-12-17 at 3 08 48 PM" src="https://user-images.githubusercontent.com/36257165/146617967-5ce355b7-ddfc-4533-904f-9c70c9f4fe23.png">

* Functionality
    * Here you can create a group of stacks called a **Show**. These shows can be played using the sequence of stacks listed in the right pane to filter each stack on the main screen.
* How to Use
    * Hitting the green **Create Show** button on the left side will create a new show that is empty to start. Then you can add stacks to that show using the right pane’s green **Add to show** button. The show can be started by hitting the play buttons on either side, and the arrow buttons will allow the user to cycle through the stacks when the show is playing.

### 4.4.2 Tree Tab

![screenshot S6](https://user-images.githubusercontent.com/36257165/146618086-60c9c1e9-23ee-4125-b911-bb69cce0855b.png)

* Functionality
    * The Tree pane allows for you to mark up dialogic syntax in units or stacks. The tokens in each tree are broken out into leafs that can be added to a tree. You can tag the links between the tokens for more analysis on the Tree level
* How to Use
    * A tree can be created by right clicking on a unit or a stack and choosing the **Create tree** option. This will spawn a tree in the tree pane with clickable tokens that create the tree when clicked upon. If nothing is selected the token will go to level 0 and become a root. That token will become selected and, when clicking on the next token, will rise to the next available level. You can click on open space to deselect and delete entries and links from the tree. Tree links can be tagged by right clicking on the link arrows between entries, and can also be tagged via the Tag tool. Trees can have multiple roots, and an existing root can also be added to any part of the tree that isn’t branching from that root.

### 4.4.3 Tag Tab

![Screen Shot 2021-12-17 at 3 12 47 PM (2)](https://user-images.githubusercontent.com/36257165/146618200-dba2f034-ed21-47bd-9131-6c9577129f6b.png)

* Functionality
    * The Tag tab is used to display every one of the document’s annotation fields along with its associated tag set. The fields are separated into four groups: Doc, Chain, Chunk, and Link. The Doc and Chain groups are also further separated into One-to-many and One-to-one groups.
* How to Use
    * In the top right of the right pane are a series of buttons where you can select which group of fields you want to view (Doc, Chain, Chunk, or Link). Select the group you want to view, and the left pane will show a list of fields for that group. Click on a field in the left pane to view its tag set in the right pane. To create a new field, scroll down to the bottom of the left pane and click **New field**. To add a tag to a field’s tag set, scroll down to the bottom of the right pane and click **New tag**.
    * If you select a field in the left pane and also select one of its tags in the right pane, you can quickly apply your selected field/tag pair to nodes in the Main Screen. To do this, switch your tool to the Tag tool (see: 3.1 Tag Mode) and then click on tokens, units, chunks, or chains in the Main Screen to apply the field/tag selection.
    * The Tag tab can also be used to save or load Tag Schema files, also known as Tag Json files. Clicking the **Save tag.json** button will capture every field and tag set in the file and save it to a JSON file. Clicking the **Load tag.json** button will allow you to import new fields and tags from other JSON files.

### 4.4.4 Clique Tab

<img width="1436" alt="Screen Shot 2021-12-17 at 3 15 42 PM" src="https://user-images.githubusercontent.com/36257165/146618373-a788c029-6882-4666-a432-882eef26e50d.png">

* Functionality
    * The Clique tab is used to highlight areas of dialogue with high resonance. A Clique is defined as a group of Resonance chains that are connected through their shared unit(s).
* How to Use
    * The Clique tab is a read-only tab, so it can only be used to view the Cliques that you have generated. To create Cliques, create any amount of Resonance chains in the Main Screen. Any time two or more Resonance chains contain entries located on a shared unit, the chains will be grouped into the same Clique. Cliques are therefore very dynamic, and can change any time a chain is added to or removed from.
    * To view the Resonance chains within a Clique, click on the Clique’s name in the left pane. The selected Clique will display its Resonance chains in the right pain. For each Resonance chain, you can view its Chain Order list in the right pane. The Chain Order list shows which Resonance chains “follow” the Resonance chain for that row. These are Resonance chains that will be pushed from the alignment of the Resonance chain for that row.

### 4.4.5 Translation Tab

![Screen Shot 2021-12-17 at 3 20 57 PM (2)](https://user-images.githubusercontent.com/36257165/146618670-cac1058e-3f66-4d8c-9434-ade7508b3fa9.png)

* Functionality
    * The Translation tab is used to view a per-unit translation of the imported file. This tab will only be accessible if a unit field has been set as “Translation” during the import process.
* How to Use
    * The Clique tab is a read-only tab, so it can only be used to view the Cliques that you have generated. To create Cliques, create any amount of Resonance chains in the Main Screen. Any time two or more Resonance chains contain entries located on a shared unit, the chains will be grouped into the same Clique. Cliques are therefore very dynamic, and can change any time a chain is added to or removed from.
    * When importing your file, use the Import Fields window on the Import Screen (see 1.5 Import Screen) to set any unit-level field to be Translation under the Special Fields column. Once the file has been imported, the Translation tab will be visible on the Main Screen. You can scroll through the units in the left pane and view each translation in the right pane.

## 4.5 Audio

In order to begin using audio in Rezonator, you’ll need to open an audio file. To do so you can, **Left Mouse Click** on the **Media** option from the **File** dropdown. **Note:** Rezonator only supports .OGG audio files.

![audio drop down](https://user-images.githubusercontent.com/46977535/146619059-b05fa09b-0887-406f-a330-0fd680131090.png)

If the audio file successfully imports, then the Audio Interface will appear, like so:

![audio](https://user-images.githubusercontent.com/46977535/146619065-3830ac1b-d1e1-44f3-b42e-dd6196f45ab0.png)

A **Left Mouse Click** on the media icon in at the bottom of the toolbar will also toggle this interface

### 4.5.3 How to navigate the Audio Interface

On the leftmost panel, we display the name and file location of the current Audio Track:

![audio-file](https://user-images.githubusercontent.com/46977535/146619072-9d56c624-2313-4988-99fc-b0f788f5e5ef.png)

At the top-middle portion of the interface is the **Play/Pause Button**. A Left Mouse Click on this button will play or pause the current Audio track. Also, pressing the **Spacebar** on you keyboard will play or pause the current Audio Track

![audio-playhead](https://user-images.githubusercontent.com/46977535/146619079-ccfdafd7-4372-4281-9394-da3741030cb3.png)

On top of the Seek Bar is the **Playhead**, represented by an orange circle. This is a visual representation of what position in the current Audio Track is being played.

The Playhead can be clicked and dragged with a **Left Mouse Hold** to a different position on the Seek Bar, which will update the current position of the Audio Trail being played.

On the Right Most side of the Audio Interface is the **Play audio from focused word** button. When this option is toggled on, you can click on a word in the Main Screen to jump the audio playhead to the start time of the unit containing it.

![audio-clicktoggle](https://user-images.githubusercontent.com/46977535/146619087-0641df50-7fcb-4f0a-95b9-bb6b3419a41f.png)

## 4.6 Export

### 4.6.1 How to export your data

To export data from Rezonator in CSV format, use the **File** drop down in the menu bar and click **Export**. Rezonator will prompt you for a location to save a directory containing several CSV files.

![Screen Shot 2021-12-17 at 3 23 34 PM (2)](https://user-images.githubusercontent.com/36257165/146618963-699e7948-c2ae-41d4-91f1-d204fe4554df.png)

Once exported, this directory will have a CSV breakdown of all of the document’s units, tokens, chunks, chains, and searches.

<img width="902" alt="Screen Shot 2021-12-17 at 3 25 18 PM" src="https://user-images.githubusercontent.com/36257165/146618995-eec64832-d379-4a6c-9805-6c67e3231b28.png">


