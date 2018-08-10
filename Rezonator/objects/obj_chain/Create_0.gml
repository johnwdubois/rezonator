chainGridWidth = 6;
chainGrid_colChainID = 0;
chainGrid_colChainState = 1;
chainGrid_colWordIDList = 2;
chainGrid_colName = 3;
chainGrid_colColor = 4;
chainGrid_colInFilter = 5;

rezChainGrid = ds_grid_create(chainGridWidth, 0);
anaphChainGrid = ds_grid_create(chainGridWidth, 0);
stackChainGrid = ds_grid_create(chainGridWidth, 0);

unitInStackGridWidth = 2;
unitInStackGrid_colUnitID = 0;
unitInStackGrid_colStackList = 1;
unitInStackGrid = ds_grid_create(unitInStackGridWidth, 0);
alarm[0] = 1;

currentChainID = 0;

chainStateTotal = 5;
chainStateNormal = 0;
chainStateActive = 1;
chainStateFocus = 2;
chainStateInactive = 3;
chainStateHidden = 4;

currentChainGrid = rezChainGrid;
currentChainName = "RezChain";

chainColorList = ds_list_create();
chainColorID[1] = 0;
chainColorID[2] = 0;
chainColorID[3] = 0;
ds_list_add(chainColorList, c_blue, c_red, c_green, c_purple, c_olive, c_orange, c_fuchsia, c_teal);


linkGridWidth = 6;
linkGrid_colTier = 0;
linkGrid_colChainID = 1;
linkGrid_colLinkID = 2;
linkGrid_colSource = 3;
linkGrid_colGoal = 4;
linkGrid_colFocus = 5;
linkGrid = ds_grid_create(linkGridWidth, 0);

linkIDCounter = 0;

currentFocusedChainID = -1;