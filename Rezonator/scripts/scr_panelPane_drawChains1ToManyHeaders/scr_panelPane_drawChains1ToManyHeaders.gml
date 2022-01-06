// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1ToManyHeaders(){
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	var camWidth = camera_get_view_width(view_camera[0]);
	var mouseoverCancel = !point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight) || instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);
	
	
	var sortArrowScale = 0.4;
	if (camWidth > 2000) {sortArrowScale *= 1.25;}
	var tabHeight = functionTabs_tabHeight;
	var chain1toManyColFieldList = -1;
	var chainType = "";
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
				chainType ="resonance";
			}
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
				chainType ="trail";
			}
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
				chainType ="stack";
			}
		}
	}
	

	

	
	if (scr_isNumericAndExists(chain1toManyColFieldList, ds_type_list)) {
		
		// draw headers for chainContents columns
		var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
		var colAmount = 3 + chainContents1toManyFieldListSize;
		var colWidth = windowWidth / chain1toMColAmount;
		var i = 0;
		
		repeat(colAmount) {
			
			// get coordinates for header rect
			var headerRectX1 = x + (colWidth * i) + scrollHorPlusX;
			var headerRectY1 = y;
			var headerRectX2 = headerRectX1 + colWidth;
			if (colAmount == 3 && i == 2) {
				var headerRectX2 = headerRectX1 + (windowWidth);	
			}
			var headerRectY2 = headerRectY1 + tabHeight;
			
			var sortArrowX = headerRectX2 - sprite_get_width(spr_linkArrow)*sortArrowScale;
			var sortArrowY = floor(mean(headerRectY1, headerRectY2));
			var mouseoverSortArrow = point_in_circle(mouse_x, mouse_y, sortArrowX, sortArrowY, sprite_get_width(spr_linkArrow) * 0.5) && !mouseoverCancel;
			
			var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !mouseoverSortArrow && !mouseoverCancel;
			
			// get coordinates for header text
			var headerTextX = floor(headerRectX1 + textMarginLeft);
			if (!lineStateLTR){
				draw_set_halign(fa_right);
				headerTextX = headerRectX2 - (textMarginLeft)
			}
			var headerTextY = floor(y + (tabHeight / 2));
	
			// get header string for static columns
			var colName = "";
			switch (i) {
				case 0:
					colName = "unitSeq";
					break;
				case 1:
					if (functionChainList_currentTab == functionChainList_tabStackBrush) {
						colName = "participant"; // stacks
					}
					else {
						colName = "tokenOrder"; // rez & track
					}
					break;
				case 2:
					if (functionChainList_currentTab == functionChainList_tabStackBrush) {
						colName = "utterance"; // stacks
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
					scr_createTooltip(sortArrowX, sortArrowY + (sprite_get_height(spr_linkArrow) * 0.25), scr_get_translation("option_sort"), global.arrowFaceUp);
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
			if (i >= 3) {
				var currentField = ds_list_find_value(chain1toManyColFieldList, i - 3);
				if (is_string(currentField)) {
					colName = currentField;
				}
			

				if (mouseoverColHeader) {
					scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, scr_get_translation("msg_change_field"), global.arrowFaceUp);
					
					// draw underline
					var underlineX1 = headerTextX;
					if(lineStateLTR){
						var underlineX2 = headerTextX + string_width(currentField);
					}
					else{
						var underlineX2 = headerTextX - string_width(currentField);
					}
					var underlineY = headerTextY + (tabHeight * 0.25);
					draw_set_color(global.colorThemeBorders);
					draw_line_width(underlineX1 - clipX, underlineY - clipY, underlineX2 - clipX, underlineY - clipY, 2);
					
					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) fieldChains1ToManyChainType = chainType;
						obj_control.chain1toManyEntryToChange = "";
						obj_control.chain1ToManyColFieldToChange = i - 3;
						obj_control.chain1toManyFieldToChange = currentField;
						var dropDownOptionList = ds_list_create();
						
						// add some of the dropDown options
						ds_list_add(dropDownOptionList, "option_select-field", "option_create-new-field");
						
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
		
	
			
			if(i > 0){
				draw_set_color(global.colorThemeBorders);
				draw_line(headerRectX1 - clipX, y - clipY, headerRectX1 - clipX, y + windowHeight - clipY);
			}
		

			
			i++;
		}
	}

	
	// draw horizontal line between headers and contents
	draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight);
}