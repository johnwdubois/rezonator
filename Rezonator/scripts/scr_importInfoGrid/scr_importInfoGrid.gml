var colorIndex = 0;

math_set_epsilon(0.000001);
var importGridWidth = ds_grid_width(global.importGrid);
var importGridHeight = ds_grid_height(global.importGrid);

if (global.plainText) {
	
	for (var i = 0; i < importGridWidth; i++) {
	
		//put toolbox grid stuff into plain Info Grid
	
		var currentExample = "";
		
		for(var j = 0; j < importGridHeight; j++){
			

			currentExample = ds_grid_get(global.importGrid, i, j);
			
	
	
			if(i==0){
				ds_grid_resize(global.plainTextInfoGrid, global.plainTextInfoGridWidth, ds_grid_height(global.plainTextInfoGrid) + 1);
				ds_grid_set(global.plainTextInfoGrid, global.plainTextInfoGrid_colText, j, currentExample);
			}
			else{
				ds_grid_set(global.plainTextInfoGrid, global.plainTextInfoGrid_colGroup, j, currentExample);
			}
		}

	}
}
else {
	
	for (var i = 0; i < importGridWidth; i++) {
	
		var currentTag = ds_list_find_value(global.importGridColNameList, i);
		var currentExample = "";
	
		var importGridRow = 0;
		while (string(ds_grid_get(global.importGrid, i, importGridRow)) == "0" and importGridRow < ds_grid_height(global.importGrid)) {
			importGridRow++;
		}
		importGridRow = clamp(importGridRow, 0, ds_grid_height(global.importGrid) - 1);
		if (string(ds_grid_get(global.importGrid, i, importGridRow)) != "0") {
			currentExample = ds_grid_get(global.importGrid, i, importGridRow);
		}
		else {
			show_message(string(ds_grid_get(global.importGrid, i, importGridRow)))
		}
	
		colorIndex++;
		if (colorIndex >= ds_list_size(obj_importMapping.tagColorList)) {
			colorIndex = 0;
		}
		var currentColor = merge_color(ds_list_find_value(obj_importMapping.tagColorList, colorIndex), c_white, 0.6);
	
		var nonzeroCellCount = 0;
		for (var j = 0; j < importGridHeight; j++) {
			nonzeroCellCount += (ds_grid_get(global.importGrid, i, j) == "0") ? 0 : 1
		}
		var currentConsistency = (nonzeroCellCount / ds_grid_height(global.importGrid)) * 100;
	
	
	
	
		var OneTokenPerGroup = true;
		var tokenCount = -1;
		for (var j = 0; j < importGridHeight; j++) {
			if (ds_grid_get(global.importGrid, i, j) != "0") {
				var currentList = scr_splitStringImport(ds_grid_get(global.importGrid, i, j));
				if (tokenCount < 0) {
					tokenCount = ds_list_size(currentList);
				}
				else {
					if (tokenCount != ds_list_size(currentList)) {
						OneTokenPerGroup = false;
					}
				}
				ds_list_destroy(currentList);
			}
		}
	
		ds_grid_resize(global.tagInfoGrid, global.tagInfoGridWidth, ds_grid_height(global.tagInfoGrid) + 1);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colMarker, i, currentTag);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colExample, i, currentExample);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colMarkerPercent, i, currentConsistency);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSingleTokenMarker, i, OneTokenPerGroup);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, i, false);
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, i, false);
		
		
		// if this label is < 5% consistency and 1 token per group, it is probably discourse level
		// if this label is >= 90% consistency and 1 token per group, it is probably unit level
		// if this label is >= 90% consistency and has inconsistent amount of tokens, it is probably token level
		var levelEstimate = -1;
		if (currentConsistency < 5 && OneTokenPerGroup) {
			levelEstimate = obj_importMapping.levelDiscourse; // discourse level estimate
		}
		else if (currentConsistency >= 90 && OneTokenPerGroup) {
			levelEstimate = obj_importMapping.levelUnit; // unit level estimate
		}
		else if (currentConsistency >= 90 && !OneTokenPerGroup) {
			levelEstimate = obj_importMapping.levelToken; // token level estimate
		}
		else {
			levelEstimate = obj_importMapping.levelUnknown;
		}
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i, levelEstimate);
	}
	
	ds_grid_sort(global.tagInfoGrid, global.tagInfoGrid_colLevel, true);
	
	// after we have sorted, we will set displayToken to be the first token level marker
	// and set displayUnit to be the first unit level marker
	var setDisplayToken = false;
	var setDisplayUnit = false;
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		
		// we have found the first token level marker, let's set it to displayToken
		if (!setDisplayToken) {
			if (currentLevel == obj_importMapping.levelToken) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, i, true);
				setDisplayToken = true;
			}
		}
		// we have found the first unit level marker, let's set it to displayUnit
		if (!setDisplayUnit) {
			if (currentLevel == obj_importMapping.levelUnit) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, i, true);
				setDisplayUnit = true;
			}
		}
	}
}