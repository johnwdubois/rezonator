// Begin the import process of a single user specified CSV file

var filename = argument0;

//load csv into grid
global.importCSVGrid = scr_CSVtoGrid(filename);

//copy headers into list
var importCSVGridWidth = ds_grid_width(global.importCSVGrid);
for(var i = 0; i < importCSVGridWidth; i++){
	var colHeader = ds_grid_get(global.importCSVGrid, i, 0);
	ds_list_add(global.importGridColNameList, colHeader);
	ds_map_add(global.importGridColMap, colHeader, i);
	
}




//delete row of column headers
scr_gridDeleteRow(global.importCSVGrid, 0);


var importCSVGridHeight = ds_grid_height(global.importCSVGrid);

//prepare import grid for copy
ds_grid_resize(global.importGrid, importCSVGridWidth, importCSVGridHeight);

//copy over to import grid
ds_grid_copy(global.importGrid,global.importCSVGrid);

global.importGridWidth = ds_grid_width(global.importGrid);
global.importCSVGridWidth = ds_grid_width(global.importCSVGrid);

//allows user to not need unit level data (not neccessary)
global.importType = global.importType_CSV;

global.tabDeliniatedText = true;

room_goto(rm_importScreen);


/*
var unitCounter = 0;
var previousUID = -1;

for (var i = 0; i < importCSVGridHeight; i++) {
	
	var currentUID = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, i));
	if (previousUID != currentUID) {
		previousUID = currentUID;
		unitCounter++;
	}
}
global.importCSVUnitGridHeight = unitCounter;
global.totalUnitAmount = unitCounter;
*/
