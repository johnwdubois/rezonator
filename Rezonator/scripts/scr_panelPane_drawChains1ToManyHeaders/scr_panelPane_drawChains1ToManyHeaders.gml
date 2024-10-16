function scr_panelPane_drawChains1ToManyHeaders() {
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	var camWidth = camera_get_view_width(view_camera[0]);
	var mouseoverCancel = !point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight) || instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_sizeWindow);
	
	var sortArrowScale = 0.4;
	if (camWidth > 2000) {sortArrowScale *= 1.25;}
	var tabHeight = functionTabs_tabHeight;
	var chain1toManyColFieldList = -1;
	var chainType = "";
	var entryType = "";
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_RESONANCE) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
				chainType ="resonance";
				entryType = "rez";
			}
			else if (functionChainList_currentTab == NAVTAB_TRACK) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
				chainType ="trail";
				entryType = "track";
			}
			else if (functionChainList_currentTab == NAVTAB_STACK) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
				chainType ="stack";
				entryType = "card";
			}
		}
	}
	
	if (BUILDTYPE != "Web") scr_surfaceStart();
	
	if (scr_isNumericAndExists(chain1toManyColFieldList, ds_type_list)) {
		
		// draw headers for chainContents columns
		var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
		var colAmount = 4 + chainContents1toManyFieldListSize;
		var colWidth = windowWidth / chain1toMColAmount;
		var i = 0;
		
		repeat(colAmount) {
			
			// get coordinates for header rect
			var headerRectX1 = x + (colWidth * i) + scrollHorPlusX;
			var headerRectY1 = y;
			var headerRectX2 = headerRectX1 + colWidth;
			if (colAmount == 4 && i == 3) {
				var headerRectX2 = headerRectX1 + (windowWidth);	
			}
			var headerRectY2 = headerRectY1 + tabHeight;
			
			var sortArrowX = headerRectX2 - sprite_get_width(spr_linkArrow)*sortArrowScale;
			var sortArrowY = floor(mean(headerRectY1, headerRectY2));
			var mouseoverSortArrow = point_in_circle(mouse_x, mouse_y, sortArrowX, sortArrowY, sprite_get_width(spr_linkArrow) * 0.5) && !mouseoverCancel;
			
			var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !mouseoverSortArrow && !mouseoverCancel;
			
			// get coordinates for header text
			var headerTextX = floor(headerRectX1 + textMarginLeft);
			if (!lineStateLTR) {
				draw_set_halign(fa_right);
				headerTextX = headerRectX2 - (textMarginLeft)
			}
			var headerTextY = floor(y + (tabHeight / 2));
	
			// get header string for static columns
			var colName = "";
			switch (i) {
				case 0:
					if (functionChainList_currentTab == NAVTAB_RESONANCE) colName = "RezSeq";
					else if (functionChainList_currentTab == NAVTAB_TRACK) colName = "TrailSeq";
					else if (functionChainList_currentTab == NAVTAB_STACK) colName = "StackSeq";
					break;
				case 1:
					colName = "UnitSeq";
					break;
				case 2:
					if (functionChainList_currentTab == NAVTAB_STACK) {
						colName = scr_get_translation("participant"); // stacks
					}
					else {
						colName = "TokenOrder"; // rez & track
					}
					break;
				case 3:
					if (functionChainList_currentTab == NAVTAB_STACK) {
						colName = scr_get_translation("menu_utterance"); // stacks
					}
					else {
						colName = scr_get_translation("tag_text"); // rez & track
					}
					break;
				default:
					colName = "N/A";
					break;
			}
		
		
			// make headers not overlap with each other
			draw_set_color(global.colorThemeBG);
			draw_rectangle(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX2 - clipX, headerRectY1 + tabHeight - clipY, false);
			
			// draw sort arrow
			if (mouseoverColHeader || mouseoverSortArrow || obj_control.chain1toManyCustomSortColIndex == i) {
				if (mouseoverSortArrow) {
					scr_createTooltip(sortArrowX, sortArrowY + (sprite_get_height(spr_linkArrow) * 0.25), scr_get_translation("option_sort"), TOOLTIP_DIR_UP);
					sortArrowScale *= 1.25;
					if (mouse_check_button_released(mb_left)) {
						if (obj_control.chain1toManyCustomSortColIndex == -1) {
							obj_control.chain1toManyCustomSortColIndex = i;
							obj_control.chain1toManyCustomSortAsc = true;
						}
						else {
							if (obj_control.chain1toManyCustomSortColIndex == i) {
								if (obj_control.chain1toManyCustomSortAsc) {
									obj_control.chain1toManyCustomSortAsc = false;
								}
								else {
									obj_control.chain1toManyCustomSortColIndex = -1;
								}
							}
							else {
								obj_control.chain1toManyCustomSortColIndex = i;
							}
						}
						
						if (obj_control.chain1toManyCustomSortColIndex != -1) obj_control.refreshCustomSort = true;
					}
				}
				var sortArrowAngle = 0;
				if (obj_control.chain1toManyCustomSortColIndex == i) {
					sortArrowAngle = obj_control.chain1toManyCustomSortAsc ? 270 : 90;
				}
				draw_sprite_ext(spr_linkArrow, 0, sortArrowX - clipX, sortArrowY - clipY, sortArrowScale, sortArrowScale, sortArrowAngle, mouseoverSortArrow && mouse_check_button(mb_left) ? global.colorThemeSelected2 : global.colorThemeText, 1);
			}
			
		
		
		
			// headers for dynamic columns
			if (i >= 4) {
				var currentField = ds_list_find_value(chain1toManyColFieldList, i - 4);
				if (is_string(currentField)) {
					colName = currentField;
				}
				else {
					currentField = string(currentField);
				}

				if (mouseoverColHeader) {
					scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, scr_get_translation("msg_change_field"), TOOLTIP_DIR_UP);
					
					// draw underline
					var underlineX1 = headerTextX;
					if (lineStateLTR) {
						var underlineX2 = headerTextX + string_width(currentField);
					}
					else {
						var underlineX2 = headerTextX - string_width(currentField);
					}
					var underlineY = headerTextY + (tabHeight * 0.25);
					draw_set_color(global.colorThemeBorders);
					draw_line_width(underlineX1 - clipX, underlineY - clipY, underlineX2 - clipX, underlineY - clipY, 2);
					
					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) {
							fieldChains1ToManyChainType = chainType;
							chosenCol = i - 4;
						}
						obj_control.chain1toManyEntryToChange = "";
						obj_control.chain1ToManyColFieldToChange = i - 4;
						obj_control.chain1toManyFieldToChange = currentField;
						
						// check if all the fields that apply to this chainType are in the navFieldList
						var allFieldsInNav = true;
						var entryFieldListSize = ds_list_size(global.chainEntryFieldList);
						for (var i = 0; i < entryFieldListSize; i++) {
							var currentEntryField = global.chainEntryFieldList[| i];
							var currentEntryFieldSubMap = global.entryFieldMap[? currentEntryField];
							if (scr_isNumericAndExists(currentEntryFieldSubMap, ds_type_map)) {
								if (currentEntryFieldSubMap[? entryType]) {
									if (ds_list_find_index(chain1toManyColFieldList, currentEntryField) == -1) {
										allFieldsInNav = false;
									}
								}
							}
						}
						
						var dropDownOptionList = ds_list_create();
						
						// add some of the dropDown options
						ds_list_add(dropDownOptionList, "option_select-field");
						//localize
						if (ds_list_size(chain1toManyColFieldList) > 1) ds_list_add(dropDownOptionList, "Hide column");
						if (!allFieldsInNav) ds_list_add(dropDownOptionList, "Insert column");
						ds_list_add(dropDownOptionList, "option_create-new-field");
						
						// check if this field has a finite tagSet, and therefore we should put in "Add to tag set" and "Remove from tag set"
						var tagSubMap = global.entryFieldMap[? currentField];
						if (scr_isNumericAndExists(tagSubMap, ds_type_map)) {
							var fieldHasTagSet = ds_map_exists(tagSubMap, "tagSet");
							if (fieldHasTagSet) {
								ds_list_add(dropDownOptionList, "option_add-to-tag-set", "option-remove-tag-set");
							}
						}

						
						scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldChains1ToMany);
					}
				}
			}
		
			// draw header name
			draw_set_color(global.colorThemeText);
			draw_set_valign(fa_middle);
			scr_adaptFont(colName, "M");
			

			
			draw_text(headerTextX - clipX, headerTextY - clipY, colName);
		
	
			
			if (i > 0) {
				draw_set_color(global.colorThemeBorders);
				draw_line(headerRectX1 - clipX, y - clipY, headerRectX1 - clipX, y + windowHeight - clipY);
			}
		

			
			i++;
		}
	}
	
	if (BUILDTYPE != "Web") scr_surfaceEnd();
	
	// draw horizontal line between headers and contents
	draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight);
}