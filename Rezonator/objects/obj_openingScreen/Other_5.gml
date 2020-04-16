// Encode colors of speaker labels
var fileLineRipGridHeight = ds_grid_height(global.fileLineRipGrid);
for (var i = 0; i < fileLineRipGridHeight; i++) {
	var participantColorList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colColorList, i);
	
	for (var j = 0; j < ds_list_size(participantColorList); j++) {
		var color = ds_list_find_value(participantColorList, j);
		ds_list_add(global.participantColorList, color);
	}
}
