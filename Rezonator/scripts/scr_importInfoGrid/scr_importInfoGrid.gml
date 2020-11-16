function scr_importInfoGrid() {
	math_set_epsilon(0.000001);
	var importGridWidth = ds_grid_width(global.importGrid);
	var importGridHeight = ds_grid_height(global.importGrid);

	show_debug_message("scr_importInfoGrid, STARTING... " + scr_printTime());

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
	else if (global.importType == global.importType_CSV) {
	
		// fill in CSV tagInfoGrid with basically empty rows
		for (var i = 0; i < importGridWidth; i++) {
	
			var currentTag = ds_list_find_value(global.importGridColNameList, i);
			ds_grid_resize(global.tagInfoGrid, global.tagInfoGridWidth, ds_grid_height(global.tagInfoGrid) + 1);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colMarker, i, currentTag);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colExample, i, "");
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colMarkerPercent, i, 100);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSingleTokenMarker, i, false);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "");
		
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
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "");
			var currentTokenCount = ds_list_find_value(global.importGridTokenCountList, i);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colTokenCount, i, currentTokenCount);
			

			if (global.importType == global.importType_CoNLLU) {
				var levelEstimate = -1;
				if (string_char_at(currentTag, 1) == "#") {
					levelEstimate = global.levelUnit;
				}
				else {
					levelEstimate = global.levelToken;
				}
			}
			else {
				show_debug_message("scr_importInfoGrid() Setting field estimates...");
				// if this label is < 5% consistency and 1 token per group, it is probably discourse level
				// if this label is >= 90% consistency and 1 token per group, it is probably unit level
				// if this label is >= 90% consistency and has inconsistent amount of tokens, it is probably token level
				var levelEstimate = -1;
				if (currentConsistency < 5 && OneTokenPerGroup) {
					levelEstimate = global.levelDiscourse; // discourse level estimate
				}
				else if (currentConsistency >= 90 && OneTokenPerGroup) {
					if (currentTag == "~blockSeq" || currentTag == "~blockSeq") {
						levelEstimate = global.levelUnknown;
					}
					else {
						levelEstimate = global.levelUnit; // unit level estimate
					}
				}
				else if (currentConsistency >= 90 && !OneTokenPerGroup) {
					levelEstimate = global.levelToken; // token level estimate
				}
				else {
					levelEstimate = global.levelUnknown;
				}
			}
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i, levelEstimate);
		}
	
		ds_grid_sort(global.tagInfoGrid, global.tagInfoGrid_colLevel, true);
		
		scr_gridMultiColSort(global.tagInfoGrid, global.tagInfoGrid_colLevel, true, global.tagInfoGrid_colTokenCount, false);
	}
	
	// auto-load Schema
	scr_loadRZS(true);
	
	// check if there are any Token level fields
	var anyTokenFields = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colLevel, 0, global.tagInfoGrid_colLevel, ds_grid_height(global.tagInfoGrid), "token");
	var anyWordFields = ds_grid_value_exists(global.tagInfoGrid, global.tagInfoGrid_colLevel, 0, global.tagInfoGrid_colLevel, ds_grid_height(global.tagInfoGrid), "word");
	show_debug_message("scr_importInfoGrid() ... anyTokenFields: " + string(anyTokenFields) + ", anyWordFields: " + string(anyWordFields));
	
	// if there are no Token level fields but there are Word level fields, let's change the Word fields to Tokens fields
	if (!anyTokenFields && anyWordFields) {
		var wordLevelRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevel, 0, global.tagInfoGrid_colLevel, ds_grid_height(global.tagInfoGrid), "word");
		while (wordLevelRow > -1) {
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, wordLevelRow, "token");
			wordLevelRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevel, 0, global.tagInfoGrid_colLevel, ds_grid_height(global.tagInfoGrid), "word");
		}
	}
	
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
			show_debug_message("scr_importInfoGrid() ... DisplayToken set: " + string(currentField));
		}
		// if this field is Unit level and we have not yet set Speaker, and this is not a ~field, let's set this field to Speaker
		if (!setSpeaker && currentLevel == global.levelUnit && string_char_at(currentField, 1) != "~") {
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "Speaker");
			setSpeaker = true;
			show_debug_message("scr_importInfoGrid() ... Speaker set: " + string(currentField));
		}
	}
	
	show_debug_message("scr_importInfoGrid, END... " + scr_printTime());


}
