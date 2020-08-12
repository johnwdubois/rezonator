clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
windowWidth = 100;
windowHeight = 100;

// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
global.scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;




// make list of line strings that have been marked as exceptions
exceptionStringList = ds_list_create();
var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
for (var i = 0; i < importTXTLineGridHeight; i++) {
	if (ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i)) {
		ds_list_add(exceptionStringList, string(ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i)));
	}
}