/*
	scr_prevWordInSequence();
	
	Last Updated: 2019-07-05
	
	Called from: obj_chain
	
	Purpose: return the previous word within the word sequence
	
	Mechanism: Step backwards through the current unit's wordIDList. If the current word is first in that list, 
	loop through previous units to get the end of their wordIDList.
				
	Author: Georgio Klironomos
*/


var currentWordID = argument0;
var currentUnitID = argument1;
var previousWordID = undefined;
var lineWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
var currentWordIDIndex = ds_list_find_index(lineWordIDList, currentWordID);
if(currentWordIDIndex != 0) {
	previousWordID = ds_list_find_value(lineWordIDList, currentWordIDIndex - 1);
	return previousWordID;
}
else {
	var loopUnitID = currentUnitID - 1;
	while(previousWordID == undefined) {
		var loopLineWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, loopUnitID - 1);	
		if(ds_list_size(loopLineWordIDList) > 0) {
			previousWordID = ds_list_find_value(loopLineWordIDList, ds_list_size(loopLineWordIDList) - 1);
			return previousWordID;
		}
		else {
			loopUnitID--;	
		}
	}
}