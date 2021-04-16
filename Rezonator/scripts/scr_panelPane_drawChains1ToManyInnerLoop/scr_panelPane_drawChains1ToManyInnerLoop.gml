// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1ToManyInnerLoop(chain1toManyColFieldList, currentEntry, ID, currentTagMap, textPlusY, rectY1, rectY2, highlight, mouseoverHeader, mouseoverScrollBar){

	// NOTE: for stacks, the ID variable will be a unitID
	
		// make sure this is a valid ID
	if (ID == undefined) {
		exit;
	}
	
	
	
	var unitID = -1;
	var tokenID = -1;
	var IDsubMap = global.nodeMap[?ID];
	var type = IDsubMap[?"type"];
	if(type == "unit"){
		unitID = ID
		var entryList = IDsubMap[?"entryList"];
		var firstEntry = entryList[|0];
		var entrySubMap = global.nodeMap[?firstEntry];
		tokenID = entrySubMap[?"token"]
	}
	else if(type == "token"){	
		unitID = IDsubMap[?"unit"];
		tokenID = ID
	}
	
	var unitSubMap = global.nodeMap[?unitID];
	var tokenSubMap = global.nodeMap[?tokenID];
	
	var textMarginTop = functionTabs_tabHeight;
	var xBuffer = 6;
	
	var chunkFirstWord = scr_getFirstWordOfChunk(ID);
	var isChunk = (chunkFirstWord >= 0);
	var chunkSubMap = isChunk ? global.nodeMap[? ID] : -1;
	
	// loop across horizontally along the chainContents window, getting each field for each entry
	var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
	var colAmount = 3 + chainContents1toManyFieldListSize;
	for (var getInfoLoop = 0; getInfoLoop < colAmount; getInfoLoop++) {

		// draw rectangle to prevent text overlapping
		var cellRectX1 = x + (getInfoLoop * (windowWidth / colAmount));
		var cellRectY1 = rectY1;
		var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
		var cellRectY2 = rectY2;
		var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader && !mouseoverScrollBar;
		draw_set_alpha(1);
		draw_set_color(merge_color(functionChainContents_BGColor, global.colorThemeBG, (highlight) ? 0.75 : 0.9));
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		var tagMap = unitSubMap[?"tagMap"];
		// get string of data
		currentWordInfoCol[getInfoLoop] = "";
		switch (getInfoLoop) {
			// unitSeq
			case 0:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					currentWordInfoCol[getInfoLoop] = string(unitSubMap[?"unitSeq"]);
				}
				break;
			// wordOrder
			case 1:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					currentWordInfoCol[getInfoLoop] = string(tagMap[?global.speakerField]);
				}
				else {
				//	currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, (isChunk) ? chunkFirstWord - 1 : ID - 1));
				}
				break;
			// text
			case 2:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					currentWordInfoCol[getInfoLoop] = "";
					var entryList = unitSubMap[?"entryList"];
					if (entryList == undefined) {
						break;
					}

					var entryListSize = ds_list_size(entryList);
					for (var i = 0; i < entryListSize; i++) {
						
						var currentUnitEntryID = ds_list_find_value(entryList, i);
						var currentUnitEntrySubMap = global.nodeMap[?currentUnitEntryID];
						var currentUnitTokenID = currentUnitEntrySubMap[?"token"];
									
						/* bring back dead words maybe one day
						var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentUnitWordID - 1);
						if (currentWordState == obj_control.wordStateDead) {
							continue;
						}
						*/
						var currentTokenSubMap = global.nodeMap[?currentUnitTokenID];
						var tokenTagMap = currentTokenSubMap[?"tagMap"];
						var currentWordString = tokenTagMap[?global.displayTokenField];
						currentWordInfoCol[getInfoLoop] += string(currentWordString) + " ";
						
					}
					// remove any newlines or carriage returns from the utterance display
					currentWordInfoCol[getInfoLoop] = string_replace_all(currentWordInfoCol[getInfoLoop], "\r", "");
					currentWordInfoCol[getInfoLoop] = string_replace_all(currentWordInfoCol[getInfoLoop], "\n", "");
						
					if (string_length(currentWordInfoCol[getInfoLoop]) > 100) {
						currentWordInfoCol[getInfoLoop] = string_delete(currentWordInfoCol[getInfoLoop], 100, string_length(currentWordInfoCol[getInfoLoop]) - 100);
						currentWordInfoCol[getInfoLoop] += "...";
					}
				}
				else {
					if (isChunk) {
						var tokenList = chunkSubMap[? "tokenList"];
						var tokenListSize = ds_list_size(tokenList);
						for (var i = 0; i < tokenListSize; i++) {
							var currentToken = tokenList[| i];
							currentWordInfoCol[getInfoLoop] += string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentToken - 1)) + " ";
						}
					}
					else {
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, ID - 1));
					}
				}
				break;
		}
		
		
		// dynamic columns
		if (getInfoLoop >= 3) {
			
			// get the current field and make sure its a string
			var currentField = ds_list_find_value(chain1toManyColFieldList, getInfoLoop - 3);
			if (!is_string(currentField)) continue;
		
			// look up currentField in tagMap
			if (is_numeric(currentTagMap)) {
				if (ds_exists(currentTagMap, ds_type_map)) {	
					if (ds_map_exists(currentTagMap, currentField)) {
						currentWordInfoCol[getInfoLoop] = ds_map_find_value(currentTagMap, currentField);
					}
				}
			}
			
			scr_chainTagDropDown(global.entryFieldMap, currentField, currentEntry, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, (getInfoLoop == colAmount - 1));
		}
			
		var textX = x + (getInfoLoop * (windowWidth / colAmount)) + xBuffer;
		var textY = y + textMarginTop + textPlusY;
		
		// remove linebreaks from string before drawing it
		var drawStr = string(currentWordInfoCol[getInfoLoop]);
		drawStr = string_replace_all(drawStr, "\r", "");
		drawStr = string_replace_all(drawStr, "\n", "");
			
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
		drawStr = scr_adaptFont(drawStr, "S");
		draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, drawStr);
	}
}