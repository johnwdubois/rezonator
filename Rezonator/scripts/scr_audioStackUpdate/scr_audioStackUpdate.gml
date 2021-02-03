/*
	scr_audioStackUpdate();
	
	Last Updated: 2020-10-26
	
	Called from: obj_audioUI
	
	Purpose: Update the Audio Bookmarks based on the first and last units of the currently highlighted Stack
	
	Mechanism: loop through unitGrid looking at every UnitStart and UnitEnd, and setting the bookmark to the earlist start time and set the endmark to the latest end time.
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_audioStackUpdate(currentStackChain){
	
	selectedStackChain = currentStackChain;
	bookmarkStartTime = -1;
	bookmarkEndTime = -1;
	
	// Get UnitID list info

	stackUnitList = scr_getChainTempList(selectedStackChain, false);
	stackUnitListSize = ds_list_size(stackUnitList);
	
	//Loop through UnitIDList and gather time stamps
	for(var unitTimeLoop = 0; unitTimeLoop < stackUnitListSize; unitTimeLoop++) {
		var currentUnit = ds_list_find_value(stackUnitList, unitTimeLoop);
		var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
		var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
		
		// Set earliest time and Bookmark Start Time
		if(bookmarkStartTime == -1 or currentUnitStart < bookmarkStartTime) {
			bookmarkStartTime = currentUnitStart;
			stackStartUnit = currentUnit;
		}
		
		// Set latest time and Bookmark End Time
		if(bookmarkEndTime == -1 or currentUnitEnd > bookmarkEndTime) {
			bookmarkEndTime = currentUnitEnd;
			stackEndUnit = currentUnit;
		}
	}
	
	// Set playhead to beginning of the Stack
	stackUnitListPosition = 0;
}