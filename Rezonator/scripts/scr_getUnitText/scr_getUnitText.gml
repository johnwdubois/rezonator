// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getUnitText(unitID){
	
	// get unitText
	var unitText = "";
	var wordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);
	var wordIDListSize = ds_list_size(wordIDList);
	for (var i = 0; i < wordIDListSize; i++) {
		var unitTextWordID = ds_list_find_value(wordIDList, i);
		var unitTextWordDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, unitTextWordID - 1);
				
		// determine if this word is a chunk (in which case it should not be included in UnitText)
		var unitTextWordIDIsChunk = false;
		var unitTextWordInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, unitTextWordID - 1);
		var unitTextWordInBoxListSize = ds_list_size(unitTextWordInBoxList);
		if (unitTextWordInBoxListSize > 0) {
			var rowInChunkGrid = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), unitTextWordID);
			if (rowInChunkGrid >= 0) unitTextWordIDIsChunk = true;
		}
				
		// concatenate the UnitText string if this is not a chunk
		if (!unitTextWordIDIsChunk) {
			if (is_string(unitTextWordDisplayStr)) unitText += unitTextWordDisplayStr;
			if (i < wordIDListSize - 1) unitText += " ";
		}
	}
	
	return unitText;
}