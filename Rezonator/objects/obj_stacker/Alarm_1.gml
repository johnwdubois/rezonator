/// @description Insert description here
// You can write your code in this editor
var endLine = ds_grid_height(obj_control.lineGrid) - 1;
var randUnit = -1;
var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
for (var stackLoop = 0; stackLoop < 4; stackLoop++) {
//while (randLine2 <= endLine && randLine1 < endLine){ 
	for(var randUnitLoop = randLine1; randUnitLoop < randLine2; randUnitLoop++){
		randUnit = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, randUnitLoop-1);
		ds_list_add(currentUnitList, randUnit);
	}
	//show_message(scr_getStringOfList(currentUnitList));
	var firstUnitID = ds_list_find_value(currentUnitList, 0);
	var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, firstUnitID - 1);
	var firstWordID = ds_list_find_value(currentWordIDList, 0);
	
	// Loop through words found in rectangle at time of mouse release
	var inRectUnitIDListSize = ds_list_size(currentUnitList);
	for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
		var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
		currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
		var currentWordID = ds_list_find_value(currentWordIDList, 0);
		obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
		with (obj_chain) {
			scr_wordClicked(firstWordID, firstUnitID);
			scr_wordClicked(currentWordID, currentUnitID);
		}
	}
	// Unfocus all links and chains
	scr_unFocusAllChains();
	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

	ds_list_clear(currentUnitList);
	randLine1 = randLine2 + 1;
	randLine2 = randLine1 + floor(random(7)) + 1;
	//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
}
splitSave = false;
randLine1 = 1;
randLine2 = randLine1 + floor(random(7)) + 1;