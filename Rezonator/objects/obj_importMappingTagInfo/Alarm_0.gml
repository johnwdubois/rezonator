/// @description verify we have a display token set
// You can write your code in this editor
	
// if we have not set either DisplayToken or Speaker yet, we will try to...
// after we have sorted, we will set displayToken to be the first token level marker
// and set Speaker to be the first unit level marker
var setDisplayToken = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_display-token");
var setSpeaker = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "participant");
var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

for (var i = 0; i < tagInfoGridHeight; i++) {
	var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
	var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
	// if this field is Token level and we have not yet set Display Token, let's set this field to Display Token
	if (!setDisplayToken && currentLevel == global.levelToken) {
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colKey, i, "option_display-token");
		obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		setDisplayToken = true;
	}
	
}


//calculate current tokenThreshold
var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker) - 2;
var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
if (currentMarkerCount != undefined) {
	obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
}
	
	
with (obj_importMapping) {
	alarm[4] = 2;
	updatedErrorCol = true;
}

if (global.importType == "import_type_interlinear") {
	
	for (var i = 0; i < tagInfoGridHeight; i++) {
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var currentKey = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colKey, i);
	
		if (currentLevel == global.levelToken && currentKey != "option_display-token") {
			
			//calculate current tokenThreshold
			var indexForSpecialFieldHelper = ds_list_find_index(global.importGridColNameList, currentField) - 2;
			var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid, indexForHelper, indexForSpecialFieldHelper);
			if (currentMarkerCount != undefined) {
				if ((currentMarkerCount * obj_importMapping.tokenRatio) < obj_importMapping.currentTokenThreshold) {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelPredict, i,global.levelUnit);
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i,global.levelUnit);
				}
			}
		}
	}
}