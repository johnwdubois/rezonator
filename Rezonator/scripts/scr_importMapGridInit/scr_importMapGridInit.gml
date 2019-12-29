
global.importMapGridWidth = 4;
global.importMapGrid_colRezData = 0;
global.importMapGrid_colSourceData = 1;
global.importMapGrid_colImportGridCol = 2;
global.importMapGrid_colRequired = 3;

global.importMapRezDataList = ds_list_create();
ds_list_add(global.importMapRezDataList, "ParticipantName");
ds_list_add(global.importMapRezDataList, "Morph");

global.importMapGrid = ds_grid_create(global.importMapGridWidth, ds_grid_width(global.importToolboxGrid));

for (var i = 0; i < ds_grid_height(global.importMapGrid); i++) {
	
	var currentRezData = 0;
	if (i < ds_list_size(global.importMapRezDataList)) {
		currentRezData = ds_list_find_value(global.importMapRezDataList, i);
	}
	var currentSourceData = global.importToolboxGridColName[i];
	var required = (i < 2) ? true : false;
	
	ds_grid_set(global.importMapGrid, global.importMapGrid_colRezData, i, currentRezData);
	ds_grid_set(global.importMapGrid, global.importMapGrid_colSourceData, i, currentSourceData);
	ds_grid_set(global.importMapGrid, global.importMapGrid_colImportGridCol, i, -1);
	ds_grid_set(global.importMapGrid, global.importMapGrid_colRequired, i, required);
}

