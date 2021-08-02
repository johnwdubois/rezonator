function scr_panelPane_drawUnits1to1() {

	scr_surfaceStart();
	
	
	// Access the lineList panelPane object to get it's scrollPlusY

	var lineListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			lineListPanelPaneInst = self.id;
		}
	}



	var strHeight = string_height("0") * 1.5;
	var drawScrollbar = !chainViewOneToMany;
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : lineListPanelPaneInst.scrollPlusY;
	

	// Set text margin area
	var textMarginLeft = 8;

	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	
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
		
		var colWidth = windowWidth / headerListSize;
	    var colRectX1 = (lineStateLTR)? x + (colWidth * i) : x + windowWidth - (colWidth * (i+1));
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + colWidth;
	    var colRectY2 = colRectY1 + headerHeight;


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
		    var unitRectX1 = x;
		    var unitRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
		    var unitRectX2 = x + windowWidth;
		    var unitRectY2 = unitRectY1 + strHeight;
			var mouseoverunitRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, unitRectX1, max(unitRectY1, y + headerHeight), unitRectX2, unitRectY2) && !mouseoverScrollBar;
    
			// highlight rect
			draw_set_color(global.colorThemeBG);
			draw_rectangle(colRectX1 - clipX, unitRectY1 - clipY, colRectX2 - clipX, unitRectY2 - clipY, false);
				
			
	
		    //Check mouse clicks to focus a line in the list
		    if (mouseoverunitRect && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
				drawDropDowns = true;
				with (obj_panelPane) {
					unitTagsHighlightRow = j;
				}
        
		        if (device_mouse_check_button_released(0, mb_left)) {
		            with (obj_panelPane) {
						functionChainList_focusedUnitIndex = j;
						functionChainList_focusedUnit = currentUnitID;
		            }
					if (obj_control.doubleClickTimer > 2) {
						// scroll to focused unit if the user double clicks
						scr_jumpToUnit(currentUnitID);
					}
					else {
						obj_control.doubleClickTimer = 0;
					}
		        }
		    }
			
			if (unitTagsHighlightRow == j) {
				
				// highlight rect
				draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.4));
				draw_rectangle(colRectX1 - clipX, unitRectY1 - clipY, colRectX2 - clipX, unitRectY2 - clipY, false);
				
			
				// dropdown buttons
				var dropDownButtonX1 = colRectX2 - sprite_get_width(spr_dropDown) - 4;
				if (lineStateLTR){
					if(i == headerListSize - 1) dropDownButtonX1 -= global.scrollBarWidth;
				}
				else {
					if(i == 0) dropDownButtonX1 -= global.scrollBarWidth;
				}
				var dropDownButtonY1 = unitRectY1;
				var dropDownButtonX2 = dropDownButtonX1 + sprite_get_width(spr_dropDown);
				var dropDownButtonY2 = unitRectY2;
				var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
					
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
				if (mouseoverDropDownButton) {
					scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change tag", obj_tooltip.arrowFaceUp);
					draw_set_alpha(1);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
					if (mouse_check_button_released(mb_left)) {
								
						// get submap for this field
						var unitTagMap = global.nodeMap[? "unitTagMap"];
						var fieldSubMap = unitTagMap[? currentField];
					
						// get the tagSet for this field
						var tagSet = fieldSubMap[? "tagSet"];
						if (scr_isNumericAndExists(tagSet, ds_type_list)) {
					
							// create dropdown
							var dropDownOptionList = ds_list_create();
							ds_list_copy(dropDownOptionList, tagSet);
							ds_list_insert(dropDownOptionList, 0, "Add to tag set");

							obj_control.unitToChange = currentUnitID;
							obj_control.unitFieldToChange = currentField;
							var dropDownX = colRectX1;
							var dropDownY = unitRectY2;						
							scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, global.optionListTypeUnitTagMap);

						}
					}
				}
			}
			draw_set_alpha(1);

	
	
    
		    // Outline the rectangle in black
		    if (functionChainList_focusedUnitIndex == j) {
		        focusedRowRectY1 = unitRectY1;
		        focusedRowRectY2 = unitRectY2;
		        focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
		    }
			//draw cell
			draw_set_color(global.colorThemeBG);
			draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
		

    
		    // Draw text of unit tags
		    draw_set_halign(lineStateLTR ? fa_left : fa_right);
		    draw_set_valign(fa_middle);
		    draw_set_color(global.colorThemeText);
			scr_adaptFont(string(currentStr), "S");
			//show_debug_message(string(currentStr));
					// text coordinates
			
				
			if(lineStateLTR){
				var textX = floor(colRectX1 + textMarginLeft);
			}
			else{
				var textX = floor(colRectX2 - textMarginLeft);
				if(drawDropDowns && mouseoverunitRect ){
					textX = textX - dropDownButtonWidth;
				}
			}
			
			// leave room for scrollbar if we're in RTL and on the last column
			if (!lineStateLTR && i == 0) {
				textX -= global.scrollBarWidth;
			}
			
			
		    draw_text(textX - clipX, y + headerHeight + relativeScrollPlusY + textPlusY - clipY, currentStr);
    
		    // Get height of chain name
		    textPlusY += strHeight;
			
		}
	 
		i++;
	}
	
	
	
	
	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	


	scr_panelPane_unitScroll(focusedElementY, strHeight);
	
	
	if (!chainViewOneToMany) {
		scr_scrollBar(displayUnitListSize, focusedElementY, strHeight, headerHeight,
		    global.colorThemeSelected1, global.colorThemeSelected2,
		    global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}
	
	scr_surfaceEnd();
	
	scr_panelPane_drawUnits1To1Headers();
	
	






}
