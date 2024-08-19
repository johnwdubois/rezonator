/*
	Purpose: Instantiate all variables used by panelPane objects
*/

scr_scrollBarInit();

windowResizeXHolding = false;
windowResizeYHolding = false;
canResizeWindowX = true;
canResizeWindowY = true;

// For hiding the Nav window
originalWindowHeight = 20;
y = originalWindowHeight;




with (obj_alarm) {
	alarm[3] = 5;
}





functionChainList = "chainList";
functionChainContents = "chainContents";
functionHelp = "help";
functionTabs = "tabs";



var defaultScrollPlusY = 16;
scrollPlusY_tabUnit = defaultScrollPlusY;
scrollPlusY_tabRez = defaultScrollPlusY;
scrollPlusY_tabTrack = defaultScrollPlusY;
scrollPlusY_tabStack = defaultScrollPlusY;
scrollPlusY_tabShow = defaultScrollPlusY;
scrollPlusY_tabField = defaultScrollPlusY;
scrollPlusY_tabTranslations = defaultScrollPlusY;
scrollPlusY_tabSearch = defaultScrollPlusY;
scrollPlusY_tabChunk = defaultScrollPlusY;
scrollPlusY_tabClique = defaultScrollPlusY;
scrollPlusY_tabTree = defaultScrollPlusY;

with (obj_alarm2) alarm[4] = 2;



treeTabScrollMin = 0;




functionChainList_currentTab = NAVTAB_UNIT;
functionTabs_tabHeight = 16;
functionChainList_sortAsc[0] = true;
functionChainList_sortAsc[1] = true;
functionChainList_sortAsc[2] = true;
functionChainList_sortAsc[3] = true;
functionChainList_sortAsc[4] = true;
functionChainList_focusedUnitIndex = -1;
functionChainList_focusedIndex = -1;
functionChainList_focusedUnit = "";
functionChainList_lineGridRowFocused = 0;
functionChainList_lineGridDisplayYList = ds_list_create();
functionChainList_focusedChainIndex = -1;
functionChainList_playShowID = "";

functionChainContents_chainIDPrev = "";
	
	



functionChainContents_BGColor = global.colorThemePaneBG;
functionChainContents_IDList = 0;
functionChainContents_infoCol = 0;
functionChainContents_hop = -1;
functionChainContents_lineGridRowFocused = -1;
functionChainContents_sortedCol = -1;
functionChainContents_sortedColAsc = true;
functionChainContents_chainID = "";
functionChainContents_showID = "";

alarm[8] = 5;
alarm[9] = 2;


functionHelp_collapsed = true;
functionHelp_windowWidth = 600;
functionHelp_plusX = functionHelp_windowWidth;
functionHelp_plusY = 0;
functionHelp_helpGridWidth = 4;
functionHelp_helpGrid_colKey = 0;
functionHelp_helpGrid_colFunc = 1;
functionHelp_helpGrid_colDesc = 2;
functionHelp_helpGrid_colHide = 3;
functionHelp_menuGridWidth = 4;
functionHelp_menuGrid_colName = 0;
functionHelp_menuGrid_colHide = 1;
functionHelp_menuGrid_colCollapsed = 2;
functionHelp_menuGrid_colGrid = 3;
functionHelp_menuGrid = ds_grid_create(functionHelp_menuGridWidth, 0);
functionHelp_helpGridRez = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridNav = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridShortcuts = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridLink = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridPick = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridSearch = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridView = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridFile = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridMove = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridPlay = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridAdvanced = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridRightClick = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridSettings = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_allCollapsed = true;

functionHelp_helpWindowRectX1 = 0;
functionHelp_helpWindowRectY1 = 0;
functionHelp_helpWindowRectX2 = 0;
functionHelp_helpWindowRectY2 = 0;
alarm[3] = 1;



for (var i = 0; i < 3; i++) {
	functionFilter_peek[i] = false;
}

scrollBarHolding = false;
scrollBarClickLock = false;
scrollBarHoldingPlusY = 0;
currentTopViewRow = 0;
//backupFocusedRow = -1;

showAdvancedNav = false;


selectedDiscoID = "";
discoIDSelected = false;
discoSelectionActive = false;
//Rez Tracker variables
showTracker = true;
//isTrackerOpen = false;
currentYheight = 0;
currentYheightCounterText = 0;
currentYheightTimerText = 0;
currentYheightResetText = 0;
currentResetY1value = 0;
currentResetY2value = 0;
timerMins = 0;
timerSecs = 0;


alarm[0] = 1;
chainListPane = -1;

clickedIn = false;

holdUp = 0;
holdDown = 0;


showNav = true;
showNavLeft = true;
showNavRight = true;
tokenContentsHeaderListSize = 3;
unitContentsHeaderListSize = 2;

// if we are importing AI chat, hide nav window by default
if (global.project == "import" && global.importType == IMPORTTYPE_AICHAT) {
	showNav = false;
	showNavLeft = false;
	showNavRight = false;
}


chosenCol = 0;
ascendYScale = 1;
selectedColToken = 0;
selectedColUnit = 0;
selectedColChain = 0;
stackTagMapKey = "";

lineContentsHighlightRow = -1;
chainTagsHighlightRow = -1;
functionChainList_highlightUnit = "";

chainViewOneToMany = true;

previousChainContentsRow = -1;

functionField_tokenFieldSelected = "";
functionField_tokenTagSelected = "";
functionField_unitFieldSelected = "";
functionField_unitTagSelected = "";
functionField_entryFieldSelected = "";
functionField_entryTagSelected = "";
functionField_chainFieldSelected = "";
functionField_chainTagSelected = "";
functionField_chunkFieldSelected = "";
functionField_chunkTagSelected = "";
functionField_linkFieldSelected = "";
functionField_linkTagSelected = "";

functionChainList_chunkSelected = "";
functionChainList_chunkMouseover = "";


functionSearchList_searchSelected = "";
functionSearchList_searchMouseover = "";
functionSearchList_tokenSelected = "";
functionSearchList_tokenMouseover = "";
functionClique_cliqueSelected = "";
functionTree_treeSelected = "";
functionTree_treeMouseoverLinkArea = false;
functionTree_treeMouseoverArea = false;
functionTree_treeLinkMouseover = "";
functionTree_treeLinkSelected = "";


functionTag_fieldList = -1;
functionTag_tagList = -1;


hoverTime[0] = 0;
hoverTime[1] = 0;
hoverTime[2] = 0;
hoverTime[3] = 0;


errorText = "";



fieldPaneTokenMode = "option_token";
fieldPaneUnitMode = "error_unit";
fieldPaneChainMode = "option_chain";
fieldPaneEntryMode = "Entry";
fieldPaneChunkMode = "option_chunk";
fieldPaneLinkMode = "help_header_link";
fieldPaneSwitchButton = fieldPaneTokenMode;
fieldChains1ToManyChainType = "";
fieldChains1To1ChainType = "";
cliquePaneSwitchButton = "option_chain";

scrollPlusX = 0;

leftPaneStrHeight = 0;
rightPaneStrHeight = 0;

selectListPrevIndex = -1;

unit1toMColAmount = 1;
unit1to1ColAmount = 1;
chain1toMColAmount = 6;
chain1to1ColAmount = 2;
chunk1to1ColAmount = 1;

scrollPlusY_LSync = -1;
scrollPlusY_RSync = -1;

#macro EVENT_TICK 0
#macro EVENT_STOP 1
#macro EVENT_PLAY 2
#macro EVENT_PAUSE 3
#macro EVENT_RESUME 4
#macro EVENT_SEEK 5