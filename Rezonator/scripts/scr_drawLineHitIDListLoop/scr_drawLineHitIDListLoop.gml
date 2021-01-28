/*
	scr_drawLineHitIDListLoop(hitIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	
	Last Updated: 2019-12-27
	
	Called from: obj_control
	
	Purpose: draws searched words to main screen, using hitIDs from the given hitIDList
	
	Mechanism: loop through hitIDList to get hitIDs, look up their display info in hitGrid & dynaWordGrid
	
	Author: Terry DuBois
*/
function scr_drawLineHitIDListLoop(currentHitIDList, currentLineY, drawLineLoop, unitID) {

	var chainShowList = obj_chain.chainShowList;
	var strHeightScaled = string_height("0");

	draw_set_alpha(1);
	var currentHitIDListSize = ds_list_size(currentHitIDList);
	for (var drawWordLoop = 0; drawWordLoop < currentHitIDListSize; drawWordLoop++) {
		var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
		var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID - 1);
		if(!is_numeric(currentWordID)){
			exit;
		}
		// Prevent dead words from being drawn
		var currentWordGridRow = currentWordID - 1;
		var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
		if (currentWordState == obj_control.wordStateDead) {
			continue;
		}
		
		// get the inChainsList for this hit/word
		var currentWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordGridRow);
		var currentWordInChainsListSize = 0;
		if (currentWordInChainsList != undefined) {
			if(ds_exists(currentWordInChainsList, ds_type_list)){
				currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
			}
		}
		
		// check if this hit contains a chain, if so then add to chainShowList
		var currentWordInTrack = "";
		for (var i = 0; i < currentWordInChainsListSize; i++) {
			var currentChain = ds_list_find_value(currentWordInChainsList, i);
			var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
			if (!is_numeric(currentChainSubMap)) continue;
			if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
			
			// add this chain to chain show list
			if (ds_list_find_index(chainShowList, currentChain) == -1) {
				ds_list_add(chainShowList, ds_list_find_value(currentWordInChainsList, i));
			}
			
			// check if this chain is a track
			var currentChainType = ds_map_find_value(currentChainSubMap, "type");
			if (currentChainType == "trackChain") {
				currentWordInTrack = currentChain;
			}
		}
		
		// adjust x position of hits and set it back in the hitGrid
		var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID - 1);
		var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID - 1);
		var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
		obj_control.leftScreenBound = min(currentWordX, obj_control.leftScreenBound);
		if (currentWordX < currentWordDestX) {
			currentWordX += abs(currentWordX - currentWordDestX) / 6;
		}
		else if (currentWordX > currentWordDestX) {
			currentWordX -= abs(currentWordX - currentWordDestX) / 6;
		}
		ds_grid_set(hitGrid, hitGrid_colPixelX, currentHitID - 1, currentWordX);
		
		

		var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1);
		
		// Aquire wordDraw specifics
		var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);//global.colorThemeSelected1
		var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
	
	
		ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
	
		draw_set_alpha(1);

		draw_set_color(global.colorThemeText);
		if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, currentHitID - 1)) {
			draw_set_color(make_color_rgb(19,69,150));
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		scr_adaptFont(currentWordString, "M");
		draw_text(floor(currentWordX), floor(currentLineY), currentWordString);
		
		
		// get wordRect dimensions
		var currentWordStringWidth = string_width(currentWordString);
		var wordRectBuffer = 3;
		var wordRectX1 = currentWordX - wordRectBuffer;
		var wordRectY1 = currentLineY - (strHeightScaled / 2) - wordRectBuffer;
		var wordRectX2 = wordRectX1 + currentWordStringWidth + (wordRectBuffer * 2);
		var wordRectY2 = wordRectY1 + strHeightScaled + (wordRectBuffer * 2);
		var mouseoverWord = point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2);
		
		if (mouseoverWord) {
			obj_control.hoverWordID = currentWordID;
			if (mouse_check_button_released(mb_left)) {
				with (obj_toolPane) {
					currentMode = modeTrack;
				}
				with (obj_panelPane) {
					if (currentFunction == functionChainList) {
						functionChainList_currentTab = functionChainList_tabTrackBrush;
					}
				}
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}
		
		// if this word is in a track, we draw a rounded border around it
		if (ds_map_exists(global.nodeMap, currentWordInTrack) && currentWordInTrack != "") {
			var chainSubMap = ds_map_find_value(global.nodeMap, currentWordInTrack);
			if (!is_numeric(chainSubMap)) continue;
			if (!ds_exists(chainSubMap, ds_type_map)) continue;
			var chainColor = ds_map_find_value(chainSubMap, "chainColor");
			draw_set_color(chainColor);
			for (var i = 0; i < 3; i += 0.5) {
				draw_roundrect(wordRectX1 - i, wordRectY1 - i, wordRectX2 + i, wordRectY2 + i, true);
			}
		}
		else {
			// if this word is not in a track, and we are hovered over it, we'll draw a hover rectangle
			if (mouseoverWord) {
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			}
		}
		
		
		// draw pulsating squares if the hit/word is focused
		if (drawFocused) {
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		}
		
			
	}
	


}
