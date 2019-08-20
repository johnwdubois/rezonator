/*
	obj_panelPane: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of panelPane objects
	
	Purpose: Instantiate all variables used by panelPane objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
scrollPlusY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
canResizeWindowX = true;
canResizeWindowY = true;
// For hiding the Nav window
originalWindowHeight = 0;
collapsedWindowHeight = 2000;


// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;









functionChainList = 0;
functionChainContents = 1;
functionFilter = 2;
functionSort = 3;
functionSearch = 4;
functionClique = 5;
functionHelp = 6;
functionGoToLine = 7;
functionGraphStats = 8;

functionChainList_tabRezBrush = 0;
functionChainList_tabTrackBrush = 1;
functionChainList_tabStackBrush = 2;
functionChainList_tabClique = 3;
functionChainList_currentTab = functionChainList_tabRezBrush;
functionChainList_maxScrollRange = 5;
functionChainList_tabName[0] = "Rez";
functionChainList_tabName[1] = "Track";
functionChainList_tabName[2] = "Stack";
functionChainList_tabName[3] = "Clique";
functionChainList_scrollRangeMin[0] = 0;
functionChainList_scrollRangeMax[0] = functionChainList_maxScrollRange;
functionChainList_scrollRangeMin[1] = 0;
functionChainList_scrollRangeMax[1] = functionChainList_maxScrollRange;
functionChainList_scrollRangeMin[2] = 0;
functionChainList_scrollRangeMax[2] = functionChainList_maxScrollRange;
functionChainList_scrollRangeMin[3] = 0;
functionChainList_scrollRangeMax[3] = functionChainList_maxScrollRange;

functionChainContents_IDList = 0;
functionChainContents_infoCol[0] = 0;
functionChainContents_infoCol[1] = 1;
functionChainContents_infoCol[2] = 2;
functionChainContents_maxScrollRange = 8;
functionChainContents_scrollRangeMin[0] = 0;
functionChainContents_scrollRangeMax[0] = functionChainContents_maxScrollRange;
functionChainContents_hop = -1;

functionChainContents_colXList = ds_list_create();
functionChainContents_colXHolding = -1
functionChainContents_colXHoldingPrev = 0;
functionChainContents_colXHoldingDiff = 0;
functionChainContents_colPrevList = ds_list_create();



functionSort_initialSort = false;
functionSort_performSort = false;
functionSort_animationSeq = -1;
functionSort_animationAlpha = 0;
functionSort_grid = -1;
functionSort_gridGridSelected = 0;
functionSort_gridGrid_colGrid = 0;
functionSort_gridGrid_colHard = 1;
functionSort_gridGrid_colSortGrid = 2;
functionSort_gridGrid = ds_grid_create(3, 4);
functionSort_gridSortGridWidth = 3;
functionSort_gridSortColGrid_colCol = 0;
functionSort_gridSortColGrid_colAscend = 1;
functionSort_gridSortColGrid_colMouseover = 2;

functionHelp_collapsed = true;
functionHelp_windowWidth = 300;
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
functionHelp_helpGridLink = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridPick = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridSearch = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridView = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridFile = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridMove = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridPlay = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridAdvanced = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_helpGridAbout = ds_grid_create(functionHelp_helpGridWidth, 0);
functionHelp_allCollapsed = true;
functionHelp_rezCollapsed = false;
functionHelp_navCollapsed = false;

functionHelp_helpWindowRectX1 = 0;
functionHelp_helpWindowRectY1 = 0;
functionHelp_helpWindowRectX2 = 0;
functionHelp_helpWindowRectY2 = 0;
alarm[3] = 1;

functionGoToLine_selectedDisco = 0;

functionGraphStats_mainGridWidth = 3;
functionGraphStats_mainGrid = ds_grid_create(functionGraphStats_mainGridWidth, 0);


for (var i = 0; i < 3; i++) {
	functionFilter_peek[i] = false;
	functionFilter_peekList[i] = ds_list_create();
}

scrollBarHolding = false;
scrollBarHoldingPlusY = 0;
currentTopViewRow = 0;
//oldFocusedContentsRow = -1;
//backupFocusedRow = -1;

showAdvancedNav = false;

doubleClickTimer = -1;

selectedDiscoID = "";
discoIDSelected = false;
discoSelectionActive = false;
//Rez Tracker variables
showTracker = true;
isTrackerOpen = false;
currentYheight = 0;
currentYheightCounterText = 0;
currentYheightTimerText = 0;
currentYheightResetText = 0;
currentResetY1value = 0;
currentResetY2value = 0;
timerMins = 0;
timerSecs = 0;


alarm[0] = 1;

clickedIn = false;

holdUp = 0;
holdDown = 0;


showNav = true;