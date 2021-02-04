// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChainContentsInnerLoop(currentWordID, textPlusY){
	
	// NOTE: for stacks, the currentWordID variable will be a unit
	
	var textMarginTop = functionChainList_tabHeight;
	var xBuffer = 6;
	
	// Set collected info into correct places
	for (var getInfoLoop = 0; getInfoLoop < 3; getInfoLoop++) {
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
			
		var textX = x + (getInfoLoop * (windowWidth / 6)) + xBuffer;
		var textY = y + textMarginTop + textPlusY;
			
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
					
		// remove linebreaks from string before drawing it
		var drawStr = string_replace_all(currentWordInfoCol[getInfoLoop], "\r", "");
		drawStr = string_replace_all(drawStr, "\n", "");
		scr_adaptFont(drawStr, "S");
		draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, drawStr);
	}
}