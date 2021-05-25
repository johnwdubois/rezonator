scr_scrollBarInit();


// make list of line strings that have been marked as exceptions
exceptionStringList = ds_list_create();
var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
for (var i = 0; i < importTXTLineGridHeight; i++) {
	if (ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i)) {
		ds_list_add(exceptionStringList, string(ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i)));
	}
}

camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());


	
// File window
fileInfoWindowRectX1 = 40;
fileInfoWindowRectY1 = 80 + string_height("0");
fileInfoWindowRectX2 = (camWidth * 0.5) - 20;
fileInfoWindowRectY2 = (camHeight / 2) - 180;

tabList = ds_list_create();
ds_list_add(tabList, "menu_file", "menu_summary", "label_exceptions");
selectedTab = 0;


// make list of line strings that have been marked as exceptions
exceptionStringList = ds_list_create();
var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
for (var i = 0; i < importTXTLineGridHeight; i++) {
	if (ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i)) {
		ds_list_add(exceptionStringList, string(ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i)));
	}
}