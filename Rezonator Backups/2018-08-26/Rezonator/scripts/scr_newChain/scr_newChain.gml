/*
	scr_newChain(wordID, unitID);
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: creates a new chain of correct type, enters given ID as first chain IDList value
	
	Mechanism: check obj_toolPane for current tool, add new row to corresponding chainGrid
*/

var wordID = argument0;
var unitID = argument1;

var chainGrid = currentChainGrid;
var chainName = "";

var aligned = false;

switch (obj_toolPane.currentTool)
{
	case obj_toolPane.toolRezBrush:
		with (obj_panelPane)
		{
			functionChainList_currentTab = functionChainList_tabRezBrush;
		}
		aligned = true;
		rezChainNameCounter++;
		chainName = currentChainName + " " + string(rezChainNameCounter);
		break;
	case obj_toolPane.toolTrackBrush:
		with (obj_panelPane)
		{
			functionChainList_currentTab = functionChainList_tabTrackBrush;
		}
		trackChainNameCounter++;
		chainName = currentChainName + " " + string(trackChainNameCounter);
		break;
	case obj_toolPane.toolStackBrush:
		with (obj_panelPane)
		{
			functionChainList_currentTab = functionChainList_tabStackBrush;
		}
		stackChainNameCounter++;
		chainName = currentChainName + " " + string(stackChainNameCounter);
		break;
	default:
		exit;
}


ds_grid_resize(chainGrid, chainGridWidth, ds_grid_height(chainGrid) + 1);
var currentRowChainGrid = ds_grid_height(chainGrid) - 1;

currentChainID++;
var chainIDType = ds_grid_height(chainGrid) - 1;
var wordIDList = ds_list_create();

if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
{
	ds_list_add(wordIDList, unitID + 1);
	
	var stackList = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, unitID);
	ds_list_add(stackList, currentChainID);
}
else
{
	ds_list_add(wordIDList, wordID);
}


while (ds_grid_value_exists(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus))
{
	var index = ds_grid_value_y(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus);	
	ds_grid_set(chainGrid, chainGrid_colChainState, index, chainStateNormal);
}


var chainColor = ds_list_find_value(chainColorList, chainColorID[obj_toolPane.currentTool]);

chainColorID[obj_toolPane.currentTool]++;

if (chainColorID[obj_toolPane.currentTool] >= ds_list_size(chainColorList))
{
	chainColorID[obj_toolPane.currentTool] = 0;
}


ds_grid_set(chainGrid, chainGrid_colChainID, currentRowChainGrid, currentChainID);
ds_grid_set(chainGrid, chainGrid_colChainState, currentRowChainGrid, chainStateFocus);
ds_grid_set(chainGrid, chainGrid_colWordIDList, currentRowChainGrid, wordIDList);
ds_grid_set(chainGrid, chainGrid_colName, currentRowChainGrid, chainName);
ds_grid_set(chainGrid, chainGrid_colColor, currentRowChainGrid, chainColor);
ds_grid_set(chainGrid, chainGrid_colInFilter, currentRowChainGrid, false);
ds_grid_set(chainGrid, chainGrid_colAlign, currentRowChainGrid, aligned);

currentFocusedChainID = currentChainID;



with (obj_panelPane)
{
	functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
	functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
}