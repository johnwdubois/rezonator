function scr_panelPane_drawFieldTags() {


	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout);
	var strHeight = string_height("0") * 1.5;
	var textBuffer = 8;
	var spaceWidth = string_width(" ");
	var headerHeight = functionTabs_tabHeight;
	var checkboxColX = x;
	var checkboxColWidth = strHeight * 1.2;
	var checkboxSize = checkboxColWidth * 0.35;
	var focusedElementY = -1;
	var numColX = checkboxColX+checkboxColWidth;
	var numColWidth = windowWidth * 0.1;
	var tagNameColX = numColX + numColWidth;
	var tagNameColWidth = windowWidth * 0.7;
	var deleteColWidth = clamp(windowWidth * 0.15, sprite_get_width(spr_trash), sprite_get_width(spr_trash) * 2);
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	var checkboxX1 = mean(checkboxColX, checkboxColX + checkboxColWidth) - (checkboxSize * 0.5);
	var checkboxX2 = checkboxX1 + checkboxSize;
	var checkmarkScale = max(global.fontSize,3)/5;
	var valid = true;
	var allTagsSelected = false;
	var tagList = -1;



	scr_surfaceStart();
	
	var fieldSubMap = -1;
	if (fieldPaneSwitchButton == fieldPaneChainMode) {
		// get submap for selected field
		fieldSubMap = global.chainFieldMap[? functionField_chainFieldSelected];
		if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {valid = false;}
	}
	else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
		// get submap for selected field
		fieldSubMap = global.entryFieldMap[? functionField_entryFieldSelected];

		if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {valid = false;}
	}
	
	else if (fieldPaneSwitchButton == fieldPaneTokenMode) {
		var tokenTagMap = global.nodeMap[? "tokenTagMap"];
		if (scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
			fieldSubMap = tokenTagMap[? functionField_tokenFieldSelected];
		}
		else{
			valid = false;
		}
	}
	else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
		var unitTagMap = global.nodeMap[? "unitTagMap"];
		if (scr_isNumericAndExists(unitTagMap, ds_type_map)) {
			fieldSubMap = unitTagMap[? functionField_unitFieldSelected];
		}
		else{
			valid = false;
		}
		
	}
	
	else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
			var tokenTagMap = global.nodeMap[? "tokenTagMap"];
			if (scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
				fieldSubMap = tokenTagMap[? functionField_chunkFieldSelected];
			}
			else{
				valid = false;
			}
	}

	else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
			var linkTagMap = global.nodeMap[? "linkTagMap"];
			if (scr_isNumericAndExists(linkTagMap, ds_type_map)) {
				fieldSubMap = linkTagMap[? functionField_linkFieldSelected];
			}
			else{
				valid = false;
			}
	}
	
	if (valid) {
		if (scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
	
	
			tagList = fieldSubMap[? "tagSet"];
			if (scr_isNumericAndExists(tagList, ds_type_list)) {
				with (obj_panelPane) functionTag_tagList = tagList;
				var tagListSize = ds_list_size(tagList);
				if (tagListSize > 0 && tagListSize == ds_list_size(obj_control.selectedTagList)) allTagsSelected = true;
	
			
				var plusY = strHeight;
				for (var i = 0; i < tagListSize+2; i++) {
					
					// don't bother drawing this stuff if it won't be on screen
					if (y + headerHeight + scrollPlusY + plusY < y - strHeight
					or y + headerHeight + scrollPlusY + plusY > y + windowHeight + strHeight) {
						plusY += strHeight;
						continue;
					}
		

					var currentRowY1 = y + plusY + scrollPlusY - 16;
					var currentRowY2 = currentRowY1 + strHeight;
					var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentRowY1, x + windowWidth, currentRowY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader && !mouseoverScrollBar && !scrollBarHolding;
					var textY = floor(mean(currentRowY1, currentRowY2));

						
					if (i < tagListSize) {
						
					var currentTag = tagList[| i];
				
						// mouseover & click
						if (mouseoverRow) {
							draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								if (fieldPaneSwitchButton == fieldPaneTokenMode) {
									with(obj_panelPane) {
										functionField_tokenTagSelected = currentTag;
									}
								}
								else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
									with(obj_panelPane) {
										functionField_unitTagSelected = currentTag;
									}
								}
								else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
										with(obj_panelPane) functionField_entryTagSelected = currentTag;
								}
								else if (fieldPaneSwitchButton == fieldPaneChainMode) {
										with(obj_panelPane)	functionField_chainTagSelected = currentTag;
								}
								else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
									with(obj_panelPane)	functionField_chunkTagSelected = currentTag;
								}
								else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
									with(obj_panelPane)	functionField_linkTagSelected = currentTag;
								}
							}
						}
		
						//check if this row/field has been selected
						var tagSelected = false;
		
					
						if (fieldPaneSwitchButton == fieldPaneTokenMode) {
							if (functionField_tokenTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
						else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
							if (functionField_unitTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}		
						}
					
						else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
							if (functionField_entryTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
						else if (fieldPaneSwitchButton == fieldPaneChainMode) {
							if (functionField_chainTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
					
						else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
							if (functionField_chunkTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
					
						else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
							if (functionField_linkTagSelected == currentTag) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
						
						if (tagSelected) {
							with (obj_panelPane) functionChainList_focusedIndex = i;
							focusedElementY = textY;
						}
						var textColor = tagSelected ? global.colorThemeBG : global.colorThemeText;
				
						var isSelected = (ds_list_find_index(obj_control.selectedTagList,currentTag) >= 0);
						
						// draw checkbox
						var checkboxY1 = mean(currentRowY1, currentRowY2) - (checkboxSize * 0.5);
						var checkboxY2 = checkboxY1 + checkboxSize;
						if (isSelected) {
							draw_set_color(global.colorThemeBG);
							draw_rectangle(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, false);
							draw_sprite_ext(spr_checkmark, 0, mean(checkboxX1, checkboxX2) - clipX, mean(checkboxY1, checkboxY2) - clipY, checkmarkScale, checkmarkScale, 0, global.colorThemeText, 1);
						}
						draw_set_color(global.colorThemeBorders);
						scr_drawRectWidth(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, 2, false);
						
						var mouseoverCheckBox = scr_pointInRectangleClippedWindow(mouse_x,mouse_y,checkboxX1,checkboxY1,checkboxX2,checkboxY2);
						
						if (mouseoverCheckBox) {
							scr_createTooltip(mean(checkboxX1, checkboxX2), checkboxY2, scr_get_translation("option_select"), obj_tooltip.arrowFaceUp);
							if (mouse_check_button_released(mb_left)) {
								isSelected = !isSelected;
								if (isSelected) {
									scr_addToListOnce(obj_control.selectedTagList, currentTag);
								}
								else {
									scr_deleteFromList(obj_control.selectedTagList, currentTag);
								}
							}
						}

						
						var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
						var delButtonY = currentRowY1 + (strHeight * 0.5);
						var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, currentRowY1, deleteColX + deleteColWidth, currentRowY2) && mouseoverRow;
						var trashAlpha = .5;

								
						// mouseover & click on sequence arrows
						if (mouseOverDel) {
							draw_set_color(global.colorThemeSelected1);
							draw_rectangle(deleteColX - clipX, currentRowY1 - clipY, deleteColX + deleteColWidth - clipX, currentRowY2 - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								
								if (fieldPaneSwitchButton == fieldPaneTokenMode) {
									obj_control.tokenFieldToChange = functionField_tokenFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "unit", "1toMany", currentTag);
								}
								
								else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
									obj_control.unitFieldToChange = functionField_unitFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "unit", "1to1", currentTag);
									
								}
								
								else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
									obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "chain", "1toMany", currentTag);
								}
								
								else if (fieldPaneSwitchButton == fieldPaneChainMode) {
									obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "chain", "1to1", currentTag);	
								}

								else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
									obj_control.tokenFieldToChange = functionField_chunkFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "chunk", chainViewOneToMany ? "1toMany" : "1to1", currentTag);
								}
							
								else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
									obj_control.tokenFieldToChange = functionField_linkFieldSelected;
									scr_removeFieldTagQuestionPrompt("tag", "link", chainViewOneToMany ? "1toMany" : "1to1", currentTag);
								}

							}
							scr_createTooltip(delButtonX, currentRowY2, scr_get_translation("msg_remove"), obj_tooltip.arrowFaceUp);
						}
									
						trashAlpha = 1;

						if (mouseoverRow || tagSelected) {		
							draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
						}
		
		
						// draw #
						draw_set_color(textColor);
						draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
						// draw field name
						draw_text(floor(tagNameColX + textBuffer) - clipX, textY - clipY, string(currentTag));
					}
					else{
						if (i == tagListSize+1) {
							// new tag row
							draw_set_color(merge_color(c_green, global.colorThemeBG, mouseoverRow ? 0.25 : 0.5));
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
					
							// mouseover & click
							if (mouseoverRow) {
								if (mouse_check_button_released(mb_left)) {
									if (fieldPaneSwitchButton == fieldPaneTokenMode) {

											obj_control.newCustomTagToken = true;
											obj_control.dialogueBoxActive = true;
											obj_control.tokenFieldToChange = functionField_tokenFieldSelected;

											if (!instance_exists(obj_dialogueBox)) {
												instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
											}
											obj_dialogueBox.inputWindowActive = true;
									}
									else if (fieldPaneSwitchButton == fieldPaneUnitMode) {

											obj_control.newCustomTagUnit = true;
											obj_control.dialogueBoxActive = true;
											obj_control.unitFieldToChange = functionField_unitFieldSelected;
								
											if (!instance_exists(obj_dialogueBox)) {
												instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
											}
											obj_dialogueBox.inputWindowActive = true;

									}
									else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
								
											obj_control.newCustomTagEntry = true;
											obj_control.dialogueBoxActive = true;
											obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;

											if (!instance_exists(obj_dialogueBox)) {
												instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
											}
											obj_dialogueBox.inputWindowActive = true;

									}
									else if (fieldPaneSwitchButton == fieldPaneChainMode) {
									
											obj_control.newCustomTagChain = true;
											obj_control.dialogueBoxActive = true;
											obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
								
											if (!instance_exists(obj_dialogueBox)) {
												instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
											}
											obj_dialogueBox.inputWindowActive = true;
									}
									else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
								
										obj_control.newCustomTagChunk = true;
										obj_control.dialogueBoxActive = true;
										obj_control.tokenFieldToChange = functionField_chunkFieldSelected;
								
										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
								
									}
									else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
								
										obj_control.newCustomTagLink = true;
										obj_control.dialogueBoxActive = true;
										obj_control.tokenFieldToChange = functionField_linkFieldSelected;
								
										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
								
									}
								}
							}
							// add new tag
							// draw #
							draw_set_color(global.colorThemeText);
							draw_text(floor(numColX + textBuffer) - clipX, textY - clipY,"+");
					
							draw_text(floor(tagNameColX + textBuffer) - clipX, textY - clipY, scr_get_translation("option_new-tag"));
						}
						else{
							if (mouseoverRow) {
								if (mouse_check_button_released(mb_left)) {
									if (fieldPaneSwitchButton == fieldPaneTokenMode) {
										with(obj_panelPane) {
											functionField_tokenTagSelected = scr_get_translation("menu_clear");
										}
									}
									else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
										with(obj_panelPane) {
											functionField_unitTagSelected = scr_get_translation("menu_clear");
										}
									}
									else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
											with(obj_panelPane) functionField_entryTagSelected = scr_get_translation("menu_clear");
									}
									else if (fieldPaneSwitchButton == fieldPaneChainMode) {
											with(obj_panelPane)	functionField_chainTagSelected = scr_get_translation("menu_clear");
									}
									else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
										with(obj_panelPane)	functionField_chunkTagSelected = scr_get_translation("menu_clear");
									}
									else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
										with(obj_panelPane)	functionField_linkTagSelected = scr_get_translation("menu_clear");
									}
								}
							}
							
							var isClearSelected = false;
								if (fieldPaneSwitchButton == fieldPaneTokenMode) {
									with(obj_panelPane) isClearSelected = (functionField_tokenTagSelected == scr_get_translation("menu_clear"));
								}
								else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
									with(obj_panelPane) isClearSelected = (functionField_unitTagSelected == scr_get_translation("menu_clear"));
								}
								else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
										with(obj_panelPane) isClearSelected = (functionField_entryTagSelected == scr_get_translation("menu_clear"));
								}
								else if (fieldPaneSwitchButton == fieldPaneChainMode) {
										with(obj_panelPane)	isClearSelected = (functionField_chainTagSelected == scr_get_translation("menu_clear"));
								}
								else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
									with(obj_panelPane)	isClearSelected = (functionField_chunkTagSelected == scr_get_translation("menu_clear"));
								}
								else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
									with(obj_panelPane)	isClearSelected = (functionField_linkTagSelected == scr_get_translation("menu_clear"));
								}
							// clear Tag
							draw_set_color(merge_color(c_red, global.colorThemeBG, (mouseoverRow || isClearSelected) ? 0.25 : 0.5));
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							draw_set_color(global.colorThemeText);
							draw_text(floor(tagNameColX + textBuffer) - clipX, textY - clipY, scr_get_translation("menu_clear"));
						}
					}
	
					plusY += strHeight;
				}

	
	
				scr_scrollBar(tagListSize+1, -1, strHeight, headerHeight,
						global.colorThemeSelected1, global.colorThemeSelected2,
						global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
				scr_panelPane_scrollSelection(focusedElementY, strHeight);
			}
		}
	}
	scr_surfaceEnd();
	
	
	
	
	
	var headerTextY = floor(mean(y, y + headerHeight));
	
	// checkbox header
	draw_set_halign(fa_left);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	var checkboxY1 = mean(y,  y + headerHeight) - (checkboxSize * 0.5);
	var checkboxY2 = checkboxY1 + checkboxSize;
	var mouseoverCheckboxHeader = point_in_rectangle(mouse_x, mouse_y, checkboxX1, checkboxY1, checkboxX2, checkboxY2);
	if (mouseoverCheckboxHeader) {
		if (mouse_check_button_released(mb_left)) {
			if (allTagsSelected) {
				ds_list_clear(obj_control.selectedTagList);
			}
			else {
				if (scr_isNumericAndExists(tagList, ds_type_list)) {
					ds_list_copy(obj_control.selectedTagList, tagList);
				}
			}
		}
	}
	if (allTagsSelected) {
		draw_set_color(global.colorThemeBG);
		draw_rectangle(checkboxX1, checkboxY1, checkboxX2, checkboxY2, false);
		draw_sprite_ext(spr_checkmark, 0, mean(checkboxX1, checkboxX2), mean(checkboxY1, checkboxY2), checkmarkScale, checkmarkScale, 0, global.colorThemeText, 1);
	}
	draw_set_color(global.colorThemeBorders);
	scr_drawRectWidth(checkboxX1, checkboxY1, checkboxX2, checkboxY2, 2, false);
	

	
	// num header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(numColX + textBuffer), headerTextY, "#");
	
	// field name header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(tagNameColX, y, x + windowWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tagNameColX, y, x + windowWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(tagNameColX + textBuffer), headerTextY, scr_get_translation("option_tag-name"));
	var optionsIconRad = sprite_get_width(spr_trash) * 0.35;

	var deleteOptionsX = x + windowWidth - spaceWidth*5;
	var deleteOptionsY = mean(y ,y + headerHeight);
	var selectedListSize = ds_list_size(obj_control.selectedTagList);
	var deleteOptionsClickable = (selectedListSize >= 1);
	var mouseoverDeleteOptions = point_in_circle(mouse_x, mouse_y, deleteOptionsX, deleteOptionsY, optionsIconRad) && deleteOptionsClickable && !mouseoverCancel;

	if (mouseoverDeleteOptions) {
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7)
		draw_roundrect(deleteOptionsX-optionsIconRad, deleteOptionsY-optionsIconRad,deleteOptionsX+optionsIconRad,deleteOptionsY+optionsIconRad, false);
		scr_createTooltip(deleteOptionsX, deleteOptionsY + optionsIconRad, "Remove Tags", obj_tooltip.arrowFaceUp);
		
		if (mouse_check_button_pressed(mb_left)) {
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.removeTags = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		}
	}
	
	var deleteOptionsAlpha = (deleteOptionsClickable) ? 0.8 : 0.4;
	draw_sprite_ext(spr_trash, 0, deleteOptionsX, deleteOptionsY, .7, .7, 0, c_black, deleteOptionsAlpha);
	draw_set_alpha(1);
	
	

	
}