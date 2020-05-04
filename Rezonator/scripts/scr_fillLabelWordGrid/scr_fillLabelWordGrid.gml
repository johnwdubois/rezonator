// fill labelWordGrid with UnitID, WordID, token, and transcript information
var labelWordGridHeight = ds_grid_height(global.labelWordGrid);
for (var i = 0; i < labelWordGridHeight; i++) {
	var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, i);
	var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, i);
	var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
	var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
	
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colUnitID, i, currentUnitID);
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colWordID, i, currentWordID);
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colWordToken, i, currentWordToken);
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colWordTranscript, i, currentWordTranscript);
}

// check if transcript info is available in wordGrid
with (obj_control) {
	transcriptAvailable = false;
	var wordGridHeight = ds_grid_height(obj_control.wordGrid);
	for (var i = 0; i < wordGridHeight; i++) {
		if (ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i) != 0) {
			transcriptAvailable = true;
			break;
		}
	}
}


ds_list_clear(global.labelWordGridColNameList);
ds_list_add(global.labelWordGridColNameList, "UnitID", "WordID", "text", "transcript");

// set custom label names for token and transcript columns
if (ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, 3) != -1) {
	var labelName = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colTier, 3);
	ds_list_set(global.labelWordGridColNameList, 2, labelName);
}
if (ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, 4) != -1) {
	var labelName = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colTier, 4);
	ds_list_set(global.labelWordGridColNameList, 3, labelName);
}


var customLabelGridHeight = ds_grid_height(global.customLabelGrid);
for (var i = 0; i < customLabelGridHeight; i++) {
	
	var importGridCol = -1;
	var currentLabel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLabel, i);


	if (string(currentLabel) == "0" or is_undefined(currentLabel)) {
		continue;
	}


	var importGridCol = ds_list_find_index(global.importGridColNameList, "\\" + currentLabel);
	
	ds_list_add(global.labelWordGridColNameList, currentLabel);
	

	if (importGridCol >= 0) {
		
		var tokenList = ds_list_create();
		
		var importGridHeight = ds_grid_height(global.importGrid);
		for (var j = 0; j < importGridHeight; j++) {
			
			var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
			var currentLineTokenList = scr_splitStringImport(currentLine);
			var currentLineTokenListSize = ds_list_size(currentLineTokenList);
			for (var k = 0; k < currentLineTokenListSize; k++) {
				ds_list_add(tokenList, ds_list_find_value(currentLineTokenList, k));
			}
			ds_list_destroy(currentLineTokenList);
		}
		
		var labelWordGridHeight = ds_grid_height(global.labelWordGrid);
		for (var j = 0; j < labelWordGridHeight; j++) {
			var currentToken = ds_list_find_value(tokenList, j);
			ds_grid_set(global.labelWordGrid, i + 4, j, currentToken);
		}
	}
}