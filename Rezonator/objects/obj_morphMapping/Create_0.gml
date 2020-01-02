scr_importMapGridInit();

pickwhippedRow = -1;

showDevVars = false;


pickwhipColorNormal = c_blue;
pickwhipColorRequired = c_red;




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
