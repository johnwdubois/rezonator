pickwhippedRow = -1;

showDevVars = false;


pickwhipColorNormal = c_blue;
pickwhipColorRequired = c_red;

continueButtonActive = false;







rezInfoGridSelectedRow = -1;
tagInfoGridSelectedRow = -1;






tagInfoGridWidth = 3;
tagInfoGrid_colTag = 0;
tagInfoGrid_colExample = 1;
tagInfoGrid_colMapped = 2;

tagInfoGrid = ds_grid_create(tagInfoGridWidth, 0);

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
	
	ds_grid_resize(tagInfoGrid, tagInfoGridWidth, ds_grid_height(tagInfoGrid) + 1);
	ds_grid_set(tagInfoGrid, tagInfoGrid_colTag, i, currentTag);
	ds_grid_set(tagInfoGrid, tagInfoGrid_colExample, i, currentExample);
	ds_grid_set(tagInfoGrid, tagInfoGrid_colMapped, i, false);
}