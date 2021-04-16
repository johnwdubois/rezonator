function scr_panelPane_drawUnits1toMany() {
	/*
		Purpose: whatever Line is focused on in the lineList panelPane, draw information on the individual words of that Line
	*/
	
	scr_surfaceStart();

	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	var headerHeight = functionTabs_tabHeight;
	var scrollBarListSize = 0;
	var drawDropDowns = false;


	var grid = obj_control.currentActiveLineGrid;




	if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
		exit;
	}


	var rowInLineGrid = functionChainList_lineGridRowFocused;



	// Set text margins
	var textMarginTop = headerHeight;
	var textPlusY = 0;
	var ableToBeMouseOver = true;
	var alignRectSize = strHeight;
	var oldRow = -1;
	var focusedElementY = -1;

	if (!instance_exists(obj_dropDown)) {
		lineContentsHighlightRow = -1;
	}
	
	var unitSubMap = global.nodeMap[? functionChainList_focusedUnit];



	// check if focused unit exists
	if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
		
		// get entryList for this unit
		with (obj_panelPane) {
			functionChainContents_IDList = unitSubMap[? "entryList"];
		}
		
		
		if (scr_isNumericAndExists(functionChainContents_IDList, ds_type_list)) {
		
			scrollBarListSize = ds_list_size(functionChainContents_IDList) + 2;
		
			// loop down entryList
			var IDListSize = ds_list_size(functionChainContents_IDList);
			for (var i = 0; i < IDListSize; i++) {
				
				drawDropDowns = false;
				
				// get currentTokenID
				var currentTokenID = "";	
				if (obj_control.searchGridActive) {
					// return to search stuff later!
					var hitID = functionChainContents_IDList[| i];
					currentTokenID = hitID;
				}
				else {
					currentTokenID = functionChainContents_IDList[| i];
				}
		
				// get coordinates of rect
				var rectX1 = x;
				var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
				var rectX2 = x + windowWidth - global.scrollBarWidth;
				var rectY2 = rectY1 + strHeight;
				var mouseoverRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, max(rectY1, y + headerHeight), rectX2, rectY2);

				if (mouseoverRect and ableToBeMouseOver and !instance_exists(obj_dropDown)
				and !instance_exists(obj_dialogueBox)) {
					drawDropDowns = true;
					ableToBeMouseOver = false;
					lineContentsHighlightRow = i;
				}
				
				draw_set_alpha(1);
	
				// Check for double click
				if (mouseoverRect) {
					if (device_mouse_check_button_released(0, mb_left)) {
						if (doubleClickTimer > -1) {
							// scroll to focused unit if the user double clicks 
							var linePixelY = unitSubMap[? "pixelY"];
							obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
						}
					}
					else {
						doubleClickTimer = 0;
					}
				}
					
				scr_panelPane_drawUnits1toManyInnerLoop(currentTokenID, drawDropDowns, strHeight, textPlusY, rectY1, rectY2, (lineContentsHighlightRow == i));
			
				textPlusY += strHeight;
			} 
		}
	}




	var scrollBarBackColor = global.colorThemeSelected1;
	if (scrollBarListSize > 1000) {
		scrollBarBackColor = global.colorThemeSelected2;
	}
	if (!instance_exists(obj_dropDown)) {
		
		scr_scrollBar(scrollBarListSize, focusedElementY, strHeight, headerHeight,
			scrollBarBackColor, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}
	

	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + headerHeight - clipY, false);
	
	scr_surfaceEnd();

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainContents
	if (clickedIn) {
	
		// Scroll up with mouse/key
		if (((mouse_wheel_up() || keyboard_check(vk_up)) and (obj_panelPane.holdUp < 2 || obj_panelPane.holdUp > 30)) and !instance_exists(obj_dropDown)) {
			scrollPlusYDest += strHeight;
		}
	
		// Scroll down with mouse/key
		if (((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30))  and !instance_exists(obj_dropDown)) {
			scrollPlusYDest -= strHeight;
		}
	
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
	}

}
