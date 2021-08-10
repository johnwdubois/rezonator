// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1ToManyHeaders(){
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	
	
	var tabHeight = functionTabs_tabHeight;
	var chain1toManyColFieldList = -1;
	var chainType = "";
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
				chainType ="rezChain";
			}
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
				chainType ="trackChain";
			}
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
				chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
				chainType ="stackChain";
			}
		}
	}
	
	if (scr_isNumericAndExists(chain1toManyColFieldList, ds_type_list)) {
		
		// draw headers for chainContents columns
		var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
		var colAmount = 3 + chainContents1toManyFieldListSize;
		var i = 0;
		repeat(colAmount) {
			
			// get coordinates for header rect
			var colWidth = windowWidth / colAmount;
			var headerRectX1 = (lineStateLTR)? x + (colWidth * i): x + windowWidth - (colWidth * (i+1));
			var headerRectY1 = y;
			var headerRectX2 = headerRectX1 + colWidth;
			if (colAmount == 3 && i == 2) {
				var headerRectX2 = headerRectX1 + (windowWidth);	
			}
			var headerRectY2 = headerRectY1 + tabHeight;
			
			var sortArrowX = headerRectX2 - sprite_get_width(spr_linkArrow);
			var sortArrowY = floor(mean(headerRectY1, headerRectY2));
			var mouseoverSortArrow = point_in_circle(mouse_x, mouse_y, sortArrowX, sortArrowY, sprite_get_width(spr_linkArrow) * 0.5) && chainType != "stackChain";
			
			var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverSortArrow;
			
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
						colName = "speaker"; // stacks
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
						colName = "text"; // rez & track
					}
					break;
				default:
					colName = "N/A";
					break;
			}
		
		
			// make headers not overlap with each other
			draw_set_color(global.colorThemeBG);
			draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + tabHeight, false);
			
			// draw sort arrow
			if (chainType != "stackChain") {
				if (mouseoverColHeader || mouseoverSortArrow || obj_control.chain1toManyCustomSortColIndexTrack == i) {
					var sortArrowScale = 0.5;
					if (mouseoverSortArrow) {
						scr_createTooltip(sortArrowX, sortArrowY + (sprite_get_height(spr_linkArrow) * 0.25), "Sort", obj_tooltip.arrowFaceUp);
						sortArrowScale *= 1.25;
						if (mouse_check_button_released(mb_left)) {
							if (obj_control.chain1toManyCustomSortColIndexTrack == -1) {
								obj_control.chain1toManyCustomSortColIndexTrack = i;
								obj_control.chain1toManyCustomSortAscTrack = true;
							}
							else {
								if (obj_control.chain1toManyCustomSortColIndexTrack == i) {
									if (obj_control.chain1toManyCustomSortAscTrack) {
										obj_control.chain1toManyCustomSortAscTrack = false;
									}
									else {
										obj_control.chain1toManyCustomSortColIndexTrack = -1;
									}
								}
								else {
									obj_control.chain1toManyCustomSortColIndexTrack = i;
								}
							}
						}
					}
					var sortArrowAngle = 0;
					if (obj_control.chain1toManyCustomSortColIndexTrack == i) {
						sortArrowAngle = obj_control.chain1toManyCustomSortAscTrack ? 270 : 90;
					}
					draw_sprite_ext(spr_linkArrow, 0, sortArrowX, sortArrowY, sortArrowScale, sortArrowScale, sortArrowAngle, mouseoverSortArrow && mouse_check_button(mb_left) ? global.colorThemeSelected2 : global.colorThemeText, 1);
				}
			}
			
		
		
		
			// headers for dynamic columns
			if (i >= 3) {
				var currentField = ds_list_find_value(chain1toManyColFieldList, i - 3);
				if (is_string(currentField)) {
					colName = currentField;
				}
			

				if (mouseoverColHeader) {
					scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, "Change field", obj_tooltip.arrowFaceUp);
					
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
					draw_line_width(underlineX1, underlineY, underlineX2, underlineY, 2);
					
					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) fieldChains1ToManyChainType = chainType;
						obj_control.chain1ToManyColFieldToChange = i - 3;
						obj_control.chain1toManyFieldToChange = currentField;
						var dropDownOptionList = ds_list_create();
						
						// check if this field has a finite tagSet, and therefore we should put in "Add to tag set" and "Remove from tag set"
						var tagSubMap = global.entryFieldMap[? currentField];
						if (scr_isNumericAndExists(tagSubMap, ds_type_map)) {
							var fieldHasTagSet = ds_map_exists(tagSubMap, "tagSet");
							if (fieldHasTagSet) {
								ds_list_add(dropDownOptionList, "Add to tag set", "Remove from tag set");
							}
						}
						
						// add the rest of the dropDown options
						ds_list_add(dropDownOptionList, "Select field", "Create new field");
						
						scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldChains1ToMany);
					}
				}
			}
		
			// draw header name
			draw_set_color(global.colorThemeText);
			draw_set_valign(fa_middle);
			scr_adaptFont(colName, "M");
			

			
			draw_text(headerTextX, headerTextY, colName);
		
	
			if(lineStateLTR){	
				if(i > 0){
					draw_set_color(global.colorThemeBorders);
					draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);
				}
			}
			else{
				if(i < colAmount-1){
					draw_set_color(global.colorThemeBorders);
					draw_line_width(headerRectX1+1, y, headerRectX1+1, y + windowHeight, 1);
				}
			}
			
			i++;
		}


		// draw horizontal line between headers and contents
		draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight  );
	}
}