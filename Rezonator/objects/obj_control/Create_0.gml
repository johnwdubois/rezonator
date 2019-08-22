/*
	obj_control: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of a control object
	
	Purpose: Instantiate all variables used by control objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

// Keep track of which line the "camera" is centered on
currentCenterDisplayRow = 0;
prevCenterDisplayRow = 0;

// Bound and set the display grid of the words
gridSpaceHorizontalMin = 60;
gridSpaceVerticalMin = 23.40;
gridSpaceHorizontalMax = 400;
gridSpaceVerticalMax = 303.40;

gridSpaceHorizontal = 100;
gridSpaceVertical = 33.4;
prevGridSpaceVertical = gridSpaceVertical;
//searchGridSpaceVertical = gridSpaceVertical;
searchPrevGridSpaceVertical = gridSpaceVertical;
//filterGridSpaceVertical = gridSpaceVertical;
filterPrevGridSpaceVertical = gridSpaceVertical;
gridSpaceRatio = 1;

// Measure the space taken up by the speaker labels, and set the left-align margin of the words
speakerLabelMargin = 200;
speakerLabelMarginBuffer = 20;
wordLeftMargin = 200;
wordLeftMarginDest = 200;

var speakerLabelColWidthDivider = 3;
if (ds_grid_height(global.fileLineRipGrid) < 2) {
	speakerLabelColWidthDivider = 2;
}
for (var i = 0; i < 3; i++) {
	speakerLabelColWidth[i] = (speakerLabelMargin - speakerLabelMarginBuffer) / speakerLabelColWidthDivider;
}

// Make light blue
c_ltblue = make_color_rgb(183, 183, 255);

// Set variables of normal/grid alignment of words
shapeText = 0;
shapeBlock = 1;
shape = shapeBlock;

// Instantiate the Unit Grid
unitGridWidth = global.unitGridWidth;
unitGrid_colUnitID = 0;
unitGrid_colUtteranceID = 1;
unitGrid_colWordIDList = 2;
unitGrid_colDiscoID = 3;
unitGrid_colpID = 4;
unitGrid_colParticipantName = 5;
unitGrid_colUnitStart = 6;
unitGrid_colUnitEnd = 7;
unitGrid_colParticipantColor = 8;
unitGrid_colAudioFile = 9;

unitGrid = ds_grid_create(unitGridWidth, 0);
unitGridBackup = ds_grid_create(unitGridWidth, 0);


// Instantiate the Word Grid
wordGridWidth = global.wordGridWidth;
wordGrid_colWordID = 0;
wordGrid_colWID = 1;
wordGrid_colUnitID = 2;
wordGrid_colUtteranceID = 3;
wordGrid_colWordSeq = 4;
wordGrid_colWordToken = 5;
wordGrid_colWordTranscript = 6;

wordGrid = ds_grid_create(wordGridWidth, 0);

wordIDCounter = 0;
unitIDCounter = 0;

// Boolean for switching transcript view on/off
wordTranscriptView = false;
// Seems to prefer starting as false?


// Instantiate the Line Grid
lineGridWidth = 13;
lineGrid_colDisplayRow = 0;
lineGrid_colDiscoID = 1;
lineGrid_colUnitID = 2; //lineGrid_colUnit = 2;
lineGrid_colLineNumberLabel = 3;
lineGrid_colPixelY = 4; //lineGrid_colY = 3;
lineGrid_colLineState = 5;
lineGrid_colWordIDList = 6;
lineGrid_colAlignedWordID = 7;
lineGrid_colUnitStart = 8;
lineGrid_colUnitEnd = 9;
lineGrid_colVoidMax = 10;
lineGrid_colVoidSum = 11;
lineGrid_colPixelYOriginal = 12;

lineGrid = ds_grid_create(lineGridWidth, 0);

lineGridBackup = ds_grid_create(lineGridWidth, 0);

//lineGridBackup = ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);
lineGridDefaultSort = true;
lineGridShuffle = false;
// set limit for word displacement by alignment
voidLimit = 25;

// Instantiate the Search List, plus Search/Filter grids
searchGrid_colHitIDList = lineGrid_colWordIDList;

filterGrid = ds_grid_create(lineGridWidth, 0);
searchGrid = ds_grid_create(lineGridWidth, 0);

// Initialize filter and search as deactivated
filterGridActive = false;
searchGridActive = false;
// Initialize line grid as active
currentActiveLineGrid = lineGrid;


// Instantiate the Dynamic Word Grid
dynamicWordGridWidth = global.dynamicWordGridWidth;
dynamicWordGrid_colWordID = 0;
dynamicWordGrid_colWID = 1;
dynamicWordGrid_colUtteranceID = 2;
dynamicWordGrid_colDisplayWordSeq = 3; //dynamicWordGrid_colLineWordSeq = 1;
dynamicWordGrid_colDisplayCol = 4; //dynamicWordGrid_colPositionCol = 2;
dynamicWordGrid_colPixelX = 5; //dynamicWordGrid_colX = 3; 
dynamicWordGrid_colWordState = 6;
dynamicWordGrid_colDisplayString = 7; //dynamicWordGrid_colStringDisplay = 5;
dynamicWordGrid_colInChainList = 8; //dynamicWordGrid_colInChains = 6;
dynamicWordGrid_colInBoxList = 9; 
dynamicWordGrid_colAligned = 10;
dynamicWordGrid_colVoid = 11;
dynamicWordGrid_colStretch = 12;
dynamicWordGrid_colReplaceWord = 13;

dynamicWordGrid = ds_grid_create(dynamicWordGridWidth, 0);

wordStateNormal = 0;
wordStateNew = 1;
wordStateChunk = 2;
wordStateDead = 3;
wordStateGold = 4;


// Instantiate the Word Draw Grid
wordDrawGridWidth = 7;
wordDrawGrid_colBorder = 0;
wordDrawGrid_colBorderRounded = 1;
wordDrawGrid_colFillRect = 2;
wordDrawGrid_colTextColor = 3;
wordDrawGrid_colEffectColor = 4;
wordDrawGrid_colVisible = 5;
wordDrawGrid_colFocused = 6;
wordDrawGrid = ds_grid_create(wordDrawGridWidth, 0);

wordDrawGridFocusedAnimation = 0;
wordDrawGridFocusedAnimationInc = true;
wordDrawGridFocusedAnimationMax = 2;



// Instantiate the Hit Grid
hitGridWidth = 7;
hitGrid_colWordID = 0;
hitGrid_colUnitID = 1;
hitGrid_colHitID = 2;
hitGrid_colWordState = 3;
hitGrid_colHitBool = 4;
hitGrid_colDisplayCol = 5;
hitGrid_colPixelX = 6;

hitGrid = ds_grid_create(hitGridWidth, 0);



// Create variable checks for RezPlay
originalWordGridHeight = ds_grid_height(wordGrid);
originalUnitGridHeight = ds_grid_height(unitGrid);
originalLineGridHeight = ds_grid_height(lineGrid);




// Instantiate participant lists
participantList = ds_list_create();
participantColorList = ds_list_create();

// Initialize a random value
randomise();


// Initialize the cursor box, which is currently unused
cursorBox = 0;
cursorBoxX = 0;
cursorBoxY = 0;

// Initialize the camera's draw range
drawRange = 30
drawRangeStart = 0;
drawRangeEnd = 0;
lineSpacing = 6;

// Instantiate the display row ascending variable, currently unused
displayRowAscending = true;

// Set the arrow key speed limit
holdUpArrowKey = 0;
holdDownArrowKey = 0;

// Both of these are unused
wordColor = c_black;

alignment = 0;
//0 = left, 1 = center, 2 = right

// Initialize the grid view as inactive
gridView = false;
// Initialize the developer variables as not showing
showDevVars = false;
// Initialize the values to hold the hover word info
newWordHoverUnitID = -1;
newWordHoverWordSeq = -1;
newWordHoverWordID = -1;

hoverWordID = -1;
hoverChunkID = -1;
clickedChunkID = -1;
showMouseLine = false;
linkDeleted = false;

// Safety check for the drop downs
ableToCreateDropDown = true;
ableToCreateDropDownAlarmSet = false;

// More developer variables
showDevMessages = false;

showDisplayCols = false;

// Initialize info for New Words
mostRecentlyAddedWord = -1;
mostRecentlyAddedWordMoved = false;
alarmRecentlyAddedWordMovedTriggered = false;

// Safety check for height control
canPressPlus = true;
canPressMinus = true;

// Unused variables for dark mode
darkTheme = false;
darkThemeBackColor = c_dkgray;
darkThemeTextColor = c_white;
lightThemeBackColor = c_white;
lightThemeTextColor = c_black;

// Set global font info
global.fontSize = 0;
global.fontMain = fnt_main;
global.fontMainBold = fnt_mainBold;
global.fontChainList = fnt_chainList;
global.fontPanelTab = fnt_panelTab;
global.fontSortPane = fnt_sortPane;
global.fontGridView = fnt_gridView;
global.navTextBig = false;

// UNused variable
scrollFast = 0;

// Set boundry for drawing on the left side of the screen
leftScreenBound = 0;



// set BG color based on color theme
var layerID = layer_get_id("Background");
var backID = layer_background_get_id(layerID);
var BGcolor = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBG, global.colorTheme);
layer_background_blend(backID, BGcolor);

// Set variables for swithing between search and main screens
preSwitchLineGrid = 0;
preSwitchDisplayRow = 0;
preSwitchSearchDisplayRow = 0;
highlightedSearchRow = 0;
highlightedSearchRowAlpha = 0;

// Unused variable
simulateRightArrow = 0;

// Variable for counting moves
moveCounter = 0;

// Safety check for autosaving
allSaved = true;

compassRoseX = 0;
compassRoseY = 0;
compassLineX1 = 0;
compassLineY1 = 0;
compassLineX2 = 0;
compassLineY2 = 0;
compassCenterLineY = -1;


// Set variables for the mouse drag rectangle, and quick gestures
mouseHoldRectX1 = 0;
mouseHoldRectY1 = 0;
mouseHoldRectX2 = 0;
mouseHoldRectY2 = 0;
mouseRectMade = false;
mouseRectReleased = false;
inRectWordIDList = ds_list_create();
inRectHitIDList = ds_list_create();
inRectUnitIDList = ds_list_create();
quickStackAbleToInitiate = true;
quickStackAbleToSwitch = true;
mouseRectWithinLine = false;
trackChunkMade = false;
mouseRectBeginInWord = -1;
mouseRectBeginBetweenWords = -1;
lineContainsMouse = -1;



// Set variables for box creation
chunkID = 0;
boxHoldRectX1 = 0;
boxHoldRectY1 = 0;
boxHoldRectX2 = 0;
boxHoldRectY2 = 0;
boxRectMade = false;
boxRectReleased = true;
boxRectAbleToInitiate = true;

// Unused variables
quickInside = false;
quickOutside = false;

// Allow use of shortcuts
shortcutsEnabled = true;

// Keep track of session length
sessionStartTime = current_time;
currentSessionTime = 0;

// Search box variables
fPressed = false;
ePressed = false;
gPressed = false;
regExCheck = false;
goToTime = false;
rename = false;
recolor = false;
caption = false;
replace = false;
splitWord = false;
swapLine = false;
quickLinkAllowed = true;
inChainBool = false;
transcriptSearch = false;
caseSensitive = false;
cursorPos = 1 ;
cursorViz = false;
inputText = "";
cursorTimer = 20;

hitIDCounter = 1;

selectedChainID = 0;
instance = input_text_create_singleline_ext(camera_get_view_width(view_camera[0]) /2 - 235 + 5, camera_get_view_height(view_camera[0])/2, 235, fnt_main, global.colorThemeText, 1, -1, fa_left, fa_middle, true, 0);

dialogueBoxActive = false;
newWordCreated = false;

// Safety check for quick volunteers
alarm[9] = 10;


mouseoverPanelPane = false;
rectNotInPanelPane = false;;

newWordDeleted = false;

boxGridWidth = 6;
boxGrid_colUnitID = 0;
boxGrid_colWordIDList = 1;
boxGrid_colChainIDLists = 2;
boxGrid_colVoidSum = 3;
boxGrid_colTimeSpent = 4;
boxGrid_colMoveCount = 5;


//stack Show variables
currentStackShowListPosition = -1;
stackShowList = ds_list_create();
stackShowWindowActive = false;
stackShowActive = false;
stackShowBackwards = false;
stackShowSwitchedWordView = false;
stackShowSwitchedTextShape = false;


// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
clipX = 0;
clipY = 0;
x = 0;
y = 0;
stackShowBuffer = 10;

drawRangeCenterOffset = 0;
drawRangeExtraSteps = 0;

drawLineYOffset = 0;
global.canScroll = true;
mouseoverScrollBar = false;

toolTipText = 0;

swapLinePos1 =  0;
swapLinePos2 =  0;

showLineNumber = true;

audioTrackStream = -1;
audioTrackIndex = -1;


if(global.tutorial){
		instance_create_layer(x, y, "InstancesPopUp", obj_popUp);
}
