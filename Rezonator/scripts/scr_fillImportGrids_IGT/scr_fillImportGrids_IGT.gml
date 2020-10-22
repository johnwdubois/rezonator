// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_fillImportGrids_IGT(){
	
	//if (live_call()) return live_result;
	
	show_debug_message("scr_fillImportGrids_IGT() ... START. Time is: " + scr_printTime());

	
	// resize & reset disco/unit/token importGrids to how they should be
	global.discoImportGridWidth = 0;
	ds_grid_resize(global.discoImportGrid, global.discoImportGridWidth, 1);
	global.unitImportGridWidth = 2;
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(global.importGrid));
	global.wordImportGridWidth = 2;
	ds_grid_resize(global.wordImportGrid, global.wordImportGridWidth, 0);
	global.tokenImportGridWidth = 5;
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, 0);

	
	// clear discoImportColNameList
	ds_list_clear(global.discoImportColNameList);
	
	// clear unitImportColNameList and add default columns to unitImportColNameList
	ds_list_clear(global.unitImportColNameList);
	ds_list_add(global.unitImportColNameList, "~UnitID", "~Participant");
	
	// clear wordImportColNameList and add default columns to wordImportColNameList
	ds_list_clear(global.wordImportColNameList);
	ds_list_add(global.wordImportColNameList, "~UnitID", "~WordID");
	
	// clear tokenImportColNameList and add default columns to tokenImportColNameList
	ds_list_clear(global.tokenImportColNameList);
	ds_list_add(global.tokenImportColNameList, "~UnitID", "~TokenID", "~text", "~transcript", "~WordID");
	

	
	
	
	

	var importGridWidth = ds_grid_width(global.importGrid);
	var importGridHeight = ds_grid_height(global.importGrid);
	
	var tokenCounter = 0;
	var wordCounter = 0;
	var tokenImportGridRow = 0;
	var tokenImportGridCol = 0;
	var wordImportGridRow = 0;
	var wordImportGridCol = 0;
	var unitImportGridCol = 0;
	var discoImportGridCol = 0;
	
	var currentUnitID = -1;
	var currentWordID = -1;
	var currentTokenID = -1;
	
	
	// get the display token field
	var displayTokenField = "";
	var displayTokenFieldRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
	if (displayTokenFieldRow >= 0) {
		displayTokenField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenFieldRow);
	}
	
	// get the speaker field
	var speakerField = "";
	var speakerFieldRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Speaker");
	if (speakerFieldRow >= 0) {
		speakerField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, speakerFieldRow);
	}
	
	
	
	
	
	
	// --- FILL DISCO/UNIT/TOKEN IMPORT ---
	// loop over every row in the importGrid, create a Unit for every row in the importGrid
	for (var i = 0; i < importGridHeight; i++) {
		
		wordCounter = 0;
		wordImportGridRow = ds_grid_height(global.wordImportGrid);
		wordImportGridCol = 2;
		unitImportGridCol = 2;
		discoImportGridCol = 0;
		
		for (var j = 0; j < importGridWidth; j++) {
			
			var currentField = ds_list_find_value(global.importGridColNameList, j);
			var currentLevel = ds_map_find_value(global.fieldLevelMap, currentField);
			var currentStr = ds_grid_get(global.importGrid, j, i);
			
			currentUnitID = i + 1;
			
			// check the level of the currentField, and enter it into either the DiscoImport, UnitImport, or TokenImport
			if (currentLevel == global.levelDiscourse) {
			
				if (currentStr != "0") {
					
					// add field to the unitImportColNameList
					if (ds_list_find_index(global.discoImportColNameList, currentField) == -1) {
						ds_list_add(global.discoImportColNameList, currentField);
						
						global.discoImportGridWidth++
						ds_grid_resize(global.discoImportGrid, global.discoImportGridWidth, 1);
					}
				
					// set the data in the discoImportGrid
					ds_grid_set(global.discoImportGrid, discoImportGridCol, 0, currentStr);
				
					discoImportGridCol++;
				}
				
			}
			else if (currentLevel == global.levelUnit) {
				
				// check if we need to grow the width of the unitImportGrid
				if (i == 0) {
					global.unitImportGridWidth++;
					ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(global.unitImportGrid));
					
					// add field to the unitImportColNameList
					if (ds_list_find_index(global.unitImportColNameList, currentField) == -1) {
						ds_list_add(global.unitImportColNameList, currentField);
					}
				}

				// set the data in the unitImportGrid
				ds_grid_set(global.unitImportGrid, unitImportGridCol, i, currentStr);
				
				// set default Unit columns (~UnitID, ~Participant)
				ds_grid_set(global.unitImportGrid, global.unitImport_colUnitID, i, currentUnitID);
				if (currentField == speakerField) {
					ds_grid_set(global.unitImportGrid, global.unitImport_colParticipant, i, currentStr);
				}
				
				unitImportGridCol++;
				
			}
			else if (currentLevel == global.levelWord or currentLevel == global.levelToken) {

				currentWordID = wordImportGridRow + 1;
				
				
				// check if we need to grow the width of the wordImportGrid
				if (i == 0) {
					global.wordImportGridWidth++;
					ds_grid_resize(global.wordImportGrid, global.wordImportGridWidth, ds_grid_height(global.wordImportGrid));
					
					// add field to the tokenImportColNameList
					if (ds_list_find_index(global.wordImportColNameList, currentField) == -1) {
						ds_list_add(global.wordImportColNameList, currentField);
					}
				}
				
				// split the string from the importGrid, so we can tokenize!
				var currentWordList = scr_splitStringWhitespace(currentStr);
				var currentWordListSize = ds_list_size(currentWordList);
				
				// make sure that we got tokens from the split
				if (currentWordListSize > 0) {
					 
					 // grow the height of the wordImportGrid (if we need to)
					 if (currentWordListSize > wordCounter) {
						  var wordImportGridNewHeight = ds_grid_height(global.wordImportGrid) + (currentWordListSize - wordCounter);
						  ds_grid_resize(global.wordImportGrid, global.wordImportGridWidth, wordImportGridNewHeight);
						  wordCounter = currentWordListSize;
					 }
					 
					 // loop over the word list and add tokens to the wordImportGrid
					 for (var k = 0; k < currentWordListSize; k++) {

						 var currentWord = ds_list_find_value(currentWordList, k);
						 var currentWordImportGridRow = wordImportGridRow + k;
						 ds_grid_set(global.wordImportGrid, wordImportGridCol, currentWordImportGridRow, currentWord);
	
						 
						 // set default word columns (~UnitID, ~WordID, ~text, ~transcript)
						 ds_grid_set(global.wordImportGrid, global.wordImport_colUnitID, currentWordImportGridRow, currentUnitID);
						 ds_grid_set(global.wordImportGrid, global.wordImport_colWordID, currentWordImportGridRow, currentWordID);

						 currentWordID++;
					 }
					 
				}
				
				
				wordImportGridCol++;
				
			}

		}
	}
	currentUnitID = 0
	var wordGridHeight = ds_grid_height(global.wordImportGrid);
	var wordGridWidth = ds_grid_width(global.wordImportGrid);
	show_debug_message("height: " + string(ds_grid_height(global.wordImportGrid)) +",   Width: "+ string(ds_grid_width(global.wordImportGrid)));
	show_debug_message("height: " + string(ds_grid_height(global.tokenImportGrid)) +",   Width: "+ string(ds_grid_width(global.tokenImportGrid)));
	for(var i = 0; i < wordGridHeight; i++){
		
		currentTokenID = tokenImportGridRow + 1;
		tokenImportGridRow = ds_grid_height(global.tokenImportGrid);
		tokenCounter = 0;
		currentUnitID = ds_grid_get(global.wordImportGrid, global.wordImport_colUnitID, i);
		tokenImportGridCol = 4;
		
		show_debug_message("Vertical word loop i is at: " +string(i)+ ",  TIGRow is: "+string(tokenImportGridRow)+ ",   Current token ID is: " +string(currentTokenID)+ ",  tokenCounter: " + string(tokenCounter));
		
		for(var j = 2; j < wordGridWidth; j++){
			
			
			
			var currentField = ds_list_find_value(global.wordImportColNameList, j);
			var currentLevel = ds_map_find_value(global.fieldLevelMap, currentField);
			var currentStr = ds_grid_get(global.wordImportGrid, j, i);
			
			currentTokenID = tokenImportGridRow + 1;
			
			if(currentLevel == global.levelWord){
				continue;
			}
		
			show_debug_message("Horizontal WordGrid loop i is at: " +string(j)+ ",  currentField is: "+string(currentField)+ ",   currentStr is: " +string(currentStr));
			
			// check if we need to grow the width of the tokenImportGrid
			if (i == 0) {
				global.tokenImportGridWidth++;
				ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(global.tokenImportGrid));
					
				// add field to the tokenImportColNameList
				if (ds_list_find_index(global.tokenImportColNameList, currentField) == -1) {
					ds_list_add(global.tokenImportColNameList, currentField);
				}
			}
			
			// split the string from the importGrid, so we can tokenize!
			var currentTokenList = scr_splitStringWhitespaceAndHyphen(currentStr);
			var currentTokenListSize = ds_list_size(currentTokenList);
			
			
			
			
			// make sure that we got tokens from the split
			if (currentTokenListSize > 0) {
					 
					// grow the height of the tokenImportGrid (if we need to)
					if (currentTokenListSize > tokenCounter) {
						var tokenImportGridNewHeight = ds_grid_height(global.tokenImportGrid) + (currentTokenListSize - tokenCounter);
						ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, tokenImportGridNewHeight);
						tokenCounter = currentTokenListSize;
					}
					 
					// loop over the token list and add tokens to the tokenImportGrid
					for (var k = 0; k < currentTokenListSize; k++) {

						var currentToken = ds_list_find_value(currentTokenList, k);
						var currentTokenImportGridRow = tokenImportGridRow + k;
						show_debug_message("token list loop k:"+string(k)+", setting token: "+string(currentToken) + "   set at col: " +string(tokenImportGridCol)+", and row: " +string(tokenImportGridRow));
						ds_grid_set(global.tokenImportGrid, tokenImportGridCol+1, currentTokenImportGridRow, currentToken);
						
						
						var currentWordID = ds_grid_get(global.wordImportGrid,global.wordImport_colWordID,i);
						 
						// set default Token columns (~UnitID, ~WordID, ~text, ~transcript)
						ds_grid_set(global.tokenImportGrid, global.tokenImport_colUnitID, currentTokenImportGridRow, currentUnitID);
						ds_grid_set(global.tokenImportGrid, global.tokenImport_colTokenID, currentTokenImportGridRow, currentTokenID);
						ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordTranscript, currentTokenImportGridRow, "");
						ds_grid_set(global.tokenImportGrid, 4, currentTokenImportGridRow, currentWordID);
						
						if (currentField == displayTokenField) {
						ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordToken, currentTokenImportGridRow, currentToken);
						}
						currentTokenID++;
					}
					 
			}		
			tokenImportGridCol++;	
		
		}
				
	}


	scr_fillCustomLabelGrid();
	fillMorphGrid_IGT();

	show_debug_message("scr_fillImportGrids_IGT() ... END. Time is: " + scr_printTime());

}

function fillMorphGrid_IGT() {
	
	var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
	
	// reset & clear morphGrid, unitGrid, lineGrid, and unitInStackGrid
	ds_grid_resize(obj_control.morphGrid, ds_grid_width(obj_control.morphGrid), tokenImportGridHeight);
	ds_grid_clear(obj_control.morphGrid, 0);
	ds_grid_resize(obj_control.unitGrid, ds_grid_width(obj_control.unitGrid), 0);
	ds_grid_clear(obj_control.unitGrid, 0);
	ds_grid_resize(obj_control.lineGrid, ds_grid_width(obj_control.lineGrid), 0);
	ds_grid_clear(obj_control.lineGrid, 0);
	ds_grid_resize(obj_chain.unitInStackGrid, ds_grid_width(obj_chain.unitInStackGrid), 0);
	ds_grid_clear(obj_chain.unitInStackGrid, 0);
	
	// set values in morphGrid from tokenImportGrid
	for (var i = 0; i < tokenImportGridHeight; i++) {
		var currentUnitID = ds_grid_get(global.tokenImportGrid, global.tokenImport_colUnitID, i);
		var currentWordID = ds_grid_get(global.tokenImportGrid, global.tokenImport_colTokenID, i);
		var currentParticipant = ds_grid_get(global.unitImportGrid, global.unitImport_colParticipant, currentUnitID - 1);
		var currentMorph = ds_grid_get(global.tokenImportGrid, global.tokenImport_colWordToken, i);
		
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, i, currentUnitID);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, i, currentWordID);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, i, currentParticipant);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, i, currentMorph);
	}
	
	scr_morphToUnitGrid();
}