function scr_panelPane_drawTabs() {
	/*
		Purpose: draw Rez, Track, and Stack tabs on chainList panel pane
	*/

	// Set opacity, font, and alignment of text in chain tabs
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var sprHeight = sprite_get_height(spr_filterIcons);
	var textMarginLeft = 5;
	
	// set positions for other panelPanes
	var tabsPaneInst = self.id;
	with (obj_panelPane) {
		functionTabs_tabHeight = string_height("0") + sprHeight + textMarginLeft;
		if (currentFunction == functionChainList || currentFunction == functionChainContents || currentFunction == functionFilter) {
			y = tabsPaneInst.y + tabsPaneInst.windowHeight;
		}
	}



	var tabAmount = 4;

	x = 0;
	if (obj_panelPane.showNav) {
		y = obj_menuBar.menuHeight;
	}

	var tabRectY1 = y;
	var tabRectY2 = tabRectY1 + functionTabs_tabHeight;
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x, tabRectY1, x + windowWidth, tabRectY2, false);
	
	// loop over tabs
	for (var i = 0; i < tabAmount; i++) {
	
		// set dimensions for tabs
		var tabRectX1 = x + (i * (windowWidth / tabAmount));
		var tabRectX2 = tabRectX1 + (windowWidth / tabAmount);
		var mouseoverTab = point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2);
	
		// highlight current tab
		if (i == functionChainList_currentTab) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, false);
		}
		
		/*
		if (functionChainList_currentTab == functionChainList_tabLine) {
			
			// Unit Tag toggle button
			var buttonRectSize = (tabRectY2 - tabRectY1) - 8;
			var tagButtonRectX1 = tabRectX2 - buttonRectSize - 4;
			var tagButtonRectY1 = tabRectY1 + 4;
			var tagButtonRectX2 = tagButtonRectX1 + buttonRectSize;
			var tagButtonRectY2 = tagButtonRectY1 + buttonRectSize;
			var mouseOverUnitTab = point_in_rectangle(mouse_x, mouse_y, tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2);
			
			draw_set_color(global.colorThemeText);
			if (mouseOverUnitTab && !instance_exists(obj_dropDown) && !chainListPane.scrollBarClickLock) {
						
				scr_createTooltip(mean(tagButtonRectX1, tagButtonRectX2), tagButtonRectY2, (obj_control.showUnitTags) ? "1-to-1" : "1-to-many", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeSelected2);
				draw_rectangle(tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2, false);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2, true);

				if (mouse_check_button_released(mb_left)) {
					obj_control.showUnitTags = !obj_control.showUnitTags;
					if (obj_control.showTranslation) {
						obj_control.showTranslation = false;
					}
				}
			}
			draw_sprite_ext(spr_oneToOne, (obj_control.showUnitTags) ? 1 : 0, floor(mean(tagButtonRectX1, tagButtonRectX2)), floor(mean(tagButtonRectY1, tagButtonRectY2)), 1, 1, 0, c_white, 1);
		}
		*/
		
		
		var buttonSize = sprite_get_width(spr_filterIcons) * 1.25;
		
		// draw filter/visible buttons if there is a focused chain
		if (obj_chain.currentFocusedChainID != "") {
			if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
				
				// filter button
				var filterRectX1 = x + (buttonSize / 2);
				var filterRectY1 = y + functionTabs_tabHeight + (functionTabs_tabHeight / 2) - (buttonSize / 2);
				var filterRectX2 = filterRectX1 + buttonSize;
				var filterRectY2 = filterRectY1 + buttonSize;
				var mouseoverFilter = point_in_rectangle(mouse_x, mouse_y, filterRectX1, filterRectY1, filterRectX2, filterRectY2);
				draw_set_color(global.colorThemeSelected1);
				draw_roundrect(filterRectX1, filterRectY1, filterRectX2, filterRectY2, false);
				if (mouseoverFilter) {
					draw_set_color(global.colorThemeBorders);
					draw_roundrect(filterRectX1, filterRectY1, filterRectX2, filterRectY2, true);
				}
				draw_sprite_ext(spr_filterIcons, 0, floor(mean(filterRectX1, filterRectX2)), floor(mean(filterRectY1, filterRectY2)), 1, 1, 0, c_white, 1);
				
				
				
				// visible button
				var visibleRectX1 = filterRectX2 + (buttonSize / 2);
				var visibleRectY1 = filterRectY1;
				var visibleRectX2 = visibleRectX1 + buttonSize;
				var visibleRectY2 = filterRectY2;
				var mouseoverVisible = point_in_rectangle(mouse_x, mouse_y, visibleRectX1, visibleRectY1, visibleRectX2, visibleRectY2);
				draw_set_color(global.colorThemeSelected1);
				draw_roundrect(visibleRectX1, visibleRectY1, visibleRectX2, visibleRectY2, false);
				if (mouseoverVisible) {
					draw_set_color(global.colorThemeBorders);
					draw_roundrect(visibleRectX1, visibleRectY1, visibleRectX2, visibleRectY2, true);
				}
				draw_sprite_ext(spr_toggleDraw, 0, floor(mean(visibleRectX1, visibleRectX2)), floor(mean(visibleRectY1, visibleRectY2)), 1, 1, 0, c_white, 1);

			}
		}
		
		
	

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	
		// check for mouse clicks to change the selected tab
		if (mouseoverTab && !instance_exists(obj_dropDown) && !chainListPane.scrollBarClickLock) {
			if (device_mouse_check_button_released(0, mb_left)) {
				
				show_debug_message("scr_panelPane_drawTabs() ... switch to tab " + string(i));
				
				// switch tab
				with (obj_panelPane) {
					functionChainList_currentTab = i;
				}
			
				// unfocus chains of all type
				scr_unFocusAllChains();
			
				if (i == 1) {
					obj_toolPane.currentMode = obj_toolPane.modeTrack;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeTrack;
					}
				}
				if (i == 2) {
					obj_toolPane.currentMode = obj_toolPane.modeRez;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeRez;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeRez;
					}
				}
				if (i == 3) {
					if(obj_toolPane.currentMode = obj_toolPane.modeRead) {
						obj_toolPane.currentMode = obj_toolPane.modeTrack;
						if (obj_control.searchGridActive) {
							obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
						}
						else {
							obj_toolPane.setModeMain = obj_toolPane.modeTrack;
						}
					}
				}
			}
		}
	
		// keeps drawing the name of the tabs
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(scr_get_translation(functionChainList_tabName[i]), "M");
		draw_text(tabRectX1 + textMarginLeft, tabRectY1, scr_get_translation(functionChainList_tabName[i]));

	}


}
