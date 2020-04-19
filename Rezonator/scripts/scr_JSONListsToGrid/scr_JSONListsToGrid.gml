// Convert JSON strings to grid data in lists

var tempGrid = argument0;
var gridLists = argument1;
var map = argument2;
var gridName = argument3;

//show_message("gridName: " + gridName);




// find the colList from the REZ file for this grid, and check if that colList matches the current version's colList
var needToReorderColList = false;
var oldColList = -1;
var updatedColList = -1;
if (string_count("wordGrid", gridName) > 0) {
	oldColList = ds_map_find_value(map, "wordGridColList");
	if (oldColList != undefined) {
		if (ds_exists(oldColList, ds_type_list)) {
//			show_message("oldColList: " + scr_getStringOfList(oldColList));
			
			updatedColList = scr_getListOfGridCols(obj_control.wordGrid);
//			show_message("...real wordGrid oldColList: " + scr_getStringOfList(updatedColList));
//			show_message("...do these match? ..." + string(scr_compareLists(updatedColList, oldColList)));
			
			if (not scr_compareLists(updatedColList, oldColList)) {
				needToReorderColList = true;
			}
			
		}
	}
}


var newGridLists = ds_list_create();
if (needToReorderColList and ds_exists(updatedColList, ds_type_list) and ds_exists(oldColList, ds_type_list)) {
	
//	show_message("needToReorderColList!!");
	var updatedColListSize = ds_list_size(updatedColList);
	for (var i = 0; i < updatedColListSize; i++) {
		var currentColString = ds_list_find_value(updatedColList, i);
		//show_message("in forloop... " + currentColString);
		
		var indexOfColInOldColList = ds_list_find_index(oldColList, currentColString);
		if (indexOfColInOldColList > -1 and indexOfColInOldColList < ds_list_size(oldColList)) {
			var newGridListsCurrentList = ds_list_find_value(gridLists, indexOfColInOldColList);
//			show_message("FOUND: " + string(currentColString) + "..." + string(newGridListsCurrentList));
		}
		else {
//			show_message("DID NOT FIND: " + string(currentColString));
			var newGridListsCurrentList = ds_list_create();
		}
		
		//show_message("adding..." + scr_getStringOfList(newGridListsCurrentList));
		ds_list_add(newGridLists, newGridListsCurrentList);
	}
}





// if the newGridList has any lists, then it is the one to copy from
var currentGridLists = gridLists;
if (ds_list_size(newGridLists) > 0) {
	currentGridLists = newGridLists;
}


// fill the tempGrid with all the info from the gridLists
var currentGridListsSize = ds_list_size(currentGridLists);
for (var i = 0; i < currentGridListsSize; i++) {	
	var rowList = ds_list_find_value(currentGridLists, i);
	var rowListSize = ds_list_size(rowList);
	for (var j = 1; j < rowListSize; j++) {
		var currentCellValue = ds_list_find_value(rowList, j);
		
		ds_grid_set(tempGrid, i, j - 1, currentCellValue);
	}
}



ds_list_destroy(newGridLists);