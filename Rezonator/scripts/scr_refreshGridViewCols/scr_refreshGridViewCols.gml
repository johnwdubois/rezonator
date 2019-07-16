ds_map_clear(gridViewColXListMap);
for (var i = 0; i < ds_list_size(gridList); i++) {
	
	var currentGridViewColXList = ds_list_create();
	var currentGrid = ds_list_find_value(gridList, i);
	var defaultGridColWidth = windowWidth / ds_grid_width(currentGrid);
	
	var currentColX = windowX;
	for (var j = 0; j < ds_grid_width(currentGrid); j++) {
		ds_list_add(currentGridViewColXList, currentColX + scrollBarWidth);
		currentColX += defaultGridColWidth;
	}
	
	ds_map_add_list(gridViewColXListMap, currentGrid, currentGridViewColXList);
}