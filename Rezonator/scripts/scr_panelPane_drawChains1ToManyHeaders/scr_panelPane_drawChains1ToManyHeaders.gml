// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1ToManyHeaders(){
	
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
	if(ds_exists(chain1toManyColFieldList, ds_type_list)){
		// draw headers for chainContents columns
		var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
		var colAmount = 3 + chainContents1toManyFieldListSize;
		for (var i = 0; i < colAmount; i++) {
			var colRectX1 = x + (i * (windowWidth / colAmount));
			var colRectY1 = y;
			var colRectX2 = colRectX1 + (windowWidth / colAmount);
			if (colAmount == 3 && i == 2) {
				var colRectX2 = colRectX1 + (windowWidth);	
			}
			var colRectY2 = colRectY1 + windowHeight;
			var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight);
	
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
						colName = "wordOrder"; // rez & track
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
			draw_rectangle(colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight, false);
		
			// headers for dynamic columns
			if (i >= 3) {
				var currentField = ds_list_find_value(chain1toManyColFieldList, i - 3);
				if (is_string(currentField)) {
					colName = currentField;
				}
			
				// dropdown button to switch dynamic fields
				var dropDownButtonX1 = colRectX1 + ((colRectX2 - colRectX1) * 0.8);
				var dropDownButtonY1 = colRectY1 + (tabHeight * 0.25);
				var dropDownButtonX2 = colRectX1 + ((colRectX2 - colRectX1) * 0.95);
				var dropDownButtonY2 = colRectY1 + (tabHeight * 0.75);
				var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) , mean(dropDownButtonY1, dropDownButtonY2) , 1, 1, 0, global.colorThemeText, 1);
				if (mouseoverDropDownButton && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
					draw_set_color(global.colorThemeBorders);
					draw_set_alpha(1);
					draw_rectangle(dropDownButtonX1, dropDownButtonY1, dropDownButtonX2 , dropDownButtonY2 , true);
					if (mouse_check_button_released(mb_left)) {
						obj_control.chain1ToManyColFieldToChange = i - 3;
						scr_createDropDown(colRectX1, colRectY1 + tabHeight, scr_getChainEntryFieldList(chainType), global.optionListTypeChain1ToManyField);
					}
				}
			
				// right-click on header
				if (mouseoverColHeader && mouse_check_button_released(mb_right) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
					obj_control.chain1ToManyColFieldToChange = i - 3;
					var headerRightClickList = ds_list_create();
					ds_list_add(headerRightClickList, "Create Field");
					scr_createDropDown(colRectX1, colRectY1 + tabHeight, headerRightClickList, global.optionListTypeChain1ToManyHeaderRightClick);
				}
			}
		
			// draw header name
			draw_set_color(global.colorThemeText);
			draw_set_valign(fa_middle);
			draw_set_halign(fa_left);
			scr_adaptFont(colName, "M");
			draw_text(colRectX1 + 4 , y + tabHeight/2 , colName);
		
			// draw vertical line between columns
			if (i > 0) {
				draw_set_color(global.colorThemeText);	
				draw_line(colRectX1 , colRectY1 , colRectX1 , colRectY2 );
			}
		}

		// draw horizontal line between headers and contents
		draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight  );
	}
}