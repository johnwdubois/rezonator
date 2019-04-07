/*
	obj_control: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of a control object
	
	Purpose: Instantiate all variables used by control objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

currentCenterDisplayRow = 0;
prevCenterDisplayRow = 0;

gridSpaceHorizontalMin = 60;
gridSpaceVerticalMin = 23.40;
gridSpaceHorizontalMax = 400;
gridSpaceVerticalMax = 303.40;

gridSpaceHorizontal = 100;
gridSpaceVertical = 33.4;

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


c_ltblue = make_color_rgb(183, 183, 255);


shapeText = 0;
shapeBlock = 1;
shape = shapeBlock;


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

unitGrid = ds_grid_create(unitGridWidth, 0);



wordGridWidth = global.wordGridWidth;
wordGrid_colWordID = 0;
wordGrid_colUnitID = 1;
wordGrid_colWordSeq = 2;
wordGrid_colWordToken = 3;
wordGrid_colWordTranscript = 4;

wordGrid = ds_grid_create(wordGridWidth, 0);

wordIDCounter = 0;
unitIDCounter = 0;


wordTranscriptView = true;




lineGridWidth = 12;
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

lineGrid = ds_grid_create(lineGridWidth, 0);
lineGridDefaultSort = true;

voidLimit = 25;


searchGrid_colHitIDList = lineGrid_colWordIDList;

filterGrid = ds_grid_create(lineGridWidth, 0);
searchGrid = ds_grid_create(lineGridWidth, 0);



filterGridActive = false;
searchGridActive = false;

currentActiveLineGrid = lineGrid;



dynamicWordGridWidth = global.dynamicWordGridWidth;
dynamicWordGrid_colWordID = 0;
dynamicWordGrid_colDisplayWordSeq = 1; //dynamicWordGrid_colLineWordSeq = 1;
dynamicWordGrid_colDisplayCol = 2; //dynamicWordGrid_colPositionCol = 2;
dynamicWordGrid_colPixelX = 3; //dynamicWordGrid_colX = 3; 
dynamicWordGrid_colWordState = 4;
dynamicWordGrid_colDisplayString = 5; //dynamicWordGrid_colStringDisplay = 5;
dynamicWordGrid_colInChainList = 6; //dynamicWordGrid_colInChains = 6;
dynamicWordGrid_colAligned = 7;
dynamicWordGrid_colVoid = 8;
dynamicWordGrid_colStretch = 9;

dynamicWordGrid = ds_grid_create(dynamicWordGridWidth, 0);



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




hitGridWidth = 7;
hitGrid_colWordID = 0;
hitGrid_colUnitID = 1;
hitGrid_colHitID = 2;
hitGrid_colWordState = 3;
hitGrid_colHitBool = 4;
hitGrid_colDisplayCol = 5;
hitGrid_colPixelX = 6;

hitGrid = ds_grid_create(hitGridWidth, 0);







participantList = ds_list_create();
participantColorList = ds_list_create();


randomise();



cursorBox = 0;
cursorBoxX = 0;
cursorBoxY = 0;

drawRange = 30
drawRangeStart = 0;
drawRangeEnd = 0;


displayRowAscending = true;

holdUpArrowKey = 0;
holdDownArrowKey = 0;

wordColor = c_black;

alignment = 0;
//0 = left, 1 = center, 2 = right

gridView = false;

showDevVars = false;

newWordHoverUnitID = -1;
newWordHoverWordSeq = -1;
newWordHoverWordID = -1;

hoverWordID = -1;

ableToCreateDropDown = true;
ableToCreateDropDownAlarmSet = false;

showDevMessages = false;

showDisplayCols = false;

mostRecentlyAddedWord = -1;
mostRecentlyAddedWordMoved = -1;

canPressPlus = true;
canPressMinus = true;


darkTheme = false;
darkThemeBackColor = c_dkgray;
darkThemeTextColor = c_white;
lightThemeBackColor = c_white;
lightThemeTextColor = c_black;

global.fontSize = 0;
global.fontMain = fnt_main;
global.fontChainList = fnt_chainList;
global.fontPanelTab = fnt_panelTab;
global.fontSortPane = fnt_sortPane;

scrollFast = 0;

leftScreenBound = 0;



// set BG color based on color theme
var layerID = layer_get_id("Background");
var backID = layer_background_get_id(layerID);
var BGcolor = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBG, global.colorTheme);
layer_background_blend(backID, BGcolor);

preSwitchDisplayRow = 0;
preSwitchSearchDisplayRow = 0;
highlightedSearchRow = 0;
highlightedSearchRowAlpha = 0;

simulateRightArrow = 0;

allSaved = true;

mouseHoldRectX1 = 0;
mouseHoldRectY1 = 0;
mouseHoldRectX2 = 0;
mouseHoldRectY2 = 0;
mouseRectMade = false;
mouseRectReleased = false;
inRectWordIDList = ds_list_create();
inRectUnitIDList = ds_list_create();
quickStackAbleToInitiate = true;

shortcutsEnabled = true;

sessionStartTime = current_time;
currentSessionTime = 0;

alarm[9] = 10;