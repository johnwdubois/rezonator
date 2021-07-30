/*
	Purpose: Instantiate all variables used by control objects
*/

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

inDrag = false;
drag_offsetY = 0;
flickVelY = 0;
flick_power_calibration = 4;
flick_power_reduction_each_step = 3;
//multiTouch = false;

doubleClickTimer = -1;

// Keep track of which line the "camera" is centered on
currentCenterDisplayRow = 0;
prevCenterYDest = 0;
prevCenterDisplayRow = 0;
cameraBottomLine = camHeight;

// Bound and set the display grid of the words
gridSpaceHorizontalMin = 60;
gridSpaceVerticalMin = 35;
gridSpaceVerticalMinOriginal = 35;
gridSpaceHorizontalMax = 400;
gridSpaceVerticalMax = 300;

gridSpaceHorizontal = 100;
gridSpaceVertical = 60;
prevGridSpaceVertical = gridSpaceVertical;
gridSpaceRatio = 1;

// Set the speed of scrolling
arrowSpeedMin = 17;
arrowSpeedMax = 90;
arrowSpeed = 18;



// Measure the space taken up by the speaker labels, and set the left-align margin of the words
speakerLabelMargin = 200;
wordLeftMargin = 0;
wordLeftMarginDest = 220;
speakerLabelHoldingDelay = false;


speakerLabelColXList = ds_list_create();
speakerLabelColXHolding = -1
speakerLabelColXHoldingPrev = 0;
speakerLabelColXHoldingDiff = 0;
speakerLabelColPrevList = ds_list_create();

// set default width values for speaker label
var speakerLabelPlusX = 0;
for (var i = 0; i < 2; i++) {
	var currentSectionX2 = 0;
	if (i == 0) currentSectionX2 = camWidth * 0.1;
	else if (i == 1) currentSectionX2 = camWidth * 0.2;
	ds_list_add(speakerLabelColXList, speakerLabelPlusX + currentSectionX2);
	speakerLabelPlusX += currentSectionX2;
}


with (obj_alarm) {
	alarm[1] = 5;
}

wordTopMargin = 0;




// Make light blue
c_ltblue = make_color_rgb(183, 183, 255);

// Set variables of normal/grid alignment of words
shapeText = 0;
shapeBlock = 1;
shape = shapeText;
shapeStartText = true;

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
//unitGrid_colTag = 9;
unitGrid_colDiscoColor = 9;

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
wordTokenView = false;
wordView = 2;
unitView = 1;

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
quickFilterGrid = ds_grid_create(lineGridWidth, 0);
searchGrid = ds_grid_create(lineGridWidth, 0);
emptySearchGrid = ds_grid_create(lineGridWidth, 0);

// Initialize filter and search as deactivated
filterGridActive = false;
quickFilterGridActive = false;
searchGridActive = false;
// Initialize line grid as active
currentActiveLineGrid = lineGrid;
clearSearch = true;


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
dynamicWordGrid_colDisplayRow = 14;

dynamicWordGrid = ds_grid_create(dynamicWordGridWidth, 0);

// Hopefully these won't be here for long!
dynamicWordGrid_colTag1Label = "Tag1";
dynamicWordGrid_colTag2Label = "Tag2";
dynamicWordGrid_colTag3Label = "Tag3";

wordStateNormal = 0;//"Normal";//0
wordStateNew = 1;//"New";//1
wordStateChunk = 2;//"Chunk";//2
wordStateDead = 3;//"Dead";//3
wordStateGold = 4;//"Gold";//4
wordStateRed = 5;//"Red";//5



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
emptyHitGrid = ds_grid_create(hitGridWidth, 0);







// Instantiate the Morph Grid
morphGridWidth = 8;
morphGrid_colUnitID = 0;
morphGrid_colWordID = 1;
morphGrid_colParticipant = 2;
morphGrid_colMorph = 3;
morphGrid_colAffix = 4;
morphGrid_colUnitStart = 5;
morphGrid_colUnitEnd = 6;
morphGrid_colGloss = 7;
//morphGridColMap = ds_map_create();




morphGrid = ds_grid_create(morphGridWidth, 0);




originalWordGridHeight = ds_grid_height(wordGrid);
originalUnitGridHeight = ds_grid_height(unitGrid);
originalLineGridHeight = ds_grid_height(lineGrid);




// Instantiate participant lists
participantList = ds_list_create();
participantColorList = ds_list_create();

// Initialize a random value
randomise();


// Initialize the cursor box, which is currently unused
//cursorBox = 0;
//cursorBoxX = 0;
//cursorBoxY = 0;

// Initialize the camera's draw range
drawRange = 8;
drawRangeStart = 0;
drawRangeEnd = 0;
lineSpacing = 6;

// Instantiate the display row ascending variable, currently unused
displayRowAscending = true;

// Set the arrow key speed limit
holdUpArrowKey = 0;
holdDownArrowKey = 0;
holdArrowMod = 1;
holdPgUp = 0;
holdPgDn = 0;
holdPgMod = 4;


// Both of these are unused
//wordColor = c_black;

//alignment = 0;
//0 = left, 1 = center, 2 = right

// Initialize the grid view as inactive
gridView = false;
// Initialize the developer variables as not showing
showDevVars = false;
showFPS = false;
showTranslation = false;


// Initialize the values to hold the hover word info
newWordHoverUnitID = -1;
newWordHoverWordSeq = -1;
newWordHoverWordID = -1;

hoverTokenID = "";
hoverChunkID = "";
hoverUnitID = "";
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
//darkTheme = false;
//darkThemeBackColor = c_dkgray;
//darkThemeTextColor = c_white;
//lightThemeBackColor = c_white;
//lightThemeTextColor = c_black;

// Set global font info
global.fontSize = 0;

// UNused variable
//scrollFast = 0;

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
//simulateRightArrow = 0;

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
mouseHoldRectX1 = -1;
mouseHoldRectY1 = -1;
mouseHoldRectX2 = 0;
mouseHoldRectY2 = 0;
mouseRectMade = false;
mouseRectReleased = false;
inRectTokenIDList = ds_list_create();
inRectWordIDList = ds_list_create();
inRectWordIDListCopy = ds_list_create();
inRectHitIDList = ds_list_create();
inRectUnitIDList = ds_list_create();
quickStackAbleToInitiate = true;
quickStackAbleToSwitch = true;
mouseRectWithinLine = false;
mouseRectWithinColumn = false;
trackChunkMade = false;
mouseRectBeginInWord = -1;
mouseRectBeginBetweenWords = -1;
mouseRectBeginInSpeakerLabel = false;
mouseoverNeutralSpace = false;	
lineContainsMouseYPos = -1;





// Set variables for box creation
boxHoldRectX1 = 0;
boxHoldRectY1 = 0;
boxHoldRectX2 = 0;
boxHoldRectY2 = 0;
boxRectMade = false;
boxRectReleased = true;
boxRectAbleToInitiate = true;
boxRectWithinLine = false;

// Unused variables
//quickInside = false;
//quickOutside = false;

// Allow use of shortcuts
shortcutsEnabled = true;

// Keep track of session length
sessionStartTime = current_time;
//currentSessionTime = 0;

// Search box variables
fPressed = false;
ePressed = false;
gPressed = false;
regExCheck = false;
goToTime = false;
rename = false;
before = true;
recolor = false;
caption = false;
replace = false;
splitWord = false;
swapLine = false;
changeAuthor = false;
changeZero = false;
newTagCategory = false;
newCustomTagToken = false;
newCustomFieldToken = false;
newCustomTagUnit = false;
newCustomFieldUnit = false;
newCustomTagEntry = false;
newCustomFieldEntry = false;
newCustomTagChain = false;
newCustomFieldChain = false;
newCustomTagChunk = false;
newCustomFieldChunk = false;
newCustomTagLink = false;
newCustomFieldLink = false;
quickLinkAllowed = true;
inChainBool = false;
transcriptSearch = false;
caseSensitive = false;
cursorPos = 1 ;
cursorViz = false;
inputText = "";
cursorTimer = 20;

newWordPre1 = false
newWordPre2 = false
newWordPre3 = false
currentNewWordPre = 1;
lastAddedWord = "";


hitIDCounter = 1;

selectedChainID = "";
selectedSearchID = "";
selectedSearchTokenID = "";

dialogueBoxActive = false;
newWordCreated = false;

touchReleaseCheck = false;
// Safety check for quick volunteers
alarm[9] = 10;


mouseoverPanelPane = false;
rectNotInPanelPane = false;
mouseoverDialogueBox = false;
mouseoverSpeakerLabel = false;
mouseoverHelpPane = false;
mouseoverTagShortcut = "";

gridInDelete = undefined;

newWordDeleted = false;

boxGridWidth = 6;
boxGrid_colUnitID = 0;
boxGrid_colWordIDList = 1;
boxGrid_colChainIDLists = 2;
//boxGrid_colVoidSum = 3;
//boxGrid_colTimeSpent = 4;
//boxGrid_colMoveCount = 5;





scr_scrollBarInit();
scrollPlusX = 0;
scrollPlusXDest = 0;


x = 0;
y = 0;

drawRangeCenterOffset = 0;
drawRangeExtraStepsForward = 0;
drawRangeExtraStepsBack = 0;
drawRangeCenter = 0;


drawLineYOffset = 0;
global.canScroll = true;
mouseoverScrollBar = false;

//toolTipText = 0;

swapLinePos1 =  0;
swapLinePos2 =  0;

showLineNumber = true;
showSpeakerName = false;

//audioTrackStream = -1;
//audioTrackIndex = -1;


combineChainsFocused = "";
combineChainsSelected = "";
stackMerged = false;
rightClickID = "";
rightClicked = false;

deleteNewWord = false;
deleteChunkWord = false;
fromDropDown = false;
wideDropDown = false;

layerLinkAllow = false;
layerLinkWordID = -1;
layerLinkUnitID = -1;

hoverTime[0] = 0;
hoverTime[1] = 0;
hoverTime[2] = 0;

transcriptAvailable = false;


initialValidFileCheck = false;


justifyLeft = 0;
justifyCenter = 1;
justifyRight = 2;
justify = justifyLeft;


hideAll = false;

updatedSpeakerLabel = false;
tokenFieldList = ds_list_create();
unitFieldList = ds_list_create();
navTokenFieldList = ds_list_create();
navUnitFieldList = ds_list_create();
navChunkFieldList = ds_list_create();

show_debug_message("obj_control, copying field lists... global.tokenFieldList: " + scr_getStringOfList(global.tokenFieldList));
show_debug_message("obj_control, copying field lists... global.unitFieldList: " + scr_getStringOfList(global.unitFieldList));


tokenFieldList = ds_list_create();
chunkFieldList = ds_list_create();
var tokenTagMap = global.nodeMap[? "tokenTagMap"];
var tokenFieldListSize = ds_list_size(global.tokenFieldList);
for (var i = 0; i < tokenFieldListSize; i++) {
	var currentField = global.tokenFieldList[| i];
	var currentFieldSubMap = tokenTagMap[? currentField];
	var currentTargetSet = currentFieldSubMap[? "targetList"];
	if (scr_isNumericAndExists(currentTargetSet, ds_type_list)) {
		if (ds_list_find_index(currentTargetSet, "token") >= 0) {
			scr_addToListOnce(tokenFieldList, currentField);
			scr_addToListOnce(chunkFieldList, currentField);
		}
		if (ds_list_find_index(currentTargetSet, "chunk") >= 0) {
			scr_addToListOnce(chunkFieldList, currentField);
		}
	}
}

//ds_list_copy(tokenFieldList, global.tokenFieldList);
ds_list_copy(unitFieldList, global.unitFieldList);


ds_list_copy(navTokenFieldList, tokenFieldList);
ds_list_copy(navUnitFieldList, global.unitFieldList);
ds_list_copy(navChunkFieldList, chunkFieldList);

// we shouldn't have more than 6 columns in our nav panes
while (ds_list_size(navTokenFieldList) > 6) ds_list_delete(navTokenFieldList, ds_list_size(navTokenFieldList) - 1);
while (ds_list_size(navUnitFieldList) > 6) ds_list_delete(navUnitFieldList, ds_list_size(navTokenFieldList) - 1);
while (ds_list_size(navChunkFieldList) > 6) ds_list_delete(navChunkFieldList, ds_list_size(navChunkFieldList) - 1);





tokenImportColToChange = 0;
tokenImportRowToChange = 0;
unitImportColToChange = 0;
unitImportRowToChange = 0;
stackColToChange = 0;
stackRowToChange = 0;

tokenFieldToChange = "";
unitFieldToChange = "";
tokenToChange = "";
unitToChange = "";

linkFieldSelected = "";



quickPickedChainID = "";

activeStackType = "Default";
readModeHints = 0;

mouseOverUI = false;

ctrlHold = false;

wordWrap = false;

chainVoidCheckList = ds_list_create();
chainStretchCheckList = ds_list_create();
chainStretchCheck = true;
newestEntry = "";

//draw Line directional states
lineState_ltr = "leftToRight";
lineState_rtl = "righToLeft";
drawLineState = lineState_ltr;


chain1toManyEntryToChange = "";
chain1toManyFieldToChange = "";
chain1ToManyColFieldToChange = -1;

chain1to1ChainToChange = "";
chain1to1FieldToChange = "";
chain1To1ColFieldToChange = -1;

chunk1to1ChunkToChange = "";
chunk1to1FieldToChange = "";

chain1to1ColFieldListRez = ds_list_create(); // list of the dynamic columns in the rezChain 1-1 pane
chain1to1ColFieldListTrack = ds_list_create(); // list of the dynamic columns in the trackChain 1-1 pane
chain1to1ColFieldListStack = ds_list_create(); // list of the dynamic columns in the stackChain 1-1 pane
ds_list_add(chain1to1ColFieldListRez, "chainSize", "entityType");
ds_list_add(chain1to1ColFieldListTrack, "chainSize", "entityType");
ds_list_add(chain1to1ColFieldListStack, "chainSize", "entityType");

chain1toManyColFieldListRez = ds_list_create(); // list of the dynamic columns in the rez 1-many pane
chain1toManyColFieldListTrack = ds_list_create(); // list of the dynamic columns in the track 1-many pane
chain1toManyColFieldListStack = ds_list_create(); // list of the dynamic columns in the stack 1-many pane
ds_list_add(chain1toManyColFieldListRez, "gapUnits", "gapWords", "charCount");
ds_list_add(chain1toManyColFieldListTrack, "gapUnits", "gapWords", "charCount");
ds_list_add(chain1toManyColFieldListStack, "gapUnits");





with (obj_alarm) {
	alarm[10] = 8;
}




global.delayInput = 0;


selectedRezChainList = ds_list_create();
selectedTrackChainList = ds_list_create();
selectedStackChainList = ds_list_create();

hiddenRezChainList = ds_list_create();
hiddenTrackChainList = ds_list_create();
hiddenStackChainList = ds_list_create();


filterActiveRez = false;
filterActiveTrack = false;
filterActiveStack = false;

menuDepth = -1;


displayUnitList = -1;
filterUnitList = ds_list_create();

listOfWords = ds_list_create();


panelPaneTabList = ds_list_create();
with (obj_alarm2) alarm[1] = 2;

displayUnitList = -1


if(global.speakerField != "" && is_string(global.speakerField) ){
	scr_showSpeakerName(true);
}

selectFieldChunk = false;
searchField = global.displayTokenField;
searchRange = "Doc";

if(global.RTLFound){
	drawLineState = lineState_rtl;
	justify = justifyRight;
}

deleteEntryPressed = false;