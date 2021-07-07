// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawFieldList(){

	
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var strHeight = string_height("0") * 1.5;
	var spaceWidth = string_width(" ");
	var headerHeight = functionTabs_tabHeight;
	var checkboxColX = x;
	var checkboxColWidth = strHeight * 1.2;
	var checkboxSize = checkboxColWidth * 0.35;
	var checkBoxScale = (checkboxColWidth* 0.5)/checkboxColWidth;
	var numColX = checkboxColX + checkboxColWidth;
	var numColWidth = windowWidth * 0.1;
	var fieldNameColX = numColX + numColWidth;
	var fieldNameColWidth = windowWidth * 0.7;
	var deleteColWidth = clamp(windowWidth * 0.15, sprite_get_width(spr_trash), sprite_get_width(spr_trash) * 2);
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;

	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	// determine which field list to use depending on 1to1 vs 1toMany and Chain vs Discourse
	var fieldList = -1;
	var fieldMap = -1;
	if (chainViewOneToMany && fieldPaneSwitchButton == "Doc") {
		fieldList = obj_control.tokenFieldList;
		fieldMap = global.nodeMap[? "tokenTagMap"];
	}
	else if (!chainViewOneToMany && fieldPaneSwitchButton == "Doc") {
		fieldList = obj_control.unitFieldList;
		fieldMap = global.nodeMap[? "unitTagMap"];
	}
	else if (chainViewOneToMany && fieldPaneSwitchButton == "Chain") {
		fieldList = global.chainEntryFieldList;
		fieldMap = global.entryFieldMap;
	}
	else if (!chainViewOneToMany && fieldPaneSwitchButton == "Chain") {
		fieldList = global.chainFieldList;
		fieldMap = global.chainFieldMap;
	}

	
	// make sure the field list is valid
	if (!scr_isNumericAndExists(fieldList, ds_type_list)) exit;
	var fieldListSize = ds_list_size(fieldList);
	
	scr_surfaceStart();
	
	var checkboxX1 = mean(checkboxColX, checkboxColX + checkboxColWidth) - (checkboxSize * 0.5);
	var checkboxX2 = checkboxX1 + checkboxSize;
	
	// loop down the list of fields and draw a row for each one
	var plusY = strHeight;
	for (var i = 0; i < fieldListSize+1; i++) {
		
		// get current field from list
		var currentField = "";
		var removable = false;
		if (i < fieldListSize) {
			currentField = fieldList[| i];
			var currentFieldSubMap = fieldMap[? currentField];
			if (scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) {
				var currentTagSet = currentFieldSubMap[? "tagSet"];
				if (scr_isNumericAndExists(currentTagSet, ds_type_list)) {
					removable = true;
				}
			}
		}
		
		
		
		// get y values for this row
		var currentRowY1 = y + plusY + scrollPlusY - 16;
		var currentRowY2 = currentRowY1 + strHeight;
		var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentRowY1, x + windowWidth, currentRowY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader && !mouseoverScrollBar && !scrollBarHolding;
		
				
		if (i < fieldListSize) {
		
			// mouseover & click
			if (mouseoverRow && mouseoverWindow) {
				draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
				draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
				if (mouse_check_button_released(mb_left)) {
				
					// set field to be selected when clicked
					if (chainViewOneToMany) {
						if (fieldPaneSwitchButton == "Doc") {
							if (functionField_tokenFieldSelected != currentField) {
								with(obj_panelPane) functionField_tokenTagSelected = "";
							}
							with(obj_panelPane) functionField_tokenFieldSelected = currentField;
						}
						else {
							if(functionField_entryFieldSelected != currentField){
								with(obj_panelPane) functionField_entryTagSelected = "";
							}
							with(obj_panelPane) functionField_entryFieldSelected = currentField;
						}
					}
					else {
						if (fieldPaneSwitchButton == "Doc") {
							if (functionField_unitFieldSelected != currentField) {
								with(obj_panelPane) functionField_unitTagSelected = "";
							}
							with(obj_panelPane) functionField_unitFieldSelected = currentField;
						}
						else {
							if(functionField_chainFieldSelected != currentField){
								with(obj_panelPane) functionField_chainTagSelected = "";
							}
							with(obj_panelPane) functionField_chainFieldSelected = currentField;
						}
					}
				}
			}
		

			// check if this field has been selected
			var fieldSelected = false;
			if (chainViewOneToMany) {
				if (fieldPaneSwitchButton == "Doc") {
					if (functionField_tokenFieldSelected == currentField) fieldSelected = true;
				}
				else {
					if (functionField_entryFieldSelected == currentField) fieldSelected = true;
				}
			}
			else {
				if (fieldPaneSwitchButton == "Doc") {
					if (functionField_unitFieldSelected == currentField) fieldSelected = true;
				}
				else {
					if (functionField_chainFieldSelected == currentField) fieldSelected = true;
				}
			}
			
			var textColor = fieldSelected ? global.colorThemeBG : global.colorThemeText;
			
			// draw highlight if this field is selected
			if (fieldSelected) {
				draw_set_color(global.colorThemeSelected2);
				draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
			}
		
		
		
			// draw checkbox
			var checkboxY1 = mean(currentRowY1, currentRowY2) - (checkboxSize * 0.5);
			var checkboxY2 = checkboxY1 + checkboxSize;
			if (fieldSelected) {
				draw_set_color(global.colorThemeBG);
				draw_rectangle(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, false);
				draw_sprite_ext(spr_checkmark, 0, mean(checkboxX1, checkboxX2) - clipX, mean(checkboxY1, checkboxY2) - clipY, checkBoxScale, checkBoxScale, 0, global.colorThemeText, 1);
			}
			draw_set_color(global.colorThemeBorders);
			scr_drawRectWidth(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, 2, false);
		
		
			// get coordinates for delete button
			var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
			var delButtonY = currentRowY1 + (strHeight * 0.5);
			var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, currentRowY1, deleteColX + deleteColWidth, currentRowY2) && mouseoverRow && removable;
			var trashAlpha = (removable) ? 1 : 0.5;

								
			// mouseover & click on sequence arrows
			if (mouseOverDel) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(deleteColX - clipX, currentRowY1 - clipY, deleteColX + deleteColWidth - clipX, currentRowY2 - clipY, false);
				if (mouse_check_button_released(mb_left)) {
					
					
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						if (chainViewOneToMany && fieldPaneSwitchButton == "Doc") obj_dialogueBox.removeFieldToken = true;
						else if (!chainViewOneToMany && fieldPaneSwitchButton == "Doc") obj_dialogueBox.removeFieldUnit = true;
						else if (chainViewOneToMany && fieldPaneSwitchButton == "Chain") obj_dialogueBox.removeFieldEntry = true;
						else if (!chainViewOneToMany && fieldPaneSwitchButton == "Chain") obj_dialogueBox.removeFieldChain = true;
						obj_dialogueBox.questionWindowActive = true;
						obj_dialogueBox.stringToBeRemoved = currentField;
					}

					
				}
				
				scr_createTooltip(delButtonX, currentRowY2, "Remove", obj_tooltip.arrowFaceUp);
			}
			

								
			draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
			
		
			// draw #
			draw_set_color(textColor);
			draw_text(floor(numColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, string(i + 1));
		
			// draw field name
			draw_text(floor(fieldNameColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, string(currentField));
		
		}
		else{
			
			// new tag row
			draw_set_color(merge_color(c_green, global.colorThemeBG, mouseoverRow ? 0.25 : 0.5));
			draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
			
			// mouseover & click
			if (mouseoverRow && mouseoverWindow) {
				if (mouse_check_button_released(mb_left)) {
					
					with (obj_panelPane) {
						chosenCol = -1;
					}
					
					if (chainViewOneToMany) {
						
						// prompt user for name of new token field/marker
						if (fieldPaneSwitchButton == "Doc") obj_control.newCustomFieldToken = true;
						else obj_control.newCustomFieldEntry = true;
						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						obj_dialogueBox.inputWindowActive = true;
					}
					else {
					
						// prompt user for name of new token field/marker
						if (fieldPaneSwitchButton == "Doc") obj_control.newCustomFieldUnit = true;
						else obj_control.newCustomFieldChain = true;
						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						obj_dialogueBox.inputWindowActive = true;
					}	
				}
			}
	
			// draw #
			draw_set_color(global.colorThemeText);
			draw_text(floor(numColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, "+");
		
			// draw field name
			draw_text(floor(fieldNameColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, "New Field");
		
		}
	
		plusY += strHeight;
	}
	
	scr_scrollBar(fieldListSize+1, -1, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	
	scr_surfaceEnd();
	
	
	
	
	
	var headerTextY = floor(mean(y, y + headerHeight));
	
	// checkbox header
	draw_set_halign(fa_left);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	
	// num header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(numColX + spaceWidth), headerTextY, "#");
	
	// field name header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(fieldNameColX, y, x + windowWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(fieldNameColX, y, x + windowWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(fieldNameColX + spaceWidth), headerTextY, "Field name");
	
	
	
	
	if (mouseoverWindow && mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouseoverWindow && mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
	
	

}