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

var rezInfoGridHeight = ds_grid_height(global.rezInfoGrid);
for (var j = 0; j < rezInfoGridHeight; j++) {
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colNumber, j, j + 1);
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colLevel, j, ds_list_find_value(levelList, j));
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colTier, j, ds_list_find_value(tierList, j));
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, j, -1);
	ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, j, -1);
} 


// initiate tokenImport
global.tokenImportGridWidth = 4;
global.tokenImport_colUnitID = 0;
global.tokenImport_colWordID = 1;
global.tokenImport_colWordToken = 2;
global.tokenImport_colWordTranscript = 3;
global.tokenImportGrid = ds_grid_create(global.tokenImportGridWidth, 0);

// initiate unitImport
global.unitImportGridWidth = 2;
global.unitImport_colUnitID = 0;
global.unitImport_colParticipant = 1;
global.unitImportGrid = ds_grid_create(global.unitImportGridWidth, 0);

// special fields for unitImport
global.unitImport_colUnitStart = -1;
global.unitImport_colUnitEnd = -1;



// initiate customLabelGrid
global.customLabelGridWidth = 3;
global.customLabelGrid_colLevel = 0;
global.customLabelGrid_colMarker = 1;
global.customLabelGrid_colTagList = 2;
global.customLabelGrid = ds_grid_create(global.customLabelGridWidth, 0);

// initiate global variables for levels (needed for loading rez)
global.levelToken = 0;
global.levelUnit = 1;
global.levelDiscourse = 2;
global.levelUnknown = 3;

