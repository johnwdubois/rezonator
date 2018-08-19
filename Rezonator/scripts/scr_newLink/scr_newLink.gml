var wordID = argument0;
var goal = argument1;
var focus = true;


if (goal > -1)
{
	focus = false;
}


var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID - 1);

if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
{
	var idSet = unitID;
}
else
{
	var idSet = wordID;
}

if (currentFocusedChainID == -1)
{
	exit;
}

ds_grid_resize(obj_chain.linkGrid, obj_chain.linkGridWidth, ds_grid_height(obj_chain.linkGrid) + 1);
var currentLinkGridRow = ds_grid_height(obj_chain.linkGrid) - 1;

linkIDCounter++;

//if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true))
if (scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentFocusedChainID, obj_chain.linkGrid_colGoal, -1) > -1)
{
	//var focusedRow = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true);
	var focusedRow = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentFocusedChainID, obj_chain.linkGrid_colGoal, -1);
	
	//if (ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, focusedRow) == -1)
	//{
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, focusedRow, idSet);
	//}
}

ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentLinkGridRow, currentFocusedChainID);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colLinkID, currentLinkGridRow, linkIDCounter);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colTier, currentLinkGridRow, obj_toolPane.currentTool);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentLinkGridRow, idSet);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, currentLinkGridRow, goal);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, focus);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, currentLinkGridRow, false);

scr_gridMultiColSort(linkGrid, linkGrid_colTier, true, linkGrid_colChainID, true, linkGrid_colLinkID, true, linkGrid_colDead, true);