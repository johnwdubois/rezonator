/*
	obj_chain: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of a chain object
	
	Purpose: Instantiate all variables used by the chain objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

chainGridWidth = 8;
chainGrid_colChainID = 0;
chainGrid_colChainState = 1;
chainGrid_colWordIDList = 2;
chainGrid_colName = 3;
chainGrid_colColor = 4;
chainGrid_colInFilter = 5;
chainGrid_colAlign = 6;
chainGrid_colTiltSum = 7;

rezChainGrid = ds_grid_create(chainGridWidth, 0);
trackChainGrid = ds_grid_create(chainGridWidth, 0);
stackChainGrid = ds_grid_create(chainGridWidth, 0);
cliqueDisplayGrid = ds_grid_create(chainGridWidth, 0);

unitInStackGridWidth = 3;
unitInStackGrid_colUnitID = 0;
unitInStackGrid_colStackList = 1;
unitInStackGrid_colTempStackList = 2;
unitInStackGrid = ds_grid_create(unitInStackGridWidth, 0);

currentChainID = 0;

chainStateTotal = 5;
chainStateNormal = 0;
chainStateActive = 1;
chainStateFocus = 2;
chainStateInactive = 3;
chainStateHidden = 4;
chainStateDead = 5;

currentChainGrid = rezChainGrid;
currentChainName = "Rez";

chainColorList = ds_list_create();
chainColorID[1] = 0;
chainColorID[2] = 0;
chainColorID[3] = 0;
ds_list_add(chainColorList, c_blue, c_red, c_green, c_purple, c_olive, c_orange, c_fuchsia, c_teal);


linkGridWidth = 9;
linkGrid_colTier = 0;
linkGrid_colChainID = 1;
linkGrid_colLinkID = 2;
linkGrid_colSource = 3;
linkGrid_colGoal = 4;
linkGrid_colFocus = 5;
linkGrid_colDead = 6;
linkGrid_colTilt = 7;
linkGrid_colTimeStamp = 8;

linkGrid = ds_grid_create(linkGridWidth, 0);



vizLinkGridWidth = 10;
vizLinkGrid_colTier = 0;
vizLinkGrid_colChainID = 1;
vizLinkGrid_colLinkID = 2;
vizLinkGrid_colSource = 3;
vizLinkGrid_colGoal = 4;
vizLinkGrid_colFocus = 5;
vizLinkGrid_colTilt = 6;
vizLinkGrid_colCross = 7;
vizLinkGrid_colStretch = 8;
vizLinkGrid_colAlign = 9;

vizLinkGrid = ds_grid_create(vizLinkGridWidth, 0);

linkIDCounter = 0;
rezChainNameCounter = 0;
trackChainNameCounter = 0;
stackChainNameCounter = 0;

currentFocusedChainID = -1;

mouseLineHide = false;

mouseLineWordID = -1;


cliqueGridWidth = 11;
cliqueGrid_colCliqueID = 0;
cliqueGrid_colChainIDList = 1;
cliqueGrid_colUnitIDList = 2;
cliqueGrid_colRangeStart = 3;
cliqueGrid_colRangeEnd = 4;
cliqueGrid_colFlankLeft = 5;
cliqueGrid_colFlankRight = 6;
cliqueGrid_colLength = 7;
cliqueGrid_colBreak = 8;
cliqueGrid_colTilt = 9;
cliqueGrid_colName = 10;
cliqueGrid = ds_grid_create(cliqueGridWidth, 0);

cliqueIDCounter = 0;

cliqueGridRowToRefresh = -1;
cliqueGridRowToCheckBreak = -1;

cliqueGridChainIDTakenOut = -1;
cliqueGridChainIndexToTakeOut = -1;

cliqueGridRowToRefreshFlanks = -1;


rezChainGridRowToRefreshTilt = -1;


recentlyMovedLinks = ds_list_create();
recentlyMovedWords = ds_list_create();
alarm[4] = 30;

//New fields for Tween focus funtionality
chainIDModifyList = ds_list_create();
unitIDOfFirstWord = -1;
unitIDOfLastWord = -1;

focusPrior = false;
focusTween = false;
focusNext = false;

//Fields for keeping tabFocus
oldRezFocus = -1;
oldTrackFocus = -1;
oldStackFocus = -1;


/*
raceGridWidth = 3;
raceGrid_colWordID = 0;
raceGrid_colRaceSteps = 1;
raceGrid_colRaceRank = 2;
*/

chainIDRaceCheck = -1;

oldFocusedContentsRow = -1;