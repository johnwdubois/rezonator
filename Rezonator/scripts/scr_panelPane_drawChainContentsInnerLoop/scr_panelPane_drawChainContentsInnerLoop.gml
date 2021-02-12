// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChainContentsInnerLoop(currentEntry, currentWordID, currentTagMap, textPlusY, rectY1, rectY2, highlight){
	
	// NOTE: for stacks, the currentWordID variable will be a unit
	
	var textMarginTop = functionChainList_tabHeight;
	var xBuffer = 6;
	
	// loop across horizontally along the chainContents window, getting each field for each entry
	var chainContents1toManyFieldListSize = ds_list_size(obj_control.chain1toManyColFieldList);
	var colAmount = 3 + chainContents1toManyFieldListSize;
	for (var getInfoLoop = 0; getInfoLoop < colAmount; getInfoLoop++) {

		// draw rectangle to prevent text overlapping
		var cellRectX1 = x + (getInfoLoop * (windowWidth / colAmount));
		var cellRectY1 = rectY1;
		var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
		var cellRectY2 = rectY2;
		var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		draw_set_alpha(1);
		draw_set_color(merge_color(functionChainContents_BGColor, global.colorThemeBG, (highlight) ? 0.75 : 0.9));
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		// get string of data
		currentWordInfoCol[getInfoLoop] = "";
		switch (getInfoLoop) {
			case 0:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					var unitID = currentWordID;
					currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
				}
				else {
					var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
					currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
				}
				break;
			case 1:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID - 1);
				}
				else {
					currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
				}
				break;
			case 2:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					currentWordInfoCol[getInfoLoop] = "";
					var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordID - 1);
					if (currentWordIDList == undefined) {
						break;
					}

					var currentWordIDListSize = ds_list_size(currentWordIDList);
					for (var i = 0; i < currentWordIDListSize; i++) {
						var currentUnitWordID = ds_list_find_value(currentWordIDList, i);
						if (is_numeric(currentUnitWordID)) {
							var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentUnitWordID - 1);
							if (currentWordState == obj_control.wordStateDead) {
								continue;
							}
							var currentWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentUnitWordID - 1);
							currentWordInfoCol[getInfoLoop] += string(currentWordString) + " ";
						}
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
					currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1));
				}
				break;
		}
		
		
		// dynamic columns
		if (getInfoLoop >= 3) {
			
			// get the current field and make sure its a string
			var currentField = ds_list_find_value(obj_control.chain1toManyColFieldList, getInfoLoop - 3);
			if (!is_string(currentField)) continue;
		
			// look up currentField in tagMap
			if (is_numeric(currentTagMap)) {
				if (ds_exists(currentTagMap, ds_type_map)) {	
					if (ds_map_exists(currentTagMap, currentField)) {
						currentWordInfoCol[getInfoLoop] = ds_map_find_value(currentTagMap, currentField);
					}
				}
			}
			
			// dropDown button for editing tags
			var currentFieldTagSubMap = ds_map_find_value(global.entryFieldMap, currentField);
			if (is_numeric(currentFieldTagSubMap)) {
				if (ds_exists(currentFieldTagSubMap, ds_type_map)) {
										
					// check whether this field has a tagSet
					var currentFieldHasTagSet = ds_map_exists(currentFieldTagSubMap, "tagSet");
					var currentFieldHasShortcutSet = ds_map_exists(currentFieldTagSubMap, "shortcutSet");
	
					// draw dropDown button if this field has a tagSet
					if (currentFieldHasTagSet) {
			
						// get the tagSet of this field and make sure it exists
						var currentFieldTagSet = ds_map_find_value(currentFieldTagSubMap, "tagSet");
						if (is_numeric(currentFieldTagSet)) {
							if (ds_exists(currentFieldTagSet, ds_type_list)) {
						
								// dropdown button coordinates
								var dropDownButtonX1 = cellRectX1 + ((cellRectX2 - cellRectX1) * 0.8);
								var dropDownButtonY1 = cellRectY1 + ((cellRectY2 - cellRectY1) * 0.25);
								var dropDownButtonX2 = cellRectX1 + ((cellRectX2 - cellRectX1) * 0.95);
								var dropDownButtonY2 = cellRectY1 + ((cellRectY2 - cellRectY1) * 0.75);
								if (getInfoLoop == colAmount - 1) {
									dropDownButtonX1 -= global.scrollBarWidth;
									dropDownButtonX2 -= global.scrollBarWidth;
								}
								var mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
								draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
								
								// click on dropdown button to create dropdown
								if (mouseoverDropDown) {
									draw_set_color(global.colorThemeBorders);
									draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
									if (mouse_check_button_released(mb_left)) {
										obj_control.chain1toManyEntryToChange = currentEntry;
										obj_control.chain1toManyFieldToChange = currentField;
										scr_createDropDown(cellRectX1, cellRectY2, currentFieldTagSet, global.optionListTypeChainContents1ToManyTag);
									}
								}
						
								// keyboard shortcut
								if (currentFieldHasShortcutSet && mouseoverCell) {
									var currentFieldShortcutSet = ds_map_find_value(currentFieldTagSubMap, "shortcutSet");
									if (is_numeric(currentFieldShortcutSet)) {
										if (ds_exists(currentFieldShortcutSet, ds_type_list)) {
											var currentFieldShortcutSetSize = ds_list_size(currentFieldShortcutSet);
											for (var i = 0; i < currentFieldShortcutSetSize; i++) {
												var currentShortcut = ds_list_find_value(currentFieldShortcutSet, i);
												currentShortcut = string_upper(string(currentShortcut));
												if (string_length(currentShortcut) == 1) {
													if (keyboard_check_released(ord(currentShortcut))) {
														obj_control.chain1toManyEntryToChange = currentEntry;
														obj_control.chain1toManyFieldToChange = currentField;
														var optionSelected = ds_list_find_value(currentFieldTagSet, i);
														scr_chainContents1ToManyTagOptions(optionSelected);
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
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