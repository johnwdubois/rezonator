/*
	scr_drawStackShowWindow();
	
	Last Updated: 2020-10-29
	
	Called from: obj_dialogueBox
	
	Purpose: draw the inner window showing the list of Stacks that can be put into the Stackshow
	
	Mechanism: loop through Stackgrid and check for mouseclicks on the Stacks
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_drawStackShowWindow() {
	
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	
	var stackChainListSize = ds_list_size(stackChainList);
	// Set text margin area
	var filterRectMargin = 10;
	var filterRectSize = 20;
	var textMarginLeft = 34;

	var textMarginTop = 10;
	var textPlusY = 0;
	var chainNameRectMinusY = 10;

	var focusedElementY = -1;

	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	var strHeight = string_height("0") + 5;

	// Begin the scrollable surface
	scr_surfaceStart();


	// Loop through the Stack Grid
	for (var i = 0; i < stackChainListSize; i++) {
		
		// Only draw elements of the list that should be visible
		if (y + textMarginTop + scrollPlusY + textPlusY < y - strHeight
		or y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
	
		var currentChainID = ds_list_find_value(stackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
	
		// Get grid info of current chain
		var currentChainName = ds_map_find_value(currentChainSubMap, "chainName"); 
		var chainColor = ds_map_find_value(currentChainSubMap, "chainColor");
	
		// Get dimensions of rectagle around chain name
		var chainNameRectX1 = x + textMarginLeft;
		var chainNameRectY1 = y + textMarginTop + textPlusY + scrollPlusY - (strHeight / 2);
		var chainNameRectX2 = x + windowWidth - 75;
		var chainNameRectY2 = chainNameRectY1 + string_height(currentChainName) - chainNameRectMinusY;

		//Check mouse clicks to focus a chain in the list
		if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2 + 10)){
			if(device_mouse_check_button_released(0, mb_left) && (!instance_exists(obj_dropDown) || obj_control.dialogueBoxActive)) {
				obj_chain.currentFocusedChainID = currentChainID;
			}
			// Check for Right mouse Click on the Stack
			if(device_mouse_check_button_released(0, mb_right)) {
				
				obj_chain.currentFocusedChainID = currentChainID;
				obj_control.selectedChainID = currentChainID;
		
				var dropDownOptionList = ds_list_create();
		
				ds_list_add(dropDownOptionList, "Rename", "Recolor", "Delete", "Caption", "Clip");
		
				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeChainList);
				}
			
			}
		}

		//Color codes the chain lists for User

		var rectX1 = x + textMarginLeft - 2; // Create the colored rectangle
		var rectX2 = chainNameRectX2; 

		//if (currentChainState == obj_chain.chainStateFocus) {
		//	rectX1 = x;
		//}
		draw_set_color(merge_color(chainColor, global.colorThemeBG, 0.65)); //soften the color
		draw_rectangle(rectX1 - clipX, y + textMarginTop + textPlusY + scrollPlusY - 12 - clipY, rectX2 - clipX, y + textMarginTop + textPlusY + scrollPlusY + 12 - clipY, false);
	
		//Outline the rectangle in black
		if (currentChainID == obj_chain.currentFocusedChainID) {
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(rectX1 - clipX, y + textMarginTop + textPlusY + scrollPlusY - 12 - clipY, rectX2 - clipX, y + textMarginTop + textPlusY + scrollPlusY + 12 - clipY, true);
		
			focusedElementY = y + textMarginTop + scrollPlusY + textPlusY;
		}
	
		// Allow for text to not stretch past its barrier
		var cutoffs = 0;
		while (x + textMarginLeft + string_width(currentChainName + "...") > x + windowWidth - 95 and cutoffs < 500) {
			currentChainName = string_delete(currentChainName, string_length(currentChainName), 1);
			cutoffs++;
		}
		if (cutoffs > 0) {
			currentChainName += "...";
		}
	
	
		// Draw text of chain names
		draw_set_color(global.colorThemeText);
		draw_text(x + textMarginLeft - clipX, y + textMarginTop + scrollPlusY + textPlusY - clipY, currentChainName);
	
		// Draw little boxes for filter selection
		var chainFilterRectX1 = x + filterRectMargin - clipX;
		var chainFilterRectY1 = y + textMarginTop + scrollPlusY + textPlusY - (filterRectSize / 2) - clipY;
		var chainFilterRectX2 = chainFilterRectX1 + filterRectSize;
		var chainFilterRectY2 = chainFilterRectY1 + filterRectSize;
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
	
		draw_sprite_ext(spr_filterIcons, inFilter, mean(chainFilterRectX1, chainFilterRectX2), mean(chainFilterRectY1, chainFilterRectY2), 1, 1, 0, c_white, 1);
	
	
		// Check boxes for user selection with mouse click
		if (point_in_rectangle(mouse_x, mouse_y, chainFilterRectX1 + clipX, chainFilterRectY1 + clipY, chainFilterRectX2 + clipX, chainFilterRectY2 + clipY)) {	
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, true);
		
			if ((device_mouse_check_button_released(0, mb_left)  or (keyboard_check_pressed(ord("P")) and !keyboard_check(vk_control) and (keyboard_check(vk_rshift) or keyboard_check(vk_lshift)))) and not instance_exists(obj_dialogueBox)) {
				// Record previous display row in case Filter is empty	
				// Set selected objects to be filtered
				inFilter = !inFilter;
				ds_map_replace(currentChainSubMap, "filter", inFilter);
			}
		}
		
		
		
		// Get height of chain name to increment the height of the list
		textPlusY += strHeight;
	}

/*
	var focusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			

		if (focusedElementY <= y + textMarginTop + strHeight) {
			scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
		}
		
		else {
			scrollPlusYDest += 4;
		}
	}
		
	if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
		if (focusedChainRow < ds_grid_height(grid) - 1 and focusedChainRow >= 0) {
			scr_unFocusAllChains();
			scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false); 
			focusedChainRow++;
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
				
			if (focusedElementY >= y + windowHeight - strHeight) {
				scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
			}
		}
		else {
			scrollPlusYDest -= 4;
		}
	}
	*/
	// CTRL+UP and CTRL+DOWN
	if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
		scrollPlusYDest = 100;
	}
	if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
		scrollPlusYDest = -999999999999;
	}
	
	// PAGEUP and PAGEDOWN
	if (keyboard_check_pressed(vk_pageup)) {
		scrollPlusYDest += (windowHeight);
	}
	if (keyboard_check_pressed(vk_pagedown)) {
		scrollPlusYDest -= (windowHeight);
	}

	scr_scrollBar(stackChainListSize, focusedElementY, strHeight, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth - 60, windowHeight);

	scr_surfaceEnd();
}
