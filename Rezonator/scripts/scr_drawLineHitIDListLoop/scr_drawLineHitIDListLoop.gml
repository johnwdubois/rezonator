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

	draw_set_alpha(1);
	var currentHitIDListSize = ds_list_size(currentHitIDList);
	for (var drawWordLoop = 0; drawWordLoop < currentHitIDListSize; drawWordLoop++)
	{
		var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
		var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID - 1);
		if(!is_numeric(currentWordID)){
			exit;
		}
		// Prevent dead words from being drawn
		var currentWordGridRow = currentWordID - 1;
		var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
		if(currentWordState == obj_control.wordStateDead) {
		
			continue;
		}
		
		var currentWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordGridRow);
		
		var currentWordInChainsListSize = 0;
		
		if(currentWordInChainsList != undefined){
			if(ds_exists(currentWordInChainsList, ds_type_list)){
				currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
			}
		}
		
		
		for (var i = 0; i < currentWordInChainsListSize; i++) {
			if (ds_list_find_index(chainShowList, ds_list_find_value(currentWordInChainsList, i)) == -1) {
				ds_list_add(chainShowList, ds_list_find_value(currentWordInChainsList, i));
			}
		}
		
		

		
		var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID - 1);
		
		var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID - 1);
		
		var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;

		obj_control.leftScreenBound = min(currentWordX, obj_control.leftScreenBound);
		
		if (currentWordX < currentWordDestX)
		{
			currentWordX += abs(currentWordX - currentWordDestX) / 6;
		}
		else if (currentWordX > currentWordDestX)
		{
			currentWordX -= abs(currentWordX - currentWordDestX) / 6;
		}
		
		ds_grid_set(hitGrid, hitGrid_colPixelX, currentHitID - 1, currentWordX);
		
		
		
		
		var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1);
		
		// Aquire wordDraw specifics
		var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);//global.colorThemeSelected1
		var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
		
		
		if (drawFocused) {
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		}
	
	
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
			
		
		//scr_drawChains();
		
	
	}
	


}
