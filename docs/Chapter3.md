---
title: Annotation tools
description: 
---

**Previous page:** <u><a href="{{site.baseurl}}/Chapter2">Chapter 2: Overview of Main Screen</a></u>

3	Annotation tools
=====
Rezonator features three different working modes that are designed to perform specific tasks. The modes can be accessed through the box on the right upper corner of the screen.

## 3.1 Tag Mode

Tag Mode can be used to quickly apply tags to **Tokens**, **Chunks**, **Units**, **Chains**, **Entries**, and **Tree Links**.

### 3.1.1 Functionality of Tag Mode

Tag Mode can be activated by clicking the **Tag Mode** button in the **Tool** flyout.

![tag image](https://user-images.githubusercontent.com/46977535/146447595-ca6611e5-ff74-4633-98a3-ace075a419a7.png)

To view all fields and their respective tags, click on the **Tag** pane. While in the Tag pane, clicking on a **Field** in the left pane will reveal all of its **Tags** in the right pane.

To view all of the **Fields** and **Tags** that belong to a hovered **Token**, **Unit**, or **Tree Link**, enable Word Tip by selecting it from the **View** dropdown in the Menu Bar. To start applying quick tags, select a **Field** in the left pane and also select one of its **Tags** in the right pane. With Word Tip enabled, hover the mouse over a **Token, Unit,** or **Tree Link** and see the highlighted field that has been selected in the Tag pane. Clicking on the Token/Unit/Tree Link will overwrite the selected field’s tag value with the tag selected in the Tag pane.


## 3.2 Track Mode

**Track Mode** is one of the two **Annotation Modes** of Rezonator, the other being **Resonance Mode**. The main purpose of Track Mode is to allow the user to “track” references of subjects across the discourse, through the use of **Trails**.

### 3.2.1 Functionality of Track Mode

Track Mode can be activated by a **Mouse Click** on the **Track Tool Pane Button:**

![track selection](https://user-images.githubusercontent.com/46977535/146448030-402917bb-0738-4c6c-b037-cf6fb58136d5.png)

Alternatively, Trail Mode can be activated by pressing the “T” Key on your keyboard.
When Trail Mode is active, the Trail Tool Pane Button will be highlighted.

The most important feature of Trail Mode is the creation of Trail. A Trail is a sequential set of words connected by **Links**. A Trail looks like this:

![image2](https://user-images.githubusercontent.com/34769184/130830151-b2d6bbea-4160-442b-a37e-ab51803fc7dc.png)

You can begin a Trail by clicking on a **Word** in the discourse, creating the first Link in the chain. The Trail will be automatically **focused**.

When a chain is focused, Left Mouse Clicking on other words in the discourse will add those words to the focused chain.

If you want to no longer add words to a chain or start a new chain, you will need to **Unfocus** the currently focused chain. This can be done multiple ways:

 - Left Mouse Clicking on any **Empty Space** in the Discourse.
 - Pressing the **Escape** or **Enter** key on your keyboard.

In order to **Refocus** a previous chain, you must Left Mouse Click on a word already within the chain, or select that chain in the navigation window.

To **Delete a Link** within a Trail, **Right Mouse Click** on the word you want removed from the chain. A **Dropdown Menu** will appear, with one option being “Delete Link”. Clicking this option will remove the selected word from the Trail.

Alternatively, you can Left Mouse Click on the word you want to remove from the Trail, then press the **Delete Key** on your keyboard.

### 3.2.2 Functionality of the Track Tab

When in **Track Mode**, the **Trail List** can be found in the top 1/3rd of the window.

![trail image](https://user-images.githubusercontent.com/46977535/147841126-b6e2861d-dad8-4b06-9fc0-0b045b0df00f.png)


There are 2 buttons on the lines in **Track Mode**: **Filter Chains Button** & **Visibility Button**. The Filter Chains Button (filter cone), when activated by a Left Mouse Click, will add all active Trails to the list of chains shown on the **Filter Screen**.

Off: ![filter off](https://user-images.githubusercontent.com/46977535/147841066-0564f685-e58f-46e5-82eb-1dbc3570dd8c.png)  On: ![filter on](https://user-images.githubusercontent.com/46977535/147841067-c3f315bc-1c58-433d-93a5-3ffd805ad9c7.png)


The Visibility Button (eyeball), when activated by a Left Mouse Click, will toggle the visibility of all Trails on the main screen.

Off: ![Hidden](https://user-images.githubusercontent.com/46977535/147841081-836edcc1-a098-4e80-aa7e-9332feed0430.png) On: ![Shown](https://user-images.githubusercontent.com/46977535/147841083-19978b66-9a58-4953-b78f-4e0c7b315517.png)


While in Track Mode, the List Window will display a list of all the Trails you have created, as shown here:

![Trails](https://user-images.githubusercontent.com/46977535/147841128-bfbf8cf9-0a4b-4727-8c9d-a0cc449aa58f.png)


A way to focus a Trail is with a **Mouse Click** on the chain’s row within the **Trail List**

The **Pick Toggle** Button will add that Trail to the list of chains shown on the Filter Screen.

More options for Trails can be accessed with a **Right Mouse Click** on a trail’s row (CTRL & Mouse Click on Mac)
  - **Rename** lets you input a string to name the selected Trail.
  - **Recolor** lets you choose a new color for the selected Trail.
  - **Delete** will delete all of the links of the selected Trail, eliminating the whole chain.

With a Trail focused, the Contents Window will display the contents of the focused Trail
  - The Contents Window (One-To-Many) displays the individual Words within a Trail, showing their **Unit Sequence, Token Order,** and **Text**, and the remaining three columns display entry level fields that the user can change.
  - The Contents Window (One-To-One) displays the chain level fields that the user selects and the values stored for those fields in each Trail.
  - Trails can be tagged at both the one-to-many and one-to-one level. To apply a tag to a trail, set a column in the Contents Window to view a field with a tag set. You can change a column’s field by clicking on the column header and choosing **Select field** from the dropdown. 
    - **Note**: while in one-to-many view, the first three visible columns in the Trail Contents Window cannot be changed

The contents of any Trail can be sorted using the **Sort Buttons** next to the column’s name. When the arrow is facing right it is default sorted based on discourse order. Clicking on the sort button will change it to alphanumeric ascending, clicking another time will result in alphanumeric descending. Clicking again from this point will restore the default sort.

## 3.3 Resonance Mode

**Resonance Mode** is one of the two **Annotation Modes** of Rezonator, the other being **Trail Mode**. The main purpose of Resonance Mode is to allow the user to visualize **Resonance**, through the use of **Resonance Chains**.

### 3.3.1 Functionality of Resonance Mode

Resonance Mode can be activated by a **Mouse Click** on the **Resonance Tool Pane Button**:

![rez selection](https://user-images.githubusercontent.com/46977535/146448053-86b41b0c-9d7d-43c3-bef5-deee29aeca13.png)

Alternatively, Resonance Mode can be activated by pressing the **“R” Key** on your keyboard.
When Resonance Mode is active, the Resonance Tool Pane Button will be highlighted.

The most important feature of Resonance Mode is the creation of Resonance Chains. A Resonance Chain is a sequential set of words connected by **Links**. A Resonance Chain looks like this:

![image99](https://user-images.githubusercontent.com/34769184/130874479-f342bfbf-5d45-4a56-a951-b6c8e8470194.png)

  - **Note:** Links within a Resonance Chain will vertically **align**, if possible.

You can begin a Resonance Chain by Left Mouse Clicking on a **Word** in the discourse, creating the first link in the chain.

![image132](https://user-images.githubusercontent.com/34769184/130874539-6cea5547-5094-4645-96e0-4236d29a8db6.png)

Once a Resonance Chain is created, it will be automatically **Focused**. When a chain is focused, **Left Mouse Clicking** on other words in the discourse will add those words to the focused chain.

![image116](https://user-images.githubusercontent.com/34769184/130874600-2902c0bd-32e0-4699-858b-2ff2edb6ae74.png)

If you want to no longer add words to a chain or start a new chain, you will need to **unfocus** the currently focused chain. This can be done multiple ways:

 - Left Mouse Clicking on the Empty Space in the Discourse.
 - Pressing the **Escape** or **Enter** key on your keyboard.

In order to **Refocus** a previous chain, you must Left Mouse Click on a word already within the chain.

To **Delete a Link** within a Resonance Chain, **Right Mouse Click** (Or CTRL + Left Mouse on Mac)  on the word you want removed from the chain. A **Drop Down Menu** will appear, with one option being “Delete Link”. Clicking this option will remove the selected word from the Resonance Chain

![image108](https://user-images.githubusercontent.com/34769184/130874808-2d19eedf-cbc8-4980-ad30-448a6a9e49a8.png)

Alternatively, you can Left Mouse Click on the word you want to remove from the Resonance Chain, then press the **Delete Key** on your keyboard.

As noted above, Resonance Chains will automatically Align when possible. This is meant to aid in the visualization of resonance between speakers. However, there are scenarios in which alignment of chains is algorithmically impossible, such as the example below. Please note that in these cases, the Rez Chains will **not** align.

![image94](https://user-images.githubusercontent.com/34769184/130874872-01047324-8444-4335-8b2e-8f96a2987d7b.png)

### 3.3.2 Functionality of the Resonance Tab

**Resonance Chain List** allows users to visualize the active **Resonance Chains** and their contents.
There are 2 buttons on the lines in **Resonance Mode: Filter Chains Button** & **Visibility Button**. The Filter Chains Button (filter cone), when activated by a Left Mouse Click, will add all active Resonance Chains to the list of chains shown on the **Filter Screen**.

Off: ![filter off](https://user-images.githubusercontent.com/46977535/147841066-0564f685-e58f-46e5-82eb-1dbc3570dd8c.png)  On: ![filter on](https://user-images.githubusercontent.com/46977535/147841067-c3f315bc-1c58-433d-93a5-3ffd805ad9c7.png)

The Visibility Button (eyeball), when activated by a Left Mouse Click, will toggle the visibility of all Resonance Chains on the main screen.

Off: ![Hidden](https://user-images.githubusercontent.com/46977535/147841081-836edcc1-a098-4e80-aa7e-9332feed0430.png) On: ![Shown](https://user-images.githubusercontent.com/46977535/147841083-19978b66-9a58-4953-b78f-4e0c7b315517.png)

While in Resonance Mode, the **List Window** will display a list of all the Resonance Chains you have created, as shown here:

![image27](https://user-images.githubusercontent.com/34769184/130875106-3deb73e7-a2e1-437b-bf78-c9a3922a9746.png)

Another way to Focus a Resonance Chain is with a Left Mouse Click on the chain’s row within the Resonance Chain List

![image50](https://user-images.githubusercontent.com/34769184/130875131-c746de2f-7d18-4274-a295-f7e66c7e9365.png)

The **Pick Toggle** Button will add that Resonance Chain to the list of chains shown on the Filter Screen.

More options for Resonance Chains can be accessed with a **Right Mouse Click** on a chain’s row (CTRL Click on Mac)

On the left side of the Rez Chain’s name is the Pick Toggle Button. The **Pick Toggle Button** will add that Rez Chain to the list of chains shown on the Filter Screen.

![image11](https://user-images.githubusercontent.com/34769184/130875311-b5fb8d47-d7a2-4bf0-ac3a-c7549aa5bf7f.png)

More options for Rez Chains can be accessed with a **Right Mouse Click** on a chain’s row (CTRL Click on Mac)

 - **Rename** lets you input a string to name the selected Resonance Chain.
 - **Recolor** lets you choose a new color for the selected Resonance Chain.
 - **Delete** will delete all of the links of the selected Resonance Chain, eliminating the whole chain.

 - The Contents Window (One-To-Many) displays the individual Words within a Resonance Chain, showing their **Unit Sequence, Token Order**, and **Text**, and the remaining three columns display entry level fields that the user can change.
 - The Contents Window (One-To-One) displays the chain level fields that the user selects and the values stored for those fields in each Resonance Chain.

The Contents of any Resonance Chain can be sorted using the **Sort Buttons** next to the column’s name. When the arrow is facing right it is default sorted based on discourse order. Clicking on the sort button will change it to alphanumeric descending, clicking another time will result in alphanumeric ascending. Clicking again from this point will restore the default sort.

## 3.4 How to Make Stacks

**Stacks** are the third type of **Chain** within Rezonator, the other two being **Resonance Chains** and **Trails**. The main purpose of Stacks is to allow the user to annotate entire lines in the discourse, instead of annotating word by word. **Note**: Stacks do not have a single **Mode** attributed to them, and are instead accessible in both **Resonance Mode** and **Track Mode**.

### 3.4.1 Accessing Stack Creation

Stacks can be used to annotate and organize units of the discourse. A Stack is a set of units all highlighted the same color, which visualizes their **Links**. A Stack looks like this: 

 ![stack](https://user-images.githubusercontent.com/46977535/146449613-6db532f2-fbd7-4309-871f-adb5c5aa515a.png)

You can begin a Stack by Left Mouse Clicking on the **Speaker Label** of a line in the discourse, creating the first Link in the chain. Once a Stack is created, it will be automatically **focused**. When a Stack is focused, Left Mouse Clicking on other Speaker Labels in the discourse will add those lines to the focused Stack.

If you want to no longer add words to a chain or start a new chain, you will need to **unfocus** the currently focused chain. This can be done multiple ways:
  * Left Mouse Clicking on the **Empty Space** in the workspace.
  * Pressing the **Escape** or **Enter** key on your keyboard.

In order to **refocus** a previous Stack, you must Left Mouse Click on a Speaker Label already within the Stack.

To **Delete a Link** within a Stack, Left Mouse Click on the unit you want to remove from the Stack, then press the **Delete Key** on your keyboard. This will remove the selected unit from the focused Stack.

### 3.4.2 Functionality of the Stack Tab

While in Stack Mode, the List Window will display a list of all the Stack Chains you have created, as shown here:

![Houston stacks 10](https://user-images.githubusercontent.com/46977535/146464586-48b49c1e-ffc4-474a-81ce-1909c6de71ce.PNG)

  - **Note**: To the right of each Stack’s name is a text readout of the units it contains.

Another way to Focus a Stack is with a Left Mouse Click on the Stack’s row within the Stack Pane
 
There are 2 buttons on the lines in **Stack Mode: Filter Chains Button** & **Visibility Button**. The Filter Chains Button (filter cone), when activated by a Left Mouse Click, will add all active Stacks to the list of chains shown on the **Filter Screen**.

Off: ![filter off](https://user-images.githubusercontent.com/46977535/147841066-0564f685-e58f-46e5-82eb-1dbc3570dd8c.png)  On: ![filter on](https://user-images.githubusercontent.com/46977535/147841067-c3f315bc-1c58-433d-93a5-3ffd805ad9c7.png)

The Visibility Button (eyeball), when activated by a Left Mouse Click, will toggle the visibility of all Stacks on the main screen.

Off: ![Hidden](https://user-images.githubusercontent.com/46977535/147841081-836edcc1-a098-4e80-aa7e-9332feed0430.png) On: ![Shown](https://user-images.githubusercontent.com/46977535/147841083-19978b66-9a58-4953-b78f-4e0c7b315517.png)

More options for Stacks can be accessed with a **Right Mouse Click** on a chain’s row (CTRL & Mouse Click on Mac)
  - **Rename** lets you input a string to name the selected Stack.
  - **Recolor** lets you choose a new color for the selected Stack.
  - **Delete** will delete all of the links of the selected Stack, eliminating the whole chain.

With a Stack focused, the **Contents Window** will display the contents of the focused Stack
  - The Contents Window (One-to-many) displays the individual units within a Stack, showing their fields and tags (By default, the visible fields for one-to-many are **unitSeq, participant**, and **utterance**, and **gapUnits**).
  - The Contents Window (One-to-one) displays the fields and tags for each Stack as a whole.

The Contents of any Stack can be sorted using the **Sort Buttons** next to the column’s name. When the arrow is facing right it is default sorted based on discourse order. Clicking on the sort button will change it to alphanumeric descending, clicking another time will result in alphanumeric ascending. Clicking again from this point will restore the default sort.
## 3.5 How to Make Chunks

  - **Note:** Chunks do not have a single Mode attributed to them, and are instead accessible in any Mode.

### 3.5.1 Accessing Chunk Creation

![Chunks](https://user-images.githubusercontent.com/46977535/147841301-da7e9bc9-f2f5-49c5-8645-8db0ba091223.png)

To create a **chunk** the user must click and drag horizonatally across tokens then release. This creates a new token-like data structure called a chunk that can be added to chains and annotated similarly to how tokens behave.

  - As noted above, Chunks can be made in any Mode. However, when making chunks outside of Tag mode the chunk will automatically be added to a chain as if it was clicked. 

## 3.6 Merging Chains

![merge](https://user-images.githubusercontent.com/46977535/147841317-da2798ab-9e58-4266-b05c-7bd505188ae5.png)

You are able to **Merge Chains** together, combining one chain with another. This is done by focusing one chain you want combined, then **CTRL + Left Mouse Clicking (Command + Left Mouse Clicking** for Mac) on a word within the non-focused chain you want combined. If both chains being merged are over the length of one, then a **Warning Window** will appear asking you to confirm the merge. If you press “Ok”, the second chain will be merged into the first chain.

**Next Page:** <u><a href="{{site.baseurl}}/Chapter4">Chapter 4: Functionalities of Rezonator</a></u>
