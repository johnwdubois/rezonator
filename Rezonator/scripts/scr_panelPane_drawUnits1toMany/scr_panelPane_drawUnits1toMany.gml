function scr_panelPane_drawUnits1toMany() {
	
	scr_surfaceStart();

	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont("0", "S");
	var strHeight = string_height("0");
	var headerHeight = functionTabs_tabHeight;
	var scrollBarListSize = 0;
	var drawDropDowns = false;
	var mouseoverCancel = (instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || mouseoverHorScrollBar);

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
		
		var unitType = unitSubMap[? "type"];
	
		// get entryList for this unit (or if it's a chunk, just get its tokenList)
		with (obj_panelPane) {
			if (unitType == "unit") functionChainContents_IDList = unitSubMap[? "entryList"];
			else if (unitType == "chunk") functionChainContents_IDList = unitSubMap[? "tokenList"];
		}
		if ((unitType == "unit" && obj_panelPane.functionChainList_currentTab == functionChainList_tabChunk)
		|| (unitType == "chunk" && obj_panelPane.functionChainList_currentTab == functionChainList_tabLine)) {
			scr_surfaceEnd();
			exit;
		}
		
		
		if (scr_isNumericAndExists(functionChainContents_IDList, ds_type_list)) {
			
		
			scrollBarListSize = ds_list_size(functionChainContents_IDList);
		
			// loop down entryList
			var IDListSize = ds_list_size(functionChainContents_IDList);
			for (var i = 0; i < IDListSize; i++) {
				
				// get current entry (if this is an entry)
				var currentEntry = functionChainContents_IDList[| i];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				if(!scr_isNumericAndExists(currentEntrySubMap,ds_type_map)){continue;}
				var currentEntryType = currentEntrySubMap[? "type"];
				drawDropDowns = false;
				
				// get currentTokenID
				var currentTokenID = (currentEntryType == "token") ? currentEntry : currentEntrySubMap[? "token"];	


		
				// get coordinates of rect
				var rectX1 = x;
				var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
				var rectX2 = x + windowWidth - global.scrollBarWidth;
				var rectY2 = rectY1 + strHeight;
				var mouseoverRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, max(rectY1, y + headerHeight), rectX2, rectY2)  && !mouseoverCancel;

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
						scr_jumpToUnitDoubleClick(functionChainList_focusedUnit);
					}
				}
					
				scr_panelPane_drawUnits1toManyInnerLoop(currentTokenID, drawDropDowns, strHeight, textPlusY, rectY1, rectY2, (lineContentsHighlightRow == i));
			
				textPlusY += strHeight;
			} 
		}
	}
	
	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		
		if (mouse_check_button_pressed(mb_left) && !obj_control.mouseoverTagCell) {
			scr_clearNavWindowTagging();
		}
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		scr_drawRectWidth(obj_control.navWindowTaggingCellX1 - clipX, obj_control.navWindowTaggingCellY1 - clipY, obj_control.navWindowTaggingCellX2 - clipX, obj_control.navWindowTaggingCellY2 - clipY, 2, false);
		
		if (keyboard_check_pressed(vk_left)) {
			var fieldIndex = ds_list_find_index(obj_control.navTokenFieldList, obj_control.navWindowTaggingField);
			fieldIndex = max(fieldIndex - 1, 0);
			obj_control.navWindowTaggingField = obj_control.navTokenFieldList[| fieldIndex];
			obj_control.navWindowTaggingUpdateScroll = true;
		}
		else if (keyboard_check_pressed(vk_right)) {
			var fieldIndex = ds_list_find_index(obj_control.navTokenFieldList, obj_control.navWindowTaggingField);
			fieldIndex = min(fieldIndex + 1, ds_list_size(obj_control.navTokenFieldList) - 1);
			obj_control.navWindowTaggingField = obj_control.navTokenFieldList[| fieldIndex];
			obj_control.navWindowTaggingUpdateScroll = true;
		}
		else if (keyboard_check_pressed(vk_up)) {
			var prevID = "";
			var idFound = false;
			for (var i = IDListSize - 1; i >= 0; i--) {
				var currentID = functionChainContents_IDList[| i];
				var currentIDSubMap = global.nodeMap[? currentID];
				var currentToken = currentIDSubMap[? "token"];
				if (!idFound && currentToken == obj_control.navWindowTaggingID) idFound = true;
				else if (idFound && prevID == "") prevID = currentToken;
			}
			if (prevID != "") {
				obj_control.navWindowTaggingID = prevID;
				obj_control.navWindowTaggingUpdateScroll = true;
			}
		}
		else if (keyboard_check_pressed(vk_down)) {
			var nextID = "";
			var idFound = false;
			for (var i = 0; i < IDListSize; i++) {
				var currentID = functionChainContents_IDList[| i];
				var currentIDSubMap = global.nodeMap[? currentID];
				var currentToken = currentIDSubMap[? "token"];
				if (!idFound && currentToken == obj_control.navWindowTaggingID) idFound = true;
				else if (idFound && nextID == "") nextID = currentToken;
			}
			if (nextID != "") {
				obj_control.navWindowTaggingID = nextID;
				obj_control.navWindowTaggingUpdateScroll = true;
			}
		}
	}
	

	if (!instance_exists(obj_dropDown)) {
		
		var fieldListSize = ds_list_size(obj_control.navTokenFieldList);
		var colWidth = windowWidth/obj_panelPane.unit1toMColAmount;
		scr_scrollBarHorizontal(fieldListSize, colWidth, global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		
		scr_scrollBar(scrollBarListSize+1, focusedElementY, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
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
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
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
