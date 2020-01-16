var colorIndex = 0;

math_set_epsilon(0.000001);

if(global.plainText){

show_message("buh");
}
else{
	
	for (var i = 0; i < ds_grid_width(global.importToolboxGrid); i++) {
	
		var currentTag = global.importToolboxGridColName[i];
		var currentExample = "";
	
		var toolboxGridRow = 0;
		while (string(ds_grid_get(global.importToolboxGrid, i, toolboxGridRow)) == "0" and toolboxGridRow < ds_grid_height(global.importToolboxGrid)) {
			toolboxGridRow++;
		}
		toolboxGridRow = clamp(toolboxGridRow, 0, ds_grid_height(global.importToolboxGrid) - 1);
		if (string(ds_grid_get(global.importToolboxGrid, i, toolboxGridRow)) != "0") {
			currentExample = ds_grid_get(global.importToolboxGrid, i, toolboxGridRow);
		}
		else {
			show_message(string(ds_grid_get(global.importToolboxGrid, i, toolboxGridRow)))
		}
	
		colorIndex++;
		if (colorIndex >= ds_list_size(obj_importMapping.tagColorList)) {
			colorIndex = 0;
		}
		var currentColor = merge_color(ds_list_find_value(obj_importMapping.tagColorList, colorIndex), c_white, 0.6);
	
		var nonzeroCellCount = 0;
		for (var j = 0; j < ds_grid_height(global.importToolboxGrid); j++) {
			nonzeroCellCount += (ds_grid_get(global.importToolboxGrid, i, j) == "0") ? 0 : 1
		}
		var currentConsistency = (nonzeroCellCount / ds_grid_height(global.importToolboxGrid)) * 100;
	
	
	
	
		var constPerCluster = true;
		var tokenCount = -1;
		for (var j = 0; j < ds_grid_height(global.importToolboxGrid); j++) {
			if (ds_grid_get(global.importToolboxGrid, i, j) != "0") {
				var currentList = scr_splitStringToolbox(ds_grid_get(global.importToolboxGrid, i, j));
				if (tokenCount < 0) {
					tokenCount = ds_list_size(currentList);
				}
				else {
					if (tokenCount != ds_list_size(currentList)) {
						constPerCluster = false;
					}
				}
				ds_list_destroy(currentList);
			}
		}
	
		ds_grid_resize(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGridWidth, ds_grid_height(obj_importMapping.tagInfoGrid) + 1);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colTag, i, currentTag);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colExample, i, currentExample);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colMapped, i, false);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colColor, i, currentColor);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colConsistency, i, currentConsistency);
		ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colConstPerCluster, i, constPerCluster);
	}
}