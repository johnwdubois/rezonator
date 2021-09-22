/*
	Purpose: Instantiate all variables used by the chain objects
*/

toggleDrawRez = true;
toggleDrawTrack = true;
toggleDrawStack = true;

chainGridWidth = 9;
chainGrid_colChainID = 0;
chainGrid_colChainState = 1;
chainGrid_colWordIDList = 2;
chainGrid_colName = 3;
chainGrid_colColor = 4;
chainGrid_colInFilter = 5;
chainGrid_colAlign = 6;
chainGrid_colTiltSum = 7;
chainGrid_colChainSeq = 7;
chainGrid_colAuthor = 8;
chainGrid_colCaption = 9;
chainGrid_colStackType = 10;
chainGrid_colAct = 11; // stack tag
chainGrid_colRepair = 12; // stack tag
chainGrid_colActSequence = 13; // stack tag

chainGrid_colShow = 9;


placeChainGrid = ds_grid_create(chainGridWidth, 0);



//creatingPlaceChains = false;

unitInStackGridWidth = 3;
unitInStackGrid_colUnitID = 0;
unitInStackGrid_colStack = 1;
unitInStackGrid_colStackType = 2;
unitInStackGrid = ds_grid_create(unitInStackGridWidth, 0);
unitInStackGrid_focusedCol = unitInStackGrid_colStack;

currentChain = 0;
currentChainID = 0;

//chainStateTotal = 5;
chainStateNormal = 0;//"Normal";//0
//chainStateActive = 1;
chainStateFocus = 2;//"Focus";//2
//chainStateInactive = 3;
//chainStateHidden = 4;
chainStateDead = 5;//"Dead";//5

chainColorList = ds_list_create();
chainColorID[1] = 0;
chainColorID[2] = 0;
chainColorID[3] = 0;
ds_list_add(chainColorList, c_blue, c_red, c_green, c_purple, c_olive, c_orange, c_fuchsia, c_teal);



rezTier = 1;
trackTier = 2;
stackTier = 3;



rezChainNameCounter = ds_list_size(global.nodeMap[? "resonanceList"]);
trackChainNameCounter = ds_list_size(global.nodeMap[? "trailList"]);
stackChainNameCounter = ds_list_size(global.nodeMap[? "stackList"]);


currentFocusedChainID = "";
currentFocusedChunkID = "";
currentFocusedEntryID = "";
focusedChainWordID = "";
focusedChainWrongTool = false;



mouseLineHide = false;

mouseLineWordID = "";


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

//cliqueGridChainIDTakenOut = -1;
//cliqueGridChainIndexToTakeOut = -1;

cliqueGridRowToRefreshFlanks = -1;


cliqueCount = 0;
encounteredUnitList = ds_list_create();
encounteredTokenList = ds_list_create();
encounteredChainList = ds_list_create();
encounteredChunkList = ds_list_create();
traversedUnitList = ds_list_create();
cliqueList =  ds_list_create();
currentClique = "";
cycleDetected = false;


rezChainGridRowToRefreshTilt = -1;


//recentlyMovedLinks = ds_list_create();
recentlyMovedWords = ds_list_create();
alarm[4] = 30;

//New fields for Tween focus funtionality
unitIDOfFirstWord = -1;
unitIDOfLastWord = -1;


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



goldStandardGridWidth = 4;
//goldStandardGridHeight = 0;
goldStandardGrid = ds_grid_create(goldStandardGridWidth, 0);
goldStandardGrid_colStackID = 0;
goldStandardGrid_colWordIDList = 1;
goldStandardGrid_colUser = 2;
goldStandardGrid_colScore = 3;

// For toggling Place chains
showTrackArrows = false;
showRezArrows = false;


stackChainGridRowToCaption = -1;



chainShowMap = ds_map_create();
chainShowList = ds_list_create();
chunkShowList = ds_list_create();
chunkShowMap = ds_map_create();
ds_map_add(chainShowMap, "type", "map");
//ds_map_add(chunkShowMap, "type", "map");
ds_map_add_map(global.nodeMap, "chainShowMap", chainShowMap);
ds_map_add_map(global.nodeMap, "chunkShowMap", chunkShowMap);


filteredRezChainList = ds_list_create();
filteredTrackChainList = ds_list_create();
filteredStackChainList = ds_list_create();





trackGridWidth = 10;
trackGrid_colChainID = 0;
trackGrid_colChainName = 1;
trackGrid_colChainSeq = 2;
trackGrid_colTrackSeq = 3;
trackGrid_colWordID = 4;
trackGrid_colIsChunk = 5;
trackGrid_colChunkID = 6;
trackGrid_colText = 7;
trackGrid_colTranscript = 8;
trackGrid_colUnitText = 9;
trackGrid = ds_grid_create(trackGridWidth, 0);
rezGrid = ds_grid_create(trackGridWidth, 0);

mouseOverAnyChunk = false;


// update the filtered chain lists now that we have those good ol chain lists loaded
scr_updateFilteredChainLists();

dragStartOriginalChain = "";
dragStartOriginalUnit = "";

randomize();
chainHue = random(255);

quickLinkCreated = false;
quickLinkDeleted = false;