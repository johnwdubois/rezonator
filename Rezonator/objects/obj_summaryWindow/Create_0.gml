scr_scrollBarInit();


// make list of line strings that have been marked as exceptions
exceptionStringList = ds_list_create();
var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
for (var i = 0; i < importTXTLineGridHeight; i++) {
	if (ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i)) {
		ds_list_add(exceptionStringList, string(ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i)));
	}
}