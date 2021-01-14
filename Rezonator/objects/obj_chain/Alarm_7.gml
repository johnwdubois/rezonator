/// @description Insert description here
// You can write your code in this editor

if (ds_grid_height(rezPlayLinkGrid) < 1
or rezPlayLinkGridRow < 0
or rezPlayLinkGridRow >= ds_grid_height(rezPlayLinkGrid)) {
	exit;
}

if (rezPlayLinkGridRow == 0) {
	scr_setAllValuesInCol(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, true);
}


var currentTier = ds_grid_get(rezPlayLinkGrid, linkGrid_colTier, rezPlayLinkGridRow);
obj_toolPane.currentTool = currentTier;

var currentSource = ds_grid_get(rezPlayLinkGrid, linkGrid_colSource, rezPlayLinkGridRow);
if (currentSource < 0 or currentSource >= ds_grid_height(obj_control.wordGrid)) {
	exit;
}
var currentSourceUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentSource - 1);
var currentChainID = ds_grid_get(rezPlayLinkGrid, linkGrid_colChainID, rezPlayLinkGridRow);

if (rezPlayLinkGridChainID > -1 && rezPlayLinkGridChainID != currentChainID) {
	show_debug_message("obj_chain Alarm 7");
	scr_chainDeselect();
	scr_refreshVizLinkGrid();
}
rezPlayLinkGridChainID = currentChainID;
	
scr_wordClicked(currentSource, currentSourceUnitID);

var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentSource - 1);
var currentRowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
var currentDisplayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowInLineGrid);

if (abs(obj_control.currentCenterDisplayRow - currentDisplayRow) > 10) {
	obj_control.currentCenterDisplayRow = currentDisplayRow;
}


var currentWordClickTime = ds_grid_get(rezPlayLinkGrid, linkGrid_colSourceClickTime, rezPlayLinkGridRow);
var nextWordClickTime = ds_grid_get(rezPlayLinkGrid, linkGrid_colGoalClickTime, rezPlayLinkGridRow);

if (rezPlayLinkGridRow < ds_grid_height(rezPlayLinkGrid) - 1) {
	
	var nextTier = ds_grid_get(rezPlayLinkGrid, linkGrid_colTier, rezPlayLinkGridRow + 1);
	obj_toolPane.currentTool = nextTier;
	
	if (nextWordClickTime < 0) {
		nextWordClickTime = ds_grid_get(rezPlayLinkGrid, linkGrid_colSourceClickTime, rezPlayLinkGridRow + 1);
	}
}

nextWordClickTime = min((nextWordClickTime - currentWordClickTime) * fps, fps * 10);

rezPlayLinkGridRow++;

if (nextWordClickTime == 0) {
	//show_message("here")
	nextWordClickTime = 2;
}

if (nextWordClickTime > 0) {
	alarm[7] = nextWordClickTime;
}
else {
	inRezPlay = false;
	scr_unFocusAllChains();
	scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
}