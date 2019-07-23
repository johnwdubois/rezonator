var currentHitIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;
var unitID = argument4;

draw_set_alpha(1);

for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentHitIDList); drawWordLoop++)
{
	var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
	var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID - 1);
	
	// Prevent dead words from being drawn
	var currentWordGridRow = currentWordID - 1;
	var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
	if(currentWordState == obj_control.wordStateDead) {
		
		continue;
	}
	
	var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID - 1);
		
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID - 1);
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
		
	var wordRectX1 = currentWordX;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2);
	var wordRectX2 = wordRectX1 + string_width(currentWordString);
	var wordRectY2 = wordRectY1 + string_height(currentWordString);
	
	
		
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2)) {
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		// Record user's click in the Search screen to highlight.
		if (mouse_check_button_pressed(mb_left)) {
			var newSwitch = ds_grid_get(hitGrid, hitGrid_colUnitID, currentHitID - 1)
			with (obj_control) {
				//preSwitchDisplayRow = newSwitch;
				highlightedSearchRow = newSwitch;
				
			}
		}
	}
	
	
	// figure out if the user has their mouse hovering over this word, and if so, are they clicking?
	var mouseover = false;
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) and not obj_chain.inRezPlay
	and not mouseoverPanelPane and (hoverWordID == currentWordID || hoverWordID == -1)) {
		mouseover = true;
		hoverWordID = currentWordID;
		
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		if (mouse_check_button_pressed(mb_left)) {
			with (obj_chain) {
				scr_wordClicked(currentWordID, unitID);
			}
		}
	}
		
	if(point_in_rectangle(mouse_x, mouse_y, 0, wordRectY1, room_width, wordRectY2) and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
		if (mouse_check_button_pressed(mb_left) and !obj_chain.inRezPlay) {
			with (obj_chain) {
				scr_wordClicked(currentWordID, unitID);
			}
		}
	}
	
	// quicklinks in search screen	
	if ((obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) and mouseRectMade) {
		inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (inMouseHoldRect) {
			with (obj_control) {
				if (ds_list_find_index(inRectWordIDList, currentWordID) < 0) {
					ds_list_add(inRectWordIDList, currentWordID);
					ds_list_add(inRectHitIDList, currentHitID);
				}
			}
		}
	}
	
	
	// allow quick stacks on the search screen
	if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade) {
		inMouseHoldRect = rectangle_in_rectangle(0, wordRectY1, room_width, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (inMouseHoldRect) {
			with (obj_control) {
				if (ds_list_find_index(inRectUnitIDList, unitID) == -1) {
					ds_list_add(inRectUnitIDList, unitID);
					ds_list_add(inRectWordIDList, currentWordID);
				}
			}
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
	// figure out whether or not to draw fill/border for this word
	var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordID - 1);
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
	var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
	var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);
	
	
	// draw fill rectangle if needed
	if (drawFillRect) {
		draw_set_color(effectColor);
		draw_set_alpha(0.25);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
		draw_set_alpha(1);
	}
	
	// draw border if needed
	if (drawBorder) {
		var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		draw_set_color(effectColor);
		
		for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
			if (borderRounded) {
				draw_roundrect(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
			/*
			else {
				draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
			*/
		}
	}

	if (drawFocused) {
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
	}
	
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
	
	draw_set_alpha(1);
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, currentHitID - 1)) {
		draw_set_font(global.fontMainBold);
		draw_set_color(make_color_rgb(19,69,150));
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(currentWordX, currentLineY, currentWordString);
		
	previousWordDisplayCol = currentWordDisplayCol;
}