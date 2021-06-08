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
			var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
			
			// get coordinates for header text
			var headerTextX = headerRectX1 + textMarginLeft;
			if (!lineStateLTR){
				draw_set_halign(fa_right);
				headerTextX = headerRectX2 - (textMarginLeft)
				if(i >= 3){
					headerTextX = headerTextX - dropDownButtonSize;
				}
			}
			var headerTextY = y + (tabHeight / 2);
	
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
					var underlineX2 = headerTextX + string_width(currentField);
					var underlineY = headerTextY + (tabHeight * 0.25);
					draw_set_color(global.colorThemeBorders);
					draw_line_width(underlineX1, underlineY, underlineX2, underlineY, 2);
					
					if (mouse_check_button_released(mb_left)) {
						obj_control.chain1ToManyColFieldToChange = i - 3;
						scr_createDropDown(headerRectX1, headerRectY1 + tabHeight, scr_getChainEntryFieldList(chainType), global.optionListTypeChain1ToManyField);
					}
				}
			
				// right-click on header
				if (mouseoverColHeader && mouse_check_button_released(mb_right) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
					obj_control.chain1ToManyColFieldToChange = i - 3;
					var headerRightClickList = ds_list_create();
					ds_list_add(headerRightClickList, "Create Field");
					scr_createDropDown(headerRectX1, headerRectY1 + tabHeight, headerRightClickList, global.optionListTypeChain1ToManyHeaderRightClick);
				}
			}
		
			// draw header name
			draw_set_color(global.colorThemeText);
			draw_set_valign(fa_middle);
			draw_set_halign(fa_left);
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