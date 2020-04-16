///@description ParticipantList
var fileLineRipGridHeight = ds_grid_height(global.fileLineRipGrid);
for (var i = 0; i < fileLineRipGridHeight; i++) {
	var currentList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colParticipantList, i);
	
	var listStr = "";
	var currentListSize = ds_list_size(currentList);
	for (var j = 0; j < currentListSize; j++) {
		listStr += string(ds_list_find_value(currentList, j)) + ",";
	}
	show_message(listStr);
}



