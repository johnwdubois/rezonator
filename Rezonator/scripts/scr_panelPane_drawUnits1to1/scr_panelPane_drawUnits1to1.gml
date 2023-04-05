function scr_panelPane_drawUnits1to1() {

	if (BUILDTYPE != "Web") scr_surfaceStart();
	
	
	// Access the lineList panelPane object to get it's scrollPlusY

	var lineListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			lineListPanelPaneInst = self.id;
		}
	}



	var strHeight = leftPaneStrHeight;
	var drawScrollbar = !chainViewOneToMany;
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : lineListPanelPaneInst.scrollPlusY;
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_sizeWindow) || mouseoverHorScrollBar;
	

	// Set text margin area
	var textMarginLeft = 8;

	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var colWidth = windowWidth / obj_panelPane.unit1to1ColAmount;
	
	var mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + headerHeight, x + windowWidth, y + windowHeight);
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;

	var drawDropDowns = false;
	
	var headerList = obj_control.navUnitFieldList;
	var headerListSize = ds_list_size(headerList);


	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var dropDownButtonWidth = sprite_get_width(spr_dropDown);
	
	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	

	var displayUnitList = obj_control.displayUnitList;
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	var displayUnitListSize = ds_list_size(displayUnitList);
	
	
	// loop across unit fields
	var i = 0;
	repeat(headerListSize) {
		
		var currentField = headerList[| i];
		textPlusY = 0;
		drawDropDowns = false;
		
	    var colRectX1 = (lineStateLTR)? x + (colWidth * i) + scrollHorPlusX : x + windowWidth - (colWidth * (i+1)) + scrollHorPlusX;
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + colWidth;
	    var colRectY2 = colRectY1 + headerHeight;
		
		// skip drawing this column if its out of horizontal drawRange
		if (colRectX2 < x || colRectX1 > x + windowWidth) {
			i++;
			continue;
		}

		// loop down units for this field
		for (var j = 0; j < displayUnitListSize; j++) {

		    if (y + headerHeight + relativeScrollPlusY + textPlusY < y - strHeight
		    or y + headerHeight + relativeScrollPlusY + textPlusY > y + windowHeight + strHeight) {
		        textPlusY += strHeight;
		        continue;
		    }

			// get current unit and its submap
			var currentUnitID = displayUnitList[| j];
			var currentUnitSubMap = global.nodeMap[? currentUnitID];
			var currentTagMap = currentUnitSubMap[? "tagMap"];		
		    var currentStr = string(currentTagMap[? currentField]);
    
		    // Get dimensions of rectangle around line name
		    var unitRectX1 = x + scrollHorPlusX;
		    var unitRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
		    var unitRectX2 = x + windowWidth;
		    var unitRectY2 = unitRectY1 + strHeight;
			var mouseoverunitRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, unitRectX1, max(unitRectY1, y + headerHeight), unitRectX2, unitRectY2) && !mouseoverScrollBar && !mouseoverHorScrollBar && !scrollBarHorHolding && !scrollBarHolding && !mouseoverCancel;
    
			// highlight rect
			draw_set_color(global.colorThemeBG);
			draw_rectangle(colRectX1 - clipX, unitRectY1 - clipY, colRectX2 - clipX, unitRectY2 - clipY, false);
				
			var readOnlyField = false;
			var unitTagMap = global.nodeMap[? "unitTagMap"];
			var currentFieldSubMap = unitTagMap[? currentField];
			if (scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) {
				if (!ds_map_exists(currentFieldSubMap, "tagSet")) readOnlyField = true;
				if (currentFieldSubMap[? "readOnly"]) readOnlyField = true;
			}
	
		    //Check mouse clicks to focus a line in the list
		    if (mouseoverunitRect && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
				drawDropDowns = true;
				with (obj_panelPane) {
					functionChainList_highlightUnit = currentUnitID;
				}
        
		        if (device_mouse_check_button_released(0, mb_left)) {
		            with (obj_panelPane) {
						functionChainList_focusedUnitIndex = j;
						functionChainList_focusedUnit = currentUnitID;
		            }
					if (obj_control.doubleClickTimer > 2) {
						// scroll to focused unit if the user double clicks
						scr_jumpToUnitTop(currentUnitID);
					}
					else {
						obj_control.doubleClickTimer = 0;
					}
		        }
		    }
			
			if (functionChainList_highlightUnit == currentUnitID) {
				
				// highlight rect
				draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.4));
				draw_rectangle(colRectX1 - clipX, unitRectY1 - clipY, colRectX2 - clipX, unitRectY2 - clipY, false);

			}
			draw_set_alpha(1);

			// dropdown buttons
			var dropDownButtonX1 = colRectX2 - sprite_get_width(spr_dropDown) - 4;
			if (lineStateLTR) {
				if (i == headerListSize - 1) dropDownButtonX1 -= global.scrollBarWidth;
			}
			else {
				if (i == 0) dropDownButtonX1 -= global.scrollBarWidth;
			}
				
			var dropDownButtonY1 = unitRectY1;
			var dropDownButtonX2 = dropDownButtonX1 + sprite_get_width(spr_dropDown);
			var dropDownButtonY2 = unitRectY2;
			var mouseoverDropDownButton = false;
								
			if (mouseoverunitRect) mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
					
				
						
	
    
		    // Outline the rectangle in black
		    if (functionChainList_focusedUnitIndex == j) {
		        focusedRowRectY1 = unitRectY1;
		        focusedRowRectY2 = unitRectY2;
		        focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
		    }
			//draw cell
			draw_set_color(global.colorThemeBG);
			draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
			
			var mouseOverCell = scr_pointInRectangleClippedWindow(mouse_x,mouse_y, colRectX1, unitRectY1, colRectX2, unitRectY2) && !mouseoverCancel;
			if (mouseOverCell) {
				if (!readOnlyField) {
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(unitRectY1, unitRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
				}
				obj_control.hoverTextCopy = currentStr;
				
			}
			
			scr_cellEdit(currentUnitID, currentField, mouseOverCell, mouseoverDropDownButton, colRectX1, unitRectY1, colRectX2, unitRectY2, currentStr, "unit");
			
			if (mouseoverDropDownButton && !readOnlyField) {
				scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, scr_get_translation("option-tag"), obj_tooltip.arrowFaceUp);
				draw_set_alpha(1);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
				if (mouse_check_button_released(mb_left)) {
					
					obj_control.navWindowTaggingID = currentUnitID;
					obj_control.navWindowTaggingField = currentField;
								
					
					// get the tagSet for this field
					var tagSet = currentFieldSubMap[? "tagSet"];
					if (scr_isNumericAndExists(tagSet, ds_type_list)) {
					
						// create dropdown
						var dropDownOptionList = ds_list_create();
						ds_list_copy(dropDownOptionList, tagSet);
						ds_list_add(dropDownOptionList, "option_add-to-tag-set");
						ds_list_add(dropDownOptionList, "menu_clear");

						obj_control.unitToChange = currentUnitID;
						obj_control.unitFieldToChange = currentField;
						var dropDownX = colRectX1;
						var dropDownY = unitRectY2;						
						scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, global.optionListTypeUnitTagMap);

					}
				}
			}
    
		    // Draw text of unit tags
		    draw_set_halign(lineStateLTR ? fa_left : fa_right);
		    draw_set_valign(fa_middle);
		    draw_set_color(global.colorThemeText);
			scr_adaptFont(string(currentStr), "S");
			//show_debug_message(string(currentStr));
					// text coordinates
			
				
			if (lineStateLTR) {
				var textX = floor(colRectX1 + textMarginLeft);
			}
			else {
				var textX = floor(colRectX2 - textMarginLeft);
				if (drawDropDowns && mouseoverunitRect ) {
					textX = textX - dropDownButtonWidth;
				}
			}
			
			// leave room for scrollbar if we're in RTL and on the last column
			if (!lineStateLTR && i == 0) {
				textX -= global.scrollBarWidth;
			}
			

			draw_set_alpha(readOnlyField ? 0.7 : 1);
			
		    draw_text(textX - clipX, y + headerHeight + relativeScrollPlusY + textPlusY - clipY, currentStr);
			draw_set_alpha(1);
		    // Get height of chain name
		    textPlusY += strHeight;
			
		}
	 
		i++;
	}
	
	
	
	
	// draw focus outline
	/*
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	*/
	


	scr_panelPane_unitScroll(focusedElementY, strHeight);
	
	
	if (!chainViewOneToMany) {
		
		var fieldListSize = ds_list_size(obj_control.navUnitFieldList);
		scr_scrollBarHorizontal(fieldListSize, colWidth, global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		
		scr_scrollBar(displayUnitListSize, focusedElementY, strHeight, headerHeight,
		    global.colorThemeSelected1, global.colorThemeSelected2,
		    global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}
	
	scr_navWindowTaggingSelection(obj_control.navUnitFieldList, displayUnitList, "unit");
	
	if (BUILDTYPE != "Web") scr_surfaceEnd();
	
	scr_panelPane_drawUnits1To1Headers();
	

	
	






}
