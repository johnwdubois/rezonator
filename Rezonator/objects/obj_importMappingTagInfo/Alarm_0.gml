/// @description verify we have a display token set
// You can write your code in this editor
	
// if we have not set either DisplayToken or Speaker yet, we will try to...
// after we have sorted, we will set displayToken to be the first token level marker
// and set Speaker to be the first unit level marker
var setDisplayToken = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
var setSpeaker = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Speaker");
var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

for (var i = 0; i < tagInfoGridHeight; i++) {
	var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
	var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
	// if this field is Token level and we have not yet set Display Token, let's set this field to Display Token
	if (!setDisplayToken && currentLevel == global.levelToken) {
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "Display Token");
		obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		setDisplayToken = true;
	}
	/*
	// if this field is Unit level and we have not yet set Speaker, and this is not a ~field, let's set this field to Speaker
	if (!setSpeaker && currentLevel == global.levelUnit && string_char_at(currentField, 1) != "~") {
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "Speaker");
		setSpeaker = true;
	}
	*/
	
}


//calculate current tokenThreshold
var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
if(currentMarkerCount != undefined){
	obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
}
	
	
with (obj_importMapping) {
	alarm[4] = 2;
	updatedErrorCol = true;
}

if (global.importType == global.importType_IGT) {
	
	for (var i = 0; i < tagInfoGridHeight; i++) {
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var currentSpecialField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
	
		if(currentLevel == global.levelToken){
			if(currentSpecialField != "Display Token") {
				//calculate current tokenThreshold
				var indexForSpecialFieldHelper = ds_list_find_index(global.importGridColNameList, currentField)-2;
				var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForSpecialFieldHelper);
				if(currentMarkerCount != undefined) {
					if((currentMarkerCount * obj_importMapping.tokenRatio)< obj_importMapping.currentTokenThreshold) {
						ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelPredict, i,global.levelUnit);
						ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i,global.levelUnit);
					}
				}
			}
		}
	}
}