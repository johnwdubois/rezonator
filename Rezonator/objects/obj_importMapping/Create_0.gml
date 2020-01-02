scr_importMapGridInit();

pickwhippedRow = -1;

showDevVars = false;


pickwhipColorNormal = c_blue;
pickwhipColorRequired = c_red;

continueButtonActive = false;



// initiate rezInfoGrid
var levelList = ds_list_create();
ds_list_add(levelList, "unit", "unit", "unit", "unit", "word", "word");
ds_list_add(levelList, "morph", "morph", "unit");
var tierList = ds_list_create();
ds_list_add(tierList, "_UnitID", "_UnitStartTime", "_UnitEndTime", "_Participant", "text", "word");
ds_list_add(tierList, "morph", "gloss", "translation");

rezInfoGridWidth = 4;
rezInfoGrid_colNumber = 0;
rezInfoGrid_colLevel = 1;
rezInfoGrid_colTier = 2;
rezInfoGrid_colAssignedTag = 3;
rezInfoGrid = ds_grid_create(rezInfoGridWidth, ds_list_size(levelList));
	
for (var j = 0; j < ds_grid_height(rezInfoGrid); j++) {
	ds_grid_set(rezInfoGrid, rezInfoGrid_colNumber, j, j + 1);
	ds_grid_set(rezInfoGrid, rezInfoGrid_colLevel, j, ds_list_find_value(levelList, j));
	ds_grid_set(rezInfoGrid, rezInfoGrid_colTier, j, ds_list_find_value(tierList, j));
}

rezInfoGridSelectedRow = -1;
tagInfoGridSelectedRow = -1;






tagInfoGridWidth = 3;
tagInfoGrid_colTag = 0;
tagInfoGrid_colExample = 1;
tagInfoGrid_colMapped = 2;

tagInfoGrid = ds_grid_create(tagInfoGridWidth, 0);

for (var i = 0; i < ds_grid_width(global.importToolboxGrid); i++) {
	
	var currentTag = global.importToolboxGridColName[i];
	var currentExample = "buh";
	
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