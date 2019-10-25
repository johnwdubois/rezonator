/*
	obj_toolPane: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of the toolPane object
	
	Purpose: Instantiate all variables used by the toolPane object
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

windowWidth = global.toolPaneWidth;
windowHeight = 170;

originalWindowHeight = 20;
collapsedWindowHeight = 2000;
showTool = true;

x = room_width - windowWidth;
y = originalWindowHeight;

toolAmount = 5;
toolPointer = 0;
toolRezBrush = 1;
toolTrackBrush = 2;
toolStackBrush = 3;
toolNewWord = 4;
toolBoxBrush = 5; // toolBoxBrush??
toolPlaceChains = 6;

currentTool = toolRezBrush;

tempReturnTool = -1;



modeRead = 0;
modeRez = 1;
modeTrack = 2;
currentMode = modeRez;





tracksOnlyStackShow = false;
rezOnlyStackShow = false;
newWordInFilter = false;


progressBarX = room_width - 100;
progressBarY = windowHeight + 72;
progressBarWidth = 100;
progressBarHeight = 32;
progressBarBackColor = c_gray;
progressBarFrontColor = c_blue;
progressBarFont = fnt_mainBold;

alarm[0] = 2;


toolTipTextPointer = string_hash_to_newline("The pointer tool #allows you to click #and drag your mouse #to create mulitple #links in a chain");
toolTipTextRez = string_hash_to_newline("The Rez Brush tool #allows you to click #on words to add #them to the #current Rez chain");
toolTipTextTrack = string_hash_to_newline("The Track Brush tool #allows you to identify #subjects and add #them to the #current Track chain");
toolTipTextStack = string_hash_to_newline("The Stack Brush tool #allows you to click #on the line and add #it to the current stack");
toolTipTextNewWord = string_hash_to_newline("The New Word tool #allows you to click #on words to add #a new custom word #into the discourse");
toolTipTextBox = string_hash_to_newline("The Box Brush tool #allows you to click #and drag to create #a chunk which can #be added to chains");
toolTipTextDiscourse = string_hash_to_newline("This button switches #the view to the #discourse of dialogue");
toolTipTextGrid = string_hash_to_newline("This button switches #the view to the #grids containing all #the data required");