// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_audioStackUpdate(currentStackRow){
	selectedStackGridRow = currentStackRow;
	bookmarkStartTime = -1;
	bookmarkEndTime = -1;
	selectedStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, currentStackRow);
	stackUnitList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, currentStackRow);
	stackUnitListSize = ds_list_size(stackUnitList);
	for(var unitTimeLoop = 0; unitTimeLoop < stackUnitListSize; unitTimeLoop++) {
		var currentUnit = ds_list_find_value(stackUnitList, unitTimeLoop);
		var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
		var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
		if(bookmarkStartTime == -1 or currentUnitStart < bookmarkStartTime) {
			bookmarkStartTime = currentUnitStart;
			stackStartUnit = currentUnit;
		}
		if(bookmarkEndTime == -1 or currentUnitEnd > bookmarkEndTime) {
			bookmarkEndTime = currentUnitEnd;
			stackEndUnit = currentUnit;
		}
	}
	stackUnitListPosition = 0;
}