function scr_panelPane_drawFieldList() {

	
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var strHeight = string_height("0") * 1.5;
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var checkboxColX = x;
	var checkboxColWidth = strHeight * 1.2;
	var checkboxSize = checkboxColWidth * 0.35;
	var checkBoxScale = (checkboxColWidth* 0.5)/checkboxColWidth;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var fieldNameColX = numColX + numColWidth;
	var fieldNameColWidth = (fieldPaneSwitchButton != fieldPaneChainMode && fieldPaneSwitchButton != fieldPaneEntryMode )? windowWidth * 0.7: windowWidth * 0.2;
	var typeColX = fieldNameColX + fieldNameColWidth;
	var typeColWidth = (fieldPaneSwitchButton != fieldPaneChainMode && fieldPaneSwitchButton != fieldPaneEntryMode )? 0:windowWidth * 0.5;
	var deleteColWidth = sprite_get_width(spr_trash) + textBuffer*1.5;
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;
	var lockColWidth = sprite_get_width(spr_lock) + textBuffer*1.5;
	var lockColX = deleteColX - lockColWidth;
	var readOnlyColWidth = sprite_get_width(spr_readOnly) + textBuffer*1.5;
	var readOnlyColX = lockColX - readOnlyColWidth;
	var focusedElementY = -1;

	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_sizeWindow);
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight) && !mouseoverCancel;
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight) && !mouseoverCancel;
	
	
	// determine which field list to use depending on 1to1 vs 1toMany and Chain vs Discourse
	var fieldList = -1;
	var fieldMap = -1;
	if (fieldPaneSwitchButton == fieldPaneTokenMode) {
		fieldList = obj_control.tokenFieldList;
		fieldMap = global.nodeMap[? "tokenTagMap"];
	}
	else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
		fieldList = obj_control.unitFieldList;
		fieldMap = global.nodeMap[? "unitTagMap"];
	}
	else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
		fieldList = global.chainEntryFieldList;
		fieldMap = global.nodeMap[? "entryTagMap"];
	}
	else if (fieldPaneSwitchButton == fieldPaneChainMode) {
		fieldList = global.chainFieldList;
		fieldMap = global.nodeMap[? "chainTagMap"];
	}
	else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
		fieldList = obj_control.chunkFieldList;
		fieldMap = global.nodeMap[? "tokenTagMap"];
	}
	else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
		fieldList = global.linkFieldList;
		fieldMap = global.nodeMap[? "linkTagMap"];
	}
	with (obj_panelPane) functionTag_fieldList = fieldList;

	
	// make sure the field list is valid
	if (scr_isNumericAndExists(fieldList, ds_type_list) && scr_isNumericAndExists(fieldMap, ds_type_map)) {

		var fieldListSize = ds_list_size(fieldList);


		scr_surfaceStart();
	
		var checkboxX1 = mean(checkboxColX, checkboxColX + checkboxColWidth) - (checkboxSize * 0.5);
		var checkboxX2 = checkboxX1 + checkboxSize;
	
		// loop down the list of fields and draw a row for each one
		var plusY = strHeight;
		for (var i = 0; i < fieldListSize+1; i++) {
			
			// don't bother drawing this stuff if it won't be on screen
			if (y + headerHeight + scrollPlusY + plusY < y - strHeight
			or y + headerHeight + scrollPlusY + plusY > y + windowHeight + strHeight) {
				plusY += strHeight;
				continue;
			}
		
		
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
			
			// make sure user doesnt delete last available token field
			if (fieldList == obj_control.tokenFieldList && ds_list_size(fieldList) <= 1) removable = false;
			

		
		
			// get y values for this row
			var currentRowY1 = y + plusY + scrollPlusY - 16;
			var currentRowY2 = currentRowY1 + strHeight;
			var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentRowY1, x + windowWidth, currentRowY2) && !mouseoverCancel && !mouseoverHeader && !mouseoverScrollBar && !scrollBarHolding;
			var textY = floor(mean(currentRowY1, currentRowY2));
		
				
			if (i < fieldListSize) {
		
				// mouseover & click
				if (mouseoverRow && mouseoverWindow) {
					draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
					draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
					if (mouse_check_button_released(mb_left)) {
						
						ds_list_clear(obj_control.selectedTagList);
				
						// set field to be selected when clicked

						if (fieldPaneSwitchButton == fieldPaneTokenMode) {
							if (functionField_tokenFieldSelected != currentField) {
								with (obj_panelPane) functionField_tokenTagSelected = "";
							}
							with (obj_panelPane) functionField_tokenFieldSelected = currentField;
						}
						else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
							if (functionField_entryFieldSelected != currentField) {
								with (obj_panelPane) functionField_entryTagSelected = "";
							}
							with (obj_panelPane) functionField_entryFieldSelected = currentField;
						}
						else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
							if (functionField_unitFieldSelected != currentField) {
								with (obj_panelPane) functionField_unitTagSelected = "";
							}
							with (obj_panelPane) functionField_unitFieldSelected = currentField;
						}
						else if (fieldPaneSwitchButton == fieldPaneChainMode) {
							if (functionField_chainFieldSelected != currentField) {
								with (obj_panelPane) functionField_chainTagSelected = "";
							}
							with (obj_panelPane) functionField_chainFieldSelected = currentField;
						}
						else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
							if (functionField_chunkFieldSelected != currentField) {
								with (obj_panelPane) functionField_chunkTagSelected = "";
							}
							with (obj_panelPane) functionField_chunkFieldSelected = currentField;
						}
						else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
							if (functionField_linkFieldSelected != currentField) {
								with (obj_panelPane) functionField_linkTagSelected = "";
							}
							with (obj_panelPane) functionField_linkFieldSelected = currentField;
						}
					}
				}
		

				// check if this field has been selected
				var fieldSelected = false;

				if (fieldPaneSwitchButton == fieldPaneTokenMode) {
					if (functionField_tokenFieldSelected == currentField) fieldSelected = true;
				}
				else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
					if (functionField_entryFieldSelected == currentField) fieldSelected = true;
				}
				else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
					if (functionField_unitFieldSelected == currentField) fieldSelected = true;
				}
				else if (fieldPaneSwitchButton == fieldPaneChainMode) {
					if (functionField_chainFieldSelected == currentField) fieldSelected = true;
				}
				else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
					if (functionField_chunkFieldSelected == currentField) fieldSelected = true;
				}
				else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
					if (functionField_linkFieldSelected == currentField) fieldSelected = true;
				}
				
			
				var textColor = fieldSelected ? global.colorThemeBG : global.colorThemeText;
			
				// draw highlight if this field is selected
				if (fieldSelected) {
					draw_set_color(global.colorThemeSelected2);
					draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
					with (obj_panelPane) functionChainList_focusedIndex = i;
					focusedElementY = textY;
				}
		
		
				/*
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
				*/
		
				// get coordinates for delete button
				var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
				var delButtonY = currentRowY1 + (strHeight * 0.5);
				var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, currentRowY1, deleteColX + deleteColWidth, currentRowY2) && !mouseoverCancel && mouseoverRow && removable;
				var trashAlpha = (removable) ? 1 : 0.5;
				
				// get coordinates for lock button
				var lockButtonX = mean(lockColX, lockColX + lockColWidth);
				var lockButtonY = currentRowY1 + (strHeight * 0.5);
				var mouseOverLock = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lockColX, currentRowY1, lockColX + lockColWidth, currentRowY2) && !mouseoverCancel && mouseoverRow;
				var fieldLocked = currentFieldSubMap[? "locked"];
				if (!is_bool(fieldLocked)) fieldLocked = false;
				
				// get coordinates for readonly button
				var readOnlyButtonX = mean(readOnlyColX, readOnlyColX + readOnlyColWidth);
				var readOnlyButtonY = currentRowY1 + (strHeight * 0.5);
				var mouseOverReadOnly = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, readOnlyColX, currentRowY1, readOnlyColX + readOnlyColWidth, currentRowY2) && !mouseoverCancel && mouseoverRow;
				var fieldReadOnly = currentFieldSubMap[? "readOnly"];
				if (!is_bool(fieldReadOnly)) fieldReadOnly = false;

								
				// mouseover & click on delete button
				if (mouseOverDel) {
					draw_set_color(global.colorThemeSelected1);
					draw_rectangle(deleteColX - clipX, currentRowY1 - clipY, deleteColX + deleteColWidth - clipX, currentRowY2 - clipY, false);
					if (mouse_check_button_released(mb_left)) {
					
					
						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							if (fieldPaneSwitchButton == fieldPaneTokenMode) obj_dialogueBox.removeFieldToken = true;
							else if (fieldPaneSwitchButton == fieldPaneUnitMode) obj_dialogueBox.removeFieldUnit = true;
							else if (fieldPaneSwitchButton == fieldPaneEntryMode) obj_dialogueBox.removeFieldEntry = true;
							else if (fieldPaneSwitchButton == fieldPaneChainMode) obj_dialogueBox.removeFieldChain = true;
							else if (fieldPaneSwitchButton == fieldPaneChunkMode) obj_dialogueBox.removeFieldChunk = true;
							else if (fieldPaneSwitchButton == fieldPaneLinkMode) obj_dialogueBox.removeFieldLink = true;
							obj_dialogueBox.questionWindowActive = true;
							obj_dialogueBox.stringToBeRemoved = currentField;
						}
					}
					scr_createTooltip(delButtonX, currentRowY2, scr_get_translation("msg_remove"), obj_tooltip.arrowFaceUp);
				}
				// mouseover & click on lock button
				else if (mouseOverLock) {
					draw_set_color(global.colorThemeSelected1);
					draw_rectangle(lockColX - clipX, currentRowY1 - clipY, lockColX + lockColWidth - clipX, currentRowY2 - clipY, false);
					if (mouse_check_button_released(mb_left)) {
						currentFieldSubMap[? "locked"] = !currentFieldSubMap[? "locked"];
					
					}
					scr_createTooltip(lockButtonX, currentRowY2, fieldLocked ? "Unlock tags" : "Lock tags", obj_tooltip.arrowFaceUp);
				}
				// mouseover & click on lock button
				else if (mouseOverReadOnly) {
					if (removable) {
						draw_set_color(global.colorThemeSelected1);
						draw_rectangle(readOnlyColX - clipX, currentRowY1 - clipY, readOnlyColX + readOnlyColWidth - clipX, currentRowY2 - clipY, false);
						if (mouse_check_button_released(mb_left)) {
							currentFieldSubMap[? "readOnly"] = !currentFieldSubMap[? "readOnly"];
					
						}
					}
					scr_createTooltip(readOnlyButtonX, currentRowY2, fieldReadOnly ? "Read Only" : "Taggable", obj_tooltip.arrowFaceUp);
				}
			

				if (mouseoverRow || fieldSelected) {
					draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
					draw_sprite_ext(spr_lock, !fieldLocked, lockButtonX - clipX, lockButtonY - clipY, .7, .7, 0, global.colorThemeText, 1);
					draw_sprite_ext(spr_readOnly, fieldReadOnly, readOnlyButtonX - clipX, readOnlyButtonY - clipY, .6, .6, 0, global.colorThemeText, 1);
				}
				if (fieldLocked) {
					draw_sprite_ext(spr_lock, !fieldLocked, lockButtonX - clipX, lockButtonY - clipY, .7, .7, 0, global.colorThemeText, 1);
				}
				if (fieldReadOnly) {
					draw_sprite_ext(spr_readOnly, fieldReadOnly, readOnlyButtonX - clipX, readOnlyButtonY - clipY, .6, .6, 0, global.colorThemeText, 1);
				}

		
				// draw #
				draw_set_color(textColor);
				draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
				// draw field name
				draw_text(floor(fieldNameColX + textBuffer) - clipX, textY - clipY, string(currentField));
				
				if (fieldPaneSwitchButton == fieldPaneChainMode || fieldPaneSwitchButton == fieldPaneEntryMode ) {
					var inRez = currentFieldSubMap[? "rez"];
					var inStack = currentFieldSubMap[? "card"];
					var inTrail = currentFieldSubMap[? "track"];
					var chainList = ds_list_create();
					if (inRez) {
						ds_list_add(chainList,"Resonance");
					}
					if (inTrail) {
						ds_list_add(chainList,"Trail");
					}
					if (inStack) {
						ds_list_add(chainList,"Stack");
					}
					// draw field name
					draw_text(floor(typeColX + textBuffer) - clipX, textY - clipY, string(scr_getStringOfList(chainList)));
					ds_list_destroy(chainList);
				}
		
			}
			else {
			
				// new tag row
				draw_set_color(merge_color(c_green, global.colorThemeBG, mouseoverRow ? 0.25 : 0.5));
				draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
			
				// mouseover & click
				if (mouseoverRow && mouseoverWindow) {
					if (mouse_check_button_released(mb_left)) {
					
						with (obj_panelPane) {
							chosenCol = -1;
						}
					
						// prompt user for name of new token field/marker
						if (fieldPaneSwitchButton == fieldPaneTokenMode) obj_control.newCustomFieldToken = true;
						else if (fieldPaneSwitchButton == fieldPaneEntryMode) obj_control.newCustomFieldEntry = true;
						else if (fieldPaneSwitchButton == fieldPaneUnitMode) obj_control.newCustomFieldUnit = true;
						else if (fieldPaneSwitchButton == fieldPaneChainMode) obj_control.newCustomFieldChain = true;
						else if (fieldPaneSwitchButton == fieldPaneChunkMode) obj_control.newCustomFieldChunk = true;
						else if (fieldPaneSwitchButton == fieldPaneLinkMode) obj_control.newCustomFieldLink = true;
						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						obj_dialogueBox.inputWindowActive = true;
						
					}
				}
	
				// draw #
				draw_set_color(global.colorThemeText);
				draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, "+");
		
				// draw field name
				draw_text(floor(fieldNameColX + textBuffer) - clipX, textY - clipY, scr_get_translation("option_new-field"));
		
			}
	
			plusY += strHeight;
		}
	
		scr_scrollBar(fieldListSize+1, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
			
		scr_panelPane_scrollSelection(focusedElementY, strHeight);
	
	
		scr_surfaceEnd();
	
	}
	
	
	
	var headerTextY = floor(mean(y, y + headerHeight));
	
	// checkbox header

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
	draw_text(floor(numColX + textBuffer), headerTextY, "#");
	
	// field name header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(fieldNameColX, y, x + windowWidth, y + headerHeight, false);

	draw_set_color(global.colorThemeText);
	draw_text(floor(fieldNameColX + textBuffer), headerTextY, scr_get_translation("option_field-name"));
	
	draw_set_color(global.colorThemeBG);
	draw_rectangle(typeColX, y, x + windowWidth, y + headerHeight, false);

	draw_set_color(global.colorThemeBorders);
	draw_rectangle(fieldNameColX, y, x + windowWidth, y + headerHeight, true);

	if (fieldPaneSwitchButton == fieldPaneChainMode || fieldPaneSwitchButton == fieldPaneEntryMode ) {
		draw_set_color(global.colorThemeText);
		draw_text(floor(typeColX + textBuffer), headerTextY, scr_get_translation("Type"));
	}
	
	
	/*
	if (mouseoverWindow && mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouseoverWindow && mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
	*/
	
		
	var optionsIconRad = sprite_get_width(spr_trash) * 0.35;
	var spaceWidth = string_width(" ");
	//json tag saving button
	var spriteSize = sprite_get_width(spr_saveIcon);
	var saveRectX2 = x + windowWidth -spaceWidth*2;
	var saveRectX1 = saveRectX2 - spriteSize;
	var saveRectY1 =  mean(y ,y + headerHeight) - spriteSize/2;
	var saveRectY2 = saveRectY1 + spriteSize;
	
	var saveSpriteX = floor(mean(saveRectX1,saveRectX2));
	var saveSpriteY = floor(mean(saveRectY1,saveRectY2)+1);
	
	var mouseOverSave = point_in_rectangle(mouse_x,mouse_y,saveRectX1,saveRectY1,saveRectX2,saveRectY2) && !mouseoverCancel;
	
	if (mouseOverSave) {
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7);
		draw_roundrect(mean(saveRectX1,saveRectX2)-optionsIconRad,mean(saveRectY1,saveRectY2)-optionsIconRad,mean(saveRectX1,saveRectX2)+optionsIconRad,mean(saveRectY1,saveRectY2)+optionsIconRad, false);
		if (device_mouse_check_button_released(0,mb_left)) {
			scr_saveTagJson();
		}
		scr_createTooltip(saveSpriteX, saveRectY2,scr_get_translation("option_save-tag-json"), obj_tooltip.arrowFaceUp);
	}
	draw_sprite_ext(spr_saveIcon,0,saveSpriteX,saveSpriteY,1,1,0,global.colorThemeText, 1);
	
	// json tag loading button
	var spriteSize = sprite_get_width(spr_loadingIcon);
	var loadRectX2 = saveRectX1 - spaceWidth*3;
	var loadRectX1 = loadRectX2 - spriteSize;
	var loadRectY1 =  mean(y ,y + headerHeight) - spriteSize/2;
	var loadRectY2 = loadRectY1 + spriteSize;
	
	var loadSpriteX = floor(mean(loadRectX1,loadRectX2));
	var loadSpriteY = floor(mean(loadRectY1,loadRectY2)+1);
	
	var mouseOverload = point_in_rectangle(mouse_x,mouse_y,loadRectX1,loadRectY1,loadRectX2,loadRectY2) && !mouseoverCancel;
	
	if (mouseOverload) {
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7)
		draw_roundrect(mean(loadRectX1,loadRectX2)-optionsIconRad,mean(loadRectY1,loadRectY2)-optionsIconRad,mean(loadRectX1,loadRectX2)+optionsIconRad,mean(loadRectY1,loadRectY2)+optionsIconRad, false);
		if (device_mouse_check_button_released(0,mb_left)) {
			if (BUILDTYPE == "Web") {
				show_message("Loading Tag JSON is currently not available for browser use.");
				exit;
			}
			scr_loadTagJson();
		}
		scr_createTooltip(loadSpriteX, loadRectY2,scr_get_translation("option_load-tag-json"), obj_tooltip.arrowFaceUp);
	}
	draw_sprite_ext(spr_loadingIcon,0,loadSpriteX,loadSpriteY,1,1,0,global.colorThemeText, 1);
	
	
	
	//selection for field pane
	var tabText = scr_get_translation(fieldPaneSwitchButton);
	var stringWidthOfTab = string_width(tabText);
	var stringHeightOfTab = string_height(tabText);
	// toggle Token / Unit / Chain / Entry / chunk / link Fields
	var moreOptionsWidth = sprite_get_width(spr_moreOptions);
	var moreOptionsX2 = floor(loadRectX1 - textBuffer);
	var moreOptionsX1 = floor(moreOptionsX2 - stringWidthOfTab);
	var moreOptionsY = headerTextY;
	var moreOptionsY1 = headerTextY - stringHeightOfTab/2;
	var moreOptionsY2 = headerTextY + stringHeightOfTab/2;

	var optionsIconRad = sprite_get_width(spr_toggleDraw) * 0.7;
	var mouseoverMoreChain = scr_pointInRectangleClippedWindow(mouse_x,mouse_y,moreOptionsX1,moreOptionsY1,moreOptionsX2,moreOptionsY2) && !mouseoverCancel;
	var mouseoverMoreChainEffect = false;
	
	if (mouseoverMoreChain) {
		mouseoverMoreChainEffect = true;		
		if (mouse_check_button_pressed(mb_left)) {
			var dropDownOptionList = ds_list_create();
			var width = 0;
			if (instance_exists(obj_dropDown)) {
			width = obj_dropDown.windowWidth
			}
			ds_list_add(dropDownOptionList, fieldPaneTokenMode,fieldPaneUnitMode,fieldPaneChainMode,fieldPaneEntryMode,fieldPaneChunkMode,fieldPaneLinkMode);
			scr_createDropDown(moreOptionsX1, moreOptionsY2, dropDownOptionList, global.optionListTypeTagPane);
		}
	}
	
	with (obj_dropDown) {
		if (optionListType == global.optionListTypeTagPane) mouseoverMoreChainEffect = true;
	}
	
	if (mouseoverMoreChainEffect) {
		draw_set_color(global.colorThemeSelected1);
		var edgebuffer = 2;
		draw_roundrect(moreOptionsX1-edgebuffer,moreOptionsY1,moreOptionsX2+edgebuffer,moreOptionsY2, false);
	}
	
	draw_set_halign(fa_left);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(moreOptionsX1, moreOptionsY, tabText);
	

}