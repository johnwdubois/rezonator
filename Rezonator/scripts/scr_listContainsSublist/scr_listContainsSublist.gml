/*
	scr_listContainsSublist();
	
	Last Updated: 2019-06-19
	
	Called from: obj_control
	
	Purpose: return location of sublist within list. If sublist isn't present, return -1
	
	Mechanism: find sublist's first element in list, then check each subsequent element in the 
			sublist against what follows the element in the list. 
				
	Author: Georgio Klironomos
*/

// Collect lists placed as parameters
var mainList = argument0;
var subList = argument1;

// Find the subList's first element within the list
var firstElement = ds_list_find_value(subList, 0);
var subListIndex = ds_list_find_index(mainList, firstElement);
if(subListIndex == -1) {return -1};

// Loop through mainList to incrementily check each element against the subList
for(var listLoop = 1; 1 < ds_list_size(subList); listLoop++) {
	var currentSubElement = ds_list_find_value(subList, listLoop);
	var currentMainElement = ds_list_find_value(mainList, listLoop + subListIndex);
	if(currentSubElement != currentMainElement) {
		return -1;
	}
}

return subListIndex;