/*
	scr_listContainsSublist();
	
	Last Updated: 2020-10-28
	
	Called from: obj_control
	
	Purpose: return location of sublist within list. If sublist isn't present, return -1
	
	Mechanism: find sublist's first element in list, then check each subsequent element in the 
			sublist against what follows the element in the list. 
				
	Author: Georgio Klironomos
*/

function scr_listContainsSublist() {

	// Collect lists placed as parameters
	var mainList = ds_list_create();
	ds_list_copy(mainList, argument[0]);
	var subList = ds_list_create();
	ds_list_copy(subList, argument[1]);


	// Find the subList's first element within the list
	var firstElement = ds_list_find_value(subList, 0);
	var subListIndex = ds_list_find_index(mainList, firstElement);

	if(subListIndex == -1) {return -1};

	// Loop through mainList to incrementily check each element against the subList
	var subListSize = ds_list_size(subList);
	for(var listLoop = 1; listLoop < subListSize; listLoop++) {
		var currentSubElement = ds_list_find_value(subList, listLoop);
		var currentMainElement = ds_list_find_value(mainList, listLoop + subListIndex);
		
		// If we've found a difference in the lists, exit
		if(currentSubElement != currentMainElement) {
			return -1;
		}
	}
	
	// Return the position of the sublist within the Mainlist
	return subListIndex;
}
