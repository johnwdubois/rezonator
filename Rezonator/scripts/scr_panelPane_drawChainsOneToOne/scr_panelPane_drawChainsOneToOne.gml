// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChainsOneToOne(){

	
	
	var chainListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListPanelPaneInst = self.id;
		}
	}

	
	
	scr_surfaceStart();
	
	
	draw_set_font(global.fontChainList);
	var strHeight = string_height("0") * 1.5;

	// Set text margin area
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var textMarginLeft = filterRectMargin;

	var textMarginTop = functionChainList_tabHeight;
	var textPlusY = 0;
	var chainNameRectMinusY = 4;

	var focusedElementY = -1;
	var focusedLineNameRectY1 = -1;
	var focusedLineNameRectY2 = -1;
	var xbuffer = (windowWidth / 3);

	var drawDropDowns = false;
	if (!instance_exists(obj_dropDown)) {
		chainTagsHighlightRow = -1;
	}
	
	var headerListSize = 3;
	
	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	
	var chainGridHeight = ds_grid_height(obj_chain.stackChainGrid);
	
	for (var j = 0; j < headerListSize; j++) {
		
		textPlusY = 0;
		drawDropDowns = false;
		
		var colRectX1 = x + (j * (windowWidth / 3));
		var colRectY1 = y;
		var colRectX2 = colRectX1 + (windowWidth / 3);
		var colRectY2 = colRectY1 + windowHeight;
		
		
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
		
		
		var tagCol = -1;
		switch (j) {
			case 0:
				tagCol = obj_chain.chainGrid_colAct;
				break;
			case 1:
				tagCol = obj_chain.chainGrid_colRepair;
				break;
			case 2:
				tagCol = obj_chain.chainGrid_colActSequence;
				break;
			default:
				break;
		}
		
		
		for (var i = 0; i < chainGridHeight; i++) {
			
			if (y + textMarginTop + chainListPanelPaneInst.scrollPlusY + textPlusY < y - strHeight
			or y + textMarginTop + chainListPanelPaneInst.scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			    textPlusY += strHeight;
			    continue;
			}
			
			// Get dimensions of rectangle around line name
			var chainRowRectX1 = x;
			var chainRowRectY1 = y + textMarginTop + textPlusY + chainListPanelPaneInst.scrollPlusY - (strHeight / 2);
			var chainRowRectX2 = x + windowWidth;
			var chainRowRectY2 = chainRowRectY1 + strHeight;
			var mouseoverChainRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainRowRectX1, max(chainRowRectY1, y + textMarginTop), chainRowRectX2, chainRowRectY2);
			
			//Check mouse clicks to focus a line in the list
			if (mouseoverChainRow && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
				drawDropDowns = true;
				chainTagsHighlightRow = i;
        
			    if (device_mouse_check_button_released(0, mb_left)) {
			        ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), false);
			        ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, i, true);
			        with (obj_panelPane) {
			            functionChainContents_chainGridRowFocused = i;
			        }
			    }
			}
			
			if (chainTagsHighlightRow == i) {
				
				// dropdown buttons
				var dropDownButtonX1 = colRectX2 - sprite_get_width(spr_dropDown) - 4;
				var dropDownButtonY1 = chainRowRectY1;
				var dropDownButtonX2 = dropDownButtonX1 + sprite_get_width(spr_dropDown);
				var dropDownButtonY2 = chainRowRectY2;
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
				if (point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2)) {
					
					draw_set_alpha(1);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
				/*
					if (mouse_check_button_released(mb_left)) {
					
						with (obj_panelPane) {
							selectedColChain = j;
						}
								
						var dropDownOptionList = ds_list_create();
						var colIndex = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
						var mapKey = ds_list_find_value(global.unitImportColNameList, colIndex);
						var tagMapList = ds_map_find_value(global.unitImportTagMap, mapKey);
						
						if (!is_undefined(tagMapList)) {
							ds_list_copy(dropDownOptionList, tagMapList);
							obj_control.unitImportColToChange = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
							obj_control.unitImportRowToChange = currentLineUnitID - 1;
								
							var dropDownX = colRectX1;
							var dropDownY = lineNameRectY2;

							if (ds_list_size(dropDownOptionList) > 0 ) {
								var dropDownInst = instance_create_depth(dropDownX, dropDownY , -999, obj_dropDown);
								dropDownInst.optionList = dropDownOptionList;
								dropDownInst.optionListType = 38;

							}
						}
					*/
					
				}
				
				// highlight rectangle
				if (j == headerListSize - 1) {
					draw_set_alpha(0.2);
					draw_set_color(global.colorThemeText);
					draw_rectangle(chainRowRectX1 - clipX, chainRowRectY1 - clipY, chainRowRectX2 - clipX, chainRowRectY2 - clipY, false);
				}
				draw_set_alpha(1);
			}
			
			
			
			
			// Draw text of chain tags		    
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_set_color(global.colorThemeText);
			
			var tagToDraw = ds_grid_get(obj_chain.stackChainGrid, tagCol, i);
			tagToDraw = (tagToDraw == undefined or tagToDraw == 0) ? "" : tagToDraw;
			draw_text(x + (textMarginLeft) + (xbuffer * j) - clipX, y + textMarginTop + chainListPanelPaneInst.scrollPlusY + textPlusY - clipY, string(tagToDraw));
			
			textPlusY += strHeight;
		}
	}
	
	// Create the column headers
	for (var i = 0; i < headerListSize; i++) {
		
		var colRectX1 = x + (i * (windowWidth / 3));
		var colRectY1 = y;
		var colRectX2 = colRectX1 + (windowWidth / 3);
		var colRectY2 = colRectY1 + windowHeight;
		var colWidth = colRectX2 - colRectX1;
		var colName = "";
		
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + functionChainList_tabHeight - clipY, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + functionChainList_tabHeight - clipY, true);
		
		switch (i) {
			case 0:
				colName = "act";
				break;
			case 1:
				colName = "repair";
				break;
			case 2:
				colName = "act sequence";
				break;
			default:
				break;
		}
		
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + functionChainList_tabHeight - clipY, true);
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_top);
		draw_set_font(global.fontPanelTab);
		draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
		
		
	}
	
	scr_surfaceEnd();

}