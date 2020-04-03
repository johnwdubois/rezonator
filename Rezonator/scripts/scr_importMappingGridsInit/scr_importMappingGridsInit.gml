// initiate rezInfoGrid
var levelList = ds_list_create();
ds_list_add(levelList, "unit", "unit", "unit", "token", "token", "unit");
var tierList = ds_list_create();
ds_list_add(tierList, "~UnitStartTime", "~UnitEndTime", "~Participant");
ds_list_add(tierList, "morph", "gloss", "translation");

global.rezInfoGridWidth = 5;
global.rezInfoGrid_colNumber = 0;
global.rezInfoGrid_colLevel = 1;
global.rezInfoGrid_colTier = 2;
global.rezInfoGrid_colAssignedTag = 3;
global.rezInfoGrid_colAssignedCol = 4;
global.rezInfoGrid = ds_grid_create(global.rezInfoGridWidth, ds_list_size(levelList));
	
for (var j = 0; j < ds_grid_height(global.rezInfoGrid); j++) {
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colNumber, j, j + 1);
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colLevel, j, ds_list_find_value(levelList, j));
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colTier, j, ds_list_find_value(tierList, j));
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, j, -1);
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, j, -1);
} 


// initiate labelWordGrid
global.labelWordGridWidth = 2;
global.labelWordGrid_colUnitID = 0;
global.labelWordGrid_colWordID = 1;
global.labelWordGrid = ds_grid_create(global.labelWordGridWidth, 0);


// initiate customLabelGrid
global.customLabelGridWidth = 3;
global.customLabelGrid_colLevel = 0;
global.customLabelGrid_colLabel = 1;
global.customLabelGrid_colTagList = 2;
global.customLabelGrid = ds_grid_create(global.customLabelGridWidth, 0);