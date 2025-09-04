function scr_panelPane_drawTabs() {
	
	// Set opacity, font, and alignment of text in chain tabs
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	scr_adaptFont("0", "M");
	
	var strHeight = string_height("0");
	var _textHPadding = floor(strHeight * 0.35);
	var sprHeight = sprite_get_height(spr_filterIcons);
	var textMarginLeft = 5;
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_sizeWindow);
	
	// set positions for other panelPanes
	var tabsPaneInst = self.id;
	with (obj_panelPane) {
		functionTabs_tabHeight = (strHeight * 1.5) + textMarginLeft;
		if (currentFunction == functionChainList || currentFunction == functionChainContents) {
			y = floor(tabsPaneInst.y + tabsPaneInst.windowHeight);
		}
	}

	var buttonScale = (1+global.fontSize/10);
	
	
	var tabList = obj_control.panelPaneTabList;
	var tabAmount = ds_list_size(tabList);
	

	x = 0;
	if (obj_panelPane.showNav) {
		y = obj_menuBar.menuHeight;
	}
	var edgeBufferY = 0;
	var edgeBufferX = 3;
	var tabRectY1 = y+edgeBufferY;
	var tabRectY2 = tabRectY1 + functionTabs_tabHeight - edgeBufferY;
	draw_set_color(make_color_rgb(125, 125, 128));
	draw_rectangle(x, y, x + windowWidth, tabRectY2, false);

	// loop over tabs
	for (var i = 0; i < tabAmount; i++) {
		
		var currentTab = tabList[| i];
		var filterListSize = 0;
		if (currentTab == NAVTAB_RESONANCE || currentTab == NAVTAB_TRACK || currentTab == NAVTAB_STACK) {
			var filterList = -1;
			if (currentTab == NAVTAB_RESONANCE) filterList = obj_chain.filteredRezChainList;
			else if (currentTab == NAVTAB_TRACK) filterList = obj_chain.filteredTrackChainList;
			else if (currentTab == NAVTAB_STACK) filterList = obj_chain.filteredStackChainList;
			filterListSize = ds_list_size(filterList);
		}
		var currentTabSelected = (currentTab == functionChainList_currentTab);

		// set dimensions for tabs
		var tabRectX1 = x + (i * (windowWidth / (tabAmount+0.5)));
		var tabRectX2 = tabRectX1 + (windowWidth / (tabAmount+0.5));
		var mouseoverTab = point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2) && !mouseoverCancel;

	
		if (!currentTabSelected) {
			edgeBufferY = functionTabs_tabHeight * 0.3;
		}
		else {
			edgeBufferY = functionTabs_tabHeight * 0.2;
		}
		
		draw_set_color(global.colorThemeSelected1);
		if (mouseoverTab) {
			draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
		}
		draw_roundrect(tabRectX1+edgeBufferX , tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2+edgeBufferY, false);
		draw_set_color(global.colorThemeBorders);
		draw_roundrect(tabRectX1+edgeBufferX, tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2+edgeBufferY, true);
		
		
		
		// highlight current tab
		if (currentTabSelected) {
			draw_set_color(global.colorThemeBG);
			draw_roundrect(tabRectX1+edgeBufferX, tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2 +edgeBufferY, false);
		}


		draw_set_color(global.colorThemeBG);
		draw_rectangle(tabRectX1+edgeBufferX, tabRectY2, tabRectX2-edgeBufferX+1, y+ windowHeight, false);
		
		// draw filter icon if anything in this tab is filtered
		if (filterListSize > 0) {
			var filterIconScale = currentTabSelected ? 0.9 : 0.8;
			draw_sprite_ext(spr_filterIcons, 0, tabRectX2 - (sprite_get_width(spr_filterIcons) * 0.5), mean(tabRectY1 + edgeBufferY, tabRectY2), filterIconScale, filterIconScale, 0, c_black, 1);
		}
		
		
		if (!currentTabSelected) {
			draw_set_color(global.colorThemeBorders)
			draw_line(tabRectX1-edgeBufferX,tabRectY2,tabRectX2+edgeBufferX*2,tabRectY2)
		}
		
		// determine tabChainType for this tab
		var tabChainType = "";
		var tabFilterActive = false;
		if (functionChainList_currentTab == NAVTAB_RESONANCE) {
			tabChainType = "resonance";
		}
		else if (functionChainList_currentTab == NAVTAB_TRACK) {
			tabChainType = "trail";
		}
		else if (functionChainList_currentTab == NAVTAB_STACK) {
			tabChainType = "stack";
		}
		
		

		draw_set_alpha(1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	
		// check for mouse clicks to switch the selected tab
		var switchTab = (mouseoverTab && !instance_exists(obj_dropDown) && !chainListPane.scrollBarClickLock && i != functionChainList_currentTab && device_mouse_check_button_released(0, mb_left))
		if (obj_control.switchToTab == currentTab && obj_control.switchToTab != "") {
			switchTab = true;
			obj_control.switchToTab = "";
		}
		
		if (switchTab) {
				
			show_debug_message("scr_panelPane_drawTabs() ... switch to tab " + string(i));
				
			var paneToSaveScroll = chainViewOneToMany ? functionChainList : functionChainContents;
				
			// before we switch tabs, let's save the scroll position if the user returns to their old tab, we can restore their scroll
			with (obj_panelPane) {
				if (currentFunction == paneToSaveScroll) {
					var myScrollPlusY = scrollPlusY;
					if (functionChainList_currentTab == NAVTAB_UNIT) with (obj_panelPane) scrollPlusY_tabUnit = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_RESONANCE) with (obj_panelPane) scrollPlusY_tabRez = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_TRACK) with (obj_panelPane) scrollPlusY_tabTrack = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_STACK) with (obj_panelPane) scrollPlusY_tabStack = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_SHOW) with (obj_panelPane) scrollPlusY_tabShow = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_TAG) with (obj_panelPane) scrollPlusY_tabField = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_TRANSLATION) with (obj_panelPane) scrollPlusY_tabTranslations = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_SEARCH) with (obj_panelPane) scrollPlusY_tabSearch = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_CHUNK) with (obj_panelPane) scrollPlusY_tabChunk = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_CLIQUE) with (obj_panelPane) scrollPlusY_tabClique = myScrollPlusY;
					else if (functionChainList_currentTab == NAVTAB_TREE) with (obj_panelPane) scrollPlusY_tabTree = myScrollPlusY;
				}
			}
				
			// switch tab
			with (obj_panelPane) {
				functionChainList_currentTab = currentTab;
				functionChainContents_BGColor = global.colorThemeBG;
			}
				
			// now that we have switched tabs, let's restore their saved scroll position
			var leftPaneInst = -1;
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					leftPaneInst = self.id;
					if (functionChainList_currentTab == NAVTAB_UNIT) scrollPlusY = scrollPlusY_tabUnit;
					else if (functionChainList_currentTab == NAVTAB_RESONANCE) scrollPlusY = scrollPlusY_tabRez;
					else if (functionChainList_currentTab == NAVTAB_TRACK) scrollPlusY = scrollPlusY_tabTrack;
					else if (functionChainList_currentTab == NAVTAB_STACK) scrollPlusY = scrollPlusY_tabStack;
					else if (functionChainList_currentTab == NAVTAB_SHOW) scrollPlusY = scrollPlusY_tabShow;
					else if (functionChainList_currentTab == NAVTAB_TAG) scrollPlusY = scrollPlusY_tabField;
					else if (functionChainList_currentTab == NAVTAB_TRANSLATION) scrollPlusY = scrollPlusY_tabTranslations;
					else if (functionChainList_currentTab == NAVTAB_SEARCH) scrollPlusY =  scrollPlusY_tabSearch;
					else if (functionChainList_currentTab == NAVTAB_CHUNK) scrollPlusY = scrollPlusY_tabChunk;
					else if (functionChainList_currentTab == NAVTAB_CLIQUE) scrollPlusY =  scrollPlusY_tabClique;
					else if (functionChainList_currentTab == NAVTAB_TREE) scrollPlusY = scrollPlusY_tabTree;
					scrollPlusYDest = scrollPlusY;
				}
			}
				
			if (!chainViewOneToMany) {
				with (obj_panelPane) {
					if (currentFunction == functionChainContents) {
						scrollPlusY = leftPaneInst.scrollPlusY;
						scrollPlusYDest = scrollPlusY;
					}
				}
			}
				
				
			// re-determine tab data (now that we've switched tabs)
			if (functionChainList_currentTab == NAVTAB_RESONANCE) {
				tabChainType = "resonance";
			}
			else if (functionChainList_currentTab == NAVTAB_TRACK) {
				tabChainType = "trail";
			}
			else if (functionChainList_currentTab == NAVTAB_STACK) {
				tabChainType = "stack";
			}

				
				
			if (functionChainList_currentTab != NAVTAB_SHOW) {
				if (functionChainList_playShowID != "") {
					scr_setValueForAllChains("stack", false, "filter", false);
					with (obj_panelPane) {
						functionChainList_playShowID = "";
					}
					scr_disableFilter();
				}
			}
			if (functionChainList_currentTab != NAVTAB_SHOW) {
				obj_panelPane.functionTree_treeLinkSelected = "";
				obj_chain.currentFocusedEntryID = "";
			}
				
				
			
			// unfocus chains of all type
			scr_chainDeselect();
			


		}
	
		// keeps drawing the name of the tabs
		//draw_set_color(global.colorThemeBorders);
		//draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(scr_get_translation(currentTab), "M");
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(tabRectX1 + _textHPadding, floor(mean(tabRectY2, tabRectY1 + edgeBufferY)), scr_get_translation(currentTab));

	}
	
	
	draw_set_color(global.colorThemeBorders);
	draw_line_width(x, y + windowHeight, x + windowWidth, y + windowHeight, 3);



}
