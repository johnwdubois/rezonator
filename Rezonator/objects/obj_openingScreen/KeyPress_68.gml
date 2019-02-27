for (var i = 0; i < ds_grid_height(global.fileLineRipGrid); i++) {
	var currentList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colParticipantList, i);
	
	var listStr = "";
	for (var j = 0; j < ds_list_size(currentList); j++) {
		listStr += string(ds_list_find_value(currentList, j)) + ",";
	}
	show_message(listStr);
}