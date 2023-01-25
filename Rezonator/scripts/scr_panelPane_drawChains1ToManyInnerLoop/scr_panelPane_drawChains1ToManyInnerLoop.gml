function scr_panelPane_drawChains1ToManyInnerLoop(chain1toManyColFieldList, chain, entry, ID, currentEntryTagMap, textPlusY, rectY1, rectY2, highlight, mouseoverHeader, mouseoverScrollBar) {

	// NOTE: for stacks, the ID variable will be a unitID
	
	// make sure this is a valid ID
	if (!is_string(ID)) exit;
	
	var isChunk = scr_isChunk(ID);
	var unitID = "";
	var tokenID = "";
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var IDsubMap = global.nodeMap[? ID];
	var type = IDsubMap[? "type"];
	if (type == "unit") {
		unitID = ID;
		var entryList = IDsubMap[? "entryList"];
		var firstEntry = entryList[| 0];
		var entrySubMap = global.nodeMap[? firstEntry];
		tokenID = entrySubMap[? "token"];
	}
	else if (type == "token") {
		unitID = IDsubMap[? "unit"];
		tokenID = ID;
	}
	else if (type == "chunk") {
		tokenID = scr_getFirstWordOfChunk(ID);
		var firstTokenSubMap = global.nodeMap[? tokenID];
		if (scr_isNumericAndExists(firstTokenSubMap, ds_type_map)) {
			unitID = firstTokenSubMap[? "unit"];
		}
	}
	
	
	var unitSubMap = global.nodeMap[?unitID];
	var tokenSubMap = global.nodeMap[?tokenID];
	
	var textMarginTop = functionTabs_tabHeight;
	var xBuffer = 6;
	var dropDownButtonWidth = sprite_get_width(spr_dropDown);
	var colWidth = windowWidth / chain1toMColAmount;

	var chunkSubMap = isChunk ? global.nodeMap[? ID] : -1;
	var entryTagMap = global.nodeMap[? "entryTagMap"];
	
	// loop across horizontally along the chainContents window, getting each field for each entry
	var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
	var colAmount = 4 + chainContents1toManyFieldListSize;
	for (var i = 0; i < colAmount; i++) {

		// draw rectangle to prevent text overlapping
		var cellRectX1 = x + (i * colWidth) + scrollHorPlusX;
		var cellRectY1 = rectY1;
		var cellRectX2 = cellRectX1 + colWidth;
		var cellRectY2 = rectY2;
		var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader && !mouseoverScrollBar;
		draw_set_alpha(1);
		draw_set_color(merge_color(functionChainContents_BGColor, global.colorThemeBG, (highlight) ? 0.75 : 0.9));
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		var tagMap = undefined;
		if (!scr_isNumericAndExists(unitSubMap, ds_type_map)) continue;
		if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) continue;
		if (functionChainList_currentTab == functionChainList_tabStackBrush) {
			tagMap = unitSubMap[? "tagMap"];
		}
		else {
			tagMap = tokenSubMap[? "tagMap"];
		}
		
		// check if this field is read only
		var currentField = "";
		var readOnlyField = false;
		if (i < 4) readOnlyField = true;
		else {
			currentField = chain1toManyColFieldList[| i - 4];
			var currentFieldSubMap = entryTagMap[? currentField];
			if (scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) {
				if (!ds_map_exists(currentFieldSubMap, "tagSet")) readOnlyField = true;
				if (currentFieldSubMap[? "readOnly"]) readOnlyField = true;
			}
		}
		
		// get string of data
		var cellText = "";
		switch (i) {
			// RezSeq / TrailSeq / StackSeq
			case 0:
				if (functionChainList_currentTab == functionChainList_tabRezBrush) cellText = currentEntryTagMap[? "RezSeq"];
				else if (functionChainList_currentTab == functionChainList_tabTrackBrush) cellText = currentEntryTagMap[? "TrailSeq"];
				else if (functionChainList_currentTab == functionChainList_tabStackBrush) cellText = currentEntryTagMap[? "StackSeq"];
				
				// if this field is not numeric, we will run the sorter/auto-tagger on this chain again
				if (!is_numeric(cellText)) scr_sortVizSetIDList(chain);
				break;
			// unitSeq
			case 1:
				cellText = string(unitSubMap[? "unitSeq"]);
				break;
			// tokenSeq / speaker
			case 2:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					cellText = string(tagMap[? global.participantField]);
				}
				else {
					cellText = string(tokenSubMap[? "tokenOrder"]);
				}
				break;
			// text
			case 3:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					// getting the text for a unit
					if (!scr_isNumericAndExists(entryList, ds_type_list)) break;
					cellText = scr_getUnitText(unitSubMap);
						
					if (string_length(cellText) > 100) {
						cellText = string_delete(cellText, 100, string_length(cellText) - 100);
						cellText += "...";
					}
				}
				else {
					if (isChunk) {
						// getting the text for a chunk
						cellText = scr_getChunkText(ID);
					}
					else {
						// getting the text for a token
						cellText = tagMap[? global.displayTokenField];
					}
				}
				break;
		}
		
		
		// dynamic columns
		if (i >= 4) {
			// make sure field is a string
			if (!is_string(currentField)) continue;
		
			// look up currentField in tagMap
			if (scr_isNumericAndExists(currentEntryTagMap, ds_type_map)) {	
				if (ds_map_exists(currentEntryTagMap, currentField)) {
					cellText = ds_map_find_value(currentEntryTagMap, currentField);
				}
			}
			
			scr_chainTagDropDown(global.entryFieldMap, currentField, entry, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, (i == colAmount - 1), cellText);
		}
		
		// get coordinates for text
		// text coordinates
		if (lineStateLTR) {
			draw_set_halign(fa_left);
			var textX = x + (i * colWidth) + xBuffer + scrollHorPlusX;
		}
		else {
			draw_set_halign(fa_right);
			var textX = floor(x + ((i + 1) * colWidth) - xBuffer) + scrollHorPlusX;
			if (mouseoverCell) {
				textX = textX - dropDownButtonWidth;
			}
		}
		
		var textY = y + textMarginTop + textPlusY;
		
		// remove linebreaks from string before drawing it
		var drawStr = string(cellText);
		drawStr = string_replace_all(drawStr, "\r", "");
		drawStr = string_replace_all(drawStr, "\n", "");
		
		if (mouseoverCell) {
			obj_control.hoverTextCopy = drawStr;
		}
		
		// finally, draw the string in the cell
		draw_set_color(global.colorThemeText);
		draw_set_alpha(readOnlyField ? 0.7 : 1);
		draw_set_valign(fa_middle);
		drawStr = scr_adaptFont(drawStr, "S");
		draw_text(textX - clipX + 2, floor(textY - clipY + scrollPlusY), drawStr);
		draw_set_alpha(1);
	}
}