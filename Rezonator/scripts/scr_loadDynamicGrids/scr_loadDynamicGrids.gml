var originalGrid = argument [0];
var tempGrid = argument [1];


if (originalGrid == global.importGrid) {
	ds_grid_resize(tempGrid, ds_grid_width(originalGrid), 0);
}
else if (global.importGridWidth >= 0){
	if(global.importGridWidth == undefined){
		global.importGridWidth = 0;
	}
	//show_message("global.importGridWidth: " + string(global.importGridWidth));
	ds_grid_resize(tempGrid, global.importGridWidth, 0);
}



if (originalGrid != global.importGrid) {
	ds_grid_resize(tempGrid, ds_grid_width(originalGrid), 0);
}
else if (global.importGridWidth >= 0){
	if(global.importGridWidth == undefined){
		global.importGridWidth = 0;
	}
	//show_message("global.importGridWidth: " + string(global.importGridWidth));
	ds_grid_resize(tempGrid, global.importGridWidth, 0);
}




return tempGrid;