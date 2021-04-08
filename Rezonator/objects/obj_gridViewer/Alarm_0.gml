///@description GridList
ds_list_add(gridList,
	obj_chain.unitInStackGrid,
	obj_chain.goldStandardGrid,
	global.importGrid,
	obj_control.morphGrid,
	global.importCSVGrid,
	global.tokenImportGrid,
	global.wordImportGrid,
	global.unitImportGrid,
	global.discoImportGrid,
	global.customLabelGrid
	);


var gridListSize = ds_list_size(gridList);
for (var i = 0; i < gridListSize; i++) {
	
	var currentGridViewColXList = ds_list_create();
	var currentGrid = ds_list_find_value(gridList, i);
	var defaultGridColWidth = windowWidth / ds_grid_width(currentGrid);
	
	var currentColX = windowX;
	var currentGridWidth = ds_grid_width(currentGrid);
	for (var j = 0; j < currentGridWidth; j++) {
		ds_list_add(currentGridViewColXList, currentColX);
		currentColX += defaultGridColWidth;
	}
	
	var currentGridName = scr_getGridNameString(currentGrid);
	ds_map_add_list(gridViewColXListMap, currentGridName, currentGridViewColXList);
}